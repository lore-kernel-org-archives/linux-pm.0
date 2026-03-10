Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F333C52A
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124492; cv=none; b=XI3Ayp9aKx/JtszfdCYeNqnAt5T9NV/3MnAxtmXd/3xVMkLvzPL6dOv6yB5f1lUWACeR1IDuWLcuW5Vs0DTF0fGwRV5/jKy6bK1SYjFSVIT+48DkyEp/WxEI7nVsX4szAfDhuM4o3GRQmelXcOFd+B1j84qMRcVmh8pTsEvlq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124492; c=relaxed/simple;
	bh=FHDyAF9EFAwRXqOkNjanAFAqCUd0SWMg+w8X1BipR7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UO7zaBUrdVfTaCNyq6HEqX7XsEbYxea8sQaDyy+MnHTINKpQD8dbNBiJac79zU/R8tuMA+WqOUGx9AgR9lFBl8qrLesn1W4TGCDLUH7VOm/bRQoL7wGZHZC0Kbq3cRJIEiISCPFXAeofqf79te7MWVEbgI1hf4M2TIHXjeUlfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=frYggJxw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frYggJxw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae527552acso32049275ad.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773124491; x=1773729291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsWmnYan0uzVCIt1+g+hxRLBpOd+p/q+HdKX/vP4pgs=;
        b=frYggJxwgG8iwaq75ovRiMkhBUB7hoOwgcmuDHkcvU1DBE/8lBKyUBcvgCY3n+/GT+
         jBG1PjeOUWpDZtArQ4MQm970przpUXIDtcyklyFw15UnxeuiAWxPBkW5k/DWPms1JiBX
         JWuF4ytKQNGsmkHUThyEY8CuQQAyvKfNIn+lf/ltLmWKMw21AvkYOiUlAFZ8GeZr5KwO
         no5k1uNXm3mWcDeVlP/laQZHRnFBcNgT2PqHc/Y7e55EQAx2k2pWphaimGgrnxnHo/HS
         X/cP2J+t1qytmrD6LeEWSLyP4fhvBt54I3ULjr57LfemCiSUwtSm6ZKDTuy3lwrnP+YG
         U//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773124491; x=1773729291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsWmnYan0uzVCIt1+g+hxRLBpOd+p/q+HdKX/vP4pgs=;
        b=eMR0lKfnefqLTSueOwxU9B3UsUFgTC1wW8BBmxVhi/TNaEmNTx9mV1YBAMm+xL+Vyr
         UDNMuZbFLMAaGkYX5jGVAXogC4SKk4YwbklxIMbqNdI7HqH/uqbZ1kTi2DGOLEwFTgDH
         mPOx0QNnN6UVCBQHPk/tCTtE0SjGgi8J3TsEDzfV6nguhqKYy13iKn50bULqntS9sbBb
         sm1ZnQ0HG2USG9WIE/v3T/1lYGznyWrZ8VFwa3zxMAYS+YJUz1AYUmZ9HD9kKkcE+VFj
         NLEHoskcDP2MqFc/F4mc/munV5olb3ibDiddBN28a5ZctW04U7hIU38scsOJIrWOjq1N
         JRGg==
X-Gm-Message-State: AOJu0YysSDkubFrhlxwNw2mO5VSxPwzZ7maCIfI/7yWABIXtYCQw2v5W
	DrxZBfUGWt4UJC4/P2bl9Dc2byuQ631p0ttU8tK0xFXJ4VLABtbtO54WsffKVpkZSaQ=
X-Gm-Gg: ATEYQzxR2j74XudEGMU1+cp1NdpP2S0lU4gI4OVhZDOeDdfJS/5v3SLiLmYc64T1Zlr
	rn2IU0EPRNWiEkmO0PKXnFq87ZCE/rjYzlBgYpp4eFzWsA4/mt7KoOE96JsSlh9N3PNcKcCw+4W
	vFxZof15i2I9pNNoL8ZTaib3m12lExuMo0kJj0MKisQUAh2h4gbULUbrrmvBs4Ex/GNdXe91cf1
	z8RxfMiHyYiCbpfQfx7h05UL2oMQ04vII8LcsDapQN2pdFb6n2f5ucoCXaKmZQIb3W27cZb/3ms
	LkPxfARDLmhny+DtkkV1ndIiBPilZhCbpu5hFbDfBTqfjQ8KhTWxNoXQmACPGzzoMwf19DECzpq
	7wVWMQ2KOEF/4fSZ+qpDe6SaC095V4sXMBUbz77Xou2q40DP+g6DozFsacBKO7uCbj12Pu2Him3
	CASkuUEIW8cK2ozK8QhQ9mGX3p
X-Received: by 2002:a17:902:db09:b0:2ae:5a58:ec35 with SMTP id d9443c01a7336-2ae82532c8emr157306005ad.53.1773124490693;
        Mon, 09 Mar 2026 23:34:50 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9c965sm141258485ad.32.2026.03.09.23.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:34:49 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: conservative: Drop cached requested_freq
Date: Tue, 10 Mar 2026 12:04:42 +0530
Message-Id: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
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

Avoid this by dropping the cached requested_freq and using
policy->cur directly.

Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Lifeng Zheng, can you please give this a try and provide your Tested-by as well
?

 drivers/cpufreq/cpufreq_conservative.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index e0e847764511..c69577e4f941 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -14,7 +14,6 @@
 struct cs_policy_dbs_info {
 	struct policy_dbs_info policy_dbs;
 	unsigned int down_skip;
-	unsigned int requested_freq;
 };
 
 static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
@@ -59,10 +58,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
-	unsigned int requested_freq = dbs_info->requested_freq;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int load = dbs_update(policy);
+	unsigned int requested_freq = policy->cur;
 	unsigned int freq_step;
 
 	/*
@@ -72,16 +71,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 	if (cs_tuners->freq_step == 0)
 		goto out;
 
-	/*
-	 * If requested_freq is out of range, it is likely that the limits
-	 * changed in the meantime, so fall back to current frequency in that
-	 * case.
-	 */
-	if (requested_freq > policy->max || requested_freq < policy->min) {
-		requested_freq = policy->cur;
-		dbs_info->requested_freq = requested_freq;
-	}
-
 	freq_step = get_freq_step(cs_tuners, policy);
 
 	/*
@@ -113,7 +102,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 
 		__cpufreq_driver_target(policy, requested_freq,
 					CPUFREQ_RELATION_HE);
-		dbs_info->requested_freq = requested_freq;
 		goto out;
 	}
 
@@ -137,7 +125,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 
 		__cpufreq_driver_target(policy, requested_freq,
 					CPUFREQ_RELATION_LE);
-		dbs_info->requested_freq = requested_freq;
 	}
 
  out:
@@ -310,7 +297,6 @@ static void cs_start(struct cpufreq_policy *policy)
 	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
 	dbs_info->down_skip = 0;
-	dbs_info->requested_freq = policy->cur;
 }
 
 static struct dbs_governor cs_governor = {
-- 
2.31.1.272.g89b43f80a514

