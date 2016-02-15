From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] PM / OPP: Fix NULL pointer dereference crash when setting the OPP
Date: Mon, 15 Feb 2016 13:59:18 +0000
Message-ID: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
References: <1455189959-27944-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455189959-27944-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Commit 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()") causes a
crash on Tegra124 Jetson TK1 when using the DFLL clock source for the
CPU.  The DFLL manages the voltage itself and so there is no regulator
specified for the OPPs and so we get a crash when we try to dereference
the regulator pointer.  Fix this by checking to see if the regulator
IS_ERR_OR_NULL before dereferencing it.

Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

I am not sure why I did not catch this instance of the bug last week
when I submitted the patch to fix the NULL pointer dereference in
_opp_supported_by_regulators(). May be I forgot to go back and test
on HEAD after bisecting? Anyway, both this fix and the one from last
week are necessary to get the kernel booting again on Tegra124 Jetson
TK1.

 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d7cd4e265766..82ad5ae72427 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -564,7 +564,7 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	int ret;
 
 	/* Regulator not available for device */
-	if (IS_ERR(reg)) {
+	if (IS_ERR_OR_NULL(reg)) {
 		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
 			PTR_ERR(reg));
 		return 0;
-- 
2.1.4
