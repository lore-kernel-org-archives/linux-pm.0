Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FAF4BD7B6
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401874; cv=none; b=nh9COHTRxsbSmOYbde8hkuvHHbgkWgb3OW8hVL/DiphBmr0OsX3xPTgzbCwvSjfPoiXsPvyjQElGtnDmQiaHFLF5AhZle0QEIojGyLI9ns5Vwz3/w7Cq6jxWrXFtbr8z9UYJ5d8xr7tdO5ZvcSX/1DPdBWKpXszc/HQ2QwcIB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401874; c=relaxed/simple;
	bh=X3gkuVRX8tdhLti2WNzQTsQKzVS/D9O3ELOwUGL+GC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLUGIxvFOjjxRAF3yIZDRL7z4V9C41MmyT4P2yCfRW9rqZ/2wC8kwsITOfKhG+USqCVuMg8azIPx0YsmuYl4BbYrt7HO/SBcdEFzi0fDO4NvEVvm0od4cMFoK8niydSQzEP/zh3wwQUFMaUnXamiuoEZa0gbs4A3CbDODiF0xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=OHpzFPa9; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="OHpzFPa9"
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id DA88D610FC
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 11:24:30 +0200 (CEST)
Received: (qmail 17512 invoked by uid 990); 19 Oct 2026 09:24:30 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 11:24:30 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: ulfh@kernel.org,
	heiko@sntech.de
Cc: leonard@lausen.nl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	detlev.casanova@collabora.com,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	inindev@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	gahing@gahingwoo.com
Subject: [PATCH 2/2] arm64: dts: rockchip: Fix GPU domain supply on NanoPi M5
Date: Mon, 19 Oct 2026 09:24:16 +0000
Message-ID: <20261019092417.391522-3-leonard@lausen.nl>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019092417.391522-1-leonard@lausen.nl>
References: <20261019092417.391522-1-leonard@lausen.nl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=X3gkuVRX8tdhLti2WNzQTsQKzVS/D9O3ELOwUGL+GC4=;
	b=OHpzFPa9AHcbe2SSrRNebQ3tIBItFPrzk58HxTXH5GJAX8sFJr7rei2dB2X5B0kohLEyMkWi6f
	DdPVoPL85Uv0lJkCitUc/tTkuKt29G8PyT0/Fpqjx9/anhGBb4r8GQ7BMX9o+T883loTcbIQaqgV
	m3ic7YI/umBmsZETkwg5+kYvQygncU5RgicxvU8nve36v/pvOlXE644JTC7yjYoZ3s/knCUKEUUT
	4E9TktfaIQ+/4HwNyfAJUR6ozajbvGiRnK6QFaGdQDivVQvbyUvVciu4IlSd3rt7YFGhkrzdYvLk
	1mXk0SFiIdp4+un3edwAkuAHDkXdrk3RCZvYyt5GeSrc80bvnDcSvOBWshA8Dy9AuL+se38PqNoh
	mbAWRnNaq+Ewy3GgX7aUITA9Z6xdopFUjtHwrs7GBlTTjEU4KkL3yfBELqZAeI2qPpt6+lKNimMM
	yLz9V91ERp4vGqLvwB628F/mrcCx3MYkS+UAJozv7J+rG6p+9O0DRP6+NILQcVnIj/purQXsPEeV
	UtwWA9YtlhgptBWYKlY/dSCkg+4MkUadVKnlP4mccDVPXxDjcY4RpbJxoXQ5uips/OrI1pV9yB8H
	/n4uwhsxawjyAznsOpX+Enl6ZDbIxyklWncHXLR3dLcIIvd8JiGB2fy+Q9ylk8BxNF72C1mYaMu8
	Q=

On the NanoPi M5, boot hangs during Panfrost initialization. Before this
fix, booting required blacklisting Panfrost on the kernel command line.
Loading Panfrost after boot reports a GPU power-domain acknowledgment
timeout:

  failed to get ack on domain 'gpu', val=0x113ff

Label the GPU power domain and connect its domain-supply to vdd_gpu_s0,
so the power-domain driver can manage the GPU rail. Keep mali-supply for
Panfrost's regulator use.

Fixes: 96cbdfdd3ac2 ("arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support")
Signed-off-by: Leonard Lausen <leonard@lausen.nl>

---
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi          | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
index 227fe6f3ec7c7..c056b3eeafed3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -791,24 +791,28 @@ rgmii_phy1: phy@1 {
 		reset-gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_LOW>;
 	};
 };
 
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_perstn>;
 	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_m2_keym>;
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	gmac {
 		gmac0_int: gmac0-int {
 			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 		gmac0_rst: gmac0-rst {
 			rockchip,pins = <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 		gmac1_int: gmac1-int {
 			rockchip,pins = <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 		gmac1_rst: gmac1-rst {
diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b1b14..0dd7e9ca908ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1075,25 +1075,25 @@ power-domain@RK3576_PD_NPU0 {
 							#power-domain-cells = <0>;
 						};
 						power-domain@RK3576_PD_NPU1 {
 							reg = <RK3576_PD_NPU1>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
 								 <&cru ACLK_RKNN1>;
 							pm_qos = <&qos_npu_m1>;
 							#power-domain-cells = <0>;
 						};
 					};
 				};
 
-				power-domain@RK3576_PD_GPU {
+				pd_gpu: power-domain@RK3576_PD_GPU {
 					reg = <RK3576_PD_GPU>;
 					clocks = <&cru CLK_GPU>, <&cru PCLK_GPU_ROOT>;
 					pm_qos = <&qos_gpu>;
 					#power-domain-cells = <0>;
 				};
 
 				power-domain@RK3576_PD_NVM {
 					reg = <RK3576_PD_NVM>;
 					clocks = <&cru ACLK_EMMC>, <&cru HCLK_EMMC>;
 					pm_qos = <&qos_emmc>,
 						 <&qos_fspi0>;
 					#power-domain-cells = <1>;
-- 
2.47.3

