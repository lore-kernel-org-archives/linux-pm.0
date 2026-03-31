Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D93A5E8B;
	Tue, 31 Mar 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984791; cv=none; b=nVS/13P3vw2IFe7ak+GGChL6kdBOC9IrKzv4DisrI+AGvPxxJpR/OBVSY3dJwm0An27PiBJoBpzT3eIzH+IqlhyGc6vxPxMWH81o+ArKAzoQVCmaOuY5TAITN1wPgG3oJv4p/SjgY/p8P75rS5xAyzX7rZe5PWe2+ke4BW74LTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984791; c=relaxed/simple;
	bh=2rpfvP+05LbXU2jqahKlt1tMkTsyyPunlRLV0XCP21s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IefLlOcrx5NfuSMH/Q7ue1X2sbPa21wZajcHzUj4v06Sz6WYBsPlZ7rxR1hGXO9oZ64hDs7W4CRkmed4j+IVX+xKpRP2A8tC/2ey9iDe3Cg2LLJveoL24Ks6519NB+3MMn3+LuOX3kL1xj67CxPUcy6rMDzTGFUHdyUz7foaD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=payjUUP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="payjUUP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB69C2BCB2;
	Tue, 31 Mar 2026 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984791;
	bh=2rpfvP+05LbXU2jqahKlt1tMkTsyyPunlRLV0XCP21s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=payjUUP7LqdzkjV/71I9YGuHEoy8Gj+BvpEKOJwQ9eorP3AxOho/HUAefXLJ7WGfZ
	 pdDvQqCzq/hf8uHDgx7XSoTOEg/TbXqn06Z/1RFP096rwRG0L88TDV7qXBD4TkUBnP
	 xB/exkaGLpIq07RFE1QidRM+f2D5x+MsL8Bs7Lj9NlXEtxWxayZk8zPQv8fw9W+FED
	 qbO/QfX9LEuG9gjKZvBMNj+mWXsd1Osi+kRVPdgueNgi1lu7hpDd1vDZniuRIjYa86
	 ByjysH2b6ya5irD0z8DiB/pQwU1qnTjTRlIesTgBFxhDSKuGGxxM1rSZ8RWTlC01ob
	 EwIRi9NsywISA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 2/4] thermal: core: Change thermal_wq to be unbound and not
 freezable
Date: Tue, 31 Mar 2026 21:17:45 +0200
Message-ID: <2280354.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4745677.LvFx2qVVIh@rafael.j.wysocki>
References: <4745677.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The thermal workqueue doesn't need to be freezable or per-CPU, so drop
WQ_FREEZABLE and WQ_PERCPU from the flags when allocating it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1915,8 +1915,7 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events",
-				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;



