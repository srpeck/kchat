f:<:`:index.txt                     / Open message log append-only
h:("\n"/:0::`:index.txt),"\n"       / Load message history from log
.z.po:{(-:.z.w)h}                   / On join, send full message history
.z.ws:{s:(" "/:($"du"$.z.Z))," ",x; / On message, add server timestamp
    {(-:x)y}\:[!:.z.W;s];           / Fan out to other connections
    h::(h,s,"\n");                  / Update message history in memory
    (-:f)s}                         / Append to message log file
.z.ph:{"\n"/:0::`:chat.htm}         / Serve static client app
