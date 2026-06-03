Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E963D1CA4;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=IW4wW7/mShbUEPW/H8a9gqO7n7NhmuisCKEdYSq/g2xEJtPcUM2Wjm5qwHcOkpPU20zIVTAh4tZOJfTxd3P4AozSbfGUoCZ+dI1vRbMupZpe/CMEF+o63zkpzm5MRj1+MuJXs0StwdM1Ydxjm5g4guAm5hjkP5/g/ARqOvNOSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=OI+w5Ft3+926c7D6aVZt9En7bIFGC53cNQ802v7Pjuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VrzJBR/ob8p3qBWfn3e2zA5HymzzMbuvzLSdXtxdvJoD2d0vtGhSm6FAB+CWKn576CqJ2dOXRUIr2k/CUCuvFlMRA/E3gaGho0IWO3+6MYkXlpIcC7VSBu2LHYAKKIWzm3/UT4Jz4gZF3trRbfljtRAbguPpGoaHrxVKEA3SEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF541F0089B;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CB50C181D83; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
References: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
Subject: Re: (subset) [PATCH PARTIAL-RESEND v3 0/3] mfd: sc27xx: Use MFD
 cells and devm_mfd_add_devices()
Message-Id: <178051961981.2666348.665108516921227224.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Thu, 28 May 2026 18:18:22 +0200, Otto Pflüger wrote:
> This is a resend of the remaining patches in a partially applied series
> switching the SC27xx series of PMICs to use MFD cells instead of purely
> OF-based device probing. There are no dependencies between the patches
> in this series, but they are part of a single logical change.
> 
> Link to original series (v3): https://lore.kernel.org/r/20260329-sc27xx-mfd-cells-v3-0-9158dee41f74@abscue.de
> 
> [...]

Applied, thanks!

[2/3] power: reset: sc27xx: Add platform_device_id table
      commit: b6c7feeb604262f31a4279bd66aa300ad0903255

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

