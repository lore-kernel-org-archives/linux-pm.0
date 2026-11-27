Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779209;
	b=ExBpw7sASbWv5V+VmhcAc+NSkjbwq3wpvCSbomvVz0O1G7HYV137AoOad4vhQqQioU7i
	 Nr0sJ5MAcKMnsNUYQGVOYZkLJWjFYdo7JlK2KyO6jaSRPhdZGttffmdJryvehrAT3wEKq
	 Yuc5vqRhr2kwHv/uMAIMuC+w+XSoiphPlG70bKx/Hvb3iq7Zut0jbBpIRZzy7sTD4oh/0
	 gqEbXAoXw0aT49ygLhBdGVnzrd2rcTbEA50PhGjNO4bLFosK11HnVsTdomF7y9psRJsBK
	 oJqrQ9GcaHKSzl9grl4aPNL5BFwc0DjZpJ+SooBukRTnyZllErWuT3JddNbK3KCUCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779209;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=AWhWVFXi1qiZ+jsR2+3reWioz9FOSzC0rU2/Z8jPD8g=;
	b=3imqQrU9YgVb6Gl+nGr6DqfEIDSVia+V8F67ucZwxqMUtf8ZEc++tEuQ5mO8ERbKXt1T
	 m0cejTVAC9ygJeZ6L3fPvjsrwz/YYttmgXWpk/KdP7UKnhYl5n8RQrMIM1Oqu+VAYU93v
	 RHxrTP6BsxDNPDM1wCDlE8+TxeXKRsNUxrDy/KJfkEFzGUBcq4V2iBrUJxfNrDuUB5Ybx
	 EkNtu0cB4Oh2Y1EjDQRM3wbi3TpDTwEe/nrs0xll6quvkF8N+RlMnFXzli5qDdDiZIO1Q
	 jooPLJMllfLUyKDRlUBUf6VZkgeVfuFIFsALKLEB8d9+l3a+RIQ9KVkNrV+m6l8QFoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=QE+CFpHs;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D01606A31E;
	Fri, 27 Nov 2026 11:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7D01606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=QE+CFpHs
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56429982a;
	Fri, 27 Nov 2026 19:33:24 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	t.figa@samsung.com,
	kgene.kim@samsung.com
Cc: alim.akhtar@samsung.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: s5pv210: Add teardown and unwind probe failures
Date: Fri, 27 Nov 2026 19:33:21 +0800
Message-Id: <20261127113322.390337-2-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113322.390337-1-202300460064@mail.sdu.edu.cn>
References: <20261127113322.390337-1-202300460064@mail.sdu.edu.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa21cc815d403a2kunm5097e7d4395dc9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTklNVkNOHUoeHk4eQkNJQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=QE+CFpHsKbVZGVlK2Lvve1qzkSilmyq5N1fTq+xxStaOloaXstFF5A7D5ljyPk4DBw1HMyNxWhwTAh0E16xhiK6exhXcri8RUD+RI83uNddC3RB17573K1M+lssPCL80X35BrUR+tiHZgLtDnzToU1/y/kE4niquby9g88TvhBo=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=AWhWVFXi1qiZ+jsR2+3reWioz9FOSzC0rU2/Z8jPD8g=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Platform unbind leaves the cpufreq driver and reboot notifier registered
and retains the clocks, regulators and register mappings. A failed
registration also bypasses probe cleanup.

Register the reboot notifier after the cpufreq driver and unwind both in
reverse order. Drop the policy clocks on policy exit and release the
register mappings and regulators on failure and removal.

This issue was found by our static analysis tool under development.

Fixes: 6d4ed0f46af6 ("cpufreq: s5pv210: Make the driver multiplatform aware")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 52 ++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index e64e84e1ee79..b01b77564ff8 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -553,6 +553,13 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static void s5pv210_cpu_exit(struct cpufreq_policy *policy)
+{
+	clk_put(dmc1_clk);
+	clk_put(dmc0_clk);
+	clk_put(policy->clk);
+}
+
 static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
 						 unsigned long event, void *ptr)
 {
@@ -579,6 +586,7 @@ static struct cpufreq_driver s5pv210_driver = {
 	.target_index	= s5pv210_target,
 	.get		= cpufreq_generic_get,
 	.init		= s5pv210_cpu_init,
+	.exit		= s5pv210_cpu_exit,
 	.name		= "s5pv210",
 	.suspend	= cpufreq_generic_suspend,
 	.resume		= cpufreq_generic_suspend, /* We need to set SLEEP FREQ again */
@@ -588,6 +596,17 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
 	.notifier_call = s5pv210_cpufreq_reboot_notifier_event,
 };
 
+static void s5pv210_unmap_registers(void)
+{
+	unsigned int id;
+
+	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
+		iounmap(dmc_base[id]);
+		dmc_base[id] = NULL;
+	}
+	iounmap(clk_base);
+}
+
 static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -633,8 +652,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 		id = of_alias_get_id(dmc, "dmc");
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
 			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", dmc);
-			result = id;
-			goto err_clk_base;
+			result = id < 0 ? id : -EINVAL;
+			goto err_dmc;
 		}
 
 		dmc_base[id] = of_iomap(dmc, 0);
@@ -653,19 +672,18 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 		}
 	}
 
-	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
+	result = cpufreq_register_driver(&s5pv210_driver);
+	if (result)
+		goto err_dmc;
 
-	return cpufreq_register_driver(&s5pv210_driver);
+	result = register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
+	if (!result)
+		return 0;
 
-err_dmc:
-	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
-		if (dmc_base[id]) {
-			iounmap(dmc_base[id]);
-			dmc_base[id] = NULL;
-		}
+	cpufreq_unregister_driver(&s5pv210_driver);
 
-err_clk_base:
-	iounmap(clk_base);
+err_dmc:
+	s5pv210_unmap_registers();
 
 err_clock:
 	regulator_put(int_regulator);
@@ -676,10 +694,20 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	return result;
 }
 
+static void s5pv210_cpufreq_remove(struct platform_device *pdev)
+{
+	unregister_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
+	cpufreq_unregister_driver(&s5pv210_driver);
+	s5pv210_unmap_registers();
+	regulator_put(int_regulator);
+	regulator_put(arm_regulator);
+}
+
 static struct platform_driver s5pv210_cpufreq_platdrv = {
 	.driver = {
 		.name	= "s5pv210-cpufreq",
 	},
 	.probe = s5pv210_cpufreq_probe,
+	.remove = s5pv210_cpufreq_remove,
 };
 builtin_platform_driver(s5pv210_cpufreq_platdrv);

-- 
2.43.0

