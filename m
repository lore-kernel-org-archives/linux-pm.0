Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305E3B9DB6;
	Tue,  7 Apr 2026 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571060; cv=none; b=dshdCrofivPbENpxNZDqAkLtbXMFttxi2+hQqelCM7tu75R4YUaq/n08YULURytV8ho3jFkHWYmkAEMfGopJj2GRuk4XfPWFZl6MCnNhHZ8piytcJhuoPtrLE9psj9z/Y1vSxhvJGTKjKsRziStNJ0A2QvGefL72GhBAUvwwMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571060; c=relaxed/simple;
	bh=SJ2WuoS7mX4Epn0VCLQy+IIZoi+LOx8zIcZdPTf6tv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASl08hGbSo2bZQ+kpafq/z0RKx4fAkcX3HLQ28dcb/1fHnkMC1LMY7F5ja6HJZPFUZVOXXGAzhpLYObY+AEe5FZCsLphUt9KvA/0WRQgF+yDaLhE9JBKser1/v6/jgDAfoK0qc4z/9v2m5k0XLaFL2sZvSFQYtLM6RoqlO+ggAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBKh8GKE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBKh8GKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55F3C116C6;
	Tue,  7 Apr 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571059;
	bh=SJ2WuoS7mX4Epn0VCLQy+IIZoi+LOx8zIcZdPTf6tv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBKh8GKEzGuPiO4q3h+2Us2SlLsiKSh5pQwjQU1jYSCwFtOW2aWp5Kffh4OUShijh
	 GLLnYssdEi0ZRE716wAlK/jSsH/iMhkWOsxAfteV9jb3wENdi2qx7hpCKkrNuwAp7s
	 gcyDUTUg9hEkmQouEPBZrU2+yzmJ6TTVyBy3LqwaPdd2cPSmyiup/f9SJX8GB1++yg
	 NcfWtnInwx15CcDSW70S0TfrUo7W63RACJfNTgUCR9WUKGdvjwsrkLOcgNthC5GF7O
	 DMAojDBU0Cj3KHZou8e0guxPojTfGdd4ooenhzfIoLeAVAMfMJrRRvskFvGuykZHfO
	 xYeSCDeNp3i5w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v4 1/6] thermal: core: Fix thermal zone governor cleanup issues
Date: Tue, 07 Apr 2026 15:55:19 +0200
Message-ID: <5092923.31r3eYUQgx@rafael.j.wysocki>
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

If thermal_zone_device_register_with_trips() fails after adding
a thermal governor to the thermal zone being registered, the
governor is not removed from it as appropriate which may lead to
a memory leak.

In turn, thermal_zone_device_unregister() calls thermal_set_governor()
without acquiring the thermal zone lock beforehand which may race with
a governor update via sysfs and may lead to a use-after-free in that
case.

Address these issues by adding two thermal_set_governor() calls, one to
thermal_release() to remove the governor from the given thermal zone,
and one to the thermal zone registration error path to cover failures
preceding the thermal zone device registration.

Fixes: e33df1d2f3a0 ("thermal: let governors have private data for each thermal zone")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Call thermal_set_governor() from thermal_release() to avoid use-after-free
     of the device name (Sashiko)
   * Call thermal_set_governor() in thermal zone device registration rollback
     path if it fails before device registration

v2 -> v3: New patch

---
 drivers/thermal/thermal_core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -971,6 +971,7 @@ static void thermal_release(struct devic
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		thermal_set_governor(tz, NULL);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1617,8 +1618,10 @@ thermal_zone_device_register_with_trips(
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
-	if (result)
+	if (result) {
+		thermal_set_governor(tz, NULL);
 		goto remove_id;
+	}
 
 	result = device_register(&tz->device);
 	if (result)
@@ -1731,8 +1734,6 @@ void thermal_zone_device_unregister(stru
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);



