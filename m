Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795804724;
	b=t94awrpIa374Pn6f7hwWOMJf/hy2hGSCWY8c7DzwsbzV29T/2BevlsicjtRY6Ky9Xot6
	 48J6pPN0E9+afFsqFANFCm1nU8eQ6jXX90suKfzx1z2col/VoNx+mIr/7rkKFNC76lWia
	 vejm/KIGe2h0/UlqMZsKC+NH2zrhHnyspkg7f988TjrDUtbyWul7DodbJ5wlKh/YUKlN/
	 tkKSo5mpWaR7Tt30/zCq3CE7koBA91iGwFvrePmkStQe1XdbMr511mDzbjWxfgDr4otfv
	 J16GHNPn+oZM3qFvoHJZjZi6Walw/JATRUwKZ3BHNkDW1vzABm7KLC7F29LIzbE3yJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804724;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=+MBUz4AYi6RkpX6F26f2XwoBsJ4+PFRX1WOKsakLQxI=;
	b=VIS0hN2KUZX9Ng/y64+Iepe6tBN4xRfy35qFnD+diT+duvbP7kO3KZTTyZ8/20WLIKNY
	 w8mTwisF4Rn+nThJuVzPAsYo8G1xzP5Cfok3sdPpOuUcGv+NyF2repbgvje/Q7OtVwej6
	 y+AAJkAoaMO9lT8mHbki2xx6zqdBdWFN3c7RxI47JcR/1tmXXhYMOMNzQZRfV3cTsHKbn
	 Eni6SxpGLtv6OkRM806bDyPmtKLenrZ8lFa0ooRmI+ZIkxCCgy3dIy9I+v0gf7xeKfMtM
	 XuLBxH3dSwcIiJUoJ59jlWSz3NGgjjI9sExdd1snQbfUqaWuQsRSbbSkAEDN91+arIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILXEfJvY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A3606A32F;
	Fri, 27 Nov 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILXEfJvY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795804724;
	b=SF50dMZFBxj9OyL+RHVaZ3ZqLwI7ektpWjH60ov4kTOYlmBeqv2D+CbQlXtAmVo8D3nZ
	 ZWeFMuu5I3dh4tgYomYIZn4+Fu5h0Q+27//ozycHVoMReguBrghOJBGVPhgN1gNO/i5g9
	 Bzqf/W9wcZ3rdQbwB+PTfK6P+wVDRGhCy6QCppORvO/g9HkhZMeb+AzEH9tjl4hLdQMca
	 if/MS+/0kY7U6SJKQ0OvMu3/56vHAdtD3vZ0JIwVr9stI7cIDLvdpXjEepxBD111J/bwx
	 70Z53D8y2lj5/Z+rgBAKtHa0vqPVmNaSvqgBUQc+Q01X8B3LyO8ZzADGiamnjtYPe2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804724;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=+MBUz4AYi6RkpX6F26f2XwoBsJ4+PFRX1WOKsakLQxI=;
	b=K6lX5Cn/nU1njL1HqfpKKs3qJNEXCNRqYaxcrw9Jews80kzRVTXMAtxu/+fzFzeMbroE
	 LgVsfmsRlWsE0AgEDfDKJAgak2nz0EHrtGE0TsY8nzujJ/ACFjpvFwIcYaRy3/uE4tv9S
	 R7eapukzsMDI46MhAXYIl+ISeUGWFAouYBXWwrVEwe1TItdlC6komRm/Q859fAuI+2h8E
	 doS4+jsYtgRIlBeb7dG4DGCuU0QNSGESycOBPX/F58SvH132L+A7s+2xVXawTMX7vhza6
	 9jrFSY4yAT8XFlKca2/HCWbviuxOERf3Sp0uBYcpGDlFgeZBbyyEpwiygE4SUOF01xw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7AF341F00897;
	Fri, 27 Nov 2026 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804724;
	bh=+MBUz4AYi6RkpX6F26f2XwoBsJ4+PFRX1WOKsakLQxI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ILXEfJvYZfhGFXpf6wGXqFe8ImPRi38NCZUAchoA+IxPl3JhK33JJuhZdgH39y5XH
	 DH/ZskiUDtIVDgSm8p2Z3c9inUfkczjLmeJbaRf6o4cJOP6hUqpb7BQqkh5kE7c0UL
	 oRVN8mlZys6LcueLL5EDgGC9hRxhMQ4MB1cpX9iBecbUaIG5Z5R3Xpf33v7Jd0aKCz
	 Qm3Y/YEoxHACKD3HS1a71dlOBI/DDlb5PZ7SNXwecLBiRF0O+r4iw/U5z7pJNoZyJH
	 FZr8kzToZwGfdMnPwJVzYZHhvDHtH4wiFbEYK9uSb8w3RtFkYdHMbekUYA1DPMK0D+
	 H9Atgu+hRXhcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B6544DD22;
	Fri, 27 Nov 2026 18:38:32 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH 0/2] interconnect: qcom: Add the Molokai interconnect
 providers
Date: Sat, 28 Nov 2026 00:08:30 +0530
Message-Id: <20261128-molokai-icc-v1-0-a5e1754f086d@yahoo.com>
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
 vPSU3UzU4B8JSMDIzNDQyNz3dz8nPzsxEzdzORkXUNjQ5PE5BQDS0tTCyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgAmE64XbwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795804710; l=2800;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=fXLAvIdNliK1/1iNFd6S6NyUNtEDWrD2V5vNaSxzJIA=;
 b=RiGyHBLQmu7AciZHBkLTJyVb1L9oSmimVnmNhaM6eAfQHOyhRrfShhkB4UzWHnmwOOF6FkA5N
 p9dbean0PKMD3iUDLbvrDT1tDZGUoAoyhhvi6d4GDMc5zri5ku5/Rnl
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
providers (next version of the Molokai SoC series [2]) and the generic
read back fix reverted: all 14 providers probe, there are no RPMh
timeouts, and the display, GPU, touchscreen and audio work with QoS
programming enabled.

[1] https://lore.kernel.org/all/20261123-icc-bcm-readback-v2-1-bacee81398e5@yahoo.com/
[2] https://lore.kernel.org/all/20261123-molokai-soc-v4-0-851e5a9f4878@yahoo.com/

I used an LLM (Claude) to help write these patches and their commit
messages. I reviewed all of them and tested the result on the device.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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


