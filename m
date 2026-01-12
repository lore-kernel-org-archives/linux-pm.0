Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16337F10D
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240157; cv=none; b=nkBhmaVTDXnOHrdHrSYKReMGTN6If8EwQ6uXEnZM42YbI3XvJq4qyaMOxzrd7VZ+5YEJL/7zupK85FVF4D+XJbkBQZpzIa6HeoDC3HsGbbQW59K1MHloFtG2ksf6YchIi9M9Z15UEHRZv/lhmtObBD4CORVN6m/qLuyf3vBWYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240157; c=relaxed/simple;
	bh=DaG0mNPrxt7UxX6d1AEb9UeNXobR3jM4FbsaSZNzERY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+zelgYtbt7tkj2EJv9+r8URZRNZORFfd0D4+VRsPIeDdK9ntGqMZ8ko9Y+h9u/K+OLTcYtzN+4TJkaciVIuh/438ALqPe3SM2rQb0OOMYh+nTKpcaCSc2It+LM8YKce+0N9uLDrnIQNZP+Mp2nBWO25MJqWuU0KcAWlsL53+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPxj+ooK; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPxj+ooK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768240150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ptdK7BGnIMVl85BczoM9exnt2HtNdeSM/ljiCxt5DbQ=;
	b=DPxj+ooK4AEZU0Vkqi/WtVqofVMcdOTvM6bUyFlhagL9PeZVJUUFMBD6GldYnK6vj7nr+Y
	pxp3IIfZlo9D4JEoeB09HnMR8PpFLRnLQWBEBVO2eAYbC67HvPTtc1PSLDgel3fbiUslho
	ovrBGcCfLqdJ+vVYYM+c8Sq0vexszYI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sysfs: Replace snprintf with strscpy in policy_store
Date: Mon, 12 Jan 2026 18:49:00 +0100
Message-ID: <20260112174901.767434-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is no need to use snprintf with a format specifier to copy 'buf'
to 'name'; use strscpy() directly instead.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d80612506a33..e9580ddf4882 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -199,7 +199,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
 	char name[THERMAL_NAME_LENGTH];
 	int ret;
 
-	snprintf(name, sizeof(name), "%s", buf);
+	strscpy(name, buf);
 
 	ret = thermal_zone_device_set_policy(tz, name);
 	if (!ret)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

