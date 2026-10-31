Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459124;
	b=sZbVibkoNvXFvy+D2a7vnEts4I/f8wtz+20j45NdX/rvIv+nqSYJ54Oxt6HbrX8/OKSu
	 Ugv0ZgU5XVAPwWEU68xQHFYVG8uPHueUTWCuoE5NWhcpLxla8L3ITDvsU5XfVlfCpL8wy
	 +aN2qGF3Sij+lJXLDCxsLGf8SB7yvxc8Pm1/U/4NM3hzv/5DISkziUOyYXY7ffZzy0vPq
	 s642aAz/nhAW/Edfgo/jvJQhsqp5gV56knCHTNPFWNMpNQrB+9E4cRI0ql8YJ3RI8C5Jm
	 ZnKc5ClSll6fsyc/GP2e0Fh8hQy24JmPqEVivxoVc9oDZBA0Y5tycbjy6pa8mE+4hqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459124;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9C4ZjeGlLcuAui4y7jh5NYMKLKYFHpEacS1pEe8tg1I=;
	b=GSDW5MYl6iLV/CIKvfvFx0pYkQmQJVX8edJLvS2EN35VlQM6m9a0xibO8rShvorC2h7B
	 ceQM+Q4dl/SCG6B0u8Tcs8YDjS6kvnTSKUA+qZ8fPYSgS0sh+e4NrRHgPQkstW4iDyqGu
	 1cdrwZTDEJ76gbydUuNG046o0HYhyjyJM9j5+AOraOIAITmT0lLpupvS4TFZhMi/nr9l+
	 dyJlmY2wTc4zGQbIq2CiuAaERZ89u9AOkr0IkbT79i0LPNbYvXyGB9/8TJte7ksVQTZiZ
	 DnPO/Spmr8C4ZjSLr3nBa6FRr6G8n+BcrJlzbAZEoi89LR764Fzm3fd7eb2TIDklw+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0XmjDZS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD8606A325;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0XmjDZS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459123;
	b=mmZjST9fFrmMYN57KcIQ3Rl/p6mcwJPl2WrVGAZ7YTOALV6j+cG/ydQTjnwSi781Ul/r
	 GtHnSza1PcjxE38VBcfzgQn42lqO2pOmTS12+W75mRLU+C4X+oc1Ac1Huh3+nUi8I0D3B
	 FbTu0DNgSRDWGH/TeUH+rOXDwpfjYHtfoW76TUu4CPi2X5oc2TDLIzAWjNQ1MHhlxDQv+
	 0Nh5VN4C3lst5VZFg66o9d5Snntr5A8J2EyeVxiq4JviAlO5BcyAfo61HCBxUx4Ls8FQ2
	 mXNxn/J4dQ19vwMfG25ZJ5VawunkIMfr7cf74wmw/ezER/XgdQclJHazW6Y4VP8wjNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459123;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9C4ZjeGlLcuAui4y7jh5NYMKLKYFHpEacS1pEe8tg1I=;
	b=mZqsHxNAWXwwOHvH4PVyxsoi2QFcGivtAuggwt4RA3NYPzcngRDEHYpxXwSWCTNqbQVZ
	 HqbIDIDARb4eqfSKXeeidTjCzUdGA1t/gexqQlGh9GE3Z3n+briyOs14t9FKZ6iLwCCIy
	 24nOe+6KzEImJeXZlAPhxDptoAQRYia6nVqp821PGfQG2UJgK7/XoXCWGNeuWAAJL+/Tx
	 5sRI4hxDOPJwkqUUMmodmbbkX7rsiqqosCPg087HOrRqPHJeVdXLdoRKdW62j3q2bBRQz
	 xeLlIzaoE2eblTMY0SUJx2dboMXzJ5iz0CU/MfRjCxJtvG86zabvmgb8CJTVR9G2WfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E85031F00919;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459123;
	bh=9C4ZjeGlLcuAui4y7jh5NYMKLKYFHpEacS1pEe8tg1I=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=W0XmjDZSjIxtxJKHIaVPoncPmnDGGEjwfp43gM6yElzclpa9Hm5EbEOcZhpe5TiYx
	 gEpRAM/D2jGH5MuiZCOn85u5l9AIMOtxcN2f+7LY+C6ooSJNjlRh6Wgwdp4s0EBRB+
	 sqCkfR5pdLHhCXNg2ICN1BWr40eNjm2iO2uauHffVVMuuOLxRJg21twNCjBv2KYe8j
	 qy7lG2ZmnazqlQLKV3LH9fOnokrM0KFJyoZpCKZ4Hv5XmGkEdUEKX3G1vzOBOZch1P
	 NUMOJmQ0lamPWvZEMjet9slrlC2cRv/AyFZIzQ3fq8LpC7xROZWMS9joMEaR9lIs0L
	 QIByZIJKehArQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 44CE045F03;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 00/11] Enable Qualcomm VBUS block on PMI8998 and PM660
Date: Sat, 31 Oct 2026 16:04:57 +0100
Message-Id: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3YLcTAtLSwvdsqTSYl0jI3MLY/NEk5S0RAMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAC6LVK3AAAAA=
X-Change-ID: 20261027-pmi8998-vbus-227837a4dfa0
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=QQTUMzJbcnskHluf3ZL3QNJlfDwcPnf44W0frCsxGxM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOuRG6OIDtxI8rAcGvhRdIxcCWngaL+/WZFI
 CdLu+FYCNuJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrgAKCRBgAj/E00kg
 crk9D/90HtW5E6+cyVh6rw4Iek3eaVQP76zsks5ArdVIuVL3D6DB6lLWVkCG8d1gr0V2iKCphOq
 RfI8MH4K0Fv+cWgWQU/lhd5LqOLZy7N5Od+p+U2jHVA9Hj3cQ8XuxXsNNX9G5MImU9vcsSMkd1F
 ELM36G2WmADaj8+wbq/gJuTd3rU4IuPcqhw9zdT302Otu+Wz2T/RU1xGfCExnYevLCvmwm6HaJ2
 ZUsBz2743Xrf0/V6VNE2rizwHx0SxBOXgjK7IQbPxIMpFiPpJcQs1eVgkboMLms5UOYEv8+1S6p
 izULFYgLKdOMA+3+0KqLEqDFNWED9ZxNArKoJSccse/XMzTC4hNLciJXo6kCVFlOLQC2BN4UMTr
 uzYDNvz1D8w5PA9vJ7SbS0ywg45ME4jydPx1k5HBW3TxxnXjavNUYIzOYU9BNoauuuk5rb8pben
 C5u6CLFyoFOECUoqr7J1r7NWpaYghd556nZytkPhbMs1cx+SufIPbghTcRSIgR2GfwrnPB4B/qv
 a8pwy7de+4HvF/O00XD14M4u0UB5O85Yeki2XfNSwbTWjvJZL+WKkuabs3t5IMg1bRGfR7aakn8
 rg/H5wQJzJ1VIi9tVDNwZrkavd8c8cjtS4wfB6h8dXn1DFyF93TkSHrNcZfuciWpNUsmoH+VPvU
 gNloHtrPXsb7DRw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

Includes basic vbus regulator support for:
 - SHIFT 6MQ
 - Pixel 3 / 3a / 3 XL / 3a XL
 - OnePlus 6 / 6T
 - Xiaomi Poco F1
 - LG G7 / V40

All devices downstream sources using default range 0.5 - 1.5 A.

Validated by looking for `qcom,otg-cl-ua` and default values when
property is not set in the driver.

This series shouldn't change existing behaviour (except register write
execution order). Without Type-C driver this merely replace the write of
the SMB charger to manually control the OTG block.

As a follow-up with the latest upstreamed Type-C driver, this change
will allow setting USB OTG, thus power devices connected to the phone.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (11):
      regulator: qcom_usb_vbus: Fix the MODULE_LICENSE() string
      power: supply: qcom_smbx: Do not interfere with vbus driver
      dt-bindings: regulator: qcom,usb-vbus-regulator: Add pmi8998 and pm660
      arm64: dts: qcom: pmi8998: Add node for PMIC VBUS booster
      arm64: dts: qcom: pm660: Add node for PMIC VBUS booster
      arm64: dts: qcom: sdm845-google: Enable vbus support
      arm64: dts: qcom: sdm845-oneplus: Enable vbus support
      arm64: dts: qcom: sdm845-shift-axolotl: Enable vbus support
      arm64: dts: qcom: sdm845-lg: Enable vbus support
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable vbus support
      arm64: dts: qcom: sdm670-google: Enable vbus support

 .../bindings/regulator/qcom,usb-vbus-regulator.yaml        |  2 ++
 arch/arm64/boot/dts/qcom/pm660.dtsi                        |  7 +++++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi                      |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi         |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi         |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi             |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi        |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts          |  7 +++++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi      |  8 +++++++-
 drivers/power/supply/qcom_smbx.c                           | 14 --------------
 drivers/regulator/qcom_usb_vbus-regulator.c                |  2 +-
 11 files changed, 59 insertions(+), 16 deletions(-)
---
base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
change-id: 20261027-pmi8998-vbus-227837a4dfa0

Best regards,
--  
David Heidelberg <david@ixit.cz>


