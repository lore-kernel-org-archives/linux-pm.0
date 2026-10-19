Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C148FF63
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401307; cv=none; b=a2V+8P6i+P0NDkx/xp7blM1lxWJUEbO3KHoFVEIwwD5msXEPkGoUZVUf7gePt6sN9LNisFvQ4fndX08uOlEUM4VBEeOGrlgtCAIxFAESNMrTep3upY/oWh42MBZRVyw8t4MRhz+0bK5I4mZCgPh3zqDVMvA0ZqjwUrj0zGfAtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401307; c=relaxed/simple;
	bh=G5e7xDGKZrF0gm5xtX9ZO1xpalWcEwZGn20RV5qhZOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlooibqgebWN90mKf8lVsvGXcPyBbWGPxVgE+Hp3kJb/IoJeLgRmCBOYySQpEAOqrOoqcWSsfbGNFAX7HLgHu6kSdcIvrPI+Rz81ivI+bimdpm857cx0sn1arX8DwzVvmRNifuTYvhQovRMpgMqGl4dQwZildGkErJpxzDUDRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=f/xc/cIQ; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="f/xc/cIQ"
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 6E88761014
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 11:06:11 +0200 (CEST)
Received: (qmail 9972 invoked by uid 990); 19 Oct 2026 09:06:11 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 11:06:11 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: heiko@sntech.de,
	gahing@gahingwoo.com
Cc: leonard@lausen.nl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tomeu@tomeuvizoso.net,
	ulfh@kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] arm64: dts: rockchip: Enable the NPU on NanoPi M5
Date: Mon, 19 Oct 2026 09:03:42 +0000
Message-ID: <20261019090348.378183-2-leonard@lausen.nl>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=G5e7xDGKZrF0gm5xtX9ZO1xpalWcEwZGn20RV5qhZOo=;
	b=f/xc/cIQtFrsxLz/Lbmo5IdXDWN1Nrtyv76OmaMwgrWVwizASO8PSVWBL6ZVrf1WYnh+GQI4aL
	vNTJS1mQD6I373/xRbpDJJNBrDqVzQXq68RrYD8wdr16Rz33/Z+qiX+uZnpgpY1rPPtYNxIs71rS
	fyw+4eM8gaAhIBMGy0GpLzOmaPMFUSDm1KXaP9GOkrsfPifax5LEjRNEQDfDHyNzaGHSyweOQQCC
	7k14CJO8hoR9LjQZGsUV76vTX1lwVOz4HSZjgCs7/IBXHM9Jeh9QbNrYOIk9FUwbGZJ6IMWq67bQ
	7AR+3tjyCMwO9UyLj9VHIcRsv0+8jVO8k+CV3c7M7XFIYToZ1fdbQtDMCTHrZBxM95Xi+rvEKKxU
	T0r+1gy8O4Dg7mlZpoHy0mqUVWGuP310FSQpfMOGNJ6jkbrniiRo4YWpKueM1ZiazjwmiI73tDCf
	WsphzaJMUij036yyEUDAhHJ1CzsXxLZm3S1KCppCXV/EfPlUW1FHW+GBoq0EP21deYfCAd2beibl
	BKptxgUHHkOY7k4skd+5AHdP08DO+5NI7ZIDXSMZ8kHcEtaeCCBRm7hCLwlTNeXBn4Mf4HElO0UM
	TGxV+OFP+FaG8sqpTVcVoTGIiVdGrjvqVh8/GgRSe5JFNQfzFWqc7At4jQ4bvzaAj2RSW3LjDIy7
	s=

Connect the NPU parent power domain and both RKNN cores to the existing
RK806 vdd_npu_s0 regulator, and enable both cores and their IOMMUs on the
NanoPi M5.

The domain supply lets the power-domain driver enable the rail before
powering on the NPU. Each core also references the rail through its
npu-supply property.

Link: https://lore.kernel.org/all/20260924102135.92217-1-gahing@gahingwoo.com/
Signed-off-by: Leonard Lausen <leonard@lausen.nl>
---
Applies on top of this series.

The NPU has been tested and works on the NanoPi M5.
The NanoPi M5 DTB builds with W=1 and passes schema validation.

 .../boot/dts/rockchip/rk3576-nanopi-m5.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
index 227fe6f3ec7c7..96c21838419e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -800,6 +800,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	gmac {
 		gmac0_int: gmac0-int {
@@ -877,6 +881,24 @@ usb_otg0_pwren_h: usb-otg0-pwren-h {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_core_1 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
+&rknn_mmu_1 {
+	status = "okay";
+};
+
 &sai2 {
 	status = "okay";
 };

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
prerequisite-patch-id: 46ebb679e93d3d25393e8cbf8fc3c955bcc01bd4
prerequisite-patch-id: 0a572164fcadaa890f0fcd7795e9aed71b4110f7
prerequisite-patch-id: 7d00dce28af9d650165613b4e63fc1632f1001b0
prerequisite-patch-id: 1f4f63a13e342a642ce4ee33c64115c7ec09998d
prerequisite-patch-id: 30b7597254007acdb9ce6f76535df17a896b92ee
prerequisite-patch-id: 8f7794535e7def740abb4c0c154cd2dec15b1c26
prerequisite-patch-id: e6dae43a32f177292235c896dd7534e704121afd
prerequisite-patch-id: a18dcdf841b6975b1e5be01a931430c0a5711f47
prerequisite-patch-id: c98141bac89990a409fa2a6d3bea93796c9d58ab
prerequisite-patch-id: d72696eb07efc69faaee3da39b1995d2b2cef289
prerequisite-patch-id: 6d5c580e02cd2ba4e1f0a590fdcd49dd643b91b0
prerequisite-patch-id: 48b926e205e294a27d6e11d00b10d98205fd4afb
prerequisite-patch-id: 8babd101cd3628a478872e8a28a9081906b87160
prerequisite-patch-id: a0129d3f560f297a03780ef78be819e7aa0775fe
-- 
2.47.3

