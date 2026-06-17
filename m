Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1648AE20;
	Wed, 17 Jun 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712694; cv=none; b=Yzhl5qotgaR0/77L/oLJnAxqFTEQqvxKT7Fnicq9UhtEHxOVEir3zRAcI06mnSiB9hMGjURM1uq3UHfoix27/xHXgAfHX2SKFp1gNQGnnbd2aFSEZ67v3oisQONZgR3/IXHiY8tMOLOhVJHTurd9eqN7nT5dMXTn7w6avZNgn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712694; c=relaxed/simple;
	bh=TkkYU2k8m9YrBUitUwsbGcSuc8vBD65Af6kSd42Scic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkyP/ONfnNLPtdSLyuKEG6w2LcmikIVTkmy2ExPf5iyMuOv0uUmh0c6tG4m+4lM2/HLoDUomhMK9OpnpHBhH5fBtuAbzviM2BAcv2Z/sBN4pKVmz7dIhNC6vjVXXVoJZ0sLC2xNzzFCHyQ5YGqlrzq9k+LKWUaMbqdjl/60EXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So0wGeTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So0wGeTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3D71F00A3E;
	Wed, 17 Jun 2026 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712686;
	bh=MIdB4GmNAQz4rlYgPL2Q69dHSE1Uyr0QPK5fAmOQW1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=So0wGeTwVReG+8r9AIxfLl5z561xegCPzPYh4Juuv1YgODekrGd1Akd6jZ1qnNqPs
	 N26w5qEfiGE07YldXi3nCpi10XSoWHxVozFiFU/XsM423U3hVu5Fox45NKV1RF6p0S
	 4UPJVRciiRsx/4pVdN3jigQqCG+2EaIJ3oKYgTS3O/5+Oddd8V9Isd0GeyCQDy0ZfY
	 vzU3qhr74wl25l0fh7ldLKM31pCXbQ9QypVs15umBx7YgKPtSbWgXm9Cr5WFTg/7xu
	 jdIMvPK4G53NUneTXDiBBM3xedRM6NUmZKWyZW/yM4NUJ1DpyYSWAidRxHAngYHrfM
	 p3SxfSDyz33NA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/2] thermal: testing: zone: Use debugfs_create_file()
Date: Wed, 17 Jun 2026 18:09:29 +0200
Message-ID: <6304554.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12941879.O9o76ZdvQC@rafael.j.wysocki>
References: <12941879.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use debugfs_create_file() for creating debugfs files related to thermal
zone templates so that their file operations are properly synchronized
with thermal zone template removal.

Fixes: f6a034f2df42 ("thermal: Introduce a debugfs-based testing facility")
Link: https://sashiko.dev/#/patchset/20260605185212.2491144-1-sam.moelius%40trailofbits.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/testing/zone.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -171,11 +171,11 @@ static void tt_add_tz_work_fn(struct wor
 		return;
 	}
 
-	debugfs_create_file_unsafe("temp", 0600, tt_zone->d_tt_zone, tt_zone,
-				   &tt_zone_tz_temp_attr);
+	debugfs_create_file("temp", 0600, tt_zone->d_tt_zone, tt_zone,
+			    &tt_zone_tz_temp_attr);
 
-	debugfs_create_file_unsafe("init_temp", 0600, tt_zone->d_tt_zone,
-				   &tt_zone->temp, &tt_int_attr);
+	debugfs_create_file("init_temp", 0600, tt_zone->d_tt_zone,
+			    &tt_zone->temp, &tt_int_attr);
 
 	guard(mutex)(&tt_thermal_zones_lock);
 
@@ -315,12 +315,12 @@ static void tt_zone_add_trip_work_fn(str
 	kfree(tt_work);
 
 	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "trip_%d_temp", tt_trip->id);
-	debugfs_create_file_unsafe(d_name, 0600, tt_zone->d_tt_zone,
-				   &tt_trip->trip.temperature, &tt_int_attr);
+	debugfs_create_file(d_name, 0600, tt_zone->d_tt_zone,
+			    &tt_trip->trip.temperature, &tt_int_attr);
 
 	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "trip_%d_hyst", tt_trip->id);
-	debugfs_create_file_unsafe(d_name, 0600, tt_zone->d_tt_zone,
-				   &tt_trip->trip.hysteresis, &tt_unsigned_int_attr);
+	debugfs_create_file(d_name, 0600, tt_zone->d_tt_zone,
+			    &tt_trip->trip.hysteresis, &tt_unsigned_int_attr);
 
 	tt_put_tt_zone(tt_zone);
 }



