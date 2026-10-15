Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8863D954F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051360; cv=pass; b=Ah22vrT58OJURr7R5sZZbJHe4uZ45YhLef3gF4XyWe0p8DH2WWqUEyvgR2+TaSqmOoCM7YV3Au/Cwc46Olfetml8KkQZnIYgA98mQ9uNObWddTbl3l2xJE1txtsKamhrQXUxNE2s89yVVYM0pKZ90mrsAEKpkcwgsf/fagm90nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051360; c=relaxed/simple;
	bh=eRRqK9tqBDZb1946J9prALf3IBZg0i+rP/Tm+Nfy9u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+o5QyI3Roi7YNw2pvLfhqFxxZvPEwmnV4pPl/ptF9nPUUsUGrvao8ZDDz86ztE5Lc1hNhwxtZ2K++36mMP30Q1znnb9Ee/RvV0RKvKoR5tM+R3Tdl2iD4W0TdWnk+WpRAO6ho/40ju4Zvbh8vdxPCOwk6wG7TcgfvGEx6rWJPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z13HKOcn; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z13HKOcn"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2dcbcc546fso612732366b.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 01:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792051357; cv=none;
        d=google.com; s=arc-20260327;
        b=Ae+IAUV1vpjHepvjbblMfojSaCAvZr0k4+/OOwfxWYfJZUcmY/eNLsbeMJ7q+ai/Le
         jLxaerOSl8KrjF2b6eKe9D1F91VUIGcQRlxmht9rIFJ78cK/4fySWCfDErnZfqwq4ZjK
         5lx1k3if7N1NQgaakNyzdqnqS70vpHBuU/VSx2kCX72hNjh6aNumtB1K0LxD+i+erXRb
         uXklbLN4HzXZtFkbK0ETOIEiIp5RWukyK9gLvvoLEJWQBfTAu5cIlPrTSp5OuWQ4TYHI
         iHoBV+9mdgxTN1ZAVAoWKHTUkSOyBVWBNXFvaNrvyNRE3AwRklKT1RVSt2RJ/Scl2407
         sFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=20IfJrL4vQgVppdX0l7DtOYLpzRZDDrYGwERMl5G+kA=;
        fh=fObMUapTqkRRBUkzIO+UrmV0R/JU4nO8CqXQr7P8TGY=;
        b=If6qtx1ye6nlAOakRczMuKQu2n7SkqnD3UVD+Y4r2aPTbxagMbRxx9WEoqpC5XYJYz
         7SgUdT2Fx/TyVA3yENIfj8CkTmpKs8lHOX6tGGmoJ5zOKppgluxFl1jbhbXEbNCIllJA
         VsPf8ng9MeDwnMdumvZpIw2MrZN7MJ6WIRGqSbIoZZrE2RMZsb0XqXsgKLAe4mBQW/Cc
         GIqoeXJlv+l2kuss5pzkXIiW8Mc1mZKGUEXYA3Ggkfvzd1jQbpq9YxgV0HRMFOaYM6XI
         8Cn5u9YnowmpaO4BGFspZapJgd3ggMKMo+la1cAvaI/PyODOrJWZi1BsEzBmZH6AB7p4
         eQcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792051357; x=1792656157; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20IfJrL4vQgVppdX0l7DtOYLpzRZDDrYGwERMl5G+kA=;
        b=z13HKOcnk6JAqA8bmRdx/wEkhx41LlWab8EjQj5+xImOXLzQNFZTIoixDFs7vO7t7E
         y6V0qxzc+xntGTvP7fN/WdCeS1kSbp8hhSIPRilt+aHt4llNwoi15K18TtVMgHfQjYQn
         k6Himw/82MdSv3p/Sw3d2wLblc84i9vPtyeR3agOEcM3xyCicyizaV1gtuk8NYDRGeeM
         7RWlWpgtnwaTNonYB9SRmfgNVkjWJYA96PkZoM7sZby4dFxtNQABZTD4+dYsLsOzM6eQ
         lBc1g7l1mjVuCaCdnaDYW9DYju9fwelU9jQComyVPXQFYx60D+8okyJJrZrGzjRjjMwR
         u3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792051357; x=1792656157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=20IfJrL4vQgVppdX0l7DtOYLpzRZDDrYGwERMl5G+kA=;
        b=o248wcG9FmMlQMGB9Q9o/CVPD/Of1wR6ZYKR4l5ngCESExwtIK6OZdurJuixh4IjZB
         kYE2u6Vd8b49du2fFiLxTQAuLVVGIxxtdOo4ZRDMVN+6EdvnwYmJq5Hlmzz9KqqhlbV6
         IQTNjaSQYO1tbKxVjyCp0BvQpVemHX8GJLNzoSKSEJtOJXoa4nK27yi68/xvfXDtipYM
         P/dNrT9q96RK8fpSYAce/b0OAtxFIfJTEkaU2ocvG8wVArtC9oSs+ExcY/+e65lhsuHG
         MHLoE1+/gNDIY7MN4xKTJjtRI4fGZitbvmnsVTarD11INrgvYtYhn1wgzbDoaGFI2D7A
         1oHw==
X-Forwarded-Encrypted: i=1; AKwUvByQVEj9iFrbGbwnaGroVB3wC10LT3TAylOzLsp59eEKve4WOG47zI+sg7/FcnbBlMCdrwi9oKDgtA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKad0s4xKp5vnN64F4BHkSMqhUQfuUfGYqE6as/DWGMLbK96uvn
	oJAYFPqjAnsdOQmxxbW5RrjcmsHpvxjQR4JIb/sjp5ouWQu5IhoyfFrUy5bLdT7xhSue8vBF+xF
	A6toDlSuYKzs+pN1FLvt06aLOQ+8ZE+jIlPCfntPYww==
X-Gm-Gg: AYBFou0gAdWOtz2kzr213wbVvvdOynRj1o8Uck6jzrXiyV3B4aRQVN/uGD7Br6M+cxx
	2u+zZcSd4a6ryTopxQ1ByRLjs7uavoWzWj3mCYx1OvBZpqwpNSmBE2/vzbZZVL290Deh5nWr3Vd
	hkohNJC83qA2hqoDfaxcLzjp3++NgMIb/qAo+8ubGB9bVNC5t/NIU8DQESm2WtMIwmGyS2oY7zT
	vtltet3FTT0wVn8BESzwkHZ6LAOApi/zuprFJUTYs53oKMzBNZ8QG1XTWIdFWWdLKx1geHo5Np/
	pEFo0SE9LfmbD6qrG5hVchSqtv0gbY5epCdM51lYzqTdOCMTdIEbLSjhbv50cLW0wRZSwkjWEeO
	aawnBJedlWNyJ
X-Received: by 2002:a17:907:d90:b0:c2d:bc76:8342 with SMTP id
 a640c23a62f3a-c31a9a2db07mr1677128166b.5.1792051355396; Thu, 15 Oct 2026
 01:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
 <CAKfTPtDkSs8KOUYAdSOz_h93khGbT6TaVc9gCa1Cpa0JbmKEGw@mail.gmail.com> <4976fcef-29ec-43fd-8655-32874720ee73@linux.ibm.com>
In-Reply-To: <4976fcef-29ec-43fd-8655-32874720ee73@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 15 Oct 2026 10:02:23 +0200
X-Gm-Features: AclHuK8YXmCN4MxRL0pXtxsV0nS_mHofnDRL2bLTzz6zddGioaxby2TUQxLM0Zg
Message-ID: <CAKfTPtAXCmf9oqy-BKYRR-cLHFQGcgOCVPwN6s=3x7hD5Xz=hg@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 18:28, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
>
> >>> +static int
> >>> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
> >>> +
> >>> +/*
> >>> + * See if the non running fair tasks on this rq can be sent on other CPUs
> >>> + * that fits better with their profile.
> >>> + */
> >>> +static bool fair_push_task(struct rq *rq)
> >>> +{
> >>> +     struct task_struct *next_task;
> >>> +     int prev_cpu, new_cpu;
> >>> +     struct rq_flags rf;
> >>> +     struct rq *cur_rq;
> >>
> >> You likely need below to keep clang's context tracking to be happy.
> >>
> >>          context_unsafe_alias(rq);
> >
> > I just noticed that I didn't answer to this one
> >
> > Why should I need this ?
> >
> > rq remains the same in fair_push_task(). I'm using rq and new_rq to
> > differentiate both current and new rq
> >
> >>
> I tried to use clang-23 and get below with the series applied.
> It may not be exactly here. But somewhere.

ok, the two functions probably need the below
__releases(__rq_lockp(rq))
__acquires(__rq_lockp(rq))


>
> make LLVM=/opt/llvm-23/bin/ \
>          KCFLAGS="-Werror=thread-safety-analysis" \
>          V=1 kernel/sched/fair.o
>
> kernel/sched/fair.c:9971:2: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
>   9971 |         raw_spin_rq_unlock(rq);
>        |         ^
> kernel/sched/fair.c:9983:2: error: raw_spinlock 'rq_lockp(rq)' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>   9983 |         raw_spin_unlock(&next_task->pi_lock);
>        |         ^
> ./include/linux/spinlock.h:279:32: note: expanded from macro 'raw_spin_unlock'
>    279 | #define raw_spin_unlock(lock)           _raw_spin_unlock(lock)
>        |                                         ^
> kernel/sched/fair.c:9980:2: note: raw_spinlock acquired here
>   9980 |         raw_spin_rq_lock(rq);
>        |         ^
> kernel/sched/fair.c:10085:2: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
>   10085 |         rq_unlock(rq, rf);
>         |         ^
> kernel/sched/fair.c:10093:1: error: raw_spinlock 'rq_lockp(rq)' is not held on every path through here
>        [-Werror,-Wthread-safety-analysis]
>   10093 | }
>         | ^
> kernel/sched/fair.c:10090:2: note: raw_spinlock acquired here
>   10090 |         rq_lock(rq, rf);
>         |         ^
