From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/37] tools/power turbostat: return the exit status of a command
Date: Fri, 29 Mar 2019 20:54:20 -0400
Message-ID: <20190330005441.27540-19-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: David Arcari <darcari@redhat.com>

[ Upstream commit 2a95496634a017c19641f26f00907af75b962f01 ]

turbostat failed to return a non-zero exit status even though the
supplied command (turbostat <command>) failed.  Currently when turbostat
forks a command it returns zero instead of the actual exit status of the
command.  Modify the code to return the exit status.

Signed-off-by: David Arcari <darcari@redhat.com>
Acked-by: Len Brown <len.brown@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7a1b20ec5216..d1b2348db0f9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4588,6 +4588,9 @@ int fork_it(char **argv)
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
2.19.1
