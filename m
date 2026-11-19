Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066133;
	b=flb6sxc29JVA2eQHW6E/XzEFFoAwHgncBqyrxtp3iNo4AeinSm7nArTzqBlW7qZIJWAt
	 vVom7oVXYHjgbDC7X1k1RT8ol7qULM6vM5RsKAFZN6RJLku1DXWw+DQKb4Ss99iItUcC5
	 OTN36OOsJeUEUeYiV2RT0qU+UoUowi7UvL9TDtVNeD1QcCVFxnKaKMCWwZH/TGw8YgmSZ
	 V67lhOUahJ/vu2W+YN5+zFl1vhCRC6CkelW5ISPLXtQTyWXngqy3uVXV3eX3sYROxzQVj
	 laZ1GqEiCO564Tb4grNlV7ywFX+7eSc1luS0YpeN11kNNbfjfSSVKW1RvCTwWyyCKzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=CRoVCX5qUvRVZQYCG7l49zxIQXQRCkCrH+z2zQB6lGk=;
	b=Ug+Fi2syT1YJbju9Rriosr5FSzddLzGzhVOiJX2o64zjea0LCTmJW74E3bEwoUidOrZG
	 MHXon/EM5V8lwXly+gZIiPGpdx+UOU47L0skaOMp72UFuGIGMirfmmIo4KOydJDzROzjm
	 HyjbK9/FR278f3uPPDOTBo7OCWMq5qGIoJ25vNXVRqWrMm9VXhhEkFVb3f1g/KY92AqkF
	 TNiMWWXt+9aFqWtUdjLj/ARDd1TXQGIRFMuwxSzOpSDCVV3tLd1H8SCJTKSyz1rcoGFU5
	 gQzHXTfh5BUrc4OgYeqDViBskK/YUGAdtFwUr7rxS1qyiCsUlZGs64GWyP4pTTzLlvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=klkfEfXt;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98314606A330;
	Thu, 19 Nov 2026 05:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98314606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=klkfEfXt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CR
	oVCX5qUvRVZQYCG7l49zxIQXQRCkCrH+z2zQB6lGk=; b=klkfEfXtWnpsJ4mzqN
	03kCdLrzIRy2uwkyqCewS0H6eEnrCWrNTU/hDhwAAOSgVXBicQZFk195272cVtQU
	5SASYTBX+eR/Eql+pJtxxRe7dp0dMiPkD8oiZCnBHtyamIsvAusMwveimZnMZyBB
	Vzo5GCeY0LmVD8iRFbIOFRmtE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX3+zviP5qaWbXIA--.59393S3;
	Thu, 19 Nov 2026 13:28:17 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: viresh.kumar@linaro.org,
	rafael@kernel.org
Cc: zhongqiu.han@oss.qualcomm.com,
	hector.yuan@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2 1/2] cpufreq: mediatek-hw: Release resources when hardware enable fails
Date: Thu, 19 Nov 2026 13:28:10 +0800
Message-Id: <20261119052811.2877720-2-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119052811.2877720-1-haoxiang_li2024@163.com>
References: <20261119052811.2877720-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wDX3+zviP5qaWbXIA--.59393S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyxtryxJF1fJF4DWFyUWrg_yoW8Kw1xpF
	W3ZrWYyr45XF4qqw1xCF4DuasayFs2y345W343A34Sv3ZxAFy5W3WUuFyUAFZakrykGF12
	yr4rtayxuF4kArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMhFIUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hG4J2r+iPFyGAAA3n

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

