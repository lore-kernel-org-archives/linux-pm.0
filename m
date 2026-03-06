Received: from mail-m3285.qiye.163.com (mail-m3285.qiye.163.com [220.197.32.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331F298CAF;
	Fri,  6 Mar 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783169; cv=none; b=BXS9w0uFce3QRCgfgsJ8MeXkt5iOoCetPD4vY56a5Oest8cB1nD01vze1CLbrkZqCZEB3ZZm+KgP0zH8NGZ3apeagBh5pL832W3UHN03Yqs8yuZvZF9Ch8OCCR2obOjzUlZJaby6U/eDGT3fHNm21qvSAz1IqH5NGq9LgQDiinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783169; c=relaxed/simple;
	bh=tY5u6ew4aK14yFkd46sg2namrulm71QthpYyuZqu1XE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=c7F/8wsvYf4y7asx6xNMxt/5km7td/epMLptzLjanNLOKL6SMxSJGZTRE7BzN0Yq2Zw7JAIkz49my0Q35R4dMiCaPjiShPs3KdbFlXbYNqe9ok2PDKqGQ7DdfDFMgFWbQ8dYTZuEYUXeKQftndi26tkDklc4cBcj5ENDfyxeQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hMxMq6NT; arc=none smtp.client-ip=220.197.32.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hMxMq6NT"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 35fcf41c7;
	Fri, 6 Mar 2026 15:40:48 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Add shaping support for Rockchip platforms
Date: Fri,  6 Mar 2026 15:40:29 +0800
Message-Id: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9cc21786a709cckunm7894a4e01405b5c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJLS1YdSRlLQk0aTh1JSUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hMxMq6NTdtGQXcm34cBu1ZOamzPkNApDLENLq0mCf7Czd+PoegEtWivxlmnF9HjmcbNCyMZDvWEKS6TCD2c3S9Ogz9eYIfkimmvszD8zYL7DBsuOG2uRBS9Vzo5O09FBFtKgNpCj8LxUfwqborBMPsRzA+MLfM88dRbAqTSMijE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qACK77M8imd6tMfzuiqSbpPVRZC5FMb2GQ7Svv8vO/M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>


pm_shaping is introduced for some platforms to throttle the outstanding
burst requests of each IP to prevent bus monopolization. It should be
saved and restored along with the on/off of pmdomain, the same as pm_qos.
This patchset adds support for it.



Shawn Lin (3):
  dt-bindings: power: rockchip: Add pm_shaping support
  pmdomain: rockchip: Add pm_shaping support
  arm64: dts: rockchip: Add shaping nodes for rk3576

 .../bindings/power/rockchip,power-controller.yaml  |   8 ++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 139 +++++++++++++++++++++
 drivers/pmdomain/rockchip/pm-domains.c             |  97 ++++++++++++++
 3 files changed, 244 insertions(+)

-- 
2.7.4

