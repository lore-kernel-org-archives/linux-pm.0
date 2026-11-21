Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288901;
	b=HEeNWOM2Z0nGmegLkv8sOCJT2IOHrIzXoH5MPJD3UjAw/LRAeqBqSwoXb9Cd6VUmVTHf
	 Yd59Y7mIr9kbAb2TyX52AnR7TGMaY/yLVhxSDRLmJhZqTk9BMkGQnLzUtCxetg1l61NN4
	 jd+WjXf8RfLB8qGx3+AXgdU7+1D27uaKH+G/K6kEfwAJavscVkfkcSQvkvj7WO/59z5zE
	 p/RSUVAaSY5weP6z3vx11RrMdwyudKqLJufF5YqWlbALpljT473MemAjeVS1Vk7qOvLgD
	 uuGA0mVbY/RYqZ5gALTK+rdpMTGidq7KxIrsQ99SDI3NlUrY5yCyCJ49iRk7Z435/dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288901;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	b=tNrnKT70VPEcKoai2HvdRe2Mzcrb8beXy3I80Rr4AMar2wq0SLtOzxHTw3aoKQVjiq6A
	 U8Pi5Mw4+7HjizvR5SSGBaSWEc9543Gptqy62wVkUnx+L8j0CG4xCFw5HQGP/BHr8uqJ5
	 5bP12MKXRcmWbbK63FUvKSxCv2PuiDc4LpZOI2zYDYiYPzwCbcafpu8fGT4NV1s++Yuxx
	 CVLiU/4eS66n4yHC8IogEerdwqHErw+lg3IjRjWGyzb51fbayl7GrFsyUDNwFsIUMIRO5
	 7N+8RrZJx0JTs490sPJMDtJvP0UzNaaVqJ2vecQxXoKu69WyrRQhpjsQYDPVGgu6FMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gfyt/L77";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E4606A686;
	Sat, 21 Nov 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gfyt/L77
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288901;
	b=ctfSfYS1TY2jvfUyMCNYDfzcdnDpBPKatO6mBMP11yMwhboCtm9n2bBV5HGsd1fhk9UD
	 vxPJetIKERxcvj9UgYMfOL0Ztn7tRa11MsVi+7RnnaIxFq9J/5BzYpk7PCiJUFKdiVyHY
	 4+Gypr5wUFDnNuHBbu+Zx0ierX0A4icViCEd37ibf0Fezxc0dcCYinpZoXj89HsiMHqpQ
	 B5ZseMaLFVj3ROXYxQZZCl/LIe+Vc+g7Yih//SzXkQH+yFEZ9tp9EwduOWyCRNrw8S0JQ
	 HjeGG4/20slCd6pIgNHqPQJw5Omds564ceEx/nhH0avi6/nDrD/oYkxHdZajNCBapfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288901;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	b=RauRq3OK9QdG1mAnA9qKIMYtY61/J0T+a8OoAkIJixY23ckjl4K6ZT5P7B5BrWBoUIOg
	 qUEip7dKNa4bJdpP94Fn+KiwK6IMKxeGrrpawZNtWBgrmPuMITH7bmR1rm4io7K4ptoa5
	 ZM4H92imTAhNxGYgAoVNAmn/sPQRyab6luyKmmLvnKsPDVOfylMnjPgLYUvfZLJrcF8wQ
	 g78naQToyq03ZNhSYfdjyOE0CFXv/eOSnRG+1g3N0x1WFHjhyK+ayrNaWVsAscP0ghXKo
	 bLsgahhmV/WXEji/DDQXtK6g/qmuwmcYlK+PMtaHWcO3ynoor/xdIUXxdrCh2poDt5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 552CF1F000C4;
	Sat, 21 Nov 2026 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288901;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Gfyt/L77OPxb7XqRNZ/MwCIYKHrYVXemBPRFa2HZuINT36lD8tUqqNIkeWkLHcR38
	 6JXoKWolsTJMsSwp2EonhFEuG9C2HIJLojuVaD6VkHKRL5/lvcYW6+1U4UDIwOq6Eu
	 /4qkoL1Os59GOFRDjLDCKei2Sd8Ju5FiwussODQEYDvp1EcU/Iye9WXK98zbA8alHa
	 +CWQxh6oGS7gQaZuT8DLBa8hQ/Tw5Gi0clfEg1nQZXgXcjUO0877VaiFHKB0PmtHIU
	 xRwYbHPq/r/5AgmjT41W0ksLsuSB0o+z7YpoJZUDE/vIUwRrPF320j0qQKtvIR7RTP
	 W18ptZk+vW7gQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0AB564BD76;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:07 +0100
Subject: [PATCH v3 05/11] dt-bindings: display: amlogic,meson-dw-hdmi: Add
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-5-f8f471788076@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=gEM9bIkhQe1Q+n5KKc7w/RzPzlM5UABBv5gf7bLSb8c=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbje/3swz+nsmXNEqp/PnedSvyH3QLM0/bFblS9fGXyh
 VSlqsadHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEeH8w/C9mudjWw7QsxKVC
 ernK1dDdpr+Zu9TeXrl45LxxRMnTD08Z/sqF3d80P/wUk4p7+ww3Pf73BSVCBWu9JuZH2a/vPnV
 lHRcA
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


