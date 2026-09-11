Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D83F412B;
	Fri, 11 Sep 2026 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106975; cv=none; b=pRZWY8b/BNpVVYH9YGhPAUB0h07hwCVNqbRbOoqnPU1DfpnRjbjl7IG17EK8u+WA5NqgnwaAw+vmbO3XhrxrcKLgPlLOPRiHzcUg365q5izel6Ve5XoepLriOVnDFsGed4EyF1xiVDoqJAZiE7kTYpkT3eIws01qTme/cc75gFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106975; c=relaxed/simple;
	bh=ADkggTW8RH6T2yTzoHu9/jk42cW3Kw5gtDzEFKW4+3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oobNewa0sNIse84iDJk2JazkXsYvZw3WR5SLNjC3863SfaJ/FNaT+/ET39yNCGMBRd8zJF2duAklG6W/vS96bq3SQEpDSZCkxym3nRU+CFHAClOE3Gn5kvIg62GvlfXKi6Z9IjoKrnrswlYc+1KTULRCG3wkAHybSwHQQNbiTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=j930sFoJ; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="j930sFoJ"
Received: from seu.edu.cn (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d62c4fc2;
	Fri, 11 Sep 2026 14:09:30 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: ulfh@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH RFC] pmdomain: imx: reject a missing bus power domain
Date: Fri, 11 Sep 2026 14:09:29 +0800
Message-Id: <20260911060929.94481-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08f15dceb03a1kunm8126a0a81c7377
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZS01NVhlDSUpPGRpISk4eTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=j930sFoJBSDlrQKg5hhUbpgFngB5t6l/UFcdtdQtZ4DttF9DdBRdN8GcPFX+xlwHvGz1gEmpkkJAIVosHU3dDF6yE+mY7Zj+eUoVmCjseS7mtUufsXJki71slHoqavXBfrGQOQSQKymp91UflSBQJBmoe61S81PhhHamLtKGd18=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Q/gVuEgQ+O1MlxzayRMNUxUrBsV8eHwDdB0w2KFHMt4=;
	h=date:mime-version:subject:message-id:from;

The named-domain attach API may return NULL for an absent name.
Treat that as -ENODEV before publishing bus_power_dev to later unwind
paths, without changing the handling of existing error pointers.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 2 ++
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 479789009c7f..9653a8ac9a6e 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -228,6 +228,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
+	if (!bc->bus_power_dev)
+		return dev_err_probe(dev, -ENODEV, "missing bus power domain\n");
 	if (IS_ERR(bc->bus_power_dev)) {
 		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
 			return dev_err_probe(dev, -EPROBE_DEFER,
diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index d255c20f58e2..e952b4ee75c0 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -655,6 +655,8 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
+	if (!bc->bus_power_dev)
+		return dev_err_probe(dev, -ENODEV, "missing bus power domain\n");
 	if (IS_ERR(bc->bus_power_dev))
 		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
 				     "failed to attach bus power domain\n");
