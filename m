Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300B397B1B
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781238855; cv=none; b=VnEX+WLYcTP09MsdJStqSwmDLgD6I/czAYZw+n2CmJP1OyAgR0msr7oNenkRro0+3wIqbQ0LWQm9VygYEij/eAq7Y7rAsL/yUTQZ3yB7QvIWo2NQOs7BCZ6c1xXGBx8NL89sjOtyyK9EGLIHZTA3mnslEQzbikW25TNFuhOewoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781238855; c=relaxed/simple;
	bh=lvfJKU3OdNs7E4fSf7JASKUsJlVAskD5AP0iAuO+yuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qW0OA0PA1pAJciPH7XbbV7s8ERmZDBz+gyiVzKT3hOSNLTRvQ4G8UxLqHv+vojFHCf8jPcTGYktnA5hOTScQ1zWo3J4NrrZnh0ioaV98AIS0zP7EnlAO273FomcTtol5evheLRltsbzr9cvRJEULRoqhjNvyaXBmI3320isy5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vet1HPcT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vet1HPcT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso2957595e9.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 21:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781238852; x=1781843652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEV7Awuq7KVMhz5bMmZCK2peLPBiWMiT9VBdMWpRmIY=;
        b=vet1HPcT4HhGoNXFWiArW4OxYmR49V7fQyaMxaR5p5wKBzMCfE7ygO67M6zMRhHRpf
         Erb0mY4Po0qmVB41mour+fCeaDkzb6TiNbMI17U6rISNjTuf3+syxqS9e7OafjcvwS5k
         uOMFBhBmKXtKHFtg1AxZf/X0tce4ljOkft9sLp2hRzcNJLhu4oFwMLoTM/IpNCv6/COu
         rTpRU/WQYPXULFhKoKvgQtICytIbncS1T+ZXcI+uLrUabrafgsR13wb2wB87CjQW4HgU
         8IbfxX2mZCnuzKvHfV0RwHxTsfkDnlpVrO2Y2U5hBZfxezN8AnDqhsb45uRc8R+X2bt7
         JrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781238852; x=1781843652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VEV7Awuq7KVMhz5bMmZCK2peLPBiWMiT9VBdMWpRmIY=;
        b=NB6JHKx+X7zk5kdB1UmS8nXrle8198Wz3HX3uTMUIah49TefBEwHgmGB2SdLMWkV+a
         GC/VVsvqjR+JEOqHsp+1k/5LzNh+Lyetdvat7tiPhd5s6UXZTH6599u54qDZGgxiBz25
         jnIzzyACefEfgluNzyhdtiTkUnyTh8ZxzAqaoj/vNgmqgMjep7x93L9qeXAGOyrrkT9c
         T5UFHR1dWUrkhjFXU9vah6Fh4GqWbO7Vc5h9/HSgXZg1kKXNDHRwKzWp+waqHYvyG5TK
         Ha79vlNyYkYkcLSUbPABCki+PYDPWyE/ZiCViNSX9iyB7SRcTecgSHIpNqrtKueE2sZp
         gI9g==
X-Forwarded-Encrypted: i=1; AFNElJ8o0+3gKNjYVtbSq3Aooq7vhnPrhlh/6Vs0tMsjTNdSuh6AYidyCa26Eh4Vd825Xx7eEHWzFByToA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/O8j08//H1DPtt96HwsAA04ckuvryTaWzyQdj0NidqcVch0ZX
	VoTEzSA/EmerfFLtf4FB5msFNis1NSv2E6i5e3J7j8//xOzDjh1jOqC6JJiyPSxR2bE=
X-Gm-Gg: Acq92OH904mobkStWOr0N4h6+EzY8q16KuAUvKEYqt8IjVPFe6Yt/wHPKYj63LWlk/j
	+S12XjJimlFO/XOv+dEMeKdqC/gGDqz3oRI03nHk4k5GsmP8mXYQLy5sqenxESRiqGy1fx4NRnF
	nxiE7U08+YrAUjb6NyQBj5z17jh3rOE6oxnzqNHMTcPGD9eR1OCriQYrk1FA5SX4XPW4AASglVW
	mL6DbqlJVCzT6lGyqzcIQ8tU6Dah36ds6kIaUTKM6cfkAI/nad4sn+0+kAt5wv84Y3Q+5re4Rac
	V2yLgI6wGl3y2EDnstCpKWi2PfEw6OErzeHoe/QNwPajlTSvptTYSAkMMwHUnWF9DdmzWqHcFOh
	6/sIn5aNbn+SwXJ6fZrurdAGjcrxHtjaafSR5KLJmy32l3UhL+GkiPAI6XWBBJznA3anIqT0fPu
	twv0sBeglMaKG6VHTj9afoy09ktArto+FiUFJxX62GBwKMTdMGXXOTBFH8DxQVn0Nt1pcX2tlX6
	n79kcdjzVY9/Gv2
X-Received: by 2002:a05:600c:4595:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-490ec4fb683mr9831835e9.20.1781238851699;
        Thu, 11 Jun 2026 21:34:11 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83da91sm36134865e9.10.2026.06.11.21.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:34:10 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 12 Jun 2026 05:34:02 +0100
Subject: [PATCH 2/2] cpufreq: add ACPM-based CPU DVFS driver for Exynos
 SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-acpm-fast-xfer-v1-2-1aa6cd2268ba@linaro.org>
References: <20260612-acpm-fast-xfer-v1-0-1aa6cd2268ba@linaro.org>
In-Reply-To: <20260612-acpm-fast-xfer-v1-0-1aa6cd2268ba@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.3

Exynos-based SoCs (e.g., Exynos850, gs101) manage CPU DVFS via an
ACPM co-processor (sometimes co-processor specifically called APM).
Historically, routing CPU frequencies through the clock framework
breaks fast frequency switching as it is implemented in cpufreq-dt.
The clk_set_rate() uses mutexes, which prevents the scheduler to
utilize schedutil's fast path.

Introduce a dedicated ACPM-based cpufreq driver that bypasses the clock
framework and communicates directly with the ACPM firmware protocol.
It implements ->fast_switch() to rely on acpm_dvfs_set_rate_fast(),
enabling faster frequency transitions.

Add Google gs101 and Samsung exynos850 to the cpufreq-dt-platdev
blocklist to prevent driver cpufreq-dt initialisation.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/cpufreq/Kconfig.arm          |   8 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/acpm-cpufreq.c       | 195 +++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
 4 files changed, 207 insertions(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a441668f9e0c..891ff4b6ec22 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -24,6 +24,14 @@ config ARM_AIROHA_SOC_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Airoha EN7581 SoCs.
 
+config ARM_ACPM_CPUFREQ
+	tristate "ACPM based CPUFreq support"
+	depends on ARCH_EXYNOS || (COMPILE_TEST && 64BIT)
+	select PM_OPP
+	help
+	  This adds the CPUFreq driver for Exynos-based machines
+	  with ACPM firmware.
+
 config ARM_APPLE_SOC_CPUFREQ
 	tristate "Apple Silicon SoC CPUFreq support"
 	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 6c7a39b7f8d2..c54d2dd6629d 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 ##################################################################################
 # ARM SoC drivers
 obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
+obj-$(CONFIG_ARM_ACPM_CPUFREQ)		+= acpm-cpufreq.o
 obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
diff --git a/drivers/cpufreq/acpm-cpufreq.c b/drivers/cpufreq/acpm-cpufreq.c
new file mode 100644
index 000000000000..20fb79169993
--- /dev/null
+++ b/drivers/cpufreq/acpm-cpufreq.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Exynos ACPM-based CPUFreq DVFS driver
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+
+#define ACPM_DVFS_TRANSITION_TIMEOUT 400
+
+struct acpm_cpu_priv {
+	struct device *cpu_dev;
+	struct acpm_handle *handle;
+	unsigned int acpm_chan_id;
+	unsigned int clk_id;
+};
+
+static unsigned int acpm_soc_cpufreq_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct acpm_cpu_priv *priv;
+
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
+	/* return priv->handle->ops->dvfs.get_rate(priv->handle, priv->acpm_chan_id,
+	 *					priv->clk_id) / 1000;
+	 */
+
+	/* TODO: FIXME. Exynos850 doesn't return rate via ACPM */
+	return policy->cur;
+}
+
+static int acpm_soc_cpufreq_set_target(struct cpufreq_policy *policy,
+				       unsigned int index)
+{
+	struct acpm_cpu_priv *priv = policy->driver_data;
+	unsigned long freq_khz = policy->freq_table[index].frequency;
+
+	/* standard slow path */
+	return priv->handle->ops->dvfs.set_rate(priv->handle, priv->acpm_chan_id,
+						priv->clk_id, freq_khz * 1000);
+}
+
+static unsigned int acpm_soc_cpufreq_fast_switch(struct cpufreq_policy *policy,
+						 unsigned int target_freq)
+{
+	struct acpm_cpu_priv *priv = policy->driver_data;
+	int ret;
+
+	ret = priv->handle->ops->dvfs.set_rate_fast(priv->handle, priv->acpm_chan_id,
+						    priv->clk_id, target_freq * 1000);
+	if (ret < 0)
+		return 0;
+
+	return target_freq;
+}
+
+static int acpm_soc_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	struct cpufreq_frequency_table *freq_table;
+	struct acpm_cpu_priv *priv;
+	struct of_phandle_args args;
+	unsigned int transition_latency;
+	int ret;
+
+	if (!cpu_dev)
+		return -ENODEV;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
+					 "#clock-cells", 0, &args);
+	if (ret) {
+		dev_err(cpu_dev, "failed to parse clocks property\n");
+		goto out_free_priv;
+	}
+
+	priv->clk_id = args.args[0];
+
+	/*
+	 * DVFS communication is expected to happen only via channel 0
+	 * for now for known SoCs with ACPM firmware. Hardcoding.
+	 */
+	priv->acpm_chan_id = 0;
+
+	priv->handle = devm_acpm_get_by_node(cpu_dev, args.np);
+	of_node_put(args.np);
+
+	if (IS_ERR(priv->handle)) {
+		ret = PTR_ERR(priv->handle);
+		goto out_free_priv;
+	}
+
+	priv->cpu_dev = cpu_dev;
+
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret < 0) {
+		dev_err(cpu_dev, "failed to add OPP table: %d\n", ret);
+		goto out_free_priv;
+	}
+
+	dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
+
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		ret = -EPROBE_DEFER;
+		goto out_remove_table;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_remove_table;
+	}
+
+	policy->driver_data = priv;
+	policy->freq_table = freq_table;
+
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = ACPM_DVFS_TRANSITION_TIMEOUT * NSEC_PER_USEC;
+
+	policy->cpuinfo.transition_latency = transition_latency;
+	policy->dvfs_possible_from_any_cpu = true;
+	policy->fast_switch_possible = true;
+	policy->suspend_freq = freq_table[0].frequency;
+
+	/* TODO: FIXME. Exynos850 doesn't expose rate of clocks via ACPM  (get_rate doesn't work) */
+	policy->cur = freq_table[0].frequency;
+
+	return 0;
+
+out_remove_table:
+	dev_pm_opp_of_remove_table(cpu_dev);
+out_free_priv:
+	kfree(priv);
+	return ret;
+}
+
+static void acpm_soc_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct acpm_cpu_priv *priv = policy->driver_data;
+
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
+	dev_pm_opp_of_remove_table(priv->cpu_dev);
+	kfree(priv);
+}
+
+static struct cpufreq_driver acpm_soc_cpufreq_driver = {
+	.name		= "acpm-cpufreq",
+	.flags		= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.get		= acpm_soc_cpufreq_get_rate,
+	.init		= acpm_soc_cpufreq_init,
+	.exit		= acpm_soc_cpufreq_exit,
+	.target_index	= acpm_soc_cpufreq_set_target,
+	.fast_switch	= acpm_soc_cpufreq_fast_switch,
+	.register_em	= cpufreq_register_em_with_opp,
+	.set_boost	= cpufreq_boost_set_sw,
+	.suspend	= cpufreq_generic_suspend,
+};
+
+static int __init acpm_soc_cpufreq_module_init(void)
+{
+	if (!of_machine_is_compatible("google,gs101") &&
+	    !of_machine_is_compatible("samsung,exynos850"))
+		return -ENODEV;
+
+	return cpufreq_register_driver(&acpm_soc_cpufreq_driver);
+}
+module_init(acpm_soc_cpufreq_module_init);
+
+static void __exit acpm_soc_cpufreq_module_exit(void)
+{
+	cpufreq_unregister_driver(&acpm_soc_cpufreq_driver);
+}
+module_exit(acpm_soc_cpufreq_module_exit);
+
+MODULE_AUTHOR("Alexey Klimov <alexey.klimov@linaro.org>");
+MODULE_DESCRIPTION("ACPM-based CPUfreq DVFS driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ff1204c666b1..ae58aa92fc40 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -186,6 +186,9 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8550", },
 	{ .compatible = "qcom,sm8650", },
 
+	{ .compatible = "google,gs101", },
+	{ .compatible = "samsung,exynos850", },
+
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
 	{ .compatible = "st,stih418", },

-- 
2.51.0

