function[D] = diag_mat(A):
% Function that, given an n x 1 row vector A, returns an n x n
% diagonal matrix D whose diagonal entries are the entries of A
        size_A = size(A);
        row_len = size_A(1);
        col_len = size_A(2);

        D(1:row_len,1:col_len)=0;

        for i = 1:row_len
            for j = 1:col_len
                if i == j
                    D(i,j) = 1/A(i,j);
                else
                    D(i,j) = 0;
                end;
            end;
        end;