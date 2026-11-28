Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795878279;
	b=E4d9kMi93Ee3NYr/VtGs4IIe8z6EZRJJK5/DGgT5HKXHYrsG3SsAO09du0bVjgRLKOyV
	 rLaommnvve28e4y3MgULox9CVcX0ufb4cB4u4xhcxgF5X2fysxoD9AOl3bEdR1Y167+z6
	 oEz8LL6zQ18FG5mwqSxYsvJzO10+SHBTy+jalJrgGK+HcntXWV/FbgB6jo2Q29dJKoGlC
	 cX/C2Y2R5HiHHkkTqJQ+u76V/0PwsHioE2LVFSo9q75bDGkhJN7QNfEFphWgKsO1/p5ec
	 b84pUC2RV8wvf61p4lLeGI2KTPMxkAlDQqOqCiHizG5dWmE8n4LCa3od3PMHMgU1UOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795878279;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=aZ1zL0ye815Rnv3lJ1KDxo5Ck4FCKhuP/puan0BTFrI=;
	b=VZ0tZq7kwkUUwjh1aY+L4sEnqwx/rjRpMoHu1Gouk5WjWK6Ki1jWjxCHgXmPTwLHATG6
	 xLjd7MInEkKDwGhf0jaLAstN/3hLm0bGVd3v5tkyawMAW4Tpf2xhGeJF3+hZtA1JSqb28
	 fStlhXugaBC9pdp+1h4Pyc7FBvb5+F6AmfM4NaZYyIr6+CcNd3dNRSZSu6hwwA3BAvlW8
	 bBHiPDqx7RfD2IXj7oWxQHFpoga/hW5CL8PXUyDu9ZwXrusgN40PAEp2SZ0RaTvXbkXpz
	 aRUcvPgD/0uR8eXFh9rvVRf4oX/rdSQqbXM7BVD071KK9LUTaDErXotu+ELfSadiTLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XC9UoD0V;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262F606A31C
	for <linux-pm@vger.kernel.org>; Sat, 28 Nov 2026 15:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0262F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XC9UoD0V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aZ
	1zL0ye815Rnv3lJ1KDxo5Ck4FCKhuP/puan0BTFrI=; b=XC9UoD0VIWnoKyCCL0
	576/CJQeYYf2ErpyLqajpphyLP9w3dqudoytpk9oGDvY8Qxn0htEEhvcn/siye/w
	2V5n+YyG48+XiRnC7VGi8QSnmIAYF8EQN34fh0si3ZbS9qhT1hhoTHnSPCO0TI0I
	5Q3l8UX7K/jTVezuRnRKzKwdA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3lg7QprfTXHKw--.32244S2;
	Sat, 28 Nov 2026 23:04:02 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	rafalbilski@interia.pl,
	davej@redhat.com
Cc: linux-pm@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] cpufreq: e_powersaver: Release ACPI data when BIOS limit lookup fails
Date: Sat, 28 Nov 2026 23:03:58 +0800
Message-Id: <20261128150358.1323440-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wD3_3lg7QprfTXHKw--.32244S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFWkAF47uFykWFWDGF1ftFb_yoW8JryxpF
	ZIkrWjkrW8GFWDGasFy3Wfua4rXa1qkayxGrW0kwn8Zrs8WFn8Wa43tr1UZF97ur4xua12
	yFn8Ja4qyFW7Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBHqrUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QLwX2sK7WIyTQAA3R

The resources allocated by eps_cpu_init() are freed only when
acpi_processor_get_bios_limit() succeeds. Also release it on
it fails.

Fixes: 27e954c24167 ("[CPUFREQ] e_powersaver: Check BIOS limit for CPU frequency")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/cpufreq/e_powersaver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 54689ebadeb2..da2bb6d7dd15 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -284,11 +284,14 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 #if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 	/* Check for ACPI processor speed limit */
 	if (!ignore_acpi_limit && !eps_acpi_init()) {
-		if (!acpi_processor_get_bios_limit(policy->cpu, &limit)) {
+		int ret = acpi_processor_get_bios_limit(policy->cpu, &limit);
+
+		eps_acpi_exit(policy);
+
+		if (!ret) {
 			pr_info("ACPI limit %u.%uGHz\n",
 				limit/1000000,
 				(limit%1000000)/10000);
-			eps_acpi_exit(policy);
 			/* Check if max_multiplier is in BIOS limits */
 			if (limit && max_multiplier * fsb > limit) {
 				pr_info("Aborting\n");
-- 
2.25.1

