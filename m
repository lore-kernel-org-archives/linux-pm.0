Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6783B3C17
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259933; cv=none; b=FPzmlSSzU2AskVI5IZtqpU0m0eRT4SSUE+pG/7yFfS+yfx/p86pq1hWNtJjRdzSSaj4jUoi6Hp1VjkRRTcepwp5FILFHR6m8cO5bk9+/VqGhWXPsqZHYoBdZ6PzBzkGezZWoD275QLQjBNij92mEc4ydnUptG/q4kd93bPNrgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259933; c=relaxed/simple;
	bh=PCceAyxaZLKgL8goEMDQOo0fDMqrsGEIZWywwLaroIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWwWFOl/re37/Ip0DdGP2pYcRmH8HSpKIV/5whwEfSa8b3IPVgK+fztUZuOrdwmBIwhPalxpiT9y7sxEzlrvGjRWadQavAq8Z7P9ERQjycXL0JfdDGaiCeZ2EaNBY8sMYtF4wMqVC2jD8TQvrmvOjQ0Jn0vhNwR5FBkqj9O8dDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUaJOYo0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUaJOYo0"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso584925a12.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790259930; x=1790864730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MaWkFoUOQ+u9WS91tjqMuEOPGp9Db2ThXslkCbREcik=;
        b=iUaJOYo047OfnqEbDRf/l0Vc+QXRDOu6pdcz7FU6JL9utiqm4seLDMg+ftiJt8tShO
         azCo2kEEykKInL8/677EBvQFEdMyjmM9jdTI+U40gdOdhoxwzCns98K1LOOG68Tl4K/c
         C/YPGzk75w+vf1gcgBUIwPYLa4wETVhXgVYKnYj075UsYAgxg+1oVc7llgndUyQ4OD0I
         wjDILbkwQkJrjVVZfpq5ER/wAQp9neyhrBt57P/KP1/H0En6uLY8a/N33pq5mRtmh2zN
         7Dm/bgj+8zOZAluO3jBCF/5nEet/FOA/pMXG6xujb9ZiC+k53cbGRPJU3fE4m99FNagj
         Qb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259930; x=1790864730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MaWkFoUOQ+u9WS91tjqMuEOPGp9Db2ThXslkCbREcik=;
        b=NXaYZGiOVVA2nhP9pQNHusxvFf5LZppM1xL7cElBnduxNZbir8/5LMsozDM0JGD6X+
         TKj0uQX//5N319rKnDD37x9eJYjJJQ0DPwLC35YjAATLt99lxY9uLfhsQVuUBDI2GkgL
         rIG19Ilk+2v0v6fgvSk6UwAI+dppdkPCRbuNCExdUE9GwRS3S0MVtJOKxEdFtWDQe3qH
         e0kQT9/jhsKz3cFmjUdmhcFuXFQ14qwiEBEHO/ELGt2mkf42+avlQQuA0JzFeDHHhHST
         CozSmZ3cfno6li/IGiz5JE1oei5Dop+/4WLCFVRJMWkOFRtpnPVug4tJ6FxniDvXOQJ2
         IjDw==
X-Forwarded-Encrypted: i=1; AKwUvBxc9HSPLj1tGuOqogJLUmz057C1mcFqluRwKnGljOQp5eAiZA0OyCOb+Dv+kpUfn6E1uPKo7FcA9w==@vger.kernel.org
X-Gm-Message-State: AFuF++kPUw+aoLBVxDUqMH0tsiE2scISHfrGgNZeT7FYs29ARsX2tSv4
	F1az1ab7o1Dm4f571njWsQE8U+YqajgS7V6WHr5nu13or6b0AibmTvZh
X-Gm-Gg: AYBFou1y3zlrUsAIxLvNuhEq0LUNU/jYvkc6xbloWt8/uUJ099iBsqJHeVcWb8X8P2x
	sM2AYBKmwXdHDcKvjluXdaSKAp33JkOWpdEBsoJDMlHS7xVOI6qBqYE8pPeWshh7roSLd0iskkG
	Igtql3Vmv2lTkUQMMW6tnU8lrcw6tEFCluLIfgj03H9hnSLvjOlxtCngP+JXKqJD0j1L27LAUZx
	90TdC9Ve/CHZXyxxSJ/ZEwAT+HJ0/ZX0Qkw5Hwp0W2/fKyf0xYHDjzlzN4VCgaYNUfb8fJ03ZOr
	ePNFTzQeRMBmrYZqg/X7p2UhxKYsUu6xZgFm/NP/uyRFPCTwArFfJEj//2lm6pn+uSbnqn2uzAp
	Sja+LMwOR0MuANI2A2QP/ri4yMeCB6rt0Ow/1hCfcUmBv6VOiGv1P2SwOtB6s6lC9YfeRH109UA
	Mo3G3daqKx6OI5oSOlJj8uTHF8ZVBJe2N9a+JawSpuZPwppanztNNIXQ==
X-Received: by 2002:a05:6a00:1c8a:b0:87c:f3e5:ebda with SMTP id d2e1a72fcca58-87e99e3efcemr1451856b3a.0.1790259930408;
        Thu, 24 Sep 2026 07:25:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb99f0sm3157310b3a.6.2026.09.24.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:25:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Shawn Guo <shawnguo@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] pmdomain: imx: gpc: remove all initialized power domains
Date: Thu, 24 Sep 2026 22:25:20 +0800
Message-ID: <20260924142520.1594149-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_gpc_old_dt_init() initializes all power domains described by
of_id_data->num_domains, while imx_gpc_remove() only removes the PU and
ARM domains.

Use the match data to remove all initialized power domains in reverse
order. Release the PU clocks after the PU domain is removed.

This issue was found by manual code inspection.

Fixes: 5a42d1198901 ("soc: imx: gpc: fix imx6sl gpc power domain regression")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Check the result of device_get_match_data() before using it.
  - Use an unsigned num_domains variable and a decrementing while loop,
    as suggested by Andy Shevchenko.

 drivers/pmdomain/imx/gpc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index abca5f449a22..d83fb37e2297 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -502,7 +502,9 @@ static int imx_gpc_probe(struct platform_device *pdev)
 
 static void imx_gpc_remove(struct platform_device *pdev)
 {
+	const struct imx_gpc_dt_data *of_id_data;
 	struct device_node *pgc_node;
+	unsigned int num_domains;
 	int ret;
 
 	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
@@ -519,20 +521,23 @@ static void imx_gpc_remove(struct platform_device *pdev)
 	if (!pgc_node) {
 		of_genpd_del_provider(pdev->dev.of_node);
 
-		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to remove PU power domain (%pe)\n",
-				ERR_PTR(ret));
+		of_id_data = device_get_match_data(&pdev->dev);
+		if (!of_id_data)
 			return;
-		}
-		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 
-		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to remove ARM power domain (%pe)\n",
-				ERR_PTR(ret));
-			return;
-		}
+		num_domains = of_id_data->num_domains;
+		while (num_domains--) {
+			ret = pm_genpd_remove(&imx_gpc_domains[num_domains].base);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"Failed to remove %s power domain (%pe)\n",
+					imx_gpc_domains[num_domains].base.name,
+					ERR_PTR(ret));
+				return;
+			}
+
+		if (num_domains == GPC_PGC_DOMAIN_PU)
+			imx_pgc_put_clocks(&imx_gpc_domains[num_domains]);
 	}
 
 	of_node_put(pgc_node);
-- 
2.43.0

