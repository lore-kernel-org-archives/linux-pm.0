Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C044606A
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962472; cv=pass; b=RF9Cy2j6MW7Z2ZmcDQdow8ZVXdBe6z8x30xU01P7PtIsu6a6lt+/cfgCgeo2M8INUNcnuApafYv+RBKjT6RvWt/dMNKexmeDeZ6ItSsTJJ7X+30V71dzh3kv9BPnDNCqc5/dfiGBCHY7QTMIgoLhWWB9SvKeebUD+aQ7T88rsdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962472; c=relaxed/simple;
	bh=YChBavy9/hT84sGYMDIbdBzY/1bKyPcMNTRHv9aVaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ongEuYTvwksBrklTUPoVbe/NrWbG9rpfydHb92psqP/4Y6On3kYPV6BiblMDDmO5IpRiatMv5GlIQ/CQPCt9FQWXhZaKgjampuKPkkQWxzxE7ciLIlKAvxH0f7T2e+VHPSI355Oqt0K6Yy7PpX2HvI0f1NDooN0a0Aryp88CdHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CxnY1zy3; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxnY1zy3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c31a34de844so94559766b.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 00:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791962469; cv=none;
        d=google.com; s=arc-20260327;
        b=K5+MnI9vuIMtxKDZTj/f772yn/bgeLoK50ibwpNrEnChu5RQwbNB6myfRlHN9BvBKY
         4ijlAUTD0QHg8jHqVL0ztMHLG+W3oOY8Q1S9PrEERtsubSUCxN9MDCoRUUpKYEqFTLWL
         FTHMtXq12KOO/2k8RnjH8j8UJw41N3SV4oIFFPiTRfZ9JhKr7w/v2uLEWZxVrpNC3BWA
         HrTGlAGS7KPr6jCKDimtUtrpHvEADNa/xVtu/HK6mfPWk+uArGxnmNviP8HTuCqoxEf3
         vauWZbqdMlFFzqiZIFPi7Q700Vw1IoLNA4ZUqQLNePKAJs+mqF7/SR/7lmsWMNQ5t+fq
         4s+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CF+KclfBDMXfeuygyCssleqkU5i6V8LQfkd3LIo/AIg=;
        fh=A8rUTNoppm3Udd8jqQfvJQMIwFVCOhQyiVrcDY2nNGc=;
        b=cp0Mr8luNTrqXaQPq1aKCegYYxvg5kUkFLmvGv7weKA017X4MjauCMsJwqASP/Fcb1
         EV5FZkJc5VRsuruyLS3ZQWB9zheL13TyBy3WdzitRpwfCE0QnSXMItD6JvNWSF78RQeL
         azR4qSEbHd91yk1rL8PjXx96Ei7/C/S4BhJ/w5dTKLKULqPcbsXNuvDcI9VN8hL7GqTR
         myf9gwzH2IQ/nK0Po88C/KUqvgjyuxvTB3aI7KC6ncRxVhV/xNmgPbK0gtLwztrAH+9p
         7ormxjGlgkMWWMKwanOnIOyKZziucFPOy1mO42XIvMIeQJHmnx4N0Fz+XW03NHBtoyVF
         9N+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791962469; x=1792567269; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CF+KclfBDMXfeuygyCssleqkU5i6V8LQfkd3LIo/AIg=;
        b=CxnY1zy3rRbqomcvoq+HCTGvn12X+9FdrAIlegJVeUuR7OW41T9Og++FojsBxS7eLa
         hZnMa0r8/90LCSLhOFwkZFsGWTuc4J1uolRaOrdLrEakdHJtxPgYGRULtvIQ55HQ9NQ5
         mnFhsfuXbc2eJgF43GwORxNxz5p0NwxGNJISiYHpQhXzFHhCgm6Y1UO5wtK2alMb585Z
         cnPCjkRB8QYIyuzYCJVHgJqHbkjg/dMerKcIpGc+MW6Dc3KPO8cJHoRuerVlaajXU6wU
         4B3lBPSR2B5z8UnaE+duO0dMFBU5KW9Upl06szXK9ekkFffYkhORfQ7zdpzaA6cVP9Ot
         qnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962469; x=1792567269;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CF+KclfBDMXfeuygyCssleqkU5i6V8LQfkd3LIo/AIg=;
        b=uJ+MkIqtptikPAqpH+VFGX05AvWPJk2eViYwYOZrUoCy7B4qp3kym3H5Tkp/ogOtwb
         4NH/RQp7o74D/wfb/DQjh1BkOdKu2fJttLpMNj9Gtb6wYs0XIr4azPszlFEwDFLqy8N5
         gAggAJz1A2GnMAQnmh9baYBrtDJfQA/BKHakBeVAwTNuSWqQE6LFTSZuCfSiddI5PLie
         I5a2D/l5CpBUDovSzrHFRe0rWBPKxY3+NzdTtFn2uIEG5YOP8AWg8LxuQyzELdbxJFaU
         /vOi/vhaUCvDbFPK0dun5NrE79k9CAQqKrw4OMnG0wUd6uXEN6yutUzO67aKztP3rEJg
         pYuw==
X-Forwarded-Encrypted: i=1; AKwUvBz7ypAMgZTJvMoU708gVogsHYUbPBK+UXYeTf3GCUEFPd4Zqut4rFuUc9on1RHIvIzY7xC2LaRjSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLkoiRiJ6MvNA+CpXK86e2iZw4FVAUgMH03ey03bGQ+intEqyA
	i2Myn+pa5y2DkyKdQpdVYOgAl77npMX58ujwxms+ND7farf4zG1yJJffRx+UrWgk7vqGw/MUokv
	3dr0JCawC53rXVvb31p5OfkRtImk23w/69o9EY4drB3Ptur9u9ROS0iE=
X-Gm-Gg: AYBFou0gjU3Ywbayegntf3Im8s5OwsEFhbiTkUxsZd6QFoE00BssCJg9uW/zyyKcg9q
	jB5u5bmOx1ICXuzwnN0sT/NHSIYLIAFLHIqoFROHY2lxTxK2eO58vo1gFE9ndMGIj3f1d7vyM++
	KKphIFAWQdqhOk6EwAGTBLAjitrFF04cMg2UpywQkKHNnKGFp1QmV5p8PfXDROAqguxlU0opH1D
	0cQAVzzAUyJt7EpEmA9Q8fzwYxcHJNLJ3oFbhudWy70Pd+MQqlN59GPwphOpY0Ty7h4Fc16kmn6
	Mfw2R8a5TkJWFHcPoWr6RnQjRZmHtq6rGJgsDY6ISPRmDivNoTSYZrzXyAfeX1sel0D7SGh9FnB
	2huDUVsWYjqw=
X-Received: by 2002:a17:907:e0db:20b0:c35:d50a:1356 with SMTP id
 a640c23a62f3a-c35d50a286cmr419508866b.42.1791962469352; Wed, 14 Oct 2026
 00:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <asWyZtW7zPVo3k-A@chenyu-dev>
 <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
 <aspc8doovTKdBqPC@chenyu-dev> <CAKfTPtAy-n5_Dj-9x2qxcu=i7eo9DmZ2aaxig_nbyNDbP2m_Mw@mail.gmail.com>
 <as2-2b417B8ZaFdO@chenyu-dev>
In-Reply-To: <as2-2b417B8ZaFdO@chenyu-dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Oct 2026 09:20:58 +0200
X-Gm-Features: AclHuK8pAU8JrMEVjSxceEUuYpPE0kaNBSBk1NHutmnkX7B9KN-NWtHcn7JJxf0
Message-ID: <CAKfTPtDB=-NwC=wpv3KiFXe4MwFTs5NTzNcYP00onx7OT967QQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 at 07:30, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Mon, Oct 12, 2026 at 11:18:04AM +0200, Vincent Guittot wrote:
> > On Sat, 10 Oct 2026 at 17:55, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > On Fri, Oct 09, 2026 at 04:31:40PM +0200, Vincent Guittot wrote:
> > > > On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > [ ... ]
> > >
> > > > > @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> > > > >         if (select_flags & WF_TTWU)
> > > > >                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > > > >
> > > > > +       /*
> > > > > +        * Only a push triggered by cache aware scheduling will push the
> > > > > +        * task towards its preferred LLC. Pushes for other reasons, like short
> > > > > +        * slice task, uses the default push strategy.
> > > > > +        */
> > > > > +       push_cpu = -1;
> > > > > +       if (select_flags & WF_RQ_PUSH)
> > > > > +               push_cpu = check_pushable_cache_task(prev_cpu, p);
> > > >
> > > > Is there any reason that you do'nt want to migrate the task at wakeup too ?
> > > >
> > >
> > > The wakeup path seems to be too fast to aggregate the tasks, so that multiple
> > > CPUs try to migrate the task to the same LLC without synchronization - a task
> > > bouncing issue was observed when cache-aware migration was enabled in the wakeup
> > > path. We can double-check in the latest kernel to see if that is still the case,
> > > and to see if we can mitigate that.
> >
> > Yeah, the goal is to use the same select function for all events;
> > wakeup and push events should be seen as the same event
> >
> > Also you should separate the check for adding the task in the pushable
> > list in fair_check_pushable_task from the decision to select pref_cpu
> > in select_task_rq_fair. The check added in fair_check_pushable_task is
> > mainly used to decide if it worth going deeper in the decision with
> > select_task_rq_fair
> >
>
> Do you mean the check in fair_check_pushable_task() should be lightweight
> and let select_task_rq_fair() make the decision as to which CPU the task
> should be migrated to, because the former does not hold pi_lock and thus
> should be best-effort? OK, let me adjust the code.

Yes and fair_check_pushable_task can be called quite often

Vincent

>
> thanks,
> Chenyu
>
> > Vincent
> >
> > >
> > > thanks,
> > > Chenyu
