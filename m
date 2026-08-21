Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1743D510
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324368; cv=none; b=VuAx08/C/ydUeFB8xl6IJ+xP+3vNOE+BXvglEPk1EkdOZ7JiQ+8NNjGT+LQt7yS6kA3d1LvHvF8JrfFfMIZoQRTNEOK94RNf8OxSbYcD9y07YCoBbU20EMvQ65hRJW8tVdJU/10L6pxU+eV7AR/wck1mQnlC4JZkdxIshqJ6MHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324368; c=relaxed/simple;
	bh=rH5zmUK9SzoukX9NWfQSCfvEsqUGZmMdB2p0Tr+O7s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FECK5nKVchervSTm/ORsi2hPxd3T638ZsFjcbkMpfIWb08ALsbofmXY/vWpla0eKfdwrQG/VXz5ygGckf43e4x8BMkbxnWaesFVBZnCm4l0NvBRDm87DyPTjwiI85aa9pf6QpOK9e+PSfJGKyVw/ly4R1hhwWuNAk+UB3GRIz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuZYwyfk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuZYwyfk"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so2243730a12.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787324364; x=1787929164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i28649nrMbrzjwe7lKZ6MKTSXfJUvAObdfOOl+7VWTs=;
        b=nuZYwyfkbV5ZRqjs82ast6UW1y79yY0pumJSXBsXCiwVBIzCTzQUk2LslBg/vpbCDl
         plRABzIvlEnVJ0TntEz2NS3Fz8HMHdJHv7JdJ7UTZidn2t4m4MsnW60SWZyaxDynOVsB
         bUOQ5+QbJtca6fMhdGPhsrOLtD7p1V8rLFVJ34PsUR1jGS1D8o0nf1rQXqlGrE/x2KFT
         tsybFqjhzeSjyw1U+VnGORXrn0oheKenIhTbyWe9PneAT5Jb9gpGj9zTxIWxYP+WaLLm
         f6SIc+0nbJA/yGmSvy7wWpCvP7eCgRRmyFGeFjTbErgoUWAkdDiKuYqkTf1af+d2195n
         Hrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324364; x=1787929164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i28649nrMbrzjwe7lKZ6MKTSXfJUvAObdfOOl+7VWTs=;
        b=aOV/NcL8gZuQAtCizm+TxuQn9tyTC5lhJUM2l6zOpUVilceOLHjV4zxMqkPBwiJ/qr
         wZezP0xcTZu5cllc3kD4i+18hpfkHP+k2rrIOaDnErBbEuOBktKCSEA4SQMk3M+39luk
         V27M2cvyYu7wJ5liyTvRhRjV4tx4hi0lJnZDOv2zZ/nSseMBRYwsIM3us/zKqb3600/L
         /V76tOeLaLglOogXjJGX57SX+sjaioGRYexvZIs27g0NY26/iGmoCcab3Q4r/7DypWCV
         ryGpmEwklnkX59A0+x27+nxqTm/bqDsEe36Im4WuSOdDxibL1mYFISxugWYn02qOQZ3n
         Gp9g==
X-Forwarded-Encrypted: i=1; AHgh+RqY1qf30avWdmVW0M2Fub5nCY+pipkcUrbbuCUQPt2Si7e/rEArBzt/7otPMKKYFIlx4F7fUq+xyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kwhloR2vqa8cCRL6NFELI1FlTqvm1Bik8QnbW+GKDDrzrgegTV
	7VO7s79skyk+wxDKAb9qFj3aQWV6dBx3jSyJdzK7M0xFIMzDF/+gEVkI
X-Gm-Gg: AR+sD11pMTxKBbdWEnkmIf9SUVl3F42f4m9xXeA7ahkUROGTipXCdRWRLkuAJm7aaJb
	sUAbtGhShqKvA6VTRwi4YSLx17l5DzAOEn1z9yzaMCQDU5wXBMnYVREhiKvamc+ZLpQQ79dKT5p
	9C+LSvCgr8OBkkdAM8QeJbJ+8h3rZzE5hWyJILc4C7tHGSL1MRqiit2wRceFp1Y0RKcdMRJeQOM
	qYAUgMgOMg2T7KUhDuoSHoHg77A3giY/nU8Q2zZL1GvxR2x6x4ohQmTOXeFdN0SmvwVpjOuSuri
	nEmRzdAXkIJWMDE1rJh0Fi8TJTjlVkL6HXQnrpXhmoTgEAVEbG/wYwiF866uaqy/LEiZsJiyKKe
	kgKubR8MBKGknqJri+UCibURHYM7hb7ifIoALxATV1lzw0xpygG7Z1mhS07JoxHzGMGlzdDa/HH
	ULB14MPSEK2WH4W8Vh8PLgWIVgqfN8H8NpwpLAIFdBwtfaxM+7jV92v+K3vOWE0biNFRSljBCiS
	owsF699eTMqG+Acdq38azBPEm679ruLxkVd4JTDf1sNUGfiNnk7RKuOxRHWLJy23zQ1De7CiSKQ
	FX6OdiGjGI2g1T0u75B0XTR/1N33gcv66OFiuw==
X-Received: by 2002:a05:6402:322a:b0:6a1:f895:1ba with SMTP id 4fb4d7f45d1cf-6a42f20b899mr8424396a12.12.1787324363509;
        Fri, 21 Aug 2026 07:59:23 -0700 (PDT)
Received: from [127.0.1.1] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a411971b19sm6577066a12.11.2026.08.21.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:59:23 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 21 Aug 2026 16:58:57 +0200
Subject: [PATCH 1/2] arm64: dts: imx8qm-ss-conn: Add USB HSIC related nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-add-apalis-imx8-usbhsic-v1-1-fb93d73ead44@toradex.com>
References: <20260821-add-apalis-imx8-usbhsic-v1-0-fb93d73ead44@toradex.com>
In-Reply-To: <20260821-add-apalis-imx8-usbhsic-v1-0-fb93d73ead44@toradex.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2

From: Franz Schnyder <franz.schnyder@toradex.com>

Add the required nodes to support the iMX8QM/QP USB HSIC host controller.

Keep the HSIC host node in the QM/QP specific dtsi to not conflict with
the address used by usbotg2 on the iMX8DXL variant.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi   |  9 ++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 26 +++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 176e2e332f87c..44eee9abacfb1 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -384,3 +384,12 @@ gpmi: nand-controller@5b812000 {
 		status = "disabled";
 	};
 };
+
+usbphynop2: usbphynop2 {
+	compatible = "usb-nop-xceiv";
+	#phy-cells = <0>;
+	clocks = <&usb2_lpcg IMX_LPCG_CLK_7>;
+	clock-names = "main_clk";
+	power-domains = <&pd IMX_SC_R_USB_0_PHY>;
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index ccf9f510e0f88..168f89eebeedb 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -4,6 +4,32 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+&conn_subsys {
+	usbh1: usb@5b0e0000 {
+		compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
+		reg = <0x5b0e0000 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+		phy_type = "hsic";
+		dr_mode = "host";
+		fsl,usbphy = <&usbphynop2>;
+		fsl,usbmisc = <&usbmisc2 0>;
+		clocks = <&usb2_lpcg IMX_LPCG_CLK_6>;
+		ahb-burst-config = <0x0>;
+		tx-burst-size-dword = <0x10>;
+		rx-burst-size-dword = <0x10>;
+		#stream-id-cells = <1>;
+		power-domains = <&pd IMX_SC_R_USB_1>;
+		status = "disabled";
+	};
+
+	usbmisc2: usbmisc@5b0e0200 {
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		#index-cells = <1>;
+		reg = <0x5b0e0200 0x200>;
+	};
+};
+
 &usbphy1 {
 	compatible = "fsl,imx8qm-usbphy", "fsl,imx7ulp-usbphy";
 };

-- 
2.43.0

