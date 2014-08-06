From: Hans Wennborg <hans@hanshq.net>
Subject: [PATCH 02/15] cpufreq: fix decimal printf format specifiers prefixed with 0x
Date: Tue,  5 Aug 2014 21:41:48 -0700
Message-ID: <1407300108-32186-1-git-send-email-hans@hanshq.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Wennborg <hans@hanshq.net>
List-Id: linux-pm@vger.kernel.org

The prefix suggests the number should be printed in hex, so use
the %x specifier to do that.

Found by using regex suggested by Joe Perches.

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 drivers/cpufreq/speedstep-smi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 8635eec..fda9beb 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -324,8 +324,8 @@ static int __init speedstep_init(void)
 		return -ENODEV;
 	}
 
-	pr_debug("signature:0x%.8ulx, command:0x%.8ulx, "
-		"event:0x%.8ulx, perf_level:0x%.8ulx.\n",
+	pr_debug("signature:0x%.8lx, command:0x%.8lx, "
+		"event:0x%.8lx, perf_level:0x%.8lx.\n",
 		ist_info.signature, ist_info.command,
 		ist_info.event, ist_info.perf_level);
 
-- 
2.0.0.526.g5318336
