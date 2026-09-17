Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38558E2DD
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661217; cv=pass; b=CngjOaot1Ss6AVb8RLxcROV6/6kdXm4VoLESwtMCbrBvhrUbk7oA3kuPTrxbAcKmJzZIBtPPq7Bz/ZzeSb/xiVQvCbGYTS+b4loOaYMsW5nY2Zd1HxuI9H718HCLuqEdNq+y8L/CpPIS5Vc0fSBBCMhmXtnGo+DXH3/EnmD4cPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661217; c=relaxed/simple;
	bh=De/999h84+l9BVfIL2AOjoR3XEAJ+zsNfEgHR7DHgHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgzXHcLx5isoWgtD+v8ofw3ms9qOjASvLEYz5HeV5fH84luJKXrhL1W5WFlmBJJ+CXzvY/bAH61mtYSCD/SmHjNs2R+nmD8UYAlBAlVowTE7S98abiI4/fiCTMclVWDsju8qfNNFOujBUDIWdNRZJKNy66uamuHJJdjv+OuX9yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TVMDzdko; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVMDzdko"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f56039dso151082566b.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 09:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789661214; cv=none;
        d=google.com; s=arc-20260327;
        b=Muk24fySqbql1xkJVLRrye+LnRyD+/KMIlE8gP+TPZMhHU78pI8Ki0d8LXcnbqY6jl
         BPtYScORhkCPAP8XNtIiQXm+Z5RHE+q85IVxQ6lQhYSbh3W3/MVeAZXnJ/d5oiWxv9PC
         xdwUI4uKfcv1VxOr+SymwpQbc+f9a/8xin5BoHZADQeKHVBjmd28n/VSO79d+h9OqIs0
         T87BrlHibCr36ETnuuj0njOOx4feZh+b4IYHT3Je0QKhYQzxZBmz8mVY0YaA6cKUMOBn
         uFzQ+QGl3VX+Zv0eWZw95+hWoodd3ItPAD6jO5LTMc4xn+JdfF+7LESvTHgxVStzisOq
         /JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l7vZZOfF1oChOGtrYGJqCH6mbY72WxmGbaYDIaKFF2w=;
        fh=QnDlYpmVYnGqT+6bav/KwiGvUpknQPdVgMwC/i38YLc=;
        b=a8+1bWH5WgPK7yflUEi+9ITk8IdUAntdpnou0ZC7AVTKMqe+7QjkkoGucczxpJ+Wjb
         KS73GbYCNxhdmvraW068GapL++XOG3NpnSy4KVEMGff5yQAqeOYwihYZAB5pA8P3vnIn
         iEXMtQlvuioNy9Cq68AZzblzF13AjfuPhE3WZ7FUPadLjURK/dVdeQtksOw5PsnF4B4c
         kvSlvaGIwOAfTHp5fMn3Xv09+ozu6MNyO2a5c26YEIA8bYoytQ92NlJwszJN/IZdrVl+
         bt3kp58oEoFp6v8Al3qDvE786vj1fV3PPhli6IA79pVNwI9JTUaSfxD4fv+LfhbxIBxw
         i9/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789661214; x=1790266014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7vZZOfF1oChOGtrYGJqCH6mbY72WxmGbaYDIaKFF2w=;
        b=TVMDzdkopOmt2usUSN7tJ/CXOAKGsQSGVXc0qJUp5OMsXpsmYcMBMfwu/yvo9kPLKh
         ZIxjvXgL35LY5U3tJHHSoD1Qa/FXvj4TjWY1Q9zekXLpuLwNi75KOjyi49n/PdIWj5On
         PFmmIjoHGmSbXQV6IG7fwRtI/IrpSmqMSNKmwQ56m4vn88CkXK3zwHGXeXirPV4lREVt
         ktDuyUVikiSZ2Asg7JvIDU2MiA3AnAqyWEqsQXVfwPfFi8rS5VazlX80JqsKsPx4Sidu
         KkQQu3joPJPcStZIdaRdq3Vw26q/XEhcgyHWptSrP7nL3lKF2wDNLDc+/oNCgvd8RA6U
         eg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661214; x=1790266014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l7vZZOfF1oChOGtrYGJqCH6mbY72WxmGbaYDIaKFF2w=;
        b=T7Fns6MNkk8Mi7AJ+ZyWOlhUGx1ZphgWXr9/7RjONGLnZsd63aRSboFtSX10D3XNYM
         gxwKi1pjONJ3L7wWfp5FEDscd+HDCwmJELtNHca0R9lIIsD0E40iGDi9NX2PARHl3TfT
         RPg62+5s6nD5LP8/eiJHGiXGujl1dYHWMYFmLjWUh9MDVbraFOf+kOCu//npkQ1oqbfN
         RfPCM6LQ+aXNrMak8RclANWMgcMhiKrZD2LxfvAmB+s49jiqtWq3AFvuyaZ/jyn6OuEW
         jggHkS1QU8j0bOY4qAOvnrVcNWDhin0DxV2j1qqxX/X+yzJPjV/IuYGuN6HAl6OdCnw1
         lgWw==
X-Forwarded-Encrypted: i=1; AKwUvBxEAhVFOob5NaQrcuZT6Jrw1UGVy4xGGtg0DrhTBtv2FNcsJJxfHFk534vhp5sotCOBj60Nhnb9xg==@vger.kernel.org
X-Gm-Message-State: AFuF++kSHLarror3hNIqOZhxvySzgCZn+lhYsqMUopTVxazIv8ZBH44H
	mzysNq2OJluOCdSGGvDTc4u6hjpK1xQF9kAkzTSBwgVnfTpd56ghsRi/rmCubQMF1k3hEHXHhX+
	vUGojKsQVhTDWR+72XXEdC62GLVW++E078TODdmggbw==
X-Gm-Gg: AYBFou0YGYjpgR2M9bLVlVOcsPMY36nG09sT5VmGjsWd3Xzzvk5Knp/hplpomR3TgJZ
	3m3xJVkT5qFMTH2h9lPSmMvbxihpziXlp0UdX+rZhyfnksTgzo4EZYTHTfbHLdQ91TmjTAZumg8
	/2cEo16ldSGvvIwd2ubjfGDbHUI0KIVQx8ydF2QgSVivLcSlINz5lV+DN633d6REpwrGzt/fdfy
	L/INWscq31TgJ5MJqEBJRkKgdPvoCqr1TEsSOLCCQ4oPJUvPhmJJ7RlUSir0NGRap63Z6Zc0KRI
	8JSVK+83YovqcvD3FufxU0sTZp5q/2gIDGabSUSlwYMEc/uBWCYCnfY+XicgD9NwcJc567oWNKE
	Pn5tpBAa1Hp2h
X-Received: by 2002:a17:906:c108:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c29e532ba26mr550909566b.37.1789661213976; Thu, 17 Sep 2026
 09:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153915.1563875-1-christian.loehle@arm.com> <20260917153915.1563875-3-christian.loehle@arm.com>
In-Reply-To: <20260917153915.1563875-3-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 17 Sep 2026 18:06:42 +0200
X-Gm-Features: AcwNN1VDgoUHXaC_qbFB1CwxOWF1VmJqBSwM0r22FFa4FgrlUpPPIB6AguxFn6o
Message-ID: <CAKfTPtBft2pVrsZQGJu0UBjuqaGJ2ViE9N6YExLvBnpgEXDvag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Randomize equally shallow slow-path candidates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Shubhang Kaushik <sh@gentwo.org>, Christoph Lameter <cl@gentwo.org>, 
	Huang Shijie <shijie@os.amperecomputing.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 17:41, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
> slow-path selectors can choose the same CPU before either task is enqueued.
>
> Use reservoir sampling for equal exit latencies, resetting the candidate
> count when a shallower candidate appears. Use the per-CPU scheduler PRNG
> and reciprocal_scale() to avoid variable division or a second scan.
>
> Use a u64 latency key with U64_MAX for unpublished states. Published
> states take precedence; when none are found, sample among the idle CPUs
> without a published state.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff5793bddc35..810343f40316 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -24,6 +24,7 @@
>  #include <linux/mmap_lock.h>
>  #include <linux/hugetlb_inline.h>
>  #include <linux/jiffies.h>
> +#include <linux/math.h>
>  #include <linux/mm_api.h>
>  #include <linux/highmem.h>
>  #include <linux/hrtimer.h>
> @@ -8458,7 +8459,8 @@ static int
>  sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
>  {
>         unsigned long load, min_load = ULONG_MAX;
> -       unsigned int min_exit_latency = UINT_MAX;
> +       u64 min_exit_latency = U64_MAX;
> +       unsigned int nr_candidates = 0;
>         int least_loaded_cpu = this_cpu;
>         int shallowest_idle_cpu = -1;
>         int i;
> @@ -8479,12 +8481,16 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>
>                 if (available_idle_cpu(i)) {
>                         struct cpuidle_state *idle = idle_get_state(rq);
> -                       if (idle && idle->exit_latency < min_exit_latency) {
> -                               min_exit_latency = idle->exit_latency;
> -                               shallowest_idle_cpu = i;
> -                       } else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -                                  shallowest_idle_cpu == -1) {
> +                       u64 exit_latency = idle ? idle->exit_latency : U64_MAX;
> +
> +                       if (shallowest_idle_cpu == -1 || exit_latency < min_exit_latency) {
> +                               min_exit_latency = exit_latency;
>                                 shallowest_idle_cpu = i;
> +                               nr_candidates = 1;
> +                       } else if (exit_latency == min_exit_latency) {
> +                               nr_candidates++;
> +                               if (!reciprocal_scale(sched_rng(), nr_candidates))
> +                                       shallowest_idle_cpu = i;
>                         }
>                 } else if (shallowest_idle_cpu == -1) {
>                         load = cpu_load(cpu_rq(i));
> --
> 2.34.1
>
