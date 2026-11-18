Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993620;
	b=RcoHg0rlHpp33lagoUp8SVX4U7yhBtQk11zt7jMGpmMUPv8v8zkaRKF4ELl1Dx44cUuD
	 qCvHjSELQQpvf1IU8lgapCs4TzFhu39XHQTi/kjHPeiP9qIFa3g9Zhz7a6U6Etf6GHp/J
	 EFrHDiBm7uKsMChcGQki7HrkJ1fRxzcoK2gAqLQVLIqJfh15rl4wy/czAJrC9+8f74Ppz
	 mV3byNonF+GK6I/ZYtV9k4Wnh5mgF0QDu/c27wJcyngFm+49GwL67lPSBeIH6QOR96UqI
	 Cw6cn0IhfhDlevZiyfB5gEg8zJof/A/VCyyvyC6lR9GNDJHEJEhsrFkQIAiscVRuJAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993620;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vDw+nWeXJ9xvEEktLyns7YM5p7WDjBtf8VUOj3m6g0Q=;
	b=vJUceuMLb/dqBGf2fLU+PfvhQvuWjnx7NQKVDuyUPhoYDpsnI/+olCvnqQPjk/jiEZio
	 nx0dPE4IfCLAS0x5TVUvXWqK9t4C4I4sNpcBcp9RDaBJNjVf826DHboca9h6hbBPBrREm
	 BqI0cn0HRvvmQnbjk8HSw9I8+P2hOeoMloa6uWCKVwiVt4GHYH+wycdoiAEFOx5eZgnld
	 QdV/Gx5phN2lBCM9YurFn9feAAVkWYWijJ6WM9QtFouxIQMjZGtvJ6yurWb+EQpgTrF5p
	 rTeR230+BP/I5itqpvfrrQm9CT9d2CXX/6xRKcTQiYg88Fih4w04663D/F4rc1nyZBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kur3slV2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B785606A325;
	Wed, 18 Nov 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kur3slV2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794993620;
	b=WcC+VkE+wvxarjCXfNs/7zjVNxD1FICv+Djz4J9gTKv9hpk8zkGcTLlumSlWKoYzO6nA
	 kN+1BJ7+ADtlrzNtGFaln0XIViTzbkriH0NZ5e2C5S2X5S9Hq2Lyo/T7JZjUVsgDQcBpj
	 7xolO9Fsb0WTEb5FOyWzoL8Nw3h47y8YYK/rPSLCiscsedskzA1jdMnw2JqSPvyfMgoTO
	 N3YN89aLHXS6cW3B4t2U/LCg1uwjXJ4GWIrMdfNeZWRnNtQm4/GYy6IlaH5V5V478B5S8
	 QnB/K4WAz0Gyz7/7plPKLn3FG+nOWZV15ZByHiSfB36/Y0L9JN0m3oQwNLVxy++ySKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794993620;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vDw+nWeXJ9xvEEktLyns7YM5p7WDjBtf8VUOj3m6g0Q=;
	b=PMC/kn+J6tnrjsCnQFa+IxrtUx9ZwZiZsMuecrDP2OP2krWT9SNhS8Dufb8fJCwwlwL8
	 mgeEjU1vMxYCmSC/RQO6ouKzJPY1NKgxgmOp52MzGu+dSyTa61ijyLgYJFxhLhQs1X852
	 xtq1tPSJx82gDRspT7I6quYulesgIa4EKjWG9pw9I8IJOzKw2OkrGjhQBNBc2A9fPa1xg
	 r4jHzCSisgtMVYU/nXNhaVxx69S2E9YvYFzjoRYUSpNmSUwhW117wRpAxjx68VsRzqWz5
	 IUYdwD88r1eCUPSL0VtkaNAanLxe0oSseZKoglXNUbwk9upnCYcne1Dr7m2p2e59n2A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D56C51F000C4;
	Wed, 18 Nov 2026 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993620;
	bh=vDw+nWeXJ9xvEEktLyns7YM5p7WDjBtf8VUOj3m6g0Q=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=kur3slV2XmT9UEuVj6A4FncFzMNBDgxrt+S9hkCsbQU6/1FjE1xY2eL5EjS08yzuQ
	 3T0pCveXciMdSA7tZ7vQflJOhlQI0l2YbYl5UvKH7avHAUXTMSePnD29FSt6JupXI7
	 7g5UljNPVgrxngNM5evXOOuEnsAx7asaG4bk9+HfvX72AkR7A4AqfA07eR0VdAFm+0
	 mKyz7bs84LJtd4CU40FjYFMTDFRP0RTaGq9p+GZ5Zy8c+oLKcqBWHO4+4bFfq91U1a
	 09MDoH7+OYirw5ORyFZd0o9uZhg51QJT4+ctxrFiLtY77U+z51FmVml0YgjNdVhmyC
	 4Est4wftpSgfg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 69C124ACC6;
	Wed, 18 Nov 2026 09:20:19 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH v6 0/2] interconnect: qcom: Add SM7250 interconnect
 provider
Date: Wed, 18 Nov 2026 14:50:15 +0530
Message-Id: <20261118-icc-sm7250-v6-0-a06ec15c6e29@brar.si>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NS24CMRAE0Ksgr+PI3f4Oq9wDZWGbBowUQDYZE
 aG5Oz2wYCxlWVK9qrtoVAs1sV7dRaWxtHI+cXAfK5EP8bQnWbacBSp0oFDLkrNsPx6tkuCCIUc
 GokLB4FJpV27Psc33K7ffdKR8nRfmxqG067n+Pd9GmHv/Do8geZ2Mz4DogvVfqcb62YqYZ0dcQ
 tNBZKjIWxsGkyCEHuoldB3UDGPUSvMhDiH30Cyh76BhuBvSlnGG7FMP7RsC9I+WoVUukQrI1r7
 hNE0Pfj6pI5gBAAA=
X-Change-ID: 20261023-icc-sm7250-1684e6e41a02
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794993617; l=4839;
 i=patches@brar.si; h=from:subject:message-id;
 bh=thiWCzeT3qPf3nieXYQksfwNg5SNIAJToCzS7eHf5TE=;
 b=lBhxm3RVsH2eld8XSLOibqgo2ZrjY/vtEo7JKBlzGF9iyMkeUVjX0QFl0CIcg8lFFwusioBiN
 X5MuSknr/DdBNji3rZR7oKV9ZSUKrjbjmT3tic6EA3dE0wTBTF0pwQ/
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
them). The SoC devicetree nodes are not part of this series. The NoC nodes
will follow in a later series, on top of the sm7250.dtsi from
Sreeshankar's SM7250 series.

---
Changes in v6:
- Binding: fix the child node description. Only the compute-noc QoS
  registers are within the parent's (aggre2-noc) space, mc-virt and
  qup-virt have no registers at all (Krzysztof Kozlowski)
- Binding: allow each child only under its own parent NoC (aggre2-noc:
  compute-noc, gem-noc: mc-virt, system-noc: qup-virt), reject it on the
  others
- Binding: add the RPMH CC IPA clock to aggre2-noc; the IPA port QoS
  registers there need it
- Link to v5: https://lore.kernel.org/20261116-icc-sm7250-v5-0-506be082a3c5@brar.si

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

 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |  176 +++
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm7250.c                 | 1489 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    |  148 ++
 5 files changed, 1829 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261023-icc-sm7250-1684e6e41a02

Best regards,
--  
Ishu Brar <patches@brar.si>


