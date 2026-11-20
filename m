Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198631;
	b=o/7lhk9x9mRYDE6JJuCkpoUR82yPtJFfXx0yR9jmYO9m0+JyesWqb+GmKdsZfmUtYTW+
	 7onHHVmK1/tsrh/9OS4QiJJLMNxbGOZ0iWDSVOlqDfVl7s+Er3kTfRmOGg2HkrOYYHlWQ
	 leHO8djC4geOETMV85yLfcFOs9LFsFDhdQVgfW3C2RQjkwrLqImdI2/otSoP/Q8nVS7xV
	 qONUG/w+2LFli02wuL3KoYEGzUVEE+3X5zv82EwFbsC44NUOOHXihjtDDOVZ7Kv0yGXrT
	 fzgYv5U2cE93E3Ro6MfXNLs4/UEwxK/enYQu+FYx1I2szoqq6BJdSPxUe/KBsgwFHpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198631;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
	b=MIj1A2f529mLE0tcT5kdbUeflLhhtI8+BFTQgJTZGlGYlCkWfmhc4F0P2zfebYUSzC2F
	 QeqegtWU1bP72gfq+bHeli8fhB+G0Z9wLik2gmg0Jr8rg5Mcs/niHZGQcSa1i2OCKmUKk
	 yxdo+KBTvS6SYbc13gQLypk187kF/OWUuH4WOcvDRTsdE01GT0EhQGVWRUw0gmO3D9MZn
	 +a6r4/YyUlQVoEkXUyjMrzhVXPvE94l5R2eQRVqyo8Peg39DOXwnnh30EXbneIAu5bNog
	 35rcjwUJSRazER8Sh5kW2t/KSupBqZFfkOfs5bu0qXsU2HPjKiqgRfEpxFgS0O1BFpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFa4aFOC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101F6076C4E;
	Fri, 20 Nov 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFa4aFOC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198631;
	b=vZI4EALvFAVc17zyIw6ljYCkNy9J9gPa7T6l//UKvkszLcmM4d0HLIbba7anjXDmmwKz
	 2zouvccaa+IcItnDDVkaZJRjzsOipH6yZHpziSDg5fORo3+sEe8HZoAvhsNeDfZY/7S20
	 SLdA6i+/w6p+3//yHGq9+/weMdZ013WrkeX2jN6cOUPNEsGYDn8TuDsgLO1ZDZTrFSyrK
	 Qv2rkHRagWpvJVI7D2BICIEvPN8rIRtYN26SbClEaQvwZ2ZnnDZ51qu0/H2eTpcrCovNK
	 DwMi79E97+JDq1as8R+xWEl76Cye3OdaiPQ0ppAxQetelU1+fr3lRcQZzBof+U5LA1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198631;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
	b=Aydy1P1yGO6i2YO/WuEK1cDjwULzR2FTytqZ6oXp7/vLyRHYPw3KjKhB+NBBE9225oCH
	 NlsCGzb6MRPw9s+cVaSWebTYE4hOOG3p8D3kAmK6pzFT78hmBGTwir+kVSY34poCZJh9t
	 tUAlJiyu/uNURcibU4WKLiAD6gM8Jev13xd7RrFTBwyCKwb4/Zj/sy6JYXqlT3Nm2IMTM
	 Sl9PhMx9pG/+CCon3KCJpi6V4eVUvvQksRuy7mMm8Lnu6ZFnxbpxzyV+IdYH/ngs04RiZ
	 RDiK9M8QviwOaOVPMgeIEbDEOQSUETir+mO4wgiKAp9W3b+HlW9fQEMpGtGcIgHqhbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 314861F000E0;
	Fri, 20 Nov 2026 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198631;
	bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SFa4aFOCt/K3oixCr0M7BVo/5IBM9KpsD6fExnY3OgpXsZlMEFE+7XJaARLzuknsQ
	 FXOFfJ6LjGv7iVknfL1H0Zz+/LeauCRc6tYCY7qfiHbpcsLbs4LUSGUKSkc4YPYxx4
	 oI+ZZV2cKE83b3XrUEvML1hA7t+FOnpqWSqTbH8/mLf7Fd3XHmwgiy8Q4N+/uTODAG
	 t3TgGR8ao3QKY8LXDS21PPQ6Qn4vGOubkEgxUoZ8D30Y+pK3IHCK0RAa309r+U3cKE
	 pzdRUNGcPTGQOAR0NCuzO4Fb+GibV02G2wHs2mmsLsz8XQnPbwXMP4B6A0+wXgoaGR
	 vAjgGZRtPfGsA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94D774B975;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:50 +0100
Subject: [PATCH v2 11/11] arm64: dts: amlogic: Add HDMI TX PHY node for GXL
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-11-93d622d9bb07@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JP7lAwalWZ4HUjkBJydQfX0hMiglUBnijIXqwFKtcOI=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX83rBW/cI+a5Hwy/7+3y/cLHD/FLkjY/sfUo+cyiw
 Mp+W4Czo5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZjI3A2MDEfnTz97SHBV8f+J
 od/qdR1+F37bdcj97NKade0rukLe7M9i+MPF5Zpg1NrnVOAkk8p6J4NjymlVJ8c7leeKEu1XrXL
 NZgUA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-gxl-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index f257fe3860f7..d205eec1cff7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -328,6 +328,7 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -342,6 +343,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxl-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.56.1


