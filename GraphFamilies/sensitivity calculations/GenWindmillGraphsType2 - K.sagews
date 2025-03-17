︠b91b152f-adcd-47e3-98c0-3a0a3dfcb194︠
attach('../TypeIIGeneralizedWindmillGraphFamily.sage')
from tabulate import tabulate

# defines a class representing K′m ∨nH for H = Kℓ that inherits from TypeIIGeneralizedWindmillGraphFamily
class GenWindmillIIGraphsK(TypeIIGeneralizedWindmillGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "GenWindmillGraphsType2 - K"
        self.min_l = 2

    # prints or returns a table of graph information for the given values of m,l from min_n to max_n using formulas
    def table_by_formulas(self, max_n, m, l, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            nalphah = n_value
            alpha = max(m, nalphah)
            
            if m >= n_value * l:
                
                maxes = [] 
                for j in range (1, n_value * l + 1):
                    maxes.append(max(j, m + 1 - j + math.ceil((j-n_value)/n_value)))
                
                sigma = min(maxes)
  
            elif n_value < m and m < n_value * l:
                
                maxes = []
                for j in range (1, n_value * l + 1):
                    maxes.append(max(j, m + 1 - j + math.ceil((j-n_value)/n_value)))
                
                min1 = min(maxes)
                sigma = min(min1, math.ceil((m+1-n_value)/n_value))
    
            else: # m <= n because nalphah = n
                
                h_sensitivity = 1
                
                if m <= math.floor((nalphah+1)/2):      
                    sigma = min(h_sensitivity, nalphah + 1 - m)
                else:
                    sigma = min(h_sensitivity, math.ceil((nalphah+1)/2))
                
            deg = max(n_value*l, m + l - 1)

            row = [n_value, m, l, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
        
    # returns a table of graph information for the given values of m,n from min_l to max_l using formulas
    def sensitivity_by_formulas(self, n, m, max_l):

        t = [["n", "m", "l", "alpha", "sigma"]]

        for l in range(self.min_l, max_l + 1):

            nalphah = n
            alpha = max(m, nalphah)
            
            if m >= n * l:
                
                maxes = [] 
                for j in range (1, n * l + 1):
                    maxes.append(max(j, m + 1 - j + math.ceil((j-n)/n)))
                
                sigma = min(maxes)
  
            elif n < m and m < n * l:
                
                maxes = []
                for j in range (1, n * l + 1):
                    maxes.append(max(j, m + 1 - j + math.ceil((j-n)/n)))
                
                min1 = min(maxes)
                sigma = min(min1, math.ceil((m+1-n)/n))
    
            else: # m <= n because nalphah = n
                
                h_sensitivity = 1
                
                if m <= math.floor((nalphah+1)/2):      
                    sigma = min(h_sensitivity, nalphah + 1 - m)
                else:
                    sigma = min(h_sensitivity, math.ceil((nalphah+1)/2))

            row = [n, m, l, alpha, sigma]
            t.append(row)
            
        return t

    # prints or returns a table of graph information for the given values of n,m from min_l to max_l using graphs
    def alternate_table(self, n, m, max_l, min_s = 0, print_table = False):

        t = [["n", "m", "l", "alpha", "sigma"]]

        for l_value in range(self.min_l, max_l + 1):

            gd = self.GraphDetails(n = n, m = m)
            h = graphs.CompleteGraph(l_value)
            graph = self.graph(gd, h)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
       
            row = [n, m, l_value, alpha, sigma]

            if sigma >= min_s:
                t.append(row)

        if print_table:
            print(self.name + ", n = " + str(n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # write output as successive square tables of options for ℓ × m as n increases downward
    def display_lxm(self, max_n = 5, max_m = 5, max_l = 5, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + " Sensitivity Results lxm" + min_s_str + ".txt", 'w')

        f.write("Tables using graphs:\n")
        for n in range(self.min_n, max_n + 1):

            f.write("n = ")
            f.write(str(n))
            f.write("\n")

            m_row = []
            l_col = []
            sensitivity = []

            for m in range(self.min_m, max_m + 1):
                m_row.append(m)
                t = self.alternate_table(n, m, max_l, min_s)
                sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])
        
            
            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "m"] + [f"{element}" for element in m_row],
            ["l", ""] + ["" for element in m_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.write("Tables using formulas:\n")
        for n in range(self.min_n, max_n + 1):

            f.write("n = ")
            f.write(str(n))
            f.write("\n")

            m_row = []
            l_col = []
            sensitivity = []

            for m in range(self.min_m, max_m + 1):
                m_row.append(m)
                t = self.sensitivity_by_formulas(n, m, max_l)
                sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])
        
            
            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "m"] + [f"{element}" for element in m_row],
            ["l", ""] + ["" for element in m_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.close()

        print(self.name + " Sensitivity Results lxm done")

        return
    
    # write output as successive square tables of options for ℓ × n as m increases downward
    def display_lxn(self, max_n = 5, max_m = 5, max_l = 5, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + " Sensitivity Results lxn" + min_s_str + ".txt", 'w')

        f.write("Tables using graphs:\n")
        for m in range(self.min_m, max_m + 1):

            f.write("m = ")
            f.write(str(m))
            f.write("\n")

            n_row = []
            l_col = []
            sensitivity = []

            for n in range(self.min_n, max_n + 1):
                n_row.append(n)

                t = self.alternate_table(n, m, max_l, min_s)

                sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])

            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "n"] + [f"{element}" for element in n_row],
            ["l", ""] + ["" for element in n_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.write("Tables using formulas:\n")
        for m in range(self.min_m, max_m + 1):

            f.write("m = ")
            f.write(str(m))
            f.write("\n")

            n_row = []
            l_col = []
            sensitivity = []

            for n in range(self.min_n, max_n + 1):
                n_row.append(n)

                t = self.sensitivity_by_formulas(n, m, max_l)

                sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])

            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "n"] + [f"{element}" for element in n_row],
            ["l", ""] + ["" for element in n_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.close()

        print(self.name + " Sensitivity Results lxn done")

        return

    # write the table for n = min_n to n = max_n to an output file
    def output_results(self, max_n, max_m, max_l, show_eigenvectors = False, lower_n = 2, upper_n = 4, lower_m = 2, upper_m = 4, lower_l = 2, upper_l = 4, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + min_s_str + ".txt", 'w')

        matrices = []
        eigenvalues = []
        eigenvectors = []

        f.write("Tables using graphs: \n")
        for l in range(self.min_l, max_l + 1):

            for m in range(self.min_m, max_m + 1):

                h = graphs.CompleteGraph(l)
                t_m = self.table_and_matrices(max_n, m, l, h, lower_n, upper_n, lower_m, upper_m, lower_l, upper_l, min_s)
                t = t_m[0]
                matrices.append(t_m[1])
                eigenvalues.append(t_m[2])
                eigenvectors.append(t_m[3])

                f.write(str(table(t)))
                f.write("\n\n")

        f.write("\nTables using formulas: \n")
        for l in range(self.min_l, max_l + 1):
            for m in range(self.min_m, max_m + 1):
                t2 = self.table_by_formulas(max_n, m, l)
                f.write(str(table(t2)))
                f.write("\n\n")

        f.write("\nAdjacency matrices: \n")

        for index in range(len(matrices)):
            for element in range(len(matrices[index])):

                if len(matrices[index][element]) != 0:

                    f.write("n = ")
                    f.write(str(matrices[index][element][0]))
                    f.write("\nm = ")
                    f.write(str(matrices[index][element][1]))
                    f.write("\nl = ")
                    f.write(str(matrices[index][element][2]))
                    f.write("\n")
                    f.write(str(matrices[index][element][3]))

                    f.write("\n\nEigenvalues: ")

                    combined = list(zip(eigenvalues[index][element], eigenvectors[index][element]))

                    # sort the combined list by eigenvalues
                    sorted_combined = sorted(combined, key=lambda x: x[0])

                    # unzip the combined list back into two lists
                    sorted_eigenvalues, sorted_eigenvectors = zip(*sorted_combined)

                    count = 1
                    for eigenvalue in sorted_eigenvalues:
                        f.write("\n" + str(count) + ": ")
                        f.write(str(eigenvalue))
                        count += 1
                    f.write("\n")

                    if show_eigenvectors:
                        f.write("\nEigenvectors: ")
                        count = 1
                        for eigenvector in sorted_eigenvectors:
                            f.write("\n" + str(count) + ": ")
                            f.write(str(eigenvector))
                            count += 1
                        f.write("\n")

                    f.write("\n")

        f.close()

        print(self.name + " Results done")


# run code
g = GenWindmillIIGraphsK()
#g.output_results(5,5,5)
g.display_lxm(5,5,5)
g.display_lxn(5,5,5)
︡7fcb6b50-2e61-4e90-8498-d7f314e92d18︡{"stdout":"GeneralizedWindmillGraphsType2 - K Sensitivity Results lxm done"}︡{"stdout":"\n"}︡{"stdout":"GeneralizedWindmillGraphsType2 - K Sensitivity Results lxn done"}︡{"stdout":"\n"}︡{"done":true}
︠0d06be63-99c6-47c8-83ec-d1c7053c9f0b︠

︡d438c225-bbb8-4fc4-a18e-2942ee465859︡{"done":true}










