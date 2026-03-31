Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF543C872F
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980185; cv=none; b=q6nbZVwpA87J+XdHEDPRkkc+9mWPFRzSzzG3sfLFgqoABe2A+x6BLhBk0lUNrN69lcq3X0HJTD+v/oVsv7TEX5uUp59MhnlRXTrqetFjldSKmr5YWOR6e9m91FUAI4isTtxoNU39hiM7FFSTKhjk9V4yi7VlQ7E0zRA4a9wWXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980185; c=relaxed/simple;
	bh=B9ZCzrVXGfIB9wKfnOJvE7KH2J4CfQIRWX4tlDtuWuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl8CGeD8KYOqPjHNI6qU95O89BLnZLpI37nKmWG4bPRneYetR66oKbuozfaK1zP+IwyndujOLuWRJtLtT69xA5KRRbe4/uLhXR5IM0HUpisR4iEKl1p5uomj5g96DxhBow9O8PK8W+65d3WYP51iBs05p8qcc5/pwlaMdCrGcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b=kj+kGMlm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b="kj+kGMlm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b258d93ffeso13390255ad.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20230601.gappssmtp.com; s=20230601; t=1774980184; x=1775584984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIPjhe0ooozuU4t14Rzg0U/ZHVJIieutYDq/fthQq0s=;
        b=kj+kGMlm03y1HiKirhlVuVIjsJ0fHDwu0fZdWQN1FSad08HGv6OX5ZqLBWouXhkpIY
         lnY2B3jQhW7XDrB8smc/69dTaHgiemRndUl5+Ua9x4gELYTcQ1C6QP+AiQxkTwfPuq5K
         qaOgTQQqXQMRl37GWFyrhAHMXO7Ga8f5y9WZqyBpTRdv+Jhhr+TvCHpD5jnnn1r1wM58
         RtAeZz4nQlwPJDmHf1E7+VSV7phVQ+aml6AzSB4G2xzZQSGf9M4dbyfh1lLtIIlOGRrJ
         fCWw3+/6zIEGZsJs56QJeOIEAZ9/yzCgmIYqgmk9fi9AZfHVV3tEhn5nlhMPQe+Maql8
         sMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980184; x=1775584984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIPjhe0ooozuU4t14Rzg0U/ZHVJIieutYDq/fthQq0s=;
        b=OCckqH7gnun6lEObBzICxTaqndVxHAEwuII7jDoXQYLf4ZR76+IrZE2MaCrv6/631B
         ze35zq74Z3e5H0qX6SC4bHZ4JY2CG3UR6o7vfYoGrI3qrGsciGNFyIjrYnsPVqROemYx
         dc7eTa0nLVTKbxqxW1Is98HBbiBAi+kgRTfoghQyRjH7ahaMq12iafbNBGU/CJ1CDv47
         FG/07uEriJqlGYxsI+XchlR9rydSTCr1jJ9Vw+7NytMKyoTizwkrmADI2jrLpus1ndZy
         mbJOe/0xqKBpS8UqZ++yxlqwdGTZ1SSEJ7ocgKUbvednZ+wZgjcY30BAwIWZPvwiLWFp
         fOPg==
X-Gm-Message-State: AOJu0YzKMXl49H3iqarlsYF92DQvwoG+ohFw1x2ktgjLgZLqiif+jSvw
	RY1CRqUFLUr66BFL09WVcv6pV3P6dgojcnIgYmyPSblatJMLy2+HhG8xX+4PjlqApUY=
X-Gm-Gg: ATEYQzyJUGgWLzFDjUJiwFiRM8c5r2PW6eHJoj2WQwpBGaRnsSF4HzGdPlv+ycVev1U
	VYnw6kAzmG8bZZKBcaSEPKc1UjawIP/iHOi15HeiKdRDbW0yYzqHEzbvr8fEdIHabCZwjuWbwl/
	+CFngO29lBz1oJWYJGu1tZ0+5zOpehiJp8wBK7cKtkW4cf47mdSYW2Chn/ebUSgKIgABaEwgG1W
	kkcNof7bmOSG/7AnNaO2bibFWLIC2NKk619U9cORpiXV7jsceanO8c3PGrnHmk4LG7bQLehUm3C
	3m/+kuR64T0GnBiHeCMaRa4QExP9kjLmSfmoH42AWGmv9UnVBu3fWNIEUQanmo9857haE7PCC2N
	Sone1W7X94MsdiBTIaI0pQAJDQoCbC/ynV4ob4TMjRZ8x60NFhmgWA8WQrYN3fEu89xPDCAHnBt
	LLCOFZKhT5aZnTEkZ1PdY29/IyJQ0UeVBwmG9NEsjSZWL3+7wOGATA+wKwRSxRIW9jN7N4Wf5eS
	bGmUw==
X-Received: by 2002:a17:902:ea05:b0:2b0:5548:7d84 with SMTP id d9443c01a7336-2b269cce951mr1369705ad.48.1774980183702;
        Tue, 31 Mar 2026 11:03:03 -0700 (PDT)
Received: from claude-dev.lan ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242680132sm125240315ad.32.2026.03.31.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:03:03 -0700 (PDT)
From: Daniel Bozeman <daniel@orb.net>
To: ulf.hansson@linaro.org,
	heiko@sntech.de
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Bozeman <daniel@orb.net>
Subject: [PATCH 2/2] pmdomain/rockchip: skip domains returning -EPROBE_DEFER
Date: Tue, 31 Mar 2026 18:02:23 +0000
Message-ID: <20260331180223.1682283-2-daniel@orb.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331180223.1682283-1-daniel@orb.net>
References: <20260331180223.1682283-1-daniel@orb.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iterating child nodes during probe, a single domain returning
-EPROBE_DEFER (e.g. due to clock dependencies not yet available)
causes the entire power domain controller to fail and tear down all
successfully registered domains.

This creates a window where devices in unrelated power domains that
would have registered successfully cannot access their hardware. On
RK3528, PD_GPU requires CRU clocks that may not be available yet,
but the idle-only domains (PD_RKVENC, PD_VO, PD_VPU) have no clock
requirements. When the controller fails due to PD_GPU, GPIO
controllers in PD_RKVENC become inaccessible, leading to synchronous
external aborts when GPIO-controlled regulators probe.

Skip domains that return -EPROBE_DEFER and continue registering the
rest. Skipped domains have NULL entries in the provider, causing
their consumers to receive -ENOENT and defer until available.

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Signed-off-by: Daniel Bozeman <daniel@orb.net>
---
 drivers/pmdomain/rockchip/pm-domains.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 2eecae092a..f42880c94f 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1077,6 +1077,11 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	for_each_available_child_of_node_scoped(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
+			if (error == -EPROBE_DEFER) {
+				dev_dbg(dev, "skipped node %pOFn, dependencies not yet available\n",
+					node);
+				continue;
+			}
 			dev_err(dev, "failed to handle node %pOFn: %d\n",
 				node, error);
 			goto err_out;
-- 
2.43.0

