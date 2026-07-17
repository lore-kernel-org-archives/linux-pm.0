Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771F1DDC1D;
	Fri, 17 Jul 2026 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251913; cv=none; b=erF+a/G8Z2dvQyo9paaJeEpEJW0UIwtF8fS5SJbogeL6/ZTW6P65UpLF9fjg0/RXM6s53UUCJaqRQcRHvqbficLBPMA20vsgS2cWMfw8UqeippKCWOugWAfWVLVnHugyFDPuHE/OFxgt3ijLLgdW+arEEzAVFPqzmLzw0EXqOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251913; c=relaxed/simple;
	bh=AEkH+S3LPeQIBHUnTBylYpth/yV5FHHkS+NT4XWVP9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpWVRbhrGXQUQfS6XmfLcER84G0B7zrKsVjMj4Nim9gE71GDRrTG2k89YOm96/LxMRBC6P4xo973jwEcxd1Aab6VWclM1WDHY1k3MaJA5Q1juOWx7veFvAMVsZnAJspMXpUlBeon0v43Deq/pideYZtcnLr2He/YikzWElTNef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 448e714a817f11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:35991573-2407-4e0b-b8bd-89724cf05bac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:aedd3a298ffaf126913f01f3b9efaaa4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 448e714a817f11f1aa26b74ffac11d73-20260717
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1057801486; Fri, 17 Jul 2026 09:31:43 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: shuah@kernel.org
Cc: jkacur@redhat.com,
	jwyatt@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sageofredondo@gmail.com,
	skhan@linuxfoundation.org,
	trenn@suse.com,
	yanlonglong@kylinos.cn
Subject: [PATCH v2] cpupower/debug/i386: check mmap return value in main
Date: Fri, 17 Jul 2026 09:31:25 +0800
Message-ID: <20260717013125.974-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <592b00fd-d529-4373-a733-d9f53d225540@kernel.org>
References: <592b00fd-d529-4373-a733-d9f53d225540@kernel.org>
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

Changes in v2:
- Remove trailing whitespace and blank row

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
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

