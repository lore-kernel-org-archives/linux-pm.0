Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793036983;
	b=0z93bhNS1UC3sJXNuzBDDJeENVJPGHtKdcvxxdLN0XlWW/WXNWsaGx0I2tklHtf0WAl/
	 4DE5C0PH7ORaXGyHDcIsKeRD6M8CsoA6LfDzwYSWKvV0KqOmAzxubT32zjwstKdwEjUBe
	 jJiW49V4Uf7tG8FxWhITOKxT/bJsdJETWZFRqP96EgCcWyUdWSI0km/Z+L1KJVv0EInfn
	 q6/VQ3SY6JXJ7TwhtSYm/lTnsXJODpW8wnh2gQNGXd/Bq/ypV0j16ctn5dj8FXO7BgrZd
	 F9ZDUn7TgZ+3+/UgW3YE3QXWJidXui2FUhyBA32E9Wqe13Vmsec/PZ0XpUFkEatnThQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036983;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ZqtX6DI0kr6jtVxLiN9ux1tO8B5QzkEQXV5/RmgmS1A=;
	b=GVxiXoI0EWsHQjccCcgwCuJAyM5gxfExw/+Lz30044SFE/U0HBm+2XjA1KAREYGsf1Bu
	 8TwoknpGESNckVmp8AziVgz3Axw5UIOfV9SqXU8lDfLRD2s2FcLYhT/IEgHtlw/7IfeWO
	 SZofizLwugn9CzgxIdm2rrcwxmqzc2MmVDLQ+EPX4GlDku7JiJAzTpDItYEA4G/ot+zYb
	 XJpxwf8yEwzU2EpReMKd9k7IxRr4LUkShtlcJWekQ2U9qNqljdLSF9ceLje0CaZr/qoLy
	 Uq/xubngKFLyWE30NpXaCogopXgdrO4yRrDF93ensElE5RAZPSNA/DtxzJbabhAtKTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZccSGIN1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9215606A31A;
	Mon, 26 Oct 2026 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZccSGIN1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793036982;
	b=t6Ex82ZySKASHboV4vV6gtxTpWHi7yOhgM7Skn//Z4VG5Aa9Z+n42mFiO/FoLcOflbU6
	 YI9yUDeiSIWQ5eKhBIsFRhISkmpmiopSo0Stgzey+7iC8DXqmIQkqRGDnkubZSuRlEUMp
	 jkrdbjS54m6piYfWyd9mex1OUuzzCXCLBNVmVDcv9fZgxx+gby37juLxNMsLTdPlE2fpr
	 a793LOPawHuoc7p+JQnDwYc8xJov7kYAMSAxJTtZ0o5/xyQSiIxHhVViaIzmpRlH8dwQ/
	 QDBOoSvIrUrB0hMsREXMmhzzAQOujjNk6SBt/kXkfX5FoWCZ4v5vcpePzJxnH60rzVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036982;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ZqtX6DI0kr6jtVxLiN9ux1tO8B5QzkEQXV5/RmgmS1A=;
	b=GW1/Mvh6LvwalVofWOe2VFAo+5UNcCw2Y6aXYkoSYS82Z7L+1GqXJep1i/eVVtYy3jmc
	 TMDhR7CZFaZ+BXrAFONGBOACu9/+/sM9DBncvMeWMKh33XFRqfZK+KOcO8m/gmpu3jWQb
	 d34McNOY3gb12FHIqNQ3Is5ZgW9jRjwhZ5wpDgllrSwfXqtfEDwDZ9YJPCJT+RjvfrNPl
	 xEIm6onBLbhPlHMP4FvSvk4irq8ZIBZdV299PSzy5gJ6krBIPPLN2Yuk79f9qDRywWCG1
	 EdEAcionqR0xg5lhT/Pl84ss8B77nkCNotUm6I1yjz2CGCXwq2dw0UBsAp5VKIKlqkQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BF12C1F01825;
	Mon, 26 Oct 2026 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036982;
	bh=ZqtX6DI0kr6jtVxLiN9ux1tO8B5QzkEQXV5/RmgmS1A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZccSGIN1gYfAomNmS+396+iIjiqH61e3iB9ano8cuajVQfweLEGNvzYWw3A7uYR4J
	 Wl/2peKylkLg1FDf43/ARgg9ZuSbXvQhat680ZDTWewBuW7J1QQpSfaVJYZ+5c1TtZ
	 1FG+OIbEzgPb0sxwD8OuRy4UvB2FJ9Zz8Pq2oa/w5DpflAO4N85oKvuu3ShqqZX9bg
	 SXomrsYBLU4fVwBkjnZ69zDO45Fu805XKB/7NA8BonEBalwYnVL4QyEkrdUAEsoJqW
	 2NJJItDvKkU8GnIxb1KFm96cDy00f+c/79QD3ef+GJdDTUN68Xhyc3G5D1CihI/HBI
	 Qe7/66eA3ldsQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4172A44E12;
	Mon, 26 Oct 2026 17:49:41 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH v3 0/2] interconnect: qcom: Add SM7250 interconnect
 provider
Date: Mon, 26 Oct 2026 23:18:16 +0530
Message-Id: <20261026-icc-sm7250-v3-0-aa303226298c@brar.si>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywrCMBBFf6VkbSSZ5qUr/0NctHG0I9hKUoNS+
 u8mdaGCywP3nDuxiIEwsm01sYCJIg19hnpVMd81/Rk5HTMzEGCkgJqT9zxeLWjBpXEKDSrZCGB
 ZuAU80WOJ7Q9vjvf2gn4shbLoKI5DeC5vSZbd33CSPNdRWS8BjNN214YmrCOxkk3wLaofEbIo0
 GrtNqqVzn3EeZ5fH0+yPe0AAAA=
X-Change-ID: 20261023-icc-sm7250-1684e6e41a02
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793036977; l=2815;
 i=patches@brar.si; h=from:subject:message-id;
 bh=XMn17Mlz1sQ1bjtBVxi9S/AkNIdkb5Ce8gNvbH3tfeM=;
 b=p6liVVIh25kiR7QvG2SeuvdfSRLRIVGeO/1/wz6ACoFFHbsJsxpSYqQSqZsuZ3JLEK0/StOyC
 LNqW8DHZp0eBSkq95HLKpvpdbRsr+jxiEbjBhLPdf1H2DCwE9dvOUWX
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

Tested on a OnePlus Nord (a 7.3 based tree): all providers probe,
and UFS, USB, display, I2C, serial and camera ISP devices get their
paths without errors. The Adreno 620 GPU also takes its memory bandwidth
levels from these providers (the Adreno 620 series sent earlier relies on
them). The SoC devicetree nodes are not part of this series.

---
Changes in v3:
- Subject: drop the redundant trailing "bindings" (Krzysztof)
- Drop the "Child node's properties" comment (Krzysztof)
- Binding: no child nodes any more; compute-noc, mc-virt and qup-virt are
  separate compatibles on top-level nodes without reg (reg: false), as in
  the milos and kuno bindings, so patternProperties goes away (Krzysztof)
- No change to the driver
- Link to v2: https://patch.msgid.link/20261024-icc-sm7250-v2-0-0e755894b188@brar.si

Changes in v2:
- Set .enable_mask = BIT(3) on the ACV BCM, like sm8150, sm8250 and sc7180, so
  that the voter sends the one-hot APPS RSC bit instead of the scaled bandwidth
  (reported by sashiko-bot)
- Drop the IPA virtual provider (qcom,sm7250-ipa-virt, its BCM and its node IDs):
  clk-rpmh already owns the IP0 BCM through RPMH_IPA_CLK, and the sibling SoCs
  have no such provider either; otherwise icc_sync_state() would zero its vote
  (reported by sashiko-bot)
- Link to v1: https://patch.msgid.link/20261023-icc-sm7250-v1-0-1e47c1226857@brar.si

To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Ishu Brar (2):
      dt-bindings: interconnect: qcom: Add SM7250 RPMh NoC
      interconnect: qcom: Add SM7250 interconnect provider driver

 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |   81 +
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm7250.c                 | 1642 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    |  148 ++
 5 files changed, 1887 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261023-icc-sm7250-1684e6e41a02

Best regards,
--  
Ishu Brar <patches@brar.si>


