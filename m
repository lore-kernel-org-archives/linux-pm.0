Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77271B6CE9
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423579; cv=none; b=OiD+13IM+ExmYiziEd0q4l2XyRYyMHKDmi3lB3X+bNOASg0frnptudsjWLrPcqPTBA2yV80yweVeHOv+6dDIGWqqJ4/Y0EMkZ6KaUGmrp2bDR2JHs2VJvphDz4RkeygDeh1f2Av1iijPVk0KYRUB1hs1L0+rDpwPIAXbrP9/2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423579; c=relaxed/simple;
	bh=Our/gfkfRbhQdh2DDIlx11+pI9CmQ6fn4czDbJq0OMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iua6hcDCzRYFhl83Y8uGmXu2Mrr5yHmHrw/Z/roYNUTdP2uUtrtI9XfvrI8645Yc4JJ/Ea7NYxEdd8zjZ+OeJOCnreXep1XpJZ2tm4Y7MwJMdldqQwOoew/dxm9RxlEvCID/8aLBqDIGk4NbDSOLlsGAu8oLg0p28ZbB8+/Z34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n05PqfGP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n05PqfGP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so3538719b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 21:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779423572; x=1780028372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1RSHyMXOLN00W1XKagDrGlcaq3EJ8WQKXscx0rEp7A=;
        b=n05PqfGPr09L07tK27Yu1c7wom2bYYq+cvt22fpt8rX25jtvp/IvMeuVh1T1UELFU1
         fKgFwVZKcr5oqZQkNUhig5aaA4LXo0InoPLncV3HTPsnPOI0b8XrwqrSTj7gxVbCI1Sa
         +DC++QR4zbD4dD0XMGslfGbRIgqbDnnkDJbT7uP4qgLU2/h7BPZ9nxxOBPJRbCCyfpkV
         SuQNX/DqE4AWtouWMyx61UOgLtnqTP8lqhF30VNZBORCxq4rygAwoXCtPHK7fsFBnvni
         H4+lORVkLFiX9ITF9Iai4ypsY4w8LK04jrfOlsJQjpIYJEN4arudBnC16/KOWP9qAYuy
         1XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779423572; x=1780028372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1RSHyMXOLN00W1XKagDrGlcaq3EJ8WQKXscx0rEp7A=;
        b=lsjyuMd5LLS9mJTphCjPpk3dFcuN8IU31bLUo7/edNgBAC8sUTPPKvICLYsogdA5dM
         Ut/4NcQ8zawhUohicZSjGjpmCYuHsMD6OS5FCeMSPLayTfhpZGalM2KoJgSyvhjrAsAu
         usYEYWyJfFtEZ1Fg/KCTL/FlBJbMAq+Y/ezQjhAdpc/LDlCvuFFxOs8xk60xgn0/h40V
         Aa7/F/XBZtUlAE7ebWvsjw9x0c4dOIsfqEPKqGy7J7s8/Fs3E4N7L4q40CuvqnXEKQgD
         cQskrlCn0/dCAAAuFdnAER9a4RrzQ0jzhfLFM45uGsTcr/vwuh9vNAvMxXmF9oVlzVHZ
         8R5A==
X-Gm-Message-State: AOJu0YydOc1cQJpDJhHwbrB8mOq7ND2X7u9qSD3z68eezkB6f3zso9Dt
	G5gGC51JALW0J9Bc3P/CUxx7EEJmNl9iJc0043DNi5E9gTrhplVU6OJrnN82i6wOHRA=
X-Gm-Gg: Acq92OE/V4osYkliHRFdJd6YAjrfPrSlkd47MelHlHZQy4O5LrqNIbG4lyNfXgzaLph
	rqx7TgrqFhUCYG8L3pakuuJdXRJJWCvCNG6HlB+0Th/cy98nSpjABg9OlgAHoJCSw1HJpNdpVnI
	u0hY59R7nJDdFa6b4ydGbBZG1jLccTU3BXi9FHMMiShbzx2sV+odrPRYIAtcrrGhuimcTRbJ0Xc
	V9S2zTEuCfyWVNe1KZMJUiGKWb2vJVYqTSwdo23jLArjQwPSPmFsFEUpkRgz1aHOIbqYLSZdpSd
	fq4y0niuOoQQJCdf1J9MmKkLTwfnf01g735ABqvk/stur/TB9bNKoaMtGhYvDIkhxls7PvNA+K5
	BJCMAwzK/15+jueLHtA1blgJ+UPaijOOZDcerr+yiFVkNtD7U9SZFwpYofZ3BVy/PcDHCFAC0EG
	sxqJOcsf+2ifG0/PITbRoDLRQ=
X-Received: by 2002:a05:6a00:1d9b:b0:837:f79d:909 with SMTP id d2e1a72fcca58-8415f5459f4mr2150184b3a.39.1779423572261;
        Thu, 21 May 2026 21:19:32 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9df3sm529288b3a.9.2026.05.21.21.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 21:19:31 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stratos Karafotis <stratosk@semaphore.gr>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] cpufreq: conservative: Simplify frequency limit handling
Date: Fri, 22 May 2026 09:49:10 +0530
Message-Id: <292e6d937890f135e30ec0d2107eaad47cb9a976.1779423281.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1779423281.git.viresh.kumar@linaro.org>
References: <cover.1779423281.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lifeng Zheng <zhenglifeng1@huawei.com>

cs_dbs_update() performs explicit checks against policy->min/max
before updating the target frequency. These checks are redundant as
__cpufreq_driver_target() already clamps the requested frequency to
the valid policy limits.

Remove the unnecessary boundary checks and simplify the update logic.

This also fixes an issue introduced by commit 00bfe05889e9 ("cpufreq:
conservative: Decrease frequency faster for deferred updates"), where
stale target comparisons could cause frequency updates to be skipped
entirely after deferred adjustments.

Closes: https://lore.kernel.org/all/20260421123545.1745998-1-zhenglifeng1@huawei.com/
Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index df01d33993d8..0b32ae28ec85 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -103,10 +103,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 	if (load > dbs_data->up_threshold) {
 		dbs_info->down_skip = 0;
 
-		/* if we are already at full speed then break out early */
-		if (requested_freq == policy->max)
-			goto out;
-
 		requested_freq += freq_step;
 		if (requested_freq > policy->max)
 			requested_freq = policy->max;
@@ -124,13 +120,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 
 	/* Check for frequency decrease */
 	if (load < cs_tuners->down_threshold) {
-		/*
-		 * if we cannot reduce the frequency anymore, break out early
-		 */
-		if (requested_freq == policy->min)
-			goto out;
-
-		if (requested_freq > freq_step)
+		if (requested_freq > policy->min + freq_step)
 			requested_freq -= freq_step;
 		else
 			requested_freq = policy->min;
-- 
2.31.1.272.g89b43f80a514

