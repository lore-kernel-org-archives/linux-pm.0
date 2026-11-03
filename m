Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709834;
	b=gk8tzZBkxGUcC/vUHP9G8w7qWHg/NbSbc9LEHJk0DUd+l45V2UZf/WV9PLjsCj5aZuBm
	 RL3kQ0Ic9c//zAxnhs1J4bWkce85KKd/P1iqhqIGnPLH7J/JA+cudzZ8oyX9Rtp7qh97l
	 04S7sfoHYMx3GrLwCvRfb8AcxHPnNh1HXUuA8icxj/L1fvVaYpjIncW6MWWlTbPVXBW22
	 NKAj8je6sQNX/NBUTzBFG5LRhprymWe9bmpwjrhOhfiLaFOMmiApjNrtxuwqu0oday38w
	 dNEta3CYdRZF3hWwhT4XnfHpeJOeY+3NMQ7bE5DBFHo7gwEez2iVmMmA0qgNe1n+iYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709834;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=lF3DSo/4fy6KkY2UCSKo/Dlv8UhhXzL8vWK+pvB7Tnk=;
	b=29uizE86i97gJ71xRVIejvadfEqCdo/ApNQqETLAMxyMtTvvmnyOZIJGr1skzzOQ9K44
	 HUD2KVx7bDz2YNZ5wvtBzh+yRMguEKYtd2xTQHens0ZPeRs2fS1NTx4rrZVb3MrXJB0Xr
	 oR4+kp9jaaZb2OqTQta7w+HQnrz1fum0F35SFVADtoqBQ5Z7M0/3PIb6yqfQoDs7oWCBL
	 ofbMQvVX4WS4KQqVNGotVGS+iCKmIxDnw89R2mjDEhgWBuqaoQvDX3dc83JqLGTY4zNqV
	 UUr6HuM7vAG1iVWWBNP5zptFp7ETW6vHKf16dKU/43NPJGmfCEDUNEG0TpM9O5GvhPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891F606EE8F;
	Tue,  3 Nov 2026 12:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4891F606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 33ef6f50d78411f19a56ed5b684f684d-20261103
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
X-CID-O-INFO: VERSION:1.3.19,REQID:c7644543-1081-4385-9023-cdd880bf9e8f,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:c7644543-1081-4385-9023-cdd880bf9e8f,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:0ecc2ece72e8b7878efae09c6d1c8a84,BulkI
	D:261103204346NSG9AIRS,BulkQuantity:0,SF:19|66|72|78|81|82|102|127|153|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 33ef6f50d78411f19a56ed5b684f684d-20261103
X-User: daiyanlong@kylinos.cn
Received: from localhost.localdomain [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <daiyanlong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1792045824; Tue, 03 Nov 2026 20:43:43 +0800
From: YanLong Dai <daiyanlong@kylinos.cn>
To: rafael@kernel.org
Cc: YanLong Dai <daiyanlong@kylinos.cn>,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/thermal/thermometer: Fix missing NULL check after realloc()
Date: Tue,  3 Nov 2026 20:43:36 +0800
Message-Id: <20261103124336.174919-2-daiyanlong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103124336.174919-1-daiyanlong@kylinos.cn>
References: <20261103124336.174919-1-daiyanlong@kylinos.cn>
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

In configuration_init(), the return value of realloc() is assigned
directly to config->tz_regex without checking for NULL. If realloc()
fails, the original pointer is lost (memory leak) and subsequent
dereference causes a NULL pointer crash.

Fix by using a temporary variable to receive the realloc() result and
checking for NULL before assigning to config->tz_regex.

Fixes: 110acbc6a451 ("tools/thermal: Add a temperature capture tool")
Signed-off-by: YanLong Dai <daiyanlong@kylinos.cn>
---
 tools/thermal/thermometer/thermometer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index b4f26d49e4c7..cc84540f467a 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -142,6 +142,7 @@ static int configuration_init(const char *path, struct configuration *config)
 	INFO("Found %d thermal zone(s) regular expression\n", length);
 
 	for (i = 0; i < length; i++) {
+		struct tz_regex *tmp;
 
 		config_setting_t *node;
 		const char *name;
@@ -163,8 +164,13 @@ static int configuration_init(const char *path, struct configuration *config)
 			return -1;
 		}
 
-		config->tz_regex = realloc(config->tz_regex, sizeof(*config->tz_regex) *
-					(config->nr_tz_regex + 1));
+		tmp = realloc(config->tz_regex, sizeof(*config->tz_regex) *
+			      (config->nr_tz_regex + 1));
+		if (!tmp) {
+			ERROR("Failed to allocate memory for thermal zone regex\n");
+			return -1;
+		}
+		config->tz_regex = tmp;
 
 		if (regcomp(&config->tz_regex[config->nr_tz_regex].regex, name,
 			    REG_NOSUB | REG_EXTENDED)) {
-- 
2.25.1

