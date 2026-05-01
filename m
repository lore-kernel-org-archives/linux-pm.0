Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09783DEFE3
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662034; cv=none; b=hLe9Zw6Rkch2pEgg1bnPxpsM8iWFRHRnDs/zxDYbGOv8IGX5J7FJuvkGeALPvvIo4HBxmvsLL3k4RU1DpM1ILQyZJ0q6xKy2iM68f1r2OdQJHxDMIt0v1aJzXig9ciwBs5OOYtUVzFYTjs3vpm8xecUZPFBSuOY+nC0qUHwmBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662034; c=relaxed/simple;
	bh=J6D9KYDFjB2m0D4tZGtKNFNFDOx+6/Y/naS4pbb+Knw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXLEUxl33anebeE0fo0Y5ezxSS+Jk+wkViSCsLZjozp8xPFey2cb1yrb0NDb1eoOWIrIfDSxafzTnQzZ93HcUrrVmz3HxvT9oGNtY9qikpq8wngzmKOGUNRC1z8k1idpeOcQerbdBF7WNI79miO9RHDaQx/nTa2SsunfsYvWSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL1DKeSM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL1DKeSM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-834f1075805so1617484b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662032; x=1778266832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqfXSrQ/LcVyuHZiK19DFrhGz1VJgx9L+sEeQ6hZEtk=;
        b=XL1DKeSMzJhnJgu+XAvs7NLlKAVPPUNpND8U+YTPf9fUT2esF2h9b5pHCtvzKUFm+M
         qeH2gpgqtAXCrC6cIX1qjKRvvTTaJcEG/DgHxhgfh3Os65piDOrP7LAEUfI+0YcDOiEQ
         h7BPMhn6F77ZuwYwEoqQQ3inHS6PX/F/36x7bXm3J2Tko8qRjRbkesZuOtdYa/DOdz1S
         YgNar2Us/nZODFQRovEv+asGsTfOx8NbIsWmRFxN8snLAL1Yq7qi6G8gr7BcSspnISlW
         lSakbrAJPw7+1jjhAHNuin3qzfAa5MwtwnBOQwVwENsTRC8sFrZwfjWbuBcFNTGkZ2vN
         zYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662032; x=1778266832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqfXSrQ/LcVyuHZiK19DFrhGz1VJgx9L+sEeQ6hZEtk=;
        b=jKPjX/ZsrZQE0SpvlhSE11Ut4C7gCp5y7g/eKmdXeir9N6HFTZpDgdkL7mzH4mGCsJ
         XrC7ynmxVE2lJGap2FplGZU1TfVSThCs3rxydE3fQiDAhTMLZi2euqM8v/E2uH54p+a7
         I2Hq5BVqLElL0e3WE4PfGIfSkOoS8rGre7gLlhKPqqiZ2GkWQunt4Oe1kmLlzrFpJTNO
         M0XPYaSCqa3XgwjZ4NXSnbeMfWQb7sliw3Ys9cbc7/B6IW5j9vbtYmyC6mtancIV0MAY
         Wk8SZgdw0vRkZBbfDwR4LWfat/iytIxug/NyLnK9ueyz5wTfvHuSboNg7zNMc6EQ0wFo
         0RJA==
X-Forwarded-Encrypted: i=1; AFNElJ8UohAqejQ9X+iv1HaYn6K3rnQNFFpr5JFRCy4/WsHlaYdGXPXWfG4afV0VW51GQfC1Z8d2qNpukw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51wfaWLqlEBou3IwlWUUJ7zDT/i4HGphcHBPV1nLzqDNaF0ap
	TnwWhhu+ljedZUFskxGIkaUTJbaby2LO/+FGJBhGzkz73xnJgNjDV9wf
X-Gm-Gg: AeBDievMues2OsRv7y1XN8mI9EvR9iRyPQlep7ox522MauE06r2vCiGjSOFc9a8nHIj
	gvdsZbqI+sgoYXes1mIwwPNOD7lXXqgGlVOS1AZ/3M5GN+hehgZrzu4poqOoNDJuuc/EUDMqv/T
	BKm5QMyoT51bBjZ0VxLJLZRY1BMPk0M+4icYb43KmzVLWKHO+uteanIXXhI4Mw6ABpUHu+bNsHl
	G/8V6CIS1a6xVCI2wDLvg8/GA/K2s7gtNG2P3ll3Bt+LiI40g6I+Pdwrog+euzuMoS5y1CqcnpS
	f/bjCbjTEorFvNCkWU6kq+MOBFTkrNqzBCQM3vH5sPFlKQ96PGW0X5L/e4bSZ2RtPE4ylyOr4BW
	HsUTUx1W6EqP1ODRdd3SZTfWYBhQ7ACrRh7GSFe5LsEmoya/ihLIx9NoFNMCM4PsWKfBC6yADUI
	1F3KEL260F5AkwSX/Fews1vKI=
X-Received: by 2002:a05:6a00:883:b0:82f:6dad:7b75 with SMTP id d2e1a72fcca58-8352d25e95fmr398194b3a.33.1777662032246;
        Fri, 01 May 2026 12:00:32 -0700 (PDT)
Received: from lgs.. ([118.193.39.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b87869sm3543691b3a.61.2026.05.01.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:00:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free
Date: Sat,  2 May 2026 03:00:05 +0800
Message-ID: <20260501190005.504962-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
one element of this array in policy->driver_data.

qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
This is not valid because the memory is devm-managed. For the first
domain, this can free the devm-managed allocation while the devres entry
is still active, leading to a possible double free when the platform
device is later detached. For other domains, the pointer may refer to an
element inside the array rather than the allocation base.

Remove the kfree(data) call and let devres release qcom_cpufreq.data.

This issue was found by a static analysis tool I am developing.

Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8f..ef19faedbfec 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -578,7 +578,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
-	kfree(data);
 }
 
 static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
-- 
2.43.0

