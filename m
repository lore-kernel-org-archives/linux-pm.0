Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0383B7B93
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565044; cv=none; b=oZak0/5D42ZDquQRDUwrvAnzTRxwlZpbHR8/qDEvC1hZG5diz0yu4k5h8jDJgbdHMgPMBG1eKApfreFP6jBxKetahlc6MBMrh1TBUYGwLbfAb8lC7+Rpc7rJ08aqmRZaYHVfxfYxlSK4TIIvAB5SWyMXfnS36UJd+nu5DMemg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565044; c=relaxed/simple;
	bh=0Ms2Ce1jxsdv/q82egBBcwdKWoMGW3+m80IgSNWXrmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZelnnUe2owdo/IfLm9iT4g9gDEaUcOxIyobe67HlCd51Ky2yAjRt8Y3IAQCq6ns9zNc5M4kD0gvCtCvkntLzNNh0JuiO2DZPTxYu5TG9kpF4zYY8oV6I8RJMeqq47YWXiQXIlt5+6KOvuFk+ZDRTM2IiHXL8Gn0qXGQRA4SSJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOO+Jfyw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOO+Jfyw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so796455e9.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565041; x=1792169841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkUVfSEq2h6YekNsdchzA/EZsTYtJJcojYRbIdHEgaE=;
        b=pOO+JfywURQGZ0BqDCDYnHNwAWzujYZp3m7mRTbfCXkUcNaktDZckTMqXx/JzSHXUw
         ZRxrarcwUexxw05MLhZcfn9/Exx3NMg47UTWDVseuQkeSo7YROcrp2BWV7fxVuI+cROA
         gB9Er6f/IHPmAKbA/LU2jnpGqEgaG6hsKSMFjiUjrwb0m09nlR8oLPvfXd6vsjLDNOZu
         +b47NpcNl0x/YwPvVYtXNtqHgiJ5pOe5yZhvhNxzxj98D7Ap5EWn0UhGZMjXgfswUDka
         +zAoyc+87+Buchr0ilgN4u2c8V/l9OX8m6E/04Xs7ZXGm+XFLSH1w5OFRgOEQPLZpX93
         3vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565041; x=1792169841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkUVfSEq2h6YekNsdchzA/EZsTYtJJcojYRbIdHEgaE=;
        b=eUIOQnAPcGPbqXw9jPI9jA2kIIa5dvqHmCksUT1iGvMqMeaYgLokaTMxhXozY77Bk1
         2NM+6eK+2+1XeTQUpApcth7wijNIi9YpWrASOQM6uaqHk/yL33j7HWq4S7ruS9E8WmYA
         ItRF5lPq1saK3kLEeFrBpXv7YUqKDzYo5RIHGht9VNz0tjDiH+NK5RFZN4uS/xDZLxIs
         ZLFCfYEssCnwgLSvMo+EH6Qn4yrSOd4UJtsy92/HF/wznTOFACPj3VxwDQ+F5YN1hPHS
         oLn/g96KJDp76K/SB9lNDM89s2WrPKKNHSas/HF/2aDptXkSJHMKd67SHQjkDyQKNmTN
         oY5w==
X-Gm-Message-State: AFuF++l+9mP0NZfksAGJ4pv0CI9JZiS2mh1kTfV0JDT+9CIvIlePF+Oc
	sCgPRcmHM/1m91cKkXkH7V4tCIowEPeYEukl6ZGcoCBCyJkBXBErIpsn
X-Gm-Gg: AYBFou3F55hv9Ne+2tTCdOxhfoFifrD9120dGaVHXxuCyQb1Y344j3f7dNnmCk36tZ4
	gbkyYYBQVu/fV1pN3hoSgiE8qe7ekmx9j5/N0aeLYeEM4UEjuUHfxx2LlezeygRc1flDXzSB2AC
	3+MbT5cRNQDxZstWB/XbgZYkFXAFiSQU67Z9pMrK9k3kgvlXMBNK76Do1AWKwzpydQDQw2dGdlU
	43ef6nQPbH7ipVHzK12XN8B1R46ryZTeqLq4DInXYA/t7LehkcOKZdowsvpJROb3wap8Q8P/jNB
	5e1205va+GTuv7PiBGaDTvPNFwFNJGauAGEvBQq167IP6qzU8t6EbCnvBLii8L6+HV5/H7pS3DG
	n1NCOpdjkjN/y7NPMGgzTizPmwII+dgy+5QaHcDeE5jvgdNdLNH+RESkoCficBqdJCNGineGHqs
	M+hvM6+WlSvR/ojGZVxfj0f+wElcKmMDef3wWeYNIg2yfDCNLTjuyPZpSeRn9g5uFV2ZDPTYQTg
	mhhjQZSHjGmkgKdnjH4+i269Pl8/4sAIXW5BH1x5aQfAHIyTkc9Te2f97KM+QmPbDUwbKNKoLHM
	yChSyEnaHn10/4ViWcwLBHjd4BRi7Q==
X-Received: by 2002:a05:600c:3488:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a18e4b8028mr51196765e9.17.1791565041351;
        Fri, 09 Oct 2026 09:57:21 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf1358asm70667395e9.4.2026.10.09.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:57:20 -0700 (PDT)
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
Subject: [PATCH v2 3/5] power: sequencing: renesas-pwrrdy: Support SoC-specific probe configuration
Date: Fri,  9 Oct 2026 17:57:08 +0100
Message-ID: <20261009165710.1320233-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Allow the Renesas power sequencer driver to support SoCs with different
power sequencing requirements. While the existing implementation handles
RZ/G3L PWRRDY signals, other SoCs use the SYS block to control different
power states, such as the ADC power-down control on RZ/V2H(P) and RZ/V2N.

Introduce a SoC-specific information structure to provide the power
sequencer targets and consumer matching callback. Pass this information
through the auxiliary device ID table's driver_data and use it to
configure the power sequencer during probe.

This allows support for additional SoCs without duplicating the common
probe logic.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Passed targets and match pointer info as part of OF data
  instead of prober pointer to keep probe common.
---
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
index 743855620501..158ee5c6432d 100644
--- a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
+++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
@@ -15,6 +15,11 @@
 #define SYS_PWRRDY_N_DSI_MASK	BIT(1)
 #define SYS_PWRRDY_N_CSI_MASK	BIT(2)
 
+struct pwrseq_rz_info {
+	const struct pwrseq_target_data **targets;
+	pwrseq_match_func match;
+};
+
 static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask,
 				   bool val)
 {
@@ -111,19 +116,28 @@ static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
 static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
 				     const struct auxiliary_device_id *id)
 {
+	const struct pwrseq_rz_info *info = (const struct pwrseq_rz_info *)id->driver_data;
 	struct pwrseq_config config = {
 		.parent = &adev->dev,
 		.owner = THIS_MODULE,
 		.drvdata = adev->dev.platform_data,
-		.match = pwrseq_rzg3l_pwrrdy_match,
-		.targets = pwrseq_rzg3l_pwrrdy_targets,
+		.match = info->match,
+		.targets = info->targets,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&adev->dev, &config));
 }
 
+static const struct pwrseq_rz_info pwrseq_rzg3l_info = {
+	.targets = pwrseq_rzg3l_pwrrdy_targets,
+	.match = pwrseq_rzg3l_pwrrdy_match,
+};
+
 static const struct auxiliary_device_id pwrseq_rzg3l_pwrrdy_id_table[] = {
-	{ .name = "rz_sysc.pwrseq-pwrrdy" },
+	{
+		.name = "rz_sysc.pwrseq-pwrrdy",
+		.driver_data = (kernel_ulong_t)&pwrseq_rzg3l_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, pwrseq_rzg3l_pwrrdy_id_table);
-- 
2.55.0

