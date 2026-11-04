Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832682;
	b=nWV4KtrjzUrX/vG8DP1twUoXUZ1y4eqVxWHiP2hbJthYF4dli2gCs9iqJyTs9UqsYtSW
	 pPAe6pMw0X3GFFdszCmpDn5HkjHkHX0ADuKKmvrEbxTngGmjbtOb2Ivyl5WAAl95Oy7+O
	 0IS87BQaAd8jVjvnYzlvxJobUNzVt/ZWRr49nVam70gZMtmTRRSEYg2gDis6XnO/7XqHP
	 FE/YagSTa9AeVdsHtDkv01Y5jctPZJjuDBMAdIpbFyOKokxLfQnKSI28LiKxByU8F4uGI
	 oPtglqxPfsyrjNohj9UTFoHPjeeaNCnc+GpVtq9/szR6/Y5rCZirchrM8w9tz6nyPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832682;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=RUeutA5JYkN4XhBF86hLcNctDM+t6W84JjGNnMq4k/g=;
	b=YC6zd7DW2HCHmxqfZYrpeukynRqQqJznaqDN+TKfExwDUw8gNfx3s3NYDeqRuFlsp7KH
	 Ia6Mo2rBSRUVQ930UJ7SXJJo+Sq56ndsaOFSFBXW8HFuZ1YUaNuCzziNpA4LE5IL0VT0l
	 KTzNvohJBSQi6l1Ygcdz3N5ySy9cp1WQutQMXS2zmdA0EQu+aZdHqs+hMlKtvidJydag+
	 cANGsxmkXO4mi6/+rxqi/HDPAb5aB9+NS/LRvIku+N1Pik8kIFsY2fw87dFqwpNgYGltW
	 yKkXEZZpaKw0eF1ZbI6N2mAm/+u/PPG6dzZd5PbmuhGuMLUS4zp9eSH79EkCiPWnP1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZXGekm/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D4606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXGekm/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FCD1F000C1;
	Wed,  4 Nov 2026 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832681;
	bh=RUeutA5JYkN4XhBF86hLcNctDM+t6W84JjGNnMq4k/g=;
	h=From:Subject:Date:To:Cc;
	b=ZXGekm/yVt5HIKgWlf/GxGofKphsJujgUoIGb3SBxsrOGYPG7QKNSh54c4DxMJxyn
	 E8TEGDAq55igQoniZ7PNb0eBrVjEvddK1WhPaxBCOwjxJoBjfM17dpuO+aZsx8N/UK
	 2h+vhGwDE1woaOzsJgXoxdabiySBD7VbRWh4wO++cTcbKCZ2asdRMUo8zlTs6kgAcB
	 LF2dQstv3APFo19PEVWtz5ssCW6E5t8BnynHxglV9ZX5K6c/gTIBNR0eoSlKWoax2M
	 G60C2ueH06OkMNepwm6Z6AxyWOMrjVngNET9WpHS4FBcm9DPnNNwnUmVKBL5ZALHVs
	 Gx+7QijSIYqvQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] pmdomain: st: ux500: Implement DB8500 EPOD power
 domains
Date: Wed, 04 Nov 2026 23:51:17 +0100
Message-Id: <20261104-b4-ux500-pd-genpd-v7-5-v1-0-4b4f256f340d@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDMBAF0KsMf+3AjCS25Cqli2pGO5s0JFQE8
 e6FvgO8E92aW0eiE8127/4pSKQDYXm/ymbsGYkwyjipSuA58PeIIlwzb1Zq5v3GkVXCfZ10XoJ
 EDITabPXjHz+e1/UD4wyYbGgAAAA=
X-Change-ID: 20261104-b4-ux500-pd-genpd-v7-5-1048f61bc405
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Populate the Ux500 power-domain provider with the DB8500 domains and
implement hardware EPOD switching through the PRCMU. Voltage domains
without a hardware EPOD remain bookkeeping-only domains. Keep the legacy
EPOD regulator driver mutually exclusive with the power-domain driver.

This two-patch series is based on v7.4-rc1 and targets the v7.5 genpd tree.
It contains only the provider changes from the wider Ux500 conversion.

The related patches will be submitted independently to all affected
subsystems once these patches are merged into the genpd subsystem. This
includes the MCDE, DMA40, SRAM, audio, regulator/MFD, binding and DTS
changes.

The idea is to land these independently in each subsystem for v7.5
once these patches are landed.

The patch is split in two, if it feels unnecessary churny, just
squash them.

I authorize the ux500 Kconfig change as maintainer.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      pmdomain: st: ux500: Implement more power domains
      pmdomain: st: ux500: Control DB8500 EPODs

 arch/arm/mach-ux500/Kconfig               |   2 +-
 drivers/pmdomain/st/ste-ux500-pm-domain.c | 269 ++++++++++++++++++++++++++----
 2 files changed, 241 insertions(+), 30 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-b4-ux500-pd-genpd-v7-5-1048f61bc405

Best regards,
--  
Linus Walleij <linusw@kernel.org>

