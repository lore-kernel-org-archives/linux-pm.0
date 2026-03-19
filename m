Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698093B3BE2;
	Thu, 19 Mar 2026 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911834; cv=none; b=SkUpuKuesm8U9kEa+jGlZ4aAv0lxFW06sh4UFnQ3qL5yynmn7bvaeiDsJPifEXJap5y0MPiZOi8zBMQjr9VngVem6/5MPw8H2WmplPKGuUZ/1yRJNxBTNj7X8GpCZbtbNQKgonWrxN1wHRX/ByticwV9N6tWFZ6PUE83lwVzmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911834; c=relaxed/simple;
	bh=i1jwU4KWNL/HrGcY1wuLKKN+d8BiawGqojUHD+lSWVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzHeE9CWTB0+iUgsVJpnUjlHCGgBRRMnzNsjLyXLp+nUNF+XLjg93mYM95AmhAw/JNQbUmxHKRkQSByS373InmiusAVVxs0ELAbuhOzjgRz1XTiaYczlcN1zyxPRz333ei9lcuIuzdNRu9lKdATiZOcGcKAIGI3BKCW/RDWV2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 65737c0c237411f1a21c59e7364eecb8-20260319
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:9407ec8d-58ad-4da2-8f17-3545054e800f,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:9407ec8d-58ad-4da2-8f17-3545054e800f,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:6e88b8e504dd3f76b8c8632c52f0d7fc,BulkI
	D:260309195445LTGO4JZ9,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 65737c0c237411f1a21c59e7364eecb8-20260319
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.81.164)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 896799789; Thu, 19 Mar 2026 17:17:05 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH RESEND 2/4] PM / devfreq: Fix available_governors_show() when no governor is set
Date: Thu, 19 Mar 2026 17:17:01 +0800
Message-Id: <20260319091701.1006345-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since devfreq_remove_governor() may clear the device's current governor
in certain situations, while governors actually exist independently of
the device, directly returning EINVAL in this case is inaccurate.

To fix this issue, remove this check and use df->governor for validity
verification in the following code.

Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 63ce6e25abe2..0bf320123e3a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1504,16 +1504,13 @@ static ssize_t available_governors_show(struct device *d,
 	struct devfreq *df = to_devfreq(d);
 	ssize_t count = 0;
 
-	if (!df->governor)
-		return -EINVAL;
-
 	mutex_lock(&devfreq_list_lock);
 
 	/*
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
+	if (df->governor && IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor->name);
 	/*
-- 
2.25.1

