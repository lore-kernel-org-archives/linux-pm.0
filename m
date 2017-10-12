From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] cpufreq: speedstep-lib: mark expected switch fall-through
Date: Thu, 12 Oct 2017 17:41:03 -0500
Message-ID: <20171012224103.GA18340@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/cpufreq/speedstep-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index ccab452..8085ec9 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -367,7 +367,7 @@ unsigned int speedstep_detect_processor(void)
 			} else
 				return SPEEDSTEP_CPU_PIII_C;
 		}
-
+		/* fall through */
 	default:
 		return 0;
 	}
-- 
2.7.4
