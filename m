Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC53475335
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252474; cv=pass; b=nwL+BIz66uUMHtKW5LxVYdDNrZjIzLtq8qY+xISYPUKncfyc+vVz4Fc/dqib5SimdhyfmaubhKiFHNKyJdjME0O8oSSAwT5CkHFBg8satxaPW38yHw1HzVsQLDjhK9l8Kqq//FZDdZCC4wm/M+IBkYbOSLrdm+h4Mf514R13vGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252474; c=relaxed/simple;
	bh=K9ufhPEWTbcGbUWPnsFi5tG5G32ivdBgHbHB+/9JtVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeLlsUZR4DxG7m7IFT4OY7iQYupt2y1OdXI4bOr5W7mpbYA6V6BOxQwmPNYFoVbV2KJW2DWnDp1Q6usFCh4a8sxwJ8pJyMG0x+nO4UW4zcYz2y+6bLWTp7dR6TU94/fL/4zePcjgeOvJgzr7+T9/yc2IrI+w8ZKC+g5tuEf3g+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxOLFp8z; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxOLFp8z"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530e8c6fb80so215891cf.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 05:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252472; cv=none;
        d=google.com; s=arc-20260327;
        b=rUBFiymTuJJWwlzU7otDOVVdM5//T+OPsYXWkBynjwGUjsUuPAZtnyfX+CLhdhbz+F
         RvwmQXBdfaUf0Ksz1LM6zBP+QGj/ZX0SA/4tNycZcqtw5o0/smwb8I0z8see35ULp2YH
         yKOOAokJydWerhbSrtwXaR9MF6Un4iZScCVJP8VHpuNRHvcGsr3ZmsBwV+rtE33wvpBF
         f/7CcC2Qcan6+kGGatU44WMYULrSdhzWCx9IsVg9woGY41fCm46Ot1UG30Gs7Khz3tPC
         K9KriV3dzHEkEu/2uP8u7/ceK5Kcs2Td3bEbTje04Rw6arXJMuQZ+iQe3EW0le8i8e6e
         lAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NkGH7LeMJDJfHMf9D0brPKFR1SEB0UnnB2ab6h95oe4=;
        fh=Lq6m5xb6el+CkY363euxH82ELd5hC3NoSSt7V8soLlo=;
        b=pLHlA0PVfX3w4GxAZBZBliHH0aMNKQwugmBITtQkD/uY8BgjaqPTCpj/78kwvXPNoP
         rZwwK9jTGUKllUbwbd6ERiIb3Bl7val27gMY08ROuPhrZW9CYNBL3mR/L8r9XKEnXe8S
         zbF3YLiSlSldLJqOBxXFGCoSaYeXZdp4mTJ/EBzQK28F4cEKcm4ES0KafrqKK61Zdsoj
         5a/tUbxulbM9yo0ErQxTizKU0jg+ap1cSqSLQ2/IrMs8EtzcYGL+bk5PWtzYTZk+Wm8x
         F3uyr+PGBxEMAEhM2sP+pq5ctdM3mSs5IzCcIgMIlSWCerWJGEFNK/BWgBXEwpQEyYq1
         vRQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790252472; x=1790857272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NkGH7LeMJDJfHMf9D0brPKFR1SEB0UnnB2ab6h95oe4=;
        b=RxOLFp8zns9PebEfZOT5KCV4HOlHPO51bVjqJXi77VlNxbLzELm0H3mDLQ0YG5FSbP
         iHnwm+NSqxJ6fMldJbBXqaoBzY68es+RwxdL1ReKIX/wWGPpQsaLPH71d6bmCOiCn6l9
         UrbDCzYsyF0jPJE0prMOVEUbVQqjAy2TKax/yaCQVXqQra4x38ey9+i3CTpaD+pOizwV
         CDMvzkDNQBIB2RnIZvX663wd8SAJ5W0bgdUnvLnzjPllJ3qiTF1IcO/N9B8KhX6PUMaU
         lE8o10voXt4eKcpDKrx6JTPn2hnLMemEJ/Lya/Ay6apKDtceIncTxBlInsqPK9sf72dq
         setg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252472; x=1790857272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkGH7LeMJDJfHMf9D0brPKFR1SEB0UnnB2ab6h95oe4=;
        b=FJbQLnHsrWD23pHdYBRIjkAulM/wIgllj1mZ+IuFcqnkaJR6OBsx230zm39r3FEI2s
         SCJTPk+93WTZZd4BIt0RF6e+Z0ahH6OSu/9NomDCXOSMJj4aM1VGh6M3DJbclvnJurl8
         fN3H+qzAbIZVlwuWStc9Qe8L3u5nIisz8lJU52aKkMFZPT8kh7gRmWv89k2fB8/NAKFO
         KI0bRRUo7dsRh5vZhtI3hTlsDYjF4N24gGSQqj4DdAzWy9nDy7MDUhfZE2FbSU7O/2OB
         ADNVIa9axB/ylyvAgqioOVnlEIh1w/SSDcuoBAesQeQMNLlktm/kftjBpBoe4XdNSETv
         IIWA==
X-Forwarded-Encrypted: i=1; AKwUvBxf4/cgdsu4Ha/JirYN2uoveyXAlYAfYAUoSTnOXkmLMV1n0Et0BoRzw7y+xa09PF/VgmzzIzj3Lg==@vger.kernel.org
X-Gm-Message-State: AFuF++kwcVb22Ab40pZX6bUAJRPl7v/8VG3TO5Ds1HvIgp1DusqSOMKb
	Hj4QKxf0A7VsoRlAIVvi2Pgk+pZgsWwp2eOEdGKvOYjBE28/W6zzVXIEdNdT/kqKzGQrBuJkJPz
	3m+sYD6hvHeTYXpAQ1IT70eRdUKC2BKHdn7evjet8
X-Gm-Gg: AYBFou3TotNjDVpTNBNy7KMMiK+pDQHlPzkmFtm5UHnFGoejUhPtjXaSQHN/2zb4skX
	4+SUsq6u+lcQK54IOCjh7hiqTnBML3RhuWeiHTATNLQtyhq1IJrEQhdHgAC+dQnexPz4jjHpVs5
	PxUQvkUCaQqpOTweugeFxrWmwomec+XKHht/HmmdmrZYJM70zULV7/8GjvSDGK3WKKYnd/1kx9t
	P/3JQVkXtiYhNRnHmzCN4Ul/pBR4kCSrPPghBguCSBS7KhVOWKdG7cYX6VmeG6FIC8BDZhfl/hR
	ZpOB+/aTa7c5WQYRbKgrH3hKQ3pFWjCeE8zFocs6YBb01LRZuB4C5tIaXTZ4LUH4otZgeY7NL++
	ZIUx5cwG3
X-Received: by 2002:a05:622a:5507:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-532fe9f468dmr9310531cf.1.1790252471121; Thu, 24 Sep 2026
 05:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922211559.3633398-1-sadrul@google.com> <sqmmgjre63ltp2m6y5ui35hijnnwfljnzjscceunvzmzd5rh6i@us2amzhvtkw7>
In-Reply-To: <sqmmgjre63ltp2m6y5ui35hijnnwfljnzjscceunvzmzd5rh6i@us2amzhvtkw7>
From: Sadrul Chowdhury <sadrul@google.com>
Date: Thu, 24 Sep 2026 08:21:00 -0400
X-Gm-Features: AclHuK89lBo3kLTsEvW7wqXIE_9vbscPCVVxotToLaOHDgnCk-gw32aXdN6iQ4M
Message-ID: <CAKgcGXgfr-hbBj+tc--uD5t3J6Q7zhnSsm17JwU0ZdVhb1ai+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 22-09-26 21:15:58, Sadrul Chowdhury wrote:
> > During system suspend (freeze_processes) and resume (thaw_processes),
> > threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> > try_to_freeze_tasks() executes, it must wake up every sleeping thread
> > with a synthetic signal so the thread can schedule, run try_to_freeze()=
,
> > enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> > all up simultaneously, only for each thread to re-enter ep_poll(),
> > observe no ready I/O events, and call schedule() to go back to sleep.
> >
> > On systems with numerous event-driven daemons (where hundreds of
> > threads idle in event loops), this causes a large wakeup stampede and
> > thousands of redundant context switches per suspend/resume cycle.
> >
> > An earlier attempt to make epoll_wait() freezable in commit 1c441e92120=
1
> > ("epoll: use freezable blocking call") was reverted in commit
> > c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> > reports of userspace corruption (Bugzilla #61781). Under the legacy
> > freezer design, freezable tasks could wake up prematurely while
> > hardware and peripheral drivers were still suspended.
> >
> > With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched=
:
> > Rewrite core freezer logic")), the legacy fake-signal mechanism was
> > replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> > are safely frozen in-place without waking them up, and the scheduler
> > guarantees they cannot be woken until thaw_processes() explicitly clear=
s
> > the frozen state.
> >
> > Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> > ARM64 test device demonstrate that combining this with freezable
> > select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
> > mean at fixed CPU frequency) and reduces context switches during
> > freeze/thaw by 87%.
> >
> > Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
>
> With similar caveat as on patch 2/2 feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>

Thank you for the review!

Regards,
Sadrul

>                                                                 Honza
>
> > ---
> >  fs/eventpoll.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 6cbef8b4c2e0..35992f6457bf 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/rculist.h>
> >  #include <linux/capability.h>
> >  #include <net/busy_poll.h>
> > +#include <linux/freezer.h>
> >
> >  #include <trace/hooks/fs.h>
> >
> > @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct e=
poll_event __user *events,
> >                * the same lock on wakeup ep_poll_callback() side, so it
> >                * is safe to avoid an explicit barrier.
> >                */
> > -             __set_current_state(TASK_INTERRUPTIBLE);
> > +             __set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> >
> >               /*
> >                * Do the final check under the lock. ep_start/done_scan(=
)
> > --
> > 2.55.0.1082.g2b9226bbc0-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
