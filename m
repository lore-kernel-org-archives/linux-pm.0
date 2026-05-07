Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF2413245;
	Thu,  7 May 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163963; cv=none; b=P9RSBBmrBSYjXdswgM2pDS73EmDVeUsv/ZFerw0PrOIVKWaIUXIagZTYseHSXoeo4G+o13B/IVJNJ/41A/AuDeLeVjUCojB3e3+xaPATbNLWswJS7mPeSOt401/qhZeLNLSnYSuUFcQ4devVcqmnX/D8azAABzD6ZeVq+pAas5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163963; c=relaxed/simple;
	bh=qC5aHtTCc9n3icRBU1s4JlGsfI3jA82q/Cz+XsUhyu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XvBhZQg1vEGcloDX3JhFG0QXB3rD8H5hQW8eVXq5hEPPleNIZDUxlnovugjw/pIWqX70dQG6fh2tvNV8hDb/FgkvFRYTagrvNvf3ksFPTntTXPNECmNsmcr9iO/lvQQM7EipDLF6DSL8qDdwS2saGMABAhCBhl06HJjP70P98vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpgz12t1778163919t67769640
X-QQ-Originating-IP: sALCS/5WbOyZmdkawfHBQABNKWV3XgulXx5zQ2cmCB4=
Received: from [192.168.30.32] ( [116.234.74.217])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 22:25:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3191623375150751920
EX-QQ-RecipientCnt: 11
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH 0/3] Enable QoS configuration on SC8280XP
Date: Thu, 07 May 2026 22:25:11 +0800
Message-Id: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWWtSjUf5FbGoGoyFRwdpIv5ds
 TyLey9gdIQMVXSBw5OYljkgiSOwo5kHFNQFg5Iql5ksBFuttPSr2BYWJje61Vma9iVCSFaHPfl
 vVze/+WgntPv7gPt+AIojWIlwAAAA
X-Change-ID: 20260507-sc8280xp-qos-a6a8b8544f9e
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=sophon@radxa.com;
 h=from:subject:message-id; bh=qC5aHtTCc9n3icRBU1s4JlGsfI3jA82q/Cz+XsUhyu0=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJl/FpzdujWNg0+soeTstHXfSq5s2Sxzb7Mm99FtXYUpN
 6eFPEkR6ihlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjCR0kxGhq0C/7TXGYTMWcTW
 9+Y/5xam+FJd2fPcXgoyale8XllPzGdkOGgfuvnqA5Ft56WVIk76/9D0ds6YoSwtu3dVwtrsaed
 3cgMA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvjhxCSDgXICj91atmTlnbXm5emu8HPVsa6vnzyWfyoE8/1Dnuryulaw
	gSmvC+UAcyzlY+WHWG/5QSflP60VNeevatHNib5Jpy8CdzNYBcFcl+i9hS4/7Jzkb0efgh5
	AtM/Ii/88OqcaA1BhHxP3zBj7x0Rku+RsIxmh1EHUjMOdWptR2gH2cm7pFbOkLNdo9dp26q
	OH8FJEouo9Nv4nwVm5kIPL6cgmNaVjiVYDvz/I4lsHZVQPK4gZvO5AtyOMRjBlAatfq7r6K
	VbKDmeWVfBpU4osxBpBneSNqpZw2UOW+hrDCmlobwA9kaKgCLV5QW81Kb7eWdNKL2/HJFlA
	AwCYSvvJBucLvHwV/B+XnbEFbap16zPJBBvbRTaQ19EKTmUaITaJtH1eZ6ZdeNl27oG9Beh
	4O2rqHnW2swZV9ZSFi+bU9orajDuzUS5/1br0nXYHvH9OrNaC0hE/CRwigWmo3IxqSoXpOC
	MyMsmJvhYz5Ak/KxjwW98Lq7iNiQMfZGPSUV5RVx7cDoZ/D4PQ6XT+7954rP97klTm1xcrF
	L8WblWWtNRR+j1SWxufHdsuNQOb4mSr6mN5RHmZSyhf2dk1H15OSI1hGaxuhpEGDB2CalQ0
	mVuOfm1Zi0Kcf/cGIjcWcDhvtLCfsafCvbhk9M0Ox2KiWz7oSDn/ushbB1TIqX7FrmBKBNA
	5XsrhUwpMU9Tf562lRQMEiB9NmVv+AcdbDDOfDgPqLuBSN5OTafGI6TOQExjXIn1IQMhnKq
	3bSKuvfsrViKL4meGL9kbxs8iD/MJsjQzZY4B53hZOINFhSYzfuaaOeR2Y0O7x14deqYNUF
	E5DKIVf1shOx03KN4lPgZU+66tYlRReTsrQW5+AZWY+3n3nsVI/OiUYe7UBuwafytzaYZWr
	nCE79zriy+KyVm7gqHSE4HZJHMpU7/Jj3XJIUDuhlsIFR88uMpA81fyTEl3w6YALbr8ZSWg
	tEoy3hdAjH4yxkgwgY2fLNFcu8ocWVBCS2lc4JW4nDr9eKvVnYkrmeVqL0YhH7Bys5s6+kH
	Svy13CjheEpCkibI9x/HYO0n1KooY=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

This series enables QoS configuration for QNOC type device which
can be found on SC8280XP platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip).

The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (3):
      dt-bindings: interconnect: qcom,sc8280xp-rpmh: Add reg and clocks for QoS
      interconnect: qcom: sc8280xp: Enable QoS configuration
      arm64: dts: qcom: sc8280xp: Add reg and clocks for QoS configuration

 .../bindings/interconnect/qcom,sc8280xp-rpmh.yaml  |  99 +++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 157 +++++----
 drivers/interconnect/qcom/sc8280xp.c               | 356 +++++++++++++++++++++
 3 files changed, 551 insertions(+), 61 deletions(-)
---
base-commit: 735d2f48cadaa9a87e7c7601667878de70c771c5
change-id: 20260507-sc8280xp-qos-a6a8b8544f9e

Best regards,
--  
Xilin Wu <sophon@radxa.com>

