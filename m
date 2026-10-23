Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792748732;
	b=D36pzwFiGTtCfrYjbNYQ3jh4o1FDZMxNk7lBISdOg37baI32DC4ep3JvyrHVlnRJ7GG7
	 m5FtSe/g1wA6hi2RvM7a1Pn+ppVG3sUTFR95Yo3d91Ts9rFJvAaGqQCLjueEMOCBQBvPU
	 IfmYw0JKh20qgfn9SmJ0EPUxBAvQjIxEWc5Unpm1ikbu0IGNEV64BpjM1iNrYL9+B5HMN
	 dURWiNsvegm31tVuBXfYuz0bRY+B7wXLpgFQ5UdXJsOVrwrjlcS9txFN++1UYnDM65h4P
	 VyGGsg1CZr782tWbx9tPn2SQ+bBwwAl+OKodW+MIetATDtbDtjq7sCQFOhBJV5SskSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748732;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=7gHRA66Yi+9G1946JIHGvrwd5VEKKIi8mLpYBAlFBVg=;
	b=MM/GE5Kw2PvTxmiXrUTFi1bi0A7idsHAVlgT+cTzX4w5hPMqsvOj2xIeICuVhLh1jxQy
	 yQ2pZdS26Zx0nIcGovHI1oreVTycZW+juhGUoQrFPILRd5B1ehJwc7dtqw0UMslTAV31O
	 Rvvo5TXKH+jBJPqqwGQ6NqAxvt5852mnvyF2oLMOCXqLhH08XNsU62whqQpIl9MTQUdm/
	 //WbJEbnieACGu8FCqNbAb7OjZ/lQRilsBLOk/b2qObIR4709KydiKNncQa6+WKn9aUVL
	 2FoDsWDWmAy/SDBnqqkhObOWzEg0jqqr6TgaLvwxAAMNbmxXkeWj0WglNYKajFz48wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDTOOMwX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F86606A31A;
	Fri, 23 Oct 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDTOOMwX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792748731;
	b=HUUCIfxq5SYfONqeF6uB5b6sdqmTxjVFfpc2gKleVpTRTFBGfJkx50yxoxwk4bT89qV+
	 Rgw4BIgM30oQr2PMku/R1HjyWOEanj32I6LOZWM9w7nekMsUDain9xnFbkn0wRsgUYYlu
	 20CYACux1JX2MIc66Bm0ymvVDmI5GSJhKzXaiJ/hi1fEhXw+6cmC7Pr0n50cCfzcz4roI
	 SOx4APn9k8pxbcR3vClBse46d5ZL65m0IIBJoQwLQrglsESf0nNS8tzqS1XljCRmqNMJG
	 PLOMwSbOPfcd5ucouYGrB+VtKkD3O+WklGu8Q9RFh8oiiHobnSHKBkS41QndWpVASAQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748731;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=7gHRA66Yi+9G1946JIHGvrwd5VEKKIi8mLpYBAlFBVg=;
	b=1ZGZEuqVdCqXbGyJpMsCQEF7qY6iuFm4czS9lI+agxFtyxRquE+KxR14ZSwiX4Zlw3Z/
	 z/Vk2PDpK4jH8EMocHOS0uDqOYbjlCfv1T/wqTIYuXc+8XndFp+5Uyeobz/1lAx9H2LlH
	 tWZuI8+MkNuHV7uE0qFJ+h9MTIbZZQTVgNkb4ui+bqpfcNNcHY8++XQfTIyHRquhtJ+VU
	 4YdsH4hBVlLj8kGsAVqbKdvDNyI0Z/46BIhX4vL0R4tYAtlIlWNQCJFpcytotrduvozbH
	 j0GfzSpNRFkeb58qGOm+Pnwo8TfnpQzoPvGgrtEomZI9tcZWOMovyLenEDla//40lcg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BCE5B1F01825;
	Fri, 23 Oct 2026 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748731;
	bh=7gHRA66Yi+9G1946JIHGvrwd5VEKKIi8mLpYBAlFBVg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LDTOOMwXo93xKC6TN6pAvEBWBYwQsx3Ox0Y0Z7xdyZL45n50VoIGhvR1HYthL8y08
	 KOg3dVX55TDEXuiRCvzTAqSzIJNQBWzjjahS7Eolyrjt+zouBIA2c6xx4W/YgJFN4y
	 GJxKR4dmbvIoB1oipVg7xbGAFquJbz1GXnyu2zMMs18+1wl25ireSboC/qIuD+gNnr
	 +hAbvmup7kieg2EDBD8TQWZojeqqaFkX2uGul1O6zcdkEkb6wkefoK115XiKavxPYf
	 aYd7x0oUbScHEF0cavLDsn7a31Uvn25tAdNoeGVKRewB8jiw/Wis0pVj/SQRJ5FkTt
	 VBbyKZEXUbDUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 36C9B44478;
	Fri, 23 Oct 2026 09:45:30 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH 0/2] interconnect: qcom: Add SM7250 interconnect provider
Date: Fri, 23 Oct 2026 15:15:27 +0530
Message-Id: <20261023-icc-sm7250-v1-0-1e47c1226857@brar.si>
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
 vPSU3UzU4B8JSMDIzNDAyNj3czkZN3iXHMjUwNdQzMLk1SzVBPDRAMjJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAP0CuS1uAAAA
X-Change-ID: 20261023-icc-sm7250-1684e6e41a02
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748728; l=1455;
 i=patches@brar.si; h=from:subject:message-id;
 bh=rT3/RTw2g8tLLg867RLRdVfy7CHWnSpMjk9in/XDuoc=;
 b=5hjXakKZCZYAn2P6T8oMSE5/B57/nB6JEJXR1VyUSv53bKsiTIJsLZ8M+cDd6RschVdIA6moj
 IuSOXSM5X28CcA9YnfPZem2hGv0rs7roYpgOlx/pHSWr33qT2olKKrV
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si

Add the binding and the driver for the Network-On-Chip interconnect
providers of the Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). They are
controlled through RPMh Bus Clock Managers, like the other RPMh based
providers. The driver follows the layout of sm7150 and sm8250, and the
nodes and BCMs come from the downstream interconnect description of the
platform.

Tested on a OnePlus Nord (a 7.3-rc7 based tree): all providers probe,
and UFS, USB, display, I2C, serial and camera ISP devices get their
paths without errors. The Adreno 620 GPU also takes its memory bandwidth
levels from these providers (the Adreno 620 series sent earlier relies on
them). The SoC devicetree nodes are not part of this series.

Signed-off-by: Ishu Brar <patches@brar.si>
---
Ishu Brar (2):
      dt-bindings: interconnect: qcom: Add SM7250 RPMh NoC bindings
      interconnect: qcom: Add SM7250 interconnect provider driver

 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |  102 ++
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm7250.c                 | 1683 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    |  151 ++
 5 files changed, 1952 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261023-icc-sm7250-1684e6e41a02

Best regards,
--  
Ishu Brar <patches@brar.si>


