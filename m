Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE2521209
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684680; cv=none; b=bNGlRIPQKjKkBh4uOlaidTMpt6/fxUcsEPVffgEQylhd3Q3QsIu26Zxne1Y4J659XBycA4/zYVQqpFBmN9bWPsQ/Ju1O0z/XCs9B/uaRCgL2ACuUaNrgUpGreFbdl8GxNnmFlw3aCRD2GxOv7wrO2eaSAZ7iZAEyLs8CoHJH8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684680; c=relaxed/simple;
	bh=JlyOw9DGPHnSjjaPGb0zqrgG9wqYAzgLkSlSJnHAR1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DreBQEvlcUbOPQgwQOewxxB6106QU+dukyQV8i2dgcbsMlU3SCaaMRf+yHO7d2nxO2d57xtICi0DBWf20QNNVEd3kDA4/tnxYUQdNsCUcRNrE1AWdW8RVVCViPQ823rcX3XS9voRFZUti+HEtzg1vsXXy3VJ+egF4q3wo48Dro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoBm3VAV; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoBm3VAV"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af5ae31d8so403541f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684663; x=1791289463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3vYW6dQLOi+5ceojdiqFpK8deIsCHfj4Q4dxj+3HOo=;
        b=JoBm3VAVgumG+wxijO7HQAOWEgODOQXRZKzNlFxV522mPglXDx0eUx6eS88cJx1/jY
         y6wfG60+5x+84YcdcSOsUO1CNPLOhnMgjrLDgx5jK6UxD2rX20Mr/eYx8nnf/isZsJQX
         USTWdB3I0Jrb1tq75cvzScYe+qUwE7F45ctQrF2ffOR8JwF+NUcK8/kgrBh7ByRXjfWX
         N2ghAH94YLOvrxBks6H1taZZ2V0wCPw+jY2PAeGWR63Mbqjm50iWAgfD4sbg0SleDKfw
         z3Vg5UDvBQt/m0tBwaZuy9dWjiqxPUPmJrlc5wJqIC2qS+lKRawxPXQInWq1M40EVk+r
         gVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684663; x=1791289463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m3vYW6dQLOi+5ceojdiqFpK8deIsCHfj4Q4dxj+3HOo=;
        b=c3oIDHkj1V5qjQDvdzfNJK/TfDVEQqHjxhRLieqFmQ3YRMJ4VYGx4wWGsmbZHNzzfJ
         gVWFG7otIvup8XiXJcttnnNDSUQ/mRuu56YCNi9OKI9I1nN3gGNiiSJSUYJ87lWO5v2N
         ta/lTyujcW7vdVOs2ypOcfcg+IjEKUpXBaePGuCrYEfXd+xwnDmMBuXu3QzajWQUmIhd
         89AiDtMXs4Q5itlX2Loouam5CWmnUhLxVsw+H8xVSAclN3PxfUCrug33m3IfybhZC/6L
         p5zy6EEzk8w2Xb9WXSfeysxASV6t3vnii9tYrhbjgM+d9HFsKNfgzsJPHiJQ5u0Z2LaC
         PMYg==
X-Gm-Message-State: AFuF++lE5QTpBvB/z7jTQ88RdgIdznsxVrwCzEVC973/FaytD6oCOZLe
	LR4+8s57WeYYdfKQu4zQRs6XrfeGFUqqCs0OlkiY/nECTsQLbzku6Fgr
X-Gm-Gg: AYBFou23wi/aAhlY5pXkolsQmKqUF5dgO5BUM90RsksmTZUi/69U1umZrxbOtEzOpUD
	ZWkuW8T3merDTyb7E4CQn+yOPpI5U1XznoRqgcbPkVtpWlzd5sspggTfugUKr5fkcKWekzf6YfY
	ZOkxqeY5lmz8TK/AxKzhv+swWF4uTQXJXGitd+vJdaFWG/IzirxLjr9R5sJllf2FCz9r3WdFIrI
	ExrjIVDJf8duZb3RgVI0C0Su4lArFSbYUrZz5gfKsOAyONhKOY117cA+i5oQpJhDsaYrFWuuJ6u
	GSXD1KB4uK+RH/DvTEQ8x3G0fQMHCgIpZ+USbpW8cfmMsBYYiF0UxQi2La1YpYKujjdqb/BehIL
	9pdXTPAV68ToYPtvhCjNjd6gYEdV17Mqq2uJm0wKLRKMNOL4eFYbGy2efDEEwsn36izooAslFMO
	FZYdRju8D4iviabT74GsbTiWVtoqDq/9rRO/crXq4Dgz25PmsWd7BteYz3O2Yym61YxWd/2ZDK6
	nNYJNF+pvthWmXWLDVbRk2mup+sdstbAWKFPJJsZcWEX+z+aa7b5I/u0i/NGFfqzA0VXHmlOLFt
	jcvigL+Eox9ekl3N29o=
X-Received: by 2002:a05:600c:198a:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49fe66d2d24mr288319655e9.10.1790684663304;
        Tue, 29 Sep 2026 05:24:23 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfafa23sm70994965e9.14.2026.09.29.05.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:24:22 -0700 (PDT)
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
Subject: [PATCH 4/5] power: sequencing: renesas-pwrrdy: Add RZ/V2H(P) and RZ/V2N A/D converter support
Date: Tue, 29 Sep 2026 13:24:06 +0100
Message-ID: <20260929122407.219448-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On RZ/V2H(P) and RZ/V2N, the SYS_ADC_CFG.SY_MSTP_ADA bit controls
A/D converter power-down. RZ/V2H(P) has a single A/D converter unit,
while RZ/V2N has three units sharing the same bit.

Add an "adc" power sequencing target for these SoCs and match it to the
RZ/V2H(P) ADC compatible, which is also used as the fallback compatible
by RZ/V2N.

Clear SY_MSTP_ADA when the first A/D converter unit is enabled and set it
again when the last unit is disabled. Wait 20 us after clearing the bit
before allowing conversion to start, ensuring ADCLK has been running for
the required time.

Bind the power sequencer to the RZ/V2H(P) and RZ/V2N auxiliary devices
created by the SYS driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
index 0190e53913bf..ab20b7ba9b83 100644
--- a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
+++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pwrseq/provider.h>
@@ -15,11 +16,68 @@
 #define SYS_PWRRDY_N_DSI_MASK	BIT(1)
 #define SYS_PWRRDY_N_CSI_MASK	BIT(2)
 
+#define RZV2H_SYS_ADC_CFG		0x1600
+#define RZV2H_SYS_ADC_CFG_SY_MSTP_ADA	BIT(0)
+/* Minimum time with ADCLK running after leaving power-down mode */
+#define RZV2H_ADC_POWER_UP_US		20
+
 struct pwrseq_rz_info {
 	int (*probe)(struct auxiliary_device *adev,
 		     const struct auxiliary_device_id *id);
 };
 
+static int pwrseq_rzv2h_adc_enable(struct pwrseq_device *pwrseq)
+{
+	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = regmap_clear_bits(regmap, RZV2H_SYS_ADC_CFG,
+				RZV2H_SYS_ADC_CFG_SY_MSTP_ADA);
+	if (ret)
+		return ret;
+
+	fsleep(RZV2H_ADC_POWER_UP_US);
+
+	return 0;
+}
+
+static int pwrseq_rzv2h_adc_disable(struct pwrseq_device *pwrseq)
+{
+	struct regmap *regmap = pwrseq_device_get_drvdata(pwrseq);
+
+	return regmap_set_bits(regmap, RZV2H_SYS_ADC_CFG,
+			       RZV2H_SYS_ADC_CFG_SY_MSTP_ADA);
+}
+
+static const struct pwrseq_unit_data pwrseq_rzv2h_adc_unit = {
+	.name = "adc-power-sequence",
+	.enable = pwrseq_rzv2h_adc_enable,
+	.disable = pwrseq_rzv2h_adc_disable,
+};
+
+static const struct pwrseq_target_data pwrseq_rzv2h_adc_target = {
+	.name = "adc-power",
+	.unit = &pwrseq_rzv2h_adc_unit,
+};
+
+static const struct pwrseq_target_data *pwrseq_rzv2h_targets[] = {
+	&pwrseq_rzv2h_adc_target,
+	NULL
+};
+
+static const char * const pwrseq_rzv2h_compats[] = {
+	"renesas,r9a09g057-adc",
+	NULL
+};
+
+static int pwrseq_rzv2h_match(struct pwrseq_device *pwrseq, struct device *dev)
+{
+	if (of_device_compatible_match(dev->of_node, pwrseq_rzv2h_compats))
+		return PWRSEQ_MATCH_OK;
+
+	return PWRSEQ_NO_MATCH;
+}
+
 static int pwrseq_rzg3l_set_pwrrdy(struct pwrseq_device *pwrseq, u32 mask,
 				   bool val)
 {
@@ -127,6 +185,20 @@ static int pwrseq_rzg3l_pwrrdy_probe(struct auxiliary_device *adev,
 	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&adev->dev, &config));
 }
 
+static int pwrseq_rzv2h_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct pwrseq_config config = {
+		.parent = &adev->dev,
+		.owner = THIS_MODULE,
+		.drvdata = adev->dev.platform_data,
+		.match = pwrseq_rzv2h_match,
+		.targets = pwrseq_rzv2h_targets,
+	};
+
+	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&adev->dev, &config));
+}
+
 static int pwrseq_pwrrdy_probe_common(struct auxiliary_device *adev,
 				      const struct auxiliary_device_id *id)
 {
@@ -140,7 +212,19 @@ static const struct pwrseq_rz_info pwrseq_rzg3l_info = {
 	.probe = pwrseq_rzg3l_pwrrdy_probe,
 };
 
+static const struct pwrseq_rz_info pwrseq_rzv2h_info = {
+	.probe = pwrseq_rzv2h_probe,
+};
+
 static const struct auxiliary_device_id pwrseq_rzg3l_pwrrdy_id_table[] = {
+	{
+		.name = "rz_sysc.r9a09g056-pwrseq",
+		.driver_data = (kernel_ulong_t)&pwrseq_rzv2h_info,
+	},
+	{
+		.name = "rz_sysc.r9a09g057-pwrseq",
+		.driver_data = (kernel_ulong_t)&pwrseq_rzv2h_info,
+	},
 	{
 		.name = "rz_sysc.pwrseq-pwrrdy",
 		.driver_data = (kernel_ulong_t)&pwrseq_rzg3l_info,
-- 
2.55.0

