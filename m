From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/3] PM / Domains: Take wakeup_path_in_band status flag into account
Date: Mon, 13 Nov 2017 16:46:43 +0100
Message-ID: <1510588003-16650-4-git-send-email-ulf.hansson@linaro.org>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Make genpd to take the wakeup_path_in_band status flag into account during
system suspend/resume. More precisely, in case the flag has been set by the
PM core, let's leave the device in full power state and prevent the PM
domain from being powered off.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
	- Added Geert's Reviewed-by tag.
	- Changed to look at status flag instead of driver flag.
---
 drivers/base/power/domain.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 24e39ce..21cbea0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1037,7 +1037,8 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+	if (dev->power.wakeup_path &&
+	    (dev->power.wakeup_path_in_band || genpd_is_active_wakeup(genpd)))
 		return 0;
 
 	if (poweroff)
@@ -1092,7 +1093,8 @@ static int genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+	if (dev->power.wakeup_path &&
+	    (dev->power.wakeup_path_in_band || genpd_is_active_wakeup(genpd)))
 		return 0;
 
 	genpd_lock(genpd);
-- 
2.7.4
