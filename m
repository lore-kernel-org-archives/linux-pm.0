From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/44] tools/power turbostat: show error on exec
Date: Wed,  1 Mar 2017 00:27:46 -0500
Message-ID: <0815a3d09baf2cd330f75020bdaad0f1adac0ecb.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When turbostat is run in one-shot command mode,
the parent takes the 'before' counter snapshot,
fork/exec/wait for the child to exit,
takes the 'after' counter snapshot,
and prints the results.

however, if the child fails to exec the command,
it immediately returns, without indicating that
anythign was wrong.

Add an error message showing that exec failed:

sudo turbostat sleeeep 4
...
turbostat: exec sleeeep: No such file or directory
...

Note that the parent will still print out the statistics,
because it can't tell the difference between the failed
exec and a command that is purposefully returning
the same status.  Unfortunately, this may obscure the
error message.  However, if the --out parameter is used,
the error message is evident on stderr.

Reported-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7af5f42a9792..2d758abecd56 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4525,6 +4525,7 @@ int fork_it(char **argv)
 	if (!child_pid) {
 		/* child */
 		execvp(argv[0], argv);
+		err(errno, "exec %s", argv[0]);
 	} else {
 
 		/* parent */
-- 
2.11.0.161.g6610af872
