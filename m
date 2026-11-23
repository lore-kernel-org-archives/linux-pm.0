Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462707;
	b=AkerpbvyEBNBRnPxhHRbhIAsqrzb+od5Zk7275q9HFBFN3fPwM5vS9PGqYDJRL3ESQmj
	 gPtpRIQ6VV6wylCs0TaoWrcxpE1xJ9yjUh1dGbboLeNFrRSpoD0NCnSAAT6zar/wlFHY9
	 rjjNylOPqMhWHdLGwTJrpMbSRC6PGhLwRcZ+EqvCiigjmVKS4LC33Pdm7vxGwe6OBZLtL
	 7a05aDKY/F3YFwog5MQUMiojliTtmM8VP2e1vV3q1hEWw89eLDUpaq/cCX5uPzgRFpWfj
	 6hyaorTG7iAAb5Yel5dCVEAsFShC4C4HhpCKbMW3LAhNMQmau2S77vOiBbMUHq5FRYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462707;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	b=LgRKGuBzmFpy30XzhgsTtZHvSTNchkm0a/v6vv2MyJ/AgVVI7RSxEdGXrh7ge4+KSW+m
	 0ICd/Ie6uE8HpvuORF8rWpHoOrTQW56rVlBYdxKFni43VK4Kk/cw2GTHDQIJv7zM1yVio
	 M0objrA95CfhrhJppzhP1N1x736H8RuXvEHkkxTHf1b6oIyOvJyir/T6uVW+Ka2RFVp0P
	 hA13CJWSdwRwMGF2uzVitynwEBml8vwnFlBFPoYNjg5VUovTVvXnfXq0w3I3vP/KOxQth
	 u+V8b+n0Q21H/ZcrnTXjvwdJ48yaT2xciWUJf5C1LON78wysmdPR+EFF++uMr9KB+oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmW73Ara;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48460A2604;
	Mon, 23 Nov 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmW73Ara
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462706;
	b=2rN2uAjze3pp5fF0gYAwHE+8UrApq6fXslvuW+uSA7LNEZGBPZD/d/JIYPbB9srgKyDq
	 8EvdG1b/EUDP2VLZT+hZxl4k1yVdepbWYL6SpJkaTM6Mcuh0oNSd54qfJJb481ORvwCOr
	 Qh6yazgqoSr4G1bmCqzEH3ajh0DgtyJiR4nE+tC45bdLNFl4dbwXUlSF5JdPMh0gDciPk
	 qQRiOdfej71eT0m2vL8wryPtdt9lGGiNQoN9ZXnCe/9O7sXwv4jw3a7mY8bSuMALMXGA+
	 hQao/be+7xIIa2+wk1OjX2gF+cYNfWWHNMWgA9ob21UNnQqpQ590PdfR0PDqfPNgzpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462706;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	b=QyFoRdH+1dhFbxwDFLdV0gS8E80X5nRhUQ1F4PEVzne26eG1nTqZ+JxVZpBAFe98MLqp
	 C8lnYbpWngwiyx5Sho+/gAJe6Lcg5hBTMJZ0wEVvhn3A/oEbND+DWjoudzk7GOu4juDUY
	 FTUmHAgxHOYTkiELKYMb+ORKBIxbrHGCoTEUoVbk1ibH6+e0zClPr1Ri4Ayu6Jx7TRVRM
	 aDnsjaGYt2wiJJqFF4l49Sxfw73Gpek68aoF55fU3rU6Fab2fHoN5TgSAhGLWNI6QafcT
	 K+Ylw+A0/naW2kJFf0vaklubWWpqiHFmC0egAEtsiZlFHHzaKpN9lIfuUGpOxGz7A5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 205291F000EF;
	Mon, 23 Nov 2026 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462706;
	bh=rAgcqIqOw6zcaQD0GaowJvtaNg3/b1Y5Y23WzFleRQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HmW73AraiiBadW4DbSF9YJFTGAESKyalCrmoUim1vH6mVoHwhoSBkNSiEkBzLDris
	 UxJfiBTTx3qqrjCRAqrA8UCO6Kd6xxOfxwc/xuqh+Xm2aPT71qs+jYo1HK9tRLdkCx
	 FcVMaqjO1KUP30/BOrAfMFQzSmXSJFO2b6P+66vwOnWTzGmxBJ71911QIxaWVyzkQd
	 8+YmUzegY+bHipPYdmmYK6v5dj3ow/Hnc7vS4SHT9xLRDHIM+5kIuQ60ochzYn/Gzl
	 Qd2Uae4SiwVHELIhS4gRhKVC4vt8IhpL0/DRyIjvWimU+Zfq46LB7JfRDUSluxYs6F
	 bUshH96kufdyA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 542904C6A1;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:38 +0100
Subject: [PATCH v4 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNL5sQ++6hzY5B5+Z/bsWLnPZw+y4ppPqnWyGbClfv
 s+zErU7SlkYxLgYZMUUWfrnWp54d/noma971FNg5rAygQxh4OIUgIkItTH8jzincSxhz4q5twuX
 X9r7263C0aH5T5X3rMO7Pm3v4VVifMzI8M080Kmb9bSV5dqwPqn5dx3e3PrKt7Lzk2+a0NGHcys
 2sAMA
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


