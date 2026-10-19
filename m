Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6744AD4A5
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401868; cv=none; b=uqKkPNSiS3Ft3/rSeTnvHIus2LCF5XhXY7LBZpyOyMTyf6J+wmyp0u740BFhGXZBQciEB5PCBUSburkqSqiNJEnDW+HId1NUOTDAfli/nhmcgQutN+co+cOkSWk5yEaJBdi7LJYcExUchUKqVCHORVxmKgl2OSPovfc2kiMWCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401868; c=relaxed/simple;
	bh=opmJhQyRutddC51J+UVfKfOELmccvq4ueY+QZcg7O50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVJhOZU9vluE47B195ROv4eMMw+8v6bh3/Cn7jjcgfzoaSlTK0nnTyalzRMvNA1AzTmEfN1b3d2KThx7rBAoJ6RzwdQH/vH1e2r6kTyDquHCJQQM2Di2Di8lOa3/AlrH94qNKfcfGt36U6bfoSJBkOGvQaj1SgZ4xXFjCZXWGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=xEVa71Hf; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="xEVa71Hf"
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 473D2610ED
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 11:24:24 +0200 (CEST)
Received: (qmail 17388 invoked by uid 990); 19 Oct 2026 09:24:24 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 11:24:23 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: ulfh@kernel.org,
	heiko@sntech.de
Cc: leonard@lausen.nl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	detlev.casanova@collabora.com,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	inindev@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	gahing@gahingwoo.com
Subject: [PATCH 0/2] Fix Panfrost boot hang on NanoPi M5
Date: Mon, 19 Oct 2026 09:24:14 +0000
Message-ID: <20261019092417.391522-1-leonard@lausen.nl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-2.99944) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.09944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=opmJhQyRutddC51J+UVfKfOELmccvq4ueY+QZcg7O50=;
	b=xEVa71HfxgzTXjABTg3LFhDeiY+KPhHuBBLKFjWpvaMgE158Dm1ZrlJzK95jpAGL7N0fd7IpkM
	AqjSk9GAzbbvO5yPzF755FOljuK3bPGTtgofYiwuU8DtUV0MtFeae6tlaJg4XdbsMzwa9+bFJD+c
	R/kRHNdL46B9QjDvse8ZpRsOc9k48uDmwpOYZCOc4ZOSwQpeekfA9iYrxAQMqfmPkOf2rSGxRhKY
	hspsVJPtZW/jznh7ZeSKecyjW/BeW3xTAc5aVi758lFQgMbrOdUA3VPK/kuArPxDkHlqwAF37GBO
	wXgzwbs8r1ZBv/73yO5tMzFBSx2ndkgyS+xbP1J2po8Rbogrux5mo0HfWQeSjckAWA3yZ3yqMXn2
	1UhpHAyK4AYL1szvzY3RCtlZem9oNPMtah119Hi/pR6g2jmnmI/k9HwQDP2zsrNw0Sghv/20Yr+7
	yPXkb3muAca5Emc+XtN+tn1xmLSD4su6bOgkj9VmQ/LNCQ3QQfcQFCFxHYq3KGk3FnDZhfWcPWv5
	F/6JKMd5rzj0XvZfAEVOK88vPsVyDxeo5GTVCgoQhN4MX4IOu1qVMqkxPX6E0IPpjoMC5g/EUXQ0
	PcoIuKn73shWMzhh/mAaaGqC8PjKrF9l+bxUSfWr+nkFUC2m6Ht/DLg7o3Po7cMQ7ndBLTMEt1L2
	0=

On the NanoPi M5, boot hangs during Panfrost initialization. Before this
fix, booting required blacklisting Panfrost on the kernel command line.
Loading Panfrost after boot reports a GPU power-domain acknowledgment
timeout.

Enable regulator management for the RK3576 GPU power domain and connect
its supply to the NanoPi M5 GPU rail.

The regulator-capable descriptor is based on Jiaxing Hu's RK3576 NPU work:
https://lore.kernel.org/all/20260924102135.92217-10-gahing@gahingwoo.com/

On the NanoPi M5 with CONFIG_DRM_PANFROST=m, boot and Panfrost
initialization succeed, and GPU workloads run successfully. W=1 driver
and DTB builds and schema validation pass.

Leonard Lausen (2):
  pmdomain: rockchip: Manage the RK3576 GPU domain supply
  arm64: dts: rockchip: Fix GPU domain supply on NanoPi M5

 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts |  4 ++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi          |  2 +-
 drivers/pmdomain/rockchip/pm-domains.c            | 10 +++++++---
 3 files changed, 12 insertions(+), 4 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.47.3

