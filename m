Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD86521229
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684672; cv=none; b=YSWBT4DFCt237xG4CvgC3QhNKMfxIaAuswWwjluXo4rjyHyl7HNwN5FPXwOoO3ESXXEY9+PnkHDiskgMdo7unawpkvZk90FOrrDlEEBo4QEQQ9VSTntIlxaoKugbevMOBNHc3EOU6lAkbp95BlNEutHTVbP6ImNRX/XTBkk4zAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684672; c=relaxed/simple;
	bh=klliFeEnRQZLWTIC4qs4JaCZZyn/hDNdLhHNIOSmZmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iklOKTknKwXGK0JeQy6NBKuzlVVv4Ra1jTWC9/e+BeJKJhg9CCaISD/my/+uk4c4l+/4vkkDuuV9P8uFfTwYBI9PjtuO3s58K/+vuwgZ9Tcn+Z3XJZrzMI5LQRxY9dUri6oiBQiSkx0aU0h0D96j4TaUlYk1XqEiDPrKBhRwyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVgKVF/R; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVgKVF/R"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso38929095e9.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684661; x=1791289461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJQJi4IqTYZXw8CF+zYbANq1w7x4nlUvMQXniMYyrjg=;
        b=mVgKVF/RG8ifIiq8McXgL2KJWHTC2xd4pmDOcfaYfsk3mhcxsa0X8YNRRUpJJQA5lp
         NQ593lI470ahuqBQAnNoSmOt30tj6rqZK5l8K1zA1wkeJEChA681x4xc1nEfDPy5j1bO
         m1JLM+SjbIEYk1/bTadJZILJ3tk2KTmcoZpO6GvwtAkeH0fkjY8uQPIuklHL3AoZXLz9
         PzvQZpkmQduMut1wwE981GqxP+V0CO8/mWsTbNjtv/ZsfER1lyYGrDfbOEhtf8/Uib4I
         37WBGMA57id52hyQUtKV4on0hQzTPh9Nw3NWvi6/OH/oj9lTuPGRkw6EnCxunmRq2dsM
         w4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684661; x=1791289461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJQJi4IqTYZXw8CF+zYbANq1w7x4nlUvMQXniMYyrjg=;
        b=jETrbD5PPnbmajkvQdfaFRl55tu+qGhjxnU2ZquGjAATtsraFj2HdeAnhhB7xuziDn
         eCeYRMw2n9Xxt9rnRauQwh/a0yoRiAqpORmfCpgijvxs6QjpORb5poFVZtBxiYzdWNpy
         9tKeXWj7znq7ZetK9/ueWBe15VgU6oE5CClJAL9+5aJiyXyJgWgws/HdkNkYHStNDdme
         +wo0FMZ3rGr64GfT78SkvoYXBhl3yaWP42xczwTWgFEP4wmM7voyXSOrY/1iPr+8FYdc
         nQzDkJMA+7FeWIZ4t9jXE3H7d22dsaOtrZosnYWFhxygerbcrmYzC80dA5gDIxfe+GIi
         Ghvw==
X-Gm-Message-State: AFuF++kEYWhDkVIcOm3ufaBt/iIqR7QtdB6Z1aIB6jM3++utayTuR+3U
	1kh6mX+TifBoPVHtNUAQ2c4OqSdvoP02VHC2a6ltviqYKfXFn8lAprn2
X-Gm-Gg: AYBFou2GKSMZ6YYtSZA9gb9px7KXFvOnQhViOLA/IzbaPgQSWoTl16cwGQL6s1XHdwt
	g/z8GHq/vTH1mmdMT+A88bSbBQ9MUNkAMfvGLbkq7FiHQKlaxaDbSA3cxU/rIqkDQa2HidzcASI
	ysD3uQJBq3U5A3+jZcXPfcog4W16ar+7p2XWpQP8HgYAz45yE6GXl1ocuqT8BQ+RoUMjyLmmHbS
	vK7aJxPM4jEIii5DGDUhl5bPdkUow4yAPuEgOV7Hc6I/kSjgf/hyhOuNjjZgqwS/2UFk5lk2rxf
	HhapBPvO9wZmTqIkh1TncGIaiE9dYZFW0ASvrwCHSt4JPRWlQubbDyW9HpIuI6ST2LQGOe+l7l6
	BmqgGiF1BNPUwKKymNU261NO8AGb6hLBxGUEml4XhxgKEX+rwjDboMWOaE9bDVlTDifqvSSibcc
	uwAbkcla/JeD1qK7D+1Y8kXghdDQOiGS5abnF++bOW8CuB985rOsKDIvh8bOUB/m1aOtLUcTmjB
	oSuqKkJfCc6GgCUEJScenv9J6XIVONQB1KAAnOsbnaBUSfCD648oZPE7U5gSI9LzcuKXqT9r99v
	UttovwJ0WhJVQYYXNw==
X-Received: by 2002:a05:600c:4eca:b0:49d:2450:68ac with SMTP id 5b1f17b1804b1-49fe66caac9mr297292175e9.5.1790684661199;
        Tue, 29 Sep 2026 05:24:21 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfafa23sm70994965e9.14.2026.09.29.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:24:20 -0700 (PDT)
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
Subject: [PATCH 1/5] soc: renesas: rz-sysc: Make power sequencer auxiliary device name SoC specific
Date: Tue, 29 Sep 2026 13:24:03 +0100
Message-ID: <20260929122407.219448-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

