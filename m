Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233755;
	b=ENNDes0gFiLJrI5QzixqEFbQiI4rJIqjKikTrIscjLHQoEjSTru67q4blAISFwHB2MKb
	 Bvnrgc/wU812SX3b8ZJbae0+o8Bx7RikLb0w41Vq/pAv3ccYppbYSEifTJUfGpEclVATy
	 t6XBwqkPX9ASdtrr59Jx9QrmcPpAWhGBoM3NKsxCYtWXrxVlRsaEVGjo6sUt/tiZnRSL6
	 zDUrVRCN7KXVFwyeH1ibJ7G0kKV/pBkG9dlyHxVjGr2ckumepY08+kqCXy1y4JDIxKk8W
	 3bgCos1df4M2qiYCOkxQq+//OGNHFSMZL1Wbpk7/6jsK3TaS1Q20NxHIXPBIJ+fRoyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BRzYSlxPXB9SayIbet1ssxpRWLhzXzCtSQdIz3Apaiw=;
	b=vYbZN4lIc6TC/pzR0RHTX78V2AUC252HiJDWBtKxeoFIK3/0mPWFF6lHBhkae9b8JEPf
	 Th4WeJHyL8U5++/yYl443OCeq7G3TYRnIrV0dHRVLQsht2i7W8VR79lqyghXw1ysG7zBM
	 KN311AJ1rKeCGP6OIHqXuSEFvde5mS7f5FxxnIZ305f7TkYXMIGeUN69kc8Ol8frsSf3E
	 lbOpAeV9M0/jvVVdzjCfHUja0Vrel33/FWqrp911+65D6WA8JfZIIPtiWNbPY191IaC4Z
	 sWicZCxxv5UFZjlCp2lNjcKkno87polSxEkcRRAMxD5rq76VtpkKU+t687X5ltKmPGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVWEf1Ho;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9C606A326
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D9C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVWEf1Ho
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso2625135e9.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794233753; x=1794838553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRzYSlxPXB9SayIbet1ssxpRWLhzXzCtSQdIz3Apaiw=;
        b=HVWEf1HozV7xPNGU2o+rDt3myeLyN86ifegA2DnnFH2fnxkqpp8ACtc/UcqYnLLmF6
         MkuqR7zOAQI1T/BlqOhQ03kJ11hJfI3YQFZ182AMWimkbpA4HMsck/rT3Goo6dUB0iJa
         d3UK6GI88ejCLl093/6+BxtyG8K0MtEhNvkATo5TQGJ7YXyczmbofwhIHhDO+WKPLzfF
         IA+wMR49GkiQqIOEP4W1shBAm8vFG3JnWpgA92H37H7rfxWAt5t/C+u0GH3N3uz4TKCM
         WaVgxacHYvgShMR+TUCTmS1lRlUKGZlytIqhjL48l0kmt1WGZVpUC5kc9UAT9L6r2rbi
         p+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233753; x=1794838553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRzYSlxPXB9SayIbet1ssxpRWLhzXzCtSQdIz3Apaiw=;
        b=Fi9C+34eWb327zCKyGEAmnm/c5cRjEfh94se5ysWPqNhZnU7FgpEse8BCwe1JwtiSB
         xWgUsyVvx9Q7X/5Lo5Elclfejm08l/oJdtIBGZeEcAER1Yt5u5SPnPWsTb24vIz3NL5w
         qGw6YckAoOXoTzmH8ZozEMCfmBUBKL93RB1yiJTgL/uZoOA0fMz2vVquiKfn4Pv302G6
         MNB9WnB3nrogaq9/yiSIhpO8ofdQ183OYI9VIBimC1EHArQPQxsdJe8wh9ab6Iaa2yOk
         I0nZ9jr1PbF5/PEYAwmoJBW/+Ly027RAGhDmk1KZpd7TdlSXheACM4Mq+OcxG/G+WOQD
         29Jg==
X-Forwarded-Encrypted: i=1; AL+hErG7s4fDz5j+rbsQ+U7sfxApuDkFpJXvVmf9TvSWOWCqTglIRnYKj/CYx0flKmA2zv/3RZVG4Sj66w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EILGBt0GS5YSR8nvgDOcWVdj1f61YQoLD1HGo8sldBTaNVvUz
	BiLudKmZfAE6BVzHUEqI2zzuDXwSaucXhfl5zdkkyqQ64TJQtnkm3+4V
X-Gm-Gg: AYBFou3d7CeQpuG0+Ke/TyDyeSrN3baBXE0jJ4ONblNUNxfpcR27RS8U9oCfCTa9gwp
	lEhovx9avFbRjtHgHKEuOiLErlp8wwxIE+8uLMi9dNDpYNTpZrlqGC9fFBgVlQGuUClAzw+FSa7
	DAW9cPPvULYPg+qp3X/fmait2URsu1rHv+PzExtelucG6tcN+cJeZ2TZj1tHhC9LqXbwgZs8HvS
	I5l95cviDE4fUEOByDpGfvhyV/e5/fTg8lGo74kjh4TxaXNu340Q9F406PPD2uFrI7uqMuazm75
	VVpVlxDoK7+RrKCjMJAwfAvPk/kPi7zv7MUPZKKJw/nBfpr5DbvoZbhf4yOjAzW/u+88Ll4LZz/
	13p8uJ27oRtihALHGPskhizq2XJekRWeHtU0GOQQty7FilfLGufRz5YlCbUbMcR59tsrvaSO8Jb
	tu4wpB2ZC6ipw/rwmzwnoz0WGh+qGGaSPe+KNhAA0XsDWXsrUlCPfP54aWfkbYQ4roqxMqRXQ83
	b7OjHmpXngyrqaRT9hoVp1/N/sHGxWkmskGy0DHOXgyCl0KqbwauYTcHLgI9n6g4TRGOjM9HlwA
	cr37DZyiCog7nwYk95E19rIhuOMKN/PcglGfia7avuigWsfSom+tx8HqGGDXklThKSuxzw89ECC
	O
X-Received: by 2002:a5d:6f04:0:b0:48a:f5c5:d067 with SMTP id ffacd0b85a97d-495810d5813mr7394605f8f.2.1794233753069;
        Mon, 09 Nov 2026 06:15:53 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495966f36besm9520949f8f.14.2026.11.09.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:15:52 -0800 (PST)
Date: Mon, 9 Nov 2026 17:15:48 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting
 CPU
Message-ID: <avHR3lIV2TB9SWSZ@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
 <au7SabL5pfbsApyB@scheduler.schedules>
 <20261109135553.GC2668564@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109135553.GC2668564@noisy.programming.kicks-ass.net>

On Mon, Nov 09, 2026 at 02:55:53PM +0100, Peter Zijlstra wrote:
> On Sat, Nov 07, 2026 at 11:57:12AM +0300, Kayra Cizmeci wrote:
> 
> > (My editor got crazy, so I had to copy this diff :<)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 262626455497..8b0dd858f332 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
> >  
> >  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
> >  {
> > -	if (p->se.slice < get_rq_min_slice(rq))
> > -		return true;
> > -
> > -	return false;
> > +	return p->se.slice < get_rq_min_slice(rq) &&
> > +		READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
> >  }
> 
> that wants to be rcu_dereference_all() or somesuch, rather than
> READ_ONCE().

Ah, my bad :-).

> 
> The think I noticed is that it will only select one slice_cpu; it will
> not consider another once its has found one.
> 
> This means it picks the oldest option, rather than the most recent one.

So you mean by the time CPU loop ends, the CPU that we selected
might not be a good option anymore.

> And given this is all racy as heck, the most recent one might in fact be
> the better choice. It will have had less time to go stale.
> 

Makes sense to me. So then we gonna overwrite slice_cpu everytime we
find a new one?


Cheers,

Kayra
