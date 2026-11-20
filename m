Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198630;
	b=XBuDNsXpaf7Y7g8WC7NRtVjMTcWPojR/TuK41lUhTokICkiyBI0xGB+RJ+vsqRxRfgoy
	 G90OxD6QcS51iX8V0yP3ErHXDf9Gi8JAbkhutfSudRQnHAVIoWPrzts6mBxd1eS02AMht
	 COfXSL0P/YRr5aIiYunw6Nbcm+5Iz7o+wfjxacOFKsKzDeveCxjDsgTHkcLYwpagTag1/
	 mvaCU7A7lgJo3oyx/xaExIAhKxZOPVtqEDG6VJYQCGtR9AE27RB9W8kkt9aRMld/5sTxP
	 kCFA2FBMXMtLkV91qv1VkzUS+UVdrtjYZc6AKdjcdytZUT9K2R5yuHFuTdntnsRKopg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198630;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	b=e8UNI0bfUekOTR9nPymTz/CHwLnnkfUufnpyJ150ewjKi5g6wGu1uXbO9o6+CgTDpez8
	 e5BrE1Ri83ZE/5Za5YwePHWSD3vFo9ZKLl6Y/FUV0fSQZnU2jgNrpC6WL5svEIhZaUrPr
	 msgB8e7r0e3c4dzzdVcimf1l0D7pdacGvld3aDiUWh0doS8er7yDOgcMxSevtRN81A+/1
	 kmfxROEhTGu60MzO4TQt43iPObewGyzwk+hOWkN7iMdJ1kW9ua1dPrOkqsck+s0rV7xp5
	 nSXgAaLkoaUCPBOYgQzjQtK3eW72l5D3DGQqk30RviaygLAIvbmqYRS9JJCmundIjgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyyTEdJm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FB607636F;
	Fri, 20 Nov 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyyTEdJm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198629;
	b=jnH1hsFxeFlfqekuMhaNDVUjCJoNJd/JbWDESTs1zpY7t4Kx533zKI7+n1nlHucLJUK2
	 od2YzqmE+gzsyQANtIfGVkY40c4Cg1pCfvpvkZp2r7WCaeSVjtGnIo/Xr5JDDEr80cS8P
	 NrATBSpE8kWiNPVLJj6k7EtsyzLipxXx2GLZjP6tDXjHSLUC0465fRH5P7Nduwb0rcp06
	 3zE5dSKuUpaMDi1CWXPNL0+2dNNwh1ioGV+L2XLQyM+IiwCHcgGn9ba/c5Pz1ettXPKjB
	 NERx5xt9Y4fgDJwJUfwNHx+QwdyRV0to/fJqYt4mDfPpL07alevT23XcubO/XGYBeUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198629;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	b=BFVufdj1URe2+jz1U35pYtL6TbuIOPI6Dd3EpW6CmcF0NrauAw7KR2o3LkiKidwfD0k4
	 udbaqM763VzaOZ7QaZjwBuFez8rjmdfjwwtAsI2PhCO+ty8h0Q4JeI6+zCBz/vyHEp2We
	 flw1Y9N5eU93lpCW965dcfZ2kObwS384lHOehjGz0pM44N96ttXOubcA68MuVxO4Dhuso
	 F5lBby2Y/SBybkAGZ6IHaiwRrEUtNBJ4Oq1/EgmmVhDFe+p4QERRXpImGlR8kN0/UA4H1
	 612ldnQQjftNUtRejEFdGjtS/aH9qgvddX46lC3KL6/jERpSuGhpG2f700hvrgaCVVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D06C11F000CF;
	Fri, 20 Nov 2026 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198629;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EyyTEdJmznZRKDEzO6kuQk05Gp+WT5kgJ8ZIKYpsDWBQ5vzKYnznL/rGmRwVOuR29
	 VbuiPEJLWvsQw29BNdxq90ZjqpCZp7RnMq3jNesdKgU07xiwT/ZZaUtzLsyYrpNT2O
	 pwUYW68yzhVW2lxoQWOsGWBp63REQOqU5gwxsuOcr52i85x0Uk98QXY/KYs9XRe4aI
	 0MvDz41raBmsGxVdJNLvtn7TFaNR0pvOXszINxs1Y/ThaJx1o1oBXRcAZ7iMLfsmN4
	 vk8H79q/aEkRMfOuvN0XKYhEQdHfyA1du9pQ9KkiQ7nQ34DJRuzGdWuk8x3QDorezV
	 UfMtJagYAbHAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7DD274B965;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:49 +0100
Subject: [PATCH v2 10/11] arm64: dts: amlogic: Add HDMI TX PHY node for
 GXBB
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-10-93d622d9bb07@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JfeJFGsdjuVYuSpN9bsRq2rmNT9JvKzwp64cluLxjAw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX4Woco+LYSxb7f8wu3TB6TEB/Jk6X/g3nZJKY3jyy
 Mrafm5HKQuDGBeDrJgiS/9cyxPvLh8983WPegrMHFYmkCEMXJwCMJE33xj+Wfm7/X4WU/loNtt9
 kQc/dpoVMvRqRK9V23HGxG6X6mqlMIb/vtH261QrkuTv9pec+vB2ycal6+fVv51i+dV7jsivmT+
 E+QA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-gxbb-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5c2fe9dc4f80..09ad9790ebc2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -316,6 +316,7 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -330,6 +331,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxbb-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.56.1


