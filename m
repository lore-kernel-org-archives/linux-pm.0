Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795806358;
	b=QNaXjs62HeQdTDU+IpjQdDyNJi6lySfZnF77xsmhMkr3i0mOn90HULt6KDlpMP3sPGWP
	 37fwOLVAomrhPC3XFs0RV0SnhXTzK28H7f+7Dr/NNfRy/k6Y54lYjpcS0ghiw8xdSlhe4
	 CVIn5Uoc2YPh4qpx/b1uxGNjqrVzJ+GwBBKc+afS3LkLphk5BWPMqOfUOOXjHIRNODF2A
	 mhKPiM8MNisXvAB2J5WeCrxgWXsnF3tNaUj0hZ3vtCWnPUPNWVwDGHnjk/i7IhTcNfgRX
	 9rUd6iBoi4PO9lPZ98ktWPUpJiGlO7/KlWXvb9UY+/oCYlYmJBrcsmNbS/ff9vwfj7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806358;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zNT2+KtUd9oxOXZ7VJVA4bdniUDvQzJvv3ytvWd8DDA=;
	b=jwkdkKU/qWWqxKwXzpfa+MY2fLKzCaoh6Zn0qyLeZLQYKQ2zkzWfB7yNY1y/bzIlur3g
	 2GjV84lC7LB1kk82FdNCJqB/ofqKYcRGoejffxMLsvkQRBNQHC0W17DBuDmmm0ClScuSC
	 e2Z+mHMxxg0GzdavOAtURuLIXWP9Tnewh7YUlmxBi4HcCiLDJQVmsj9OVqJ/rbySk5CN/
	 SiawCe+sRVqu1rovbgEMoOT4eRYsyWJCoKhBvx7bcaxkJm9FSf15HhBZ2MM6O7WTBbHjE
	 OZzxCk9fGvD+gAVJpTURvddtrfU4B3AT3gF7ZR8gv6SuR5ywOsPtsb+AX7yHaf9ytmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpVwf8k5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457A606A31C;
	Fri, 27 Nov 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpVwf8k5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795806358;
	b=HIcVUlwFsD4lxt3491ogqvuQeYQqsQHrkxsokLHc56DM1vuG4kX3N/vG4A7q0KJZ4bU+
	 RmO8TrXX+om3ww7tXffRaGYbSObEcPXx47i5aqTUrB3C2grkCaBzT38Kg+LlL1rMZRgGl
	 apfFYRlYDzaDFFq3bPXrBJE5UH8MmP6HeEoQjse4UkU3X7e6OUKsRl0dEQiS1lhTRG4Tt
	 5NMXdvOfk9Z25ZvHH8ySMwVwvZF3R8GXRROkIA5bMyHB/IERCaNI5w2Nw1p/R51r+AejU
	 q9S/KT5UUiYjaAqhMlK2s6GsG3P0TqBeSFBrvepqYFinnolcuWfOeq0re4JfGUDsNig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806358;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zNT2+KtUd9oxOXZ7VJVA4bdniUDvQzJvv3ytvWd8DDA=;
	b=pelG5yZIsbgt0OoreCBPUHn+wffK0dRRaiW6799qJKIytutGG6CBJ8F2YRJAO+oF8zFz
	 /78WcqirBoJMyHS26Y90beXscVMm1R3e6gxvQgY8XYYs1NPbsghZqcXexCm1PJmrhoGec
	 wGaAWRbUWFXoIMGixqMjvVrbvA7GwOm6RKIa6NAj4NwGdpSoOBTWFhukhtgrE1xe+maHh
	 WUOAt58HKlnhdN549wRxtjMAKen0+beW+eoAlks65Yr9O1kHe6KnoZ7nAkZuftfJLO9kQ
	 pPwAQvYHyDQC/nWdrRSkDscW3m10L9Vp9O1iyUGD7plwqk7LE/ffAo/i2yh+yUHayJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 524681F00899;
	Fri, 27 Nov 2026 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795806358;
	bh=zNT2+KtUd9oxOXZ7VJVA4bdniUDvQzJvv3ytvWd8DDA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=TpVwf8k5d3rzLD5KonaXgw/hnrr7wpsvFaZrU2fY9sG+Nn3wmt5ElSJ/QOojG+V9m
	 TXeDzpdz5NyJ6uAcyXsQAZdEQGVqEaaJKYC26tuMDgf8O35wDPHGzXlZEkZCHMckUF
	 3ok3HnuK2urVu41EDCPbAVyvCT44LQF6oDnSgRhYIgLuXwS1eoM7NtqATi9YmBnsEj
	 h2M8hawn/pustxj1MqABV59kQJTsxvQchwANwfm0x47nus2mVk509pnt0jakXKnPtY
	 cTMk+fdTg2xmU6j+dCBbTaUiepkb/Rc4TG4WMAxwW9L5Zi/VFWcxEJtaR1YwV9FHch
	 R+TbdRqMMc28Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D48744DD78;
	Fri, 27 Nov 2026 19:05:53 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH v2 0/2] interconnect: qcom: Add the Molokai interconnect
 providers
Date: Sat, 28 Nov 2026 00:35:52 +0530
Message-Id: <20261128-molokai-icc-v2-0-7806842d166b@yahoo.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6CMBBFf4XM2ppO5enK/zAsahlkVBjTIpEQ/
 l3AuHB5knPPnSCQZwpwjCbwNHBg6RYwuwhcY7srKa4WBqNNimgy1cpD7pYVO6fwgLF1lS6KJId
 l8fRU83urncsvh9flRq5fE6vRcOjFj9vdgKv3K+d/5QGVVjYhzJK41nlanUbbiOydtFDO8/wBS
 1UXvrgAAAA=
X-Change-ID: 20261127-molokai-icc-1314acd09958
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795806352; l=3168;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=OLY8f5RTTQRtYbj7FHrGwVS/UNeuccZVvC2l7+O5rZo=;
 b=SOG3hH0S+ubC5Vw2XwK5K8aZedCtRBe7ctvfFALmoPiygSz23zInbTqpjpO9bpIWFnFGwqxzA
 2uF52Nlpc0EClItGhM1JU5vxxSEZMwCt6lBIUpryy+Rihz8JyzatJyC
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com

Molokai (SM8845) is derived from Kaanapali, but its NoCs are not the
same: the aggregate NoC is split into aggre1 and aggre2, the MMSS NoC
config and service ports are split into HF and SF halves, many QoS
ports moved, and QUP4, SDCC4, SP, QPACE and a few config slaves are
gone. This series adds the binding and a Molokai driver.

It replaces "interconnect: qcom: Don't read back BCMs without an RPMh
address" [1], where Konrad asked to fix the driver instead. Molokai used
the Kaanapali driver, which votes on the QPC0 BCM that the Molokai
command DB does not have; the read back of that BCM hung RPMh. The
Molokai driver has no QPC0, and it programs the Molokai QoS offsets
instead of the Kaanapali ones.

The topology and QoS settings come from the Molokai driver in
Motorola's downstream kernel. The upstream Kaanapali driver matches the
downstream Kaanapali one node for node, so the driver is the Kaanapali
one with the downstream Kaanapali to Molokai differences applied.

The binding header includes the Kaanapali one and only adds the new
MMSS nodes: molokai.dtsi builds on kaanapali.dtsi and inherits its
interconnect paths, and a header with its own numbering would redefine
the same macros with other values. If a standalone header is preferred,
molokai.dtsi would have to override every inherited interconnect path,
or stop building on kaanapali.dtsi; I can rework it that way.

Tested on the Motorola Signature with molokai.dtsi switched to these
providers (Molokai SoC series v5 [2]) and the generic
read back fix reverted: all 14 providers probe, there are no RPMh
timeouts, and the display, GPU, touchscreen and audio work with QoS
programming enabled.

[1] https://lore.kernel.org/all/20261123-icc-bcm-readback-v2-1-bacee81398e5@yahoo.com/
[2] https://lore.kernel.org/all/20261128-molokai-soc-v5-0-144801dfad7f@yahoo.com/

I used an LLM (Claude) to help write these patches and their commit
messages. I reviewed all of them and tested the result on the device.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
Changes in v2:
- Route the crypto engine through the A2NOC slave instead of A1NOC: it
  sits on aggre2, the downstream A1NOC link was left over from Kaanapali
  (Sashiko). Tested: the SCM crypto path now goes through
  qnm_aggre2_noc.
- Cover: point to v5 of the Molokai SoC series.
- Link to v1: https://patch.msgid.link/20261128-molokai-icc-v1-0-a5e1754f086d@yahoo.com

---
Venkat Yadlapati (2):
      dt-bindings: interconnect: qcom: Add Molokai RPMh NoC
      interconnect: qcom: Add Molokai interconnect provider driver

 .../bindings/interconnect/qcom,molokai-rpmh.yaml   |  144 ++
 drivers/interconnect/qcom/Kconfig                  |   11 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/molokai.c                | 1753 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,molokai-rpmh.h   |   26 +
 5 files changed, 1936 insertions(+)
---
base-commit: e5aad2bdbbee783611d32599f89cea3f12f9593d
change-id: 20261127-molokai-icc-1314acd09958

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


