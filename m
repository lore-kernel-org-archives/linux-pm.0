Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973360;
	b=qyaF8al/L1yDLOgSyXlpLfEGG892PpTerA7+/wZml7Yy0hSmwcHNgo4Alir5a2c6+cW/
	 lft0uYVSMtKzuBtANEEs2+a1UCVF4Lxp0joXG4vEpeyfNcn5QwqfStTtyN+BEPlxNMjNv
	 rccUcX4KCpR4WTmp15EXyspV3O8MDgqTtk09AbBh5i6yESh40C88yYCrjvPiFBKaiF3O6
	 xoLj6FWsUo33cYZ6nXO6Wd/LFhew4p3CGhdjRmESVXZ6PjkkDB6UZeGlK7574yNOrTx7i
	 OIFWli2HO4337q66qm31/z5jD8P+Iy/8b1pzdFlZFmmlBVhENxuNOgM8c0doze8sOJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973360;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=CRoVCX5qUvRVZQYCG7l49zxIQXQRCkCrH+z2zQB6lGk=;
	b=stWrL2N57RLNkID/IiMQOQBVFmgQdiEEKZuccP0jHnxsW0p6Pz6RNT3jenLLEZOzU7rG
	 BdRzg8jg9RkoSXBO/nrrxDtq2vSDktKqAPB4f3mVi7/l6ucj+YjQD7X3IN+seVi704CHO
	 RjxeTJYU+Q0O8zEdZ8gpQXHX74Yj11k5dZ8GIBZpBfxxokwrGzTlyQjZIvjHJ3LdM0MUZ
	 /iOnDZiHXlWGpNXzL/Rxg21vy7mmf+z4U9zYRuHAOtV9HONxf9xMS6ryFDvr00DNGYTHu
	 BYRxSdUmtAOHQi10WJWY3o2XKToQeqfgo7p8zPZcndjWBXlbDT2ONIBvJDjRHT9sTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mwprI4iZ;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC00606A31C;
	Wed, 18 Nov 2026 03:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mwprI4iZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CR
	oVCX5qUvRVZQYCG7l49zxIQXQRCkCrH+z2zQB6lGk=; b=mwprI4iZ+CbiDSDsWB
	7VgMALErBQDHw1E7HMN0ODI8mXbWwx1x4+ZM5kyOlT0O3kjwoJR5iw0GjwQr6i5Y
	faUNia3AAIHABG+uZynxk434tCUYvIkQgGEN9XzP2/Pk60LHqwGWwwg5HRNamu4e
	gmoOHKho4LRzPUIGipKrGWuEk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn38CPHv1qYqpgIA--.57100S2;
	Wed, 18 Nov 2026 11:42:08 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	hector.yuan@mediatek.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] cpufreq: mediatek-hw: Release resources when hardware enable fails
Date: Wed, 18 Nov 2026 11:42:05 +0800
Message-Id: <20261118034205.2002363-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wDn38CPHv1qYqpgIA--.57100S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyxtryxJF1fJF4DWFyUWrg_yoW8Kw1xpF
	W3ZrWYyr45XF4qqw1xCF4DuasayFs2y345W343A34Sv3ZxAFy5W3WUuFyUAFZakrykGF12
	yr4rtayxuF4kArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ5rxUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RHFNGr9HpGVjAAA3M

If the CPUFreq hardware fails to become enabled, mtk_cpufreq_hw_cpu_init()
directly returns -ENODEV without releasing allocated resources.

Reuse mtk_cpufreq_hw_cpu_exit() on this error path to clear the hardware
enable request, unmap the registers and release the memory region.

Fixes: d776790a5536 ("cpufreq: mediatek-hw: Fix double devm_remap in hotplug case")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 2c57371ad502..65f15fe935db 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -289,6 +289,18 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	return ret;
 }
 
+static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct mtk_cpufreq_domain *data = policy->driver_data;
+	struct resource *res = data->res;
+	void __iomem *base = data->base;
+
+	/* HW should be in paused state now */
+	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
+	iounmap(base);
+	release_mem_region(res->start, resource_size(res));
+}
+
 static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -321,6 +333,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		if (!(sig & CPUFREQ_HW_STATUS)) {
 			pr_info("cpufreq hardware of CPU%d is not enabled\n",
 				policy->cpu);
+			mtk_cpufreq_hw_cpu_exit(policy);
 			return -ENODEV;
 		}
 
@@ -330,18 +343,6 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
-{
-	struct mtk_cpufreq_domain *data = policy->driver_data;
-	struct resource *res = data->res;
-	void __iomem *base = data->base;
-
-	/* HW should be in paused state now */
-	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
-	iounmap(base);
-	release_mem_region(res->start, resource_size(res));
-}
-
 static void mtk_cpufreq_register_em(struct cpufreq_policy *policy)
 {
 	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
-- 
2.25.1

