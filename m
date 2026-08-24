Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609F40B367;
	Mon, 24 Aug 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569895; cv=none; b=Ww35dzIbIhZCwImLOrMHZ7gHBtQSvGQi6xqAu8OCtVJcTjtj7GJJDEAsCZpuBeOlqbLgQsJK/48wlbWXNI8t+LTLS3hWvYrEHfxjdeXWhY69FQoDXiBQg99v8mjWkOy/fLsfh70Xsv0c70KI+a6dIOfVUGnXrgmdsaQwkgX+wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569895; c=relaxed/simple;
	bh=rKtYZ4cuNw2XD4BIP9sPPE9g0fpAvvKP/Sfa/QGMjIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh8Z8RUPqzstrixe8aQnEBusTPOxm9ozyGBamTBdM1hJYPyt1CefHD7PZzt02BFb5x7KCXLXicPGlAv5rJbVys7r22IC7nt3YMgbxV4uXJfqXpvywac9W40leaf74RkjFJJiqA9apXTi2pLzGu2j4NCCBQ++v/A6kF+IiM44mVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ObcmMFca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VteIXgpB; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ObcmMFca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VteIXgpB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 70909130005D;
	Mon, 24 Aug 2026 07:11:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 07:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569892; x=
	1787573492; bh=yyAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=O
	bcmMFcah6VWQt1lnG5fWb89SOZ3pwISwWy3p7CkV2x42aThFTrnAu8t4E/LZekJF
	s+q/ocaKEHRRlfXqKekfwPi0nh/Tsrda6Y8xINyhGRshWR2WfICQoCG2sIdzLgSa
	N2jJxH3kDxIKx/O9KgwjKeUX5aEw5/CwX/8pUW2a6vkRvZLcRb2Vt1kx6bcAelen
	Xbv84H9xJQk5RcyTtC6v8l62zgMRS45OA6pf58i1TmM4WkTKOyjZ6v3wCOhWhjrv
	GIxm7HCOhML0ILf1LM0FgExULfgqVEa9vZVDx5OCKQIqqrs4wyl57AyX1SHUA8o3
	v/1iI/arpufs4cblVXerQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569892; x=1787573492; bh=y
	yAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=VteIXgpBHVXXIXkqf
	4HCbBg/HxjDfGZmZmx2cFGv+qddpamknSZWVFu7h1bir4/3k7vngpPBA/oMPEoK1
	0BRUKy6Lk35gSAeELWBi2ojq+hQM+pfcJBjZHR7VRtVygZubjJeMGgvL3oi4lVxP
	s0za+L+K+zKEKy3uM8fOWUUacQXU9r0PE5JLYixhaUbti+h2//pvziceRPt3Iwds
	S894DiKQnSG8vSfuPxGBPdBaaA6fOP1h1oF/M2Ft3CYBEqOamVdNi3BN8+I2tQPm
	ohDQrEPzjEXoRMjvfp8CsS1u6RU4i5BdZ3PAiOVHHsen5WLehm1PnTsT34pW3wTq
	arJ3A==
X-ME-Sender: <xms:5CaMaow3Y9GlBm23J6UMqeNaEmT_CxYshE55VnVeypQhJWDGoxkqYg>
    <xme:5CaMatUl5894Ar-smezsR07OJLdMlv_Z8TgbSgLhRXn_3B7GZGLVUHnQMeUddkVyw
    -UFE6epYV3xzGvna_JgEy_SXad9kEBh5R-BDQWtA4SWAV3vjMEKG2vO>
X-ME-Received: <xmr:5CaMatROTP5BS99rFddvYAmDMlvP5q2DsEruo6QrtGtgh7HbtHzScIL7Ed2ra9vlhNuWfU2taQ>
X-ME-Proxy-Cause: dmFkZTFZCbpsgW1YFD8tkPvHCNfxYRvTZ4blFH/NRV/HzygHIZO36nEMOhE1d730qpXJvh
    mj3vwdyckgY6cjcLbWoO+E+Y3xnZHjj3a4qFKPUp4C1ItOyypDc5v9ubc43QMrvknpo3YV
    t254bBqkhHFILTMaiaOskey67wujVC060Hg7shRsjYN75EBvtRkSi+gTwzTAT9QI5uwF5a
    jKY8X+yRsMvgEojvqKUbS+n33ebqC8Mk85kgoigVyIrVFWYfmyd/lA/A6ULdG/inFBXWp7
    ziuYhhyF6f7lNHjxbQ4kgWN86q7p7VmrRBdAb8OqXw1LSsz5kDP4W0+4ny2SVIkbn/odIK
    sf4O9rLwTvN1owLeLJeRDej9R2fOMuPzGWUO9AyRJmv3oebnLgAG7tohV4GtAlGdkl39OS
    WN1gKehlQbcq1i1RlPATIOvCydwYlmIBO+5j+aMcmi/KyXBdPWuxCg08+8l083ANX9+4Wh
    40CtErh+EM+/Uov4XapNrslCi+GV7ACGr6yic20uXHqWtpf8rOabFMZWcw5dcinjlpn5ng
    TaGaEoh5ZLYRbUrrMix0OIZW/rhunExybkwfqmYWxrhObNq9A0WLtpe6H0rxgCAtQg1Tnm
    /w4vkuKbnsu5g4Ww4vy+x68JXfx+et5DEchqGAMWeiQKRWR70aujF0munKRQ
X-ME-Proxy: <xmx:5CaMakNOmqtW3dImjCTsB_6OQBT0mPRyOupzhql2fsz44o3uNvDKrA>
    <xmx:5CaMaixAGBFlnZfVEcOQ13XGVqWdaKNCJX6lZaT8wZ3lUvAnzVRxqg>
    <xmx:5CaMampzz8uSV1XhNbY0oEySIk2_EiQjvmyavhpQmGLzzvWmSt8NtA>
    <xmx:5CaMami4gaUg9lKBXW8yorn1F6_c0NK0afXHrxzkSPuMeW3Ke-_2mA>
    <xmx:5CaMakJOZuXrm-zfUA2uFgrYmI50Ki5veIfFe31BhuTy93qLc22OkTBB>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:11:25 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v9 13/13] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Mon, 24 Aug 2026 23:09:02 +1200
Message-ID: <d06951df2d4e1dca108be71c5e66bbb088610a21.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D, and hand
vdd_npu_s0 to the NPU power domain as its domain-supply, so the rail is
switched by the domain that gates the block.

Measured on a ROCK 4D with this in place. The rail's regulator debugfs
reports open_count 1, so the domain is the consumer that took it. A
sampler running beside an inference caught use_count at 1, and three
reads at rest report use_count 0 with the rail disabled, so it follows
the domain rather than staying on. Over the same run the genpd
active_time of all four NPU domains rises by roughly 60ms per inference,
and the inferences either side of that are 128 of 128 channels against
the CPU reference.

rknn_core_0 keeps npu-supply on the same rail, which the binding
requires. Only rknn_core_0 is enabled: the driver binds one core per
node and the second core is left to whoever can test it.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..79e039bee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -722,6 +722,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	hdmi {
 		hdmi_tx_on_h: hdmi-tx-on-h {
@@ -779,6 +783,15 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
-- 
2.43.0

