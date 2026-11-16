Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800800;
	b=PgsAfZPqTHI7663p/65McYVXIMKOLY40s7wbRpfvm6BvitdPlI2+iQnv6wBvHIHkG1C6
	 al5Fp4wOmbhkzzBxTs1gJKc4PBi4NUjYjg1kKDa9gCKUDBMf1yN/AlfgsPH3GRcMmW1cS
	 Lx2jaRcmwmwjUt4SEaObDQW5Y1hcAxkqy+3W1A3vKFR32HMkaoJtcyQIfhLk7UeouqVd8
	 26/4Z8C9xdJlU71Z3KY6kHF5+eo+gkt4rVBw1hQTWW85cMLr/Yi3JOh/POq/d2qEh48tR
	 hjYchDSlK7jIP74YATt41mMx3gtHTzRHQ8ZtbiP6DJ0M5mYDJlOpRMZSoY8wHbgQiwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800800;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bMYoHdwDS6ERXR7o6vJNjrN/UznMDiuh92Nc95EJc+g=;
	b=YfuE0RnQqwokkfb1nbMkcxz8QDY+S19GT9r+PMOYnk+H4OOPKX24JwAx6qH9kOBs+l/3
	 8R1ofnjRfGpYmpje5u2r15+/wAUvvQ/Ut9fJSvLuX/WibEFyi0rkO2biXiLms6rOTp3Se
	 hEQIpi5JW5RHuwMzQm5SfA+F+OaR0eDgSBcCWJw61y9T9Xuw4nYT0yx+HpejKk6+mCJaT
	 HOb9cPziKWNo+yeDhghtHOLHyBWuV10bocn0aNGx505KdcmXJMlZIUEj9XSunMoGZYAeZ
	 0K5I8XTFmEBjuaEAv2ZNx1G23/oCpNbFhMFsJUpqwN7Nd0hYpmk/Sl0CgP36p7wdiUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5438606A335;
	Mon, 16 Nov 2026 03:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5438606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4d4ec16ce17011f19a56ed5b684f684d-20261116
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:981e35df-7e09-4fc2-b70e-c289b82f6c20,IP:10,
	URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:981e35df-7e09-4fc2-b70e-c289b82f6c20,IP:10,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:0196c6742fcb74d94cd1383e5144a5f1,BulkI
	D:26111611463290TSEWKU,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|136|153
	|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:11|94|82|1,Fi
	le:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4d4ec16ce17011f19a56ed5b684f684d-20261116
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(175.2.56.187)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1437984618; Mon, 16 Nov 2026 11:46:27 +0800
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	james.morse@arm.com,
	hch@lst.de
Cc: will.deacon@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Xin <xiongxin@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 1/4] PM: hibernate: reset clean_pages_on_read after load_image()
Date: Mon, 16 Nov 2026 11:46:16 +0800
Message-Id: <20261116034619.36218-2-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116034619.36218-1-xiongxin@kylinos.cn>
References: <20261116034619.36218-1-xiongxin@kylinos.cn>
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

load_image() sets clean_pages_on_read but nothing clears it.  If a
nocompress resume attempt fails and a compressed resume follows in the
same boot, the stale flag makes hib_end_io() call flush_icache_range()
from interrupt context for the reused ring pages of
load_compressed_image(), triggering the WARN_ON_ONCE(!in_task()) in
smp_call_function() on ARM64.

Reset the flag before load_image() returns, so that it cannot leak
into a later compressed resume.

Also clear it once the load is known to have failed, so that the bios
still in flight do not trigger the same interrupt-context flush during
the final drain.

Fixes: f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages restored in-place")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260926032416.467937-1-xiongxin%40kylinos.cn
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

New in v3, split from the single-patch v2 per review feedback from
sashiko, as it also fixes the stale clean_pages_on_read path on its
own; it now also covers the final drain of a failing load.
 kernel/power/swap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c78f1593600b..7f3cc2cc5cca 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1125,6 +1125,9 @@ static int load_image(struct swap_map_handle *handle,
 				nr_pages / m * 10);
 		nr_pages++;
 	}
+	/* Stop flushing pages on load failure. */
+	if (ret < 0)
+		clean_pages_on_read = false;
 	err2 = hib_wait_io(&hb);
 	hib_finish_batch(&hb);
 	stop = ktime_get();
@@ -1137,6 +1140,7 @@ static int load_image(struct swap_map_handle *handle,
 			ret = -ENODATA;
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
+	clean_pages_on_read = false;
 	return ret;
 }
 
-- 
2.25.1

