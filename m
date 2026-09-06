Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C037DEA8;
	Sun,  6 Sep 2026 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788665928; cv=none; b=ZziZqVJPZIRWHlKq89MO2rhY03g4JGrZDH6oRVNnczsi47sNUfOo46bQIZUaPQM6LPpaZ7TEfIa896LVv0eVLE87qFkmEwlkqgTmtlgQ2EdMKagO9JYDCDCgDRg7CXP0tQjk9e9G+PxTWX7mlVyhKJDUwbSSDsY3qnconVUtEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788665928; c=relaxed/simple;
	bh=kcfGz+D/RqtJqDOXx88LoPOrMhM4P5mZj435dno+u1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGkA9r2ZWYiLqlsOVO5xBp+Yrk1keueL+W9aKRTKVcAZG7kueoi2PjMpbJ4PtuzBqXz0uq3Md66sZ61Wgso1+mucrM0XkO/NdMu2WJn0My1ruXoOEPMH4GlqbPxgp5eibTRTA2405Ll8HzBVIsk9SunnnD9q0GKThp3HOUiqSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=igWyWEeG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="igWyWEeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bn
	7FZwwf19c3h9u4aABxH+CJMemOfFxO0YWc91hO9HA=; b=igWyWEeG3ZP1kr3m3c
	HBFlmj5kRfWW8+D43PbIkRWsXc+8yFyi5I4GNSAMb2I0vqpZ6DgpYH9owzRWgqL/
	FWASWjIGYbV24glq9IqasWm60fSYoVIY3+MdDR8pnC8DaJ1NEtmt/gt8Q0JJcGmI
	+84xv2O1uMYbF33glmYlMLnQE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3T5Yg4Jxql1DaAw--.30101S2;
	Sun, 06 Sep 2026 11:38:09 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"A.s. Dong" <aisheng.dong@nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: imx: Propagate SCU provider registration failures
Date: Sun,  6 Sep 2026 11:38:06 +0800
Message-ID: <20260906033806.84671-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T5Yg4Jxql1DaAw--.30101S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryftF4rKF47Kr4kuFy8Krg_yoW8XF45pF
	Wktayavrs7Jr4fG3WUGF1DZryay34Fyry7Kay5Ga4xZF45JFnxWa4Fqa4jkFnFyry8tF42
	yr429FW5CF1FyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRNeOZUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QECymqc4CGhRwAA31

imx_scu_init_pm_domains() ignores of_genpd_add_provider_onecell() and
returns success even when none of the initialized domains are published to
DT consumers.

Return the provider error and remove the initialized domains in reverse
order before devm releases their backing storage on probe failure.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: c800cd7824bd ("firmware: imx: add SCU power domain driver")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/pmdomain/imx/scu-pd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index e3f9e741daf7..05d4364f34be 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -474,7 +474,7 @@ static int imx_scu_init_pm_domains(struct device *dev,
 	struct genpd_onecell_data *pd_data;
 	struct imx_sc_pm_domain *sc_pd;
 	u32 count = 0;
-	int i, j;
+	int i, j, ret;
 
 	for (i = 0; i < pd_soc->num_ranges; i++)
 		count += pd_ranges[i].num;
@@ -503,7 +503,13 @@ static int imx_scu_init_pm_domains(struct device *dev,
 	pd_data->num_domains = count;
 	pd_data->xlate = imx_scu_pd_xlate;
 
-	of_genpd_add_provider_onecell(dev->of_node, pd_data);
+	ret = of_genpd_add_provider_onecell(dev->of_node, pd_data);
+	if (ret) {
+		while (count)
+			pm_genpd_remove(domains[--count]);
+
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

