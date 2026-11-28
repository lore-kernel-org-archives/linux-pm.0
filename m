Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795879784;
	b=ZC/u8wMGrbQawbhAC8gt4Y/JWbsBkEhxAvOQLdkBtEJ5f7xcwno7o/nlBv8qJZe1zQbP
	 dhnipm9E2FdumyWd4FZ1BZczrtGaPj/bo6aCGYh5zjUIMii9tORoheh2QkeScl9ghDBz5
	 Qs6wxjS3ka105pX3997h8Y4U3yaCsTM+fUr/dIMQZ3iBB/rvOkuGsNYC366NwAlLrPAKh
	 +eYET/KwEaqM7noi0+7SZUaD+eSobejAk8+75TIRNwry3bkV66+DG+pe4WftH9znqrQku
	 Bpyc7EY6A1vc89CU9xjiECtGTcL3qUb7EF+mGgZK6DWjmtfx8JxxLLLQzP3TXb8N//Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879784;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=69kWFlc64oDWx4+1oU+Wiazj3ZPmIj+HYXpbh3IXN84=;
	b=g2jjKEyc3x8J43zKMJ2zecRH2Z6yLg6erI5ISayTZCzHP25btDlKVd1r/ZCOVlVf3YYe
	 iZupWYVbjlj0A537rDxAEDpbcAuY0QygWq7Xe54Zd7a5sTgf45ZD9oLHMPgJuub0oRkJU
	 E8sz0jeN+lWHReYCJzIXGrL4qrw1QpYqMkFVrqzsdGfbsfCyikAeskPq4vRizNeNDvLlK
	 sqW41XQiLRpuaZBcix0pcSunzTd1ObpayX17ycMmcbUStyG2JWpZalwxZqyPwsmWw9KdE
	 +iOKFWluNA3SvlFrm5rBjDJA7Y7+SjSu9HGrycDMQ/cvnMKXegVrTNO7894+joOCEGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="nfN/voo3";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C8606A324
	for <linux-pm@vger.kernel.org>; Sat, 28 Nov 2026 15:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518C8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nfN/voo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=69
	kWFlc64oDWx4+1oU+Wiazj3ZPmIj+HYXpbh3IXN84=; b=nfN/voo3wbsZnEKawM
	roQD89ODoMAtgja8yKj9E0m5GQVpMCoqYo7MV6vHQ+l3H71Ng7QjevHitVn/wru4
	+UT1Yc+aTepM/0HNyezWYDq1SCyjDJl4cqlkwHgNHY2IerLKqddaI8HmGAx6RtWX
	R8bwEyDzpdJVGZyRqslZ10+CU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Txgy8wprBF+ALg--.29300S2;
	Sat, 28 Nov 2026 23:28:52 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux@dominikbrodowski.net,
	malattia@linux.it,
	davej@redhat.com
Cc: linux-pm@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] cpufreq: speedstep: Drop the chipset device reference on failure
Date: Sat, 28 Nov 2026 23:28:49 +0800
Message-Id: <20261128152849.1333461-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wD3Txgy8wprBF+ALg--.29300S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWruF1rtr1UJF18KrW5trb_yoWftFcE9F
	1jgr17tr4qga9Igr1Uur1avryrAFy3Wr1fZF40ya43t34rZF9Iqrn7Zr15Z3s5X3y2yr9r
	Gw1UtF4SyF1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGjgcUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hRn1WsK8zToxAAA3C

speedstep_detect_chipset() leaves a reference in speedstep_chipset_dev.
Drop it if speedstep_find_register() fails as already done when
speedstep_activate() fails.

Fixes: 9a7d82a89a8b ("[CPUFREQ] Move PMBASE reading away and do it only once at initialization time")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/cpufreq/speedstep-ich.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index 262cfbde9ca7..14a734d304ee 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -357,8 +357,10 @@ static int __init speedstep_init(void)
 		return -EINVAL;
 	}
 
-	if (speedstep_find_register())
+	if (speedstep_find_register()) {
+		pci_dev_put(speedstep_chipset_dev);
 		return -ENODEV;
+	}
 
 	return cpufreq_register_driver(&speedstep_driver);
 }
-- 
2.25.1

