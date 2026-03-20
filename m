Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D802E8B64
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999505; cv=none; b=n+J75z1LuqTa2+VWd4Zbbd8l+eag1EPjp3ZFZN4OaOOU7QkzkAO9DRSxGzcQLs7EbKO4buEqaRZwCxssYcgI2WFePrnIxzfNDGsFUqklQSJuM+1vU5B8D8khU/zcCCiOED5I64/sdDrSGJOL2F5nQ6c/btmCIKg7KkX+nC2RQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999505; c=relaxed/simple;
	bh=2YCuEty2unv7N8a/bv0AHivwyDfA6N+PF5ZTIGgY3po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/E4hwqf9QfmN8YKZzVVCzX/CghKof9vx1Jetvo4dSyY684ws7quA0DbcYg4Y8beHC+wSE/tS8BZuc6c5MkPvuoPza34/fm0wKpTSU8+av3yTbucp1j+OWf2IXVKyU/ioi/8Wm1zCRONZ9iAhngE7JfR3d9KdsljDdIYc9cnHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dO7RKIhK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dO7RKIhK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad21f437eeso15557665ad.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773999504; x=1774604304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQasu/xrnIk8QOOWcGsoDHIKa5Hw9PFKHEZ6nnxa6ME=;
        b=dO7RKIhKRoy3Xx7xlqS1MJahw48mmfdFVPT3fZ/rTC37Pnqn/beiPaps75ysAau9Hf
         B1NHewdaWOCRkr2cXhVS3gsgXD1CfdbicrC8vLzwYIzJ+f6PyLNBL4KgMVNd0BlLEyR+
         vCDreZO2fbMy8lQNLc12VFt+T3+dVScvEAkavraRmZDfQEqrnancuuZLAYmp6UpeBYZB
         JfcRes9aPv5t5wmM4pmTNb+d1vFWCveE35X2JfExNBKKhV7t6moxKdIr0KNHHpboTBLL
         G31LNbWM4bESeNEqTbhr5ArRB7rk3BiQKXKEpsFw6FV+t6ylHPkxKPVGD4dw8b2Nryka
         JZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999504; x=1774604304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQasu/xrnIk8QOOWcGsoDHIKa5Hw9PFKHEZ6nnxa6ME=;
        b=bRvuHFpvM3KlD3urQ6A4ZewyJVuv2exxe1LFV2grrNo4Zfx5OeEl6bIHPtI/ZXYCwb
         zjhKB6rbahx793ebuVGFwUs/d2et3F1t2kjqZTTRNxi62hL+Q0bOB7U3vg6pMlFkBDFI
         Qe0QcmPV2wfLWnNC7Jw1cy86V3alpjAJfVcJWJJ6uVUMci0WIi02Ql8DKeOy1no3eEgO
         VUzfzchtqq0QGbZ56ZyjPzSpw5E9Mm39c3m9mpuhwoblLXV93Vc+/7GmG6VqRYRVRtEm
         XPYUQyVZ7XcAXYrid1uSK6FftbORrRwlgNeiX22LygQeU27ODJzy4p3jdzwNjt1khU56
         d4YA==
X-Gm-Message-State: AOJu0Yyzg8CLwNh5UhRYzuRzEU8VZupiheymSmiuSk/28C1fukRms4xC
	VZyzO/H1uiqyku8uWLJ/olK6D4y4esQHm5eMFcn4dCd5mBYX3jISRdJ1di16+DEsv+U=
X-Gm-Gg: ATEYQzwC+O0Zmy81zShQhQTf20tWk8j1MxYj7YX8+6f/EUhYPrb6vgi61kWdje44rS6
	Wgx7T0cX6ei6lbkB6JND0HJk6HEWXmtqlROiKOuOFVuM/RiOE5HtFgzsIzAap7n9wp5DgCvO49I
	Ieb/gQjoz99n1ODsiENUPQd46ow3wPaehpEoe+lyFzaWP1OWt2px0EApn+a2PEBNEuY9+17YwnC
	Wh1FK6F0+LEcus2jNg7BGQ972DzW4n04oEATdBiuZVRVo+HCAHPKVRapRkn/2gp+UvLTqmxzGCZ
	mP/7eXc1l/J5UdNQD6MbJI06zbKb50gwamBO+olFkCHGx1DP+5nOAZ9VI6ibXsOQ0REF9VWe4wf
	P8YxfW80iyPetNsJ61N3spNZJb5+40Nl9Oqc2sApfCqPvGAZybGU54v8hJajww/C0L8OAzacB7J
	eV95mIMnz0J0ve1A8qz6Qf7ys7GYaJuqdC8r0=
X-Received: by 2002:a17:902:d2c9:b0:2b0:52dc:f1c1 with SMTP id d9443c01a7336-2b0827bd48fmr20166035ad.16.1773999503526;
        Fri, 20 Mar 2026 02:38:23 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b5dsm23012515ad.52.2026.03.20.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:38:22 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: conservative: Reset requested_freq on limits change
Date: Fri, 20 Mar 2026 15:08:14 +0530
Message-Id: <d846a141a98ac0482f20560fcd7525c0f0ec2f30.1773999467.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recently reported issue highlighted that the cached requested_freq
is not guaranteed to stay in sync with policy->cur. If the platform
changes the actual CPU frequency after the governor sets one (e.g.
due to platform-specific frequency scaling) and a re-sync occurs
later, policy->cur may diverge from requested_freq.

This can lead to incorrect behavior in the conservative governor.
For example, the governor may assume the CPU is already running at
the maximum frequency and skip further increases even though there
is still headroom.

Avoid this by resetting the cached requested_freq to policy->cur on
detecting a change in policy limits.

Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
[v2]
- Completely different design to solve the problem.

 drivers/cpufreq/cpufreq_conservative.c | 12 ++++++++++++
 drivers/cpufreq/cpufreq_governor.c     |  3 +++
 drivers/cpufreq/cpufreq_governor.h     |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index e0e847764511..df01d33993d8 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy)
 	dbs_info->requested_freq = policy->cur;
 }
 
+static void cs_limits(struct cpufreq_policy *policy)
+{
+	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
+
+	/*
+	 * The limits have changed, so may have the current frequency. Reset
+	 * requested_freq to avoid any unintended outcomes due to the mismatch.
+	 */
+	dbs_info->requested_freq = policy->cur;
+}
+
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
 	.kobj_type = { .default_groups = cs_groups },
@@ -322,6 +333,7 @@ static struct dbs_governor cs_governor = {
 	.init = cs_init,
 	.exit = cs_exit,
 	.start = cs_start,
+	.limits = cs_limits,
 };
 
 #define CPU_FREQ_GOV_CONSERVATIVE	(cs_governor.gov)
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 36eb7aee4bcd..acf101878733 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
 
 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs;
 
 	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
@@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 	mutex_lock(&policy_dbs->update_mutex);
 	cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
+	if (gov->limits)
+		gov->limits(policy);
 	mutex_unlock(&policy_dbs->update_mutex);
 
 out:
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 168c23fd7fca..1462d59277bd 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -138,6 +138,7 @@ struct dbs_governor {
 	int (*init)(struct dbs_data *dbs_data);
 	void (*exit)(struct dbs_data *dbs_data);
 	void (*start)(struct cpufreq_policy *policy);
+	void (*limits)(struct cpufreq_policy *policy);
 };
 
 static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)
-- 
2.31.1.272.g89b43f80a514

