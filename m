Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF4463B6A
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304392; cv=pass; b=kMlZiizqEu0OcOKc3sJ01FsjRuxbUfma3Vnlbl4pzB05Qddvw11XDNluOgjf5k9SbOLGMzDu1vlk4vK12a6r4GyT0ZzxNUK9j/xdfaAPDt3q9OZguChR8RUg4AIeqFbkOJUSc+EAvbWEHbA4vF7G5eumTWmMoXozdHeD55Kvv8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304392; c=relaxed/simple;
	bh=hSsh9shPC+8zyN41uAbGJXso9bz6zuixcFGzucZkpfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfCSAUfZaVn7Lwyvnmnp1797K6WKzcVtIgk+mibF+Cq9S2j4fKtoaliqv3DmGzrB/uQYg310bUi0S6CohJvdzjdcI8N14ToTEf16ZvCaMEHb9J9DrCgdywt1gfXWIdJPOqUxQ6WNyy3zRaLhk/p5xH3wIsFME+vwCiCRtUn89tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KaLCFi56; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaLCFi56"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so1383011a12.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 02:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787304381; cv=none;
        d=google.com; s=arc-20260327;
        b=iPzSvbt1gwa7oL3ouBxZgiIebjdg6Be29T3e8RXByuBZuWF9ogrcoVGsR1+MO9XkId
         dAiHkGv5WrOKXfgoLq0bp8Dc0uwwCBxAFdezaoB0zANoQZl7U4Q/Mq0DymtnHuud9AGu
         31N8581feSXiNb83LucyJK9Cnnnft+txBLkIfGm4UNJzwG9Lp6Ng0aAcn7HH6fpkMlEF
         CRDxzBrU9oY8lawaZNdTcAH49rB7XImZ5zcqojF89lK2A/2cxqZM598GGID+g7aeJjnF
         Yr7r7MGbVTbpar2PgrUS6Ubhj2ln6NxiW53UCebosCCwcVR/tmSygBNaB/TlOi4kn2un
         WBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Eza+T3BtDv3vto6aplpVZui5PJgLGreuoA4FewSDT50=;
        fh=fae/P4TxxiVbFgD34jpG+2KR4YwhkriLdlSUuLtlFGg=;
        b=BTQk5hi63KA7N6FyI6kJErG0sWTNUiIne89MFRiVtWrOUCJz0Amj2Jsa3uqskX1Q2v
         v9KM76I2Wi4vIywO+iIlPHflcRRXnef5e8RhDRfLo/X9TQxL0Yh+QDJFUbGN+HWwVVl0
         RpdBb/QdBHA/MIoArA0PZKHYWkck/uJP7Q/2dcnAxcJ01+hshvy7FZgICGZy/4wwywpd
         1r/2iE3wOijHzwM7eERj6/mqWxmmrpybvtbjCXWgrWsN29S71fKcKer32T/cBbGMdOkN
         XdhFYDiRNwd5SQyFI7tMyGl1cgCekSZLzJB03O9ejHAG0IQupNzw9lMVPxGrIDXIRZvy
         GvNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787304381; x=1787909181; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eza+T3BtDv3vto6aplpVZui5PJgLGreuoA4FewSDT50=;
        b=KaLCFi56l8gbYf7wgrvWIa12czXoz4fj3lOKMnVEFjebRh65b58ufSEw+ouOfxknSj
         65mUCl/5aEVsqo3BwFvKSkHQ4D2tCikgGikyOPD1Q7ZTJWC83128fO1+7c4G9p83p+15
         hsNQnirWRzUmy25O1nIFtm7aP/lHiDVou3ukEhUKell2mG1DfLzeRe7N1XoEv2FCAZWi
         1pdu5GYIHY0q7cq990asGqI+CzmzHbtfLO8FnhNVCIur3oTetv/NGxDqbrkI1rfnI27H
         GnzeRPsjqTOXUHf7bmpjVyLwf/aFfyG/aQihhKh3nkysoIv16YOnZ0TJZEkMqTMVmjBU
         IZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787304381; x=1787909181;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eza+T3BtDv3vto6aplpVZui5PJgLGreuoA4FewSDT50=;
        b=JeEkS2ZVd5zqQ2UWrNMBzoxrukwC6SkNBLUf4s/zk2bSunsr55zrKkCiY7PTGFVxVw
         TnxBzUDdDZYfoUhoZNUeNGKdG/iNvuIS+++7K2bLmmZQ29ZC6UQYmIi5ieVZRueg9YpI
         8cbyGby5UBntLZstW724PMk0ARyjhvgwNrA43He5VqDulv+1yfC8Y68NwI5KtrNwyPCW
         /7+FadJ/9I1Tnu32CzpeAGCPu4oEkapnLIoPUt7EIZobT9bOwfuUu/+3EHVJNzNoI7Nd
         xJ/Wm5Pt2vjCvsny2cxRbwUZ9Ar+dbbRGSDJ3QNdlXWF6u3zmJYSP4MaMsfROYn7ZEEP
         LqgA==
X-Forwarded-Encrypted: i=1; AHgh+RqunR1pDAiSpKdYNjeF5+0AsLr/pzYc355SARK8w024qeSCcq1NbfJ1wQoTeJBe3dlosyxx4MqYzg==@vger.kernel.org
X-Gm-Message-State: AFuF++mpp0xlqh4P9yD2BYe+JKPnxwE4BO/9J3fLE4nJTr3Uxs67xn0O
	dezFW5q5aOT8rWZWsRYu/kJJ3vq3Acx4RYDsaCVTADZkpXm0u4VIXFMUkdccCJAkLk27E9mU7qu
	i5hD0PgHaHjdwDx+pGr5vuTSxpCmghYWRlPbpiAxqXg==
X-Gm-Gg: AR+sD11GztC3e1gK/Y3RUr1eeA6PSie0+12Kjf2EQAYAgFrzgs2ADYZ+HN4fLmkdTYc
	u0fDorlxPIjClx5HkSSc2iK/hPivVzEOFeIDPrmIbRWWjv1YC7tipDkOlp8RzMz4gGklhmfjaNY
	jiSCzT8TY6mRKzpJPRxcOzvOlpvaipiQ/+PLDOhZS/k4qnHTSnCBLOnw8QILdX7hARVSlTsrt9U
	KJJUQTXHyai9qZRzC3MvudhREVPkCfg2BVfnPDMr7Acr83d8NTMD/76Gg8wwNdAS0C5ALmTnuhJ
	ciKDwsGm3SAf/tgUhiw6gfs0et9NKbLQIl8fy46IcncpWkeg8pcyYb8H+1l9OYvYgXNgjl81qxG
	k
X-Received: by 2002:a05:6402:24c8:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a42f172088mr4330083a12.5.1787304381089; Fri, 21 Aug 2026
 02:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821073927.455475-1-wujianyong@hygon.cn>
In-Reply-To: <20260821073927.455475-1-wujianyong@hygon.cn>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Aug 2026 11:26:09 +0200
X-Gm-Features: AcwNN1WWjdZbXI78GoIK0jWAAtL0xFM0dt2X4f2G3v-SeXG3xMLa1_PO0qV4jEw
Message-ID: <CAKfTPtAxY7ABQMF+-uZJK2=nN21f-yQ8Pst_Mm9XP3dGJmHk_A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jianyong.wu@outlook.com, zhongyuan@hygon.cn, huangsj@hygon.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 09:43, Jianyong Wu <wujianyong@hygon.cn> wrote:
>
> cpufreq pressure lowers a CPU's capacity by the ratio between the highest
> frequency it may reach and the highest one it can reach right now.
> Utilization carries the matching scaling only where the architecture is
> frequency invariant; without it a fully busy CPU accumulates the whole
> SCHED_CAPACITY_SCALE whatever frequency it runs at.
>
> Reducing capacity on such a system scales one side of the comparison and
> not the other, and a fully busy CPU ends up reporting more utilization
> than it is credited with being able to run.

Even with frequency invariance, utilization can exceed capacity, only
the time to reach it will change.

What issue do you try to fix?

>
> This became reachable with commit d2d5c129d07e ("cpufreq: Make
> cpufreq_update_pressure() fall back to cpuinfo.max_freq"); before it the
> pressure was always zero there. Whether that matters depends on frequency
> invariance rather than on the fallback itself: a system that has it scales
> both sides and is unaffected, while a system that does not scales only the
> capacity.
>
> Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
> ---
>  kernel/sched/fair.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c19a025d8d68..a163e00c9882 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5854,10 +5854,17 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>  static inline unsigned long get_actual_cpu_capacity(int cpu)
>  {
>         unsigned long capacity = arch_scale_cpu_capacity(cpu);
> +       unsigned long pressure = hw_load_avg(cpu_rq(cpu));
>
> -       capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
> +       /*
> +        * Utilization only follows frequency where the architecture is
> +        * frequency invariant. Elsewhere, lowering the capacity would
> +        * scale one side of the comparison and not the other.
> +        */
> +       if (arch_scale_freq_invariant())
> +               pressure = max(pressure, cpufreq_get_pressure(cpu));
>
> -       return capacity;
> +       return capacity - pressure;
>  }
>
>  static inline int util_fits_cpu(unsigned long util,
> --
> 2.34.1
>
>
