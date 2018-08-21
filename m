From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] cpupower: remove stringop-truncation waring
Date: Tue, 21 Aug 2018 14:02:25 +0200
Message-ID: <20180821120225.3516-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: linux-pm@vger.kernel.org

The strncpy doesn't null terminate the string because the size is too
short by one byte.

parse.c: In function ‘prepare_default_config’:
parse.c:148:2: warning: ‘strncpy’ output truncated before terminating
    nul copying 8 bytes from a string of the same length
    [-Wstringop-truncation]
  strncpy(config->governor, "ondemand", 8);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Passing the length of the input argument to strncpy() is almost always
wrong and provides no extra benefit over strcpy(), and since 'ondemand'
fits within 15 bytes" and it null terminates the string its safe to use
strcpy().

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9ba8a44ad2a7..91b5b768ffd2 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -145,7 +145,7 @@ struct config *prepare_default_config()
 	config->cpu = 0;
 	config->prio = SCHED_HIGH;
 	config->verbose = 0;
-	strncpy(config->governor, "ondemand", 8);
+	strcpy(config->governor, "ondemand");
 
 	config->output = stdout;
 
-- 
2.18.0
