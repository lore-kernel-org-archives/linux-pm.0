Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238655;
	b=O3657aZv4FFHfDdeZc6oOeMefD/IWghQ2RmI8F3pXIRtIUdq0U8ODEBNnCyqRwQDuEPa
	 Tt/ykwlaJp6d1vcvbzrYoXSZfgvhVYvhjCjv4mK6RyGL4NYp4TNrxnahZpSAtboODNrSN
	 hwe6zbdq+1bY08Qckn6Hkf20puq010ZG+pwEmzAIxb/x5kY8eE/dEgGTg4tHR3IJExMzt
	 d8+1myvldvxijNNWAJZfNUW8pJ0AfLW3fWjZQ6bDfk417rKOCxyPXGP4iRju63SZt2ORN
	 nyLmhI4bN4SkxBUcZ6J9dV7bULQT4axeTuYGlXUcVpiXgZ6Zohawu5GF3RFHVjgv6HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
	b=ZFT3eNsgG+JsV3OeIkbWf46bvHgn3e0TspDudi4hFdnE2F2cNP/0b2WjEBQAswfGOh53
	 w+b1hk/X1FheCSOX7wo6D2hz7kgaIBa8nVzGwCcVBuB4cS3Q3qGfI/3/RKqAKBXzKLncd
	 gycM73LJOaP62e8JT/4DsrKkYOCW1mBBn4gIatUUpOMHij70tj7JCcwO45e6AUUREShQG
	 bmmuFJSGPOcSasYPR1quu9oZsLgDRIwN+TuTxHLd8Si+2lQxzTg0GxXSDyHkqYej6fxKQ
	 AGncpk5y7Hm0PuqkgPKd9W7yrQKPU+jjtliWHBo2B/g/Ykj1JiALHNMhHXDTFcZRgtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GinMFf5q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA5606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GinMFf5q
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so1464826a12.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238654; cv=none;
        d=google.com; s=arc-20260327;
        b=FDsre/9TCL8rnCpm4Lh0p9qxJ6u1mDoNocU2r5a9zfntuiZKVALeOYJP87NUNl2+kB
         FY+wQ7uh8Hw9aXTujVFgRO/GBXQNUXje09Yv8GCmKR9Y1srrUdh8wgJ2xQvFROTr1Xm4
         wBAVIstQZeejKrRoO16ZCRdXCV1XVCgxDn4EfeDL6XSWpl1rFeITlrQJ89G+X1X29m3l
         V9AXDlfZBkBxA2PBGOGYqIwkTUrjcRrin9tNSRyR7J1MMel2aBO7spn61wNCNk7SQnGE
         sbI4z3nBZtBQ6QpqKCUZO+nQMHU9DPxXEIErPU195F8utl7Ew1sn7UWcjob5wJMCfOKU
         d2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
        fh=XvI9nC6MQt7II2wfJy6XDgTkfTPy0mmBI+HFYm4+rrM=;
        b=hKVA9QcRb5a2QR74zXZMzBTR3pkRlWazMWAy+g2M+z9lO4wX9AMF1M+u1TiL+RdlXn
         PXOhgm+2vhMy+ZyQKoiEYSLjjhjPOCqeHNlCFNirqjcytWdV0Z2o+uvM8GkByGwKNYPs
         4HpNTOTzjto0iodHSVnpzj59Ta6WSvMfpoKLKua9co3TERqoQBqRv0oOy6JXtjoCQfHj
         ywKh9jeXZ46QJmjbNDJHfBgpblBxnMb1iDlxVEoSfc36XTuXQPoderMmn4+d4F4Q5e3x
         JWti4A3IVecXSo8RoR6DNXABHDQ72ddEWopCqLQcD5a3OL0arPZjnkpNAP4jLcpxzYWI
         tuMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238654; x=1794843454; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
        b=GinMFf5q4pAFBb/uChQ3hd7/mTHu1bPgEL7RRWQ49jw3v6aXhEJyRyx6Lbu5Y41rip
         hbz4gnwFKnx9TYthFpuFLymcEIWHXZCVrRVs03U4C83sgStItikXtxkvRQDH/NWHjeq4
         HLRuedXwVk+Uou3xAFsB/iso7t+Xkxm75NcIXBeovrCuAZAPyEcYH2nWY3TjYo8ImkHW
         aL3FhVouQsavlcDz+94oVgr04LSspkSjR+vXA7GGDkdP6gCdIYuY6CnbMpGMSaP/4q+E
         rc62h6dek09tahcUx0yHWOxmWkU03b3j4Nia/cZR6yx5D6PQ5WO++ftJ/SlAWodMKkm9
         1aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238654; x=1794843454;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=67EAGkQ4nFUyxDwDN3EnN/s3MSpyl1/wArd3b/Zl6F8=;
        b=wy+28o0Nt+oeWIqJuNqi8Qqg9Soc+C8uwCli72Zif8SFdkmZZQoivWhhaHTucGzzXU
         C7u4T2Ol1g6K/WsrK2yKjkc33axF5skfcKsMYuMs4zo/KBVlWxQ5tRGQqwvMZQFEX5CL
         qbG6CX5jU5rB+4K0hlI43ZmE65lbkuknvtpumqSThWnhE0QX+nTnISncfKFQSQoi/XQ0
         Ne1C0naFmirtr5iXGbd6YRh7pTPXZS+jzEtoQ5dIE3juaa3yqnmYjeAP2u0JCcBrYnbO
         sgYqSA+lhqZtTkWXLIgqoJviAAer4hNjVTHlZeejIIJDfqqV4XA9HPu9BOdMglmFJbZc
         vY4Q==
X-Forwarded-Encrypted: i=1; AL+hErGMAFvxT5wixMOd+Er2XrxfsiKW77Lg/eDi2RiwabkhEKk6GV0VttLqiqd0lnzafA1RMGsdLcfeiw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+v4c/me+C5UdKOIT0iho12L+RZQcx4wbisFaWORC6r7GTFlIfn
	mDlYH7278PXRXkxezqVJmOwiIvhEnnuHVVJn+pZSMAkxXEVllLcqEW8tymHQ5TN3b3SAR+TfYNM
	u4CjLHQkfMJg/XjbWQAuVKFgHVfuWLFqyjvkYegRD3w==
X-Gm-Gg: AYBFou1Y9sBEXQ7BPzZzRdbUlUMV/Mt2MRpqaRjx8S292rPXKAEJbRxt9FUD4apjUZ5
	upUf1yqjGl3CeIzGZwvf34yRYKePx1Yy77gfniRQqY/Gxv62tRH5GIyvmpBHzAc4QEnGLfFfzl2
	IkKwJnpBX0TZgRqngCQTO43uj0zzKfqGkK1PbkX3sjCmUl8wGuk1v1PuSdXu38ehuLMGWan8nFg
	OOJ82JCakh3LFznM94U6NuKrjzxH1NC3Vtz7gmwCx4NSUvMCuIG5ThvUyV5ghm5aP+CziFDRMeV
	YD4dgZucMshnlmwJ0AYlxqrvgL7lMKQN18S42MVSDU3x02UCAxb9nCjNm6JPJwPDPo9oPrTCe8G
	iUBZ2YZKeaZeKi4U/nUDDnHI3xjRdVvBaugQOuKNmq6f4/9dTbdbSE4dt1sVwl9YbbFjL9A==
X-Received: by 2002:a05:6402:5289:b0:6b4:602d:f1f7 with SMTP id
 4fb4d7f45d1cf-6b7224201a5mr2863676a12.20.1794238653840; Mon, 09 Nov 2026
 07:37:33 -0800 (PST)
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
 <20261106151947.3991524-7-vincent.guittot@linaro.org> <au7SabL5pfbsApyB@scheduler.schedules>
 <20261109135553.GC2668564@noisy.programming.kicks-ass.net> <avHR3lIV2TB9SWSZ@scheduler.schedules>
In-Reply-To: <avHR3lIV2TB9SWSZ@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:37:21 +0100
X-Gm-Features: AclHuK811qKUEGatxNoqg1c1GOx20pgleT3TGIXPs1QZ03pxVoNJcJkfBXVbIS8
Message-ID: <CAKfTPtCQP5uhmFOyJimoOA4zsVT5k3TUCDS28JOLrCcxoO1Oyg@mail.gmail.com>
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
To: Kayra Cizmeci <kayracizmeci@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 15:15, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Mon, Nov 09, 2026 at 02:55:53PM +0100, Peter Zijlstra wrote:
> > On Sat, Nov 07, 2026 at 11:57:12AM +0300, Kayra Cizmeci wrote:
> >
> > > (My editor got crazy, so I had to copy this diff :<)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 262626455497..8b0dd858f332 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
> > >
> > >  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
> > >  {
> > > -   if (p->se.slice < get_rq_min_slice(rq))
> > > -           return true;
> > > -
> > > -   return false;
> > > +   return p->se.slice < get_rq_min_slice(rq) &&
> > > +           READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
> > >  }
> >
> > that wants to be rcu_dereference_all() or somesuch, rather than
> > READ_ONCE().
>
> Ah, my bad :-).
>
> >
> > The think I noticed is that it will only select one slice_cpu; it will
> > not consider another once its has found one.
> >
> > This means it picks the oldest option, rather than the most recent one.

Yes, I followed the same logic as when finding an idle CPU to limit overhead.

>
> So you mean by the time CPU loop ends, the CPU that we selected
> might not be a good option anymore.
>
> > And given this is all racy as heck, the most recent one might in fact be
> > the better choice. It will have had less time to go stale.

patch 20 takes care of such situation whereas several task select the same CPU

> >
>
> Makes sense to me. So then we gonna overwrite slice_cpu everytime we
> find a new one?
>
>
> Cheers,
>
> Kayra
