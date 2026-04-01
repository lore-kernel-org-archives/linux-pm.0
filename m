Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B01F875A;
	Wed,  1 Apr 2026 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014292; cv=none; b=F6EBeGCdPemSPP4d8/ydNQVA4F1XYgzlJTbUjSkvr/IZ2r/IGuwIyzl5Vt2SYw6uB8Wu54pv4bMG/w6R1rtDIFSCmf1fhTCmmxCt9GMpJgH+lSFQWBOAgYKE41C4i8HrggVk1nuq3Z2tNHN8K2GmVbSqgp6V4umoPHtxaCtmsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014292; c=relaxed/simple;
	bh=mpsRLlgShVo0aSCmG5RomxoA/G0YvSjaCtIyd13tRgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RU8md3qslqLFbzj+Gfmj8w4lx8yz54it8lbL19D42Lau0ucbdoZAl0JvPTaEEFSiVFAyOWjB4reNB7GgN6vgB78xEQayxCox043iGQ9T6C6DehNKzY989sm/c+/xkE8N25TLmOhO6CiPQHlTI/I0AETou92cVqa9kmZR110OxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 41910c582d7b11f1aa26b74ffac11d73-20260401
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
X-CID-O-INFO: VERSION:1.3.12,REQID:6ab4b3e0-440b-48d5-8b53-f345efef6c09,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:6ab4b3e0-440b-48d5-8b53-f345efef6c09,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:687112bede1fa0f076d65607ff1559be,BulkI
	D:260401113125116UWKOG,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 41910c582d7b11f1aa26b74ffac11d73-20260401
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(106.16.221.117)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1208669954; Wed, 01 Apr 2026 11:31:22 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	zhanjie9@hisilicon.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 3/4] PM / devfreq: Fix governor_store() failing when device has no current governor
Date: Wed,  1 Apr 2026 11:31:19 +0800
Message-Id: <20260401033119.67821-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
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
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2977b07be939..975f82d7a9d1 100644
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
@@ -1403,6 +1400,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		ret = PTR_ERR(governor);
 		goto out;
 	}
+
+	if (!df->governor) {
+		df->governor = governor;
+		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+		if (ret) {
+			dev_warn(dev, "%s: Governor %s not started(%d)\n",
+				__func__, df->governor->name, ret);
+			df->governor = NULL;
+		} else {
+			ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
+		}
+		goto out;
+	}
+
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-- 
2.25.1

