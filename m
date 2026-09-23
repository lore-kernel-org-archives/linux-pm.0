Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA113C1D4D
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146460; cv=none; b=P+BqaTxNDm5PT5RgJZcWWrP4qQ/E75paEBAULVMSk3nmFAVuisQZ4A4RPTz49hQyJ+Uo0LqeWJzVHiDgQW/mM/aDgM+VWn+N0pyPk05Z1FC9PO/oUOs8NNCJARZUnb/XI1SGFNwa/LWROQKwv96NzmVS2Ph4g7Okk1I8ah403dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146460; c=relaxed/simple;
	bh=ub9lmV/vJgIvt/52cHA9hak78+wXdVZ+Y0e9MlYNLQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPAKpyXMlO/cjATBPSKNcRTWn9bXsnH5pkWMCxZbqhfugBh+uj8lxhx4ORBjlhO/DZ+0Mpsg6AQkMKMTB1PNOZEG5npN7E31usfB9B5blTvwyCHjUdNHhaQZX5DHVe5WxJLlrwb3HfYeubWINKMEcXKlYzqaNHwxPUFYGDLMp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRDZBxYA; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRDZBxYA"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so444617a91.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790146455; x=1790751255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBPFJ7pxrxjtZgenSu8SvKuqY5moK00ZFB2fToeyYWc=;
        b=NRDZBxYAy2bPOWNeTf5QXaE/7XzsdGjWfJLlNnNvz6ifxZM9DD6f7z97XheeW0xr0i
         MzTKfFyh7LE1X6AOzvlkV83TJRVpqFvq3Ph/8poL+sTmzvY4DilZhplT6Z+umr4aTmy5
         4VWLwoItw8L1qg0UFBriZi07FdvvAQlb5DFwTYMWvwbFfrAGuWwxFKCKO42iI50duK7N
         j0AGEk7Tga0SjpPa/wsL8Pn+CX2+mi8lb8LWpNUAvFLWIMwZ7Q9k9gpurKLQZQaTs91R
         AqEBx2iBdiDrbWm4ryBsGp/zh44/UWofiEa5776aKh12EAfqWT9iXAezNTipSL+hsli3
         vrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790146455; x=1790751255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBPFJ7pxrxjtZgenSu8SvKuqY5moK00ZFB2fToeyYWc=;
        b=xUgnr3biHBrbjSR/4QquadEhLWO44ny4+d09movDC1UloVoLw421CPZpMWOUhwH6Lr
         wLL51f0Mct1MC/ArDc2nFGVfWq3zKA4mC4t58toxqiITr8B76TpVtvkLTrw4tmA6nIs8
         yNcHFZ4jb7YM0Rps37uOH4N5UcBvct2KKhdX/5IXakCMYiMs8UkKSW+3fVQX1caIpBLm
         zBFUL5MR6zUMAT5OgdxWGPTVfXnM3WmLkGKQy8DHOJXFApBIsuUa0ZVp1qRZexzzN6NO
         G0PiAJ8OwQyaGZjuouy2Y2KnGgPIAZC4N32AQaYdSF/6fLT0HDidFxtz1eGMSNu9HUt2
         dDPw==
X-Forwarded-Encrypted: i=1; AKwUvBwS70/aW0aw6HEXFYN2OZrIStBvTviR2pAlXgFay2QUdwJSDY5U7/LzGPxHIA+hl/Ev4SrFlP6pRQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kFgY1uFoHHRWelItecjinFV+AN3yO/lj/YVOahYIXTTv8HzVNM
	wtB4XyxpSVjD5F7siDakBZbJDhNqOMhXfyveFemvRRVHPcPy9740EFTo
X-Gm-Gg: AYBFou09tKHfJs2c8+nW3pxaOmAe/5NfE2FV6Pi8rGzgmUwKqYG1Fv4aujiVj3378uP
	dxYKLIzXbr1W3UyaYvhWKEayNK1F/k+9qtxUm9MjU6WpXzbFVVnEAfBphEJvZP3ljLE0JovkSeg
	EPKLYHSa7Uc7Vs8ZqwAUuHHiDc0t/3VCPlfGKAtQuhsFhzXMwTi2yS+FaQ39Dgbth7c0lZtXeC+
	Poehy1THZyCqLSSsgmor0FeqApyp/N8TbBJPZISjefykfeCDVxzIJk69VYiszdV5o1ILHsmhr4u
	1u1uNmd6UHo75GutP7LUqJolmPu6+Ig5xH708jV+Z+0j3N8uAk4OKR1ZLnmobnJ9WGFDKicVDfm
	ETiYrj6bY9aZsb1BF7xk/Axi0RCC6kXZB7u1YpLU3Lueux6kPu4GhMRuvc1rtatUPBEjbcgaqzn
	PcyzyQflyICQ+mWuq4MvcojXyidqCLN1njPyKu9zV6U+0OGiuU6A/aWuPTLRdkJA772AIlQ2Qh8
	rWP+DQbYmlh
X-Received: by 2002:a17:90b:3d8e:b0:39d:c3bb:98e7 with SMTP id 98e67ed59e1d1-3a07e568935mr1435549a91.6.1790146455101;
        Tue, 22 Sep 2026 23:54:15 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc2b2fdsm3321787a91.12.2026.09.22.23.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:54:14 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/13] sched/fair: Remove magic hardcoded margin in fits_capacity()
Date: Wed, 23 Sep 2026 14:54:06 +0800
Message-ID: <20260923065407.3451520-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504020003.71306-5-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io> <20260504020003.71306-5-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 05/04/26 02:59, Qais Yousef wrote:
> -#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
> +static inline bool fits_capacity(unsigned long util, int cpu)
> +{
> +	return util < cpu_rq(cpu)->fits_capacity_threshold;
> +}

This does not hold on current tip anymore: fits_capacity() has picked up
a second caller that does not pass a capacity, and the new signature
accepts it silently.

kernel/sched/fair.c, invalid_llc_nr():

	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads),
			(scale * per_cpu(sd_llc_size, cpu)));

The second argument is a scaled count of the CPUs in an LLC. sd_llc_size
is a per-CPU int and scale is an int, so the product binds to the new @cpu
parameter with no conversion and no warning, and the test becomes

	cpu_rq(scale * per_cpu(sd_llc_size, cpu))->fits_capacity_threshold

With the defaults (CONFIG_SCHED_CACHE=y, sysctl_sched_cache_user=1,
llc_aggr_tolerance=1) scale is 1, so this is cpu_rq(sd_llc_size), which is
not a valid CPU id on a machine with a single LLC. invalid_llc_nr() is
called from account_mm_sched(), task_cache_work() and
can_migrate_llc_task().

Separating the two uses first makes 04/13 safe to apply. Something like
the below, against tip/sched/urgent (3cb0243767fd, where the cache-aware
fixes have just landed; sched/core still has the older mm->sc_stat form).
It is a no functional change, since x * 1280 < y * 1024 is equivalent to
x * 100 < y * 80. Built with CONFIG_SCHED_CACHE=y and =n, no new warnings.

I can post it as a standalone patch if you would rather not carry it in
the series.

---
 kernel/sched/fair.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5cdde4..97ce56fcaf85 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1526,6 +1526,21 @@ static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
 	return false;
 }
 
+/*
+ * The margin used when comparing the number of a process' active threads
+ * with the number of CPUs in an LLC.
+ *
+ * Mirrors the ~20% margin of fits_capacity(), but is kept separate because
+ * fits_capacity() describes a utilization versus CPU capacity relation,
+ * which this is not.
+ *
+ * (default: ~80% of the LLC's CPUs)
+ */
+static inline bool fits_llc_nr(u64 nr_threads, unsigned int nr_cpus)
+{
+	return nr_threads * 100 < (u64)nr_cpus * 80;
+}
+
 static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
 			   int cpu)
 {
@@ -1542,8 +1557,8 @@ static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
 	if (scale == INT_MAX)
 		return false;
 
-	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads),
-			(scale * per_cpu(sd_llc_size, cpu)));
+	return !fits_llc_nr(READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads,
+			    scale * per_cpu(sd_llc_size, cpu));
 }
 
 /*
