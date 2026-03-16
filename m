Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCC34EF17
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701526; cv=none; b=cvH5qmNCpLtdt2dINZQk6ArKVobj7IHHUYMFTfvB0SUU/xPZfSD0HCal/V97vcIofhLRAi4dqCEhbJykcNwewC8gnMVZnRM7Mu7flEt0rPXRJbURSi/aWtkFLGQnOuJRNIfKmIvrK02poeVHo8eOcXnqk5Szf7X/D5j6Vmad4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701526; c=relaxed/simple;
	bh=wbQpH8xHkI2CQ6U2T9EqnF4GFQq2gt7FrQgWHXKo5Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sm3zCEf9dRNpC3qYfHqLlxGDwqw+599KSneB4WK5t1gm4BDpsIyTu0abKGudZyfh70g4p/I3Uu3tjOz3biu4jgqL86zm3hw9c8Pa1QXJQpBbOjrc5KX/q5vU3nQnXbw167cm3XNle/gB8VMPrO6D+50cG8QZCEznTh192zkMEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQQceYiW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQQceYiW"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so203502066b.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773701523; x=1774306323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh9//1m1U8pgZ3fqMvWrrlUw47QW8R7ABRGa1wFJOT4=;
        b=LQQceYiWpbBfGU4ryHYPUKI39P4vol3EKbF/CDUZCrqLon2n0ewqp6rVGS30yMVJbp
         oJ4FFxP3r+pwRLBcIeTum/9WznhJZ/CjdDjR5D0jkS0eX4wJWjGGe/uiMd+7s0qB0WJo
         wgySq8yawlgEJucHai1miCl/tESfSiuMBwKgToQrcz/6qUTlAheKfzn7eoWnOYE4LbHp
         +GvJ1qXl0auiATav82mpMpNx+62JauqtmS/8IWxmZzi1BVuqOC66pLizJZVtWMJoGNu3
         D4ITongVWaVjGu7b2ZsVqrAhGHobHu2fu3gIbWKb/Dx27oEoYpCDjWMpzusc0O22+fCX
         1ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701523; x=1774306323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh9//1m1U8pgZ3fqMvWrrlUw47QW8R7ABRGa1wFJOT4=;
        b=P2wy8M9Ef7bCwaLbyERDYd+uk0SQt9cDgtT+S8LheXOdDvefolohkX+ykKrqlmNOOx
         RRi5ShHhPfjByl3Yc1W9rM5LWSX7IFYtOp0iHH7LGda/ZYSdJPKrpCaQJK2gyxz6rfEE
         GTFcRl2QajRQVraPznpxN/RDsOCxSI9ly1BITAe6dqScdBiDFPRISGK0Dnb6sHcfocRV
         RobwDCs73EjcDeB7d7A9rEMGfpdXFJh2ptEHqZRyU4Vsh1hX06Y//X/HOR/q3df5FjPZ
         OX/SQXPcVYfKZRYWv6BHnXdr/KQMTupVguRGaCxqNA7O9Fzp2t9B4kO9Mbv/r2+kmoB6
         BB7w==
X-Forwarded-Encrypted: i=1; AJvYcCVXw4C1vAjlHD7+bzsJiYr+i+7Koz38QT+MqPG/Ga6GqorR9KFZpom3Vrf9/MV3AiBns5sBq1wtaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/zeY/7Pv9/S+7il0zyXqr/JodAwAHWRj149cD7UOhif4cYjX
	V6Ioa++cBcuKJGMmIjPtP2/bWc2Fm6ynM9WBOavelqZHMsLM7wrPcfHG
X-Gm-Gg: ATEYQzyNKJkRfNG74C17MwwaOu4k//E2tb+HHOYc20OPx3WvI94LfhMAfIZNKmUa2Sv
	BlDIRUyp+5cjAqA+rWTysJ4I70Hg+DDOPkKUhjQic14J+MAdVRNAn9OXkRqKsjNolgXUiXao7pM
	nCF8tZVQsdN6RvUDXSinUZgZnXgKq7/EptLXJekMbvXnJ3kszydlzhEuQvCfvx0Gm86GLCOonlk
	Nxl8OV9YSXq/ywGnTf476fWcifu93zFpWUT2BaBt09ktFjSSzDEPhFlG+N/im68YAPXYRXXG9HA
	3AGoIxIYOukZ3/7VMAGz/RfJlt1tuFDNnMtraRN42qgtO5wQvPNwGW3MhN7BX21xGdBFoyWuK4e
	V0ZP+IuOX3Yo6TZ0SGoikZ7ARksnjKe/+Lj0B2j3mrpSglQgY6RebG/n5geU70YLnqaxob/oTyt
	N0sgd2ZE0V9vebsdme2wGBi5cX8DW6zUsPoMz9Ofb5Y8P5qXf7c/aScHrOZ1Di7DYW+M2f34vZO
	+orvJs+MPoRUa1Og+cPvjsxemekXWnbCAEP8hI=
X-Received: by 2002:a17:907:9716:b0:b97:9130:659e with SMTP id a640c23a62f3a-b9791307885mr573602566b.3.1773701522887;
        Mon, 16 Mar 2026 15:52:02 -0700 (PDT)
Received: from codespaces-165493.m1k4x3cq3poebda54cltipn05g.ax.internal.cloudapp.net ([20.61.127.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d096d58sm634557166b.62.2026.03.16.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:52:02 -0700 (PDT)
From: RuslanSemchenko <uncleruc2075@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: amitk@kernel.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org,
	RuslanSemchenko <uncleruc2075@gmail.com>
Subject: [PATCH] thermal/tmon: Fix crashes and compiler warnings
Date: Mon, 16 Mar 2026 22:51:53 +0000
Message-ID: <20260316225153.33379-1-uncleruc2075@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TMON tool has several issues that affect stability and build quality:

1. In sysfs.c: find_tzone_cdev() uses readlink(), which does not append
   a null terminator to the buffer. This leads to improper string
   termination (CWE-170). Fixed by manually adding '\0'.

2. In sysfs.c: get_instance_id() had a logic error where it could
   access an invalid pointer or pass NULL to atol() if strtok()
   returned NULL unexpectedly. Added checks and used a string copy to
   avoid modifying the original data during scanning.

3. In tmon.c: Fixed -Wstringop-truncation warnings by ensuring
   control device names are properly null-terminated after strncpy().

4. In tui.c: Fixed format string mismatches where 'unsigned long'
   variables were being printed as 'int' (%d), causing warnings.

Signed-off-by: RuslanSemchenko <uncleruc2075@gmail.com>
---
 tools/thermal/tmon/sysfs.c | 92 ++++++++++++++++++++++++--------------
 tools/thermal/tmon/tmon.c  |  4 +-
 tools/thermal/tmon/tui.c   |  4 +-
 3 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index cb1108bc9249..a42545dc2be3 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -150,13 +150,18 @@ static int get_instance_id(char *name, int pos, int skip)
 	char *ch;
 	int i = 0;
 
+	/* strtok modifies the 'name' string by injecting NUL bytes */
 	ch = strtok(name, "_");
 	while (ch != NULL) {
 		++i;
-		syslog(LOG_INFO, "%s:%s:%s:%d", __func__, name, ch, i);
+		syslog(LOG_INFO, "%s: token %d: %s", __func__, i, ch);
+		if (pos == i) {
+			/* verify length before performing pointer arithmetic */
+			if (strlen(ch) > (size_t)skip)
+				return atol(ch + skip);
+			return -1;
+		}
 		ch = strtok(NULL, "_");
-		if (pos == i)
-			return atol(ch + skip);
 	}
 
 	return -1;
@@ -168,6 +173,7 @@ static int find_tzone_tp(char *tz_name, char *d_name, struct tz_info *tzi,
 {
 	int tp_id;
 	unsigned long temp_ulong;
+	char name_copy[256];
 
 	if (strstr(d_name, "trip_point") &&
 		strstr(d_name, "temp")) {
@@ -178,7 +184,12 @@ static int find_tzone_tp(char *tz_name, char *d_name, struct tz_info *tzi,
 		if (temp_ulong < MAX_TEMP_KC) {
 			tzi->nr_trip_pts++;
 			/* found a valid trip point */
-			tp_id = get_instance_id(d_name, 2, 0);
+
+			/* get_instance_id modifies string, use a copy */
+			strncpy(name_copy, d_name, sizeof(name_copy) - 1);
+			name_copy[sizeof(name_copy) - 1] = '\0';
+
+			tp_id = get_instance_id(name_copy, 2, 0);
 			syslog(LOG_DEBUG, "tzone %s trip %d temp %lu tpnode %s",
 				tz_name, tp_id, temp_ulong, d_name);
 			if (tp_id < 0 || tp_id >= MAX_NR_TRIP) {
@@ -203,6 +214,7 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 	char cdev_name[PATH_MAX];
 	char cdev_trip_name[PATH_MAX];
 	int cdev_id;
+	ssize_t len;
 
 	if (nl->d_type == DT_LNK) {
 		syslog(LOG_DEBUG, "TZ%d: cdev: %s cid %d\n", tz_id, nl->d_name,
@@ -217,33 +229,43 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 		snprintf(cdev_name, sizeof(cdev_name) - 2, "%s/%s",
 			 tz_name, nl->d_name);
 		memset(cdev_name_linked, 0, sizeof(cdev_name_linked));
-		if (readlink(cdev_name, cdev_name_linked,
-				sizeof(cdev_name_linked) - 1) != -1) {
-			cdev_id = get_instance_id(cdev_name_linked, 1,
+		len = readlink(cdev_name, cdev_name_linked,
+				sizeof(cdev_name_linked) - 1);
+		if (len != -1) {
+			/* readlink does not append NUL, handle it manually (CWE-170) */
+			cdev_name_linked[len] = '\0';
+
+			/* get_instance_id modifies string, use a copy */
+			char link_copy[256];
+
+			strncpy(link_copy, cdev_name_linked, sizeof(link_copy) - 1);
+			link_copy[sizeof(link_copy) - 1] = '\0';
+
+			cdev_id = get_instance_id(link_copy, 1,
 						sizeof("device") - 1);
 			syslog(LOG_DEBUG, "cdev %s linked to %s : %d\n",
 				cdev_name, cdev_name_linked, cdev_id);
-			tzi->cdev_binding |= (1 << cdev_id);
-
-			/* find the trip point in which the cdev is binded to
-			 * in this tzone
-			 */
-			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
-				"%s%s", nl->d_name, "_trip_point");
-			sysfs_get_ulong(tz_name, cdev_trip_name,
-					&trip_instance);
-			/* validate trip point range, e.g. trip could return -1
-			 * when passive is enabled
-			 */
-			if (trip_instance > MAX_NR_TRIP)
-				trip_instance = 0;
-			tzi->trip_binding[cdev_id] |= 1 << trip_instance;
-			syslog(LOG_DEBUG, "cdev %s -> trip:%lu: 0x%lx %d\n",
-				cdev_name, trip_instance,
-				tzi->trip_binding[cdev_id],
-				cdev_id);
-
+			if (cdev_id >= 0) {
+				tzi->cdev_binding |= (1 << cdev_id);
 
+				/* find the trip point in which the cdev is binded to
+				 * in this tzone
+				 */
+				snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
+					"%s%s", nl->d_name, "_trip_point");
+				sysfs_get_ulong(tz_name, cdev_trip_name,
+						&trip_instance);
+				/* validate trip point range, e.g. trip could return -1
+				 * when passive is enabled
+				 */
+				if (trip_instance > MAX_NR_TRIP)
+					trip_instance = 0;
+				tzi->trip_binding[cdev_id] |= 1 << trip_instance;
+				syslog(LOG_DEBUG, "cdev %s -> trip:%lu: 0x%lx %d\n",
+					cdev_name, trip_instance,
+					tzi->trip_binding[cdev_id],
+					cdev_id);
+			}
 		}
 		return 0;
 	}
@@ -398,9 +420,14 @@ int probe_thermal_sysfs(void)
 		/* detect number of thermal zones and cooling devices */
 		while (n--) {
 			int inst;
+			char name_copy[256];
+
+			/* Use copy to prevent strtok corruption in get_instance_id */
+			strncpy(name_copy, namelist[n]->d_name, sizeof(name_copy) - 1);
+			name_copy[sizeof(name_copy) - 1] = '\0';
 
 			if (strstr(namelist[n]->d_name, CDEV)) {
-				inst = get_instance_id(namelist[n]->d_name, 1,
+				inst = get_instance_id(name_copy, 1,
 						sizeof("device") - 1);
 				/* keep track of the max cooling device since
 				 * there may be gaps.
@@ -414,7 +441,7 @@ int probe_thermal_sysfs(void)
 					ptdata.max_cdev_instance);
 				ptdata.nr_cooling_dev++;
 			} else if (strstr(namelist[n]->d_name, TZONE)) {
-				inst = get_instance_id(namelist[n]->d_name, 1,
+				inst = get_instance_id(name_copy, 1,
 						sizeof("zone") - 1);
 				if (inst > ptdata.max_tz_instance)
 					ptdata.max_tz_instance = inst;
@@ -476,10 +503,10 @@ int zone_instance_to_index(int zone_inst)
 }
 
 /* read temperature of all thermal zones */
-int update_thermal_data()
+int update_thermal_data(void)
 {
 	int i;
-	int next_thermal_record = cur_thermal_record + 1;
+	int next_thermal_record = (cur_thermal_record + 1) % NR_THERMAL_RECORDS;
 	char tz_name[256];
 	static unsigned long samples;
 
@@ -488,9 +515,6 @@ int update_thermal_data()
 		return -1;
 	}
 
-	/* circular buffer for keeping historic data */
-	if (next_thermal_record >= NR_THERMAL_RECORDS)
-		next_thermal_record = 0;
 	gettimeofday(&trec[next_thermal_record].tv, NULL);
 	if (tmon_log) {
 		fprintf(tmon_log, "%lu ", ++samples);
diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216a27f4..6b9701a7f8ff 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -229,8 +229,8 @@ int main(int argc, char **argv)
 	while ((c = getopt_long(argc, argv, "c:dlht:T:vgz:", opts, &id2)) != -1) {
 		switch (c) {
 		case 'c':
-			no_control = 0;
-			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE);
+			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE - 1);
+			ctrl_cdev[CDEV_NAME_SIZE - 1] = '\0';
 			break;
 		case 'd':
 			start_daemon_mode();
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 031b258667d8..09869efb6778 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -208,12 +208,12 @@ void show_cooling_device(void)
 	mvwprintw(cooling_device_window,  1, 1,
 		"ID  Cooling Dev   Cur    Max   Thermal Zone Binding");
 	wattroff(cooling_device_window, A_BOLD);
-	for (j = 0; j <	ptdata.nr_cooling_dev; j++) {
+	for (j = 0; j < ptdata.nr_cooling_dev; j++) {
 		/* draw cooling device list on the left in the order of
 		 * cooling device instances. skip unused idr.
 		 */
 		mvwprintw(cooling_device_window, j + 2, 1,
-			"%02d %12.12s%6d %6d",
+			"%02d %12.12s%6lu %6lu", /* FIXED: %d -> %lu */
 			ptdata.cdi[j].instance,
 			ptdata.cdi[j].type,
 			ptdata.cdi[j].cur_state,
-- 
2.52.0

