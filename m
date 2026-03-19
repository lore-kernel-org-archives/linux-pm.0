Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8B3B8D55;
	Thu, 19 Mar 2026 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911851; cv=none; b=llbX80gx0eUdR3ku2cIa4t7vw8CSZgBZpAmC9a145rCHVHUUPLgQpJZDLSV9/nmRa7HnexRfCQb3sW+MR2AWYj+69nEf+MsGmmt9hn2b9JKqMRHi2+MemWGT2C/QlG7y+nuR/oeYGMUJPXFlXqxNMZSBwuW/b5AoEaZew5SYEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911851; c=relaxed/simple;
	bh=1yT3lSlM6pAAQCAVRHAZbp80PA6zTvdaA26h/rSurHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PU/WxYi7tkyWQO91yCvW9JYzuUnSPXWLty/Loo7m//R55Eu1ianvGlC7kT3FbykD9O9tQlcJoBxuT2k5iKvJ/CgoR3vJ0FTMbDFwEQsgNaAV8UZHaCShg2zmv5qQVvOGp0oxVTq23mS5XFutbO1ZuTNEThb8gV9mMZTZ8p5WMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7049782a237411f1a21c59e7364eecb8-20260319
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
X-CID-O-INFO: VERSION:1.3.11,REQID:cb0db077-dad8-4715-ab0f-67fee49567be,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:cb0db077-dad8-4715-ab0f-67fee49567be,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:9aeb2e59c72a43aef4d1b20a2dc4b566,BulkI
	D:2603091955003MUJSQHW,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7049782a237411f1a21c59e7364eecb8-20260319
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.81.164)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 205671121; Thu, 19 Mar 2026 17:17:23 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH RESEND 4/4] PM / devfreq: Optimize error return value of governor_show()
Date: Thu, 19 Mar 2026 17:17:19 +0800
Message-Id: <20260319091719.1007244-1-tianyaxiong@kylinos.cn>
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

When df->governor is NULL, governor_show() returns -EINVAL, which
confuses users.

To fix this issue, return -ENOENT to indicate that no governor is
currently set for the device.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4a312f3c2421..7cc60711fafd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1412,7 +1412,7 @@ static ssize_t governor_show(struct device *dev,
 	struct devfreq *df = to_devfreq(dev);
 
 	if (!df->governor)
-		return -EINVAL;
+		return -ENOENT;
 
 	return sprintf(buf, "%s\n", df->governor->name);
 }
-- 
2.25.1

