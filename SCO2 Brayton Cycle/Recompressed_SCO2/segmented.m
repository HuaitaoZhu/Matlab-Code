function [dt,hot,cold,Q_n]=segmented(hot_in,hot_out,m_1,fluid1,cold_in,cold_out,m_2,fluid2,node)    
%%Segmented Design Model
    hot=zeros(node+1,5);
    cold=zeros(node+1,5);

    hot(1,1)=hot_in(1);
    hot(node+1,1)=hot_out(1);
    cold(1,1)=cold_out(1);
    cold(node+1,1)=cold_in(1);
    hot(1,3)=hot_in(3);
    cold(1,3)=cold_out(3);
    hot(:,2)=hot_in(2);
    cold(:,2)=cold_in(2);
    
    
    Q=m_1*(hot_in(3)-hot_out(3));
    Q2=m_2*(cold_out(3)-cold_in(3));
    Q_n=Q/node;
    

    [cold(1,4),cold(1,5)]=refpropm('SQD','P',cold(1,2),'H',cold(1,3),fluid2);
    [hot(1,4),hot(1,5)]=refpropm('SQD','P',hot(1,2),'H',hot(1,3),fluid1);

    for i=2:node+1
        hot(i,3)=hot(i-1,3)-Q_n/m_1;
        cold(i,3)=cold(i-1,3)-Q_n/m_2;
        [hot(i,1),hot(i,4),hot(i,5)]=refpropm('TSQ','P',hot(i,2),'H',hot(i,3),fluid1);
        [cold(i,1),cold(i,4),cold(i,5)]=refpropm('TSQ','P',cold(i,2),'H',cold(i,3),fluid2);
    end
    
    dt=hot(:,1)-cold(:,1);
end  
