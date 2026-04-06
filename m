Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70A388E6C;
	Mon,  6 Apr 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492232; cv=none; b=sW+ONZ0aiWPa2tUDrrj7hpQxFHvthlsNy8GN9K5KfhmGaGhXCOMB6dmnLvSkd3AK6uuKhqmIiJ+tZTJoAFPH/LyaO2qMdzh1Ycu3QNAUI3U9q3OTz7P9lQAy5zSVoRjQEDOXLPl/bk4xwQhSpZ5mc8glpqV1Thosrhl68EEyxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492232; c=relaxed/simple;
	bh=iNyHnILSZIQzvTBN2lLqkkbhAoqfm0BQYRWueouMDvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqsW4MWjcD6mPt3o0Odx8Djz+VJj0SD25krmz0Lopi9ImkOLQ4hSiuTLGpU5SmDBPX6VT1pwOPUAPRgEluj1f849wIhE3Wq9qLf5Xo4a05n0QKa52D5/zQy82DhAittdZnAJc/+l7bAF0sTDKKOE2pGo/0Ipvoeo3t3bXRVBl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg8uNrSX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg8uNrSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC05C4CEF7;
	Mon,  6 Apr 2026 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492232;
	bh=iNyHnILSZIQzvTBN2lLqkkbhAoqfm0BQYRWueouMDvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tg8uNrSXVxDpeRDyDD2bnWtTjbQFQvIO3LZ8DfRFak7NgFhXo9PrZmEjIdGUGV45w
	 3EFqckTxqXPjiOVJFIyFHpjY17ab7tkuKhJLC8hiH7n8meq96QOfI/0hW+/h+Ediot
	 V5F2VokR8Zu/btjs0Ihr9aalB8DGZOd5qz5A5wfpjdSaM91gxAn9CIvBdw7PxOxdUk
	 xHFdd2ouyPiejeJXzZ/JW3HGqd/xr11Gv461EM+7uIy0XE7UtcAGQ0OWQccUIkB36R
	 j6twBe0AqMhcFP8HZWdSpTq9HN+JFXd2ApcWnIztG6r1VCHzjA3+FrSqS5BiH2oI54
	 vdZ7y3+/S9gWQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v3 2/6] thermal: core: Free thermal zone ID later during removal
Date: Mon, 06 Apr 2026 18:09:01 +0200
Message-ID: <3067350.e9J7NaK4W3@rafael.j.wysocki>
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

The thermal zone removal ordering is different from the thermal zone
registration rollback path ordering and the former is arguably
problematic because freeing a thermal zone ID prematurely may cause
it to be used during the registration of another thermal zone which
may fail as a result.

Prevent that from occurring by changing the thermal zone removal
ordering to reflect the thermal zone registration rollback path
ordering.

Fixes: b31ef8285b19 ("thermal core: convert ID allocation to IDA")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: New patch

---
 drivers/thermal/thermal_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1735,8 +1735,6 @@ void thermal_zone_device_unregister(stru
 
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
-	ida_free(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
 	put_device(&tz->device);
@@ -1747,6 +1745,9 @@ void thermal_zone_device_unregister(stru
 
 	thermal_set_governor(tz, NULL);
 
+	ida_free(&thermal_tz_ida, tz->id);
+	ida_destroy(&tz->ida);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }



