Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26096544D79;
	Tue, 29 Sep 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706548; cv=none; b=cAtgjj8LXXU5BRlVRxBo/kmYMG4VFdSYry3Uy57w/xGK2e9lGzBuwN+2ViQi/bNpo6eWTasNFgi5UYKFYcBnUHj90BtZx9cFssar3TnjH3k92GIGN31PMW+qFlR6gCrcfJ5WeOfjZ8YIKaAlcX0z9UeLq6sTkpVKNok+xh1CfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706548; c=relaxed/simple;
	bh=QVLv2HnN4E/QEnpzL/J/pll7aQfosBt+Kx7BXlhxaKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=miFCUKEWST1O8k78WOHmvFgCpGhz4/cay5voht5wmO6QgK1KHuXgZNU687pSc+LIu+1Lgsv8ZI+BYODkFyIZzNjf5PhhmrKbSezxJIuF3u2Sly+b7XBa/4qK04O0TXpo+bqOxhDGf4bsppx+5EL4Qn5g4/CzgX8/hnHLghUxwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=M5koVvc1; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=oXfItZB+; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="M5koVvc1";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="oXfItZB+"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1790706520; bh=Gnfeq3trRNlTBmZloFXeOj3
	OAbYXAx6OWuuY/mgNDOU=; b=M5koVvc1RK3GwP1nben8HqMrjq2RZEADXQaKdFZx81ZTtEe0Gz
	eHZIgjF9pDgQ4LjjQVwRL8+Wuwpxj19DsvLVaQ1fHXTllF0puvJ6RbAaVnflAu0V7w1seo5s3Nx
	s4q1p7/ISvVl38Kd2FDagFllOnjwaPVho8dLhhGIDFQJsKlIHb/Yd50wBxwDf8UKOWWzmOTpQN1
	4loB6MtcUF0mBMb12lgBrHLWbt/a2LJT62gc2Mefs0DrMbA9h9mXzSAmUwOi8zX8QMBkvZS1jEK
	+NlRPawn0k0Ns/XgUdGLCRzSfmy42ohluN0Uvl7Y2m267KKyYK66gWrKyxakRpQLj5A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1790706520; bh=Gnfeq3trRNlTBmZloFXeOj3
	OAbYXAx6OWuuY/mgNDOU=; b=oXfItZB+KcvU7b1CQWeKZSBimRtIW3Mx3LyGD3u3tR6BhNtb1s
	hiFtC2QDvTKke75LebWZhmKoGHJsvc5zzWCw==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v2 0/6] MSM8953/SDM632 rpmpd/mss fixes
Date: Tue, 29 Sep 2026 20:28:29 +0200
Message-Id: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XMQQ6DIBCF4auYWZcGsCK46j0aF1ZGnKSCgYa0M
 d691HTT5f+S922QMBIm6KoNImZKFHwJeapgnAfvkJEtDZJLxWthWLKLqiWL67JaNnKs8d5c9NR
 oKJc14kSvg7v1pWdKzxDfh57Fd/1Bsv2HsmCcKW60HY1prVLXZSD/IE/enUN00O/7/gHnIAmlr
 QAAAA==
X-Change-ID: 20260319-sdm632-rpmpd-c0e3eb548f58
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790706517; l=2402;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=QVLv2HnN4E/QEnpzL/J/pll7aQfosBt+Kx7BXlhxaKE=;
 b=4pUKGGXHE+LvU55K8Wk7dAqtbOC8lUICww2l9F/bQgaNuNvqxF40clH4WRNy1S1tuwmnCTUwZ
 yC9FOVoXoP3Das45KhvUbZAlIAagAnzS6rcG4k8JKIox1OdDIxHK/Bn
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

SDM632 pm domains are different from MSM8953 because MSM8953
is defining pm8953_s1 as regulator but SDM632 is defining it
as pm domain.

This patch series correcting the pm domains defined in rpmpd
driver and splitting the MSS resources for the both SoC to match
the reality.

These changes was discussed in a previous threads:
https://lore.kernel.org/all/2b057aa5-4416-4fd4-aeab-6bc23acbb53d@oss.qualcomm.com/

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v2:
- Define RPMPD_VDDMD
- Remove unused MSM8953_VDDMD and MSM8953_VDDMD_AO
- Squash MSM8953 mss related commits.
- Rebase on latest next.
- Link to v1: https://patch.msgid.link/20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org

---
Barnabás Czémán (6):
      dt-bindings: power: qcom-rpmpd: Remove unused MSM8953 indices
      pmdomain: qcom: rpmpd: Split SDM632 pm domains from MSM8953
      remoteproc: qcom_q6v5_mss: Use mss as regulator for MSM8953
      dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add SDM632
      remoteproc: qcom_q6v5_mss: Add SDM632 MSS
      arm64: dts: qcom: sdm632: Correct power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 .../bindings/remoteproc/qcom,msm8916-mss-pil.yaml  |  9 ++--
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  5 +-
 arch/arm64/boot/dts/qcom/sdm632.dtsi               | 34 +++++++++++++
 drivers/pmdomain/qcom/rpmpd.c                      | 29 ++++++-----
 drivers/remoteproc/qcom_q6v5_mss.c                 | 56 ++++++++++++++++++++--
 include/dt-bindings/power/qcom-rpmpd.h             |  3 +-
 7 files changed, 113 insertions(+), 24 deletions(-)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260319-sdm632-rpmpd-c0e3eb548f58

Best regards,
--  
Barnabás Czémán <barnabas.czeman@mainlining.org>

