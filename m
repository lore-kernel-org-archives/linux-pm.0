Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F43DEFF1;
	Thu,  6 Aug 2026 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998182; cv=none; b=OW/xE8+4tPvpBHFeyooTOrAlykvK0Zpp1Ww4PuaF42v6I38d3FneHf5jmRQaMiA2X0XUAXc0HDXNLjgbSevihwiT+PzbiOK4rdb2r3xHeiKqZJicZceBleN8aiwOnP1bE1s8GqKbsG46LZOhvsBrLfrntW3DYo00l6MdDjzU0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998182; c=relaxed/simple;
	bh=U4X+rhj/sXR+vtuG+XLMw3JDpabQzZVg4RMgkgdiYpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceISx3wf9YQ8eFI8eHecmbEdyQgMGHPPr2jb2mzn7rXzspi9yKBZINjujlhypyuHYu7kkAk7DLUUjd4gmrlTUL4d4hm/78lcWJdB3THO+LEGt8+wF3p7gZMhYBRNyoofHHPQw+LxCti3AzhnkLtXM9RmiJ7LpPHSVQhhBhbudhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=1puoFuVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9C2+b4U; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="1puoFuVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9C2+b4U"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 995101300165;
	Thu,  6 Aug 2026 02:36:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 02:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998164; x=
	1786001764; bh=sgu7nAbq8Yx5koaOMKJWboxHdobCAGSow6z6pMfKPGU=; b=1
	puoFuVjNERzwVWN0t22cIXz+deO4xgXn/Yn+6FkOmLHlXm7cnNgXO0QN68aO9ILC
	LoiLk/7MWB9BDccQuLdx8iZlM8QB0Jg7YbzKXGuaMx/fTiGSrFIbyjbeKPFn1Hfy
	Bj+DSKqFdmB4Y+W4TlE9mHo4istLQZGxbOp28FytrB9vz/A6I1uXYfu3sXedhMU7
	jDtyFyVwjHm961xc6jzuZoa7jiKZlbM5oalpIVzDOaj4OaaT3mc0Ia8aaoWE9dDw
	Fv6/nkCs/qPc9rLzraCJg5d77l4fW1Wm4Mn0SGsA7Z7rThzisURGdBadHAh9kS8p
	NtUfBxsEp/Nrd10GoRg0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998164; x=1786001764; bh=s
	gu7nAbq8Yx5koaOMKJWboxHdobCAGSow6z6pMfKPGU=; b=G9C2+b4UWlPuB3JYP
	uLtmvJRPN4B6+j0SXyZff2fi/mbZNtkI5BsPTzii57azW83r4JPGnJn+oP87LlXu
	uzMK5FoIAp78F9XIfJDO/Bc9TlUCyZgtBB6LtaVq3KqvNDVgGlARRU9ZcwA03RKc
	fWAVBiJLW510K8TZ0MmP4hqyECLKIb1p7Y2Nbjl2fdlg5z02GLLJHkfNvfKTRbOf
	wxXfrhm2EfTTc3PgIb+AdKudyla9JZYzs5kR9mxlMLYtcjNaRG0cRj5wEtQilaQn
	FRPxJxcXywGFvrJ2OGuDbUWjgzaHA8gAmW5PpzvYkkuFUuEqE/XlrdFVAAT3z6+A
	2n0zA==
X-ME-Sender: <xms:VCt0ast72_PppLC-vbFNWAr4fmvLj9QXF77FP7toQlx2Tuo0fLzMzg>
    <xme:VCt0allGcodj5pUuAqPS3BSQ7an4MpprS47MBseXp7PZ33Qu6kor2-6nd80LEMab5
    dZxXofTHPGKHO43iIf56rsw-fz1566dDA6MgxrLIGnnlfeKCaE__UaS>
X-ME-Received: <xmr:VCt0ajk2MoeANJT9Wdyf_MA9nQ9R8p1RXOvXsjkJUd5R6CK5bMjlsYAnEc-dHw5vdIcMhPYTjg>
X-ME-Proxy-Cause: dmFkZTFONgeA2O3pwjIbPcMCTqIJqr8rt4x9wj1HWpKtWqUM08CHxAytH4b3Wcxne+7M9Y
    PXPM0VguFKPHRj7GsPgHOCGdBiHCvhUSS0VPsXiwRKvCWrXPAstwqnluAM2XfUZr49eWpS
    e+UecSjujmJ2AT270+mwV76lh/D6/9znIOY6mQx5cMF79T+XdTHspX14zKQTkVq2imOTsH
    vp93U39Lnk9e3xSvtrqjBURQNo6oCQMtbFhYzXBG6dEvWqKT8clHR5x+RedZsGjCkMON3x
    w67ON4vBChW2U2GPv48gIMgNJJLmEWZg5zEIGItcQU7FX5BKLMjAr+kfs3S2cJ4Ku2vNei
    eTyzZo7cemSdKbqcslTdF9+Fnu6Wnz4g9+SP/0PbxOIZE8eibAnqIUUyYrpwfADWd8/jkQ
    lyZiACxDgx6oXDCrfC75glZna01b4xAevCxCiaFfAJqGJP9faeFM9Zqtowd3xeiNo9JDG8
    sQZoBFeT/sjP33Sq6xmNDkviAk90SnbPS6sC/dCYlVmUFCE7qI6m0SKYsfQm7Z5BG1nfOl
    I3/74cQkajuQVirurXoz2U6V0p2pKZC8lAqpTB9XLjVAYR1m08HfIcgnKVrE/pnSXn2IHW
    kgORTPywBrs6TDNtcDLqwDCpnKfCeAZtwCPFUjdUjIzIasboxPsOfrMoZgqg
X-ME-Proxy: <xmx:VCt0aojnAKsgkWNOX9a1LKyPFFgx-mQSnCJBRtXQd3VwGT7-mJ96lA>
    <xmx:VCt0atF1xf1Ud6hOaB97940z0VNbJ5I2zp9gom9BP1Cd33SsAsOPrw>
    <xmx:VCt0arblB6kuyR8R_IRRsl8evZYmQ2Dsa8DnadgUAAlAa30MJRqFpw>
    <xmx:VCt0aoOv8qyUnC-n_2c3zzJCIcFdlDdVGqC-7N1M-nCs7C_2ygC27w>
    <xmx:VCt0as3pvbaerTG75kRiWOpxwx6SbePvKk0caBaqAS4ASjQMqc-0KdN_>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:35:56 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v6 9/9] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Thu,  6 Aug 2026 18:34:13 +1200
Message-ID: <20260806063413.350184-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806063413.350184-1-gahing@gahingwoo.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
core from vdd_npu_s0.

The supply is marked always-on because the NPU power domains are what
gate the block here, and dropping the rail underneath them takes an
async SError on the next power-on rather than a clean retry. Only
rknn_core_0 is enabled: the driver binds one core per node and the
second core is left to whoever can test it.

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

