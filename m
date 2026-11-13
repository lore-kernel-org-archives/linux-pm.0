Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554795;
	b=wOwLWR5pWf5whWDvk595DVHad6M643NeqW7OlU1HpxHF8HPZ4x9AAPVj9o8iXbZ6PLJT
	 VdRUi2l7JG8xKZYoMKy5uJSmS8uZTirQpwm/p6tiYL4MU+gGdGV3YF+Zd6O1ISBdUh/UO
	 aLacBXfIaStwEnhATa/Sfj1cYgBw8L0TSBCS221vRsZYpaJl/IYWG3iuGZYOeV1yrM6db
	 GJwx8gZdbwVZIjHSkGCGhDMRZplx1Xru+o0OBq/cFS6WaFQmKH0rEnG8DGY9cyRtklrKM
	 FbsTL2JFvV8jVSu5xbgZmGdTB7E95wjb9JLdSp2HwN8lmB4MJZHPeS2GC+js8FMM9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554795;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E88biqVSHz6qNL4jjCebFWR9AcvaKjbYfKIBmqWfjtk=;
	b=Rb5vlqzAj0iwN7g+dg8bZpah+lI5sR/U2O0pMBUmiLOm9dUbAdud/iuhkYZvktKA3r+h
	 lfPQ2KXPZtV3+99DOinTt7HeihE+Z+1ThKyerWmjjQXJ1JuIyCtNVq2H5pLNlLSn5KrIl
	 7NfXrFos8lQA7SK1WO6SNErMoU1M56jSJCtlTyjnnylwFMi+K4c/SzG2e/wV81Bafwy6g
	 cB9XP1nSu0vfTSOockde4CfI7CRSWdm2IviorfBRaaRCKU+GpyxAxVvMnXa05lf4pNFRR
	 ct70QTSIaUhHYYD+oheUMJM5VCM5X8AMj4j+8SJGaZlKHM4fin+uKYbU1cJVgM+XtHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wWh7Sftl;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86D606A321;
	Fri, 13 Nov 2026 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A86D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wWh7Sftl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=wWh7SftlkSXnWmMbKb2yfaii51zIaJX6qOUmiIpupUtBflxRh8jDASLVdM/iUYz934nG+FDqIuIx5
	 EEmjBdhseLxzZJSDj6MFV3BU/j+WvFYxi3q56lVsAYkKY4mSimJACt4bJAhZHGmVXPfKZ7Mw2rGboC
	 eQAThuC0boY91pl0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af6bba6b13-c50f6;
	Fri, 13 Nov 2026 15:26:31 +0800 (CST)
X-RM-TRANSID:2ee16af6bba6b13-c50f6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af6bb9ff6e-1c780;
	Fri, 13 Nov 2026 15:26:31 +0800 (CST)
X-RM-TRANSID:2ee46af6bb9ff6e-1c780
From: Gu Bin <gubin@cmss.chinamobile.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	rdunlap@infradead.org,
	hemanth.selam@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/thermal/tmon: propagate fscanf failure in sysfs_get_ulong()
Date: Fri, 13 Nov 2026 15:26:20 +0800
Message-ID: <20261113072621.2285-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_get_ulong() always returns 0, masking a fscanf() failure, so
find_tzone_tp() cannot detect a malformed trip point temperature file
and reads the uninitialized temp_ulong. The sibling sysfs_get_string()
returns its ret.

Return the fscanf() result from sysfs_get_ulong() and have
find_tzone_tp() skip the entry when the read fails. This also makes
the check honor the "ignore 0/invalid trip points" comment above it:
previously a failed read left the caller-dependent stack value to the
temp_ulong < MAX_TEMP_KC comparison, so a garbage or zero temperature
could be counted as a valid trip point and later drawn as a bogus
marker in the TUI thermal data window.

Return 0 rather than -1 from find_tzone_tp() on the skipped entry so
the scan_tzones() loop keeps running, avoiding the early break that
would leak the remaining scandir() namelist entries.

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/thermal/tmon/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index 5d64aff12a86..7f1e38276254 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -70,7 +70,7 @@ static int sysfs_get_ulong(char *path, char *filename, unsigned long *p_ulong)
 	ret = fscanf(fd, "%lu", p_ulong);
 	fclose(fd);
 
-	return 0;
+	return ret;
 }
 
 static int sysfs_get_string(char *path, char *filename, char *str)
@@ -167,14 +167,15 @@ static int find_tzone_tp(char *tz_name, char *d_name, struct tz_info *tzi,
 			int tz_id)
 {
 	int tp_id;
-	unsigned long temp_ulong;
+	unsigned long temp_ulong = 0;
 
 	if (strstr(d_name, "trip_point") &&
 		strstr(d_name, "temp")) {
 		/* check if trip point temp is non-zero
 		 * ignore 0/invalid trip points
 		 */
-		sysfs_get_ulong(tz_name, d_name, &temp_ulong);
+		if (sysfs_get_ulong(tz_name, d_name, &temp_ulong) != 1)
+			return 0;
 		if (temp_ulong < MAX_TEMP_KC) {
 			tzi->nr_trip_pts++;
 			/* found a valid trip point */
-- 
2.55.0.windows.3



