From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PM / hibernate: Mark expected switch fall-through
Date: Sat, 4 Aug 2018 21:12:00 -0500
Message-ID: <20180805021200.GA10911@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114713 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/power/hibernate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 9c85c78..38f3f96 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -638,6 +638,7 @@ static void power_down(void)
 		break;
 	case HIBERNATION_PLATFORM:
 		hibernation_platform_enter();
+		/* Fall through */
 	case HIBERNATION_SHUTDOWN:
 		if (pm_power_off)
 			kernel_power_off();
-- 
2.7.4
