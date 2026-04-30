Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E41247291;
	Thu, 30 Apr 2026 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519248; cv=none; b=lfUVTy9bvqceNh62vUvc8EYLYQnr3VGzfOnffY2UVrTPuyvCkY6wFZJoRf9ZPcTNUMnRKnQP2zWf4rIU98zgsshQboDQgDaaxUDE9PDXgtDOGujinUKr/kSDCjvgflQferefVtnzIfKOhLMVjngAZ5gOOnl8xccvheBzi4wzqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519248; c=relaxed/simple;
	bh=p3vcf/wCTJIAmkbegHP2RypD6AUzBos3fYc6+PWfHm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYvubwVJlGfjHTh4otAHF6yoC65fwrlw2o3rOpgiLULztF8UZBdWBYIwU9HlPx24nELdHnNE39ESJmKw5wegFqYa897IGUGp99cjQE7w5YqYDOT5ANr5lEcmvNLGR7KVd00CTQtxYe9C6JpJoec1+bCOpY9XNkQE+ALNLetl7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8f8b812a444311f1aa26b74ffac11d73-20260430
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:416c9d10-0fe9-473c-ad39-eb7e2b311d23,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:416c9d10-0fe9-473c-ad39-eb7e2b311d23,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:4b6798964a88d4b26caea75360e99aee,BulkI
	D:260430112041ZN07P7ZJ,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8f8b812a444311f1aa26b74ffac11d73-20260430
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.159.75)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 111396165; Thu, 30 Apr 2026 11:20:38 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: cwchoi00@gmail.com
Cc: cw00.choi@samsung.com,
	kyungmin.park@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	myungjoo.ham@samsung.com,
	nm@ti.com,
	zhanjie9@hisilicon.com,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v3 3/4] PM / devfreq: Fix governor_store() failing when device has no current governor
Date: Thu, 30 Apr 2026 11:20:35 +0800
Message-Id: <20260430032035.75496-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401033119.67821-1-tianyaxiong@kylinos.cn>
References: <20260401033119.67821-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since devfreq_remove_governor() may clear the device's current governor
in certain situations, while governors actually exist independently
of the device, directly returning EINVAL in this case is inaccurate.

To fix this issue, remove this check and add relevant logic for when
df->governor is NULL.

Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
Co-developed-by: Choi Chanwoo <cwchoi00@gmail.com>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2977b07be939..76e3700577ca 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	char str_governor[DEVFREQ_NAME_LEN + 1];
 	const struct devfreq_governor *governor, *prev_governor;
 
-	if (!df->governor)
-		return -EINVAL;
-
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
@@ -1403,6 +1400,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		ret = PTR_ERR(governor);
 		goto out;
 	}
+	if (!df->governor)
+		goto start_new_governor;
+
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
@@ -1423,6 +1423,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		goto out;
 	}
 
+start_new_governor:
 	/*
 	 * Start the new governor and create the specific sysfs files
 	 * which depend on the new governor.
@@ -1436,6 +1437,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 
 		/* Restore previous governor */
 		df->governor = prev_governor;
+		if (!df->governor)
+			goto out;
+
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
 			dev_err(dev,
-- 
2.25.1

