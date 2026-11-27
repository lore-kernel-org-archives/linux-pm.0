Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779212;
	b=PrjmJfni6fYC+MeQ/BnqtTzWyOnvKHGv2mdDaPxVY3dZy9GnCUYr3Gt2fdNykOa7rJfA
	 ZDVtDa3OA+kWtlSHDy6zCrVMbOma42A9hgm8RlTxkjkQJl2hy6Ad9uUE0th0EJOuHWf0p
	 YcdleKlrLVBXyfMDtpvzz7/L1QrU8jHGBwxiT0hevewa1QWV7sHCD8FIrweEPN0N81jza
	 EXXn35OUKiX4q6Liu3+Iw6k+2QrxkUKj4jQO9R4nq4tQKBr1cVT68EOHjb0ap2KwN0yR4
	 GctSnsIyvFUOblnIhGeI8u0swRGVfIMqOIKgwCsjPqwmfXnbH7+B8NTwe8Hsa1Va5+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779212;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=n9iKJQ0ODduFNUuImSDNNL7ErQfbbfsZlX7pZrvxC9o=;
	b=cYQC+jRl6KKBcqngj8b3RsxSUCo4a1nH2raqxHNy3d/hbnjlPhMoFFvSS3BiZ+Fzl6nF
	 FPUTJ0yEcSB9TY5D4QMnXZs5EvuSNUGg5GZUTdpLug7EVgOmpmu10J3A/ApEirSFw7Eu5
	 qVKlO+1z38ulbZxdmh0bo3KEFzFI3W08ginw/7h2NkNWgZdfePo/9A2DYqXx3mMvd2Z1C
	 rKJU8mwCJhEKAOPIhEtP1pFpvpa0m6iBz4xiWFS3AcW6v4C+v8ic1gQ0a77WNjVCiuuTo
	 lZb3p9Kk5n/lmbB62AXMqJW/xzSj7tWKbVc3Av+WYpL9ZeRUe+i75yEYVz6YXJyMS6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eFaCwpCl;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC73606A32C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC73606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eFaCwpCl
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56429982e;
	Fri, 27 Nov 2026 19:33:27 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: ulfh@kernel.org,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jianxin.pan@amlogic.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] pmdomain: amlogic: Tear down EE domains and their OF provider
Date: Fri, 27 Nov 2026 19:33:25 +0800
Message-Id: <20261127113326.390398-2-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113326.390398-1-202300460064@mail.sdu.edu.cn>
References: <20261127113326.390398-1-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa21cc8230303a2kunm351106c8395dd7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR1OVkxOTExNTRlPGEpNTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=eFaCwpClZEM3BORHOVvcDNoKNbseIf0IPFEyct3qIYCYm43POZwhMqKINaEtr3E6rrtW5v9GVA/Fd0M/wrIwia7PAJA6m/8ELPxNAAOEgsYGngQPQGw9fFugePdhsbTaz46+HtvSkdnjlcQM6bJAf6ns4TT/1/rRs6gkbBOCOJ4=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=n9iKJQ0ODduFNUuImSDNNL7ErQfbbfsZlX7pZrvxC9o=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The Meson EE power driver leaves the provider and domains registered
after freeing their backing storage. Remove the OF provider on unbind
and release initialized domains during managed cleanup, including when
probe fails.

This issue was found by our static analysis tool under development.

Fixes: eef3c2ba0a42 ("soc: amlogic: Add support for Everything-Else power domains controller")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/pmdomain/amlogic/meson-ee-pwrc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index 338f70d77bf0..f108d9337e5e 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -428,6 +428,16 @@ static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
 				       pwrc_domain->clks);
 }
 
+static void meson_ee_pwrc_remove_domain(void *data)
+{
+	pm_genpd_remove(data);
+}
+
+static void meson_ee_pwrc_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+}
+
 static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 				     struct meson_ee_pwrc *pwrc,
 				     struct meson_ee_pwrc_domain *dom)
@@ -494,7 +504,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 			return ret;
 	}
 
-	return 0;
+	return devm_add_action_or_reset(&pdev->dev, meson_ee_pwrc_remove_domain,
+					&dom->base);
 }
 
 static int meson_ee_pwrc_probe(struct platform_device *pdev)
@@ -641,6 +652,7 @@ MODULE_DEVICE_TABLE(of, meson_ee_pwrc_match_table);
 
 static struct platform_driver meson_ee_pwrc_driver = {
 	.probe = meson_ee_pwrc_probe,
+	.remove = meson_ee_pwrc_remove,
 	.shutdown = meson_ee_pwrc_shutdown,
 	.driver = {
 		.name		= "meson_ee_pwrc",
-- 
2.43.0

