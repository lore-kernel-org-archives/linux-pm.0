Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E2275B1A;
	Thu, 19 Mar 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911824; cv=none; b=J+cEFlMceYhvZnRvFGvhlpNsv+LIkoYKV/z9vLXSkSMUyRLJVesxmrevr6MGwVwqiksZEaNsexLF3077Hj95n59OKeKaUyYeYCfhTEJeOKgGsBJm5kU+4oUNRAWIMGkSOzgW3XVtwb+hNDvwKYCp5hNH9JuPNxslzHwx3dxX5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911824; c=relaxed/simple;
	bh=EQ0u/cTaIGlgPPSn2zj/uyDVberTCae4yj7OzesI1G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dvpo6kvkTw9L/0w2fRdFFeOHrSTlFkRwMQNRI5tyc1J6QJ0/nmkQo34zlABoW3x9I3Lu5l5ZPG9zkwQLXsn5Eq30jkJocmKfJP16BAMqYX1AZjty6Y9YwEcz5z7u9mE9TVDl6Pi9oLThZE/Z7IwaI0gx43EzTMbXZ9T0p/2CJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6064b9ce237411f1a21c59e7364eecb8-20260319
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
X-CID-O-INFO: VERSION:1.3.11,REQID:043da8c6-4c6b-4547-9d39-4784c595ba21,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:043da8c6-4c6b-4547-9d39-4784c595ba21,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:0d2ff1fcf33a4e7cd8c36a8596f372e0,BulkI
	D:260309195436K68LMHDV,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1|19,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6064b9ce237411f1a21c59e7364eecb8-20260319
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.81.164)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1593952495; Thu, 19 Mar 2026 17:16:56 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH RESEND 1/4] PM / devfreq: Fix possible null pointer issue in devfreq_add_governor()
Date: Thu, 19 Mar 2026 17:16:53 +0800
Message-Id: <20260319091653.1005878-1-tianyaxiong@kylinos.cn>
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

To fix this issue, modify the relevant logic in devfreq_add_governor():
Only check whether the new governor matches the existing one when
devfreq->governor exists. When devfreq->governor is NULL, directly
select the new governor and perform the DEVFREQ_GOV_START operation.

Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 54f0b18536db..63ce6e25abe2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1288,23 +1288,21 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor->name, governor->name,
+		if (devfreq->governor && !strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* The following should never occur */
-			if (devfreq->governor) {
+			dev_warn(dev,
+				 "%s: Governor %s already present\n",
+				 __func__, devfreq->governor->name);
+			ret = devfreq->governor->event_handler(devfreq,
+						DEVFREQ_GOV_STOP, NULL);
+			if (ret) {
 				dev_warn(dev,
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
+					 "%s: Governor %s stop = %d\n",
+					 __func__,
+					 devfreq->governor->name, ret);
 			}
+		} else if (!devfreq->governor) {
 			devfreq->governor = governor;
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_START, NULL);
-- 
2.25.1

