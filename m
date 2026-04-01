Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A43DEFF6;
	Wed,  1 Apr 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055103; cv=none; b=Q/NGGjCxAzn/lySlKJ/xnzl0UveazxlAhMhXQxOvCrB+CX7tkb6sXj2zMHmu+oqwmgsVgDPl+blAWXBKOZnAOAchhKiXqIzxabHvMDRQTe8Rnhc4ZVkV8XHuv+/UiorGtObAFHnXrFxaVA4OQILa6anS6hq9l/edA1LflCuJNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055103; c=relaxed/simple;
	bh=Yhrtbp/k92ahaHlAi6531bQrgJS5kO/zOPxTHik69LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcjAhS/whrS2fyS7/GsAEwlo3c0I7jRdvHOQKSri7RF+kyxL8aI2b0mug9+0BfGyVkEDf7DbWMZxTbX3QjOIak1pw44m/tvYVWNW4C0k+BvQn5G1wQ4fVNN+c0YUGq4cEidU4fj5aJKgvtwfSOp1p4hvKWtn9TX7K6TCuxzYM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP11yPzZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP11yPzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8A1C4CEF7;
	Wed,  1 Apr 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775055103;
	bh=Yhrtbp/k92ahaHlAi6531bQrgJS5kO/zOPxTHik69LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DP11yPzZwvcYUS0bXQWrx1mARUrx9VrIkDb/REpqcy1aeYoEP8KK5mNjzNLGae++h
	 pyRAp/Vu56pf6T8MVkd7/bD+3Z6BWmCtxafvQqO8JlEDbAh0oDgxECl3hoV34WYGs+
	 z87qKdQ6xKOXXTryy3YlMWCWsJ2ZnchKuJzxuLDAmHF2otcHfe3SeOQiQYn3Nji/MP
	 6DYpasMkkv4aLM4BxJxFLVWwk+31p4CQ/YRFSxDgmhcs4khQGJGXAF/aSAeLyhOpkK
	 SFtrqBBANZ25AA6qfznj87AvnTWC4/2ikKr6qYtpVqnJD/5yM665RwxDMQYhBE7gi7
	 rDHRvvkogk0YQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 1/4] thermal: core: Drop redundant check from
 thermal_zone_device_update()
Date: Wed, 01 Apr 2026 16:37:36 +0200
Message-ID: <4748678.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
References: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
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

v1 -> v2: No changes

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
 



