Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553374F30DA
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615923; cv=none; b=Nv5gyKUALy1ABkaRyyZeUspGHI9qU48dt46b8ElIYqMWB84x1xk8wWHWOBZt8lAjYDB2lY0DDdwUcnGYTrC8QzMGL23XsbqLLNQ/cLWyseUK6jNb/HfzlFXWg7ONzcG0yrHgNIxjSQuS393GkItlTzAtHFykJOi32paGMhuf5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615923; c=relaxed/simple;
	bh=GSDTTVtVozpx3VJNNfeRSYeJA9UCPSmKB3J4qrce5Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgCSC5bz+OQAZYC1MzyIPl+PzOnbqE1D5abmNwY5AGpzAYCS7MFY2wAmb2rJsVtx31qcGSGqWBDLz+zbly6j4Z5C30KvAPCU8ljYUWxmlUDJH94v7S/4uLxL4w87AYbMYegANZEc2ulyIHCxxpnGrOkBEatE/GO0H4ZDes/VJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=lpvouWgf; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="lpvouWgf"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b926f0so2099487f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790615917; x=1791220717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKoAFSTyhxJJ9frySV0GsBnYnyW00C156g62nhJmL7I=;
        b=lpvouWgfM4I5l8wQ5851jrCQ7UQQyKxCz0DP6tCgrdlDHHXENQFTnxcYn+VRq7Kt3Q
         YbifFGG0/UieoHOVS0LK9gRIPprXxk2v6lu9YBxZ2N0udXFdotMSfR/uF0yt+n8tru7W
         HEn/MPsrrbhgWiLGRBBxN4LOZqKUq7qb+dvt/GkuIzOJ77r4V5ygPrApcDd6hnU58Ba+
         qdETt1XQOBum8LAgH/FZrG93uj7XQ+9vZcj0lMZivU4STXYC2qW0RXQ4kxjU30grji09
         PnondSkC8bhin9g1rgMbrcE9QsRp7dVoWDH0H4vkT9meLhR1Aq/STTmkYDVfCRTSSjLJ
         Cf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615917; x=1791220717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKoAFSTyhxJJ9frySV0GsBnYnyW00C156g62nhJmL7I=;
        b=av2I8JQr9HLe4KUgBpddoCCY/J7OsBrZJqHrD5sLHWRo5+pgEZbVpPbXzwhVIzquR+
         AlesK/WXuqcgSMdV28pSNychg35IJNWVr+hjOiZf8HqeqxDDOGgzKGCVDFoQErRxkB/P
         bmtTaLmLj4NvtiWqhxh2lhRsP7RZOK5M842YExcgUzbTFyQyjnWZuj7TIbt6UKXZy0JD
         nsWB+6C2fZDtPOhzkczxGMFlfDzExwKhK9QL6UX1q2XOKqIMZ5kZ48tUNNrccU/oRJ8I
         kIdVuHaPAfgAC3mdoY+HVVGwLHgTqzq66C4PTUXVajDKeR2cQvKsaEzuw2RJio/aEtku
         5SWA==
X-Forwarded-Encrypted: i=1; AKwUvByGTkR8/V1U4QNgvF2Wp/ccdPqvKxMLuvYsIk9zC1UNuJQ/7tzOCK5GmLoE3CHMHyQ1a3weDhb98A==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+OwpbMoMKSIUnJLbpY7LuhnklbUsjhdar6zwix7+MFBIns0jl
	bY0HyMLxv3t7yo9NhOPbYzhOxNCqlhiVCgelapAMjAeZ+L0MliykSvC25Sdg20HnsnvuHL3aQFF
	UNVWo
X-Gm-Gg: AYBFou3lyESZbLMBhAxJULzlPw3ZCeNxvOLL9++Mkb3gmfwXzum8wfKlOJ4jbBiXfnY
	ypdALAgi434g/L6vlQ0tuxhZXZ9AGs7vOM4SuLD42OL9XSIQW/KKaVmvVCdhPSSESb20WEuUN+y
	eX58TpwK/QneTN7U7f23ptDxvXwtGI4IPu2uiMg3lOl4QRsfc5bCbUmRyMO4V/uigwXAF7Gd1vR
	F9fOrVy8M6uOsSYCPdd+gtlALpnX5uoEAeY7TMdfBWQTT3AmG7O1We12L02YeUyxscmGowsRWgr
	NeVDBxeqoM90FoLBoCTxN5FZonfy62PKjSaquLOvnoWDNDR0AON3EaMEqoG2f8HJr2zsPsv2a4y
	g7eLJfP4sqc4WhjeVPNgG7DbW/ZCX4xn5p+tz5BOrKeMWHcNQsFTbnBcsx+zetz0waU++kSX891
	Bmm8xdx/Umw2+00QKlL2gWBo0whhd5ej7YsaHv7IJYolNwMrG8ove1J49mbjwifsFlXk4Zga3Vv
	E0gbSNCVLKP3L2b
X-Received: by 2002:a05:6000:2211:b0:487:a3f:1ea6 with SMTP id ffacd0b85a97d-4887171417cmr25452794f8f.11.1790615917277;
        Mon, 28 Sep 2026 10:18:37 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm29224973f8f.36.2026.09.28.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:18:37 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 28 Sep 2026 21:18:20 +0400
Subject: [PATCH 5/5] arm64: dts: rockchip: name the reboot mode supplies on
 RK3576 EVB1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-rk3576-reboot-mode-v1-5-65486b03bd41@flipper.net>
References: <20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net>
In-Reply-To: <20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=alchark@flipper.net;
 h=from:subject:message-id; bh=GSDTTVtVozpx3VJNNfeRSYeJA9UCPSmKB3J4qrce5Vk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtWhhfLzE1objgdFrER4kj67Xv6uS5Fq0Sv/X5CXc90
 9eGpgnrOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqb6cZGRauctbcWyvRt/REtjnT1WhdyZehG1dG3G4LuafFJPFC2Z/hn7JD+Ey
 HiZqxx79dfRSpsVRALGraiop3H688uBfhO/lPBisA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

A reset that carries a boot mode request has to leave the mode register
intact, so it also leaves the regulators as the running system left
them. The DDR firmware that runs next configures bus QoS in the
interconnect, in CCI_GRF, DDR_GRF and NPU_GRF, and faults if a supply
behind any of those is down. The NPU rail is the one most easily left
unpowered, as nothing else on the board needs it.

Name every supply those blocks sit behind, so that requesting a boot
mode powers them regardless of what the running system happened to keep
enabled.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index 4c82980a9f63..55951f290906 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -957,6 +957,22 @@ wifi_wake_host: wifi-wake-host {
 	};
 };
 
+&reboot_mode {
+	/*
+	 * A reset that carries a boot mode request leaves the regulators as
+	 * the running system left them, while the DDR firmware that runs next
+	 * configures bus QoS in the interconnect, CCI_GRF, DDR_GRF and
+	 * NPU_GRF, and it runs into a synchronous abort if any of the blocks
+	 * is unpowered when it accesses them.
+	 */
+	ddr-supply = <&vdd_ddr_s0>;
+	ddr2-supply = <&vdd2_ddr_s3>;
+	ddr-pll-supply = <&vdda_ddr_pll_s0>;
+	ddrq-supply = <&vddq_ddr_s0>;
+	logic-supply = <&vdd_logic_s0>;
+	npu-supply = <&vdd_npu_s0>;
+};
+
 &sai1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sai1m0_lrck

-- 
2.55.0

