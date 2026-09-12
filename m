Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F47A86E
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216107; cv=none; b=WF3tv9enjsnNpw2D1ugTeL+VCthz3055VQmrzApgcPkE8coSO22jtN8cf3FGYCDat3F1xpKfU1DVPops0rUkiAUFEnkOD3UIea6V8VfhLqAkuHolanaaNdL+mgcAmVBs8hvvlA6VaJdRRt27SPp/zt+jhvtLCdwnLGYZm9jYfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216107; c=relaxed/simple;
	bh=06OCCRLJZiWFmko6yn+El7auSYo4iw4lQ+pGHqY4J3s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ieu3JqG5ihHwtVzmeN5SfkRcK7wNJMjlfPHpSrpPW2HKtFNmpKJbmik+RSO6wZRPm378eOy7+xPjc0QdHp4RoPbnb6cxWQuISQuBeRx05x0tdq7WIsP+kG6Zk9rYMDWg1M39Q1EDlc9+AyyesJwRFFYySY4HxpPhy6jGJ+aDYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhYPyA9I; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhYPyA9I"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-869d181419bso1760721b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789216104; x=1789820904; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oe7EXYlzw5spJ4MGmK2TXNFq8D9C+6xPH4nivENYcuY=;
        b=BhYPyA9IrNZBzadE/xwuZhtWgRAC8lgeIBzDTaC2GcEnwP4TqINJO4sPJcir14Ucl8
         HokL2QWEvU8n8kHYaRc2MSM83FSTSzMGyHKyXt5V9avbymkSBjzU0IBseZHfOhbRENuV
         id4CiDzkufYLl3vnIiQnErwICdxzjExoh3sF1EoXaOS8+4rlqfzqHIDcysa3fDnzd3X7
         W16OcGrgE6kwustxrpONo5mufCKfCYMI+dbkou2cE5Wz0i8bP9pYi2R6TY0y5pX/H6RV
         1RAX++MPxplV2yNaxIr39O3kDcer+vFlbk0M+Dyet50no03kDxYOWumQFPswqZVFOIzK
         yKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789216104; x=1789820904;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oe7EXYlzw5spJ4MGmK2TXNFq8D9C+6xPH4nivENYcuY=;
        b=lXifW2sd2BZJBUxr2/DcyCJnB4iEG/jfamamVBefJ4g0HXdT7H1/1V0jh42RsHuSvL
         NYyhKwUui44hDh2c88VqjiuZKXIaGfuWNmQ9Qf9jUjI8L9BDzRbNSCU2Rlj26ROjF7S+
         rU3/FbRI/Iz8qhCHivudu3Iqm4By51OUChz1rsK2/S2+EucmmB5Wa7PcUilxkHaQtIBj
         Wr1QQf4xybM732ZNsjh89rXt+Afyf92Wg1/1KcPUXJpu0EkW6vrY6k2lxxrGjuLwc7xo
         r8/QYPsiIJhMp8u1JD+PIdrPa12oVpBnnKep46gPm8ZcuGSVJ94EQzPtSlTW/XQ/hT7A
         nN1Q==
X-Gm-Message-State: AFuF++m+5ctUzPDM5gESJhYT5smgziIdvLG96ux40xJgixgMD3Sdv4G0
	ypOmcdqK26EANW5uwS1q/sfn3yesvZjhde8D82koUesrizCAfFNyhHFA
X-Gm-Gg: AYBFou3RyebPe7AH/2JZgObldr3vlI9LlJDdTRG4UpXxEaOyIe12ON6VXCLKuyFLWf7
	9TNOyaWsU+HZIL9bh1dSG2fv+wpsODTf0v//LPxWU4TJ0G2F2eiARDaIIL0UjR48UpQ5R/vPr7Y
	//Od4hTgAknFRIqslIIyaDXnoSVoBegsfTqgBz4FrAadZ+LtaCjVr1IzNbEZbtPtcrNyWMx3Z9a
	TnhTSC9nHWupsVxpVPVI04iR/ZRd6auRAsv9wW7HYUp3JW04TrFkDaMTKMYuviQNGcpBXMsaff5
	GkyYufIrViNr4SGNdy/b64WY0IptipxhcjKKxhuIBYMHWdsx6JWlWA3a4kTM1OI4Opx3ngLggii
	emzeH+A3F5ljrYeaF1oI7od047xqhsKNVxf0zo5rZc4ZtHFKAWWYZPA/R9RCRvPVtqJDytsxFLp
	ITPz0c1uFuHRrkFjQ0jrcBIOPEaMrgIeNWO17F4Ea+aB4aiOhhTT+DwtB1dKGO9Bw=
X-Received: by 2002:a05:6a20:b08d:b0:3da:6bdd:2308 with SMTP id adf61e73a8af0-3daed5d1814mr17126253637.18.1789216104145;
        Sat, 12 Sep 2026 05:28:24 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701d:4e35:aab7:8c01:68f1:4912])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65b1a63sm2512427a12.31.2026.09.12.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 05:28:23 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Subject: [PATCH 0/2] Enable USB support (peripheral mode) for Xiaomi Redmi
 5A (riva)
Date: Sat, 12 Sep 2026 12:27:32 +0000
Message-Id: <20260912-riva-usb-v1-0-0acd5cf8c62a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDWpJhVcRSwYg7Eo6SCSpndXL
 L/kfy+AkGcSaLIAni4W3lxCkWeAS+9mUjwmg9Gm1HVhlOerV6cMirCmyVisKouQ8t3TxPd31Xa
 /5RxWwuPdQ4wP6sV+cGwAAAA=
X-Change-ID: 20260912-riva-usb-ec9ef25c885c
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

The purpose of this series is to enable the device to act as a USB peripheral.
It enables USB-related DT nodes (controller and PHY) and modifies the
charger driver (BQ256XX) to expose its VBUS state through extcon.

Driver change is required since the device has its VBUS connected to the
charger IC, which means cable connection/disconnection events must be fed
from the charger IC, to the controller driver to dynamically enable/disable
the USB gadget functionality.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
Reza Kurniawan (2):
      power: supply: bq256xx: Expose VBUS state through extcon
      arm64: dts: qcom: msm8917-xiaomi-riva: Enable USB support (peripheral mode)

 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 17 ++++-
 drivers/power/supply/bq256xx_charger.c           | 88 +++++++++++++++++++++---
 2 files changed, 96 insertions(+), 9 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260912-riva-usb-ec9ef25c885c

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

