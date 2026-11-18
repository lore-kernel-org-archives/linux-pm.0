Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022746;
	b=h+WmPyoNEwwclncaYDjGYjDVzGT0X5vgB1b6uGjTgbtZc6dMHUb9zzmL9Sz1AkMuf+nB
	 iO4EnJiiV6/wHzLS1zGgo9VTO04a8MdLL8dMbqYKH6to36MIf/RbalrXhArEa4wfBSTcD
	 4mDAi8d6UdPexarH3zWy6cLUEz7CorRfBSqc8LCZJoulrD1VNNroBesyAanYbF1TI5ipW
	 6BV8KNKatDO5akgcI83GG+nIPE0zvW/oFnDlcvTrM8z7kx3zs4ArKQt8KdCDYGpMKB/0X
	 eLz/m/bx/Gv2Qqx+6SqxNf3iDwku2pYiDGHe2HqJlEuJu9/hc8pNYFKTdHn5wlqeySQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022746;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9YZUE0SQfeTFaUsEU7pDqAhIsWdOwTS9NfPx8Bh6Brc=;
	b=YP7VaU7jwTBVt+a8JT647TO2SdUKznaSOIgvk+gO4iwSruSx8SVmuyRllDSUcOTVZB/C
	 f9UmiZArDy8O7wCOg4jiNjf9f8vL4EQxWWGHAFAdpFhO7U6Zr7srxYhOP+hJ3YwPkcfQ1
	 EmIqg6VM1uXDFbIsbG0SJP7qUa2Owak62r7Z4+eZamA88PBXd/k6P0GsvfQGR7O4eFp1L
	 4apdu0w6POSt/unJQ+UeVdp5iFEtdT8wKHm1UXAkfXc0i61GND36anAseZ4E6v905nFLr
	 7vPvzA28RKGwdofnmU+WQrix65bqM69t9/SXT9UkQI65FGt5C+rglmixqIXC2lNpuIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gj79Yalq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97C606A33B;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gj79Yalq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022746;
	b=FCtiYmHv94g9uR3gXksjMgxWx8lKtetjyECuIU02da1aU00ZEQl5agtOwluHGfjKLbVy
	 lhHnrgo0jjtSEFCcHx0BypcXr+UlVmn0647s/xmxgo0DBFOdhRP7HF3dy+jRnYvhd2rp9
	 TLv6voPU89moNPn64WBLjGn5n5wbeme95lPirs7G+63iEUiLvn5wpeuQqRzsfAo3P0S/e
	 CAoKMvbpW0FnvqBCgKpcv42K0nnJ5Iamdn1oiF+QkJg1UF1B7oE+miTjCgTxroXHsAZxL
	 2Qy8TMoim1cCzWXwQNC5SZeTnM/djlGBCMo2ZM87Nk4gbBYx9AY4O/TAtHLy6ANN8ZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022746;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9YZUE0SQfeTFaUsEU7pDqAhIsWdOwTS9NfPx8Bh6Brc=;
	b=JBuU8XPox/F2nGT5Kx5bq9gAFdO4tjtOSKmJjgCmOmEFxnBkXN+Anh6L1tVyo00u/IOC
	 0lj1spYtRAN/6zKVwTBgel8iGAVv0c4LI+RzWMiE7wq5UcHuQCYuNLf6LsZuq62Uva0ee
	 jeG/FZyUqcsyLXVsv2sxjx3si2pIa4+cp7xfzYfitbZ7aWMCKzxlCp7fvyxV799QTXQOT
	 3qzahfP0HMOnS1hMydMhweEErU7N5k1UopUoHu1l48EVUv9bjuA0PFz+X8Bn8EO+lpfIe
	 ddCARIevVDs60yn0MadH8o/XdkwnNcGBfL05r889SoOsezN7ybvgVATOXRCy1qm6dMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 64A921F000C5;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022746;
	bh=9YZUE0SQfeTFaUsEU7pDqAhIsWdOwTS9NfPx8Bh6Brc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=gj79Yalqoap12dZm3yY0BQt29qvREARF6Et3pfbt74ubv8f1G7ofYVcnrdGsS1eU7
	 ah8n1a0OtlPaYSGEkQ78iU8qpS15aPiosXJRz8k+6OPu4TKzBFRr9dZfe/ohYR2CHT
	 iGt2w1IA4AsJjDAErbZOFlvzDtxJjcMxogMf15j+Ffurqz+ZolY4+UCqNFQxwr2/nE
	 s1FjxFbcQmmewap7p9pGM/Hc0JuVGZSdoDrzYN04+HWVFo0F2v328yuNBWKwVz4WQb
	 QhvnFRsgpfiU3MlRljYiUGNcxfBOTcU0ryEjuqFeAPzpKW/4fpMZM+wW0vdQI/CiY7
	 M0MNLGV7P0Tww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B70444AEDA;
	Wed, 18 Nov 2026 17:25:44 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 00/12] Enable Qualcomm VBUS block on PMI8998 and PM660
Date: Wed, 18 Nov 2026 18:25:33 +0100
Message-Id: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6CMBBFr0JmbU07gC2svIdhUWCQMRFICw1Ku
 LuAbly+5P33F/DkmDzk0QKOAnvuuw3wFEHV2u5OguuNASVelEQthiebLDMilJMXiNrE2iZ1YyV
 sk8FRw/ORuxVf9lP5oGrcG7vRsh979zr+gtq9XzpW/+mghBRJbWRKqZUN6ivPPJ6rNxTrun4Ad
 ym4LrgAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=G+aoOXMCv1vOvaJcGLQ/ejfn57oi1myVgmlFlR994S8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+WZrBYerqOCRo5K3vHy14SqZ4dyO8XnD90e
 cqzIB93wsqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flgAKCRBgAj/E00kg
 corCD/4qkSFiE/InAscyogqdEzdsfvAxDPp7cp2kQltHmN3seuhtUFOTHW1fUxPjhsxRhJ2lpta
 a2TM/U8dkZAD8oIa41tTEluDqsggNIBqOEvSYeTR1NBjbYLHat3rV6W6ibd3UnXRmacMap0sWWr
 kcqEvNuJqRLe226Z4qoDV5MwPD1ZYedRA1dG+tTRSs6FuUq6CJJjlq42wGYtby09N95TuJPatvQ
 lO/ueS2p5OcpKRF+Oke6gzfRQ6RGvysB37fGNxMvQBrOUMm83sJEpx7W/pXo+dTSwYXF2bd7xwn
 pMc41kU7Kk1Hyq2SMwZgg+Ba/f7qjgVzLnYNzYuVuyQ7zUPfa2cqazlStYo2r5pODeGGBbx1fVf
 MzNWBgUxYDtX7ICHXZLD8iLJl1QdMFK8t/Gbiu4Vc3MXOAW0OV/U5aoBfvHs1bPpHNexduaYELZ
 pT8i95PkGeILkhFYemceUs16iswlgW9iFiDMh86TW6WF7A69jamzuDpE+tOcHUm9ZDZ2bOGNwID
 v8Onm9hXgy76MuX+wAtCHSAbgKB13wHAhTTEMIl3SPuYVNWhEk2Ig3F1pEDdtwo05LPKnrmU1n6
 CQxFdr2D/nN5bopswUeBTrBEHbo/XHMldk4nMNP83nEtPQA8NsYZobIIltnlsbBiQqmNWj/ExK5
 hASOvFvPpyHgRRw==
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
Changes in v2:
- pmi8998 and pm660 belongs into the different generation than pm8150b.
  Adjust the device-tree, code, and commit msg accordingly. (Konrad)
- Link to v1: https://patch.msgid.link/20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz

---
David Heidelberg (12):
      regulator: qcom_usb_vbus: Fix the MODULE_LICENSE() string
      regulator: qcom_usb_vbus: Add support for pmi8998
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

 .../bindings/regulator/qcom,usb-vbus-regulator.yaml        |  5 +++++
 arch/arm64/boot/dts/qcom/pm660.dtsi                        |  7 +++++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi                      |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi         |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi         |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi             |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi        |  7 +++++++
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts          |  7 +++++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi      |  8 +++++++-
 drivers/power/supply/qcom_smbx.c                           | 14 --------------
 drivers/regulator/qcom_usb_vbus-regulator.c                | 14 +++++++++++++-
 11 files changed, 74 insertions(+), 16 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261027-pmi8998-vbus-227837a4dfa0

Best regards,
--  
David Heidelberg <david@ixit.cz>


