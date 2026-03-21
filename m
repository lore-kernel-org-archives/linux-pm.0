Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDC30F95A
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774082947; cv=pass; b=ioLKQuaKwxLluf9uhv6LmLK6y8rMgFjkZNrn4a2m8fAqDO4VmgEBcjmdAzdYnkgkYTu4XjsaBmGFARrLw7dkKKhTO3y5Grpp+su6SPgF9x7Dd6X+FUleKa3mPQBcpC/HFID6COTqoyenyVJf0aEy8f/f1l5yKu0YPCcX6sXUaVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774082947; c=relaxed/simple;
	bh=m5Gig/1tHrwlaY35H1Mq8hT3w9QyquJLwRqQFvC8Tr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBvh/urRRNJRwwz/rSoks+wdakN3HbHUCauUNOqJUWls69CpIg0IcTsL8bycI4/cRGp1+ptkRAeMOrIVIWheIxQLFWHr1FSjSUcRVGdKhWfYm4hn2zGqjSmLIjL95Yitfn0BeETK6L+Y6wAA2hxSWziZMoQ0N9LhYMNwD6GF3s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX7OViCx; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX7OViCx"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50919fc3a14so14265831cf.2
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 01:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774082945; cv=none;
        d=google.com; s=arc-20240605;
        b=AbwcIIouAVoI11/RnyukaaS41/I80rbVJA6wsgtuIvRHWWLo++V4KZhNRlWfoy2sO7
         BxVaHm/DRdVcO5YOqpcOkwG5cMPH5eFEJJNjgHMCBuh3SwCJDwjQyyl0ZGcIKcJOicmw
         sfU+cPkG0OQ0mKmokjaYRSUVTzVNpZ2HKILMSQJHyDdOFFtnO4X5ylWs9qtByypQjfai
         aryqCCERqfX/OIqFpd5Tx+TcfTQnrjdjLKtiEUJEcqAujOBhwTGzMdK118fzbuwpxWWB
         VWYKMKI1nB8pRd4KGT7bE8PiSntHNYfuUvk9VapGQBGr2Q07T3s1YHZnN+6h14MJdELM
         Xa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fpqeC4ZrvaN2dLqn06moEKq8XGkOpFq5XqqsLu+iEs=;
        fh=ViIftssUQanqEPO9EnjS9BjkK4jkyNuHGubWUSS51IM=;
        b=R8JXGZkP274iZ1oKWkmQNe/9dk77prjyH4WRiOMv9HweVqKmhrHKbmaaIg7Jti2TcH
         8v5nqGk6qf17AXYERahHkOnWn295Cy+qdofOHFU6v5/h1tqq0Jl8T2QXpLE0w8e+dW70
         W1sxbBBomdgw8YSZNrvuBJXkaOoIDrCnFzGG552ICE7jX5iZ71g0nKVVMrF+oKqmOoBv
         SKinL2zmJqy+/afI6ERiJ8XLSHIG6eeapbDrgZDHsyfwjFze2fdDz9v4K3ZQ9H5Po/fs
         oo/bfBsagSF5vLueu9ogGFNvln6R3+rmNoD99w0XDXwREuW3kAzSNOKzsMsH5m0Fu9pX
         TRtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774082945; x=1774687745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fpqeC4ZrvaN2dLqn06moEKq8XGkOpFq5XqqsLu+iEs=;
        b=WX7OViCxgO8uNZbvP2frq7YKgGQ++kzql8a/q4yPrc0g6UubCCP7rjtWeMDNW1RIZe
         ubn/vq4lzX9d4yBNzBoPvmvk1MRmU/mpEcHSAmQJZqpvtVZ1P8+Y/mGWyoVYA7LcnoGL
         X14REomzvEsQAaYmlSfgvYNIlAYrPlmLY3EL6iatrGpUzDG6nDvzGG8qpMoY36Cmeyo7
         YxckKa52DYuKoQ/KlKGOq8Lo44q450vmzsqDG+RmX4h8iQG1Q5wbLrtHtmD+heDpWBeR
         3wHvpabZmkqAG+LwZ4sxtIggukNXZU1HhLPU5cWxKmUKQaSlbclddNKnXs8HR5k9blo/
         zPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774082945; x=1774687745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fpqeC4ZrvaN2dLqn06moEKq8XGkOpFq5XqqsLu+iEs=;
        b=D7KzTEhhxtJWZR7LZVGODiJfBBll/Q1meriN1ULmNFzfbbP36xuKA0j4FDh2y/C/zF
         NlNAT+7Y/ltx8vXImT6s7tmOKndMp7q0D8SLjVj5Mq1NDyo1xJERepLGO5tTRChfAgOG
         sjT2mZYhiFzGItwL+MV6kUBnXDzWKwBnQ7Fb+Gl4H5VZUrSEnKz+gSCDBeOj9WwnLHYx
         ca3K5qyGKak7gDtIMM14CHSBKnufAmdAerBzJOmzD80Ws2+FznfgNEN7cwlaE3LJNEuJ
         kuvT1aP/Dis4rvNXjLohh7/LMKsObVW37xDlGJvSHIc4oUn9LWR3tXbt1HO/YbaWXAiS
         EiEg==
X-Forwarded-Encrypted: i=1; AJvYcCVOHwAxYDucAyxYzuahiCWnZwY5YxVqpeSl/OxxV5Kh0Wa8TrASp2CxWFR+DA+nOvtF6OdJOURswg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QLsm9Z7JPWRPsQOMAhgh9ca5yYhJ+mseKzofWukbQT4r0j04
	KZa7/+oyAnvHCAK6ESiObnpq+Q5DfIWntmJv4pGvX3K3vXU5OX8+8iPWt8ALS7EoH7jN4MVco//
	8xlpjv45SHMgagpExTaJJWmFemXm0ItU=
X-Gm-Gg: ATEYQzw70jqih009qlJzz0Yn1J/CLrf2qMqffovf55vwQjb59XNfgibcJez9brvxq4Q
	63NKTXzcaXq+6mkLp1pu1wnlKvHSEkijY5E2LEHawgeIhGg0MAiO5ho530cn9PLZ9HURCBCxyeG
	5a0pcyHQ32uhOMjGgXJZ0+1ECO0KtBl2LX+/YTJMxXqJ9bD5U4MHxoyjFuppCDtHff05GLaIDDP
	1t0TcwqHXVFZ3xUG9K6dlmCtOztPA7xKusmEl/lj1XmAXYtp1QldWHH73RbNYFa8gxAU2w4lE0L
	gmMPc8R0
X-Received: by 2002:ac8:5a4a:0:b0:509:2d05:6977 with SMTP id
 d75a77b69052e-50b374359a6mr86879841cf.16.1774082944671; Sat, 21 Mar 2026
 01:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320113148.7308-1-xuewen.yan@unisoc.com> <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
In-Reply-To: <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Sat, 21 Mar 2026 16:48:54 +0800
X-Gm-Features: AaiRm52LRubfAYPhIriP2zx4Hvo8N8s3C4RL2lHm1RjAi9UffoFpFzzuiFqfiK4
Message-ID: <CAB8ipk842qMbR+RQ8G=ciQydAoCUdKZexu90qND6PtABxoUa9w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in get_load()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	di.shen@unisoc.com, jeson.gao@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:32=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Xuewen,
>
> On 3/20/26 11:31, Xuewen Yan wrote:
> > From: Di Shen <di.shen@unisoc.com>
> >
> > The cpu_idx variable in the get_load function is now
> > unused and can be safely removed.
> >
> > No code logic is affected.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >   drivers/thermal/cpufreq_cooling.c | 13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufre=
q_cooling.c
> > index 32bf5ab44f4a..d030dbeb2973 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -151,26 +151,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooli=
ng_device *cpufreq_cdev,
> >    * get_load() - get load for a cpu
> >    * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
> >    * @cpu: cpu number
> > - * @cpu_idx: index of the cpu in time_in_idle array
> >    *
> >    * Return: The average load of cpu @cpu in percentage since this
> >    * function was last called.
> >    */
> >   #ifdef CONFIG_SMP
> > -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int c=
pu,
> > -                 int cpu_idx)
> > +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int c=
pu)
> >   {
> >       unsigned long util =3D sched_cpu_util(cpu);
> >
> >       return (util * 100) / arch_scale_cpu_capacity(cpu);
> >   }
> >   #else /* !CONFIG_SMP */
> > -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int c=
pu,
> > -                 int cpu_idx)
> > +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int c=
pu)
> >   {
> >       u32 load;
> >       u64 now, now_idle, delta_time, delta_idle;
> > -     struct time_in_idle *idle_time =3D &cpufreq_cdev->idle_time[cpu_i=
dx];
> > +     struct time_in_idle *idle_time =3D &cpufreq_cdev->idle_time[cpu];
>
> This is a bug. We allocate 'num_cpus' size of array based on
> number of CPU in the cpumask for a given cpufreq policy.
> If there are 4 cpus in the CPU cluster but CPUs have ids:
> CPU4-7 then accessing it with this change would explode.

Sorry, it was our oversight. However, this is fine without the other patch.
For patch-v2, maybe we can add back i++ to work around this issue.

Thanks!

>
> Please re-design this patch set slightly and I will have a look
> on the 2nd version (and particularly the part in current patch 2/2).
>
> Regards,
> Lukasz
