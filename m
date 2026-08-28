Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9F3CB56B
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904321; cv=none; b=l2r6pr+vEKmHar7xYDynnCqBe3B/bHX3kSOJPIvkCJcQ5+rc9Nd9c1IM01FFSIj+M0duDm+ZcILjAmB1YrYdTAG7YDo7uJZ1fqYNW7+Pvss1pOjGAncE03W6BF2h5mHOeCtfUWdjJvLfTLEets1cfVltk/aj0UyuDtEkoKw8gMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904321; c=relaxed/simple;
	bh=Zuu639CNTuzVoE65g1kpKILchYG+xoS33tjcfcKYxwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puQw/7FcPYSKlA5tnnMi6X+sF/fyVEtsIRHfc037t7An9a+OLnPb0tLrQlhZW59sEdIcYdRmqWf8f6hh8o6kc2ldT6ilSCU8/GK2E5EbSG1q9DDg/nRkIVenO66zJCbdux0U3abXXefoHpLIGXut3V+tcg0QXQzXCNpVtTn/Oo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so295702a91.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 01:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787904318; x=1788509118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtUAFZXh+ySgplVG7Wug/753+iyCW727Wt4S0li7blM=;
        b=iJw7k4k0TkCq4bq10aLBCMXpSFDdk3o30+rk8qtKY3fCjn8tI7Ylw3TWqJkGqU2ac3
         INNQQGkLYCwxbay8p4Y8iPzbEBgcWsCYv3Z7KZAmSqCeahoPiE+AqHJkWtCisZv9fI/U
         lN+uhZNQqdJWEcWzvCeD6PpmqHBKpLtrwmUMk/GYST4p+xIbDmJRqhjYG5BThrMMg3sw
         KrESmDUePyI9e2NpNcWlg0wjcG6ReIfva6BtM/zaTG6BevsQow+D12l+8GPakAjI98Xd
         5IkMOe0LfSKznC/gzpwVvL2BjJhh5tqX20JeA5Kf60ImoWG67INcQoFgF0oMT7oC19Y7
         jpqw==
X-Gm-Message-State: AFuF++kNRuXT3GU8Kq5/gJyC/Ri5pZ/vwaoE+L5tw1+5SwMn1/gZp6U3
	qhyKcL4eiJPAwTxwbmkiS5JbKXTz4gni9MXkLGGyLp4JXiZlLMPk1wqz
X-Gm-Gg: AR+sD11jWGIegSyduSLLPpkNH6EX1yDDEGNrztBd4cVM7U0w0dmLWG8Ofhhfmbrhv1X
	H77dVCP/KJM/zlqD05jGvCwOWi1rBzaipSchDSRLuYqtLXDJMso+qrVC7UHvy+5rHBsx54TQYO6
	gBhKh7oJkIQNMFtvjHquB3tv5HdTVjgpAMUkro6ZdjAuOZvUSwdZurS5ZdBkyalU0nZagAH2QB7
	UsQvIw8zvNoPDrHXnPjpy6PCRPX0rTua3TlnPpb9LYSIkIraM4gHovG7OGgWktEIMqsJsCNE55Z
	l9XsjtHzpAn9V9wBrJVNEaNU/sKiXD21aJrMo2mGDR+yxASG4f0U8DVb3YL6qYBuod1Omhtoqp4
	cYxocX6vGcYQRUNVxIo0M2REUiK+tt6c87EDXKt74W8ttTHyHfjN2IRKtocVI3t3R7KMC8FcdwC
	vpJbcEZhbpDE44VnLYsadBS4mKHHMaHU+Pta63J27SdmZQOhgeGG8a5zruyhbxF0h47SUU884OF
	zZ98yzwOQ==
X-Received: by 2002:a17:90b:3d4f:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-396d0ed9e0bmr11452791a91.11.1787904318296;
        Fri, 28 Aug 2026 01:05:18 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58d51sm1492039a91.15.2026.08.28.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:05:17 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] cpufreq: sparc-us2e: fix frequency table index copy-paste error
Date: Fri, 28 Aug 2026 15:56:49 +0800
Message-ID: <20260828075649.2728795-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In us2e_freq_cpu_init(), the last three writes to the frequency table
all use index [2] instead of [2], [3], [4] respectively.  This is a
copy-paste error where the index was not incremented, causing the
divider-6 and divider-8 entries to overwrite the already-written
divider-4 entry.

As a result, only three frequency steps (div 1, 2, and 8) are actually
available to the cpufreq core, while the intended dividers 4 and 6 are
silently lost.  The struct us2e_freq_percpu_info::table[6] has room for
5 entries plus a terminator, matching the 5 hardware dividers.

Fix the indices so all five frequency steps are correctly populated:
table[0]=div1, table[1]=div2, table[2]=div4, table[3]=div6,
table[4]=div8, table[5]=TABLE_END.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index a68706406b88..5cda391ad03b 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -282,12 +282,11 @@ static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	table[1].frequency = clock_tick / 2;
 	table[2].driver_data = 2;
 	table[2].frequency = clock_tick / 4;
-	table[2].driver_data = 3;
-	table[2].frequency = clock_tick / 6;
-	table[2].driver_data = 4;
-	table[2].frequency = clock_tick / 8;
-	table[2].driver_data = 5;
-	table[3].frequency = CPUFREQ_TABLE_END;
+	table[3].driver_data = 3;
+	table[3].frequency = clock_tick / 6;
+	table[4].driver_data = 4;
+	table[4].frequency = clock_tick / 8;
+	table[5].frequency = CPUFREQ_TABLE_END;
 
 	policy->cpuinfo.transition_latency = 0;
 	policy->cur = clock_tick;
-- 
2.43.0

