Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3795234973;
	Mon,  3 Aug 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750166; cv=none; b=WIeYFOtn4hWH2NgtDhhZ8zist6IVehHEd8YYHuOUBa/8nnTRdGFUPS+M4gIWexav18er5kxGjrO9tWruRHyPXPr1anBRGPP43diZQWgkqjCuHWbp3uOqilKBDaWbm5gwUF4/5/Q3XP9b/GzVZEjNLXigKPuJabhhgP/wfGWYc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750166; c=relaxed/simple;
	bh=B/PDIxK+nCQrB3w0MlBKx+RXgfqlE9FDVKgfrJL2HUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/Egd0kFll0aXmCXwwUOu99Yn7FmnTF+vt+b2PEpf0n1HdeMywOfwiTjhDAAsTEdKqV5uFZIXuL3p2+sihAWiZ5poeATodfR+vU8moSFDNQV0MmEMUU5bPz5sLYeTxJE1wiFdCA7li7LVx3PJf0hP64IC8Fl70NvGztKOFZsV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=el5+SpJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfAoXyZc; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="el5+SpJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfAoXyZc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id BC057138007E;
	Mon,  3 Aug 2026 05:42:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785750163; x=
	1785753763; bh=9q7dSejQCfebr8NuQwMpF3YyoxfDmxNmsHXgtdnFkTE=; b=e
	l5+SpJ7HxLGlkyOCRqrTEYuEf2J0E10tRAv0h43Zab6xN4jjFqMxc0CRCwG/Riam
	L8MWjPopH16EnagXHx3grADsT+fpZQgVDQsr5khCOa3g80gACC9dlJZjQZ2g+gq+
	tpiy2HT659yPG6d1Ru4R5SJCQabHS0n4Wro5vts2fiJx8yd19LJchYysNHMeSzXi
	kLC8yYg9Tcvvl5v5BsP6UYu7o8refijgqZD7mFdMwh/Ul6A2xKcQWXRO8Eols6BT
	0QvYzHwEa184P9MPbkOZLb1k0gk/C2S/mHf56cQVxcAtQdRiC8H9ClFNc+Ssmbxh
	X19dEO8tdSoI9oEvbiWMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785750163; x=1785753763; bh=9
	q7dSejQCfebr8NuQwMpF3YyoxfDmxNmsHXgtdnFkTE=; b=jfAoXyZcZDMPMYYXq
	X7NegD3I9XmFSif7ztevrupeagH5JaZS5MqAuLvKEzhpXRuq0ICL9bglNmsmVR19
	+m8AAgqE0cLqIdzzHY1u59oURUR72rHUCLqxyacP24mW73E+GrHzllN7q23wllVD
	8ci2tcBBw0LJXqknGJVJL3dCClAM/OJA9hXYXVFJM7UipDG6pwhRxyUXH8T5ImL5
	sRNBIWwdZ39Ioer8u/3io//CYZ5C8nAM3uwCjfN1EGRzVBsm0qf7nqxaCbhGACFT
	pXzJhWbISsd8qvF0hT/X3f1SuNkMhrcgf8OPf5E2oOKUgskRAjvSJr0lKfnES79a
	4QcPQ==
X-ME-Sender: <xms:k2JwapK3M1F8Y08pMa1ZT7yWuBQ_FQzuBn0t68G1Kki9xE9yoQXZmg>
    <xme:k2JwasPr5aCe7jSBrOeuq14x-BozaXAEgw06lF07XdBaXhSUYfF3BomiSUkRdX_lJ
    5qjrnv138ExHZUnBSJvp7R6R9EXXmYiGT_8YyjaxQd_m0es2mOe1aHp>
X-ME-Received: <xmr:k2Jwapa1RI_HbUwmUiiUcpST2h1TWqG9m_gp0nmZh5k8YJ-mzuVwTecsDi6m4GwRxGoEo55_Eg>
X-ME-Proxy-Cause: dmFkZTEB/ldE4jb5JSNTG/I9RbU0Qo97nVJHJuqspibj3o1/xsvgn1ENECHMTdFcxmmZdC
    p905ozJ3RWn/7JpxgVGZ/yWIhIhWQKgEKDuJiwAa4Jfs/xSDfCl1x37vAIUO+pYjZwJmFP
    0x7zPsAleubBidZ1ms8Ul80JPAR9F5Q9VedgxtlHdx0InBVregMto0NgkhK/jfbULI8TLk
    CgagouY/mEjxO+4NO7d42HULvfceTCaT+iumTCuvUWiRi4ophp0o3j4AoGoI3cjL47Vw/I
    nbTHhhA/GJZBW7g0XiL616r7LDtgHgTkWUHPGolNuttXZCJjIb+KgJES1CkXXWn2TJdKIm
    Zwxgy3lp0BYH+b8Y8OeUQHhQyPz+IdRigKfWzIDoLKtI86mRn08YUINxAk7RkhgmsV2SGO
    KV8Gaor4rfkNGIc2c1qCUSG3IxmEvImscbhILDcy8Hjb8h5sWlYhsuWcz2ebMpnA7ZUQ4b
    gi3NMXu8TipSB47Oy74nODL4cLVWxk230zTChNsPsaV6k3CwtCh1CDhYGTw6YUjBqx5xs+
    aH7KmoI8jFKXyj9KBZvhzqVjP7zv9M71QuEfwxE8N/RjkYgWZUo9hYY9rZi3Oy1D7Colgs
    lfEw6KTK9kv6RinunxhJlc01MNWAFFvnOupXOwTVuMXVZTihJWbxbMjbiKvA
X-ME-Proxy: <xmx:k2JwagzJvP_lHyfhsQ94VOEQMuYXojGHSkBmqyeBHBSW5y9VxMEG_g>
    <xmx:k2JwatFvzL1D8pDdJ05ov_nwn5m1Ud8G7AFezirmxaEzeiS7AIO7GQ>
    <xmx:k2JwajoT_2zXl1S_WambTCtG2uOMJosRVFyWizI0iVuMixMlWQKc1Q>
    <xmx:k2JwajxQiDTCPdqTphpZHo0Fo-Ez2I9C_ub_B_c259SsvoULVlxXiQ>
    <xmx:k2JwaqGaOl-2109Mp8-KdNp3A5HLK5WME-ByDdvcnV716AixDeeaKASI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:42:36 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: royalnet026@gmail.com,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	krzk@kernel.org,
	will@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v4 6/6] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Mon,  3 Aug 2026 21:41:25 +1200
Message-ID: <20260803094125.3285895-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803094125.3285895-1-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
core from vdd_npu_s0.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..965e0906b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -442,6 +442,7 @@ regulator-state-mem {
 			};
 
 			vdd_npu_s0: dcdc-reg2 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
@@ -869,3 +870,12 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.43.0

