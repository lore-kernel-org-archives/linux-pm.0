Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794481414;
	b=P8VRR6vTcItbVF0JwdB9zWOFOhC1UgXr91EVDJUCMJtVQCTCtjfBgb+Sq0hRqrZI2/T2
	 hgnpEi46EBMLN7MyekbBZzk3/kRfOeS56+rkfoGTWP2Hzp218K6IXS4E69g4PdKVVr4cL
	 obq/GPzp0k8NU6L6ahbS1FTiIUos5D2V6ViQt13929osY5u0hm6KcHLxqYjPgny5ylBdp
	 bKGsbl3FCyCpnHQor+enkFb8SayUG8t3/g4rJZmHO7Mo9NEwJcAcBRCVOXYmbmVj4A0PH
	 qt+1vDNwX2NPcHa7li1URIdEj4/Fs5Hu8OPNdXPYceNkmNXCgLEpAEnv8aEK4Zy8/aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QDokx6lDmg6FMP0/3Nuvn8ZV/jYdhXylaz0xMFxLtRU=;
	b=fg61YWqFKGKJJxpXW7nyqt1R3mFm4dhvZXjEb3sUODh9gbE0tHXbOJKL7unqMLg6Bvad
	 Q+bmjz9OZA35LXf5wqj5/zysfzQvrYTDj5Xln3cFWyuwb8qwrTQp+p0rsNNaDwXjGTIqI
	 2oognw998426h7wJnS4AJ+BSyoD8VHI8YP2efGg0xLaDwR6+JDxYW3Tljcm3hItcmKxuX
	 ACjAaXEsFl1vuvtY7H4PS67JgKMk12U2MHdpZ02u+xsMiDVDYYWs2e2cMN0tKya2Hpucs
	 dGvjm5Ux2+Y/lAnJky72XG+3eqRDG+mo5tTBIXkk7ZnhHJSRTqFgnxhM4kTFuWbikLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HqTHbmdq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A71606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HqTHbmdq
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso1458190a12.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 03:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794481412; cv=none;
        d=google.com; s=arc-20260327;
        b=gwYq2wPOA7rC8A2iWuYQlQ0uJM4Vy/sQSRbPtqTO9CuIQZDm7apZXpb0pHjvJxMhi5
         mXTlTaWNmlgeIEUnK6w9j4//8n5H49apqzRW67/gwoLKprxaL04BtUkN5i9MEWKhRwpn
         ZDdOLYG5+q9yz/KLXO9pYVIWu/0mlZdoPBUabcyL6itWV7qShEFpI7bEVbp5m2lUqeAb
         9yl68yPh6w303JxAAnLDjon8ewWcAw4MHjLsq0LGKRYnfl+2t5ICSXVboBvRobo80Qek
         k44+bYYaDNtIuw+v1L9B5ucP1cOvVSyJBW7yoUP0Qh9+dvmm30q1K2SIVS51OAZAZ4J+
         484g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QDokx6lDmg6FMP0/3Nuvn8ZV/jYdhXylaz0xMFxLtRU=;
        fh=wNzVZMEG7Pk3Si90i92c4cWCPDWXaPMQ2o6u/PeeYhU=;
        b=JunknRj5N9piFWPMkicdBMGszTkJyewlpNmkLX3k3kEORMwIbpol3Y57bbbZ1Yq8dF
         1t20efg0AoAn9onj1WTzd9IoXiAdnUFc6egymtt/9X1y0ZLmJQFhK2IOSX0nkIFr29oN
         ZmvpFsPWudMugtP8rVHlcbBbdDFOWMJ9o7YG2ecF0FdjvZbyAyRyRscXzyXUIVL0F7Si
         ydmg16CTGykf5d2jbOVOYLVCkdJLNsfdKMaDxhWN+a/d1EKiDDC/2c4dllF850pk12cr
         /FzEO4l6cyp8HpNfk8++5ilAD6fDIwLO8uLHL87ofuV3vtSTdmR4MT/MAQj4VCAFFPKL
         hiDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794481412; x=1795086212; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QDokx6lDmg6FMP0/3Nuvn8ZV/jYdhXylaz0xMFxLtRU=;
        b=HqTHbmdqGcsd+Ajhp8wxInTGFj2DFQMZDTU3BwKsN1jrw/3wArhMv+Ip67f86/l+5m
         SbJQ8uU3vlMnNr/oeyBW89aTiSdh6+RZeAxpZrRxHTy4YdI8kaP5YCPhfuyh3g3gjumT
         xvUyRokh2KaCTFD9gN01aq0jzar8oxNVIxlznAhaXBV9bC5CNpu718yUyWp9pyEM8dA0
         EbxKReC2hM5GwXOI+PyGgEAeXZzfONZR1yyQ/jPPTRed9cacpAW5slGYqajIniBi/3KK
         wqAtl0Xv8BbF+cTou8KMO8j0xbDX0GAbwbA3YKg3EYb7/9KEM3mpOhRPyTmheSopT8YI
         y4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481412; x=1795086212;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QDokx6lDmg6FMP0/3Nuvn8ZV/jYdhXylaz0xMFxLtRU=;
        b=dZ40d4kv9KNnU91LeNS1QrrzOirYHd0k+JUuwtoecPc+3vTF4F8fRv+L0fp4jNwDLX
         qq8TUxk65PFDnN4QdXoQHnv5yACE9akM2C8yjpkMjcM4CCNY8uO+Cc8LjOtH/X++SaCc
         TAXXtAq8rTBM1UpY2ZerEDl7nnsmYOxHE672nlNWpX30teFRyU44u9YSxJOap+p2jzjG
         7EWMpX9PP1CUovupm0Of6luk/Kve3yCLcL6C9plwCtDqZq9z0hF82wJzhzIITrOF2JoC
         BtlBTPu8m4uul4uyO2HBHI8SK4IsI3/yac0MuQV10FrqSUh7+b03hAB4ydQH8W5uehWc
         yG0A==
X-Forwarded-Encrypted: i=1; AL+hErEXMewSdTRirxhyCHQ6TiRegtzdILKXs/CI5tNCgBjg5Py8OtA5OQUBHFbk3RSXXLCttk3LR+hlVA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8vl4H9Eakzg6ywwe/milxX5kUm/YBv3MAvaNPDXVXUdU8Fnj/F
	X9bcBOMEtXi+VSgdJndVCsN8eUVPhezUVzDzrUq8qtAtqXt8z/RO2dND/EdxIM9tA5gNKSG+eCr
	7/ftiiBV4VEsZokMumMqPjW09+U7xd85L1zRiMmiZTw==
X-Gm-Gg: AYBFou0gn6qBu8lf4Tsfj3O6SasCannH7HG6tofHzEAYge7PlW0KNXiMiduyV0VCFTR
	r6Kf6D+T+fR6U6PPczudV8a472T92QCKzBU7h4TCD60UCW+8UGFUFRXGk0XPk/GBJ9jrGTik/nv
	rG/5IubmdY4augcJlZ/yKLCPXQOrNSdWDc55IPw2BvEcNBrBYanULgUTim2Uz9SLqusawRqr+T1
	sD4n6qSS7xD0sBcYWXLLdAnR/LgSJbW7Ek+gBzNo4m1+2ABMhdhzoCGOzu9zx+fzHd3kGdcTh9I
	11Ugr4ozZAvVe24mo7Q20zh+Obp8iDgr1ZsrTvKyvBD/lq2Pg1CT+N1QjoCF5J74wKlMR6dYSDn
	v0YGGhZB8WH0ui8UZEm3f4RrfRSBkHLmK5ad9IvBSC3Gx1Xw0WWxeF4T/gaKZXac4UBKU9g==
X-Received: by 2002:a05:6402:a150:b0:6b3:cfa0:77cb with SMTP id
 4fb4d7f45d1cf-6b79e07eccbmr1108582a12.10.1794481411373; Thu, 12 Nov 2026
 03:03:31 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103154603.1893325-1-nigro.fra@gmail.com> <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
 <CAKfTPtCGmZQ9XVYJL_5f603qTf6_CdeKsq_pAYM_Ldqs3NaXaA@mail.gmail.com> <20261112093613.GJ2668804@noisy.programming.kicks-ass.net>
In-Reply-To: <20261112093613.GJ2668804@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 12:03:19 +0100
X-Gm-Features: AclHuK8Sr9B3BKdtYWhzEUcJavKjNWqYDLDaTDdTrbMIU8RDvtjNpcnMG7oQ-T8
Message-ID: <CAKfTPtBFRTA-xcBU8xQTXzrAEp7iu7KRA88ChJXB0f92ZT_56A@mail.gmail.com>
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms
 behind another task on the preferred CPU while allowed CPUs are idle
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Francesco Nigro <nigro.fra@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>, 
	Mario Limonciello <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 10:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 12, 2026 at 09:59:02AM +0100, Vincent Guittot wrote:
>
> > If the root problem is the migration of a delayed task during
> > newly_idle load balance which transiently make the CPU not idle
> > anymore for another task waking up simultaenously, can't we just
> > prevent migrating delayed task for newly_idle case in can_migrate ?
> > Migrating a delayed task to a newly idle CPU doesn't really make sense
> > because it will be the only task that will e migrated and will be
> > immediatly dequeued.
>
> In fact, I would suggest just dequeuing it right then and there. If it
> were actually runnable, it would get to run on the new idle cpu.
> Therefore it is not contended anymore and its lag can be dropped.

Yes, make sense to go even further

>
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11771,7 +11771,7 @@ int can_migrate_task(struct task_struct *p,
> > struct lb_env *env)
> >          * 5) are cache-hot on their current CPU, or
> >          * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
> >          */
> > -       if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
> > +       if ((p->se.sched_delayed) && (env->idle == CPU_NEWLY_IDLE ||
> > env->migration_type != migrate_load))
> >                 return 0;
> >
> >         if (lb_throttled_hierarchy(p, env->dst_cpu))
>
>
