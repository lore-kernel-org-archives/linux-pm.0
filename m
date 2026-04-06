Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF438AC75;
	Mon,  6 Apr 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492236; cv=none; b=Tvyub9wbcTzrVm1PBtIFEIjnLJHqXTBxg2MEAh8sLt2sfWYc9mhZ3sggaNNPLymPO2FvuJAa/ciqSYdj9iyk15IyLctUy4rY7fkJssUFAhBN2cCnrgRZ9SD3Wax7rkCZh682vSMET+bERb+J5uB5orhEVbkliV9bWIk/+u04XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492236; c=relaxed/simple;
	bh=8Zhv0fnXgAUIuDjz7958x8yoxVSoQEppR4BMml2ukzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhpcSUsBY+dRErwa2x367/OlMOK56E5XhuKcrbvmkcfYy6AhBa7HBsiLhstdRUlmrFZzA5YQz9rFaCqNreCCoy/U1h+Z//SCxdqNwlL+ZDRKgYv3c0fsZunCltMFKKp+yjHGPB3qFtsQn4e6yOihp9sretCQWRDd4vHrR7rfWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzXRVGtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzXRVGtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA18C19421;
	Mon,  6 Apr 2026 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492235;
	bh=8Zhv0fnXgAUIuDjz7958x8yoxVSoQEppR4BMml2ukzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzXRVGtD1knFa/CXitW2K9yWy1nraQPf3HcuuFBmXQXv0hOaCLSLE1k4wswn8WRD2
	 bclOpIukvNHWmcF7t5NGfw5CD8vfbjmCLQCQX3wzKLzB6kkSY+r1c1C2KoNIEj5HtU
	 zNdxSSn+Nseo4xXmXzcYiQ6N7tYU5pUY1oHwu3z5MGYacKqIW7/ekjvRB0BgWgA4qn
	 oCgPO4qlBBuQbsTL6+UhlPQJ4QINEUrvr5IA2TyOjONRKPV06Bim2iFyUhifN83fCl
	 bzoD6O6rM+Vdi83OyXRHtiedTI+o4IU8cMFWeiyGAnORzpxuAnUEltAoxvQQSZKz8C
	 BclLUtVBx96ww==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v3 1/6] thermal: core: Fix thermal zone governor cleanup issues
Date: Mon, 06 Apr 2026 18:07:39 +0200
Message-ID: <2288346.irdbgypaU6@rafael.j.wysocki>
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

If thermal_zone_device_register_with_trips() fails after adding
a thermal governor to the thermal zone being registered, the
governor is not removed from it as appropriate which may lead to
a memory leak, so address this by adding the governor cleanup to
the rollback path.

In turn, thermal_zone_device_unregister() calls thermal_set_governor()
without acquiring the thermal zone lock beforehand which may race with
a governor update via sysfs and may lead to a use-after-free in that
case, so address it by placing the cleanup thermal_set_governor()
call after the wait_for_completion() one, which reflects the
registration error path ordering.

Fixes: e33df1d2f3a0 ("thermal: let governors have private data for each thermal zone")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: New patch

---
 drivers/thermal/thermal_core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1618,7 +1618,7 @@ thermal_zone_device_register_with_trips(
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
 	if (result)
-		goto remove_id;
+		goto remove_governor;
 
 	result = device_register(&tz->device);
 	if (result)
@@ -1649,6 +1649,8 @@ unregister:
 release_device:
 	put_device(&tz->device);
 	wait_for_completion(&tz->removal);
+remove_governor:
+	thermal_set_governor(tz, NULL);
 remove_id:
 	ida_free(&thermal_tz_ida, id);
 free_tzp:
@@ -1731,8 +1733,6 @@ void thermal_zone_device_unregister(stru
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
@@ -1744,6 +1744,9 @@ void thermal_zone_device_unregister(stru
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+
+	thermal_set_governor(tz, NULL);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }



