Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC23AE6F5
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301952; cv=none; b=iNT0KYjgiHpVrOo0wTAVCzRt7HYh3y9s0mRvKX+h2yBU/LSOC2woQG24BqqqWFUMinqS1wttshn/fhFWqDT8Ma/TDQhCSPR++hpArzyH25GeV8LEks3tLo1eVDV5rumXiJutJKKMGehZphc2PLKOuFOKhDA6wALJn4PBvMG+I7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301952; c=relaxed/simple;
	bh=hECz+rTVF4JahtvtK36ICZ2v3e438UAepa3Jm1G/eh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zy7osQ/qMkOd6OQqFmiXM4MbOqIKg/WINPy6gtQISx0WUZAD875Zs72yKW6/bk3ijODJDtcMr/J80Q/51CPveY7Af0BBOy2Kq4oEyiVelhLoeHJnP7i8haGb7GtcrjQvlFvYyUWTQl5I13XMZ2dUwPNjdShectMfk6dbCmgN7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fslGJVK7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fslGJVK7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so1536886a12.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787301949; x=1787906749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iYefBj/AHN1n4yIAZB/3J8tNso/f+xEHco2SVVZ9szI=;
        b=fslGJVK7NiDaJxyjl4hcMXJITJWW8pv8KIy9RIwAja79MISOlXmOH0BCktpKeSur0x
         0/XFMikHTuTcU/IjzKET+qYu/6/3bOgdlXaMrUDNcHsqk5DUObTo6V2bTEd9sb5p720a
         uguxieZNAFrHAGnknHpCQG4zXZeT0TXv1adgLPbYVFbgHRGi5nbcaGeS8TzXokXbBOUY
         698sOVOs3+pADfv0j9j3fQxitIeYoH4FIauseIv7koo6aiUAGAZ0mUcjlIrklyavxlww
         IyPFb1Qt5I59f8YiDmvFoLSLxGn8uIl28VNYJky4+4eEK3vmaL7yJCXAUIi+pkOsexQS
         Qj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301949; x=1787906749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iYefBj/AHN1n4yIAZB/3J8tNso/f+xEHco2SVVZ9szI=;
        b=Vlg8B8RKFhtxdckeCqi0XZ/7Urt7D+djTkZ8g6xUOwQnX5d9bSnYri7ntjbZM8ZRFR
         0yfIa9s1Q30XKG05Y3mDSW8nRK6BwLapWcORhF8pSMygYyx35jWGx7r9nraK6m4MFkrU
         RmqUJBiEq7ZDNY8jVzZWN8dxwAnQbyRykd8MM0jqgKDczMG+La1ymTVM4upd2hSXI5d6
         lRxLSFDEb9Z8v4l9VQLNW1wwDHtaT3CRh1tsmLnKxgcKnqLFCJIduqev+PrpvhhuZFHj
         tOJu8X0muhL/OE+tPu54T8T29HCO6lK5C3/jT9zDAuQkT+8Mv7ZEZRzPY14a6kU0df07
         eJnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwsLxboGaqPV2vFOLFR5jxixVbAnhg6ojBA0YiY4yRe3Boc3BPc2feYw70vHFrZSW3VbXLDziaBQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lCcnXUGZ8aTE/11pUI/9sSIfaPCp15ca5Te2HULlh9I1UQwWN/
	OPVNfq+vquR+vAG0OY1jDrwQDXCd0C78dA+L/e/xABeRE+nibOqvHuoE
X-Gm-Gg: AR+sD122aPyWikEiTxTgiAQq01kxVkweHIG+htDdDq+UsAWzBIHZGhkUECRWX856G+D
	iRyF0QAzMFcC6Ytlk4cqiDF3O5ljeHw0DtmEGW0MH2McM1IDOuBQGwEAWB4m9va1nO22S58TBQK
	otBWm7lmY5jrbIK82uUB4lPdpR01+uCDFWurz8SQV3yJScXlkQOBUcRRXPR+BrbhOO0LfTgcXHp
	Hu5s8XWfonjJTC6liTDw5fyz9sfdd38BP7Us+jkhrECNutcCrFIzAxdvSK5gm6n6sxtemmnpwoF
	BlzYu48rlBsNmrGTI97h/XdiJG4J/0Nb6VyBk6cJPetLwSzLfDphM+2wwGOFQp4+P7bmOk9cFYb
	zSrD7izG63/T/Im/ESoMdkPJyq823Ckw/d6PATJTDz85e5Hp6X2q8XECHSwpfGLtOaL4uG1uimL
	w1SBP35emVL7vZZA8xB3OJvuk4MzJZWuTacsGMkjgjeIT4V1BdmubLx8QZ6yXwjkMePV32q6iLK
	4YnoQ==
X-Received: by 2002:a05:6402:505b:b0:69c:811f:8f5 with SMTP id 4fb4d7f45d1cf-6a42f1b9325mr5134767a12.6.1787301948672;
        Fri, 21 Aug 2026 01:45:48 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([95.236.20.157])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c2cbsm5579500a12.22.2026.08.21.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:45:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: airoha: fix probe failure with correct error check
Date: Fri, 21 Aug 2026 10:45:39 +0200
Message-ID: <20260821084541.139703-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

dev_pm_domain_attach_list() returns the number of attached PM domains
on success (a positive count), or a negative error code on failure.
The driver checks "if (ret)" which treats a successful attachment of
one or more PM domains as an error, causing the probe to fail with
return code 1.

Fix by checking "if (ret < 0)" like all other users of this API.

Cc: stable@vger.kernel.org
Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/airoha-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
index 3e7770860d13..8283c528d0c1 100644
--- a/drivers/cpufreq/airoha-cpufreq.c
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -64,7 +64,7 @@ static int airoha_cpufreq_probe(struct platform_device *pdev)
 	/* Attach PM for OPP */
 	ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
 					&priv->pd_list);
-	if (ret)
+	if (ret < 0)
 		goto clear_opp_config;
 
 	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-- 
2.53.0

