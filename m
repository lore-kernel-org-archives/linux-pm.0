From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/15] PM / Domains: Add late_initcall to disable unused PM domains
Date: Wed,  3 Sep 2014 12:52:26 +0200
Message-ID: <1409741551-16437-11-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

As default behavior let genpd at late init try to disable the unused
PM domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d71d045..cf4651a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -721,6 +721,13 @@ void pm_genpd_poweroff_unused(void)
 	mutex_unlock(&gpd_list_lock);
 }
 
+static int __init genpd_poweroff_unused(void)
+{
+	pm_genpd_poweroff_unused();
+	return 0;
+}
+late_initcall(genpd_poweroff_unused);
+
 #else
 
 static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
-- 
1.9.1

