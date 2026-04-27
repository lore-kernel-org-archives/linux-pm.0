Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1473B19AC;
	Mon, 27 Apr 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291326; cv=none; b=iDqLQASeQDK4RIfUn4rMaKpYBFCVHA+g3K51aZ5FXO7Lh/Hxcv2B3S1SarAJHHsoOl1/3dEfZWqHze/pcY9eR696qUboKufznyzVo39Zn7vsVsfi5pnLk6AjSaAdk17+/dIsPqj3tFhvEm6MgpVhaLL1x8RgBL4D2oPT2zNgZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291326; c=relaxed/simple;
	bh=Q1BKskmxGfdISycfwvvhahkfUDQvrcLE7FHFOg6MuJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aJGhw+2vbB5rjI+SQACDhOx6ygBoi1JIhpT+hvZMz5ke9m1Z0XJhqI645K902yalfK7eG+WGurRkUzQpCs3F3io+BjhAxHU29DLmU7IU9/sL+J6iuvFu6pISvtE0cvjIxYTtBJmN1PgoINdD63xusacOsYlbrUEzG6B95NoCHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=BZ/qWjmQ; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="BZ/qWjmQ"
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 63RC1xxF064594;
	Mon, 27 Apr 2026 20:01:59 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 63RC12BI057321;
	Mon, 27 Apr 2026 20:01:02 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4g42Bp4Lbmz2L1dwH;
	Mon, 27 Apr 2026 19:58:10 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 27 Apr 2026 20:00:59 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <di.shen@unisoc.com>, <ling_ling.xu@unisoc.com>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [PATCH] pm/opp: fix race between opp_add and opp_get
Date: Mon, 27 Apr 2026 20:00:47 +0800
Message-ID: <20260427120047.10830-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 63RC12BI057321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1777291280;
	bh=Q0/Vj7FT5BKHaRvDeL7zH5EzhoNZ/VfyWfFPbigmXTA=;
	h=From:To:CC:Subject:Date;
	b=BZ/qWjmQizbTshLDE9qkX6AA/ehcH+QuAygLWDm4Pcq8YZfpiPAfc4Qc+HNH1J3At
	 x2Hv4KX8NzT+FfxXZAfOKofXMDwSA56428GtBfTzNray6Mf/g3vVvOf5PT782lqWsi
	 q+jLZVHm31SJN3r9yCo6EgUaahjk5zOfBSmdRl8OYFHMG5xsfz21EIbid9C37IQrf3
	 WhEtKUIe0+MDXJL3QOWRB+qsuATBf4bhwfBBzDNudHrok6oK6TPrk2zupNmyB0T8jf
	 k+vu1ZeMMXN65dv79a/Zmm2rRIixcSi2ca26hOUzguOzy9iLfBEfyyz0V0vLfCQ/65
	 P6dKDZ+IL1UUg==

From: Di Shen <di.shen@unisoc.com>

There is a race between opp_table_find_key and dev_pm_opp_add_dynamic:

dev_pm_opp_add_dynamic                dev_pm_opp_find_freq_exact
_opp_add_v1                           _find_key
_opp_add                              _opp_table_find_key
mutex_lock(opp_table->lock)
list_add(&new_opp->node, head)
mutex_unlock(opp_table->lock)
                                     mutex_lock(opp_table->lock)
                                     dev_pm_opp_get(opp)
                                     kref_get(&opp->kref)
                                       refcount_inc(&kref->refcount);
                                     mutex_unlock(opp_table->lock)
kref_init(&new_opp->kref)
  refcount_set(&kref->refcount, 1);
                                     dev_pm_opp_put()
                                     kref_put_mutex()

This would cause the opp be freed.

So use the mutex to protect opp's ref count.

Co-developed-by: Ling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Ling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/opp/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 866641666e41..34cdcf8f598d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2088,11 +2088,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 			return ret;
 
 		list_add(&new_opp->node, head);
+		new_opp->opp_table = opp_table;
+		kref_init(&new_opp->kref);
 	}
 
-	new_opp->opp_table = opp_table;
-	kref_init(&new_opp->kref);
-
 	opp_debug_create_one(new_opp, opp_table);
 
 	if (!_opp_supported_by_regulators(new_opp, opp_table)) {
-- 
2.25.1

