Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709834;
	b=4IVkATVkX63fc53V49uyko+1L1SHukaS4F8RdqbnZpj7bCj9LQSdVkRDvx+wYLKyHQVO
	 MYO2BnGymdQoXtSgQCHMuwlWIlxeFL62ujLZl/GTKBZ87EV610Xy87MwWmhX1cMRbX+/A
	 qKwzltqbGdLN2Y4hUulOU/AYgM1cy9GjWVtCLdNNo+MSAJTRPW35NwVkKpZtHQUHw6tWE
	 Tw/07kgymMZ3b7O3nen+6hhAE3VkfAh97CWfUOtI2ANQ7z5PUx90xBWodrrlIjwSVOkOB
	 M1HtMmqpbmVMYvKhaDAWFwyFVeLqeEGjEV1HSvjeX4FXKwOV5lIsNhqtk+NL9wh7tmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709834;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yPsTarkNePmz619K0m4BOqrBzL3fti5jQ/yGZI9K3YA=;
	b=m4gSAZn5MC2M/uCdzCQalR6YM74PbeZAhk92hWUDMZGpZkRtZfFjGP3vyu9pIZ8gTmI5
	 voPgzl+kPBf03RYbmazlU4b2QWnhQhyHlblxTrEeHu2Iauq23yOYsRfRGpiwz3Rf8W7Y6
	 YDGC4qkSsmFidxNAVt5NSRTStHharnwytpwhVWxrbb+HurblpkpEkAVuSTBWQrfceCOzG
	 icFMKPKbomxHV0Lc0B7oTUXZb+D8hzYp3l9NtNOJ0pmx2jIYeizSMajq5kV0xaZeeTaVe
	 33Otoe4GV9ZorJ42bKrOFM0NZ3bs9uLIsLerJqKEwzSO4XEF2dFLdy0KD+dFKe34orw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C22606EE94;
	Tue,  3 Nov 2026 12:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C22606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32beb9f6d78411f19a56ed5b684f684d-20261103
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:891e6794-7a56-439a-b44c-c9a2a07348f5,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:891e6794-7a56-439a-b44c-c9a2a07348f5,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:ea8dc47480066c86d37398f6f5ab4a34,BulkI
	D:261103204346NSG9AIRS,BulkQuantity:1,SF:19|66|72|78|102|127|153|850|865|8
	98,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32beb9f6d78411f19a56ed5b684f684d-20261103
X-User: daiyanlong@kylinos.cn
Received: from localhost.localdomain [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <daiyanlong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 814079660; Tue, 03 Nov 2026 20:43:41 +0800
From: YanLong Dai <daiyanlong@kylinos.cn>
To: rafael@kernel.org
Cc: YanLong Dai <daiyanlong@kylinos.cn>,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools/thermal/thermometer: Fix missing NULL check after realloc()
Date: Tue,  3 Nov 2026 20:43:35 +0800
Message-Id: <20261103124336.174919-1-daiyanlong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In configuration_default_init(), the return value of realloc() is
assigned directly to config->tz_regex without checking for NULL. If
realloc() fails, the original pointer is lost (memory leak) and
subsequent dereference causes a NULL pointer crash.

Fix by using a temporary variable to receive the realloc() result and
checking for NULL before assigning to config->tz_regex.

Fixes: 110acbc6a451 ("tools/thermal: Add a temperature capture tool")
Signed-off-by: YanLong Dai <daiyanlong@kylinos.cn>
---
 tools/thermal/thermometer/thermometer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 1ae6c3ecedb4..b4f26d49e4c7 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -83,8 +83,15 @@ static struct tz_regex *configuration_tz_match(const char *expr,
 
 static int configuration_default_init(struct configuration *config)
 {
-	config->tz_regex = realloc(config->tz_regex, sizeof(*config->tz_regex) *
-				   (config->nr_tz_regex + 1));
+	struct tz_regex *tmp;
+
+	tmp = realloc(config->tz_regex, sizeof(*config->tz_regex) *
+		      (config->nr_tz_regex + 1));
+	if (!tmp) {
+		ERROR("Failed to allocate memory for thermal zone regex\n");
+		return -1;
+	}
+	config->tz_regex = tmp;
 
 	if (regcomp(&config->tz_regex[config->nr_tz_regex].regex, ".*",
 		    REG_NOSUB | REG_EXTENDED)) {
-- 
2.25.1

