From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v6 22/25] drivers: firmware: psci: Deal with CPU hotplug when using OSI mode
Date: Wed, 14 Mar 2018 17:58:32 +0100
Message-ID: <1521046715-30683-23-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To deal with CPU hotplug when OSI mode is used, the CPU device needs to be
detached from its PM domain (genpd) when putting it offline, otherwise the
CPU becomes considered as being in use from genpd and runtime PM point of
view. Obviously, then we also need to re-attach the CPU device when bring
the CPU back online, so let's do this.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 944d6f6..06f3916 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -190,6 +190,10 @@ static int psci_cpu_off(u32 state)
 	int err;
 	u32 fn;
 
+	/* If running OSI mode, detach the CPU device from its PM domain. */
+	if (psci_osi_mode_enabled)
+		of_genpd_detach_cpu(smp_processor_id());
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -204,6 +208,10 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	/* Clear the domain state to start fresh. */
 	psci_set_domain_state(0);
+
+	if (!err && psci_osi_mode_enabled)
+		of_genpd_attach_cpu(cpuid);
+
 	return psci_to_linux_errno(err);
 }
 
-- 
2.7.4
