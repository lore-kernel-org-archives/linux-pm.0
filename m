Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ADA3EF650;
	Fri, 10 Jul 2026 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671956; cv=none; b=HWe4nxZDD2u9PYnhzvELImUYtw7CgICnsSDNqP7EWaCgBRaeybsGmWtaNnW4qNblHlz7KznLsKzmn/Cvam9laxhtjtQiV4IagU93PDa6I6ZU4BTyppc9eNPfS9q86u8YnoaZ9dXEdJ9xKVztkpYy+Yf6/zMQBGQFBYyhQagM2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671956; c=relaxed/simple;
	bh=PGQxHoCamhkvyKv7L3qhCKlwwAlwklqGBQ+Swl9BfuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZS5C0wFB7EbLT5DTXM0eDVT8F28ViNSp/TIFbVBfwsepLlWjHaxb2aCSfL2iAoX+VOH7R9xp1k9A+cQuztdlmcndNcfXOAR91YzYZw0KUhli3rKQjOR+LOwEoAldp6HPmN58Z/VH/iKQrWu0GuQcj8qDb4XRsx/CGejkgguMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=LCw4SI4V; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="LCw4SI4V"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTPS id 66A8PLtZ053463
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 10 Jul 2026 16:25:21 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4gxPyf6FLSz2S3kr9;
	Fri, 10 Jul 2026 16:24:58 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 10 Jul 2026 16:25:20 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <pavel@kernel.org>,
        <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan94@gmail.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH 2/2] PM: EM: Validate new_table in em_dev_update_perf_domain()
Date: Fri, 10 Jul 2026 16:24:47 +0800
Message-ID: <20260710082447.5160-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260710082447.5160-1-xuewen.yan@unisoc.com>
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 66A8PLtZ053463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1783671938;
	bh=FtFWK67eFemJ8nOXJOQ+HYOeP+r+Wyz0kpClXRfvc0g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LCw4SI4VBmoNgpY8HNuAe4jneFocL6RAefBeDfef3izFpLTD0GtUoGWNjZRWFwGy6
	 Xx3+TYxW21eJ1Yj3W4oXxekmOv+orJE/Tzs8DRdgeCVQD2Bk5FZ7BIiE1GmLZTV8PO
	 cTNL/01ieqRbKAaF0M71wRcg+WnIikd4mLiqS1g0KrEJSKavU7ro5r7o9P32l86EF6
	 wD+Ecvs9ZJphZtkQXX+J6HBd8ohMYEtSUqYMqDO6wIJ8eV5XHrQyco0iFSYYeD4abK
	 25mHIYtFbGigyR7R9q2MBObKM0wQTXf705Opr3ueNzKr6mcOLxEJl6vezPNvaSNNpy
	 QPgSAeaCrOINg==

Add an explicit check for the new_table parameter in
em_dev_update_perf_domain() to ensure it is not NULL or an
ERR_PTR before proceeding with the update.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 277aaf1b19da..4d75e1b3c20e 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -331,7 +331,7 @@ int em_dev_update_perf_domain(struct device *dev,
 	struct em_perf_table *old_table;
 	struct em_perf_domain *pd;
 
-	if (!dev)
+	if (!dev || IS_ERR_OR_NULL(new_table))
 		return -EINVAL;
 
 	/* Serialize update/unregister or concurrent updates */
-- 
2.25.1

