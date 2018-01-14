% Our data is called "data"
 
% Create matrix to assign groups to labels
g = randi(2, 938, 1);
 
% Specify a cluster amount 'k'
clusterNum = 2;

% Proposed groups for each step of the algorithm
newGroups = g;
 
% Variable to stop algorithm at appropriate point
stopAlgorithm = false;

% Variable for the group centre (for centroids) and to store groupdata
groupdata = zeros(1);
groupcentre = zeros(1,clusterNum);

% While algorithm is running
while(~stopAlgorithm)

    % Assign groups and calculate the mean for the centroids
    for i = 1:clusterNum
        groupdata = data(g == i, :);
        for j =1:size(groupdata,2)
            groupcentre(i,j)=sum(groupdata(:,j)/size(groupdata,1));
        end
    end
    % Calculate the distances
       for(i = 1:size(data, 1))
 
        % x-coord of point i            x_i     data(i, 1)
        % y-coord of point i            y_i     data(i, 2)
        % z-coord of point i            z_i     data(i, 3)
 
        % x-coord of centre of group 2  X_Abar  group2centre(1)
        % y-coord of centre of group 2  Y_Abar  group2centre(2)
        
        %% Calculating the Euclidean distance for 3 dimensional data
        groupdist = zeros(clusterNum,1);
        for j = 1:clusterNum
            groupdist(j,1) = sqrt((groupcentre(j,1) - data(i, 1))^2 + ...
                                  (groupcentre(j,2) - data(i, 2))^2 +... 
                                  (groupcentre(1,3) - data(i, 3))^2);
 
        end
        
        % Minimum distance
        minimumDistance = min(groupdist);
        % Reassign groups according to distance to centroid
        for j = 1:clusterNum
            if(minimumDistance == groupdist(j,1))
                newGroups(i) = j;
            end
        end
    end
 
    % If the new proposed groups are the same as the existing groups
    %%if(groups == newGroups)
    if isequal(g,newGroups)
        % Stop the algorithm
        stopAlgorithm = true;
        
    else
        % Make the groups the same as the proposed groups
        g = newGroups;
    end
    
end
% Display final groups
disp(g)


