From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] cpupower: remove stringop-truncation waring
Date: Tue, 28 Aug 2018 11:31:18 +0200
Message-ID: <20180828093118.28326-1-anders.roxell@linaro.org>
References: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
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

The normal method of passing the length of the destination buffer works
correctly here.

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9ba8a44ad2a7..84caee38418f 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -145,7 +145,7 @@ struct config *prepare_default_config()
 	config->cpu = 0;
 	config->prio = SCHED_HIGH;
 	config->verbose = 0;
-	strncpy(config->governor, "ondemand", 8);
+	strncpy(config->governor, "ondemand", sizeof(config->governor));
 
 	config->output = stdout;
 
-- 
2.18.0
