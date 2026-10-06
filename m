Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A830472F83
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302580; cv=none; b=Nzx6hiFmgql17WOqrQLtMCdRNXqc+naWKJPxzUKScNIgsKL4r5aHirfpvz7zCQwS1HwVAQCZzbuYLJBi0hHPFFjy9i+YjAfOtKNTwyw1+bIsT7/s20EsK/6xdbtHB99b9B+V1xZncr5T+dIZaOntZ3TWXoJNsxwisTMUqSHH/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302580; c=relaxed/simple;
	bh=eFY0EL/+0X6JOgjuwcgNPswP21gloYHJF0IpxpUkDLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jouHqQ3hhcrQbeAbmxzmnHAqRxIV7a33RCCsAWaiPR0rSSi6plrtLNy2b9HpmGw2COshSgj68sC06NdICwvMNtgSZJn7bwIWMyDBo7EDK1WHPeOdGG+RjHtwl7evJ/VrPa2ntAlk2ntG5FYVcYo+lqkaG9K0XmgXQRPBIEF3u4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=m54ieys2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="m54ieys2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a061a13884so8232635e9.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791302576; x=1791907376; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J8q1Zp2FdwvzE5fOrPSeuvqoT9vOFY1AG6osvW0MSLk=;
        b=m54ieys2i8OUV1pRTbC4UJX124Lp/fhnxOQjoPIHoYI8Fr0os6szO2oPqfT9vqo6jr
         Duym2aXiHQxPbBbk25TiraxniEmmz0R007ij4XEmR11kxwMW9ITjoV8An44UNRA+jkdH
         +pCdBV75OKTB4ehBjWXyyS7DImnu3wuiIx6BTKQBgYjc/px+61Ta0mlks6EkBkTnvEXn
         5+8FIxMcpJRQWKaq3fFZCMziSW0AXayZmakS0ZjN2bTLEcfs4YYor6Yhxky9+II0udyB
         uUZxBk9B5m2Ah0RnnKi6hrLicUlDGWCNsy8i1Ldp8zrNtLt1yp6JxwjBzpHCZrG9XdnH
         r2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302576; x=1791907376;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J8q1Zp2FdwvzE5fOrPSeuvqoT9vOFY1AG6osvW0MSLk=;
        b=NzXInsWdmz0OpF3knBBSRhUbFgiprIvb6lAkBiSJV1/C2Cu47ecY9et8/Z0QzVNpRw
         trQYcs3dQPFMb3UfLQpoD/a5M9zQIT81xgjOm8GvOrB0SMUeLgtm8NcnnUD/BdAsaV3Y
         /Ic8xzBpLKg+PaI0LunqIC+gdqeyw8GNsZvY4pLT93YtP7ltf+uHJUvBiD+7LPb6NCh2
         /TebQWrWDcfuXPiyp5TX+i6yrWwjm82UR0DXSlSQoGBgCLF3FL74JNh0OVe3QyYCcxvo
         ayzIH24rv8DGhzJloIDYBhkka+gZ4WXPSYnNhn3f8ywECsOikjy99/C1EUi0OJyfzsjH
         FglA==
X-Forwarded-Encrypted: i=1; AKwUvBzQil2efmdGWS5Oey7a0RqGqBl2LI/i0EdnKQaP9rdGP0580BEinmOosbPtH4XJPd0ChEynBInbbw==@vger.kernel.org
X-Gm-Message-State: AFuF++mcra77HGh8S5JHO6n5yWLyyOuRxAbj5T7ixjAHzQCT+u3smHIr
	LIvf/QOSVLdzXHizY2P5KWJ2nkQKSdGCYS65fCY3tQbG2OsmCubFR65WY2ML+93h6mA=
X-Gm-Gg: AYBFou2utGmQvSEBGi6ck7c5GmMo14IeDN5fFqCwOLiqH21Fc3KEL1ZCw+AQslO0kUL
	8DFrr+v5cCa9CaFA2kxEwhXFEGx8ywR+gRxaZbONQPwg98ACRic7u2KIRKgNeFwTffNmmSwJAvM
	eK4C4xhObnr6B2gUPtv+lnmvTQ4ADQj8iQ4lemYzBKS69wKYjFgQwDu+WsO1jgSK0nVCn8RQCeh
	G89b9PaWwYfAnjFwDRrbkR0Zgw43NSQOaEELBgbY7ee9rN29DyDADxifU5WBJNXrhfccfVtyXs/
	f+v9y6uvuA/c0aBFdrhW6DMi8WoX5wFTZKFqyXufrBbqEAKPbNFUH7BIC+iTRNJnf6TlgNxs8GB
	llrn3ye91eNc2mkrE0WpNJA6Rhx4Pm9HtnJS8BfF9pjm0LIi8S6VAwjDtSeYi3gWYpxlM1gdOtJ
	y9l1XJ1zK0nJGNuLEd3yB/nV2635/bKtUstC8VC9AHcdoVjlStzKVDTaGQrTeMC0q1Yha6EkwIc
	zkd1kG14YvXRliKlOpg6wsDvY9F
X-Received: by 2002:a05:600c:2049:b0:4a0:2644:80db with SMTP id 5b1f17b1804b1-4a17b562c6cmr22905595e9.35.1791302576578;
        Tue, 06 Oct 2026 09:02:56 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.85.242.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2014asm369641f8f.38.2026.10.06.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:02:55 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 0/5] power: reset: syscon-reboot-mode: Add support for
 Rockchip RK3576 reboot modes
Date: Tue, 06 Oct 2026 20:02:38 +0400
Message-Id: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBQFf4V0bU3pC3DlfxgXLb1IfVDS1kZD+
 HcLbnRhXE5yzsyEAngLAe2KCXlINlg3ZGCbArW9Gk6ArcmMKKGSNLTGmmN/YaKS2IN2LuKbM4A
 NqwkH1piOcJS/o4fOPlbv4fjmcNdnaOMiWxa9DdH55xpO5bL710glJlgKXktNmDa83HdXO47gt
 wNEtFQS/fQ0vzw0e4RivFUVJVKob888zy9LK+Q7FgEAAA==
X-Change-ID: 20260928-b4-rk3576-reboot-mode-d3804e39df04
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, 
 Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=alchark@flipper.net;
 h=from:subject:message-id; bh=eFY0EL/+0X6JOgjuwcgNPswP21gloYHJF0IpxpUkDLE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQdlV59fO6HO2LMB9oMc1MOdcTfnsIoI82R/TRb7remg
 NKX0slnOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjq9KkM/3MONbC/dohs2apfalN85pCjm2yd1pPstUdFlecfs7hx5SzDP7spJ20
 qkwzzb1f+/ZzfrO0/1yh7qSbPXtnj37NCH95w4gMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Rockchip RK3576 supports reboots with a specified boot device priority
mode, allowing one to override the board-defined strapping config and the
OTP programmed priority setting.

Supporting it requires several changes though:
- The boot mode request needs to be forwarded via TF-A to the boot ROM
  (upstream since TF-A commit 2a97ba20e901 ("feat(rk3576): forward any
  boot ROM boot mode request on reset"))
- Some power supplies need to be kept active across the reboot to prevent
  early boot code from running into a synchronous abort
- The magic values for each of the supported boot modes need to be defined
  for the OS to use

This series enables the above with the RK3576 EVB1 board as the example
user. Other boards will likely need a close to identical change to make
use of this functionality, but need testing.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Dropped Tested-by tags from bindings patches (Krzysztof)
- Link to v2: https://patch.msgid.link/20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net

Changes in v2:
- Fixed a leak of the dynamically allocated syscon_rbm->supplies (Sashiko)
- Uninitialized access to supplies[].supply (Sashiko) is fixed separately in:
  https://lore.kernel.org/all/20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net/
- Link to v1: https://patch.msgid.link/20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Alexey Charkov (5):
      dt-bindings: soc: rockchip: add boot ROM download boot mode
      dt-bindings: power: reset: syscon-reboot-mode: allow supplies
      power: reset: syscon-reboot-mode: enable supplies for the next stage
      arm64: dts: rockchip: add reboot-mode node to RK3576
      arm64: dts: rockchip: name the reboot mode supplies on RK3576 EVB1

 .../bindings/power/reset/syscon-reboot-mode.yaml   |  8 +++++
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   | 16 +++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 36 +++++++++++++++++++
 drivers/power/reset/syscon-reboot-mode.c           | 41 ++++++++++++++++++++++
 include/dt-bindings/soc/rockchip,boot-mode.h       |  2 ++
 5 files changed, 103 insertions(+)
---
base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
change-id: 20260928-b4-rk3576-reboot-mode-d3804e39df04

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

