Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA2320CB1
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632011; cv=none; b=uv7jDbXEmXC8kVthT5IiTZk/xq+GYFQklGFzUN43kvtif12t1BC9BA9fj44P//0m42YOvxTISUyAH8NrlBKPwasYtPdSOM+C4FnZMcmE8npT2YTCtww7Fgh0JOui+2VcA2YxFKJJX777f8Fh6gtrDzVX6EJSGLyFDC4nI27HlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632011; c=relaxed/simple;
	bh=96SmEBMpH/wqIXtgKcP04dOn4OMx0kaCIPIVm7vT7qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYFrxQH6d4H0wNKpsHksjm0x3eLq5hCFMBtOun5lsV0fJvdKYSrAXpZ89/ENBxwXhYCHprSqzgGSWpVLA7OsWhCo1o0kbJc+r2ba2nJAGJ4vibL2RUINoGE01sRqL1L9Dv2HcoBiFtEn0g7rrqog2ZaJyq5Kk5EMzFcxAobMG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxQNvtq5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxQNvtq5"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so6458445ad.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789632009; x=1790236809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=scFjHYyfb0SgwjNAVVjkYsuuibhuV8HJMFO5s2VNqw4=;
        b=NxQNvtq58YFqjoF00FXiWfe6CAwEJoqeBfVmNEJjb9lwetdA0PoMM2nHSAokyLoPln
         n7lr5BcePoUvmaLgeDAPpo93X53PrCC94pGbeKyZkfHF9svbOWRauu77ZoiYmoNwm2qw
         JTV8TKNw3QFu8yjx96HEk4mGn/BtP2swE1PRrofc0aweUcKPRo6BrkL/Ddzo3SdeH9rC
         Uh2bO280WIfWN6nNFv0ULLC1xxrGg2Ym//Ix9lP0AZHRBLkFLCoMybOLaLCuolvtkooO
         GeHpZ5hQDdXJs1rlQHJ0/Qaht8CLXM3+P37rZF3iIHrZJSgT3w4SgjD44y4tv0iYjIPZ
         8Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632009; x=1790236809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=scFjHYyfb0SgwjNAVVjkYsuuibhuV8HJMFO5s2VNqw4=;
        b=updTfpOl+wKaKbN1eOjaAL/cHnqa5Rl4VkTvBoksaV7MlGJHG6V1xAdEyNgRug0Pvi
         R0kZoa6pRSesKSm7UxGFXl8y5JBsYsWNvLEczUe+ERD065MM1LiFau1Pm2cgWZPw6ckr
         SKSdi5noRZuhwGycT/HP1+LcF8QjJG6rILiyipee+G9YA3ivVWd4zDupIBNV7Gp2e+z4
         XZOQ9oMEmFa/NWamSEoOSUqqvyR+uDLpmpdqk79S64fDaGE48I817bmxt7Ba4ITG82Vc
         6YfG7BzWf+51EBtnb9qiKywOc2mgSV8RxpBh7w368LqZVZax2V+kGcsENfKFJ5M5muq9
         97gA==
X-Forwarded-Encrypted: i=1; AKwUvBxUUhsFx6qIu35AZYazCkIPrc9vvfxDf4WO3vDaJZMnoEcOWyqAdms+zNpAkwEpqm1zIzIcjx0x7g==@vger.kernel.org
X-Gm-Message-State: AFuF++kKv5iJUTYyaUCvcUui2cuXQ4OrH7ltVCwDn2UU1K6kEG6cxuqW
	+wYsxkiXBqVlcn4eGoKymOfEmfAIDzXgKHRYc4kvwhZ6aZJ6D32R81rU
X-Gm-Gg: AYBFou2SY7LUhMflC5LKxP3UeLm+BVjjpxIOCMYzxDWzFKM9O8lAO9vUFUX+ef0M7Or
	vVZuuY5tDmm+4vLd2KWqk2GYr34cN6oFsGD960egv9EuDY6cMe7sIbwNVYgwFQfqhJPSyYG2Fl7
	fpVyG+P5P6qp3a/ghmD9nty+MiRwJsVPiEj/Y+EqTqui6hI28xPqv8ENt2XiIYVsEwrDXPvXwWW
	DlyjEY7/kiNZq/IqhokWPadKNYdRBEpfU3cfT43WxzOTZrqcZWomGpjHLTvclKHUeZdd03FBb/h
	1D+FS/GlNquUNXFrATAKEjMr3Ico2JvaFpxJvNP3aowGNUbSmyCoTAp+MM+gP1zYqSi5mUhDfq3
	6db5Rjrsg0AZsvJElko3qCKkkrHaE0Oy/dLph9suNJ1aERnd4q1s0lhAz3MqS8f3hC4DKPhpt/C
	2P20RE/x+URTF+U3k4bSYN9JSGBDrpjcJ7rat8rox4OpMEclZTRzY3P9VJm67hD2Qtfz4frgy5C
	9gSbwC1yEeruX22gRLuMZC2HA==
X-Received: by 2002:a17:903:4b0c:b0:2d9:2149:57c0 with SMTP id d9443c01a7336-2dd8e7a2c5cmr128507045ad.22.1789632008976;
        Thu, 17 Sep 2026 01:00:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm26539542eec.31.2026.09.17.01.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:00:08 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/thermal: fix typo "binded" in comments
Date: Thu, 17 Sep 2026 13:30:02 +0530
Message-ID: <20260917080002.23952-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"binded" is not a word; the past participle of "bind" is "bound".

The tmon.h comment counts cooling devices, so the noun is plural there,
matching the wording already used for MAX_NR_CDEV_TRIP.  The tui.c clause
needs "is" to read as a sentence.

Only touches comments, no code changes.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
Randy, your Reviewed-by was for the v1 series; the two hunks below changed
after it, so please say if you would rather I dropped the tag.

v2: tmon.h: "cooling device" -> "cooling devices".  Randy Dunlap pointed
    out the comment counts devices, and MAX_NR_CDEV_TRIP just above it
    already uses the plural.

    tui.c: "is bound to" rather than plain "bound to".  v1 left the
    comment reading "trip point id that bound to this cdev", which is
    still not a sentence.

    sysfs.c is unchanged from v1.

v1: https://lore.kernel.org/all/20260907064725.10686-4-hemanth.selam@gmail.com/

 tools/thermal/tmon/sysfs.c | 2 +-
 tools/thermal/tmon/tmon.h  | 2 +-
 tools/thermal/tmon/tui.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index cb1108bc9249..5d64aff12a86 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -225,7 +225,7 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 				cdev_name, cdev_name_linked, cdev_id);
 			tzi->cdev_binding |= (1 << cdev_id);
 
-			/* find the trip point in which the cdev is binded to
+			/* find the trip point in which the cdev is bound to
 			 * in this tzone
 			 */
 			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..b7767056f189 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -77,7 +77,7 @@ struct tz_info {
 	char type[256]; /* e.g. acpitz */
 	int instance;
 	int passive; /* active zone has passive node to force passive mode */
-	int nr_cdev; /* number of cooling device binded */
+	int nr_cdev; /* number of cooling devices bound */
 	int nr_trip_pts;
 	struct trip_point tp[MAX_NR_TRIP];
 	unsigned long cdev_binding; /* bitmap for attached cdevs */
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 7f5dd2b87f15..dbc3ca95c724 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -238,7 +238,7 @@ void show_cooling_device(void)
 				unsigned long trip_binding =
 					ptdata.tzi[i].trip_binding[cdev_inst];
 				int k = 0; /* per zone trip point id that
-					    * binded to this cdev, one to
+					    * is bound to this cdev, one to
 					    * many possible based on the
 					    * binding bitmask.
 					    */
-- 
2.48.1

