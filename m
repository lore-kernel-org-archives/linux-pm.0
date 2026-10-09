Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4B3A9632
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565042; cv=none; b=QtL1TZVDgL43jv29Uay5A/KtAPoT7GkP6QJf8yv1nlZeyRUiZbkjbENcgK9f2a4ykGWagxF705guVuoRDtlTrH2eE4pGzS/XXBrfGMGXrpFgKnFLApdB0O72Z0uvMGBJSKceIG3a/7mjtdmIzNeer2R01gZZDVFFYTlGxM4joQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565042; c=relaxed/simple;
	bh=lsKw8BUqB2i8PlWaeh2lm5BE6pBBcN0QCDBp7cwoE6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ4PrufpvjKAzRnRfP5zbX24ZmF6J3Ou9wEdsMchklYk6oPnq4zEqUB7XY54PDMLeJM/KvLq3CI5HLaG9WUXnb7kfRe9n19sMdAt0cORl6LGfYPADNVcBBuxRJ1PMuLXbLYpTM5RIXwQblRGw+LqE6YU0xuFwaYU2nNt69A9ijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGzxMH9q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGzxMH9q"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so961825e9.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565039; x=1792169839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbt4JRGi2yyrIpxHVLcBe+EosGZVPWi/jFn4uBQ1NNo=;
        b=EGzxMH9qHhoOVFolss3DVPRDHRU5SBAK9ET7t0fHsuF+vsKKcLQsQF1kr2z9BJJMC3
         O5UoyWAlczIWjDAPKji3cHuIvyAlkW29bhYOEs8qWNQ3eRBG4ca17/Sq0xafu706xmc7
         p+dG3hK7N00B6ve4DfhV7/n06qHwxd5Y1nt4NeHR4XcW3qNdzJLCbTYvu6P73IaYZhUO
         1x6ugbc7aYVavf+pUUeSFnT3FuWtJyBu93NCirA5dOKyNYKiF2EMqdInSxmmmp8cykrz
         EpKABnJ3VdWfai48W2P6fmUOW+qQEGCDpnMo6YbPw9EofBOB1yVuEPVyWpF5/YknpWrB
         GutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565039; x=1792169839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbt4JRGi2yyrIpxHVLcBe+EosGZVPWi/jFn4uBQ1NNo=;
        b=gBnij7sQoDhqlTF57LmCVxeBUB31oGfIpVHEL54hTphYbLdp1gVDoDa1CyEriFQRJ3
         EX9bm9nqdLHVrriJhQs8Jx8TAARYSRtb3bZLRulHbWOk5osetKQQysd2e8a6Mh2GFyVs
         pJM9E10eL7JtJzxyEfYzGCV9qJBR6Ij7KN/Ud9RFG/E67ONaF/JkpEuiRI67zrRATXQh
         Yq4m1+L1I1DSSg5LGzss2UNFuSmoLHN6XSovRSWrcZcezdFODjhrC69Av9BV6CKDxZea
         DJ0PwYcFv+conjRiZyOF1P7GMczT6IRDEvmcG2bbEN1/E03vVw7PWJiP2Z7WaW3m6N+2
         MzaA==
X-Gm-Message-State: AFuF++nFhsrh8WGeC+KgaBa+YjWdSZgEWn3JzJY+Y0LtH5uZXRZ+P32I
	rFiBkpKHp9yV7VJWyujCkQz5jf8UnyUlCcE8UuIhTix8dC7BoFshgCUT
X-Gm-Gg: AYBFou2ZcPQv1CGAH5aoqCUvP4aKgyGpbAsvleHg/HmwZmv7lT+xjdII1oEgN9qpDSh
	6U3/V8exnzBlYFEywqxkIWral8bCbIOkhV1DmUYsQuG5vu9KEZ5AEUpdiHQUKEmxKxKqtH/KxQp
	QU2niG0+mfckOLtlfGHBYXo72r2PfN2AdeJVxnjUkwWmX85P3UTpBQTc15gbdg0PiwyR/Rcu1ej
	fm62m5mY9DfrI6MmoZId/JGieWC8vLJ5YPVdMAOW78q6k+CET1vk+oL44yjqPjThtiD7rN7gKPS
	MkFKoaCpoG5mKlZPEw5zJp57o56HkqSIxY7n04H3KD0j5zJ/biHBr/vHRd9PfrNDSnvJH6bBfni
	m6Gzpmgs6fLzdcHGGbid2m0VzQebfxOUV7mqC2G8bZXL6jz6T+HRmF9DTuEoE9qUgA5HaYaUiJ7
	RrWUMZktlpP/NGvPNCQVeOb5F82Te6ZAxB3bub0CKVfmLGhKaTK5XZgMVS4fZKh/halFqTJ+W6j
	BhRuhwDysCZKw8X3bu305rflS47urHcOLLJRuvu+GXBfzxwHuNlpZj9YDKTcQz354ie/ZxLFP1k
	o0s/otzDi+KqExEDWw==
X-Received: by 2002:a05:600c:154b:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-4a18e4d0be2mr49995535e9.23.1791565038895;
        Fri, 09 Oct 2026 09:57:18 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf1358asm70667395e9.4.2026.10.09.09.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:57:18 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/5] soc: renesas: rz-sysc: Make power sequencer auxiliary device name SoC specific
Date: Fri,  9 Oct 2026 17:57:06 +0100
Message-ID: <20261009165710.1320233-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The SYS driver currently creates the power sequencer auxiliary device with
a hard-coded name, which prevents SoCs with different power sequencer
configurations from selecting their own targets and consumer match
callback.

Make the auxiliary device name part of the SoC-specific initialization
data and use it when creating the auxiliary device. Set the existing
RZ/G3L configuration to "pwrseq-pwrrdy".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change
---
 drivers/soc/renesas/r9a08g046-sysc.c | 1 +
 drivers/soc/renesas/rz-sysc.c        | 6 ++++--
 drivers/soc/renesas/rz-sysc.h        | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/r9a08g046-sysc.c b/drivers/soc/renesas/r9a08g046-sysc.c
index cd129c727461..4faaa511f41b 100644
--- a/drivers/soc/renesas/r9a08g046-sysc.c
+++ b/drivers/soc/renesas/r9a08g046-sysc.c
@@ -77,6 +77,7 @@ static const struct rz_sysc_soc_id_init_data rzg3l_sysc_soc_id_init_data __initc
 	.revision_mask = GENMASK(31, 28),
 	.specific_id_mask = GENMASK(27, 0),
 	.pwrrdy_pwrseq = true,
+	.pwrseq_aux_devname = "pwrseq-pwrrdy",
 };
 
 const struct rz_sysc_init_data rzg3l_sysc_init_data __initconst = {
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 0e92c415d4be..05f04dd3c94e 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -107,6 +107,7 @@ MODULE_DEVICE_TABLE(of, rz_sysc_match);
 
 static int rz_sysc_probe(struct platform_device *pdev)
 {
+	const struct rz_sysc_soc_id_init_data *soc_data;
 	const struct rz_sysc_init_data *data;
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
@@ -150,8 +151,9 @@ static int rz_sysc_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	if (data->soc_id_init_data->pwrrdy_pwrseq &&
-	    !devm_auxiliary_device_create(dev, "pwrseq-pwrrdy", regmap))
+	soc_data = data->soc_id_init_data;
+	if (soc_data->pwrrdy_pwrseq &&
+	    !devm_auxiliary_device_create(dev, soc_data->pwrseq_aux_devname, regmap))
 		return -ENODEV;
 
 	return of_syscon_register_regmap(dev->of_node, regmap);
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index e55f3258d703..b9665071cf4e 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -21,6 +21,7 @@
  * @specific_id_mask: SYSC SoC ID specific ID mask
  * @print_id: print SoC-specific extended device identification
  * @pwrrdy_pwrseq: has pwrrdy register controlled through power sequencer
+ * @pwrseq_aux_devname: Auxiliary device name associated with the SoC
  */
 struct rz_sysc_soc_id_init_data {
 	const char * const family;
@@ -31,6 +32,7 @@ struct rz_sysc_soc_id_init_data {
 	void (*print_id)(struct device *dev, void __iomem *sysc_base,
 			 struct soc_device_attribute *soc_dev_attr);
 	bool pwrrdy_pwrseq;
+	const char * const pwrseq_aux_devname;
 };
 
 /**
-- 
2.55.0

