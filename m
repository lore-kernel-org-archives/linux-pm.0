Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15B35C19F;
	Mon, 29 Jun 2026 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782702709; cv=none; b=e13EAnkCRqDPhJgCLUSPUGNSVN8+r8c5oQpcNsgB+fzW7pssQb6xkVjkEEX5QVvR39bBZNu8hg3yMA8mcBX8CatqeF0XEBK8dsfLXo+Qs/04XlZdN12myFQTyjinRwkYhaGNuczBM2VJM5R98Zkkl54X9f565ecTOjLs13qXMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782702709; c=relaxed/simple;
	bh=WS6aMDWTh0MxVBzt+/eE+t9Oj+YEyOwY4UGJtSkPqtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5Dh9e6Am3MaEKojDuA66cEZUbV5AsgsKx3EsWsmO9aUCM3rkTcWBk36o97Esr7zb+FFhiaKjhBmlM4RffHuAypQZdnNKk4gyn4RYKeJeh9jYNoyt7jZmwx+AcS9JMBaki4yHkXyk/UXk1Kw8ZwQ5EP7+dV6lLVqCnKeMyedLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3ab143f2736811f1aa26b74ffac11d73-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:07bcff7d-ab44-4bb2-ac7a-ec3b7eec7420,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:394a6bcccd0778bf0883b01304f84a7a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ab143f2736811f1aa26b74ffac11d73-20260629
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 293483947; Mon, 29 Jun 2026 11:11:32 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: skhan@linuxfoundation.org,
	sageofredondo@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] cpupower/debug/i386: check mmap return value in main
Date: Mon, 29 Jun 2026 11:11:13 +0800
Message-ID: <20260629031113.556-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
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
---
 tools/power/cpupower/debug/i386/dump_psb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/power/cpupower/debug/i386/dump_psb.c b/tools/power/cpupower/debug/i386/dump_psb.c
index 6fb81b42ea61..9da519200433 100644
--- a/tools/power/cpupower/debug/i386/dump_psb.c
+++ b/tools/power/cpupower/debug/i386/dump_psb.c
@@ -181,6 +181,11 @@ main(int argc, char *argv[])
 
 	mem = mmap(mem, 0x100000 - 0xc0000, PROT_READ, MAP_SHARED, fd, 0xc0000);
 	close(fd);
+	
+	if (mem == MAP_FAILED) {
+		printf ("Couldn't mmap /dev/mem\n");
+		exit(1);
+	}
 
 	for (p = mem; p - mem < LEN; p+=16) {
 		if (memcmp(p, "AMDK7PNOW!", 10) == 0) {
-- 
2.43.0

