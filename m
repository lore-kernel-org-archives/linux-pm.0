Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.186.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621583;
	b=Qgv95LkloKE+5X5IdXSWrSByl6mzCyewDErhYy9XBCqrn3aP4f81aIsW2ZHKmPgjTJg+
	 mMEBGB65BDQxUCGoNzz9FmpKJmiBvNFtsjQs0z8Qaubt6gVXQr9awqbyq55kopc8ax3br
	 HuydFI4ZWwfxfXvoV//2t3CZg/mEWAsM2Z0CfCbMsNNTY5+7vYSW061G0KVFNEquaUx/4
	 5U6WHaPlf4BM5CqcNv9ZQGllAEaF00xwYXKD4ZOB6ti4yvrm/B5rw5Ov1JKJEf+mgiPwJ
	 T42kx25cXmC2PjyPVtWAVC/D6v+8dLsBHR6rme/1x/V7dlv7QAeeVYrezVFR3a/kPWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621583;
	h=DMARC-Filter:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PDSkEKkks/d7MiM2y0tVB++OxFGGHwNllUbyOwZf0uk=;
	b=SWg7zOm0rFRFfhgVie3OHMSiM2o3mI6+zHjIO3kENCIWVLzFF4R2tiGjL0BYzBjY0pIz
	 QdJVpsEgr5RzuTeoM82MpmwcdPa7aFudb0s+AqGBAuHZn+7Utn8nLBRznky+DZqOQrQIl
	 ojXoJijDmsBi8LBHfzOiBE1eKfMODytO46pzYUu4hb6uhXnhtOfdHpsjmX1fcW6e9ggXQ
	 oYcB/rJyA6XZ/y1T3WmqozrUDwukk1RJGHBXR83Lyj12wNekCgdBOSiPH9fF2QJ+WxYsa
	 LorsP3SoCBsWcIZqa/LeeXg0YDImsy6jGTJ9YFW9no0sN+Spq9L6Es+EZ9w7wtT2Dgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=krgm.moe;
	spf=pass smtp.mailfrom=krgm.moe;
	arc=none smtp.remote-ip=103.47.186.116
Received: from krgm.moe (krgm.moe [103.47.186.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BC606A323;
	Wed, 25 Nov 2026 15:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC0BC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krgm.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krgm.moe
Received: from yuno-laptop.local (unknown [103.47.186.116])
	by krgm.moe (Postfix) with ESMTPSA id EA80083B;
	Wed, 25 Nov 2026 21:16:17 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
Subject: [PATCH v3 0/2] Add Qualcomm Netrani RPMh interconnect support
Date: Wed, 25 Nov 2026 23:45:46 +0800
Message-Id: <20261125-netrani-interconnect-v2-v3-0-1136e2cc6e3e@krgm.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0JmbQ2dAqIr72FY8DPAaJiathIN4
 e4WPIDJ23zJ995bwJNj8nBJFnA0s2crEcwhgXasZSDFXWTAFAutMVdCwdXCiiWQa60ItUHNqMr
 OlBqxSHs0ENtPRz2/9+Vb9WP/au7R3uY2Y2QfrPvs1zNu3v+XmFRlVDdnLPNMm9P14YbpOFmCa
 l3XLyM/kgPPAAAA
X-Change-ID: 20261125-netrani-interconnect-v2-8d3812260f23
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, SignKirigami <prcups@krgm.moe>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011; i=prcups@krgm.moe;
 h=from:subject:message-id; bh=AmDdxPLBAE97NVWXGljfY0cxcowZORedOia0sutb3VQ=;
 b=owEBCQL2/ZANAwAIAUNLJdlxtMKiAcsmYgBrBwLBxd15yk+LaeveyQe0sMlnAIMe5pv6eijWG
 fQxlnKb+cSJAc8EAAEIADkWIQQKI/ZJLAWGn9r1JLZDSyXZcbTCogUCawcCwRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQQ0sl2XG0wqJe3wv/R+RPHtBF3jbsAe0dARyAuQuX8mxSExI
 sRjPB2yOxEkRpZ8M+uScpnKl9hTNOSazZ5A6PT0GVJNbIKRD69joeVVYmfWxga1fLOsGT3KgfZz
 dkU85tgLFFyqc2KAuIAaFTtGMvwxjsPJ8XhAah6FdiXKlCD9EZTTQ6beBy6TjNyZ54+Ylb6IdoN
 zEORIDxAajwvsYpJBT58g11r8SS0e2tnxCv6wJ7t2RhrSEqhQBGfhOI1MNZsYf+1hPGLFSg5cRJ
 GIKlk/ELwGoSZu89zfESuaKZ9E2zX4/ZQaxPcz7vUjaYCarwed1h+ry+eSUHam2CLg+m1YWTWtG
 SzwRfbcNVt/WJH3go37n1Z5JYj8z1r6chr1Z5NyNTpnOmRh5felcdE+8Ga0UJ562CqfBHhRwToL
 pCpQYJQxmmVVr/0bLeebnLt3a/HDgT+2IcGDqhHkm2PXcqkSe+a+cATfbw1u/PDnXGA4XseDjBa
 LXLOsJAVQwdaffY/dwffalIqS1P4fkf
X-Developer-Key: i=prcups@krgm.moe; a=openpgp;
 fpr=0A23F6492C05869FDAF524B6434B25D971B4C2A2

Add the devicetree bindings, interconnect port-ID header, and RPMh provider
driver for Qualcomm Netrani (SM7435). The series registers twelve interconnect
providers and sends aggregate bandwidth votes through BCMs in the applications
RSC.

---
Changes in v3:
- Remove the ARM64 defconfig update. default ARCH_QCOM is sufficient for the
  driver, and ARM64 defconfig changes are maintained through the SoC tree.
- Drop the redundant "bindings" suffix from the dt-bindings patch subject.

Changes in v2:
- Make the binding self-contained by replacing the undefined parrot codename
  with Netrani (SM7435), using the standard RPMh description, and linking to
  the interconnect port-ID header.
- Document the new port-ID header as part of the devicetree ABI.
- Remove provider clocks from the binding because this implementation votes
  bandwidth only and does not access NoC registers or configure QoS.
- Expand the driver changelog to explain the bandwidth-only design.
- Add the ARM64/COMPILE_TEST dependency and default ARCH_QCOM.
- Enable CONFIG_INTERCONNECT_QCOM_NETRANI in the ARM64 defconfig.

v2: https://patch.msgid.link/20261125-netrani-interconnect-v2-v2-0-4eab92854137@krgm.moe
v1: https://lore.kernel.org/all/20261124-netrani-interconnect-v1-v1-0-bb5efdb229cd@krgm.moe

---
SignKirigami (2):
      dt-bindings: interconnect: Add Qualcomm Netrani RPMh interconnect
      interconnect: qcom: Add Netrani RPMh interconnect support

 .../bindings/interconnect/qcom,netrani-rpmh.yaml   |   77 +
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/netrani.c                | 1723 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,netrani-rpmh.h   |  169 ++
 5 files changed, 1984 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261125-netrani-interconnect-v2-8d3812260f23

Best regards,
--  
SignKirigami <prcups@krgm.moe>

