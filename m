Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059240B11F
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297803; cv=none; b=bldWvb4TW4KIJ/Ry2x8YYJFbR/syTIQ81PvpJ1kOTf8+9kfMwv8uQLPm1frGKhxOAqF6AbC0zGtaigeiGcbPWoT3cipHUKWEdmt+PmgAJj52jtkRi4r63hyQY0DnYpZgepItltWVv+tnmjCZDH8ZwKYywf31MWH9jzsbyt4hskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297803; c=relaxed/simple;
	bh=Anss7133/aANMPtcn5QRXQaxDH/4VeyG3Fgcsy6YMc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hJaDCk+3br+Vh5NGfDARj8nvEy8jjuWjhm4hj3uxIZ/qACcRpHbMmCywKjvMMWlI2UqYEZCpOLpwvCNX4cFT+a+o7w4JLMhNBt8f8fms00GwPIsT1alr+Ko6VBL5JAJVNNxg942Oempbl2uH8tBsji9gEbmcoiB7dIoYrgv9/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbJtyab6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbJtyab6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so676263a91.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 21:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297797; x=1792902597; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VWSV2lYeWe6uhtDKhgh0Nkoh2az0FS4A25FIOTm7cLg=;
        b=bbJtyab60pRpfxg2B0XuPjmJrIruUt6Dq3k25lsiQSFIjD5OaOQTdlME1k67VsWjho
         +kj7ftF8WBjhxabYEodLwoPGSZnRYLm5aZstMbMhxCLyHYebf3Sp0eTNYGqohVEHmzWo
         trVh5sjLSBoTYSgMjy3mo2tCnTv3OzqF+oL0R4sXKTFI94F4sb75bCOcrrXGCKv5Usmd
         CmUwk/acpeF7KwjCBbxD8Qi2UxA5L9+Wbe+DKBgf5yKCMuohpEfQFTlGZh4Adty2d8xj
         JSAmU9mVqech7nH08lWEMfGxVk96sXSmX15b4f2+CFMr2G4C5wsndrxlmAZPikfb7ugj
         Ul9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297797; x=1792902597;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VWSV2lYeWe6uhtDKhgh0Nkoh2az0FS4A25FIOTm7cLg=;
        b=RVb8i95G4EdJP9Zb8NlCkJRJu+Sbl+69x3/dSS9MtPnpuw2PA0Rucr/RPYvv9+FgS4
         2kUcN2eah7tZ8qqpqR3KNQoOmJqX1ANZOnosIJPoM9KZe46OtvKfgfj4oSmptpFG3V8u
         xzP73k+LAugT8u9SCzzWfL6mKPZyPqbwBaJrWCoXNWC7y9zIGB1MdeebwazcSK2hi7Yw
         iGG38MPjLwBO2L2ucc/98QxApRDyX695nxIY+RZUvzJLD22RxKQ8oECltaamHeRXSLh+
         dGc7080y/W5faPCvAfsQq3GNEeSe8Shx8X4ym2u2/apYdu3B4qGbl5mHAsOWlEgCurwV
         7Rpg==
X-Forwarded-Encrypted: i=1; AKwUvBw6mAXtPm4EDeJWTBwACTk+IPOptnDRLuWIClEEUDgdWeCFXqMcO3b7z0itBRCc6Q9ndUC6M6lUtQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIHrJxDiNfb9olS5MSLstnDateUlKR7D06CXBUKZ9VQw0AZFBpk
	/y4DhxwFLdkzZkncd5lkNYDT4OkcZdQhDIY+bqtYp5F36mu5xEE8v9Em
X-Gm-Gg: AYBFou3diFWC+IGBFKuz9w1Nd68QeWL8Lmh1tFQS/etzuesTQ0F/kUS8smGNP54WaL7
	cBNh17lsx3kTvOG4Rb+NkK9d10BCdTA/vgq3iitAR6wNB+HopVJsLRe61oRuKycXDHWVvBML3VS
	NP93/dUFKM/HN2jTtXZ759Mh2UW6eDP0nLOK8EXJNd+VVaykFsC4eT4hC1It0avN6Dta7/Cvo3A
	cGqSDelAXpnzZw70MGC/vsbvV1TL8LegjOLPhse4s7Eh3t0IdBjkDomFaGBbtp9G9h1NmXzUMKY
	sC7+v4TMHu2uCttlm5ah5TqSSUbEz6hJ+NeinU3JBWyLjY9ACLamzne589OMDtm48SK8Y5XAzFF
	G20ONs/ad8BPBwSyMvEielzW2+Vv9vyG7TVJ5hP2DRXKXnls8eQoT7W3v/XWZ/DoFBwOvotjbeh
	ONdfRPGLk85hJTgDqpJ/cEwPkjn06Nyzaj+f9Tr812uW/89RkIeObwML0CNhysQIk=
X-Received: by 2002:a17:90b:5610:b0:3ac:8897:7b88 with SMTP id 98e67ed59e1d1-3acef5f43f0mr3344212a91.58.1792297797308;
        Sat, 17 Oct 2026 21:29:57 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:8841:a092:12c2:47d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm5885369a91.1.2026.10.17.21.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:29:56 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Subject: [PATCH v2 0/4] Fix PSCI on MSM8917 and MSM8937
Date: Sun, 18 Oct 2026 04:29:20 +0000
Message-Id: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WNQQ7CIBBFr9LMWgxQQ40r79F0gTBtx9jSQCWah
 rsLNcblm7z/ZoOAnjDApdrAY6RAbs4gDxWYUc8DMrKZQXKpBBc1W4Ih1tOLnbU03CqpVK8h64v
 HfN5Tbffl8Lzd0axlX4yRwur8e/8VRfF+2eafjYJxZtFqlA2edC2uw6TpcTRugi6l9AH3CMdds
 gAAAA==
X-Change-ID: 20261013-psci-fix-8a2c0d6266fa
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Val Packett <val@packett.cool>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

PSCI on Qualcomm MSM8917 and MSM8937 advertises support for OS-initiated
mode through PSCI_FEATURES, but rejects every PSCI_SET_SUSPEND_MODE call
with NOT_SUPPORTED. The cpuidle-psci-domain driver treats this as a
fatal error, so probe fails and the CPU PM domain topology is never
registered:

  psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
  with error -95

This series adds a "skip-suspend-mode-switch" property to the PSCI node.
When present, cpuidle-psci-domain does not call psci_set_osi_mode() and
continues with the topology it has already built.

Skipping the switch is expected to be safe on these platforms since it
matches the behavior of the downstream kernel, which manages the
cluster power level in addition to the CPU power level, just as Linux
does when OSI is supported.

Additionally, it also adds the property to the PSCI node for both
platforms. For MSM8917, additional change is added to fix the system
being unresponsive at idle.

---
Changes in v2:
- Small phrase change in the property description
- Added property check in psci_1_0_init()
- Link to v1: https://patch.msgid.link/20261017-psci-fix-v1-0-dedae27e4a31@gmail.com

---
Alejandro Tafalla (2):
      dt-bindings: arm: psci: Add skip-suspend-mode-switch property
      cpuidle: psci: Allow skipping the suspend mode switch

Reza Kurniawan (2):
      arm64: dts: qcom: Skip suspend mode switch on MSM8917 and MSM8937
      arm64: dts: qcom: msm8917: Use a shallower cluster state to fix unresponsive idle

 Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8917.dtsi           |  9 +++++----
 arch/arm64/boot/dts/qcom/msm8937.dtsi           |  1 +
 drivers/cpuidle/cpuidle-psci-domain.c           | 16 ++++++++++------
 drivers/firmware/psci/psci.c                    |  6 ++++--
 5 files changed, 33 insertions(+), 12 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261013-psci-fix-8a2c0d6266fa

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

