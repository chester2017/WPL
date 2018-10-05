function [d] = mol_dis(a, b, dis_type)
%MOL_DIS    Compute distance between two molecules
%
% John R. Owen, 25 Mar 2009
% NCRG, Aston University, UK
%
%
% This function computes the distance between two molecules given
% vectors of molecular descriptors.
%
% a = array of descriptors for molecule 1
% b = array of descriptors for molecule 2
%
% dis_type can be one of the following distance measures:
%       'hamming'           1-norm
%       'euclidean'         2-norm
%       '3-norm'            3-norm
%       '4-norm'            4-norm
%       '5-norm'            5-norm
%       'tanimoto'          Tanimoto
%       'dice'              Dice coefficient
%       'cosine'            Cosine dissimilarity
%       'dixon-koehler'     Dixon-Koehler modified-Tanimoto
%       'soergel'           Soergel distance     
%
% Note: these are all distance measures, not similarities.
%
% Reference on Dixon-Koehler modified-Tanimoto:
% Dixon, S. L., Koehler, R. T. (1999). J. Med. Chem., 42:2887-2900.
%

switch (dis_type)
    case 'hamming'
        h1 = sum(abs(a - b) .^ 1);
        d = h1 ^ (1/1);
        
    case 'euclidean'
        h1 = sum(abs(a - b) .^ 2);
        d = h1 ^ (1/2);
        
    case '3-norm'
        h1 = sum(abs(a - b) .^ 3);
        d = h1 ^ (1/3);
        
    case '4-norm'
        h1 = sum(abs(a - b) .^ 4);
        d = h1 ^ (1/4);
        
    case '5-norm'
        h1 = sum(abs(a - b) .^ 5);
        d = h1 ^ (1/5);
        
    case 'tanimoto'
        h1 = sum(a .* b);
        h2 = sum(a .* a);
        h3 = sum(b .* b);
        denom = h2 + h3 - h1;
        if (denom == 0)
            d = 0;
        else
            similarity = h1 / denom;
            d = 1 - similarity;
        end;
        
    case 'dice'
        h1 = 2 .* sum(a .* b);
        h2 = sum(a .* a);
        h3 = sum(b .* b);
        denom = h2 + h3;
        if (denom == 0)
            d = 0;
        else
            similarity = h1 / denom;
            d = 1 - similarity;
        end;
        
    case 'cosine'
        h1 = sum(a .* b);
        h2 = sum(a .* a);
        h3 = sum(b .* b);
        h4 = (h2 .* h3) .^ 0.5;
        denom = h4;
        if (denom == 0)
            d = 0;
        else
            similarity = h1 / denom;
            d = 1 - similarity;
        end;
        
    case 'dixon-koehler'
        % Compute Tanimoto
        h1 = sum(a .* b);
        h2 = sum(a .* a);
        h3 = sum(b .* b);
        denom = h2 + h3 - h1;
        if (denom == 0)
            d = 0;
        else
            % Finish computing Tanimoto
            similarity = h1 / denom;
            dtan = 1 - similarity;
            % Compute Hamming
            dham = sum(abs(a - b));
            % Compute Dixon-Koehler
            d = dtan * dham;
        end;
        
    case 'soergel'
        h1 = sum(abs(a - b));
        h2 = sum(max(a, b));
        denom = h2;
        if (denom == 0)
            d = 0;
        else
            d = h1 / denom;
        end;
        
    otherwise
        error('Distance type not recognised where dis_type = %s', dis_type);
end;

