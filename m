From: David Arcari <darcari@redhat.com>
Subject: [PATCH] tools/power turbostat: return the exit status of a command
Date: Tue, 12 Feb 2019 09:34:39 -0500
Message-ID: <1549982079-23516-1-git-send-email-darcari@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>, Len Brown <len.brown@intel.com>, Jirka Hladky <jhladky@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

turbostat failed to return a non-zero exit status even though the
supplied command (turbostat <command>) failed.  Currently when turbostat
forks a command it returns zero instead of the actual exit status of the
command.  Modify the code to return the exit status.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9327c0d..c3fad06 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5077,6 +5077,9 @@ int fork_it(char **argv)
 		signal(SIGQUIT, SIG_IGN);
 		if (waitpid(child_pid, &status, 0) == -1)
 			err(status, "waitpid");
+
+		if (WIFEXITED(status))
+			status = WEXITSTATUS(status);
 	}
 	/*
 	 * n.b. fork_it() does not check for errors from for_all_cpus()
-- 
1.8.3.1
