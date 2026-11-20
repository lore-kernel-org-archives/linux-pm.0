Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198627;
	b=dBYK4W/uMKW8x05Yk7EGTJu4UrnU3sd8GI2PKkqxN74PxxTUqH7X0ku+gre+Z8IBIbnB
	 AHbZISilCMOTmfM1zUCG7EkH3SyVPONninzvBdDVFwE0rgtJODD4Xw07x8NyB32SBXlBb
	 ySPMDud8g8zMjo3xHlrCY+GFWC/gst1stmFjS9aQVlp0VCeRBnwMJ2hCmSclqcJll86Y/
	 xz83sD4GYlEFFiSX01CYJbzoJtGNAWcFivX+paUyEfNr+f7E2oRS2neRwME429ZX6MZTV
	 quBVbZHEnN2QwF4ipYl5ZO6mE8mTjBMfql9Q2uC3MntTmAq/TI2o6cZUQ1UNHkTGj+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198627;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yHe9tlbPKIJqO89i6ObV/O1zLBcXG+I79hBGaK84tB0=;
	b=EkSX8/tDZ9Mm7SeaDqd7qK0YG7kpXtsGJ5u1tIzpvfJKrvGmoqOv4YxFUZwVwEr1oPBg
	 sP/0J+2ThWA22Mq41WCiHv43Plle8nXh5Dt3UL/cilnZDzFCeG4hrXcIDizqrtU3UI3jA
	 R1RxYxxLh5zBc50YcA1UN1OKYJYO39DSr56laHwAfHP348SUPJLTZHWEroLSMVwSwqOmf
	 SGhoxCf1b1j58WlbtkTdhF+MAuGzVmYyPYGnCTp2I1ZAiNzOTZClYEfSrsi5od4QMt1QX
	 zO2ZmMgd3hPE5i5f0iZLj+cmVLuWE4dbmthNhgMrBTUo5mb3AO+ZBJK1enm9E5khsLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ0PnbXQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B8606DE2B;
	Fri, 20 Nov 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ0PnbXQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198627;
	b=XP8KlAurL4/tO3zUqaxn6DOGc4exiCf8Y3SLr8If7CYVnPQrhkAxzIlKuQqf401EuwrX
	 99SKo6KTjNCsQTNjDbf42R2KCnWicF+c6pgEc68dEtHZ77YGatuWn4poslOb6d7/uicr8
	 C1nb94BDhoIt/GtrsqA66OKclzP6WpNyIfBdQlI796pezymNnmGzjUKx9MykYoWa74RCc
	 ZoSr1GgaUuelHSv4SsYorkRVLNPdi3DYQthSU7CvXcACzdxgYYF2pF/c781A2BMZdwmNF
	 BNHLEoOCM4CzxaY+ikdUfthxgAuqtVo+pC6AdqeeVHU9ansosZnf5juuG1CIbk14Zeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198627;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yHe9tlbPKIJqO89i6ObV/O1zLBcXG+I79hBGaK84tB0=;
	b=lx4X5CQ5HE1leOef2igxLk2zNbSD+1HyxSg1hOPL9wyjh+RNbGBtVQJUoJuoBDvojtRl
	 XTN+4KQ/95NRB1NqYVMfjDHeGYQk25RTqbckZ5Mrf8gUKXOBzAnSPQn1endbqzhOkriMp
	 f3B6aPhCSzfcpSzVflenbFnvCDLlY83JHWtkK7GHpwoAeNgcw3CEUZ5U/wF4fVluIGhLY
	 NC0BetAa7YqNodGglOXJFw/Q2gmf932AMn8UXlfj3ZTt1DxgBqEKIAXW0WgJ7tE7fOUQm
	 tjg6+URJwKpl3iCdkfTAAcsnb6MYbichM/WOqSDgSDq2mCTMbsSA5EVpwvQXPbzJ4fA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E35CB1F0156F;
	Fri, 20 Nov 2026 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198627;
	bh=yHe9tlbPKIJqO89i6ObV/O1zLBcXG+I79hBGaK84tB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KJ0PnbXQHWjt5DYMmF6A4xG7BDao2ybplMAkCTtwyt+OdTw4Yy6/BRh6hTI+SiF5s
	 DrxdYhCJWPjuvCTl9yGpfWDKnzs/9S6UnBo9sOBXw7i3A/NR0cmDQ+QiuH4/wEpoix
	 x4wkGDvoWyrabKYXJ0LQ/E2XETBakSUDI7RwTM6ivbqDZJVYFs4arApzdWrY6Nc/6e
	 Uylh4cG3lpXbsR+EAohizMDQpuGOulVJYXJbDryHUEIbMjoI6D2btdF3aVH32KF4A8
	 gsJh4ndXH1NGEA6H5f+OYvgBe7I4sFJ1yUuTG+QRgXfsrOuytjO9EhaVZKVjeoX/bl
	 yV9rUhB3+mSWw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1F0904B925;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:45 +0100
Subject: [PATCH v2 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-6-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=7xG4MIxwS+Zi1PRSbSHzfUQgbqHckZHtTi4D+NymJ5Y=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX174l/q2lartNv9n/V9WcUvk4i67Nx9sA3fcYKu4s
 SJX+NrRjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiE2czMpzbfsp/s53NovDi
 9niW2Z6bFwUu3y54Yem/6GyvQ195PYwYGSYsYjkhWqoYNFM0xV4n4veut+9YXHbWzfwyOedLwp+
 tfEwA
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
 drivers/pmdomain/amlogic/meson-ee-pwrc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index 338f70d77bf0..404af4619256 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -428,6 +428,16 @@ static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
 				       pwrc_domain->clks);
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
 static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 				     struct meson_ee_pwrc *pwrc,
 				     struct meson_ee_pwrc_domain *dom)
@@ -478,6 +488,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
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


