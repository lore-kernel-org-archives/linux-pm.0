Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794468979;
	b=a2pVUMkGf2oL8Gbg7IZQRwX7wRfguEugd0mrYnz9hs5D+4W+JbF2m+v6RFrZBo9fxVDi
	 vGVm1PseYghKxbT1IVy7KgSXCr0tNFiCCKNyf0Cs/9Uh23A+IDuffekBMu+oZkj7yJ0KF
	 Ex3hidkn+XNKtVRaLQPTxGtf3wPy1tZ9zQztTTLDUN75j3JIUgx6GZhC+qwAZ4Fp1/rTD
	 k08IsDbGUWvTfFEVv93ZMp/+IdlzIzLuOekp4YT+TMjExaW3YnbT8GOr92230WesEZiYK
	 B7allg0ufDSE3cqTZmkivN7e0ZePoOsxmPIgU6TS+1efKe295rkr1LlJwsYgtLvRByA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
	b=pX2aBMsCcCuDE1pETnfS9RrltB8TQcxhQBt18XWBLIEf4/An6veiRUY3WlmX+AOfnDTH
	 SbkBhNJfOpbuVacn+SU+XknCUBxrUubsw36VZdc6+jRBqz1+Du2OJaigl4FiTX6HpHeir
	 9I7OoKxJ1rp4rYxQgRgI+sj97PS3+18OMu5Md/XMvFBEDxK3Z6kkZxIzYk6mKc1r8hnOo
	 OgBq5ROUKFfL3/mM2PNrAMqXZI96A+O8wVVwef0OVkJh7Fs0nzY2oyeBcQW8KmdvTqHOb
	 D3mDExMO+h0l3jmJC/6Tf5vPDRz1fU0dgqt++J61lIhx6Abz0jUbqc9wJLBLYk/Vsxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wxIft4T0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5357606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5357606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wxIft4T0
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c445c95d553so19253066b.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794468977; cv=none;
        d=google.com; s=arc-20260327;
        b=Cq5eY00avKXDgiiuEJxe5XEC178Ic9NoR0djBHdV5Ni88P3JhihX43yuhKPTv5aQ42
         tk7T+FzmpnuQHivbxWBrIb4vc3Y1TIyY6uyslzQV2HCOg9T8AYuApQDbgKWg3+m8bF7e
         Tz6PZINlXslRap4O0vV5fn6goQC7hDex3mATXisfL5NsOmyUm/+4BDHTUwZwO6Ai4pYk
         2oyS5UmbTP+r0Pul6wNlLdeSatdaNA2GdYr/JZQ33AW1R/iUEr7XgzJ3gBnz24KUtK5o
         BuNLGuOkBEmwoBUoOb7VFpfX4Xga4fsGTCpNUtUJpo0epURfGXEs9y/Rc9ldlHN50hPd
         Ntjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
        fh=RXLoqFvQab4cziF3tbyy6YMdqdSjkPm3HxKMDQc5wFY=;
        b=XFJEIl06tvNQhDGn4dV4WzDCrjWw6tb/N+uygibYIzB9oGEXh9a6nuzE+NScm5U9a3
         J4wpQkMNO+HnDDejkLEkKDWJryvaVLlOuLYdqOBZ2a3D6AqOtZrXth16+6N4SmC9W6jn
         IlXRSYXtiWw9uJir/8OMLUhLMtwCR/V3VK79awalDfBDLLw+28nUqPkIyJzPrdCAzRk/
         J+8foTwmOTUqGJMHt6LpsxVzIFvpbSmz35uxyqm/VeBjRp/pHAiPlc4KEfwlhqqWE7cZ
         BNUsXSL5cg183QXy0fvC05CZhPn6NJF9n1t8/La6A+AtB1ocV4og7FOhJ1tT/wty1Els
         P2ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794468977; x=1795073777; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
        b=wxIft4T0cmv1z5/Reo2BcKlgMCIs+Q1MmV+XlUJmSYJh44Axu27u2hS9BTVUuSehHY
         Z5tcaSLA78eSNVq08hBZsuahjV5X09x7JaB5QJsYLkmyHD8pC9T3wGIeoYOXHXJKbIk7
         GIgLZjpLu5LW8TN+OlGnwW9V3YsuLKsjkvNxtp1XN4FkdnLqH45OJRAKE9mlf+sxMGay
         W6Tt4/GIExCwbsxRPOFJgve7RrmixlPLDg/aWqbY8s82ASYRueZG1vqDcnytqnQUoOoN
         BCYm4+TUHceESvwFIWXRg5Y+mILlYPtr10Yi8gxt7CS3nWz0Q0fg5PWjgkQ1A10FhU4I
         IiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468977; x=1795073777;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=63wXmcQtAwyCVNpBcdPY82MrHRAWOWViDW8V2M+GO/8=;
        b=Y/K1hasIeXche3NXmGRQHfjm+suNX17Wz+xQUqTmnjTU2Y8kEa5DKCQkYko0sbQ8OM
         2EKK3UEay44u26/Qe6ny3FoXmfGwZtfxQh9zdhdj4SiTT7Encvsy63L1/fIqUARVqDE3
         6aAH0Hpxh3Q5z0QdAV+Sq9ku90LWoIII03/z8Dd3lotSWUYRi4mtGFMTJGUaWxj84fzr
         RK2faIx/boZ1rigJ5yxpUDYVXh6sQj4iWdnWLSC2ZFqYQEQEJIXU8pUx3Dmp94FdxE+v
         npNhqPVL1AnkjcGH02iYmr8zVva6W9KakMNyK93GrFVdRXwMz1/cpmgzr1Gp2j3cIN95
         1fug==
X-Forwarded-Encrypted: i=1; AL+hErEdbWBpPMb36wmUbCn9l/7tNWD8DI3YUWEbQpi4Ef6hzeAngFFPC2yUJrFyf/PiZB2LCWkodqvAsg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/FXag9adaeJzUrgIqCBB0SW6jZ9iD3U+GaFP9xDfjFwTKHNYq2
	VRLsLU31OYwamvQJGLr2NL8HRb/PQ5/nApF2YHZouIiFKWJlBMMCTt7LTPFWaXj9/NU9+KDTlKT
	L8szIHs4bo1VqgiBwcRmaYOY99ZUy8ykh86CWAHAeIw==
X-Gm-Gg: AYBFou1iQwwjiTN+FKHDi6EUDPTPVMZ742X6NMo3adlP79r9K50Mj4A/0yuGpUhx6Nb
	bO1ej6DhIlHGHV7hSDvOReFTc9qRELDwV0AOZP5qTNrX4Rp3eG/5MzWbRszKq7iLudl1Nc3zaBL
	k3o00J0/Wqg/tjC2mH2gsGcfwsLQCJ7sS3tvFyIFvOiO320E2NimzetlvQL4PuuMa+KTySuO+gx
	X82Fme4jN2yXAo/rwsGijfSWPlS0I0DTssN/61okuxcZwCJiIO6q92eY01lU5bfVgTdkORzkL1Z
	p/AKmzEm6+Gqu9hXfR4S/pXBwNQuWseJ9ZysvHT2PHKHNByWt1PM3uPD7ePnL2QFKjiA68m1/wO
	xs9AkptFvLqs1fBFoBkp0AasKW+CKluLmI38AQdF8V0AIDJxwsM+MTwzA0/e525qtiqom6Q==
X-Received: by 2002:a17:906:c14f:b0:c2d:bd87:7fa7 with SMTP id
 a640c23a62f3a-c5066aeaa78mr354986666b.24.1794468977239; Wed, 11 Nov 2026
 23:36:17 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
 <20261111090155.GF2668564@noisy.programming.kicks-ass.net> <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
In-Reply-To: <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:36:05 +0100
X-Gm-Features: AclHuK9R2Yb38ySYLoMWNSvC_iqj6wysaQZeAeLf45aT6e-W3q4IhehrciXpto0
Message-ID: <CAKfTPtDfxesgZJ=ttSs3fqKwaWY8yt0CNnB31g2oS5j5zm5dKw@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 08:01, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 11 Nov 2026 at 10:02, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 09, 2026 at 05:14:39PM +0100, Vincent Guittot wrote:
> > > On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> > > > use that, rather than adding yet another list? I mean, its used for
> > > > migration, so excluding all pinned tasks actually makes sense.
> > >
> > > rq->cfs_tasks can be quite large (we even take a breath during LB)
> > > whereas this list should be 1 task most of the time (except during
> > > wakeup)
> >
> > Like in the other email; detach_one_task() is also just one task :-)
>
> but in some case I want to do more than one like the case described in patch 20
>
> >
> > > > Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> > > > MRU per set_next_task_fair() moving the current task to the front.
> > >
> > > The plist was only to reuse struct plist_node pushable_tasks; in
> > > struct task that is already there for RT
> >
> > So while plist makes sense for RT, it doesn't make sense for fair or DL.
> > Notably for DL we keep pushable tasks in a RB tree.

I wanted to add tasks srted by slice in a future step but i can add it
to the next version

>
> I can use a rb tree as well my gaol was only to reuse the
> pushable_tasks as those pushable list are exclusive
>
> >
> > > > So reserve iterating rq->cfs_tasks, skipping blocked and current and
> > > > such, should get you much the same over-all.
> > >
> > > Yes but I was afraid by the overhead of iterating this list which can
> > > be very long; We have already seen email about bug with thousands of
> > > tasks queued on the rq
> >
> > Right, so just take one of the tail and stop there.
>
> I don't want to take any random task from the rq but only one that is
> meaningful. Why do you think having a dedicated pushable list like rt
> and deadline isn't worthwhile?
