Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01783EFD3D
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528778; cv=none; b=UHCvVY750rbP+re6vONUTsDrTTxy4ii7aR69pKYB6n7JtkKWDOX1EnTumltMV6zLfh1dqX5qq2X+9n5HHjE1/KXOqndepJJGHsfhO1VRyED7e5801kWO/+92Wo/tVyQqPV+ce5MZELMFBPCgqmbCvbAkDCDEYYyGrho1Ep/dcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528778; c=relaxed/simple;
	bh=XzExxJ0V4iYErSn7UfRFdvuX/OfogLUQ8mA+EbmIGXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrDP5ZzRFBiijjy6fePczR0JBbhyYzN4hT1TwErQW/I6mHnBNwfdmi/dhFI1UZiX2MJ0Lchp/2UtM4TV8TId4gcrn/I1FTTmPzTW/ASuD5PkMkjz63egbUAcylhvO4i1p+5gsgcUQApOEqLTp8wE+l+qdG5EhSfhJaK+z/sNBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhNW05H7PznTVZ;
	Thu, 26 Mar 2026 20:34:04 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id B6CD440563;
	Thu, 26 Mar 2026 20:39:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:39:31 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v1 01/10] devfreq: Use mutex guard in governor_store()
Date: Thu, 26 Mar 2026 20:34:19 +0800
Message-ID: <20260326123428.800407-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326123428.800407-1-zhanjie9@hisilicon.com>
References: <20260326123428.800407-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Use mutex guard in governor_store() so as to simplify the locking logic.

No functional impact intended.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fcad3edceeea..21aa9661de0b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1431,20 +1431,17 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&devfreq_list_lock);
+	guard(mutex)(&devfreq_list_lock);
 	governor = try_then_request_governor(str_governor);
-	if (IS_ERR(governor)) {
-		ret = PTR_ERR(governor);
-		goto out;
-	}
-	if (df->governor == governor) {
-		ret = 0;
-		goto out;
-	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
-		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (IS_ERR(governor))
+		return PTR_ERR(governor);
+
+	if (df->governor == governor)
+		return count;
+
+	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE) ||
+	    IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE))
+		return -EINVAL;
 
 	/*
 	 * Stop the current governor and remove the specific sysfs files
@@ -1454,7 +1451,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
 			 __func__, df->governor->name, ret);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -1476,7 +1473,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 				"%s: reverting to Governor %s failed (%d)\n",
 				__func__, prev_governor->name, ret);
 			df->governor = NULL;
-			goto out;
+			return ret;
 		}
 	}
 
@@ -1485,13 +1482,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 * the new governor, restore the sysfs files of previous governor.
 	 */
 	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
+	if (ret)
+		return ret;
 
-out:
-	mutex_unlock(&devfreq_list_lock);
-
-	if (!ret)
-		ret = count;
-	return ret;
+	return count;
 }
 static DEVICE_ATTR_RW(governor);
 
-- 
2.43.0

