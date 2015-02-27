file:hopen`:index.txt                       / Open message log append-only
history:("\n"sv read0`:index.txt),"\n"      / Load message history from log
.z.po:{neg[.z.w]history}                    / On join, send full message history
.z.ws:{s:(" "sv(string"du"$.z.Z))," ",x;    / On message, add server timestamp
       {neg[x]y}\:[key .z.W;s];             / Fan out to other connections
       history::(history,s,"\n");           / Update message history in memory
       (neg file)s}                         / Append to message log file
.z.ph:{"\n"sv read0`:chat.htm}              / Serve static client app
