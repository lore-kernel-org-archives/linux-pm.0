Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC009448CEC
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793126; cv=pass; b=Zos2me05HzM3QLzN5XmboJdodXWrpi2Zh43GTE4Pyt9abc12c87Bfw0sA/1+muy27suT/hNmBRw/y4dGpMR6RUd7jRTG7PflN0EtNBHCnHXoboSehEwvLSxwAn3rK+hISO0Te2jAmb8BSIYH4wL6s+B2QygtM9D0SKVoiXhiT7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793126; c=relaxed/simple;
	bh=+cgBnKpA956E9oC3dPcEvrFaJuDQAJAIwVEJgcDrCgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIe9H0VXRPDB4uG42LyKy27dhHHnEywPDAEl++18DEGUw10r2uEz94l5AoUoij9EuZnAYtx/VXFdAU4mcX620kE3V7yY67jS+YFb0rZhQ+jTk8Qt75ZM9Jl3Tdxu4x8YrI+NMPAnNU+8qtLv7LTq9eIIx1MkxjjKm8t6IB1Rv0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eyn6+JVN; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eyn6+JVN"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c31a34de844so239143466b.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 01:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791793123; cv=none;
        d=google.com; s=arc-20260327;
        b=ObVvdA3DQrM/rsW7kWanvvNLHbzWTX5Wy4cqZc/V7dW7zISNy0GhIVEmu6+jtmsJPY
         zFq5kOZXg7d9ehlPQiLpJgkZsNdCsFGEZqidcpZjBEyd+2AyTp0eLzG1fp+hORvH8lAu
         If36bm9V+YQ2i4Y0t7XmvcWTtYV3Y6MXontck14Va/m8cVvVRfAnxpogFL/X0juKZLBS
         xvqlJD4/Aocb0ZWUus4g0XJjAakiCEcGzIsso65YfU49dtU2SabgdmvgntmnvRiwCXGS
         3makwDpJwjobiz1/sGlpMcl7lo7WPAL389JggZUMBKZunjy9J+6XQ7+RPzhukS6/c3B1
         zLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zSGc2gSvInI+9O2ij46iITf1yj50GR8jSWXc3T4EcG4=;
        fh=w4V6Qxqlcp4HvBJdRgB8BS6jPiVqd0pTzkCGcE/OaFc=;
        b=ajHehOnU0i8naLWVtIw3DUB8bKYszUWp02olTsx1DmkdmH4PlCICLBmXA3LHnVSeBn
         NiahWtOP56RUuvHEKFWFY/Kkx1Z2HqEBC/6UWOSxJZo3hYOeA6hFOV67axe8y7t4Hmx6
         vdVCs3GsYDulqIJNTAnS6h5eNZ9rSSVjPNy3NpupVWVBQIH5g44dcS2DLHFHOAycLQu5
         fSiuJ6hri8QzLAHTE1v8FgZ+3C0/pn1Vy86uhQM4DFm/13b8+dNyAo9uAh7s5RwxPG9B
         MvA3b+9/J9Fq3L4I0NB94plWRL1to0khJ8jSXym6AQ0f+ydruTtPydv68GlfNM47v2Vj
         iknw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791793123; x=1792397923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zSGc2gSvInI+9O2ij46iITf1yj50GR8jSWXc3T4EcG4=;
        b=eyn6+JVNq6toaTEpom54udG10HGMfVRoqi5ipDvof/sRly/8NHLD3n6Kt/9oTjRJ4t
         BYUK18Iod//l3EDN9mTJIl3KuguTqXrR4pBtp17FUdEIXG9tDIAiJCSz8swISpMOYJDN
         UZ3Fb6SIxgzm3R2M7YY0E22ITiNzpj3PGSgwrid9NDPKi4XKyJXu6WkAXME4uS5hW1MC
         K4D/+unTFruqKsXLUY/LfSnXLFaZA5InYInlIhlSMJPDvuswDwjZJ5OvMXmTB9996lxm
         b3WNaCsufIP2GxHGzV/58VUTi6/mCzKZRK/7Y+Jr/cKy8E5TEDBvTO9OGTRmkW0/nrG/
         OpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793123; x=1792397923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zSGc2gSvInI+9O2ij46iITf1yj50GR8jSWXc3T4EcG4=;
        b=aEN4pgxn1iJXmsu/VN/b1TdiMG0eeD0YkJEQknPpDlE8ySgTbXwYR4FtPyTWemP/VX
         IPEfpEHvdsH9qbR1hPF+HbtDZ2r4D8lmyF+XKOzIwVKXKp1ZE8HxOntz5qxGzyRmfZM0
         cdnDPLkdrjF9E2Bm7TdGv3ewtNl9cBcAuMSEs4PoH1d6wEyaRLDi8eupmE9UplDj05na
         7F6KfNrwIJI+W33rX1Z2NnANCEDxhIabOTnDE3QiAwEncjvartDvXa+eYBsxNWXn9NcT
         FKK/VSV3DWAiXynMDoP1TySpElayeTOHBwHisBxnI1ueGNBB0oNkfeGJks8696fBNwmu
         uRSg==
X-Forwarded-Encrypted: i=1; AKwUvByo7SC43h2IFHEW6ChGsjBeht1wC7j1uaLDWa1IPsowmHA2LeW7hNkirWJojk1N8hWBWa/idiKL5A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLM60SO2vQUUCrq5carXWsPFwpcIxc18OhzcCLGokGUJpkLiurW
	v0PoEkRIfVvmB3/lXyo0nRL8piqa2o4CBcHOkjsNF6KfFG5mEjVMfSa7dvLEj4T4GxmLt6/2Fwu
	ifO9dyXycD7zWkCMvVTs1HHeRxBrpyuEDkA+yX0x7Xg==
X-Gm-Gg: AYBFou3ZBBad9A+dRcD6Me2+m6oqfgerL0ULav9TBpt93kWB5/FYOND6VUFonpw3CFz
	jD83iqV23IcU6vq485oEfUxSGngj/hFxyseCgzKquOUbfiXKfye25P1yeBmzanDyiUhxNYWhuhN
	0NWsS/rrP31uE1ewIb75ab6VSmBoRCA1P9OzwXd+jCZ6CHHC+vgNjUjgt2Zr0Vo58aWILHkVRx7
	xjwxN+jT8GOdd8+cjNz9ekAQYtgVa41xyixs/3Fiiuj4GSnndcX5xQfGdHwAHCCjhZXP77uWPhP
	EcX4aM8tNdStzYkK84tP76mzAHaxOABG5H+Yzw4RouHfu++4EXdf36PiXmYWFl5xO4vJ+2rOmBh
	fryZVDPdj2ikD
X-Received: by 2002:a17:907:d1a:b0:c2a:704c:8c8e with SMTP id
 a640c23a62f3a-c31a9fced4fmr940287766b.11.1791793122980; Mon, 12 Oct 2026
 01:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtCAbreGDhesDmFNvXEzjj+anmOH1=jqT-1B6Lfj0FfPqw@mail.gmail.com>
 <20261011174038.5334-1-kayracizmeci@gmail.com>
In-Reply-To: <20261011174038.5334-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Oct 2026 10:18:30 +0200
X-Gm-Features: AclHuK-DP5qVnsuYOeIrtkpyOkecXNVv-1nV6z-W92W9g6i97Pk7RW1tEN3H67A
Message-ID: <CAKfTPtBDcfk+TEEjD07RBLpCAusKqa0K4AWuFrcCtdw9uGsXCQ@mail.gmail.com>
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Oct 2026 at 19:40, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > >
> > > On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > >
> > > > >       task_tick_cache(rq, curr);
> > > > >
> > > > > -     update_misfit_status(curr, rq);
> > > > > -     check_update_overutilized_status(task_rq(curr));
> > > > > +     if (!tick_pushable_task(curr, rq, rf)) {
> > > > > +             update_misfit_status(curr, rq);
> > > > > +             check_update_overutilized_status(task_rq(curr));
> > > > > +     }
> > > > >
> > > > >       task_tick_core(rq, curr);
> > > > >  }
> > > >
> > > > Hm.
> > > >
> > > > I think this mechanism added on here does not works.
> > >
> > > Ah yes, while factorizing the code, I removed this main diff between
> > > tick and put events
>
> > In fact this is on purpose.
> > fair_check_pushable_task() is the function that is called to decide
> > wether we try to push or not a task. In the case of short task, we
> > will not push a task that is already alone on the rq
>
> I'm confused. So, is the added tick push mechanism not working at all
> on purpose? For future use or something IDK.

The push mecanism part is generic and includes a push on put prev and
a push on tick when the task is alone and never put back in the
runnable list. For short slice tasks, we don't use the push on tick as
there is no reason to push a short slice task that is alone on the
cpu. The push on tick will be useful for other cases like misfit task,
EAS and cache aware. The latters are not part of this patch

>
> Before the fair_check_pushable_task call on tick_pushable_task():
>
> if (rq->nr_running > 1)
>         return false;
>
> So now at the rest of the function, nr_running have to be equal or smaller than 1.
>
> We call fair_check_pushable_task() with next = NULL.
>
> There are only 2 paths that can return true, one of them requires next to be true,
> so it never works. The other one:
>
> if (check_pushable_short_task(rq, p))
>         return true;
>
> And check_pushable_short_task() does this:
>
> if (cfs_rq->h_nr_runnable <= 1)
>         return false;
>
> As I know, h_nr_runnable should be smaller than (or equal maybe) to nr_running.
>
> nr_running can be 1 max, so if h_nr_runnable can't pass nr_running it will
> always be smaller or equal to 1.
>
> Maybe I'm missing something from the start :-)
>
> Thanks,
>
> Kayra
>
