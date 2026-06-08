Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DB3C768B
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938484; cv=none; b=OuImH0nhmvECmsCJteHhr6mf8/cqzMPZntELEILre0wtY2zoLVHIgLNzEXm93bXzG66/3JoWr4fJln/dD0cqmoIW2IDnpldCdwm8/Dqkhqafoz6DoVpsihh/pxwEyaZW8kS35hqHOxnGVgNSpXM5nVHW4if0tN8AQS7JZj+aPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938484; c=relaxed/simple;
	bh=48mcwPUmo/9zYJofH+uVW4ZSw1r41eWn2E1U8TdduE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IE4kgPBVJskl1vqcqk8u+BTnimzmWQvvczy+2OZS4rDY3KLWG2+Jey3QSDVEkV0vGOxpJrVCc5UxjSblfafVa/YLNfm8sgNeYvyQdzHfMjMIN4Kv2yAqxF1Y/LV3TKnsa7OlLznR73bCoMEV1uFEaGTg6jEpn+mKuf/lirziPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQP3BSeQ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQP3BSeQ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9158c621ebbso547977885a.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938482; x=1781543282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qK97WBhlFm9jXzvytkBdSpTTdkdNQDjTkrZMdLzU+1g=;
        b=hQP3BSeQ+i24b0Sx4OJtT/KiEXqtELu3jGeCI/G/lXez6TQpW2mQ1HX7g3XJLYlFXC
         tNbiYqqUvJ6tdcyURgQ4lmHt7jXK6PLmNRSP4Q3SpohDY8wWJyphCfaBQTd9X5gbZHCY
         1KCPZo9quGR9fw8anjdTSTgcc/k/4YDWXuk1EOZ++6gpWy1oStFykg/u1ah8almjQAhZ
         Yw7iuhIoKeJsXqXbo1yvac2WJTQKvsW4ElQJArjjowMrpIRagHgF2qKDU+/dJoriFbOp
         do5ETI+bW27O61wBFgg3OigdkVxQn8koa3XFvrwfpA89pl/l6ytsNN1DZRC/7ZDYI93i
         BVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938482; x=1781543282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK97WBhlFm9jXzvytkBdSpTTdkdNQDjTkrZMdLzU+1g=;
        b=Hi7NmpIR0sG58FKOwb+2oOnrVH23wezE3QMtaqZnlBHwldjC4LIHaSVtV89EMZ9nFZ
         5w31dJYCagsjnUgEv9YMNSftILmdC5s9rRT79iPu57Cl097hQFtm8o1cwKxrJNPqQIWv
         jcKQ1CLhPoP2LXiUniwrQ641rKsCfb3FoBsVB9MVRU6tCVTOuK5VPrFBS5hZEKrGfvIH
         cJPznP+HjJTfUNew8+waEyAM/CzP94li0kBTJTOTuOIVmSOavp056xuoVK3j2MChkW/r
         5+oQgdNNdAcVa6L+1NOuZOMiqsmXIoz3QvAXheq9mhaiR2mbcjWuxf43xLEpeLAul+5H
         lZdA==
X-Gm-Message-State: AOJu0YxYFyB2jcs+VGyEjpqXh1YDw61AXOEHLaJjqBmwKjjJY7a9cQGX
	4321WCWUgwqnVGvgs739CLpKtKmXBikxA+jfoUyVuqMgMLKM/nXAw3Z0
X-Gm-Gg: Acq92OEPm+KC96D5sBZczX4lesDrXBG5WuAqnr3+44nnG25EvlTchsl5Sdex7MBJwZv
	yAmw1Fx3n3cnIRwXAXq2NPk3QL79FTPITd3Db1+Unhx3Gz57wMIrw8xr0OHTyG7Z1aEjC7/Gb8T
	zDKh4recxB4uNXzgHUrHKH/xPN/8/TUdLG/CD+EwqxMO5xNnR+f1nCWdbeKzkgeLt2QAUVyacEc
	JhwMYsrRkVktu2cHslnekEFTa/AgXGCiBGz4NIr96/eDhsPOvYhkK+jMaWMP8uKC7XPTGBOX+n4
	i8WtzqLrxopLl9j/poptC/NeGK3gJhxl+yjx47O7iKB69TNKc9w58U8IuRRK+K8RJi1l4US09tT
	1vBpfmX5Con9brv+FD9Bw2KRujAFQ2D45uld4/rqtiHF9hfsFZqrpg8X0iTYrmp6HcA2G+JSGjh
	rN7JfQAOCiCQII+lCW72NtkLjG0pJ6KKbZuLr6aXtonCbMux0lRRY=
X-Received: by 2002:a05:620a:40c1:b0:915:ba3c:8c2b with SMTP id af79cd13be357-915ba3c97cemr1718627285a.19.1780938481705;
        Mon, 08 Jun 2026 10:08:01 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3bf5f9sm1821869285a.35.2026.06.08.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:08:01 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PM: QoS: Fix misc device registration unwind
Date: Mon,  8 Jun 2026 13:07:48 -0400
Message-ID: <20260608170748.82273-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_latency_qos_init() registers cpu_dma_latency first and, when
CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP is enabled, registers cpu_wakeup_latency
afterwards. The second registration overwrites the first return value.

As a result, a failure to register cpu_dma_latency can be masked if the
second registration succeeds. Conversely, if cpu_dma_latency succeeds and
cpu_wakeup_latency fails, the function returns an error while leaving the
first misc device registered.

Return immediately on the first registration failure and deregister
cpu_dma_latency if the second registration fails.

Fixes: a4e6512a79d8 ("PM: QoS: Introduce a CPU system wakeup QoS limit")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 kernel/power/qos.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 398b994b73aa..1944dbeb0d4c 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -519,18 +519,23 @@ static int __init cpu_latency_qos_init(void)
 	int ret;
 
 	ret = misc_register(&cpu_latency_qos_miscdev);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_err("%s: %s setup failed\n", __func__,
 		       cpu_latency_qos_miscdev.name);
+		return ret;
+	}
 
 #ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
 	ret = misc_register(&cpu_wakeup_latency_qos_miscdev);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_err("%s: %s setup failed\n", __func__,
 		       cpu_wakeup_latency_qos_miscdev.name);
+		misc_deregister(&cpu_latency_qos_miscdev);
+		return ret;
+	}
 #endif
 
-	return ret;
+	return 0;
 }
 late_initcall(cpu_latency_qos_init);
 #endif /* CONFIG_CPU_IDLE */
-- 
2.43.0

