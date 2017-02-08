From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / Domains: Provide dummy governors if CONFIG_PM_GENERIC_DOMAINS=n
Date: Wed,  8 Feb 2017 19:37:55 +0100
Message-ID: <1486579075-21498-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

This allows to compile-test drivers that refer to governors (always by
reference) when CONFIG_PM_GENERIC_DOMAINS=n.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/pm_domain.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 81ece61075dff0e7..5339ed5bd6f9d04a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -182,6 +182,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 {
 	return -ENOTSUPP;
 }
+
+#define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
+#define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
1.9.1
