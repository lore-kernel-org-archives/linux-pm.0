Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FC388E6C;
	Mon,  6 Apr 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492229; cv=none; b=noqdGJPa3WZ1FLedghBAImROVie0GxciFmrGkK+ru2iImKt37E4/eqrOFAeeT77opgCLj4ULxOxG/6EnI7E4Ki5NYHfHveL3u0eNa4f1CY3dvyYqvXwt5U12Bq2smVFZWlhzs5ThXvYcJwaKim/eS7pY7VnK4Lx3mY5BUbrP8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492229; c=relaxed/simple;
	bh=AYo8btoOBZTA5zYKJB6LjOVvbCcD9APGCG1pPdi2+OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n64RWiaTxKHg4xvPfYmK9xpZFOFUkyu7yCBT48YwJHJlcxzZ9/mXjnQ6TfS+B0+b48Atf2bOB2HIFZhudRwikcBQhTTgWdfoESsZluXfdy30Iw4G/II25u9atAtbT7CA4hKXzdv9RJqF+3bu1p/reeT5c9XnEB9hSLoZohTXzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXGv6O56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXGv6O56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D033C19421;
	Mon,  6 Apr 2026 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492228;
	bh=AYo8btoOBZTA5zYKJB6LjOVvbCcD9APGCG1pPdi2+OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXGv6O56QjknfW7HiQ41ftkiU2sg3nlF4r6vqrWRS63AuCavJaAJDt0SseXkiop/d
	 cruqC+4wd8PBfTGibSf4mNByfXlcQ5P06rBpQPEAOQHdvWYzHddMpw/vATeg+hysLN
	 wNZMw+YlCUOiZeIQ5vKcF75MBcCZccuptxfvC7ROXmIu6PBvXRNRcJJVN3yXRfTkOr
	 Br64y2jcPuOLvxphL/BFc+tQYe+Ck9S7TTDogpCIwyGpmYzF938Djesqa8jm1HXvu/
	 KCklHmfvfKAJxzzagXR2yBCaC/HUfPJH1xJTpr8sfOf8QcelhxHyMPfv0/eA55MC2l
	 QyYrIbSJs54XA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v3 3/6] thermal: core: Drop redundant check from
 thermal_zone_device_update()
Date: Mon, 06 Apr 2026 18:10:17 +0200
Message-ID: <3440175.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5119690.31r3eYUQgx@rafael.j.wysocki>
References: <5119690.31r3eYUQgx@rafael.j.wysocki>
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

v1 -> v3: No changes

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
 



