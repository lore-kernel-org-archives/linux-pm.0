Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B02F360A;
	Wed, 24 Jun 2026 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272336; cv=none; b=A999XBOjbIbBCy2WIKKsML14LpCDP/KH8TbMmKJPlMOAdLDDcQ8eszDWBNg/gx8m9CKYg0On5Dwe7MZTRWqCTKT53rbaNLM1soiGV+GbPNy9yKMbMj0bJVnR8Cp/xFy+tORLBlu9sl6fgOXyZa4pPGKEFANYeTtBNSUJGpCYa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272336; c=relaxed/simple;
	bh=y5LZAiJERyeAfoe5CHZ7ra2UCNsHVHvTkAIdQBRaQr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mTP3kM3GqKWX5Fv7MpYvPCGsaustBIKk/4xRrfc41hAflEjB12uReNGWEOhnlgRVNnmu1IJlWcXGQ8qAeijM8DmNQ72FMboNzLmWMH/lkc/Y89yK0KbdwwwIo9MGK6xcdtbPwe26wGyaw8umnbqHPUGRU3nqGlwXJ308Rn1/0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a+Hzj8U3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a+Hzj8U3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vK
	QDyIqON71tqGHwtM14GRZInKm8rV7IMf2eudX48bQ=; b=a+Hzj8U3KaEAZUvVQ7
	w8dQPCYHc0D32wMXUPHBW7ThJhkQ5dHoopkPkfMmUmVHfjV14sWgfa6T5vtHKIPo
	NgGHyBxHuUEdtuJQuvSrbPjGipYR1FguEZNYFLmDt7Sj+76wp7j6N0gYKqsUBh0U
	aXYlQlCUJw+DTvWLeYfHD+igc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXGiYVUTtq3F9PDw--.36777S2;
	Wed, 24 Jun 2026 11:37:59 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] cpufreq: apple-soc: Fix OPP table cleanup
Date: Wed, 24 Jun 2026 11:37:56 +0800
Message-Id: <20260624033756.2702021-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXGiYVUTtq3F9PDw--.36777S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3tF4DZw43XFyxKryfZwb_yoW8Kw4UpF
	W5WFZ09rn5tF1ktws5JF4j93W7tw1kGrW2gay7GwsavwnFvF1qqa48GFy7uF95Cr95JFy3
	Cryrta47Zay8J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRNTm3UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RfCMWo7URfnnAAA3l

dev_pm_opp_of_add_table() adds the DT OPP table but not all failure
paths remove it. The driver also uses dev_pm_opp_remove_all_dynamic(),
which is not the right cleanup helper for OPPs loaded from firmware.

Remove the DT OPP table with dev_pm_opp_of_remove_table() on init
failure paths and from apple_soc_cpufreq_exit().

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Remove unnecessary cleanup calls.
 - Remove OPP table from apple_soc_cpufreq_exit(). Thanks, Viresh!
---
 drivers/cpufreq/apple-soc-cpufreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 638e5bf72185..977d56fc4fa0 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -258,7 +258,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	ret = apple_soc_cpufreq_find_cluster(policy, &reg_base, &info);
 	if (ret) {
 		dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
-		return ret;
+		goto out_remove_opp_table;
 	}
 
 	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
@@ -271,13 +271,13 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	if (ret <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
-		goto out_free_opp;
+		goto out_iounmap;
 	}
 
 	priv = kzalloc_obj(*priv);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out_free_opp;
+		goto out_iounmap;
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
@@ -320,10 +320,10 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_priv:
 	kfree(priv);
-out_free_opp:
-	dev_pm_opp_remove_all_dynamic(cpu_dev);
 out_iounmap:
 	iounmap(reg_base);
+out_remove_opp_table:
+	dev_pm_opp_of_remove_table(cpu_dev);
 	return ret;
 }
 
@@ -332,7 +332,7 @@ static void apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
 	struct apple_cpu_priv *priv = policy->driver_data;
 
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	dev_pm_opp_of_remove_table(priv->cpu_dev);
 	iounmap(priv->reg_base);
 	kfree(priv);
 }
-- 
2.25.1

