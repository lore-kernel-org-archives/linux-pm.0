Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288905;
	b=msyuoPQ1re4J/ocM3SzoqN2hclsoasUyI8wipsw0TCkpOf/KdO5DMyRrL0yz2XQwabec
	 SWtRqNDVYSBrOd62Npdz5kIPWSucC+UoPx9fCqDzmNep8H9hdkSaoa0crfIrCynqqly72
	 nfme64NXEg3CsjgrvBQXwsSrgaAFHbcNMhOQ7HqHy6A934mXZRRHGCh2t9fogAd28rP5X
	 RxNldiKUkC7FlBcu3kZa2Dt18PeO8fZH5K0+yHbNdvLLRhitfHgFcewrJ7ZXlEVoAI0dC
	 Zu4llLWpDc+eM3kQbikajz6rrmPw/TWhO0HDdTA4QE9Kd/h9LxkE6NSf2/xUblDSDNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288905;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	b=cjHrz0asmlDl5gXDzo7192JGPCWkiiyFekq9zu6ICystqeZoXH7SotIXIKdpurF6ci8A
	 A/KpMZQv/vR6GHXEOmR4VmGlQ5C1Yfxm/0jU2qUveuMwLCroqDxOP8NeFIXSPf3NXia2J
	 Ot70n9LBQUhtWRIQLJAz6cXMbcjpOGSGkrX1y/Y3BagJnkPZadE3DlhdjB4qMrlYt59YG
	 jIBux2CCbLoYZQVnSw5R7T1m9B1CpYiAtfgU+oNYgT3+f+409QV21LFv/hhOXW1wbJKpy
	 acy8O6XTgP03GuHWuymEKKYkJwF6oQlH4MZdr+29RDxvLGuahWMKQqGKLRyFkez1D4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlEBdC2H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4C606A33E;
	Sat, 21 Nov 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlEBdC2H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288905;
	b=Yt2V6k8/DXdclqCos7oC1WThjl5gk983RApxu3TFT/X9qQJCidGF7HsyTLMIEAzEFUmy
	 42Jh4bhCLxcs+CCFJTl7peLd0ewERxoSdfitFlvH1ojC1iA5rzk2T5MXzaJfaaGfOuSO0
	 /+mI0ViWOPSeJVH27dFmKYZhw/8qmk/pbVuGcBZOPMsNhlQ7e3h7QVYnpNKMKtTfLS3sP
	 IO5zhDUKFfkfhVy/prp7Wp7Q8/bRcM5XTX89bNkEvk0plNTMq/dCgM1WSl1iL0Wtuq5Sp
	 sX/ZV6SbloJvEvd3WqfPHkY0+gthWha6dBPgXSBp1KBVflQs4VFtG/XapTGLq4HK4Mw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288905;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	b=dw871ckaIm0LZXCEb4Gvd2tHAtW2/jXCsZVdwsva40EQgmr/iztj/id6+DeiqOWXl8CT
	 2ckVSoRqg5mbiJZP7jBAKMdB+waQenajktOElizDIdqARbkSJMzsvJv6dUpbWiK3YdSMq
	 MZhgshH1tu5mXy1eyvL3zmMlp+P9OjncXI8YAQgpM09c+QpSC6QGYSyYqWNgGFKoZ9Bf6
	 y8qFJ0T+ofVDimlpOOBfg6rFFTdNIXsi5GcyZdXNEBNLqSbApYvTLORRj61dVqsomSnLM
	 KrT795xkcNmv5QeuLmYE2u2n+Ib7C1hQkF0sCTypwTOXcVkbY/usUC0H2eyp3b4sgbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A1031F000D3;
	Sat, 21 Nov 2026 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288905;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JlEBdC2H/30seFlcxFGPk7ym6bF9oBRq4CAuAOeBkV2JdBxUxIUlRzG5kWpygthN7
	 I938eLXO4oEE5N8KFFY4HmLe08dL+K4tx9P3Dc51lzL1oF6ZEGWB9Q0F4P/llVoOOE
	 OEKRLKsUV2YUqyrNst38FvGsqro0+u91e6CQ/csJTmUtW/EwLu0WjKSJ/gElBctvbV
	 r9srK660KdXfgt5cYCIYRNxixW95dPCPN6INU5RGjbChQiCqqalOBu1VBXZwB+GWIy
	 ls3QqRQi3mVbgGKg8q+2z60H5iusFAAripsVAfPspC1kA5b9Qpe7jjHgsFjFNUGKV4
	 Zm+XPN+ddC0vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 257064BD7A;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:08 +0100
Subject: [PATCH v3 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-6-f8f471788076@aliel.fr>
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
In-Reply-To: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbjeyNd/pLbHSLbNC9O7Kpl3LCmtWPdlw0x26Z8ct2+b
 F4R+4KjHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEShIY/rtH9t6YeTTJafnp
 9R9ffZ8eufZx5l6Jn+wuL6YyvprF2HqV4Z99JNPl6lw7zxLnFWsfzZ+R/Cy0M3Zmq7DQ/47JSc8
 2PuQBAA==
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


