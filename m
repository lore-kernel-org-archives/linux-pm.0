From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpupower: fix spelling mistake: "logilename" -> "logfilename"
Date: Thu,  3 May 2018 10:09:10 +0100
Message-ID: <20180503090910.29144-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dprintf message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9b65f052081f..9ba8a44ad2a7 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -104,7 +104,7 @@ FILE *prepare_output(const char *dirname)
 			dirname, time(NULL));
 	}
 
-	dprintf("logilename: %s\n", filename);
+	dprintf("logfilename: %s\n", filename);
 
 	output = fopen(filename, "w+");
 	if (output == NULL) {
-- 
2.17.0
