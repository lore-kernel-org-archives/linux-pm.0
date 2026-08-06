Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DC34EEEE
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992951; cv=none; b=mifYfm3acDbp514ehrQfuNB8Q8dIYHyuJ53d7HPzijUCAIu/eooUGiAnxILEZM9DegSRauPbw3UdSCgoawOzjdIqyoeTaVO+ueMy9rT0wz/XpBt/MshceN3hczhAiewJm2SRoVhZoVjFGFX5rNEOY3LSgONN3lWdaiDA9HIqn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992951; c=relaxed/simple;
	bh=oN4Rl3edB4mJV9TlJ8etemR3rqbOYTSNlcZJeSaUlcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Huxoi7IsWWo/y1ME/4XeZsJnHnpHoS9ifeU0hjrNUzSjQGtIkgyF1Q53ktNOEP10n3+afqpJgitDp4+14SKPoZuo6g/aASU4LJRk5/CkvdUDfgNrn9w7TIz6OcAMc7LLV/OKkgj//o1LAPGlAs9UDOS+PYrWEM0Hup3aemramr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUVjZIhl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUVjZIhl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1112700f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785992948; x=1786597748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+oWKqgV2uBxAga3aUXb6pt+JmIGNx/LBE5DxnCPtLR8=;
        b=eUVjZIhlOt5bbL1tB98PkEglFgQs0eMRWsjviH2OKlvHu/opOmVDcCiagSViQDIxL0
         HpfpLEj+609dAoepLXFswHGKoxMVWaMX9uN7K5MkRvFRjo/5a7hpHaQsJNEAccAvmCvA
         SxlS175nRmAKGE/0USPbsc3doYakslLaKS4eK5oHlk/H75Oya62aJ6F2tDKYYkaoMnx/
         CXIGb4sW3HBN9ZAx/yYe0310fLgVVO7x/E1PYhZZq8Qz/E7PRo7D0NOQokhk/J+st2SF
         GsR96+WGqs3/9CGs8Scrt2cemqpIxvU53dx3Q1axGekTNSA4hcekTC5Zp0Ofhq3sgAtG
         dcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785992948; x=1786597748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+oWKqgV2uBxAga3aUXb6pt+JmIGNx/LBE5DxnCPtLR8=;
        b=s5baH6Kgl9xhohyt5tcJgvp4iPv3zyns1jz+fP/bSosJWcRiaT1W8iut8pneBsV9Sl
         96HzbvWI3EJOOgpOXKmHyi2w5gM3t5iSUZWLKHRSmN7+i0l3D/K/en0K4PQn9xWIld8b
         O0rBjgTbZ4nh6urna8v2ctieP2SYxn/SkVMH6jj2lu7jgFYMEY3XyqS3kW40Qvw7/c4K
         +Dq7J7vqyDr1ihrUViAdqT0iC/sa9bkOeOEVwe6AAU7j2pZd/guzKE1DtX4zoZxKjbP1
         Zwn3ZZ3HOdPb2DqFFouTzsw2f53Zk1y79tDE9oYMedN6lbYIJh0CFcwAcjHaOt8GIXTo
         eRwg==
X-Forwarded-Encrypted: i=1; AHgh+RrdaKxEdFWc4C6qfLA55F8EKeq4/ZsQCxCHrypItPVWLtZ3+XfIQqSomobxNw+UxUXIrndyhGqdwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8lRPbdH42WCKQx1oqtI1hF2cqUMwm0jmDOx/D1IwoxlOWYaJ
	6u4QWiVPMAilRs1CFkIAMREjwXT7JHdTVbIEQa3K4RoU6NFr8BMlVE7R
X-Gm-Gg: AR+sD12rtE3Gq2/AVgL9YmIUy+R+LgbpQNo9bqCPV6pQehUQ5PTECZyPrhTDLSEhy/9
	Lp3KtwkDJLLLlllstQOHIlHhmVEqNbYdXVH0TgRjiE2JODrmJms6jt+UIE4tQoVZSjMs1l8oLev
	RTiYJpQH2CEpN2E9F0Km1gAvl/a9pR65V7nzM2hC/s7ZyJyRoq77gO1c+dDirgAwSrIgr6U33IX
	Lyv11YYp++Fubd5z1kq2whFAbXtZo9txXQLljFrqvgyIuIB92fYa9sJD1mZpDVvaGwmOBYotIaj
	TUAiLErLsrUJXm1Tsq/G52HnebET7U/29VH4UF1PNvgXtExa3g0IEH6Z9BWO8A4OmKju+c1ZZeR
	M6+Izy534RzOfW8BF2o6hdBiBg7YIIIcr9DQenGCkntW5uuVhpRt2RxO4CpGzXNO1sAROdDkB/7
	CcnzuF4d0h1LU1IF7ZdRAr5UjIAHgZWQH4luKBXbMHcCmk/9e3uQG/A8J7FJx5w3QzXdqceCLYA
	VrzdBLEwj2b8rXg1zl+Gw+nHah/JUWXhVfVG/NIQ1uzjyJWJHvMY1Lf6p/gDnOYZmCqErynV3CJ
	tLq3lczbqGZchJFR/5xZpsG6m4xaXGvil6GtthC8oKwZjuoPj8mX5yThY0PzR79f9WYLrTWeyA/
	yiCCNulGu
X-Received: by 2002:a05:6000:40da:b0:47f:93b6:8d06 with SMTP id ffacd0b85a97d-47fec482347mr19399636f8f.0.1785992947779;
        Wed, 05 Aug 2026 22:09:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adf9-2301-8c14-6be6-a9e6-a2d4.310.pool.telefonica.de. [2a02:3100:adf9:2301:8c14:6be6:a9e6:a2d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b183b2sm3315505f8f.24.2026.08.05.22.09.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 22:09:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Anson Huang <b20788@freescale.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: imx6q: fix devres accumulation across driver rebind
Date: Thu,  6 Aug 2026 07:09:02 +0200
Message-Id: <20260806050902.90550-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx6_soc_volt is allocated with devm_kcalloc(cpu_dev, ...), where cpu_dev
is the CPU device from get_cpu_device(0). That device is never unbound, so
its devres list is never released, and imx6q_cpufreq_remove() does not free
the array either. Every probe therefore adds an allocation that stays for
the lifetime of the system.

Allocate against the platform device instead. Its devres is released when
the driver is unbound, which is exactly the lifetime the array wants:
imx6q_set_target() reads it, and nothing may reach that after
cpufreq_unregister_driver().

That makes the array actually go away on unbind, so also clear the
file-scope pointer in remove and on the failed-probe path, rather than
leave it pointing at memory devres is about to release.

Tested by rebinding the driver on qemu's mcimx6ul-evk.

Fixes: b4573d1d657a ("cpufreq: imx6q: correct VDDSOC/PU voltage scaling when cpufreq is changed")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e93697d3edfd9..8110c95059e0e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -400,7 +400,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	/* Make imx6_soc_volt array's size same as arm opp number */
-	imx6_soc_volt = devm_kcalloc(cpu_dev, num, sizeof(*imx6_soc_volt),
+	imx6_soc_volt = devm_kcalloc(&pdev->dev, num, sizeof(*imx6_soc_volt),
 				     GFP_KERNEL);
 	if (imx6_soc_volt == NULL) {
 		ret = -ENOMEM;
@@ -485,6 +485,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	return 0;
 
 free_freq_table:
+	imx6_soc_volt = NULL;
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_opp:
 	dev_pm_opp_of_remove_table(cpu_dev);
@@ -506,6 +507,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 static void imx6q_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
+	imx6_soc_volt = NULL;
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	dev_pm_opp_of_remove_table(cpu_dev);
 	regulator_put(arm_reg);
-- 
2.53.0

