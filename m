From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] cpufreq: tegra: don't error target() when suspended
Date: Wed, 20 Nov 2013 14:06:22 -0700
Message-ID: <1384981582-30697-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

d4019f0a92ab "cpufreq: move freq change notifications to cpufreq core"
added code to the cpufreq core to print an error if a cpufreq driver's
.target() function returned an error. This exposed the fact that Tegra's
cpufreq driver returns an error when it is ignoring requests due to the
system being suspended.

Modify Tegra's .target() function not to return an error in this case;
this prevents the error prints. The argument is that since the suspend
hook can't and doesn't inform the cpufreq core when its requests will
be ignored, there's no way for the cpufreq core to squelch them, so it's
not an error for the requests to keep coming. This change make the Tegra
driver consistent with how the Exynos handles the same situation. Note
that s5pv210-cpufreq.c probably suffers from this same issue though.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
This is a fix for 3.13.

Commit d4019f0a92ab also failed to update the Tegra pm_notifier hook to
emit cpufreq notifications. That hook calls the target() implementation
directly, which used to emit the notifications. However, now that the
notifications are made outside of target(), they no longer occur when
target() is called directly. I'm not sure if this is an issue or not?
---
 drivers/cpufreq/tegra-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index f42df7ec03c5..b7309c37033d 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -142,10 +142,8 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 
 	mutex_lock(&tegra_cpu_lock);
 
-	if (is_suspended) {
-		ret = -EBUSY;
+	if (is_suspended)
 		goto out;
-	}
 
 	freq = freq_table[index].frequency;
 
-- 
1.8.1.5
