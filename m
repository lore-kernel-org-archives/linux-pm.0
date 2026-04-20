Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB0397E91
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729089; cv=none; b=rg2/adC0TcKGDrXml0gEQ8CPeqNBOj8XbfsuhiSoozPVdUnrQV4NmGTIGOVtPO8FeugtoYU6B/D4QXJsd8bibGEV1+PI1kAb5E0qy0nAKxDhV2T8NPbYfT3Fx0GLcNWWmfDMHcX6IDsXoCdbBzbERia1TKYLZJotnjedbos6/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729089; c=relaxed/simple;
	bh=fQmK2/l/owONuV/KAsTohuLBlI/zxOSPwI6yoI7yexU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEAtAyy071aY7VH6XCg42y+qhuaVrRVxV0fk0bon1it90BKgxoNVK8asnVvz80y/oke5rt0mIyBZcVmbPD1JC+P6xLocyj9WG/VYpxth47QhsLJcZcvWkx36VbFEpQCfr6gueAQ8Kk7tDbyAZ6+PNCc7gXM8c6G+mAGLHDu9Ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=oIw5RRyu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oIw5RRyu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3591cc98871so1625578a91.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776729086; x=1777333886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLT3tpSwkvQ2Tt/V/NMhLxE2z8Vhzn3uRFvBt+UOKAM=;
        b=oIw5RRyuQCGzQNvGXnbBTnSR4HL5DoHvlTEVVDqWJBOJPRr6hAEbzeqkF96o5rEkmj
         g2x99e7pVYTnNDMuU7xd6hoM4+qujmxg45AXPHGX3TpwG7QoOoqrs7/bbZZ7BPDIOgvE
         7b1up6Ab2izgt5ZEVxQXLoVEaTcCdK170kT/drfopfqUlmwBwSw8Fv89n7p+ZGy4ZggP
         ViT1RS9XgKgPTnhKkr6eQTJFO7lwkMGQzNaKevNwraaVxIOs06H5mPbz6+HVEtNBnXw2
         hoKs2qHm0BRrKEhasNlBDmTkNYX32EPOanRIpByz9IRWE6yPlmyFKmwOjoLVTB8aggWs
         60mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729086; x=1777333886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qLT3tpSwkvQ2Tt/V/NMhLxE2z8Vhzn3uRFvBt+UOKAM=;
        b=kbFLj+0YavbOgIeBXAgGSjc5ZyHHMSEJphcygDMQuImaLJzxFbPu+JKMgBcRYB3AIw
         Jzwwe/4Da41KcPhwdQAi/OcdemyIR1fjdTDJf2ooEBuWKR6z2s6+PRQAeXVP5O4uOEXq
         3RB/CPD9M/oVK5U3fhcwvOfOhhO/wXb4lTNgDSDNkD+ONpiFqCzZCgFPDMer8iHuvst8
         EI2E+K48cNd+kpvVwbiJebaCq8+3aJEr5GsL8B4qy3r3urKKivqqH8jWOPXAv0FPiuJz
         DzoVWBiDIylXTFARhDzDEMawD8m4BOG07suOhFrA+paEcjC/OPHTwSF9U81zHYTnoSId
         L7aQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f5WU4meonAVOEw7AG+Mhhrx872leUhW1OqkFMLhmSnS4cMZc9+IOHmS9aEgrSVSPb4F/UpZko4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzuqMhW9HXYSjpALPI5Wead0bat+DZkfMo2k2TBSIHsjV9bQf
	/hmDyIKgf8SuD0UPYj+FcUYk1Bw1YtCZh+0GaL3Ine7MQhwpclRoccsRvhUwZwhPGJWlhgvZYcZ
	Xjj6UBo9tXg==
X-Gm-Gg: AeBDiesgMLXAXesAfKl7+jnjbqbdLQnHpDLR0R+EMjsPgscSZGa5e4wekY7DgO9tOPf
	HRL9DhcZ9P5NNkhHnLG0NxZ7nE/ATGGvSy4eeRJQL8AI9zBX6VZyS0onrFINMPV3J5hrvqRCAlI
	aLqUO9Ebo5wvwHbsYu92JPA0JEbwWrXokCrSK8xYX7Ez2r2Ns4SCnskJnqBxWNkcBlA9QfB0Nok
	XHzwtCQ2zckJdARI6LCqZDj2F4QATlGqln22vumERrm0UfOsczi2vazSQgCa6lrqpRNbStLGIMK
	jfv/rewXricx8uxg9aQugGvfB5fGEMM1AKLyZLiMcUwWa5AYa9FY1jTNY0ANueQ1lgc27wEG1mV
	QuuvKIBq+9X2xrNzd+T0uZtvhmqt09JeXfPg7ScZB/tucsjCkg+QorArClIAyAedvLkHJAwK5c+
	Z71W4eiWAVVWgPxkyYSMQmv5NNrGTmXw==
X-Received: by 2002:a17:90b:1804:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-361403c326fmr16049310a91.2.1776729086216;
        Mon, 20 Apr 2026 16:51:26 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141898ebasm11819562a91.7.2026.04.20.16.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:51:25 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Mon, 20 Apr 2026 16:51:19 -0700
Subject: [PATCH v3 3/3] pmdomain: arm_scmi: add support for domain
 hierarchies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-topic-lpm-pmdomain-child-ids-v3-3-c2c40bef238c@baylibre.com>
References: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
In-Reply-To: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=fQmK2/l/owONuV/KAsTohuLBlI/zxOSPwI6yoI7yexU=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBp5rv6y2OemQ05EvI6I9Eb7ji7vCtT8ygEexN59
 biCxvg2gTSJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaea7+gAKCRBZNxia0/vG
 ZWyAD/0d0/YBQizqrbUviBkwWp3DBYDrtv2ykMygkKlK5l5L3sb28ibT5WnM8ZKqh+t0KUia/iZ
 z1ZHFEHYVTHi9u+NXT0H10ur1LRQnWGt5fziPeyxaezbBY4YrI/MerMp3WyJ9xuVPRWOA1hbbii
 HvTXoszaQQsEngTIMXMz4v/+a9W8NcOWYD3awqyH1Dbr8aSno7skX2VyScGvFIBeCHo4PMfqx3f
 rYbFgy28uknIGuOkg/CWTwjojLRtghphUiE9bfW2083x15l6bhlcvg4eTAFL/IkzQmd/pUPLzKD
 Ww8WkE+0rrAvtEh0o/UMFr89T19zGcyPaCKJXBSa+7AhimyFta28Iz7x1mInWwrkSSv7rwQDxi5
 K70tevOBPa/T5RgkyteJfwHSKMTpUsi3qz5YYV41r0+VFVzBuklBnQmgVAgDpA3sAhBiVM8zPgo
 dDLB094XaZa/Zr8ZtRa5EauOf+LM04uLX648SRJMw1HgO0E4qYU5qiW1axHnL+aQb9j63RHEoZP
 zgzU71AQBfc+RsWUukD2frkeinl9TgSa7UgMVrb4fjd9t6AH1K0NDThwQUdogfzqM5wHV+uUbya
 ImAuPuowMRCnwI57qIk42BJJJk7hBurgdH9Q9kP0yP0yj+37ivwb/NruZSiW/vU0XrsFBVln7C6
 HLUBmgLhKNszwiw==
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
index b5e2ffd5ea64..66dcf2e687a8 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -114,6 +114,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 
 	dev_set_drvdata(dev, scmi_pd_data);
 
+	/*
+	 * Parse (optional) power-domains-child-ids property to
+	 * establish parent-child relationships
+	 */
+	ret = of_genpd_add_child_ids(np, scmi_pd_data);
+	if (ret < 0)
+		dev_err(dev, "Failed to add child domain hierarchy: %d\n", ret);
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

