From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 18/27] drivers: firmware: psci: Add support for PM
 domains using genpd
Date: Mon, 3 Dec 2018 21:03:34 +0100
Message-ID: <CAPDyKFq1EQcwDqf737=t5OyhiTQ_RNyxO8rUaVShYPiN8ow3yw@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-19-ulf.hansson@linaro.org> <20181203163717.GN18262@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203163717.GN18262@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Dec 2018 at 17:37, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Nov 29 2018 at 10:49 -0700, Ulf Hansson wrote:
> >When the hierarchical CPU topology layout is used in DT, we need to setup
> >the corresponding PM domain data structures, as to allow a CPU and a group
> >of CPUs to be power managed accordingly. Let's enable this by deploying
> >support through the genpd interface.
> >
> >Additionally, when the OS initiated mode is supported by the PSCI FW, let's
> >also parse the domain idle states DT bindings as to make genpd responsible
> >for the state selection, when the states are compatible with
> >"domain-idle-state". Otherwise, when only Platform Coordinated mode is
> >supported, we rely solely on the state selection to be managed through the
> >regular cpuidle framework.
> >
> >If the initialization of the PM domain data structures succeeds and the OS
> >initiated mode is supported, we try to switch to it. In case it fails,
> >let's fall back into a degraded mode, rather than bailing out and returning
> >an error code.
> >
> >Due to that the OS initiated mode may become enabled, we need to adjust to
> >maintain backwards compatibility for a kernel started through a kexec call.
> >Do this by explicitly switch to Platform Coordinated mode during boot.
> >
> >To try to initiate the PM domain data structures, the PSCI driver shall
> >call the new function, psci_dt_init_pm_domains(). However, this is done
> >from following changes.
> >
> >Cc: Lina Iyer <ilina@codeaurora.org>
> >Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >---
> >
> >Changes in V10:
> >       - Enable the PM domains to be used for both PC and OSI mode.
> >       - Fixup error paths.
> >       - Move the management of kexec started kernels into this patch.
> >       - Rewrite changelog.
> >
> >---
> > drivers/firmware/psci/Makefile         |   2 +-
> > drivers/firmware/psci/psci.c           |   7 +-
> > drivers/firmware/psci/psci.h           |   6 +
> > drivers/firmware/psci/psci_pm_domain.c | 262 +++++++++++++++++++++++++
> > 4 files changed, 275 insertions(+), 2 deletions(-)
> > create mode 100644 drivers/firmware/psci/psci_pm_domain.c
> >
> >diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> >index 1956b882470f..ff300f1fec86 100644
> >--- a/drivers/firmware/psci/Makefile
> >+++ b/drivers/firmware/psci/Makefile
> >@@ -1,4 +1,4 @@
> > # SPDX-License-Identifier: GPL-2.0
> > #
> >-obj-$(CONFIG_ARM_PSCI_FW)     += psci.o
> >+obj-$(CONFIG_ARM_PSCI_FW)     += psci.o psci_pm_domain.o
> > obj-$(CONFIG_ARM_PSCI_CHECKER)        += psci_checker.o
> >diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> >index 623591b541a4..19af2093151b 100644
> >--- a/drivers/firmware/psci/psci.c
> >+++ b/drivers/firmware/psci/psci.c
> >@@ -704,9 +704,14 @@ static int __init psci_1_0_init(struct device_node *np)
> >       if (err)
> >               return err;
> >
> >-      if (psci_has_osi_support())
> >+      if (psci_has_osi_support()) {
> >               pr_info("OSI mode supported.\n");
> >
> >+              /* Make sure we default to PC mode. */
> >+              invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> >+                             PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
> >+      }
> >+
> >       return 0;
> > }
> >
> >diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> >index 7d9d38fd57e1..8cf6d7206fab 100644
> >--- a/drivers/firmware/psci/psci.h
> >+++ b/drivers/firmware/psci/psci.h
> >@@ -11,4 +11,10 @@ void psci_set_domain_state(u32 state);
> > bool psci_has_osi_support(void);
> > int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> >
> >+#ifdef CONFIG_CPU_IDLE
> >+int psci_dt_init_pm_domains(struct device_node *np);
> >+#else
> >+static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> >+#endif
> >+
> > #endif /* __PSCI_H */
> >diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> >new file mode 100644
> >index 000000000000..d0dc38e96f85
> >--- /dev/null
> >+++ b/drivers/firmware/psci/psci_pm_domain.c
> >@@ -0,0 +1,262 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/*
> >+ * PM domains for CPUs via genpd - managed by PSCI.
> >+ *
> >+ * Copyright (C) 2018 Linaro Ltd.
> >+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
> >+ *
> >+ */
> >+
> >+#define pr_fmt(fmt) "psci: " fmt
> >+
> >+#include <linux/device.h>
> >+#include <linux/kernel.h>
> >+#include <linux/pm_domain.h>
> >+#include <linux/slab.h>
> >+#include <linux/string.h>
> >+
> >+#include "psci.h"
> >+
> >+#ifdef CONFIG_CPU_IDLE
> >+
> >+struct psci_pd_provider {
> >+      struct list_head link;
> >+      struct device_node *node;
> >+};
> >+
> >+static LIST_HEAD(psci_pd_providers);
> >+static bool osi_mode_enabled;
> >+
> >+static int psci_pd_power_off(struct generic_pm_domain *pd)
> >+{
> >+      struct genpd_power_state *state = &pd->states[pd->state_idx];
> >+      u32 *pd_state;
> >+      u32 composite_pd_state;
> >+
> >+      /* If we have failed to enable OSI mode, then abort power off. */
> >+      if (psci_has_osi_support() && !osi_mode_enabled)
> >+              return -EBUSY;
> >+
> >+      if (!state->data)
> >+              return 0;
> >+
> >+      /* When OSI mode is enabled, set the corresponding domain state. */
> >+      pd_state = state->data;
> >+      composite_pd_state = *pd_state | psci_get_domain_state();
> This should not be needed. The domain_state should be 0x0 being set
> after coming out of idle.
> >+      psci_set_domain_state(composite_pd_state);
> The three lines can be summarized as:
>         psci_set_domain_state(*state->data);

Sure, let me change accordingly and thanks for spotting this!

Kind regards
Uffe
