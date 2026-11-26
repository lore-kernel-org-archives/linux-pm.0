Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654417;
	b=io5RbZQqQGD1J6/ZkGQAcmeHCfYNgCRKY3JyKdu28cefnMGlX0vs5KwNTB8R3P5ihyn8
	 knY8GbN7uBv2lZY9Jg1O9bUgvacwBcrvhquu6ap32bDnB5WeR6sMqvKEqSizQROqKT+eh
	 dDnH+LcsHtBxaj9v7sN9l9uoWKI0LgajwHsuyt7KKMZMPqHjZ0snEJLh4pzqczrY5m9jN
	 KryV/o6jWkXAUY0xL/Ax3Rf4Y14U8gxQ3K7ZHjfeX9+nU7tcVkgWVvHIPk8rf/vfRx66b
	 nsGCdyl5XJ/miv6Fhx9Cut9K+hzuWqypv3D+5ELrstIIKGUSVNw7lnF735me6fNfDcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654417;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uU22h3jpaXKv8VPx4Lx9G4sdjfw/2Tu7j5+Bo/KJuE4=;
	b=kFwXTvrZ94C7qMO61asldz1hkso+RoeIERijcXjrzjD9N/Mat3EcuOev6gJ2MsVP1l+o
	 lG9CVs1So9hil4XcSKPgoTRYQlSqQllVBRbc3zue77q5N0sV9pTBwNUAGhfgvogspDR+5
	 Yqq63UYfGJCj4O10wKEgWrOsuc+eEqqu4+z0aDKlG3aRl/MBnl14rMQ2KnThYnDLLjgyS
	 bPrWvF0F0E3xtt5EcbCZqCkcHMYEuH+Oxr3mzoQGgU2O8nppnnko+Kbn+XaWYWWEPjE2R
	 FkbkHRWfXvbe9D0/MyeNsu5Iz5RqRiV+N9zweDRwdEqFHQedYsTfR2NW/L+/6cMrKbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVoSkYA4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F1606A690;
	Thu, 26 Nov 2026 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVoSkYA4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654416;
	b=U4eNpPdWjFR3iu4pk9HnKg1T7Nxnc+2ibWelBNLQouIg5XMkJNa2Q6gbb8+sKT1L+kdV
	 oyYKTbY98LqCH/LObfL/2sPfzpajYI6pgc2XECM1lofMGbTqMeC8lEXgJ5uCJ8k9zEeA8
	 uIJ0pm+Xp8ypzCinobrLlQ6VOTV+KMd957cCyU9rL1o7va3iscqZwyEWxzi7uCZUqtQKK
	 0nGlFEDOGu9FL56rBXrjP+w1mmY6GuDU/LatOx/XJ40zD1qZ89Yv/brj2oYLdbs4EMLzA
	 Ds1Gsv8+2Hzhd1GJlKY6Xe7kfM6GsE4MNZTiCF7urP9lVEow2vjM3uGm+aHzs1Iy70A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654416;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uU22h3jpaXKv8VPx4Lx9G4sdjfw/2Tu7j5+Bo/KJuE4=;
	b=iQydiiG/GbQihixLE0A+IaCibQHxTFLJtwsrdVTA3MXf53lhijtZ1vjx6aD61NLsUjAe
	 j8tPBbAAZmtno3dJWSm5MWPOrT0Iyy3tpIYOGrVr8eaBOxVkDWa9Z/Vm4aUDvqrwvQ/32
	 hkP86MsFjy8T1RRPLJmVmtxAuxRoLz9B7mRaQtEsjdq1vIqk7mBND+g+eqLZNYJW0o+qX
	 Yzpef88RspVJpQXIbSbPRRqEnH9eUv3jtNXq8/j4LU/2CY9VkkLka8BdnjXfCnO7ELpd2
	 Vk2cSYkcT9noNvxj0eYhiL0wz+Wmc79snq/gw8+6FadHncQfab1Hk80arBlZT/eEzfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8D8B31F000CF;
	Thu, 26 Nov 2026 00:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654416;
	bh=uU22h3jpaXKv8VPx4Lx9G4sdjfw/2Tu7j5+Bo/KJuE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=CVoSkYA4VTpjKgnbLGSLGd3+mjugv5vPoCrVeBkXpqUksIUBIVaLt1Z1rnjmkAtFA
	 p8fhrSXzvEc3KD1rNjsiPWzWYlHzB3ieKAf4AJg7KGw2okvB6cQoZDvJIhMxAPFBPZ
	 y6wQYpEpu/gP/+Eii8MvxE86cyNe5/x9mWOdE4qE++6Szm2qBp8gVHNkBda5k7pqcw
	 tNdyr9u9G7pspwrWen7diFMJAfRZoro8bwq7fBTP9vlITo10yRmHlKcPP8JGlwJVwF
	 Si1Wie9UPDV43ZgvFIqRFtsb5m+qnYw/gBLm9G5XUybiljl3s/ogLIDTPvadSeY/Rs
	 IBvhbUbAhVoJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E2624D140;
	Thu, 26 Nov 2026 00:53:23 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] thermal/drivers/mediatek/lvts_thermal: skip sensors
 without a thermal zone in IRQ
Date: Thu, 26 Nov 2026 00:53:25 +0000
Message-Id: <20261126005321.71799-5-iasnezhkov@gmail.com>
In-Reply-To: <20261126005321.71799-1-iasnezhkov@gmail.com>
References: <20261126005321.71799-1-iasnezhkov@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654402; l=1531;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=GQljtqYQ6lcHw8R3VtJICUMkx+Xq1lALWiNrkmGHLgg=;
 b=DH/AUAWu5lnGqPy8+N3l9XPuuvdXd1jikIKHLwpyiWTax2zPR9JKcsvnhDQ2Z0kSFmJa1+W52
 S6YPolMrjUSAe9bNSFd6DBmtwUbgjzO1f7yZdbaIP+h96n3Oxg60u20
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

lvts_ctrl_start() skips sensors absent from valid_sensor_mask as well as
sensors whose thermal zone is not present in the device tree (-ENODEV),
leaving lvts_ctrl->sensors[i].tz as NULL.

lvts_ctrl_irq_handler(), however, loops over all four sensor slots and
passes lvts_ctrl->sensors[i].tz unconditionally to
thermal_zone_device_update(), which dereferences tz immediately if a
status bit for an unpopulated sensor slot is set in LVTS_MONINTSTS.

Check lvts_ctrl->sensors[i].tz before calling
thermal_zone_device_update() while still acknowledging the status bit
with W1C.

Found and drafted with an AI coding assistant.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index f0b7caa..5fc87a8 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -588,8 +588,9 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
 		if (!(value & masks[i]))
 			continue;
 
-		thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
-					   THERMAL_TRIP_VIOLATED);
+		if (lvts_ctrl->sensors[i].tz)
+			thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
+						   THERMAL_TRIP_VIOLATED);
 		iret = IRQ_HANDLED;
 	}
 
-- 
2.54.0 (Apple Git-157)



