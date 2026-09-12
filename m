Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA63DF59
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226323; cv=none; b=pbhPT9n20AseYF9ems/wCYDVJcZqOtxiUbgZvTKbFdL7SBxz2LV+zoAYszxCFu/Rrirux+J7p89rAcLhrWv/0EeQKw89JH80AprQg3VVgyrpfk9ZEt4tWhQL5O35TjJu183yKXlMVIsUmWlTqATPerAzKzLrtTtQ0TQnWHUikL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226323; c=relaxed/simple;
	bh=HO8dOn5XSt8bUjw1LP6GJ0iDeCxa9iOwIjXje+HTSwQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QpV5Ko7xb//53JqiNfcoG9wLfC60x+OExiE4g8BsOGpVBsBpzXD2Bj1ZJNXH/uQ8AwHqGIh7N4XpD6V3RdxjMzMrfJzj5CaIMXr74yJpw+DNYjjjmHF7YBcOw43nTuPadzW7FS0sPNzgST77GBgO0GooKI912q3cIY3+h5ASB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqe3OtfQ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqe3OtfQ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso507570a91.3
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789226320; x=1789831120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zHFsO42ibf5oQHYbBFQXH2drbhJs53f8vZr6nPk5Rs0=;
        b=Pqe3OtfQJi+ClP/ac1dtXPl53r5lKNPM9+yGoyE1YQzJZ1K4eURSF75K4fBP9hUA0G
         uBXG2SJMhX9G7h5nCsvuOEQ6R8ZBG/MVaDsab4+HOtrwiTPPSg9ufrdbeos0J5Zg3fut
         4cVaGN8aHOedQLHLKmszhJz6Z6wwg1ANErYWHo8QJ54WlaMx9qmrXMF/7ORG2Gpi2+vX
         1/o6GHu3VttaK7xAJWXmYFx8x9udyE+rKsJPi29L0pziZcXdUbeQzfuoK/GjuTxP0R0C
         z9WBt9TsjmhHX/6HXgHa7EWw6+IIPOJxVXpiFr91zGYGT9CJo0mrtZP/z4AffsD+bSG6
         0QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789226320; x=1789831120;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zHFsO42ibf5oQHYbBFQXH2drbhJs53f8vZr6nPk5Rs0=;
        b=Xw+bu2XQ9ZBjZebooarKW3d1PcbhfpwUcH+2BIeHNLBSoz/HqddY3m1+bsz7KBr/iP
         zFthMq4F3p1dpVeSio8CJDVi2m00Cmud8irmj35rj4entf5rlHJfIgjqLd6IHfQBvN0g
         6g6s1p7uPGV3FuVhKdIUet1+BeVV1A/Jzu/fe9q2bR+Hg8IaSDdSGT5RjGsACkDZEW4g
         mVGiMIp+ijU8O5iUVsuq9c0GWIuMqbB+GGP3ML6a88FYtk9Gp5YmEXNT7xucT5eewj2T
         X2I8sAbIJcr5O0rKI3i+wytfU1PFUZyXXKPTaTGj+nfTC1T0BEA/JtOlTaf/fe8JF7D/
         gOnw==
X-Gm-Message-State: AFuF++kOr3dtZpgr86vXlZdR8J3WUXUcGmtmIl60VWEqRWMApjv/lGst
	iiTJQgCYoQndA3SUkdYAfrBMc++1KEYuDxXqXlOj4svS9twqOqHgbqx7
X-Gm-Gg: AYBFou0FxnrlWg1LajLs17eS0JRsGZxdDX8LfW2L/NxxRWKm6ttqz7yTfLjQ2a9/dPJ
	G+mxRfsEI9FOEetoMRaZrGbUoOUsKkci+3VAYAnQSM9Bz9GHErgKtOjIBb1+4T5aM+wvrn7P4XY
	ddlxH+EFTgk6icKlQZzxWcUC5aQ2R1gFzU4rtyorqb/xIT6oRdn5kNiSnHNcJXTnuDJO5wUNj4u
	nhnmmXGWBcv6/I0Tr36jiqCwuwbDOcRv/Oh4h7kmnaMVKqpVPapUgNe6pyyeruR0FwhsjxcuhZX
	SXMcK/xMc7wpbWA1q8ErPMJ/5oiipp2aFYG+HNZ5uVsOop6hBk4KGXIBG3xFLYOATtQgR0e5U+8
	OxVO6ciU++rRcQ2AdfYS+6Ys0+nw6UwrH7gLGHbY4/ND63Ih3lRfVeKvn0N92obwFPuQ4vo1TCV
	gqEx5AhOmfPK6pgAR86KzH2IVNPnxo1vEXUJRP7X7fkwogj+1RHkUkFuSU+urg3TE=
X-Received: by 2002:a17:90b:582b:b0:39d:9b53:112a with SMTP id 98e67ed59e1d1-39d9c378f02mr17421863a91.23.1789226320389;
        Sat, 12 Sep 2026 08:18:40 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701d:4e35:f53f:aaab:9e63:54e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d1056sm10635924a91.7.2026.09.12.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 08:18:39 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Subject: [PATCH v2 0/2] Enable USB support (peripheral mode) for Xiaomi
 Redmi 5A (riva)
Date: Sat, 12 Sep 2026 22:18:10 +0700
Message-Id: <20260912-riva-usb-v2-0-997fe0171ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQqDMBBFryKzbkocULSr3qO4iONEp1QtiQaL5
 O41dtvlg/ff38GzE/Zwy3ZwHMTLPB2AlwxoMFPPSrqDATWWus5ROQlGrb5VTDVbLKiqCoJDfzu
 2sp2pR/Njv7ZPpiXtkzGIX2b3Ob9Cnrw/2ZArrbShriBbUYnm3o9GXleaR2hijF/0IOPhsgAAA
 A==
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
Changes in v2:
- Make extcon feature optional

- Link to v1: https://patch.msgid.link/20260912-riva-usb-v1-0-0acd5cf8c62a@gmail.com

To: Sebastian Reichel <sre@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Reza Kurniawan (2):
      power: supply: bq256xx: Expose VBUS state through extcon
      arm64: dts: qcom: msm8917-xiaomi-riva: Enable USB support (peripheral mode)

 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 17 ++++-
 drivers/power/supply/Kconfig                     |  1 +
 drivers/power/supply/bq256xx_charger.c           | 96 ++++++++++++++++++++++--
 3 files changed, 105 insertions(+), 9 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260912-riva-usb-ec9ef25c885c

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

