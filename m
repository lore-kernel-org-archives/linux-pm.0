From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v9 03/11] PM / Domains: Document flags for genpd
Date: Wed,  3 Oct 2018 16:38:16 +0200
Message-ID: <20181003143824.13059-4-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The current documented description of the GENPD_FLAG_* flags, are too
simplified, so let's extend them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 776c546d581a..3b5d7280e52e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,11 +17,36 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 
-/* Defines used for the flags field in the struct generic_pm_domain */
-#define GENPD_FLAG_PM_CLK	 (1U << 0) /* PM domain uses PM clk */
-#define GENPD_FLAG_IRQ_SAFE	 (1U << 1) /* PM domain operates in atomic */
-#define GENPD_FLAG_ALWAYS_ON	 (1U << 2) /* PM domain is always powered on */
-#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3) /* Keep devices active if wakeup */
+/*
+ * Flags to control the behaviour of a genpd.
+ *
+ * These flags may be set in the struct generic_pm_domain's flags field by a
+ * genpd backend driver. The flags must be set before it calls pm_genpd_init(),
+ * which initializes a genpd.
+ *
+ * GENPD_FLAG_PM_CLK:		Instructs genpd to use the PM clk framework,
+ *				while powering on/off attached devices.
+ *
+ * GENPD_FLAG_IRQ_SAFE:		This informs genpd that its backend callbacks,
+ *				->power_on|off(), doesn't sleep. Hence, these
+ *				can be invoked from within atomic context, which
+ *				enables genpd to power on/off the PM domain,
+ *				even when pm_runtime_is_irq_safe() returns true,
+ *				for any of its attached devices. Note that, a
+ *				genpd having this flag set, requires its
+ *				masterdomains to also have it set.
+ *
+ * GENPD_FLAG_ALWAYS_ON:	Instructs genpd to always keep the PM domain
+ *				powered on.
+ *
+ * GENPD_FLAG_ACTIVE_WAKEUP:	Instructs genpd to keep the PM domain powered
+ *				on, in case any of its attached devices is used
+ *				in the wakeup path to serve system wakeups.
+ */
+#define GENPD_FLAG_PM_CLK	 (1U << 0)
+#define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
+#define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
+#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
2.17.1
