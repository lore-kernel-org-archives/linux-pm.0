From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC] OMAP: McBSP not working if CONFIG_PM_RUNTIME
	not set
Date: Tue, 07 Jun 2011 14:17:49 -0700
Message-ID: <87pqmpnxxe.fsf__16893.3759131052$1307481558$gmane$org@ti.com>
References: <201106072118.33632.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106072118.33632.jkrzyszt@tis.icnet.pl> (Janusz Krzysztofik's
	message of "Tue, 7 Jun 2011 21:18:33 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> writes:

> Hi,
>
> While solving this problem:
> http://www.spinics.net/lists/linux-omap/msg52011.html,
> I found that since commit e95496d4acadd0b72c4947be61e8d44700fdaae7, 
> "OMAP: McBSP: Add pm runtime support", McBSP ports, or at least McBSP1 
> on my Amstrad Delta, no longer work when CONFIG_PM_RUNTIME is not set. 
> Even if I don't use such setup and always select CONFIG_PM_RUNTIME, I 
> think current behaviour is wrong and should be corrected.
>
> Before I come out with a patch, please advise if and how you think this 
> should be solved. Should CONFIG_OMAP_MCBSP depend on CONFIG_PM_RUNTIME?
> Or should it select CONFIG_PM_RUNTIME? Or maybe an old code which 
> manipulated clocks directly should be restored for no CONFIG_PM_RUNTIME 
> case? Or should arch/arm/mach-omap1/pm_bus.c be always built in and 
> pm_runtime_clk_add_notifier() called from there in order to enable 
> clocks on device initialization even if CONFIG_PM_RUNTIME is not set? Or 
> still a better solution?

You're on the right track already.

Yes, the notifier init should be done even on the !PM_RUNTIME case so
that clocks are enabled when the device is added and disabled when the
device is removed.

Can you try the patch below (only compile tested)

If it works, and with your Tested-by, I'll queue this as a fix for
v3.0-rc.

Thanks,

Kevin


>From 971a6b1ba5cbca7b38fb14ae834b124c6e7bf9b5 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 7 Jun 2011 14:13:33 -0700
Subject: [PATCH] OMAP1: PM: register notifiers with generic clock ops even when !PM_RUNTIME

When runtime PM is disabled, device clocks need to be enabled on
device add and disabled on device remove.  This currently is not
happening because in the !PM_RUNTIME case, no notifiers are registered
for OMAP1 devices.

Fix this by ensuring notifiers are registered, even in the !PM_RUNTIME case.

Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/pm_bus.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index fe31d93..334fb88 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -56,9 +56,13 @@ static struct dev_power_domain default_power_domain = {
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
+#define OMAP1_PWR_DOMAIN (&default_power_domain)
+#else
+#define OMAP1_PWR_DOMAIN NULL
+#endif /* CONFIG_PM_RUNTIME */
 
 static struct pm_clk_notifier_block platform_bus_notifier = {
-	.pwr_domain = &default_power_domain,
+	.pwr_domain = OMAP1_PWR_DOMAIN,
 	.con_ids = { "ick", "fck", NULL, },
 };
 
@@ -72,4 +76,4 @@ static int __init omap1_pm_runtime_init(void)
 	return 0;
 }
 core_initcall(omap1_pm_runtime_init);
-#endif /* CONFIG_PM_RUNTIME */
+
-- 
1.7.4
