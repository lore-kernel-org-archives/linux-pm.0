Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794810485;
	b=ZYbsY5yK5tXZ/fzvVEb7NwVG8tQt8EepO+9imc61+Ck6WlIxYiBIbOX0c6r1jc1/x0f3
	 UeLF8KYrxSLsTskJt6SS7H+QV4tgxV/PvgwBakrmoWGBMYArw5T9z8SiwBJxtCSM0LDQN
	 i9sm1280l7/ZPT9RtgM/C5GeL1E0ECJO+WflJXOxtGN+EyrZf+hYGwRorIWCtC9zlio2j
	 llxOH3sb/1J7Jz33hwZUkETM0/NvPCAPiFeSBcRiqdVVUDXYTsV+FdVuztHYz2z5Hu5oF
	 4Q/LCgtB3qauq0bGlQvTSulakSoB5S8Bo0Aws/fXUnkk9pZBeqqsDO7OPXhKdtm1Qwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810485;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=lm13Y6ctHvmZbeSOQhKri06XHlukKaMtOFS+YBisHDU=;
	b=klBRAhpPitw6z2F0hTr4iF7rVOLUd9hrZL/YCBld1iYnwZbZ+CABC4gTGUR+Qyt1/z+Q
	 uSs6TonsO5qwl2M93TZeovi0x9v505FI9on99siFHRpuRM18yX3krHdRadcosc1KpahbU
	 /bhArcjnm6QoZqJxyaqbXQ8i810IYoup5JQGuQnFVdCoxPHJ0j41P199V34vcLiHCeA53
	 drnBZWbAkyexnvitO2p1zJ/cr68YjBKkuGrv6gO94g/pIh9Gv+1tVXFaGnOERp6j/pj4d
	 oceWCoxGDowLQ/dcws10Mps51iZhDpvwo+0oHmX54eotCY3lGEgt/uXUdx2uBQJgMHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqRFOw9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D93606A32A;
	Mon, 16 Nov 2026 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqRFOw9K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794810485;
	b=ozjXwpukQqmu9sEajnM5c0CgYw9DPNnBvN/BUUjQ7iELXSLbsQHJPXQ39PP1G1MU8T/m
	 EXy/PENru8n55BXq7pH/x+vUpcTM37d7Q1C257U+G0DGY7lQAhou603HWW35YYSWPjBYJ
	 AZ4HVvISf5cmiUhzv+EiXqCzh/P5Z81iASE/n5biebMn7RKNX4ROR4quE0ZL2mxTSK6mm
	 ETD0FOtZjvFro6QFEwpUtmD+ohMA/hFc0uTpTkBh+ljZbzVu2ASacCXyWUIC3ZcOB7yPx
	 Bqz4HXTNUFhY04gs9uQN0ImWK20Dl+Fg4EbyAiN8rejKte3hYei1RPwtDtOv7pakkcw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794810485;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=lm13Y6ctHvmZbeSOQhKri06XHlukKaMtOFS+YBisHDU=;
	b=RbGDw+E/fFuA2e/loDXqqVlP2Tsh0q7zrmpKQRs+AZcwwAcZG4bd4jK2A2mdXOyJ7rba
	 hGwjmw1AMg5c0xyitRgsGT3r7d0Xg9OhaTKkI1YNVy7QrwyHSOSlPeE/otZcM4JSdVqQz
	 g+tLkpUgZtFZ/dJJvyQSSkBtlNKgQKiK+YXpOvgqjV82v1dsXDFacuhXWcxcJOB1DPEw5
	 ygLHW7IL2TD9pWKCheuVWkuwROYZdd+OSHq82eKBr0o1FFFfHjenm5wFDBZ7Du40ZzPYL
	 etgQYXTAAyj3eNxZDsoCnZORf4lasREwk7FsiPHP55rJzyY0DWUTyzHjUjZN1Xoojxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 561401F000C4;
	Mon, 16 Nov 2026 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810484;
	bh=lm13Y6ctHvmZbeSOQhKri06XHlukKaMtOFS+YBisHDU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HqRFOw9Kzj1aYqQWRfO52t0ABZD/7WXaeNfLtHKCVid5aJShnD5K3JvjOXPV5M4H7
	 D6MtcS082oDv8fwSw/j1zlsX6/T+M9nKSp7CXd3teOUBhZPpJac6bTUzKSUuvOxz/c
	 4vIDUGQMEmfhRfAIa8kKyX2JeVObefI8KpF6A6iTr/Kpaqf/ambNHQzRng1tfMJc2a
	 OUIAzV7ZDRLzgwfyyFlIoJoFzIoynb3Y+G4tdoThe5xHovD78tR3PV2JTSLwZw6C5w
	 AJgpZUo0TiAqXAxWDrZAA3QF5+LyZGe5tEoXV1VgemzmdKUnkvGetPx3RypAvlOG1+
	 MU3g9S1eNhiXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB2394A34E;
	Mon, 16 Nov 2026 06:28:03 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH v5 0/2] interconnect: qcom: Add SM7250 interconnect
 provider
Date: Mon, 16 Nov 2026 11:57:59 +0530
Message-Id: <20261116-icc-sm7250-v5-0-506be082a3c5@brar.si>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NSwoCMRBF0a1IxkaSyrcduQ9xkMRSI/gh0UaR3
 rvVOrADDh/UufViFUvGypazFyvY55ovZxpmPmPpEM575HlLm4EAKwUonlPi9eTACC6t12hRyyC
 AEbgW3OXHJ7befHe9xyOm21gYLw653i7l+fnWy/Hub7iXnOqoXZIA1hu3iiWURc1szPYwhbqBQ
 FCgM8Z3OkrvW6im0DZQEQxBCUUPofOphXoKXQM1wV0Xt4STTC7+4DAMb4ZOxtRfAQAA
X-Change-ID: 20261023-icc-sm7250-1684e6e41a02
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794810482; l=4178;
 i=patches@brar.si; h=from:subject:message-id;
 bh=FmDl7r4ZU/FsePaBkU/prDSU3hSRvdYbNG3dNT3ojhk=;
 b=QyYaOwfZ7o+nvOwhePp2p456xxQNFBIR0gamgbFhIFS5MUeuMjAljcmZZDsuzYul26wdqbza7
 2t82WJ1NYpdCfBm988re+mEAyVdlRYj04v/Q+5yWZhGGWeO0860ipuZ
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
Changes in v5:
- Binding: each parent NoC has exactly one child, so describe it as a
  single 'interconnect' node instead of a pattern (Krzysztof Kozlowski)
- Binding: move allOf to the end, before unevaluatedProperties
  (Krzysztof Kozlowski)
- v4 lost its threading: my mail setup rewrote the Message-IDs, so the
  patches did not link to the cover letter. Fixed for this version.
- Link to v4: https://lore.kernel.org/r/010601a17d6204b2-d2d847ec-d522-4402-8450-187fb3ced56f-000000@ap-northeast-1.amazonses.com

Changes in v4:
- Binding: restore compute-noc, mc-virt and qup-virt as child nodes of
  their parent NoC (pattern '^interconnect-[0-9]+$', no extra comment),
  since they share the parent's register space (Krzysztof Kozlowski)
- Binding: add the QoS clocks of aggre1-noc (aggre UFS PHY AXI and aggre
  USB3 PRIM AXI), required there and rejected on the other NoCs
  (Krzysztof Kozlowski)
- Binding: drop the redundant example node (Krzysztof Kozlowski)
- Driver: order the node definitions so that every node comes after the
  nodes it links to, which drops all the forward declarations
  (Konrad Dybcio)
- No other change to the driver
- Link to v3: https://patch.msgid.link/20261026-icc-sm7250-v3-0-aa303226298c@brar.si

Sorry Krzysztof, I misread your v2 comment about the child nodes.

Changes in v3:
- Subject: drop the redundant trailing "bindings" (Krzysztof Kozlowski)
- Drop the "Child node's properties" comment (Krzysztof Kozlowski)
- Binding: no child nodes any more; compute-noc, mc-virt and qup-virt are
  separate compatibles on top-level nodes without reg (reg: false), as in
  the milos and kuno bindings, so patternProperties goes away
  (Krzysztof Kozlowski)
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

 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |  104 ++
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm7250.c                 | 1489 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    |  148 ++
 5 files changed, 1757 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261023-icc-sm7250-1684e6e41a02

Best regards,
--  
Ishu Brar <patches@brar.si>


