From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to
 attach a CPU to its PM domain
Date: Tue, 4 Dec 2018 11:45:53 -0700
Message-ID: <20181204184553.GO18262@codeaurora.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-22-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-22-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
>Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
>a CPU number as an in-parameter and attaches the CPU's struct device to its
>corresponding PM domain. Additionally, the helper prepares the CPU to be
>power managed via runtime PM, which is the last step needed to enable the
>interaction with the PM domain through the runtime PM callbacks.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
>
>Changes in v10:
>	- New patch: Replaces "PM / Domains: Add helper functions to
>	  attach/detach CPUs to/from genpd".
>
>---
> drivers/firmware/psci/psci.h           |  1 +
> drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
> 2 files changed, 20 insertions(+)
>
>diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
>index 05af462cc96e..fbc9980dee69 100644
>--- a/drivers/firmware/psci/psci.h
>+++ b/drivers/firmware/psci/psci.h
>@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> int psci_dt_init_pm_domains(struct device_node *np);
> int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> 			struct device_node *cpu_node, u32 *psci_states);
>+int psci_dt_attach_cpu(int cpu);
> #else
> static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> #endif
>diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
>index 6c9d6a644c7f..b0fa7da8a0ce 100644
>--- a/drivers/firmware/psci/psci_pm_domain.c
>+++ b/drivers/firmware/psci/psci_pm_domain.c
>@@ -12,8 +12,10 @@
> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/pm_domain.h>
>+#include <linux/pm_runtime.h>
> #include <linux/slab.h>
> #include <linux/string.h>
>+#include <linux/cpu.h>
> #include <linux/cpuidle.h>
> #include <linux/cpu_pm.h>
>
>@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
>
> 	return 0;
> }
>+
>+int psci_dt_attach_cpu(int cpu)
>+{
>+	struct device *dev = get_cpu_device(cpu);
>+	int ret;
>+
>+	ret = dev_pm_domain_attach(dev, true);
>+	if (ret)
>+		return ret;
>+
>+	pm_runtime_irq_safe(dev);
>+	pm_runtime_get_noresume(dev);
>+	pm_runtime_set_active(dev);
You would want to set this only if the CPU is online. Otherwise we will
not power down the domain, if the CPU was never brought online.
>+	pm_runtime_enable(dev);
>+
>+	return 0;
>+}
> #endif
>-- 
>2.17.1
>
