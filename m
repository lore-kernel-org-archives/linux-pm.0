Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C235E95A
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011557; cv=none; b=UmP/KB5Z9nzLRdjMCou9iaEZNaLn3ysEBDFk9qqvpIZIvzGevxLcH4YfGeYZVGPdL3ahotIhqfmjgq7z9CrTBP2XSzbPf/KFTqiVfIJ8pf1esC2zwIyiVZeQd35hfMBxsL7y4IxFf2WC8bw2Tp2zZGDbmiDOQCOJscvTyjcx2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011557; c=relaxed/simple;
	bh=5rqZFu4m0DhI2LCQIRiD6LzWwdcNiXgBJGJBIxfmWzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcSu5gPXH5FEOIn+77H+Ld5H98h5G99HnzwEc9dN0PYarOY3W9Moy1i07AUQG3qG3IHd1Cf3imQgef8MxIoVXKMYVU0UFnwxZsLPKf3EXi+Znc8gRMMgSB0riY8CrqHUNY2Wr6d79ngXQfQx7OxkSXIq51bL3FNs8NwfLCZgw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbDlBhbU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbDlBhbU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2627814a91.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 19:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775011546; x=1775616346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0AMRHVKUvntR7Icz/Ehum0LT86VVv3YWOGS3oQyg8k=;
        b=NbDlBhbUmm7ubGPH3omzSFJPvC1KYng04JkvHBvP3dHNAkq7Nuy1IumMShbzu+cJ5C
         E571R/G6mSuSyy1rPwBDiTP+dGaUJ3NhWV6MjSGqP7z9tUOgi+4Sqk6BvHFUahB8wfrH
         LH6iW3GdFEzzaDhZneuE+SuWoHBzr0wE6h8cbSd6iDr0XzUNbd/feqdu9B67xgFY/aQ7
         PE3x7umuOQHgx1ZfODfuDFGpNdh3Qir9Wx7rR8Kjajzlwh4jkv/k6dC9oYynWYcQBSC0
         xBHpSXjzd7LPf/2pN8xDi9K1qSD+IPtt+5pZpzpNgE93kTJD5kE9GXn7mP19W3J1Ewbh
         ygOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011546; x=1775616346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0AMRHVKUvntR7Icz/Ehum0LT86VVv3YWOGS3oQyg8k=;
        b=pUAdqvLB81huy1ku/bk6AIexa/NuMJ2sDEQ98pYu348UiYbeB0Fu/9eyiY4djXNf+a
         ocGicagrpiqH0QUgXWYPiheRKoJ/lYhgIOalKj2CAKUte0KnfK288i7/juvGa8jBdanP
         vSxDXqi9WuQ8nggIUR/6LPTzhNcXsgbxi+0snn8oHdel0GwiLtqn1JxNdInmD2cHIsme
         i7JcnbAsqk5w6LiIsGyWzxPIA9Q5f0nLlkcKfe1KVvh1H7JDB6rCPRp/+940z7dYtJAF
         qwG5ao9M6KgoYn+cNUXesptW+elKEYqBx8c8r1qA+2QqpYadsJBA5Gfge7rJf2jcFDum
         JLCg==
X-Forwarded-Encrypted: i=1; AJvYcCWq99r/q9xt1pZblUKPVYyQWPfS7BxkfYVlK+gRhpe98D1gkXAJLNOod9WbW/zhcQg9yLS9SXfBiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKB8EWZhpQy7OIW2vJs2kMLRrWNBGzHVAC0HP6cpAm7pQq49WD
	qBLxwL5h5zlSP122Nb86H3OAtShkKhOMFjC3N2GYUn4eGQvB/73EcDfw
X-Gm-Gg: ATEYQzyafQzfZpIaTYkTT027w3F4ecTtiQYqODpjxSTt045QLB+GWxJUlF7Pkmsm++s
	2sKP1hnU+A36KSegZXqb9yAo5OQ2WPovq04ScTUI824wgyDJTFVsC80Wg9lUZ3OZ3OmjWlZesWa
	E7zPVDPTdU6EIhzymVFhqz/FHQZg8A6LI8x8eY9RB+FQaMODTGcVrWjcYlmlqv98/c+zfIzQAcW
	algzIiM9XgeMMazmVQN68+EUVsWmqkCuTb+gKmzMmywtw4srs/YrCRY04rhaJvSP+S4RsMc5izB
	uMWv520PhodFLjZCGr06oUx28q3q1gLYureggbKkfzo6piQS01EiJgl0vkhH9we72bj8Ue02a1q
	TSgyVEoG4FfJD4G3bregqT+Lz3qpWQJWP7jqT3TjUk5a1QsC9Cxplj8gzBD7KvswbrGuX9VEpDg
	mpARmWu79cwxHLzUU=
X-Received: by 2002:a17:90b:3f8f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35dc6f7feacmr1597549a91.21.1775011546230;
        Tue, 31 Mar 2026 19:45:46 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba590d49sm1572450a91.2.2026.03.31.19.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:45:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Tobin C. Harding" <tobin@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path
Date: Wed,  1 Apr 2026 10:45:35 +0800
Message-ID: <20260401024535.1395801-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
kobject_put(&dbs_data->attr_set.kobj).

The kobject release callback cpufreq_dbs_data_release() calls
gov->exit(dbs_data) and kfree(dbs_data), but the current error path
then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
double free.

Keep the direct kfree(dbs_data) for the gov->init() failure path, but
after kobject_init_and_add() has been called, let kobject_put() handle
the cleanup through cpufreq_dbs_data_release().

Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1a7fcaf39cc9..3ad51a986781 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -468,13 +468,13 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	/* Failure, so roll back. */
 	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
 
-	kobject_put(&dbs_data->attr_set.kobj);
-
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
-	gov->exit(dbs_data);
+
+	kobject_put(&dbs_data->attr_set.kobj);
+	goto free_policy_dbs_info;
 
 free_dbs_data:
 	kfree(dbs_data);
-- 
2.43.0

