Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE8485CE2;
	Tue, 15 Sep 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469192; cv=none; b=fxk5nI9JpWBlMccbP6k1pWvYij7REuYk7a0DttW4H1h3Ge6U1oN9ZcZ6Fn04Tb4+LEv9x/wF+I/Pq0Jv4EsCu53LZoJXuH6564R/IDXbZNKiS6OpUYpC5jC67+SW+P81Xj1e1+2wkfxyCTx8cjqqvDQgGgUtBhuxPJ13HAWas18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469192; c=relaxed/simple;
	bh=D4ppPQapyLhd/s9SIDIm3/DEZoesU7DqcPjoruLNSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf2S5FJbwNyk5yR2CjR7SIYEdsR6/K00rKbcMvmp8BCA8Oc5THriuHalTJhBQNOT8ISwEh/x3ltQ4g1f9J/PD51kg5BlYJjCHxukUH6OLZI7z08dsDM5xsJpx7Y8GHcsJcpq9ejbRpm+noouR4ST6Y4/psgUJLidIrgLisgZYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=o5KcKxv/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+jRTOGW; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="o5KcKxv/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+jRTOGW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id E4CEA130050E;
	Tue, 15 Sep 2026 06:46:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 06:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469185; x=
	1789476385; bh=0k2WO5fN2pPgdnD7jJ6cdxK1ff8uhQPVB9+e5XeZDfk=; b=o
	5KcKxv/SlV2aYjj0KfjiwqAjYLU/J+yZ4Wg+42qPde9qFeZvxLQ2rwR3iKzjj4bc
	W4Z9gQ02OpW9Ea6eEGxBrBB1lP8Q2/HoBxkn7NYRajwK0KjZC911AfQv8TJsa0zL
	3htZhYruMmYsYuQjHFV9chxWRcRR1A58CTs+blKNLNjCIUndc68BWHDqTcdltfOw
	0p0rme9iLcfYJsSCpYJ1cwyOcAoAJh2Ti4EWHQ4cvUKYYwvLPNOu/dkbPbWFPQN3
	6L2uFEay0F8S2qk3pTBCPJxpztTMUF04R3GUZay6TjndIYeWw5JqkvLdIfcVCaKI
	8CzVuB9D9RzMoy6B6hpvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469185; x=1789476385; bh=0
	k2WO5fN2pPgdnD7jJ6cdxK1ff8uhQPVB9+e5XeZDfk=; b=a+jRTOGW2gW9D9uRd
	58qAB2jFVMu687OEygroRLYvOHTqlqcoevsa09QZw19JfgWWwRSMJOeOIJ1oRN9B
	s/KCkeXvl1D6vTx+U0yKCdxa34GkeheHmC7XrVlVZfDQANh9Y1pSwuemxg50SEFW
	9/K1rczH8Qorot9wneCm501+E3iktZ54ecMmMmHC1afyjOEIR6RYGuHr95vZKbJy
	BIVmDvj/bLjWG3CMV+tz3LiBXdH096RUoo3q9vM5+2YJgutpMvshrp5qhL+SDb4l
	iOx7SgPQxzvMI6HwVnl7YG5fL5fyW3qew0qUM9FsFozDe1lZuY/3oO674iVk4deu
	gFGhg==
X-ME-Sender: <xms:ASKpaizMRspP3fbEvI2dGg0t-RTXliI_XiiADwnKD57TFz0NihB0pg>
    <xme:ASKpauZWLIo-vyYCI-R7ULaRwWjZpCYqsmSl_VJx__fzoDyOkrI2YxS4a2cYN9_mt
    SXWWq6yGToGb5o4NhW2Saw1NsKvDAWlr1q8KYqXvrIMdQhmPgvYzsE>
X-ME-Received: <xmr:ASKpaiIC0jXkdKuoIMc0YMCl3QzKJ1CUQPl3wcDwgbNzSK3JfJtdO7NpWKtCfxONG8RtIebaow>
X-ME-Proxy-Cause: dmFkZTERaSqH5KPECAN19InuPeLsiKMx6D5y15UiNi79LQSE+6PwQZueGcEC5S1rOFrK3s
    AYJQ5gLhphYiIeKw6agxUW6Fop3EpWpekZBzn5CD9c5ViahuaZguxQ6ney6sO43OfzeyFX
    kYhoR9UDnAzR8pnmcjQlc+x5gLPOpxNVIBYuMwia89SdQ/qFDD3jNxIWu4HvJyRrQkT5fi
    Bc2tWX66wGyq3ia2uvvLsx+3+MQXh8ILcdhexnLin+iBHzzQwqqqN6rvF+dRwz/tz6mc79
    V2Z2N8t1wVU0baTbSz4IGhSDBvU+gOblwoPbiM80kR6dUxb7moWmec21zQauVhFlqpiZq+
    vpW0GhBX31bWwlGN0QFZ/wI39d6+Fet+dUwUDz5xKxisTx6SB3mk5UuglUIe5BsqJZck8R
    TZ5r3ICH6hOBlPs29Do869msBDk3MBAG12RC0wVjVCLn5K+URgWZ8eGYfaxral+2o4ELka
    S4o2LahSPRTF8U6V+UNvoq5fHZQ21M73f6wKlYeBfP4nd7vfxuuIIjSbTzHtbyUh2Ps5D/
    NooK3dyiiu2xLcMiqWy6Sx9UoOaN3HueZgsJbt/7aynudz+zMJYu+7/oTzABlpdKLo2m01
    WWr7b0rPSU+KYpcPkJ05VaRdzLeSUFMrH2a1A2a1jzwlUIM1QTcdgtVs1PtQ
X-ME-Proxy: <xmx:ASKpasyzop8wr_1qQHyjE6ogIMVjYNLJx7VmPdpEFT1d6_IPmPZAug>
    <xmx:ASKpaiOE-SerW_LfM8vlP-XAzDNYULceF2hJX1eCLBsCIJIXRbXjJA>
    <xmx:ASKpaouovgujGa6FmJeZf_TURPb3_Y1G239Aivjj0M-R6SLrgXhe2A>
    <xmx:ASKpan3LMBlQPNMFWOovbcFLvxu97-TWDHE3weardQIWY5ghPKKqog>
    <xmx:ASKpatEaD5OAsnQBocHErXMdYUVIMi2yBP2_aCANuJrBbGwKS181LExo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:46:17 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v13 14/14] arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
Date: Tue, 15 Sep 2026 22:43:28 +1200
Message-ID: <20260915104328.45901-15-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable both RKNN cores and their IOMMUs on the Radxa ROCK 4D, and hand
vdd_npu_s0 to the NPU power domain as its domain-supply, so the rail is
switched by the domain that gates the block.

Measured on a ROCK 4D with this in place. The rail's regulator debugfs
reports open_count 1, so the domain is the consumer that took it. A sampler
running beside an inference caught use_count at 1, and three reads at rest
report use_count 0 with the rail disabled, so it follows the domain rather
than staying on. Over the same run the genpd active_time of all four NPU
domains rises by roughly 60ms per inference, and the inferences either side
of that are 128 of 128 channels against the CPU reference.

Both cores keep npu-supply on the same rail, which the binding requires.
v11 enabled rknn_core_0 alone and left the second to whoever could test it;
it has been tested since. Both cores probe, each with its IOMMU, and a
runtime that deals its submits across the two returns text identical to the
one-core run over nine language models.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..93d59c0a9 100644
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

