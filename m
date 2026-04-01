Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA21F875A;
	Wed,  1 Apr 2026 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014259; cv=none; b=feAsIiMPEWOkOJ5oy8GxMqxZfo8MvKDPF3Rf0b4NB+PnK1mZifdX/2Tj1IgG9McB23vJasmbhbDA6ePBPFg443L3T+EaLx5YqdwlRq5ZnEZlLaz3lKZ7WvRnfd+GZjZBXFxWTc4jFurjkVQgecm5WsKdt/yRJ//FroK82ipMuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014259; c=relaxed/simple;
	bh=ai6PNSXECpvO4A644D3B7Mn2DNqwwjYn71wrEsz5nhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSTdGiHRzIQUABINRLb2jXuAmXOx7MhZv9pyEn4rpwLXjv44IUhmjeTPfrqdxWkQ7mPtwVXnkxpowwfIn7e/KzrnzBzF+AGgWqkGIX2J3O4hjcmXwGSGU8UFm57Cc3zRmlLmjYnOvTP5Y2LvgJdBXArnPWxwisaoYihxjNW5EKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e007f842d7b11f1aa26b74ffac11d73-20260401
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
X-CID-O-INFO: VERSION:1.3.12,REQID:742f5f40-1580-44d5-95c9-ffbccdeb2246,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:742f5f40-1580-44d5-95c9-ffbccdeb2246,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d76e7eb4af261e82779d18e1cb29b20c,BulkI
	D:260401113052KVNSC9SY,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e007f842d7b11f1aa26b74ffac11d73-20260401
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(106.16.221.117)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1257289319; Wed, 01 Apr 2026 11:30:50 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	zhanjie9@hisilicon.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 1/4] PM / devfreq: Fix possible null pointer issue in devfreq_add_governor()
Date: Wed,  1 Apr 2026 11:30:46 +0800
Message-Id: <20260401033046.67482-1-tianyaxiong@kylinos.cn>
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

When a user removes a governor using devfreq_remove_governor(), if
the current device is using this governor, devfreq->governor will
be set to NULL. When the user registers any governor
using devfreq_add_governor(), since devfreq->governor is NULL, a
null pointer error occurs in strncmp().

For example: A user loads the userspace gov through a module, then
a device selects userspace. When unloading the userspace module and
then loading it again, the null pointer error occurs:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000010
Mem abort info:
ESR = 0x0000000096000004
EC = 0x25: DABT (current EL), IL = 32 bits
*******************skip *********************
Call trace:
__pi_strncmp+0x20/0x1b8
devfreq_userspace_init+0x1c/0xff8 [governor_userspace]
do_one_initcall+0x4c/0x278
do_init_module+0x5c/0x218
load_module+0x1f1c/0x1fc8
init_module_from_file+0x8c/0xd0
__arm64_sys_finit_module+0x220/0x3d8
invoke_syscall+0x48/0x110
el0_svc_common.constprop.0+0xbc/0xe8
do_el0_svc+0x20/0x30
el0_svc+0x24/0xb8
el0t_64_sync_handler+0xb8/0xc0
el0t_64_sync+0x14c/0x150

To fix this issue, remove the list_for_each_entry() logic, as
find_devfreq_governor() has already checked for the existence of
governor with the same name. This makes it impossible to find a
duplicate governor in the list, so the subsequent logic is
unreachable and can be removed.

Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

Hi Jie Zhan: 
	If you're willing, I'd like to add your Co-developed-by tag.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 82dd9a43dc62..994984f7b6e1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1261,7 +1261,6 @@ void devfreq_resume(void)
 int devfreq_add_governor(struct devfreq_governor *governor)
 {
 	struct devfreq_governor *g;
-	struct devfreq *devfreq;
 	int err = 0;
 
 	if (!governor) {
@@ -1280,38 +1279,6 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 
 	list_add(&governor->node, &devfreq_governor_list);
 
-	list_for_each_entry(devfreq, &devfreq_list, node) {
-		int ret = 0;
-		struct device *dev = devfreq->dev.parent;
-
-		if (!strncmp(devfreq->governor->name, governor->name,
-			     DEVFREQ_NAME_LEN)) {
-			/* The following should never occur */
-			if (devfreq->governor) {
-				dev_warn(dev,
-					 "%s: Governor %s already present\n",
-					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
-							DEVFREQ_GOV_STOP, NULL);
-				if (ret) {
-					dev_warn(dev,
-						 "%s: Governor %s stop = %d\n",
-						 __func__,
-						 devfreq->governor->name, ret);
-				}
-				/* Fall through */
-			}
-			devfreq->governor = governor;
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_START, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s start=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
-		}
-	}
-
 err_out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
2.25.1

