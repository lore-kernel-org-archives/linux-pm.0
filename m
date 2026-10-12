Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE3373BFE
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796699; cv=pass; b=diuW3POFmqVMUTE+7XlkHq+BgYBTzqhZVCqxfS8v29tlTCue4RcDV7vzTA/SWlqrA90jNvcc2jRwyjnO0hMvmbNZzF3vbImG8yBapWV+XlymfsQl/OD9Lfl37zT21Ar4vUtj9mm8XgjTl9UEJQ7/1cca0L49jzAuR1z6NcOEqsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796699; c=relaxed/simple;
	bh=Qjk7fnAlrbE4/F3NsAOgm3PV1I2II+ar/lUKWdrB090=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhNUmWuaDa3lhZdQkblQe5VVAGOhYV550i0OB1uq+1g+CH02IYe/xyOrlXb3MaSwdazCjrfZ9we5llCV0XxKaGb/J1qCzJd/EPY3cNjtgKx/dzvZo3NX3q1gmrnL06v3z+NZfpmJwKCX9SvixY5eyVIpqkNdzonFOHI+ZvnNSTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMnsCeN/; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMnsCeN/"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c315729ad50so289984066b.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 02:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791796696; cv=none;
        d=google.com; s=arc-20260327;
        b=bHFwL9ShEZ06NpNpY3CcFfKe296zNGdUGiISycuWrHaGu6bGBSCxg//gxDW+/pIgji
         kbY/wjxUvdiXqXEuUEXJ59ZdKByI4AFwROXLcRwqULSyKYzpW0X2WJ9ssrRZUPS20+hM
         BNgrvYzCZcoCHFsb6i9JTXwsInQ9uUnyhDn+FIsRpeCC6hxSj8tFuA0usceR2J6AzSng
         lVSdx2iwjX2LyyQqEjCXY8A7ObxqrWHQ3e2mg+1dz0zQ4jo138SvXw/kcAumefRfX6OY
         AL4ubjyHElfNqJCO9nSnIinu+pk2yNtya0KcuFgenCSBxdJz7OecMafpaDtIypqGygQg
         UPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1biN2HNTY83zhnJs+D3TwuOQxRRYiRudFmWbhPoQzOg=;
        fh=XDyBkxGSKVhMJbTVZQcyiVYgkVYGgckZHMWWcqpJUu4=;
        b=WvFJwZ3wn1GeLagR7hfX8D7tsqNxmsQeDYMcWZm14mN4K62iv9WiwMw2AnpNFz1eBL
         f6P4suJT2ZIcuQZxPHVPZaV3h+5DI5mBsgEDFfDFjf99V+EEI9shXhrQvco9TL7A3EXI
         hnIf06/avhysNkzdfs0YDxoAjCBenoaC0eRH65R1s4PARr/Pofbc8OTU4A7ti7+kDZzb
         YVy67w+z8gf/LoPL94pn+MFAoM/oVvNMaLM6sdvt+21HbAuORaeh38ScF7uEAVT5sGs5
         h3cbcfyxafThEt8rBaicMOUJBhLiD4b1XhRQsb7G4NihTcURWMV8GJO4Hviyx6RWsnHy
         ZVIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791796696; x=1792401496; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1biN2HNTY83zhnJs+D3TwuOQxRRYiRudFmWbhPoQzOg=;
        b=pMnsCeN/KynwljdXrJMzjynLfit6Jn85Nn517Pwz/1Gf2sdNtbjLImH6k7VLnZpwI5
         O+CbuWnWFasQz7Xbnm23C+PnfaJl0oX/8505h+ilCKshlYFh1NUdyHgQBh/+ys6DBJ7J
         TlFxpXCbCJPoDkd+e7hngQXt3lafvlOIacySLmdEODjJNIFSKf+7/o/vu0DgH1T+oRKH
         dfEjU/o5o0dSehOpfaMAE6oJsb0pEOSXOebVIUDB6fOcw83KoaR1tbxqUb87N1bdz8p3
         wXUotbX+kBKpusWbf083XqIaMETyqtuwZ/Vp8T11LKU+giYLezgRF7Fb1RWlZhOj/6Wl
         CC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796696; x=1792401496;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1biN2HNTY83zhnJs+D3TwuOQxRRYiRudFmWbhPoQzOg=;
        b=fbIGZ/5guFcFkHlBCUC2el+20QFn5+VqePBkR2qf0f3xf3oS+iYVZJb4fBCIYWqVl0
         UzVq+X1DcO1OOXShO645GGxNmDVEVwOzf0Hx9sso9fb8TIulmAEatBqmZ0v0GCO7L5sG
         lJxTCrRillRT7H+ubD9hYCAmUdh1VEKkVqgqpyW7SNhMzjmsgbGaoxKWdO5sPXsvmasI
         ZuuZT9ZccUUpxsG18fqA++uIgsO+CUV0ECP9y1rtvLzx4FxJVUdAZtLLE19BW7l0P1y4
         tjpLJ4fBWoF3FAZpRsz/bR8iEaNygPiYDy2c+TF+73i7Vb83+Gr2NaQuUVULc7V3dTfo
         Cwtw==
X-Forwarded-Encrypted: i=1; AKwUvBwgGWIgdm+xiiJ4RfpMwFo3ird8DfONUbjMmxqszH1L/B4VM6dOuypAQQBOPT5ZWsYVxQedotlxLA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJYg8FNx5vtmyzOn1TzzZzlsY/IfxewXPim+gfhDA5XDMGQdW75
	gr5+ax5tNgoVy/jj+HbY+xmeYe3RV6AGI0kiBJ7RSkascI3b/U7a7wmKrVu3HL5NC6PMfrQ2qZE
	a2sIvzbPj0cDVdEl4DMuMCpqHLHbF2Nr6On3tE4CL9A==
X-Gm-Gg: AYBFou1xMEoHcY/L7u2LZ8lyzP2a07HWjz0U4PrSiepwIeDaRrv5O86AFztnFfUmUBQ
	ciXmx49zdbWU1IbUOtY5wgxR6ddkHiCP1zIrOTx/eS7KwhplESEXZdY4Vwc43sHl5jXvr1X951y
	JqCOmgVTB/mQphOc2TgipmbIYXFqekynv95PaVQwK5rCY9VO1FV+5TyzIonkuInEQcx6q0tOlxl
	I0jNPZlvkbtVKgsDVUrsmmW2YwUkL+DlFbqFopaMy6h1YSupgiUWkCFU0+Y2bIUi3Y+ynWOxc8I
	kdvLLt4rP7lrkQ351iiVOMyzERswromkLjBxa05s8rmZ3VpYYcVZBC2ocJx39xJLBdEEcHSu5fq
	Jq3Q2sZq3QPnu
X-Received: by 2002:a17:907:c0b:b0:c29:5215:b2d2 with SMTP id
 a640c23a62f3a-c31aa016eb5mr943230966b.23.1791796696105; Mon, 12 Oct 2026
 02:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <asWyZtW7zPVo3k-A@chenyu-dev>
 <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com> <aspc8doovTKdBqPC@chenyu-dev>
In-Reply-To: <aspc8doovTKdBqPC@chenyu-dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Oct 2026 11:18:04 +0200
X-Gm-Features: AclHuK821TZ5FWAZ4M6gg4tQ483l6POneLRhBIaL6kMutdLqFFMPJC-y16mM1as
Message-ID: <CAKfTPtAy-n5_Dj-9x2qxcu=i7eo9DmZ2aaxig_nbyNDbP2m_Mw@mail.gmail.com>
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

On Sat, 10 Oct 2026 at 17:55, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Fri, Oct 09, 2026 at 04:31:40PM +0200, Vincent Guittot wrote:
> > On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
>
> [ ... ]
>
> > > @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> > >         if (select_flags & WF_TTWU)
> > >                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > >
> > > +       /*
> > > +        * Only a push triggered by cache aware scheduling will push the
> > > +        * task towards its preferred LLC. Pushes for other reasons, like short
> > > +        * slice task, uses the default push strategy.
> > > +        */
> > > +       push_cpu = -1;
> > > +       if (select_flags & WF_RQ_PUSH)
> > > +               push_cpu = check_pushable_cache_task(prev_cpu, p);
> >
> > Is there any reason that you do'nt want to migrate the task at wakeup too ?
> >
>
> The wakeup path seems to be too fast to aggregate the tasks, so that multiple
> CPUs try to migrate the task to the same LLC without synchronization - a task
> bouncing issue was observed when cache-aware migration was enabled in the wakeup
> path. We can double-check in the latest kernel to see if that is still the case,
> and to see if we can mitigate that.

Yeah, the goal is to use the same select function for all events;
wakeup and push events should be seen as the same event

Also you should separate the check for adding the task in the pushable
list in fair_check_pushable_task from the decision to select pref_cpu
in select_task_rq_fair. The check added in fair_check_pushable_task is
mainly used to decide if it worth going deeper in the decision with
select_task_rq_fair

Vincent

>
> thanks,
> Chenyu
