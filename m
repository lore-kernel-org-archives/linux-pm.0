Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE8378D82;
	Wed,  1 Apr 2026 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014138; cv=none; b=m5C/d//UzY9oLNN3TxJwOZzpSjONs9CSATgxfqWk4BkLIZJgTPM8jzBbDxcCQ8nDKPWk4YgC3+sd0EN7yhXZUPPGaXX5OVS6Hp5dkELGq9/Bgji/5sTKEL+W44fcTRCiEjAl6CmnHBxdj7fayqV9CKPy2+rqcIPrLoAB5vsnPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014138; c=relaxed/simple;
	bh=JE73yWTHgXvKuziX03Pb/L1Jm6LLDvaJ18XO7stKeHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFyzudkCOHmF4uDpOG3FXEvXMDO2fM63eO4BiOFIr4NkbdQ4ThmlyTN5cRCFXJ3nzqSKjgK+sIt2cdmhsKj7wbhl79ZRnbZdrUBWG18fq+j5ler8LZ4F5dxdGgNqx/pu7Vr+mQ5ZO2Qc43Ore6iCJiTOTFNQxFwZby1o0mBt7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e1d180402d7a11f1aa26b74ffac11d73-20260401
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:31d14ffc-1288-43a2-8fd1-d616d6fbbd25,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:31d14ffc-1288-43a2-8fd1-d616d6fbbd25,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:031de86f4684fbaa433d0572901c36a6,BulkI
	D:2604011128437RXE4JB9,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e1d180402d7a11f1aa26b74ffac11d73-20260401
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(106.16.221.117)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 579856791; Wed, 01 Apr 2026 11:28:42 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	zhanjie9@hisilicon.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 0/4] Fix some errors in the devfreq core layer when governor is NULL
Date: Wed,  1 Apr 2026 11:28:38 +0800
Message-Id: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While doing some development work with devfreq_add_governor()/
devfreq_remove_governor(), I discovered several bugs caused when
devfreq->governor is NULL. Specifically:

1) A possible null pointer issue in devfreq_add_governor(), caused
by devfreq_remove_governor() setting devfreq->governor to NULL in
certain situations, while devfreq_add_governor() lacks corresponding
checks for devfreq->governor.

2) When operating on governor and available_governors under /sys,
there are also some unexpected errors.

For issue 1, the solution is similar to Jie Zhan's PATCH.
https://lore.kernel.org/linux-pm/20260326123428.800407-6-zhanjie9@hisilicon.com/

The original v1 approach actually changed the original logic, which is incorrect.

See the following patches for details.

change in v2:
1) rebase to  linux-next(20260326) /devfreq-next 
2) remove some code to fix null pointer in patch1
3) add  sysfs_update_group() in patch2


Yaxiong Tian (4):
  PM / devfreq: Fix possible null pointer issue in
    devfreq_add_governor()
  PM / devfreq: Fix available_governors_show() when no governor is set
  PM / devfreq: Fix governor_store() failing when device has no current
    governor
  PM / devfreq: Optimize error return value of governor_show()

 drivers/devfreq/devfreq.c | 57 +++++++++++----------------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

-- 
2.25.1

