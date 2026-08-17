Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9A3C8182;
	Mon, 17 Aug 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962811; cv=none; b=mwnvhyz6LEwPI67+Qu5InUbq4ylWKp+2fNYLFs6NT2eQTbUTZOBuc7yHRm5jG2bPMgkNZLpDNPmEF6YKoFj7XB9WDFzO5PyUk/xlkvhASWT3+Iz6P53QGTBpRlVmcwxESNLwghYO7bheGvbp/oz/gHsI4M85LT3Fo4JrTsmgh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962811; c=relaxed/simple;
	bh=z7J85CfHziIHpbzAOGQtxVB8e6fEljYhfHoyTdd1Huo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQvqFVUvvVk1cSPiUOgSspH0bNfIeWv1Aekc8QDlTCrKimyL+XyTezJevf0c0mMTu0qE00gymtPAxYn9Po6qgkQOAr+o/K0AtqYCB8hi1d1uR+aVaUa0Nl0QYHfGuWr6V1jNPrh1eFoK1TN1w+JLiqTBeoYX5guFITi386iB6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BO6GwmnI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BO6GwmnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786962809; x=1818498809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z7J85CfHziIHpbzAOGQtxVB8e6fEljYhfHoyTdd1Huo=;
  b=BO6GwmnIdZ6lPtrPkziO29pBXxt8MZMcUCcrly71WYt4QOxekOQ5QE3J
   pFjIomlGqBZeXBMOd1LQXuHwtJH6GWg7Euxa+hZqzgqkik88C1FsJh9C5
   u4dFuNq4+xufJX5joSK+WgfLNfX8YENMgmSntWYhx7G+HrmrO7QcwDZEe
   5Yle9UYUaD2sFvvym2BHdbhAHgSCHf1xxYgQ5R6dIjgHb5WQijQqxuWnw
   Ym6gyDUep/CYX4tqe6cc3/t8K+VOXWTypM36YGQTBM6LGV0OhgQLyT0ws
   E0YXzjQzpMnOxbWj1PuMXBM72qbxsyhOdIg0C4Vza0YQpq7mOwIAWZpst
   g==;
X-CSE-ConnectionGUID: yskBmDbrRPej82x6524HmA==
X-CSE-MsgGUID: NdkXNNDERHepXZFypeGcXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91307177"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91307177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 03:33:29 -0700
X-CSE-ConnectionGUID: Ke08qGHPSGS4cvvCTHWdGQ==
X-CSE-MsgGUID: 4woWfm19QCWBXZcd4XBtyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="289694759"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Aug 2026 03:33:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1528C99; Mon, 17 Aug 2026 12:33:26 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] thermal: sysfs: switch to use scnprintf() to suppress truncation warning
Date: Mon, 17 Aug 2026 12:33:24 +0200
Message-ID: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the sysfs code to use scnprintf() to avoid warnings about potential
truncation of the names of the sysfs attributes. We can't increase the buffer
size because the size is the part of an ABI for some reason. Note, with
the current size of buffer the affected attributes have a room for up to
1000 names, which ought to be enough for all cases. There is no functional
change, as the same limitation was implied before.

Fixes: c56f5c0342df ("Thermal: Make Thermal trip points writeable")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thermal/thermal_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index b44abfc997ed..44bd7c50e4ac 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -400,8 +400,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
 		struct thermal_trip_attrs *trip_attrs = &td->trip_attrs;
 
 		/* create trip type attribute */
-		snprintf(trip_attrs->type.name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_type", i);
+		scnprintf(trip_attrs->type.name, sizeof(trip_attrs->type.name),
+			  "trip_point_%d_type", i);
 
 		sysfs_attr_init(&trip_attrs->type.attr.attr);
 		trip_attrs->type.attr.attr.name = trip_attrs->type.name;
@@ -410,8 +410,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
 		attrs[i] = &trip_attrs->type.attr.attr;
 
 		/* create trip temp attribute */
-		snprintf(trip_attrs->temp.name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_temp", i);
+		scnprintf(trip_attrs->temp.name, sizeof(trip_attrs->temp.name),
+			  "trip_point_%d_temp", i);
 
 		sysfs_attr_init(&trip_attrs->temp.attr.attr);
 		trip_attrs->temp.attr.attr.name = trip_attrs->temp.name;
@@ -423,8 +423,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
 		}
 		attrs[i + tz->num_trips] = &trip_attrs->temp.attr.attr;
 
-		snprintf(trip_attrs->hyst.name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_hyst", i);
+		scnprintf(trip_attrs->hyst.name, sizeof(trip_attrs->hyst.name),
+			  "trip_point_%d_hyst", i);
 
 		sysfs_attr_init(&trip_attrs->hyst.attr.attr);
 		trip_attrs->hyst.attr.attr.name = trip_attrs->hyst.name;
-- 
2.50.1

