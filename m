Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240475;
	b=XLXf9G1TDQ52HNE2d/12Ki1e/ZSTu5PPSPTyH8Iefn6phuzw7PW62fLQe/F2PyboalD/
	 BnGrNlgR6T5Mvg+WCWqzWWjxvoIC41RTMqyaVyca3zUmgkZSAJ5YKy4zTY2OxqNuKlAoy
	 R11a0bqdQ8hpL3wFpQ0xUBZSvqYnGCXWfdrK3lVuSbb1pH//1qNlEZe/YxwdiMALOgnD5
	 xpi2PrWnIQw/Npuc5sMcguYxGkBJMruJ9dSygz4wX/jW+f6X+t4x/JhbhAzqLmr4l6A2g
	 VQChNbngOlr3tJ3vsbTCIbX45mSTI2V2i0AmC+oaS+OI3tlN9xguY/5EC+fFzUU465w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
	b=zZ0nkNPrgLm71YH6RGq+onrFTJuw82UdHV2VeqaZ2cUDsdOLxJ1CiNq8l37pf825qFgt
	 pFOuyKhFi+naaLKXWJzLivwUxfyzwgRRfr5hRENldFLeDckmE6QRcM+H4bQx/+O0+mk2a
	 EuQrHyeJiALheIhiuEMz7QNHW1SHE83c5Wm9AC2Zy2qhU9GuEkj0vEFh4H/9Rltj8im1x
	 u34MYH6RbMH7oCBlmdoOkruTYQ7v/+SMf1y+rnq6c8mjlZMaY8xeg3FwNuqvTKR+TjhkI
	 Zo00Oogzvz/XXLos8blf8Rl/KeSDktk/4OXPz6pBOW9ZZ3O2ivst/OcyXrijmKP4LDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bqGE6uj9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E998606EE86
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 16:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E998606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bqGE6uj9
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so2785526c88.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 08:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240474; cv=none;
        d=google.com; s=arc-20260327;
        b=mQqQoK0TT9AeoWFqx7C+oabhdVuC+KIi6lb2hWtxkRLJYpqMgp1Pzb4D/+hz/ixy3Q
         35qzxykEGAaccF0e4s09ABoClASMxRYILWrSGE9mm4tb7Z4RGwzUTtB9keBQuaFdqodd
         jDmeH6jqMVjp8QX75gK4dKTAZhFIhiCSxbMxP768K42fBZWmKNFSZXm3rPbpXa5TL/DX
         97DnUoJSRMCaEi5IwWNfnn1XNK1Bs18FLkikbZBgfnN3uCn8dud4tvg/3I2wmjT6D+O7
         E95f+yeHtq3d/jcKuDn9bKqdVOqnZ27+jJaWAty49P7WwFfkY+EDsC8Te3pt/u0SNgye
         BOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
        fh=1/83b+5TngiCw9G9zluB5ETg6ITLpc/JPN7G2l1pOXc=;
        b=odt3Ni4uVwWImsZZ/Y/nds4Ek/nncFetOisqV129SY8ZwXC8C9+zukx1oUbU3MR877
         D2+qGZtzuoCyvPLdvRYXBQMb/xhxvBu0V9S9aePezOxutz2HueBpCiGtZvqIQUoBm4pc
         cklh5/yEsiskdYkLM/NSFmnFC6TfG0WX9HlAuHiUdu5D/fvRM8+u1dtRag4omsa8SBSB
         PfuZspSvF5s1dOfykU0TIqKPmEzNfGdYO1o6KSDAWPzLzlUiW0IYu8qXOvx33F5bz3mA
         V4WANAX10E6mt6sE/lOKebN1UVFJg5cXZtPyB2A4TEUmuCJ3zuYLVh8ZwgMQjLqHO2Wm
         hJ8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794240474; x=1794845274; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
        b=bqGE6uj9fKNrG3w60stdKMh4HkVt8FhOYmdsnCe4TVSocwnXywOb+5yHbPTKcgBfcB
         24sIIhOCRIpBIAHL8ykVKY6f1y9oj6FVgZNKihX+p7xXKXhf2hd9n18VlVZRd5UEK2TC
         360/o11TUVm8T2JwYmSC9DN7xhrMXgjAf3UzdZ5LwFHaNXt/ewz9OrucTI1Kq47o6hpj
         zb83MyoEqsO0ZR05PKUu5U10cJr2zvZO5ICX+FlyUxmtUdMikqYc5HxQ0hSaqc8rFk2z
         /oVTW00zFJcwb3FEQQiz06zNvurrx5ypDVuEpVFB0joXKVBkl9pD8dr5TxhzRVPGQlmg
         ne2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240474; x=1794845274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
        b=ibTeT2kaoOwQzM+JOZ7Mr/qybVESNlbdQiHvUUpIW/w+qEUW4q35MlWtiMfEDca3wk
         iHSCxgxObfzNDzDZbNYmR32L/q4xq+AcVSSts4b3nZ4AU9Eey7iOBW7nsS9eqcuSMctn
         SebVLdKmJ81Ik7O1QaEKg6uu9WCKAvonyM9BSDOh0CUK4wAJiXNCb1+mCwsgR2wGhoUq
         MUqeuHrOSJ2y1/bB+QA/KYkFcCdi+qAbTRTgfrIrMTMPMPmIWwzlEEShySePp0UBaUrb
         FhZjAI8UBg+5cSn0fYVryC5QRkctbvdoOKJBNbP7dLmhdYEuQ7LR4mK639STWqhk6CoN
         xbQg==
X-Forwarded-Encrypted: i=1; AL+hErEGcy93hd8uYXwedRvHnhsMmYzlxTSyW8JNLDNIdcaNatFTXyH99btwIQ0wGMY1akeDa5xCdwUZeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/NkJu7CnIlXh3TdyvLiCCn1K5aNq3wi5w/H+nTPhvjZbKTFBFw
	lVdUzVG2OXKJlgEfq/Bcy5bHfHJf+wB0TNqnjfswCOiGaM3qmBMbKKpSz5CdnkDTGVq8RO9B1/4
	uOYTpel8SMgCVI13WrDehV1o2tZ0vGdzswF8iPFI+fw==
X-Gm-Gg: AYBFou1zqng+NgE6jqo1D9RouX4e6IZDpqMuvVbO7Y/cFersV0IHwVNEKb8uwdQg1t9
	X2MsdqDDTUnrDHer4IBELNRVbg1HoJ6Ixqy2i8+e3oEZ8AgKIYMdSQrUXQeKpWw88pz9zuRPPo7
	qtrhbPge4A5VJneCcEwD/6Dnt/1lIby7srQkLxdrPT4rBjZumEUfleCUgCclCxLu1+SOVHmAZs9
	AZmnqqFG+2zUI2Z/2RfMrlJ+bRVEK9564sgJkwtffOX+wFEsZz6Rk6jBgplMwY6Bx0ogoSbo6us
	69LhoxMFXOv5Q4S4OWJXNUO8TZC6UhZ9Pg2bowrOcAjqxa88I2BNXUJZ0bRI1wwisPPO8vaeNXq
	1RD9YOU4Ev37+VsTycT8YrH0BrnFg/Z/+LuwzBeAN6K9tFCssklwmYVcSWLDohKfyWmpdhCY=
X-Received: by 2002:a05:701b:4284:10b0:194:3a84:e67a with SMTP id
 a92af1059eb24-1b39ff06096mr7491026c88.41.1794240473701; Mon, 09 Nov 2026
 08:07:53 -0800 (PST)
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
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 17:07:31 +0100
X-Gm-Features: AclHuK8HkNgfirok1D7dYwfSows5oKF3C-rSYYm8dDteUYYcSG8yjSHtd3IxClM
Message-ID: <CAKfTPtDcu6HS-G75bG7xp10t-n-XceneFtqxa_cAd+B96zCJiw@mail.gmail.com>
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

On Mon, 9 Nov 2026 at 15:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
> > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *p;
> > +
> > +     if (!has_pushable_tasks(rq))
> > +             return NULL;
> > +
> > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > +                           struct task_struct, pushable_tasks);
> > +
> > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > +     WARN_ON_ONCE(task_current(rq, p));
> > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > +
> > +     /*
> > +      * Remove task from the pushable list as we try only once after that
> > +      * the task has been put back in enqueued list.
> > +      */
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +
> > +     return p;
> > +}
>
> This means a task will only be pushed once? After which it needs to be
> re-enqueued on the runqueue?

Yes, my goal is to keep the list small to avoid ending up with many
tasks to push. So I only check if prev could be pushed somewhere else

>
> So if it was found during migrate_disable(), its thereafter stuck? --
> this seems a little weird.

If a task is migrate disabled while we are about to look for a
possibly better CPU, it will have to wait until after the next time it
becomes current. This is a simple way to pace the number of tasks to
push in one callback
