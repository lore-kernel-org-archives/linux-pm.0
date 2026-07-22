Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD430ACF2;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709576; cv=none; b=uV3shJVh46kIoqX3rK7bUDyv9FgRaL5OyF5H0UUcvdBaJg5Ts4kvr0TpnfbPJ1SkbfjvksROezVnwO2Ia4cypd6B1EaJpIYP4mygZ4DrSrnYTaBrvRXgb6HaFf0YdL92NPbu4guNe8/926jOfSsNBIgF0dtucfdt42QjiUbSrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709576; c=relaxed/simple;
	bh=QQCi8joyIQJkB/7W6FFWGEeP6YN+mclhm8poIQ026HY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mhmMZf0Ict8o5gUrRd8mjt4MPUhSYQACy8V53irbMsXrlX6U0LyQiPfN+bjDvzwx73GkNFWUJQvsQ4cut5om95swTrTNc7GMNOSesQWZvVr59R5ZRK8BTWuyX5Exw7cgMKUHkj0zvrK5Ao49Z+kp7mBoMiEml2hkQ7nvi6y4x3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcW/b/cI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcW/b/cI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 691D8C2BCC7;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784709576;
	bh=QQCi8joyIQJkB/7W6FFWGEeP6YN+mclhm8poIQ026HY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jcW/b/cIFCOrDCNQFMdgN0r8V5wQB4EfkdIp6CaIsRNV1hO9xl2l4LlQDcmbxTSop
	 xnz0aw9HdjUJQbXo5dKpv5pBUsbr0Zb1ZYUQYhK9HqAghw+m8VWTfgPNOb7bBk7/UV
	 ZD1eWHzyp8Ln/YmKhmoF9DtSGFWjAaeJvoCqzsa7y+b5ScCDmF3L1K4UG1JMmH1PyC
	 E4caJATseBQop5g+pTcieeQkaVKbKPYNC5FDS3mCJe8LfZDM72dWS53wQhbbKAQXax
	 l5u+k8huQMhSA7ZZPmO9rVQJjBaTDxXwUbBXYAUkznZiTUC/NkFBFzH2Uc1xMvY6XP
	 QiLhkV+pU50Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53711C4451C;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Power: Add power domain for A9
Date: Wed, 22 Jul 2026 08:39:30 +0000
Message-Id: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKBYGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3URL3YJcXePUtCTjNKNEkxRzIyWg2oKi1LTMCrA50bG1tQDAyC7
 HVwAAAA==
X-Change-ID: 20260722-a9-pm-3efb3f2a4d72
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784709572; l=814;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=QQCi8joyIQJkB/7W6FFWGEeP6YN+mclhm8poIQ026HY=;
 b=WLQ47soAxbaZK576/tY+iiZaJ+qwcSMeFxILfLIWBKgQ9gUpoJkMTVFTUiaU9RzgZsL9M+dAC
 J6phS4teZz6CL993sARjLs4UT/eYb9BYbCni9oX3A4iZJRMwX2xfUXU
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add power controller driver support for Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: power: Add Amlogic A9 power domains
      pmdomain: amlogic: Add support for A9 power domains controller
      arm64: dts: amlogic: a9: Add power domain controller node

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        | 10 ++++
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 69 ++++++++++++++++++++++
 include/dt-bindings/power/amlogic,a9-pwrc.h        | 61 +++++++++++++++++++
 4 files changed, 141 insertions(+)
---
base-commit: 544455a3a844edd6107b15cd0ab0b657399f2d49
change-id: 20260722-a9-pm-3efb3f2a4d72

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


