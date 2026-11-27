Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793342;
	b=DQ9jCR39ApTH4QH/iiyH3AAfr/cKUQG7MdjO3JV48CZJGdkCpp949+u/3updf3xzNJUk
	 ksXHmryoGQnJLniG/PHUcJffjerMS1mZPt3w7j8V7oWjg3JtI/iEus+yGbsznTRK1PISs
	 yBOwWy00taWmgDwHS6Z9DUO1Q2wmv5s7r6bTxnxIxowRJpRsoftWJAQhPgRQvX92asMa2
	 nrQ6gBcqHPr35mt9Evy07SSf0LbR0gfbEK5ugkAfTsRj9mK3HSO0Dkyw2bBstUlXmhcKF
	 /mBRQtMmap363r7K2qmODJWwKnTUFRTXDbvsXRdDibvZPQi/x09mRdE/lz/T63/udJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793342;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	b=zU2kAPvMHEueFtT7pNSKAFR2VXpQAAUCaDgUZtJ80ilXSylo/ElN9xTN8I/MnlotkmFp
	 +gnJhXSW/yB72tw5hwNaNbcBH86RJ5eXXAfsOiJXcKyMW3glmz50Ku76O3tJ5OCSpGH9s
	 GYm80YJxp4wglZJMhIbKMXxplMRe2Cw8QhIjJ9I7OB0CEJ7CwwoqCrds5zMvpjEWZBAkz
	 i/xrvwrJt/Df84L12xawVB1uCwu7u2Mw1pH4Mqj+qz0wHqsLkN9zwPkNu7hveYr448fOg
	 Lj7LNkDKR3M2TZpS77zPGQnK5w33lkYnQ1ylSLuvdk1ZcsMU3+8Ca4YEGOQ+ncEzY+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0h59hDe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81914606A6B2;
	Fri, 27 Nov 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0h59hDe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793341;
	b=itMu9fLDQxUBfOsUGomLfMEW5mrzEds2Up+R2kkdRUcJZQI4795KTITgXS+CofYDV3y6
	 jl/DBlrbL0vdMkTw5ST7vhgBdVctXI/uuvs9uUQPuBSwoEi0mq1HefhmgosrplV4ANpSY
	 radhDvashyKTKokznYVuT0LALDeUbdRnYZv27A5zVtI1eZmXJjqvLXzQLIkQ23vE4EqzS
	 YrdmONZ2f6C7JN2EzjRzPDDsVMYXSyqaqykuIiGYoA8SeJBlWhkHpAazV4CnCkzQUQ7lk
	 7O76bUmnvhxxJsAckkhnRdaCS+IoLrsPtDomwX0AwS2x9Fv408vjYFo6Hu8lRLkN5Dw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793341;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	b=KJWy82oggkW6v+DlMEZp0JOb7WBONdlCKVSwLkn7eSnDOY4ZGYJWPO9Ak0tz/NyIEQHV
	 7kyeSrMrRGwrOcnHWzB2zTYz+jWHtaLy2SJU+FssAhC9MqC5qLqEJgHiX3ydhYxUVorb1
	 VCc4vXBxGBE9hdQ2L11LvQzFIuDx8iwqzkvsH4Xu3I1qvAPMKy4hyDN4/PZT1iQbzFXOG
	 NFJAxGuriY/5UnNR8YHhZb9vVn8CU0XD6g+VFVvkrVJ0qdNTiB2UDD87v7lptlqNBO1xq
	 Lo+P5qHXq2AZWlRmRIFmTT+PBY5e1ucdZ30nMzaiNJQnSysLiImcZZwHXGbYIPldBqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1570F1F00A1A;
	Fri, 27 Nov 2026 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793341;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=g0h59hDe/mJg48hOgbf4+rxb1vygJARjLWbwi/LJ4DpRXxlosU7Ff7bEz26h5XiFm
	 I3w8mxYJHXVWGC5fAQSpQde2hZYNZcFlbpi4FPb7HEmlP0SYYMNnC2RbVbgKs6hJd+
	 ZXvry3J/0hQDVCvUKLFBam7J71CylVbALlT6Do9H4IAHeTm4X13pVLHANI4Ix1hq4S
	 cqKaqfBMYVBgd3Yj2wS1cTrN+7VK4dkXzEgqt2PI5NJyjOzdTSiJD3u4gQqq3MZWm3
	 kOD5UoxnHU0SMwp/xXzI9iWlgCTwEAQ1pCJzoUKFBkDPUNxmWNrfeh7Tr/ND4IVnHo
	 3/GDjjtZ6WP+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B69A14DC88;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:08 +0100
Subject: [PATCH v5 07/12] pmdomain: amlogic: meson-ee-pwrc: power up
 memories for boot-enabled domains
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-7-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=2pSroicxmn87L6WpeMI1TQ71NJdXRXfygd9gmAxHGRQ=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwkmna0x2M3+6ml8XrZtddFambW/Dxc1lXx4JPv93o
 T1xxdEjHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEnLcxMnyMCes8suaC0xc7
 g5nuIYE+5xr1JJQeS036GXDwyqvtr1sY/gpwfyxnPeW8JaWlRnJCq6XP+1zvTQUPmApfTf8ZLn6
 CkxsA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

When a power domain is found already powered on at probe time (typically
the VPU domain left enabled by the bootloader), the driver registers the
genpd in the ON state with GENPD_FLAG_ALWAYS_ON and never calls
meson_ee_pwrc_on(). As a result, the memory power-down bits of the domain
are not touched.

pwrc_ee_is_powered_off() only checks the top-level sleep bit, so a
bootloader that enabled the VPU without waking every memory block
leaves those memories powered down, and nothing in the genpd framework
will wake them since pm_runtime_resume_and_get() is a no-op for an
always-on domain.

This is a preparatory change: a following patch drops the explicit
HHI_MEM_PD_REG0 write from the meson_dw_hdmi driver, which relies on the
power domain to power the HDMITX memory.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/pmdomain/amlogic/meson-ee-pwrc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index 338f70d77bf0..b3ae5cd7bea8 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -392,11 +392,21 @@ static int meson_ee_pwrc_off(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static void meson_ee_pwrc_mem_power_up(struct meson_ee_pwrc_domain *dom)
+{
+	int i;
+
+	for (i = 0; i < dom->desc.mem_pd_count; i++)
+		regmap_update_bits(dom->pwrc->regmap_hhi,
+				   dom->desc.mem_pd[i].reg,
+				   dom->desc.mem_pd[i].mask, 0);
+}
+
 static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
 {
 	struct meson_ee_pwrc_domain *pwrc_domain =
 		container_of(domain, struct meson_ee_pwrc_domain, base);
-	int i, ret;
+	int ret;
 
 	if (pwrc_domain->desc.top_pd)
 		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
@@ -404,10 +414,7 @@ static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
 				   pwrc_domain->desc.top_pd->sleep_mask, 0);
 	udelay(20);
 
-	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
-		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
-				   pwrc_domain->desc.mem_pd[i].reg,
-				   pwrc_domain->desc.mem_pd[i].mask, 0);
+	meson_ee_pwrc_mem_power_up(pwrc_domain);
 
 	udelay(20);
 
@@ -478,6 +485,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
          * prepare/enable counters won't be in sync.
          */
 	if (dom->num_clks && dom->desc.is_powered_off && !dom->desc.is_powered_off(dom)) {
+		meson_ee_pwrc_mem_power_up(dom);
+
 		ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
 		if (ret)
 			return ret;

-- 
2.56.1


