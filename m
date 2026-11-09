Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240894;
	b=sDEoR6NJQWXb8iLYKLbipG5PC5D7alzSiGoRTJSxxJkmt2bdqwBwKKYXBkgOkiR02oMj
	 y6s6mSBMQWSuiqavDIZ+Ms0v1Q2s/DJF+eH4O5RCcVfb32wx/6/sV4YKlo4nakc7D9pBB
	 XdvM2Ae2UfK1AHCNN+lrqMok3Na6KdaXfSMPge2tfR3MNM3KNK538/YGzLjgEPNkZYSwC
	 0fT8OXD1bEYfBxGTC+KOOkiBTaNazO49CvikSUP6LiTQH3xCnoe+s27IN+nfsFu1vI7WJ
	 bK7/Q6cARvS4TrD3BwbSeT7t3hr6HcvCfqL6uOv90mlm41KjZGbLSHG9luWhQn9XYlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
	b=UcTwVJ8hh6IeGBdcKhuT3m+V7zaIITsBtAwMJYav1uylliC8ANIvKp0V9SZcQJCe3CPS
	 autCCohTe63/IOi97r/dlkUBHZARfUUomvqb0gFgXbNwS1gizA34m20JiAzAnp8o9098l
	 md15lDq9D1/kFMe6oawBQTxlpMDvN3xwTcBpIOEKfXaVB/7gI82EZmtVMChnGzMFrp9SE
	 +0Ey1z5UltgnpFbjr8bPNloOqrFbYSlNI9QBOnVZR1FlGGo52ohmbvbFhFOc5z5JR7syq
	 x5Vo2MQk+1zb30DrbvLi3Nj2L10gmVjQZ7KJjJSakm0oCIGVLCmiAppwXYjLhhQvyEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IKT4xzwd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E277606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 16:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E277606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IKT4xzwd
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so1381232a12.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 08:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240893; cv=none;
        d=google.com; s=arc-20260327;
        b=KF+0eEQu2D/RTjSd0EmncaqfmRzpfr+fwXxMOHQS4IyWsyqCl1aW80i1FDjdp1qJqJ
         ifDO6gq68nvZFTD16JanPMRNmrknfrvfxo/mA3/ANbkNLbkExeT1A18fFLTiR2fFScpv
         gI7VpeS3tlWdKFKXRUNWhgX9edX8TVf5OnTx2LUvaq1Qx9l4ESsXl+ayTiUT8m918cci
         XBy551wW7Q3TwhSfJpyOO4gdotUDzn8JNPnoYlTfl61Q02/CKwogNvxQI8SE0AVqDrem
         QWXSON0NqvuM5KLh5dLDUoJFZgYg3bqDmg3WHRd5124onxoP5VnRub3dhb8SM4JZTjp/
         FcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
        fh=LaSEt8k7X5NrQGy5GK+XUurg94V/x4AJ2c8kCHXAM9Q=;
        b=sN7RN/Q5Zhsz84a0QFnpVp/tSxMtCxZnwNM54jgntOYfRr7kjop+gEsC/F6cR/OtqD
         iuo1+qz0ZeeqqUxS4bG3GXInOWcwW2Wwc29jvpAe6OICVPb1Gl/9iOdqk1PGLP10Rok7
         SPszusGg2A7GhNKxWYfR+8Is/gNJj6clLqbsqmkGf7ZQcRUQvJQjYPVrCKK84ixo8sHV
         HZBte6H14GeAmXP+NzzUpj8TdM7qKiYWRDWuEgaCv3tgnJyce7NGVzMsdrLh1J3gpv7X
         JS+Lz3OrK3nvLb2Aj5Lx93zK2JBbL/XjfCfXFVLq51C80uQ5hk6ismH2iTgRF6GEV2ga
         Xgpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794240893; x=1794845693; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
        b=IKT4xzwdBITINaAmi9Te00xNxWBY8gPeyVTW7S5qwm51AkeDkhtCoh5jhu7fGcTHR3
         6QTN8dTJ2oR3dvu5TVx5U/BeCfqy8FOonrfaekGc1/+N80gsHUkjbwnGL/Ox6Lce6IuW
         CohYZ++fW208MYiAW877VmLQLzbXNIYl+hbW144I5sp5ErPT0HPckXjp8otNdzyyCZSB
         8m6vQzu5PvMtPN+Ca4gQvLUyOU6bmNQqcipW7Jm2aJCT2/FJXgVQKdzHHByoztNKGXSc
         Tb7zY9NSZKhtObVjil9Es9DolX02wmyjl4OJ5FqNkskpBSgPccF3K/vIAQmt7VfarSl7
         89Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240893; x=1794845693;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
        b=Xp4ATZysfrGEjz7yKH/5oPy9Dc3MwAAvStIj/BtFhu4HFRDxU1rpRWZ9U2loz5pJxe
         F6pZPd53xiSYFOBq2SGACmT4aGTZrsYL4h9v7cfyT6bupOsZqWgtur6WPWJa/pV3sdRd
         h+dj1T8He2wvIK4YaKjx9j9V7oic/XS572IOenUtR3jPLi9gx4TGMHo9G10sGGh1P4HT
         tWX48xizjRPMpoJ8ewYuuOU8OnqiqvUj1zipvYk7qOn4WUJ8kaMqRhwNQ1bNUfw14W0L
         QPQJ7nqfK1N16y+zS3kqp4P23OeronD13M/SySJEMxBFgTnsESsaUKOLDvRgHnp+AkXF
         JpZg==
X-Forwarded-Encrypted: i=1; AL+hErH5bf7RHpehnPliii7qOz6azT6MiNGjhd6nG4dOV4r6KfRLnzfM+tQrp6TWZ/+sfYkn2Z56wpXsPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9s43TsAuJO7r948cJqUmvsl8lPcy1GLct3i9wUhlBOToLyJn63
	7558uwAzuVQp/A8HIsV1zcowN92vxc1OvY8NabqGI54UKyHtst1um8NMBVVlklwcBrOfwiD7MSV
	McVBb1vgs/VIThX1W2gGmJtwChfI+1vC3f4fZUiXK2jMz/Ghr6hnGs2A=
X-Gm-Gg: AYBFou3QR9Gt+NtuJjYhlgs9N7Nr5COlHwXjUY7Lfhdaq5U0/e8AnxEKvX4coqMWuao
	lU9y36Ag4MeSvxE8tpV78JGlG/lEO6RosIhsIoEJs1oZBuLkMPvT10ZjtJbVQrC1k3497h2h3lH
	XPafEcXuJS+BqFKvmJuSbLZU8YLAVbko4/yIFdU2wA22bnAXaOANHFAIorSPK0pOyi8t2qGcRE5
	2bvav3bTZppSBdpRg4VQehsAyUOUAVKd8vRjbcOx2MiI1c2hSigzzfwcDRSkBUdNjhE7HyWHXh8
	SufOWKWuLkktRU7tmHAs+bEFIP+wi+yJHb8IsBp10MNhUAni40Ov8iv4cRAD8pS9M1J0fCqgrK9
	zVMsdnVcZKscLXrHwoRxtOVpBpIgCo+gVjQgubnmBkyf1hVOJhY52kmQ6wnf/8rBnnZ5URA==
X-Received: by 2002:aa7:d7d5:0:b0:6b6:e808:9701 with SMTP id
 4fb4d7f45d1cf-6b755e6b4aamr53584a12.1.1794240892542; Mon, 09 Nov 2026
 08:14:52 -0800 (PST)
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
In-Reply-To: <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 17:14:39 +0100
X-Gm-Features: AclHuK8Lril_R7chVytS1fQiJPDmi6Vo891N6VuKxGIj8nfdzRAKgkQea7WMEGA
Message-ID: <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
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

On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
>
> > +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (!task_on_rq_queued(p))
> > +             return false;
> > +
> > +     if (p->se.sched_delayed)
> > +             return false;
> > +
> > +     if (p->nr_cpus_allowed <= 1)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> > +{
> > +     if (!__check_pushable_fair_task(rq, p))
> > +             return false;
> > +
> > +     if (next == p)
> > +             return false;
> > +
> > +     return false;
> > +}
>
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (sched_push_task_enabled())
> > +             plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +     plist_node_init(&p->pushable_tasks, p->prio);
> > +     plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
> > +                                struct task_struct *next)
> > +{
> > +     if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> > +             __fair_add_pushable_task(rq, prev);
> > +}
>
>
> Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> use that, rather than adding yet another list? I mean, its used for
> migration, so excluding all pinned tasks actually makes sense.

rq->cfs_tasks can be quite large (we even take a breath during LB)
whereas this list should be 1 task most of the time (except during
wakeup)

>
> Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> MRU per set_next_task_fair() moving the current task to the front.

The plist was only to reuse struct plist_node pushable_tasks; in
struct task that is already there for RT

>
> So reserve iterating rq->cfs_tasks, skipping blocked and current and
> such, should get you much the same over-all.

Yes but I was afraid by the overhead of iterating this list which can
be very long; We have already seen email about bug with thousands of
tasks queued on the rq

>
> That is, why can't push_task_fair() be something like:
>
>         list_for_each_entry_reserve(p, rq->cfs_tasks, se.group_node) {
>
>                 if (!can_push_task(p,..))
>                         continue;
>
>                 ...
>         }
>
> This would result in pushing the task that has not ran longest; which I
> think makes most sense. Hmm?
