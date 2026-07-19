Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3E2628D
	for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784467423; cv=none; b=CQ87OxpeX3LeLnJJZ5ugzZ2m7KO3ShKokBcLafs4RzL0ZPmlFGUlP83yvD8GUeQF6/uO4AyCgIh6YPidc0X/1ulpnKz4KWehgDhcjM+86rOucfbst/xGLZ+jvOtjs6kzHlqDPCu9YMGqynKHaM5tr/ZBoaV5no0xNqb3E7U3zqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784467423; c=relaxed/simple;
	bh=OZTgTY7cOPgclh6p8HnIoGjd4Bq/o/jkAL8jWi657MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UY8irpxi7yUu88wa87mnSC1nopHklMpaY9IQnZRvwL2z4pUTYX5MHw7WEiRA+ulLwlNmGySzBJIP3Ss0TrqLrNb6A6Eml2Xpf9uUwC/7bOgjlgch5FQhce6EN/x0LaXWMCoSAGg43txULXQ8JEfEGi9bzf1NObZwOvmIHVXH5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yg2fjaID; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yg2fjaID"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784467409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3lAthVnWhhUC2vcdF0C+mOfmgeUUfF0dWH3HwU+wgHs=;
	b=Yg2fjaIDo9uM81sbZ0kUBUwcBHYxxyI3ZP7jVgAk/X/uUjSVWmDY2jNBLyl3UJpKyFYhkT
	LIxe6A12M2mTT/HFPfkGH1EnriguWAaJaJ00IBP9dvhSs7r34/34NsuI9cVtPn5tQZof2x
	gT2pgmZ4VSUArkgmgHxsQhEaHw6iFKM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sysfs: Use sysfs_emit_at() in trans_table_show()
Date: Sun, 19 Jul 2026 15:22:53 +0200
Message-ID: <20260719132251.31936-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=thorsten.blum@linux.dev; h=from:subject; bh=OZTgTY7cOPgclh6p8HnIoGjd4Bq/o/jkAL8jWi657MA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkx51cr3hI8bSKxj/fSpQl7N3xUO+g1QWWLRFr7jk0Hd 3JckOV/1VHKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATYZrL8E8npsrvK4NUsLlf 3btH4SKNNxJjN4Wfn1muujBkIZeFJTfDPzVLs6gJj2NPf7hU4RElmnO5mMP73Ks5Jvki0k3B2Q6 W7AA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace snprintf() with sysfs_emit_at() in trans_table_show().
sysfs_emit_at() is preferred for formatting sysfs output because it
provides safer bounds checking.

Convert multiple PAGE_SIZE length checks to check the number of bytes
actually copied by sysfs_emit_at(), thus avoiding manual buffer size
accounting.

Consistently return -EFBIG when the transition table output exceeds the
sysfs buffer, including the header row.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/thermal_sysfs.c | 49 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index b44abfc997ed..adbcb2c011e8 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -706,7 +706,7 @@ static ssize_t trans_table_show(struct device *dev,
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats;
 	ssize_t len = 0;
-	int i, j;
+	int i, j, copied;
 
 	guard(cooling_dev)(cdev);
 
@@ -714,41 +714,40 @@ static ssize_t trans_table_show(struct device *dev,
 	if (!stats)
 		return -ENODATA;
 
-	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
-	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
+	len += sysfs_emit_at(buf, len, " From  :    To\n");
+	len += sysfs_emit_at(buf, len, "       : ");
 	for (i = 0; i <= cdev->max_state; i++) {
-		if (len >= PAGE_SIZE)
-			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
+		copied = sysfs_emit_at(buf, len, "state%2u  ", i);
+		if (!copied)
+			goto buf_full;
+		len += copied;
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
-
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	for (i = 0; i <= cdev->max_state; i++) {
-		if (len >= PAGE_SIZE)
-			break;
-
-		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
+		copied = sysfs_emit_at(buf, len, "state%2u:", i);
+		if (!copied)
+			goto buf_full;
+		len += copied;
 
 		for (j = 0; j <= cdev->max_state; j++) {
-			if (len >= PAGE_SIZE)
-				break;
-			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
+			copied = sysfs_emit_at(buf, len, "%8u ",
 				stats->trans_table[i * (cdev->max_state + 1) + j]);
+			if (!copied)
+				goto buf_full;
+			len += copied;
 		}
-		if (len >= PAGE_SIZE)
-			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
-	}
-
-	if (len >= PAGE_SIZE) {
-		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
-		len = -EFBIG;
+		copied = sysfs_emit_at(buf, len, "\n");
+		if (!copied)
+			goto buf_full;
+		len += copied;
 	}
 
 	return len;
+
+buf_full:
+	pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
+	return -EFBIG;
 }
 
 static DEVICE_ATTR_RO(total_trans);
