Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699683;
	b=owCd/aNUsYRYwKsMQsy0l2NdRMQqRR1vQNp+4LgivqtEFQ53GdSlEJDO+sSsQZ0BLUMj
	 wnxJKwspanmoSsvq75uV2MIHcBuV5BMYEo0olk5F73YBCBFP9DVGZwCOLLjAtqNpV96JB
	 eyEpTLVv97fuwKNx/h9eaCTcOiOvpvd866zb3snv8jTLkY7t8hR18Z6gp2ujxZeBtSMzy
	 WzZ43SzMDN4CNznBNyv8m3E9BWLleSzuqQcIzbviaufxxFs6K7jmHjgn43pYa9JF9NZQf
	 VEDTnZc9oD2R1it95QVtF38WldS0DhgpbkaYe4po3nMjXq+wchLfgVO2FBya3yj63Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699683;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=OfJl/3qvWQ96HZ0/MhaHRr6gto4HfhpK3vhDKRrOjmY=;
	b=1zmBf5EdJG4mNGIUCC/h1ftFbNg8G3+ui5OTCjQweBgwkkikPO024iVD8v9jCwKLlUy1
	 C2r557RneXIjEFyZUCseJaRE6wwT9TcM8mcobWB/Hk9xAh1XSuZQCfwqe+7rd88vEi1KJ
	 /Pc7+MRqANf4L/ys5kaDNeOtgAKH+QTVQm1AuN+DZOZk+jIG4iTiMdZ32zMB5wwjuuiOJ
	 p/wvjiSVy7ghKvo+CoD3ChUTbf0yFp7D2RVrgXw1l7xuuebw/bYUKAN0LEb5gWXf6vlEz
	 9RPbAVgnCjikNIMmjAE9wDRqKSnO+12Sn7YFp0T9PTEGt4Dv+4zpyVenf/63jg4Y9oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ffG5EsP8;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF0606A32D;
	Thu, 26 Nov 2026 13:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EF0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ffG5EsP8
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fcac;
	Thu, 26 Nov 2026 21:27:57 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: rafal@milecki.pl,
	florian.fainelli@broadcom.com,
	ulfh@kernel.org,
	noltari@gmail.com,
	alex.aring@gmail.com,
	eric@anholt.net,
	khilman@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	liguangshuo@mail.sdu.edu.cn
Subject: [PATCH 1/3] pmdomain: bcm: Unregister PMB power domains on unbind
Date: Thu, 26 Nov 2026 21:27:53 +0800
Message-Id: <20261126132755.4091008-2-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126132755.4091008-1-202300460064@mail.sdu.edu.cn>
References: <20261126132755.4091008-1-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa2180a976f03a2kunm345e734035d93c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTU4fVkNMTBhKTxhOSUxDQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=ffG5EsP8xNGNW1lDF5CVdPi7slxD9y01MEMCNwA9jW7uRy8HEFn7eo/Grtqpa7egbAqrQvU7D8HfmiAIwOKYCz8ruvRESNcYfDq+e5TDMkNQhLhzL2ithrbfFAxTwLlsPrlgQr+d7uyVEOdJCOgA1gacRwt89twqFxr4aXxpdjU=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=OfJl/3qvWQ96HZ0/MhaHRr6gto4HfhpK3vhDKRrOjmY=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The PMB provider and its domains remain registered after the driver
releases their storage. Delete the provider before the domains on unbind
and remove initialized domains if a later registration or allocation
fails.

This issue was found by our static analysis tool under development.

Fixes: 8bcac4011ebe ("soc: bcm: add PM driver for Broadcom's PMB")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/pmdomain/bcm/bcm-pmb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm-pmb.c b/drivers/pmdomain/bcm/bcm-pmb.c
index d074c8cf2038..22b84c4d85a6 100644
--- a/drivers/pmdomain/bcm/bcm-pmb.c
+++ b/drivers/pmdomain/bcm/bcm-pmb.c
@@ -270,6 +270,21 @@ static int bcm_pmb_power_off(struct generic_pm_domain *genpd)
 	}
 }
 
+static void bcm_pmb_remove_domains(struct bcm_pmb *pmb)
+{
+	int i;
+
+	for (i = pmb->genpd_onecell_data.num_domains - 1; i >= 0; i--)
+		if (pmb->genpd_onecell_data.domains[i])
+			pm_genpd_remove(pmb->genpd_onecell_data.domains[i]);
+}
+
+static void bcm_pmb_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+	bcm_pmb_remove_domains(platform_get_drvdata(pdev));
+}
+
 static int bcm_pmb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -311,8 +326,10 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 	for (e = table; e->name; e++) {
 		struct bcm_pmb_pm_domain *pd = devm_kzalloc_obj(dev, *pd);
 
-		if (!pd)
-			return -ENOMEM;
+		if (!pd) {
+			err = -ENOMEM;
+			goto err_remove_domains;
+		}
 
 		pd->pmb = pmb;
 		pd->data = e;
@@ -320,17 +337,24 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 		pd->genpd.power_on = bcm_pmb_power_on;
 		pd->genpd.power_off = bcm_pmb_power_off;
 
-		pm_genpd_init(&pd->genpd, NULL, true);
+		err = pm_genpd_init(&pd->genpd, NULL, true);
+		if (err)
+			goto err_remove_domains;
 		pmb->genpd_onecell_data.domains[e->id] = &pd->genpd;
 	}
 
 	err = of_genpd_add_provider_onecell(dev->of_node, &pmb->genpd_onecell_data);
 	if (err) {
 		dev_err(dev, "failed to add genpd provider: %d\n", err);
-		return err;
+		goto err_remove_domains;
 	}
 
+	platform_set_drvdata(pdev, pmb);
 	return 0;
+
+err_remove_domains:
+	bcm_pmb_remove_domains(pmb);
+	return err;
 }
 
 static const struct bcm_pmb_pd_data bcm_pmb_bcm4908_data[] = {
@@ -358,6 +382,7 @@ static struct platform_driver bcm_pmb_driver = {
 		.of_match_table = bcm_pmb_of_match,
 	},
 	.probe  = bcm_pmb_probe,
+	.remove = bcm_pmb_remove,
 };
 
 builtin_platform_driver(bcm_pmb_driver);
-- 
2.43.0

