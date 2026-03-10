Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22830E836
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155649; cv=none; b=nZX8KhnXVsqWTVwzlO7WFO3S4BXvaF410+uVf7Xi4+W5WOdLnPIYd+TGUh50lmt7h01A8HrTJHET1zmDDOAq3xd3urTRMB+UwfoS0Zzs6JOJU9SofPW8zzhovSAwHqIQiPdCUK+BV2ldNvjIu5v6E+ppTUl6ViD2YkZpVdmqhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155649; c=relaxed/simple;
	bh=DnzFg0mcg7DWKinkKUIecJ/4ipRlMZ4tbWqodWV0Qe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W84XOXw31nifCns2vmY70lBaWBWEuw1RNC/K6hYYYARwcwCjKur6DhHa/kuKvXrMS4bIBnhW0UADoY9KtfxfHsJX4x7AMjXWIgs7S/gk/CnqzVlIFbw8jjOmtpMFq3H+Y2TWNWDBMQELqTtCnGzjmyjP8mdM4z8tTziIfOFWMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2CEUx+uR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2CEUx+uR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so1690515766b.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1773155646; x=1773760446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I6YPqDvPQifSPNHeTQ6UX3rfZJZJOabaUyayiVVNw7c=;
        b=2CEUx+uRM6ViQq6lTBcmaw7h/RHtLpcjhgrxpdAfo8XTWUfZ9UC6FRZ4l8W9ScHlMb
         eiF47B8bQzcLgVfEsx5a3PHk52z6RnPhvjVmL7kqr8v7oIpZNJ0/DC6n2OPo7iXajTZq
         gf49jMaqqrvFw6Ac6QuJNy2wZ/sABd2kyT34L5YspZwlQOGxIcPwZZX2yXh8a1/Qkr6C
         9ftbGwNVF6WtoGW2tm7ONBFQqpUoi5OE3dTZHwZjpSZH+FMhcWT1d7SPWwPP1CXRiJRl
         8voAZMWdgzMQed7JJ+XuSvudbUL8QdLzjtiPoWPJ3NhZp/uQcadO1ffYTDJyTAVnPXte
         f//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155646; x=1773760446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6YPqDvPQifSPNHeTQ6UX3rfZJZJOabaUyayiVVNw7c=;
        b=sYgM1lxObDwZfNtspTQqPbCJ5XkCtjaP1guntAClVjj2g+dkijbo8Qwz/f6RCmn4Ed
         d2027Xz7qmQz/LcNmWzOXXI4XFEaVebgzBc5TeifJkpNBZGCxok3GhD8JVtJqFLaaRJi
         KVI4Hz2COVTl0ctySNqtviLQex/BqiujP5WiyxxFOrRp674viq+MGTWHQWqhvQYDJNYc
         Fy3WMtkhBct3eF1kqOlij5ICrpB8GV0M2OMdCjHISySXzWQ1MSjLRpVaTPIPPzLyO3sz
         8P6MtZnDSrXZgJj0AmI7bOAkhZNLrWFlmYC6xUlYJbB5bP7vvnZcHh2QUb85I86JTq1x
         B0aw==
X-Forwarded-Encrypted: i=1; AJvYcCVzP2GaR+qdAg6fvEEXqN2kh3Kr1Bdji4gUYTK3LitFFJibtyZ6kbZ50uW8Z+6pejnAfXCjKuYwKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaECBCYmRsDk7ZhohZaJ1OyMcIlJc4MR03yq6+oTbYFgWLj4w
	inzkvx8fPX1jcI0cSN194loNLXUbiMpdAYvfEWQY22hK77bfLCvFuqz6tu3uWI3vhHQ=
X-Gm-Gg: ATEYQzy1psLGTrZtnsz90eYISeVl8N0BFiqf4gIy9QX+gswmv3mc3qEg49idaZekXyX
	+riMtddO0gFAVDAw39KrrbMduivRMIMXGlED7cvJWcMFNuoc/JXwkad4IS81xLEU/FoVaoHNaP6
	jErfTZVfnw+mjhSql0Xfr1uDemRLMCu9hlXdF+YSK1B87q1mfPov8Koe+nHVilIs/Vy8uWNIt3R
	448FOWgbsz2Zxvh6ZdGx3mKTs70+Uz6H46vYwgScW6YbqpXHFhaR2OFW/pF+846q7qmQxkGjeME
	LoyeR3G0M+UwMzymA/cwRusbAqkzrZhPwxUjZvzaDxGCwwLoFdKlFEKIuAsxeVbJQoZTnRLxllh
	7sfxQAj4ALkuTvBcJ2PqsD3HJ3PSPNqbTmHrfS9WYyL6WcOJuBeW/bcJpDgLyn19rJc8R9+so71
	bq9y5qJ7k6hkZ7jrlZ
X-Received: by 2002:a17:907:96ac:b0:b8f:9fe5:fd62 with SMTP id a640c23a62f3a-b942e027afcmr793960066b.42.1773155645650;
        Tue, 10 Mar 2026 08:14:05 -0700 (PDT)
Received: from airbuntu ([146.70.179.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15d51fsm501611366b.53.2026.03.10.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:14:05 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:14:01 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
Message-ID: <20260310151401.r4ty2scfyyxxnyhl@airbuntu>
References: <20260301191959.406218221@kernel.org>
 <6250711.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
 <2409653.ElGaqSPkdT@rafael.j.wysocki>
 <20260310035406.xnu3nlqp4ldshxww@airbuntu>
 <f11fc45d-314a-4e2d-bcd1-9d8b1a49c87a@arm.com>
 <20260310150347.ji2fdpdvw6txspc4@airbuntu>
 <CAJZ5v0gDxG5XoV6P+be84gfFjqLc2pmuJJpbtZOY=2_fOpQbwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gDxG5XoV6P+be84gfFjqLc2pmuJJpbtZOY=2_fOpQbwg@mail.gmail.com>

On 03/10/26 16:09, Rafael J. Wysocki wrote:
> On Tue, Mar 10, 2026 at 4:03 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 03/10/26 09:18, Christian Loehle wrote:
> > > On 3/10/26 03:54, Qais Yousef wrote:
> > > > On 03/07/26 17:25, Rafael J. Wysocki wrote:
> > > >
> > > >> In the meantime I realized that if the .select() governor
> > > >> callback is skipped, its .reflect() callback should be skipped
> > > >> either, so I've posted this:
> > > >>
> > > >> https://lkml.org/lkml/2026/3/7/569
> > > >>
> > > >> and here's a fixed version of the last patch on top of the above (for
> > > >> completeness):
> > > >>
> > > >> ---
> > > >>  kernel/sched/idle.c |   25 ++++++++++++++++---------
> > > >>  1 file changed, 16 insertions(+), 9 deletions(-)
> > > >>
> > > >> --- a/kernel/sched/idle.c
> > > >> +++ b/kernel/sched/idle.c
> > > >> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> > > >>    return cpuidle_enter(drv, dev, next_state);
> > > >>  }
> > > >>
> > > >> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> > > >> +{
> > > >> +  if (stop_tick || tick_nohz_tick_stopped())
> > > >> +          tick_nohz_idle_stop_tick();
> > > >> +  else
> > > >> +          tick_nohz_idle_retain_tick();
> > > >> +}
> > > >> +
> > > >>  /**
> > > >>   * cpuidle_idle_call - the main idle function
> > > >>   *
> > > >> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> > > >>   * set, and it returns with polling set.  If it ever stops polling, it
> > > >>   * must clear the polling bit.
> > > >>   */
> > > >> -static void cpuidle_idle_call(void)
> > > >> +static void cpuidle_idle_call(bool stop_tick)
> > > >>  {
> > > >>    struct cpuidle_device *dev = cpuidle_get_device();
> > > >>    struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> > > >> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> > > >>    }
> > > >>
> > > >>    if (cpuidle_not_available(drv, dev)) {
> > > >> -          tick_nohz_idle_stop_tick();
> > > >> +          idle_call_stop_or_retain_tick(stop_tick);
> > > >>
> > > >>            default_idle_call();
> > > >>            goto exit_idle;
> > > >> @@ -222,17 +230,14 @@ static void cpuidle_idle_call(void)
> > > >>            next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> > > >>            call_cpuidle(drv, dev, next_state);
> > > >>    } else if (drv->state_count > 1) {
> > > >> -          bool stop_tick = true;
> > > >> +          stop_tick = true;
> > > >
> > > > Silly question, but wouldn't this benefit the normal path too to delay for one
> > > > tick? This will only matter for the cases where the governor doesn't explicitly
> > > > set stop_tick to either true or false - which I am not sure what they are :)
> > > >
> > > Right now the governors will always set stop_tick explicitly (and overriding
> > > that might confuse the governor-internal state).
> >
> > So we can drop this hunk then
> 
> Not really.
> 
> The governors expect that stop_tick is true by default and they clear
> it if needed/desired.  They may be confused if it is false to start
> with (theoretically, a governor may select an idle state with target
> residency beyond the tick period length then which won't make sense).

I see, thanks for the explanation. It could be me, but if you think a comment
is worthwhile to document this expectation, would be nice to have.

LGTM anyway.

Cheers
