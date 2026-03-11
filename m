Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82784318EE1
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188393; cv=none; b=XrrA1MiiwBxqm3lPcoEulstbzs6KlQIqIwByfCc225PG95YJPWb/98p0ARiJHwuTUb/lS2/IW2dwHWoMAHzbIbJ9zQvS9JIs97/ma6fd1GK83VHoOEFKVRQwMMTFpiuzTesz9MPwCL7zPG4eBlmLA+CJrtTjJpEdAmgfqdR1Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188393; c=relaxed/simple;
	bh=SpNaRu6uMd8HuXBGwkIHZTjCWaD47krsvCZKz8R9UDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9fBR3r524KxVs0By01ILCqRW/9i/KJ6PCwZlhCql8w2iaxXwInRXWeY2HATnCheGKIFZoeBrx0GlBctw6L2C7pXIaXeliguC1lhoEuRMG67fIXYmm5l34sfCSlStSCWgWaYfE2Y7U7RGGqrsDNDrIl1ZZy/Ah699rXWvEXFgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nUMjab5q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nUMjab5q"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bde0f62464cso5173682a12.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188391; x=1773793191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4UkaIVkjTxZ19xGJc/X7b8NyYsvb0FdSydtov7Zv/8=;
        b=nUMjab5qVm2UpxcrlYiA6CoXy6V2OUkR9Ktb0a6gCUH+mnF+pEaKo8prno5x4vm2ot
         vXL85vbxG7lhtRPQgWFFreLDhdugyCkqXHRnst35im5t0fTFjdrWVQH19/wUZ3FIYoTw
         nxx1CZ4cI3V4Ci8UPawPVGcrF/Qj4yYvkQWR0vmHIxTjzBYqlvfM2eHjEtcvF1Y70SAz
         mAKyXpNUwZJEsqR6Sbxf76zwe6WFKkA8novm5Hkz8Pb8rduETLa4A73ZhV2thRihFnQO
         J8c74+SiF2dGv6//JJ3XGIYTi82JGU5jHTeqjjFqrYtr4GR8OI4iLM497COWkTmUtuU3
         Q/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188391; x=1773793191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4UkaIVkjTxZ19xGJc/X7b8NyYsvb0FdSydtov7Zv/8=;
        b=CH+U/VKINZI6qM/kFMhvdrk5O2y2/TpC5g+yUj8helJZ96j0oNUHXlmgj94tV0qUGN
         8ZOfK03zwgLIbb0q+FgmGZcIqvKQ0YJKkVu4q3/6FiEeM0gyG+UIBrx4UyCBlks475S/
         3PGojkDgA1aGwSgppAzYR+NBIUtuYTQiqcfLyh0mvzkp7n9TdznZATvY0NYPLHM9hND6
         6hjF75f7OxSvEPOPzuZOayPgd1W1jvQ9GiYTsuzoWK2iDexELgwuFJZWVcnzhjpehZ+n
         5KdZxh6jmeWtBFGcK1aIdBAFS9cCf3Z4TQqdkUKtcWQJlVfGB1LCOEpxgKGVCcjoiKi4
         B8mw==
X-Forwarded-Encrypted: i=1; AJvYcCURRGKbJwWghsJJgdaonHUWhoJNFVdezDIdOnDoD3U7LxOJ+Y2rE8Yf2V82A78m7rOaT/qSNaO4Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqkV6+peGkEgsC6fDyQIXpNbr0ucFu13ROckcrwWm4IlBg5f5f
	OTwga1BxGK7bXJgDqFylnh2t8H/iQ1l/DA+NVC8ITSOR1yA9l74Zxud0kmyoTFAjvPA=
X-Gm-Gg: ATEYQzwA/TK6k4oyW6hgtkfFBMIpxuwhXSSMc4vYop++vUclQx/0rfuvFEXj1UEm0ZN
	Dm9RGuwvloecGagZHGGEsNJfIgN1lULaVumY4syIDReYwTTwqNZegb5Os1veZlzXkyEi+9pZmU/
	ZS2gP5X1HRkZS11UECg0xuymiWiujKIbOAYf2f8npEQaA1wWU6IDrAmRaEf8NnlDofPyTZNFFy+
	0JQqF/UwJOQefuG+epbwp/Fob0ROVkPM6/IxYU5iWOTEsiStam5USirFDcwZoKT0cE5JmR5j2iS
	eUS2T0iDWXFVCkWpAuGlFOC6U4XYCvhtseP3bNZLGR60iO6kx2ZG/I7S5/HLOGv6EPkOQrLbaNb
	L9B9ybf9suKE3xNhQXhyMYnwQReFxBPFSqZ1+hfa3PP1qsnBDRz4nT9NARyty9kKxSYBT/t+bo6
	6jWeFcZmbBCCL4U4Dwq2bb6gqnZu/99HY=
X-Received: by 2002:a17:902:e5cf:b0:2ae:512b:eea9 with SMTP id d9443c01a7336-2aeae8932a2mr6152945ad.36.1773188390908;
        Tue, 10 Mar 2026 17:19:50 -0700 (PDT)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222ec3sm4843865ad.1.2026.03.10.17.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:19:50 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Tue, 10 Mar 2026 17:19:25 -0700
Subject: [PATCH 3/3] pmdomain: arm_scmi: add support for domain hierarchies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-topic-lpm-pmdomain-child-ids-v1-3-5361687a18ff@baylibre.com>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev-53144
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=SpNaRu6uMd8HuXBGwkIHZTjCWaD47krsvCZKz8R9UDw=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpsLUiDjI6WNZvQ23csmjtCDm2sG6My9oxiWgsj
 jofXq40XHKJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCabC1IgAKCRBZNxia0/vG
 ZQFQEACPB90DS6xyqHEHKzUMOrtuYJlGewKdEEMh/l5LQXY41rYLvJsbqdV5LCx66GdglEiD4NP
 6jeDqaJIiZpGIJbxgDgw8y8w6vwseR+NoC8YtF/UTEhOrwYCzp0xxdI9oo/WwIr+Z2zd0EBnVr+
 y8grEV9ktvw4lR6g1KIMnvqIw3kgbMkn4FwM4Oi5xfzdEvH6SB2E6A0ayo8TA4pNym6k8XEgNgD
 uJr8d1plI43iOLDyHoQXaRjzp2Hf+zqNtMDKQL2H6McB1m08HIeuxUU21z3xIci4gF4y0XXROJX
 fHsBHaeAECe8YOGRatDhLklxJqTGyerbGv8F6nNqa1fCsyBy3lX9GjMhcUsrKln1ODUbvCTQKR0
 aahV1rNojPIrZvK4RyS0Uxb79RJ9vDjDnggMs0e1EyE2oFG6moVl1tzla968Q5o28bk6jP1hrDH
 kKq64Jd+N7nZzEgls8sh9PnSajocfYaDG0ae1zxUTRND2nx4aWfRgACm8mC/PiWfdmz4RbQRAK6
 jmRP69B4LbXGNZ9uhBO3Lvcta53D1eCazu6HrlkDwYozWWJyLZmchRhLHkpHu1Q8VSOL8MS91Jo
 x9K50uoHLg8IkriC+0sLR6QTRfqAlIknTnzIVpYRj40VFQvP69cRTE3zxdR9UZPVLIvsGs3QVT8
 93oWglDypvxbtHg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

After primary SCMI pmdomain is created, use new of_genpd helper which
checks for child domain mappings defined in power-domains-child-ids.

Also remove any child domain mappings when SCMI domain is removed.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index b5e2ffd5ea64..9d8faef44aa9 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -114,6 +114,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 
 	dev_set_drvdata(dev, scmi_pd_data);
 
+	/*
+	 * Parse (optional) power-domains-child-ids property to
+	 * establish parent-child relationships
+	 */
+	ret = of_genpd_add_child_ids(np, scmi_pd_data);
+	if (ret < 0 && ret != -ENOENT)
+		pr_err("Failed to parse power-domains-child-ids for %pOF: %d\n", np, ret);
+
 	return 0;
 err_rm_genpds:
 	for (i = num_domains - 1; i >= 0; i--)
@@ -129,9 +137,13 @@ static void scmi_pm_domain_remove(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 
+	scmi_pd_data = dev_get_drvdata(dev);
+
+	/* Remove any parent-child relationships established at probe time */
+	of_genpd_remove_child_ids(np, scmi_pd_data);
+
 	of_genpd_del_provider(np);
 
-	scmi_pd_data = dev_get_drvdata(dev);
 	for (i = 0; i < scmi_pd_data->num_domains; i++) {
 		if (!scmi_pd_data->domains[i])
 			continue;

-- 
2.51.0

