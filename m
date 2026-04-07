Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBB3BA258;
	Tue,  7 Apr 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571053; cv=none; b=rm1iL/K4cPkWC4ECxWdTROJalXBnoimeRA0YLVp8u2RU7xsDTdd2jXIcM5FvhxMTNfrl85Trj0eWD9rryKNhZVa+oCGYNZOOcQ1LqD/vNrFGBw9jnnyH4peCIshogwCR1q7PYBAP5ETpjmt3nuzak5r7+o6vGL127Qp8Rd32Hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571053; c=relaxed/simple;
	bh=NH4DCemmEh/KzB+lUTpqLoYo4Q1pELKN2OjcpBMiYNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKTqqGLdb4xIauI6ezZQLavvQ6MMT0Sf5BsYMwAsfn7an2gxoJdvwEqId+zxO9oHpBItY2v5augnrionhOtLy2P/ZU7WJxkIuEV+xQFq+wrzETDKgsu9Tt/64wEQ0QsuKaW19Hynwb7nJvFI3b4zdFSr3p+5wcLYUYf51vnyhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWVPsGr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWVPsGr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7903C116C6;
	Tue,  7 Apr 2026 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571053;
	bh=NH4DCemmEh/KzB+lUTpqLoYo4Q1pELKN2OjcpBMiYNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWVPsGr4W1Q6S0Ie9PDjIdi0+8kE88hBF21OgsrohuAvM8wKvR8AseVWfyUeC9tbd
	 cDDzJ5yllvtE9WY0qqJLaWGDIBGIUVwwwpfDT6ykT1iyfJ1GMuefRRvU0PfUoBUYcx
	 F6zuOa0xn6PWXHM9FUNihIsEVDajjczA/GbTAFULMew7Q+wNuz679hMOKxA1QE8rLV
	 KVz3mkJ6ig+wSVaWVFWW8ytHv3DJwRfRU10bkr0CBNqiRKvOOy1qgIfsP8DgN6Lkwm
	 XXxyGJZyMchmQ9uW9dBM1Tj22iqTd6I8OnfcEdhJzBkvUqwZlDoWRjxQbnXI1xeXlF
	 bQ0Tt4u/LIJPw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v4 3/6] thermal: core: Drop redundant check from
 thermal_zone_device_update()
Date: Tue, 07 Apr 2026 16:06:23 +0200
Message-ID: <3406806.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12871778.O9o76ZdvQC@rafael.j.wysocki>
References: <12871778.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since __thermal_zone_device_update() checks if tz->state is
TZ_STATE_READY and bails out immediately otherwise, it is not
necessary to check the thermal_zone_is_present() return value in
thermal_zone_device_update().  Namely, tz->state is equal to
TZ_STATE_FLAG_INIT initially and that flag is only cleared in
thermal_zone_init_complete() after adding tz to the list of thermal
zones, and thermal_zone_exit() sets TZ_STATE_FLAG_EXIT in tz->state
while removing tz from that list.  Thus tz->state is not TZ_STATE_READY
when tz is not in the list and the check mentioned above is redundant.

Accordingly, drop the redundant thermal_zone_is_present() check from
thermal_zone_device_update() and drop the former altogether because it
has no more users.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v4: No changes

---
 drivers/thermal/thermal_core.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -702,18 +702,12 @@ int thermal_zone_device_disable(struct t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
 
-static bool thermal_zone_is_present(struct thermal_zone_device *tz)
-{
-	return !list_empty(&tz->node);
-}
-
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	guard(thermal_zone)(tz);
 
-	if (thermal_zone_is_present(tz))
-		__thermal_zone_device_update(tz, event);
+	__thermal_zone_device_update(tz, event);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 



