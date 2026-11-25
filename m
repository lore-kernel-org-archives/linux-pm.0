Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.186.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619464;
	b=lqgbMcrNIBmyXTaQ5NidVITUUrrYtzDmCSAZmOPVqDP0njhQ9yTQaVHwKBYBkKnMaRC7
	 vlUdOc655JarQGin1BnUsOLiM8tQRf8zYyhYhMYqYoYTcXm+shU0HJjTi4aYfuwOJ3jjp
	 yEzE3hi1Kkcbqq2XxNwYeoylnHx1JTw0LOVEvlxcldAK8tUWpNjeyRY4L3CiSx7Yv1jkl
	 Lw6eboQlfRGRy0Bi80XyJFcOTrHnQDNSs9zkaTmMt+TF6fvLIllVnsT6mxqSSI6zUMErR
	 32XF06ByraubV/3ZkvZm+oBdyQfk4+4+o7wcjoBh5CsFA+QgO0nagY2+45n14biU0TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619464;
	h=DMARC-Filter:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wKAzwlJaHvvZUc1GqVIsN3QLNoOjrdsYRfFTCyMKo78=;
	b=W9jzANuwIKM/WSs0ITXwtLF9kTtDNNcAmjUxFomG/2PHvzehxMnf2s18WHYg9DlE5Oju
	 /UwPS6m2NSIvSn+Mtgt+DPFT28Joz59FOMbI40Rw+V3c3Ykz4RnLpfm6kXKgSa8y6rlv7
	 svqrQDTlKentE3ojK5v+PZe5EImIQDlZaYR4wbT7MPP5HKFUUyQSu4ygTJEH47RWE3lXO
	 jVbh7/ESo5yvouPDqEWnGUF7Cdal2GaEoqXYcHCEHbooVfJL8Nja3dMbS4ZSI+Wj6h3dU
	 cB73oGjdqIbc8rsQbSlUQv/+dfsD1ByoQ9gTW0wys7Y8T/wqukCFaTrQJ22bn0Otq3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=krgm.moe;
	spf=pass smtp.mailfrom=krgm.moe;
	arc=none smtp.remote-ip=103.47.186.116
Received: from krgm.moe (krgm.moe [103.47.186.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE3606A330;
	Wed, 25 Nov 2026 15:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDE3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krgm.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krgm.moe
Received: from yuno-laptop.local (unknown [103.47.186.116])
	by krgm.moe (Postfix) with ESMTPSA id C032583B;
	Wed, 25 Nov 2026 20:40:58 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
Subject: [PATCH v2 0/2] Add Qualcomm Netrani RPMh interconnect support
Date: Wed, 25 Nov 2026 23:10:27 +0800
Message-Id: <20261125-netrani-interconnect-v2-v2-0-4eab92854137@krgm.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gZsRBGvIi60xjEuoqRVBPHu0
 3GWH7z33xDYhAO02Q3GpwTZNIHyDPwy6IdRpmSggmrnqELlaIMKikY2v6myj3gSNlPZOKK6mKm
 E9N6NZ7nectf/HY5xTetfDp7nC+AhnxJ7AAAA
X-Change-ID: 20261125-netrani-interconnect-v2-8d3812260f23
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, SignKirigami <prcups@krgm.moe>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=prcups@krgm.moe;
 h=from:subject:message-id; bh=S8jIpqyqn7BsyDavqg3O6s2rA7TOYn5AWPi0OemCYMw=;
 b=owEBCQL2/ZANAwAIAUNLJdlxtMKiAcsmYgBrBvp9NP3a+0QskKMgJ9UsbQPR16O+fSLdFOpki
 OYJX92u/l2JAc8EAAEIADkWIQQKI/ZJLAWGn9r1JLZDSyXZcbTCogUCawb6fRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQQ0sl2XG0wqJ9dQwAqazwc5IbYeyrwA+hM21sjOmIptwBuaA
 qVBCPmN8cDkkQch2fCOc3ExFwpn50BsUvmF5IdOOqbVRp5fMxPWfh7l1RbJvBdy6h4n9Ez4Kcrq
 05ZQZIu2bSOLrzOVbfVs9VBAw9C+lyLOt4mCLFqSZ3SRqTowiHkQmSeeIhmLy/8fYTYQffxXND1
 HhdiKchnYbtjFs+jxuYTLYKD0x8gK6tsRfNs5D0tL+Lv7sbdxRJu2EgApco04jT0oFPrOm7x3qw
 8bSKsYBN5QAqnu8GB2VJUvubCA3bPIeaCfXpI/u/kaM5cfVcxHnV3cGw5skqmW6Ukui3Gc1s+4r
 WqliYpNBxO3hbmxonsCZ0IeFDwMXUZjZpGOpYWB84TpiClGSgrylYlqGeqHcjeqhx/3P+AXZ1Nf
 l6wgBzCs5W7hxG4C/JPiVp0NhtZebG5pQStUiT46ouOP1LXH7EWieOoiJ67W1AyaucYwiH1sePE
 yTx3pOsLHO/r3PP8UQSdydMZCunC6JX
X-Developer-Key: i=prcups@krgm.moe; a=openpgp;
 fpr=0A23F6492C05869FDAF524B6434B25D971B4C2A2

Add the devicetree bindings, interconnect port-ID header, and RPMh provider
driver for Qualcomm Netrani (SM7435). The series registers twelve interconnect
providers and sends aggregate bandwidth votes through BCMs in the applications
RSC.

---
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

v1: https://lore.kernel.org/all/20261124-netrani-interconnect-v1-v1-0-bb5efdb229cd@krgm.moe

---
SignKirigami (2):
      dt-bindings: interconnect: Add Qualcomm Netrani RPMh interconnect bindings
      interconnect: qcom: Add Netrani RPMh interconnect support

 .../bindings/interconnect/qcom,netrani-rpmh.yaml   |   77 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/netrani.c                | 1723 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,netrani-rpmh.h   |  169 ++
 6 files changed, 1985 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261125-netrani-interconnect-v2-8d3812260f23

Best regards,
--  
SignKirigami <prcups@krgm.moe>

