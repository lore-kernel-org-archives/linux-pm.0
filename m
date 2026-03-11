Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD93B3899
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247392; cv=none; b=JMGHwVwVQYCbItpoGLJrK1MnfXhdNcRYSKMOjH64uROB8agLc1nemOCMDKujSGoEYePdbxnnN8Zik/JqIXwKKhGigzXargrM9aBRTGtbyv7Z0fGxwne4I/tMS2MZy8LsOJUgmoWWR8VNe6HcDcHxH9pntb6lrtwjS8DirBgcNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247392; c=relaxed/simple;
	bh=TYp9hDZTxtN13hKZq3n2Cp4t4UPJzAGTRB4wmFdHlOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujaLrTpKW0NcnNORCMnfjnT5F99hizZco5Hp0Rg8YtDPuRlE7xLDGvmwFDpJbqLtbGnIpOgQxNgs5YRO6Ig/jA49N3wOM4Q076jXHRN4dU/xBp4y81EUAPyj/I2USQX4KTHx+q2i2V5oCf0M0Nc0yX9MxngM3SrfMiBJoNR8MsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HFy7Eceu; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HFy7Eceu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773247378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pdpADfahntg3YeP1Zleci7xdDq8ph1nCktCatjATaGQ=;
	b=HFy7EceuD6D47ufT0PLtZqoK6PrhB9uu7ZV2JMYACb3zweMi4NuboYevpblKfn4052x/Fz
	koHTYMHoxyCp0fEvtbQny/k0Zs9VcTys6CFB+qHV2uPLSfbyAqZqHDOm6Oq8GKoHTGJ6rH
	ZNG8fBMAmGHBn6dRUvbQMt3N6XGj7D4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sysfs: Use str_enabled_disabled helper in mode_show
Date: Wed, 11 Mar 2026 17:42:14 +0100
Message-ID: <20260311164212.405981-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=thorsten.blum@linux.dev; h=from:subject; bh=TYp9hDZTxtN13hKZq3n2Cp4t4UPJzAGTRB4wmFdHlOc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkbZ6dc8IzPZ+jL/SjDHdOhHNyy5JCC1nz2PScaw+YcW PLiwQP9jlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjImveMDB/5ru2osWX1Lbp3 4fDTehVJ3X3LP0bdivCz2FG2U21x0G1GhvVPt/Z23JnzZU+p6YcTXIJLRcILH/LMff8/pLo37rW 6FAsA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace hard-coded strings with the str_enabled_disabled() helper. This
unifies the output and helps the linker with deduplication, which can
result in a smaller binary.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/thermal_sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 46b3b2df935c..5eecae13f07d 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/jiffies.h>
 
 #include "thermal_core.h"
@@ -56,10 +57,8 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	guard(thermal_zone)(tz);
 
-	if (tz->mode == THERMAL_DEVICE_ENABLED)
-		return sysfs_emit(buf, "enabled\n");
-
-	return sysfs_emit(buf, "disabled\n");
+	return sysfs_emit(buf, "%s\n",
+		str_enabled_disabled(tz->mode == THERMAL_DEVICE_ENABLED));
 }
 
 static ssize_t
