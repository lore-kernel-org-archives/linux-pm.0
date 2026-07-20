Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BE23D7E3;
	Mon, 20 Jul 2026 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511308; cv=none; b=ZDot63OuQT3N8jXPmmfNgaEmPhwI+xxn8S29cEmdwq0mDcZeYbUcmMUHWVEm/HfZRX+FQrJAEhwAh705g1mkwrJ5ECfwJJhQh3ZKAlhpvY6P1uqHlfBR82vt30abJY4/YFpsXdFTgBU8SL5rcbWhe+BXnSwXiAsPZkuJWKWkCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511308; c=relaxed/simple;
	bh=SFMLLAN8ah+f1pJQ81gomP4kEGF/u/VaxZaTdGI6/dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoeBjyvFmwJSvUx/ZJR4z6tFCL0KcJbJikNvBVwzILOtDCoqi3c0ss4+q3YtqlZIrtg5FkPVW2r83X+a1nhMc+ihADp/V++GW8SSdAPOsp9kvoc9r8NszmPeHObMBBA3JPxkItUQc1id2KE/PSnB0cM2eX6VV7fLkJ7C3gARrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37a79e4e83db11f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:501ac419-51b3-468e-bb3b-31df9b516492,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:919ca5a287e8556ff712818ee23c416b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 37a79e4e83db11f1aa26b74ffac11d73-20260720
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 553083663; Mon, 20 Jul 2026 09:34:58 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: skhan@linuxfoundation.org
Cc: jkacur@redhat.com,
	jwyatt@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sageofredondo@gmail.com,
	shuah@kernel.org,
	trenn@suse.com,
	yanlonglong@kylinos.cn
Subject: [PATCH v3] cpupower/debug/i386: check mmap return value in main
Date: Mon, 20 Jul 2026 09:34:37 +0800
Message-ID: <20260720013437.428-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <7f6a28eb-ea4d-4c9e-9aed-ed184b5d22e4@linuxfoundation.org>
References: <7f6a28eb-ea4d-4c9e-9aed-ed184b5d22e4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of mmap() is not checked. On failure mmap() returns
MAP_FAILED, not NULL. If mmap() fails, the subsequent for-loop
dereferences the invalid pointer (MAP_FAILED), causing a segfault.

Add a check for MAP_FAILED after mmap(), consistent with the existing
error handling style for open() in the same function.

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

Changes in v2:
- Remove trailing whitespace and blank row

Changes in v3:
- Format Adjustment
---
 tools/power/cpupower/debug/i386/dump_psb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/power/cpupower/debug/i386/dump_psb.c b/tools/power/cpupower/debug/i386/dump_psb.c
index 6fb81b42ea61..fcbb73b48acb 100644
--- a/tools/power/cpupower/debug/i386/dump_psb.c
+++ b/tools/power/cpupower/debug/i386/dump_psb.c
@@ -182,6 +182,11 @@ main(int argc, char *argv[])
 	mem = mmap(mem, 0x100000 - 0xc0000, PROT_READ, MAP_SHARED, fd, 0xc0000);
 	close(fd);
 
+	if (mem == MAP_FAILED) {
+		printf("Couldn't mmap /dev/mem\n");
+		exit(1);
+	}
+
 	for (p = mem; p - mem < LEN; p+=16) {
 		if (memcmp(p, "AMDK7PNOW!", 10) == 0) {
 			decode_psb(p, numpst);
-- 
2.43.0

