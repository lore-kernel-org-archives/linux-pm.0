Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450754252A6
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324365; cv=none; b=u8l0OgoX80EHLvnEIo1/M1AYCIyK7k+u8QobXQ4giS1TMvbmMIIN3dz/RFm6NF94LhXTkhESeZm8mtO48eSvV3++6maLE1upnHkYneIJyD9O3S+rVK43X7Zie2HgWcoo1E3m2VKruQbe5iCihkeJM7SLeP7wCjzxnLU6H/WiYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324365; c=relaxed/simple;
	bh=WDEAc+a/SLkgrSJkUe7LKkxiz7rqpJlb0a2xNqjXnFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=unRyAW3Yp0zCDdt562IKroxmmbjXKBeObesOtDBHVjET0rhp6tNAFYSHbR0jREUlJCFRBUZoyqaUCLMaCFI63ct4fQbLsup1mEFQAkb7T4J3LZpunAMVd4J32mrVHlpI0bfMnS+tw/Ndy9WF0jHVk9a26GWpmAHwHK3HHStqzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgP00wgp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgP00wgp"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so2032227a12.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787324362; x=1787929162; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bmv09nVrxkTx/RCEk8yEB9FeokGQe6GnMpeREDR5iZc=;
        b=XgP00wgptpWTzQS4mZIO1B8F5epij68Bt6isUbuprd2gXyYEYMHp2kc42POCUqEsJb
         iaQ1Ds5/UoheFW3BCB7GcLHIQRY6lU9hGzLT4Gq7ap03sXqs8ztKzdpoVY1kNjsm8Tw3
         BHkevcqHjs16cfoTck3zJfSkizXL2hTGbnqCvoS+5fqF4qOEEHVZ+2FOzJymUJlf8umC
         Z16XJh+koCx29aGFu53A0J7IcukTewbM1fypYQrpS5PFW7xwwrdIcWB4Roe/QZ5vZ2MR
         NC7kHWeos9vR/jNkb60kPBHMtvlkIOCD7mdijRuqpkXMTLC+87uD/xhbh0I1dcJbCT3H
         iWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324362; x=1787929162;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bmv09nVrxkTx/RCEk8yEB9FeokGQe6GnMpeREDR5iZc=;
        b=VnTRGyxCcQ0HJ0cp+HyAJ7fP2RcUPRL+4JrB5KltSQQzprpwFEEavRxlyattcA0PM7
         SZyRRErVW2f7r5JeE311rESA/FJLnBOE3yvymzCl3ehuErC/Xm88+WlxiU/bIb/mGQSd
         3LsN9dNFuR3RI4YEudiC0ZVyoeyJ21RNxpCLmf/W5jqKf8WOPpIEcJyKdv3IqzdBtB87
         1sCbly6GI+mq8CVEIIyTnNO2eLkNgLH+Y+6hGs+Pe/Gf+tQYTXpw8vJmHAGGn1VVmope
         AR1pK8hRUnp4wvzzldVLkr1K8x1aQlyZRcgucN1hyS25lZIOxOhSzy37cvYtsizKiZER
         ORfA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9IHHxLDl3r186DYaBgM6tPCIHjKKsm3aHYpW7W5UyxmslQTNNM0GjsOLDYu6i+vxx5sqS00OVCg==@vger.kernel.org
X-Gm-Message-State: AFuF++l4Rjjcv640EUMMzMY39h/N8k0kXU/tdX/nxpnCqWBPIxVbPSvH
	bBeY5HJWdGvLczAehbUOMRcy8nI1TsbBUYdkUAkT/y4ydwiF+JPeeVwy
X-Gm-Gg: AR+sD107kxT0R28+ABDsavRADvaVt8atqOiGpj41QNXM6ny/R1WtQVY85gNbtnPdt/8
	hKlWfp8c51HtdNaVyuPkuK/LmFrEznOaGXhUeuHmBdUTs02CiAdcvoB8SxMVqhv6P1sppf/2Ejl
	yreFMFD3DUGfTTptVwEB6T7pUrGnzb2quGUEOm1KOE1Wdl2YL8Vu7Etp4u6QVk5LQUtDNO9TgfW
	+SiA1z0kbuGH1/+RUe125R+Nmr1ciVA8VcA4QZbV6GOzeqFrfSxVKo5KP0w1NNKytf2XCrUSGCX
	I9TK/F+f/T4ll/BBwtW0LfNi7oNNegsUqWIioU0mBzYBTM9IF9yRjhXN+NnTpniJL1ybvJRBe1F
	DO2CHDKlL4KGCWFIxBsyKs12LM2DXSaMokRl0BN6EXzimh+NlU+mbAtxDDtIsnGBY/9N1olIqTR
	mx4srfjK/dr9rGlVSoynV4zG2ozCF1qjpPnoPx8NywMwL3sBFlH+PE01qb333qMypVjlJR0uCXW
	xvBAj72ssuqXdSAjNpiI/QzdEVmEdVkB7IdqV1UEOkeaH4oW9c35S0BdRRWOUr3hNxxl2cRCp6Z
	9C2kXH6i5Qi7Zkhu3/yPs6UPM1x2kdYsBCbdME4LLY+VdpeV
X-Received: by 2002:a05:6402:321a:b0:69a:a4cb:2882 with SMTP id 4fb4d7f45d1cf-6a42f216beamr8673257a12.9.1787324362464;
        Fri, 21 Aug 2026 07:59:22 -0700 (PDT)
Received: from [127.0.1.1] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a411971b19sm6577066a12.11.2026.08.21.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:59:21 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Subject: [PATCH 0/2] arm64: dts: imx8qm: Add USB HSIC support for Apalis
 iMX8
Date: Fri, 21 Aug 2026 16:58:56 +0200
Message-Id: <20260821-add-apalis-imx8-usbhsic-v1-0-fb93d73ead44@toradex.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBniGoC/yXMwQrCMAyA4VcZORtYypDqq4iHLs3WiM7ROBmMv
 vuqO36H/9/AJKsYXJsNsnzV9D1V0KkBTmEaBTVWg2vdufWOMMSIYQ5PNdTX6nGxPpky+o4vzI4
 o0gC1nrMMuv7Pt/thW/qH8Oe3g1J2/bdeCHsAAAA=
X-Change-ID: 20260821-add-apalis-imx8-usbhsic-84c9cc211d1f
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

The Apalis iMX8QM/QP routes the second USB controller in HSIC mode to 
the USB hub on the module. Add the HSIC host description for the 
iMX8QM/QP SoCs and enable the HSIC path for the Apalis iMX8 modules.

The HSIC host node is added in the QM/QP specific dtsi to not conflict 
with the address used by usbotg2 on the iMX8DXL variant. Therefore, it
can't be described in the shared iMX8 conn dtsi.

Tested on Apalis iMX8QM with the Apalis eval board.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
Franz Schnyder (2):
      arm64: dts: imx8qm-ss-conn: Add USB HSIC related nodes
      arm64: dts: apalis-imx8: Add USB HSIC support

 .../arm64/boot/dts/freescale/imx8-apalis-eval.dtsi |  6 ++++-
 .../boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  6 ++++-
 .../boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  6 ++++-
 .../arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 16 ++++++++++++-
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  9 ++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  | 26 ++++++++++++++++++++++
 6 files changed, 65 insertions(+), 4 deletions(-)
---
base-commit: eba4724641990bd9975ca10ababe726b6143f0b6
change-id: 20260821-add-apalis-imx8-usbhsic-84c9cc211d1f

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

