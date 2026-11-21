Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300704;
	b=L0TK672u7hx5vhkDxB4ILaa0Id8FbwvJf1xgnZ86Q3+FZn5mvHylJiF17xmbia4SwXvA
	 vKseY7udlv+HWJHErxsdKqm794wDqk1jPEunQ8g178Z6paURkPtpRkr2S7R+qxTxWVEey
	 b/tsS0a7EijNyutCSne05Mj0Q/n4TtqP9Q6KMUJFTgXt2k/jjWvLRMzoIaVJ7/gfj/kJU
	 hngic3sGs2CETVpwaF5qQOLDrd27CykoOacKctkWVSS1Rj80jsQ47lFANToG06+g/X38Q
	 PRJR5LyWFz/D0xa1dEOirPrGdrg+8ow9JtcKCIms8bIvM96T7tTC7lFyQ8aHgczbBAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300704;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=EjZKzruiZCxDenHsmG2d/cUYANC+FAiZogQjrerbutM=;
	b=0H3OVFe6hTwD77mYokiaooCc9C96iFMYSW3F86cq/IsLS2pym6lgyX8eMBjM46vEfk1q
	 klBwNaE9Q1yKg6BPOd4wgHYG2UQ0Ki+i6Ue3LMgL0sVQhKSnY3vuURuEXIA+rhTifZ39E
	 YAqQnoK7lvG/78xnyCG0auPi+Hlh6gts0w2Yl8WUAyx2annrl1OYsv4XORjUOt2SxZ6/0
	 o3SkK8FldxKAurajMk6QJ2NQ6L2at9U5Vwkn+gen5kCtCl29eF5ytUeAErjkRBnDtajlU
	 p10MhZkzq5kfLgmRfZF8D2q+GlM3EH1tVWc1zDRZoxl/lAGN3DFAklF7MAMnEP/jggA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrryXt+5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71A606A699;
	Sat, 21 Nov 2026 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrryXt+5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300704;
	b=DroYfeGHQoIqduK3FcefvpblQk06Y8daysTS/DkqsZPvwy2bfAz5MPGYqvPBg2vMAt0l
	 oMpSctoM504C/Z6RH7XLWSCu6ljT/V4dQKpgFJqDgvwlssjPrpmAVYQXkXeStwZ8CwEwK
	 wKWQNM5S4J2HRO72cJjGWAMlpG1WbAy7oPXTlnsmhBlPp3wzIWQvq8VTp2Msqt5bMYyGs
	 6Z7XiYV/DHnf6WAhiD5eIbDLh2EVfZsxWfkSfGHonfOXr9q7dq+sMT6ctvuL9DzLaJYhj
	 SqHMZOR62oq3sCeWPOrysri30GxeZzrcucKAkcugcN/dGhwG25EMlR03VNKAY6AM4qg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300704;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=EjZKzruiZCxDenHsmG2d/cUYANC+FAiZogQjrerbutM=;
	b=GktZGXmZ3ozPRDRMDsXuxlMakynw08vLIAMD64wbgekWK2IGKfQsfBP9Ke4bZYntyT0I
	 8L688wJrGKPME8HoWvms2+ycEt8NPxkekqoff2qrE13zt1jqW988PXULHdYvn8AnELG+a
	 GDlncxIsFAOgSI2V8oeMbxSm5+uS0byWUtQvfjiEaeKuxX+btYmEFTp1NhVQdd7HYZTum
	 dDbP7PnCNSKxpHrFbT2ZBhkKpha/v+RyjBJG9aww6J/V5gj9rmojDo1RDoVO2f17vHnXw
	 cWOXbTrFKL6eSyr8BTEnFJDjg2FLs2Rb4uTsNqY2/Fnx3zD3DulrOUJqVkTfQ160Jjw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 56F251F000C4;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300704;
	bh=EjZKzruiZCxDenHsmG2d/cUYANC+FAiZogQjrerbutM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=NrryXt+5zWYeIuNu8Zz77cnpgys4CMOqCd5zFYo+kwGT6NqCmIBccn45rQKJPdfml
	 tlztBzwwkPpt9VB4U19CQRDr99T38nboJiRPD4dQO0IoqQNddekR7LdvxhUXMAXeVm
	 xB70Hc6hGq19lx8hvi4Vcsyy8e3wl3xIIhgcB/utYTOqXkG+aUvdnA1vieqZbagVTn
	 JfTPBkqX5XGL+ScTbE4aG9rLCk27cglHFWrYcZwIFZdITzSJNIvw4KsV5DatM8/xUH
	 eLLPzUNvMe29WxQ0KPnUzua8hEdQ8x2UbEJXRfqGG6Uf6ooa1oTYcGG9FvYc3VshQ2
	 FrGBD6xCBMGMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A79524BE26;
	Sat, 21 Nov 2026 22:38:20 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 00/12] Enable Qualcomm VBUS block on PMI8998 and PM660
Date: Sat, 21 Nov 2026 23:37:54 +0100
Message-Id: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12N0Q6CIBhGX8VxHQ1+NLCr3qN1gYj5t5UOlFnOd
 w+szdXl2b5zvpl469B6csxm4mxAj90jgthlxLT6cbUU68gEGBw4A0n7O6qyVDRUo6cAUgmp87r
 RjESld7bBac2dLx/2Y3WzZkiNtGjRD517rn+Bp903LfhvOnDKaF4rVthCswbkCScc9uZFUjjAp
 nKu/lSIqjBSagkVKKY3dVmWN4OigPnzAAAA
X-Change-ID: 20261027-pmi8998-vbus-227837a4dfa0
To: Abel Vesa <abelvesa@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Markus Rathgeb <maggu2810@mailbox.org>, Rob Herring <robh@kernel.org>, 
 Robin Snyders <robin@snyders.xyz>, Sebastian Reichel <sre@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=OImt/nLXL2kIokFM/oPd0DirAEB3/8IPasOrbeEvB2A=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1avifTQxrbPQJE0RvoKnBjQHFeuWxjodvzK
 ZaftvItqoOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWgAKCRBgAj/E00kg
 ciUWEADBJs6O+Q+0LfJhX5AAna/uYamcaAMETjP4OSon5T7LaCQ8nfVwsxINcgfoX22O7Cfc1Sz
 9FKRsgSHjsvp3raIeXLxKsQm0wpdEIvex3wwPbEq/GLIxZAJGyirBW4LkfnBBDCdM41K1SCzVcO
 qK4kZuweel5akob4FaY5tieSe1CPSuzU4L7zh0+px+gCvzCyGHEEfpoqVDrhjUURGcCBz/P2D5o
 l4V1WKS1nojNhIFqkhIPP0Bkbf7omcLICG4R3BYgMoC8QKP6a2hfxdN/PDj28dagGhPN3pBs46x
 14kaed+zpU4UyNvCGEqhFGvEpUnkfgd80/+tfyHN9ny/wi2LILQ/MPooPdcIsmdTlbQvAkFSWcS
 8mzRpQp06iKzIPJirElr9nU61atSgUF5KjK0xYBEoFYsv7pnii5+Mr3GoIZq2UZwznsMPN2mMnv
 +srt4CrgDKjrC3wqrcbGaCzXIyty54o+93oCwPCKCC16BpVXqCC9GyF+zXMeR+E7VGG1KotmU8m
 ao76bmyb/TwXbXCb6Ha5WwB9E66mYxxIHL06OyGiI0JDvQzwF03QnnrbzKwgOHO1Y/of+e6snBU
 r1hT7Srpa7cGsRMhm9EQbbBt+fM/XSGJoPDRmdMBTnWisWOpxqztfXQ3nHWwEMi1oAc+yT+hZfF
 fllyl2cswRiuj1Q==
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
 - LG G7 / V35

All devices we support using default range 0.5 - 1.5 A in downstream
sources.

Validated by looking for `qcom,otg-cl-ua` and default values when
property is not set in the driver.

This series shouldn't change existing behaviour (except register write
execution order). Without Type-C driver this merely replace the write of
the SMB charger to manually control the OTG block.

As a follow-up with the latest upstreamed Type-C driver, this change
will allow setting USB OTG, thus power devices connected to the phone.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Limit OTG current from 3A / 500mA step to the 2A / 250mA step. (Markus)
- s/pm8998/pmi8998/ typo. (Sashiko)
- Reworded commit messages.
- Link to v2: https://patch.msgid.link/20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz

Changes in v2:
- pmi8998 and pm660 belongs into the different generation than pm8150b.
  Adjust the device-tree, code, and commit msg accordingly. (Konrad)
- Link to v1: https://patch.msgid.link/20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz

---
David Heidelberg (12):
      regulator: dt-bindings: qcom,usb-vbus-regulator: Add pmi8998 and pm660
      regulator: qcom_usb_vbus: Fix the MODULE_LICENSE() string
      regulator: qcom_usb_vbus: Add support for pmi8998
      power: supply: qcom_smbx: Stop clearing software control select
      arm64: dts: qcom: pmi8998: Add node for PMIC VBUS booster
      arm64: dts: qcom: pm660: Add node for PMIC VBUS booster
      arm64: dts: qcom: sdm845-google: Enable vbus support
      arm64: dts: qcom: sdm845-oneplus: Enable vbus support
      arm64: dts: qcom: sdm845-shift-axolotl: Enable vbus support
      arm64: dts: qcom: sdm845-lg: Enable vbus support
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable vbus support
      arm64: dts: qcom: sdm670-google: Enable vbus support

 .../regulator/qcom,usb-vbus-regulator.yaml         | 56 ++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/pm660.dtsi                |  7 +++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  7 +++
 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi |  7 +++
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi |  7 +++
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi     |  7 +++
 .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |  7 +++
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |  7 +++
 .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi   |  7 +++
 drivers/power/supply/qcom_smbx.c                   | 14 ------
 drivers/regulator/qcom_usb_vbus-regulator.c        | 24 ++++++++--
 11 files changed, 128 insertions(+), 22 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20261027-pmi8998-vbus-227837a4dfa0

Best regards,
--  
David Heidelberg <david@ixit.cz>


