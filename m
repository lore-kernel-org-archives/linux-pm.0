Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58933EE1DD;
	Tue, 31 Mar 2026 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984795; cv=none; b=lAF8gHAA+CC9u9sLBRGiJni2TCkkOZwnuYT2/aezQ6/djiAotrARwkGFOdSvzfa26Kd/zjAixhTb7yj4JqkYEjomow22KdzCVLf4q/wMztyWeUPWB+UCXu2b2TFRLhsHzljH5t8DQ8Msk1q2DB6YTfOKhtNnUrlocvpPxR/t9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984795; c=relaxed/simple;
	bh=oef1ymCCk2FaeCwEaFYMMZNdD20uOyglBQ0aSGR6mxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7sK4/F8C6l3VUYolhziCa0rqGWkW+gVFgrPeYAoZnJGLbjO52O7bj2eUdpQ37t1tChVL2GMI38PJe5OJBgzGShztFlEzll9m3T5Fw60uFXDxrQnbzRLlsCqPxxtQPbcjFRycSor+suYalEou0H84rQ/9H/CYQc1JjYxD7T4GqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N65S+XMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N65S+XMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674E4C2BCB0;
	Tue, 31 Mar 2026 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984794;
	bh=oef1ymCCk2FaeCwEaFYMMZNdD20uOyglBQ0aSGR6mxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N65S+XMRBXJ+4mL2y7sf7uZVVvbOadiif8w0vtSlHq+QTyYBD8ir0BJwez5Ut7Uo1
	 HkNM7qTHRIVLsKMH+M83u05SthXDim3LiIwiKOAhwU8TSdWr2Q6ysB9EgSVMwmrHGt
	 yskmAxz14AxFn7iY2ddKllxGOWCPGjxznUTLKhwjCyX5TEx7yp4kLEY4LwhnvLja17
	 oKkmxgT22NGFuRYA3hIpVCD+BqtfarG3ZKQBrKiHJ5nJaLeSV72m319jhc+fP/QkOg
	 CaxeQNRl5Q81syM9u39FF4A5B4ZekU7rg+P+ZUKnlxK1rYv/jRewiDB7uIV8DTIwpS
	 qwIthNkNnR/WA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 1/4] thermal: core: Drop redundant check from
 thermal_zone_device_update()
Date: Tue, 31 Mar 2026 21:16:48 +0200
Message-ID: <5081910.GXAFRqVoOG@rafael.j.wysocki>
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
 



