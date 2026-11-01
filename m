Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521560;
	b=tYi7XyH4HYnRZ0MusVc9Xq4+Zt+1S83dV6xIxW3Zd6+pL3RAiWBLqWja1Z0+0zztCa3m
	 kR80z6gv674JCiN1+KXp7LbtAPwNUnz0mpRrzz8Ujx2vC/ihSoTq+ceF4j5Qtv2/LIl/n
	 v4rDAGtf4KeLG/GAdP1XpkZt6P3XKSsRh0bgDhV/x98oeGoj/IfR/lQbB1UwSD2/dx9Jf
	 moEEBrNteMOA04SNoKVTIb9AXqFGg6rJAMmbMsmCw5IxhLGmzPzD46U4Jz9H6DK9O4CKp
	 Df94gOnrRB/Q8g7Bk3qNSgyKY6OZc9qdnp+HXG3xUWynhEiagkpDwMbFo8JZhYa36+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521560;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2zyzlQZVxKaIY0yOEUymbeRyYHxqKX5mByILgxzc0jg=;
	b=b9neopqrIELVOqfVD4iOzRwcj7O5LJWqtkc60Ye3hWmgqCLp6wKRzhrkFPJDTvDb6HjB
	 wlX6BU1WF+w1w+TdhOaUCLqd8ltFfZfgxZKJGmXr3A2gT6afjuA/i7gM+7eyRMNNFZvU8
	 T+/G1SNjY7PG+Wun8gGUqZGd/FN2ST9AcK8wjT5zvAR5PQ4EDJPz+cKodeJ57P1wm59p+
	 7rgUZx7VeUizYoZvm3kxZXyZMFt9DRQcE9H8e7XZ8E3et5lIfDR0ti+VUrftJZ1MTeFd8
	 K371a+w2/ot4UPohdQYy/7RgbbFc+U5bqP48poVT2vhhhdDzW4wLC7kj5Q3nNM/95sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=OTpDs1e6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H40mRjH3;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDC606A326
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDDC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=OTpDs1e6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H40mRjH3
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 44287EC0692
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:25:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 01 Nov 2026 03:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521558; x=
	1793607958; bh=2zyzlQZVxKaIY0yOEUymbeRyYHxqKX5mByILgxzc0jg=; b=O
	TpDs1e66qboqgxG2PpC16j2sH7TJddbo+oVPEpaRSHVhke3x8rRlmt4ycjx2R7dY
	/69lyaSpRTAsqFoQwBaW9mPW6jcusRd3aF8upzuJ9K6kHQ+PyrhZYq6wUsF/Wu8e
	ZS4xVSbT0GjLtXbfXNpnsh9zwz1vIwxFuRMplbkPlSHyhrSGsCdzb2Dgc+hHumep
	r9DhNLBfFA3qAwym6jjttL07IQ9E2j1P8cBaz3AI6X41WZDI8fKCr6iYkel2jQdD
	MTocZAlEsEkHjLZI0enuODUjZ/VRVCOFymLpl1ox7Xxi3L9S2n+t/97++/FO1hsm
	Ge/cSWrJsJOTWtFe8vIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521558; x=1793607958; bh=2
	zyzlQZVxKaIY0yOEUymbeRyYHxqKX5mByILgxzc0jg=; b=H40mRjH3c0gCWrEa2
	ZcN6DKuy5m+/f3cp+iLyt37jF1O4+mR6K4ASY7c3fsRQE5GgW41wu9hywDxNpZDO
	Xo8oxi2DTsQTZBHWBP7c5gB6shFXnI3Y1hrb+CP2DrItG7us2bp04RQqyYk5/3gx
	evDH44u9VE03Z3pTZ2mfKZzMgZJDleJ0fsDrH3++cdFlxyXZoLVbkH4eBrhP2vEp
	BqFovapOWK277RrJmOS+tviulbq1vyF/51LHrlrBtQTFFtkJ675B/HvopAbyLNAk
	3Kw3wvO7dS7tkBSI2omvUvdJVFkCktPVigfO+GzD+201SYtkSw0RtbjWpymaGw4s
	+MlEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521558; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:HOByjPh01gtR2xusXJdEnLU9hubmUA/YR7VSgMirLOUAgaV
	zalk/2S1DhdNSopsgmNM+zZL3YmpyqWiPTKvMvAZUVbpXRdQ3KSf36b90dR4LoBy
	1x9UoNfHlNgw8b4V6/5TqY4SVHoeN/hrgDoF03QEl3FSrGb6usInhd68Fx2qFxyE
	7vLLqsDIRo1HPsGQweq+PYfPPxmDsoq+q7+Sz48dAsCegkQ+Ipg6zsF89vKFxLbv
	eEtLcqRcuGOY+A8pIGF8O8g6seJErjqG1CmWcmvh5dneLo7QVjdV1Cnkr0g9KMbc
	WM7ohI9s8TOTg7FE+43NRVPUNoGf9LvzFAYcw+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wv/eGDeElSENTGA8Ghx+iULvw+yggP6rkdnx5gKwE3g=:lsPRW5tbvjV1yB2K11YVzDhVzncaGOx91nla6MReLdw=;
X-ME-Sender: <xms:lvfmasrw7k8yaVKHeIUXNTqL-SMeEiOd4l2tWchfSFh9zGXbws60PQ>
    <xme:lvfmak-mQ3jm6UQKwItz2aTDrt-nnpoMXb7djmqVRZpWuB-o8I5luVdQ8BeJ50re-
    LsHErccyN4cwKeTjb7kjvFuNrVl0J_RXTclRRQPgREEsZluOt_iyO3H>
X-ME-Received: <xmr:lvfmav4m4Ou89MxTcoRt5HJBrRJRbdlErDs4v_jRxEbpFdpuHyHDrgwZI1TyLdPCSHJcweyM>
X-ME-Proxy-Cause: dmFkZTEio0HITRPU8VpT4PebgbYf+HqQTVmTBwoXIcaWhSPJQuOpCGNL4Feyfw1mm6jNto
    aCqGt+GjGmHddQdDYMsFOcBW2fd2wbE1C2hSqpUPgYFBCtzpG0VAhrL+r+dSJb3xHPmeXu
    bbiU80H+3s8diofjGu9JFbSOoisVQrvN3eDU6svi49hrmcI63rUfSkuUe5+aUvGFuszdig
    Qnc72eHSOddgDW0HvcKHXNvldok2Sz2296F+6Jr1XxRzNWV9h54MRHCMGFMHXdGms8Xsm1
    Bk/Rw1sBqh58/z5F2FEqlRBvxPnvur8T5rxLVrR8npGrMSSnol3N1co7aLduCklPXA/va/
    YXTHoUsCnKY9azuEaJJ5cCfMAuVhudV4dodqOzomVIYegi3ufkxBF55rrFoq3iaq6LHP33
    T76ZGeyGkijxFWxFlKRfgjr4wSs8XktqK9Cmvzz6H8XrlQbewx5zl72aflAIu/xJmUigHe
    ihwQFF+zsQXm5SSJ7HLlnBh5Kz2GDn0QnNv3awq93FX17kx4AxbOt97kEUTVKpXIVoXzrT
    xIXSHsKBUmxXWaF7TwhMQP2jYb2EtSIjvqSLK9L+56g8vFQOYlJ8YJwAmO1+lut35s9urn
    QvjPedj4/VeZ9I8NgTPNqwLUBD/0eyh+oDkjX0x/7kEUCaaYL9QzhA12nA4A
X-ME-Proxy: <xmx:lvfmag3kzYBO9WRsiDPs1ACndkAeqVnYC2zDsUlRioWhP2-sZPpzXw>
    <xmx:lvfmapjkGvKVYjvQfdTwGLhPQ62aXV3SiAYxBQ8ES1P_HdZZl8eyvw>
    <xmx:lvfmariUw_ppVMna6bgM_sYzZep3I-FyI8HA-J2lnXjfB91kZhx7bw>
    <xmx:lvfmalK4-DC1STWBHZWukQl1gPsGcWwbudOWBVlx-nTZY2ajX8FAeA>
    <xmx:lvfmam3Tn_xs7OPK_vb-d-tEDN15IQfKJm_Q4C2HTj2qrjyPjgnNri8T>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:25:50 -0500 (EST)
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
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 15/15] arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
Date: Sun,  1 Nov 2026 21:23:07 +1300
Message-ID: <20261101082307.151957-16-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable both NPU cores and their IOMMUs on the ROCK 4D, and make vdd_npu_s0
the NPU domain's supply so the rail is switched with the domain.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index f068794e48d4..72b251d396fe 100644
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
@@ -779,6 +783,24 @@ wifi_en_h: wifi-en-h {
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
+&rknn_core_1 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_1 {
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
-- 
2.43.0

