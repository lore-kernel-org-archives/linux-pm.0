Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462697;
	b=jcuCgli3vK+LshgUzwxNKFfjM0lEkyaSYYK9IsyZBD2JGFRh6ZocYM+eV3gPZ3qHjuC6
	 pT7gj5HgR8zHC8kXQxAOVIf/uYJ04qXuqG5VyCXf/f3RM6H8USG6XrZEm6CwHG54ATMtx
	 OWkMkllHSlW9UjXld9HulYcXb8BsBdj5Zc0WrfC23ImbjA9wkWvObH2ZIXZdET/4yjoHg
	 ryl0ur0ESGi6yhfZLcNEPtMeNobfdqdcx13mJS6cNkQbrezi7yBlTsMSRwJk5KYXjBYL5
	 bUhwV/BNnSj6L9ozkaUa3S5K+fbyvmPlj0AFdv1J0AFpq8FjTWrJCiRk0Z8zyShnTwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462697;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	b=Nl9i+lQx9K1OiiBVXmOHg+f/i6OFQ1BlecN1LHDY2X6sL0Dm4PerqoojV0/Mxc/ug/r7
	 srckMlwiBQ2Dzyd0LramF8gio0rL2Ul+BDpZhw+ZdAExk66PrznjctF4y9kdIFn9Toalm
	 IsYsZXl8IQ3VsaNBeDde6aa95LITtA3zIVBluO3b8ajNHC7mBv1J3UGyLoS6T9IGYfq16
	 mGp3QyEjxHE5mN034nuQ4IMqd3OibHUrBJjOJRo0vqMoQkjoZC0w1CCaZV1+LDaDHqpdb
	 2SmWTuSMY61EKbVgU0oZs2QORoDOKz9+dFIKg5UiWyjwEdA0ujXFp0Cq4GyZkNcPvzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGw80R18;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB399606A680;
	Mon, 23 Nov 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGw80R18
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462696;
	b=D16+vNgjx7SZYVqA7fghtOIZAOsU70Xt2B1AEh1vH+MfjCslmvS27NfsYP30bomp2rjv
	 mLPxq48oQpSme901AJBlWP2IPVqDMTUPR3lnZNSY4X4LGQ3+DHXhkL5epluZJbS5JepPY
	 aME/fClbiPjYRqXGYk93IrLdNRt/mNn24tuXLnHsOvmhZNyfkSEuOXwp85nctrACvBX19
	 ebooVP1C9DFe3w+nUfLy+Md4aORkYd4Mb71ir8M15q2AhNBTFcHIkCvAi8h5OWdq5769A
	 f8C0Igd0PcI3IKfWLKq01mDLFRYfNv7/Ei/slk+ei5XYDzr0MQ+jYCCAhfYwe861JRA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462696;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	b=Yz1hh0+8LaSK1dm3xAcHZmM8+qRtfv/98MsuTQTn5wdbhCSHpdQI3xXcP4lqEop5EY5w
	 uMTNcaGR+T8PrAiWS78m8F7QpGxFacO0aeHoMU8vT7v8oYdgx/9teI1jE5HthAUr+Mbzr
	 X3BLc7RoX8C+fcPgBBzaBzZGMUm+TZvWeq8nLxBaK2T36LyxjBm1tZP9/B7pqFaNslNOj
	 BFGWvflw6LJjMmJbUvzKBI3g2aT3jFEZvZIy8fmmvdJ5Rm0Lu2XHhh3FAtQhKrg+OiDvb
	 ivGcz5i154cV4KG35d4BXeonmfrzFI3iFLoKeGeo8AQP4K4wwSwzmNoeaHfw4OiNCtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BE5C1F000EE;
	Mon, 23 Nov 2026 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462696;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YGw80R18q7FgynHyEeJCHzZsqOO9lttL8RfhmTU9ge7tih9SmIvOWOdeXBH9AuX75
	 Kai4qqJ1AK7mahIo7RTiXvjvQ6R7yPQHDUnI0bJlnFgtZq295nVcBhoKCQxivtdzs/
	 PntreUkoJpktJd3gfD0a9XjnBvr0LXKBpOs2YsKkCkSrEpE9c/v3iWo187pleB7dgK
	 LU9bHkaFiVn5lGwR8IO42B19Y0zy4QPQ78ywlR31oZr0Os1j1SNDNeEPggM5XCSRQc
	 c9APEYqt3rDw+BSwIvX6JOjmz8k/adiHop/6LzX3RdZb56mjnDk/cZ24IDMcyoaKKg
	 V7TxCMLgju2hA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 38B134C69D;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:37 +0100
Subject: [PATCH v4 05/11] dt-bindings: display: amlogic,meson-dw-hdmi: Add
 phys
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-5-3fb94f5534ca@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=gEM9bIkhQe1Q+n5KKc7w/RzPzlM5UABBv5gf7bLSb8c=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNN7tUkxefzfp/05Vz1/gdqt9osSBO7bav79/ffHFa
 k1tx85zHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEVPUYGV4ZaLtvOGNn89kk
 go2ls35FSID8azmeX3tDm6+uUK45zMfw31cgfxrXrTd9U5UTPr77HibExz1T5F3HoVcPLDus+yT
 qeAE=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The HDMI TX PHY now has its own binding and driver. Describe the link
between the HDMI TX controller and its PHY with a "phys" property
holding a single phandle, and update the example accordingly.

The property is optional so that existing DT, which do not describe
the PHY, keep validating; the driver falls back to creating the PHY
itself in that case.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 416fe263ac92..7ece4ea262bd 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -108,6 +108,9 @@ properties:
 
   sound-name-prefix: true
 
+  phys:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -136,6 +139,7 @@ examples:
         power-domains = <&pd_vpu>;
         #address-cells = <1>;
         #size-cells = <0>;
+        phys = <&hdmi_tx_phy>;
 
         /* VPU VENC Input */
         hdmi_tx_venc_port: port@0 {

-- 
2.56.1


