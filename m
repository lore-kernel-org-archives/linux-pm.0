Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30733B9DB6;
	Tue,  7 Apr 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571056; cv=none; b=ixD3wK+7w85P2bYBRQUp1utUWl9fM6Jn1CWAH9Me/odruTFK2QWALABtrzU/hnJGLcAAjhD12gMC//Nkvo2WOKozootSKqpVjx4bVx5o5z7mfI2PRbnBhfCvIaehB9H/hHf/ZrlAFIbFT0dwzSOkSFJf6y3SH5w4CD93EEQNAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571056; c=relaxed/simple;
	bh=4mJ9ms3n19PonUmT2P1Pl3FdIlRcKk6ZwrGHvXQzL8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPJpbbY1UqjQImvdlXEQQwNvmgD21tT5g/hCrdPIqOhXaHuqbE49+L2f0rY7IrqVcpo7TSSCiTet/JlPSK5qPZAAfec2B05dGNUg4vD90yzl//QQu1O+SOoWUg0erq5jv/s7vxrVP6PNKZ9WIL0PKhGvvnDE0gYmVTWFt3R/ar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPVsq+tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPVsq+tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED9C116C6;
	Tue,  7 Apr 2026 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571056;
	bh=4mJ9ms3n19PonUmT2P1Pl3FdIlRcKk6ZwrGHvXQzL8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPVsq+tqVca8qg48vPJn0PzQN7siHLlmK92d5b6mH5sllvwTCxJfscSiiFNkU238A
	 Uq0IIO15UmDlTCe42qv7mdqKHpwp+YMy28ecxSeRAM5cT2QwDtfY3y0Vkt4heSif7M
	 fqxu1eKX86aW1FPuwv2ROzzRb/uwmlkBJ7wE3/VsRlnpLtuhKiJHFWPp+KH1m0tTaI
	 0rX3X5Mj0xLL7E3pXxshSNjrNTJgCAl+Iwb9NUnIjXZulbMVMGxX1lHNRD0Cc6V3iT
	 eGDQXsMnXwI7WK5rFruFq+Rpznr+mMQjkNGCIy62hsfwhtvcbyXGGIdnG9QGVy4lCD
	 hviRN4/00q4Rw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v4 2/6] thermal: core: Free thermal zone ID later during removal
Date: Tue, 07 Apr 2026 15:58:34 +0200
Message-ID: <5063934.GXAFRqVoOG@rafael.j.wysocki>
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

The thermal zone removal ordering is different from the thermal zone
registration rollback path ordering and the former is arguably
problematic because freeing a thermal zone ID prematurely may cause
it to be used during the registration of another thermal zone which
may fail as a result.

Prevent that from occurring by changing the thermal zone removal
ordering to reflect the thermal zone registration rollback path
ordering.

Also more the ida_destroy() call from thermal_zone_device_unregister()
to thermal_release() for consistency.

Fixes: b31ef8285b19 ("thermal core: convert ID allocation to IDA")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Call ida_destroy() in thermal_release() in analogy with the mutex
     cleanup

v2 -> v3: New patch

---
 drivers/thermal/thermal_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -972,6 +972,7 @@ static void thermal_release(struct devic
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
 		thermal_set_governor(tz, NULL);
+		ida_destroy(&tz->ida);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1736,8 +1737,6 @@ void thermal_zone_device_unregister(stru
 
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
-	ida_free(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
 	put_device(&tz->device);
@@ -1745,6 +1744,9 @@ void thermal_zone_device_unregister(stru
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+
+	ida_free(&thermal_tz_ida, tz->id);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }



