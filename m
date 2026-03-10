Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A73A900B
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115075; cv=none; b=LIt57djBIFqD8eLKgztGxXmlNK3qAxHwhQ3TokttcjAllxHs9ZYVyFwNm7kcpW5qZJj/qjqJXe1BpBsq1V7lO1uLFZGCvQ1qLCRV+jz3X/LB2aR4wcouQNYeBUqYjHUMp2OXh3hNpqbjyNenABT/rs0g+U0qgf6SF7mgJ4TzDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115075; c=relaxed/simple;
	bh=I++9CabtjnzNdZic6iU2EuZTX0Bdpq5xE7epVmOiHuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSH1ZH9GTcBMYp6i6wyFrYEIHF8FOe8+UoeXHslP0ScwYW/fuaix9YI0V4rdD7gkyEbdC/f3rc5KHd7yxKRbMG2LFzyEPQvTZg5MRFc6UQbBfB8yW2r5UjMphqB0R0HT0D1NYq7914jF+8GjtsrwcIedA3YMjNflwKaHGy8dbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Wj4EG51j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Wj4EG51j"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso112902455e9.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 20:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1773115073; x=1773719873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2OgqkD+rDLKy88k7oX0bX18Yp0IhShgRiQX3DdPw70=;
        b=Wj4EG51jfhQzpsm8t2T+FqRWqrxWlxexMml9K8cm6mJcGNIO9Epu0jwY0F3oAFyYPv
         dhi8wFBhK+ff39Axx0zcmW9IGeneTkWBXA8x4Ba+z83bGzNcD1YJ3wMf9TBTudTqgHoG
         wy1NXbHhzhNXZSwrb+AwH60zHnILa1uG/8tjT9bNK3azNs4kmag1gmeasbGmp3LaCFv9
         +MNerw78qz3jQnTiPCxkdoBxqdv82PYmHVOBfMtgXRRBH2py62nkgXl1njQ7CHiBMz1M
         iIw034LdLUZs97clISOnXJ+xyC6iOTF9qKDECjCa1Hmm7DlDFoJgk0IFMt7HXZqAbxce
         I3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773115073; x=1773719873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2OgqkD+rDLKy88k7oX0bX18Yp0IhShgRiQX3DdPw70=;
        b=kH1Cae4y1/hdd/P/OrWV5IKGEcYJfhIQYlEdjBLeFeaxQrhpRUutFZt4opn65bcwCP
         3QjmpHmRbIZkEE3CYtZaHAhibex9cW65i3t00Kq7jcgiDTsdJqrbrX97mCjLcS4MGHoF
         L3o3hovP3RFkkIYEuqaBxDVsxB40KfTRJO4AKiXBZVT/zkGB3S5Oh2pTu9caso4Wq16T
         f+0SS0S52jAMnt5ZhdQBoRwG7LM7mYH2QYtXEpsCMXSJ83l52GhzQDqT3u9mdcFCM0qO
         7HksVZxQodsXz+Khel0ajt3IQIx/nq/1pebVfFDnOWbgA3NoYygTo3uFuqzP2pfHTuW5
         rIJw==
X-Forwarded-Encrypted: i=1; AJvYcCUZRyflNljWNYfow6RMoEr7pApHSzr57cnsvj5muH8X/uNwX9dCDDCMWd0qw9Pf3p049QODbzPm9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIt6kPti1DoMMo37rJmi08PhQejiEAeu8I4ykOHrNIwr2O2E4
	1eUQldp9IUGQQqe+S1xM97YXcozFr5Z4jrM3N5ikXEfSMx3zv3GJKOCW7fcoFHZbuV0=
X-Gm-Gg: ATEYQzxgMR6QmyrhptlTUUtQVyoc2pYgKYq+eCQ5k2BBfsPREw/bw8CMGTDb2O5FJt2
	z/NtrEMmMgdJXwvcmjIIVhcviLDIfQz60UBLD+Ua5fivafcKPAUmpebi620HALOjHO4zNXp3fzE
	myOt5hH1Pg9f37tgrqwPGZHXGQwi4+25rW7WjHdpVc/ord9Q1E8XAT0If1NlJ5CTYkif8eboH6E
	5brDy4S4RaUnEOL0OLgU+tumhtQ3Y8yW30riklJPMfu+i/V4o63MzuAsQadE2sWz7OuCIrX46Bf
	2e0rvYaShGe2UEyCetuKW+rD3n7+qsFkvD+9vtY47VMwlEKa0jVaqWVqaZdCc64zaF3RMYraYaj
	hag+Rr1DpKFstZ+sQhgK3/gAf9sqX3fU3/XdZNOyF+mWi19dckxvGGeM2pMFeVyMMQOU7mF55HU
	EN/h4ozZpADYm9T+9N3Q==
X-Received: by 2002:a05:600c:64c6:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-485445a899bmr8904845e9.8.1773115072357;
        Mon, 09 Mar 2026 20:57:52 -0700 (PDT)
Received: from airbuntu ([194.36.110.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48531818b5asm112595685e9.3.2026.03.09.20.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:57:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 03:57:48 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1] sched: idle: Make skipping governor callbacks more
 consistent
Message-ID: <20260310035748.oum5mlscwh3tml7v@airbuntu>
References: <20260301191959.406218221@kernel.org>
 <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
 <20260304030306.uk5c63xw4oqvjffb@airbuntu>
 <12857700.O9o76ZdvQC@rafael.j.wysocki>
 <eaccec02-2f4d-4746-81a0-deda2125bed3@arm.com>
 <CAJZ5v0iVhOurCYuGoZpjd_+GqCxre38Ms1gT9+3-LYk5isP5Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iVhOurCYuGoZpjd_+GqCxre38Ms1gT9+3-LYk5isP5Dg@mail.gmail.com>

On 03/09/26 13:26, Rafael J. Wysocki wrote:
> On Mon, Mar 9, 2026 at 10:13 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 3/7/26 16:12, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If the cpuidle governor .select() callback is skipped because there
> > > is only one idle state in the cpuidle driver, the .reflect() callback
> > > should be skipped as well, at least for consistency (if not for
> > > correctness), so do it.
> > >
> > > Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/cpuidle/cpuidle.c |   10 ----------
> > >  kernel/sched/idle.c       |   11 ++++++++++-
> > >  2 files changed, 10 insertions(+), 11 deletions(-)
> > >
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c
> > > @@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
> > >  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > >                  bool *stop_tick)
> > >  {
> > > -     /*
> > > -      * If there is only a single idle state (or none), there is nothing
> > > -      * meaningful for the governor to choose. Skip the governor and
> > > -      * always use state 0 with the tick running.
> > > -      */
> > > -     if (drv->state_count <= 1) {
> > > -             *stop_tick = false;
> > > -             return 0;
> > > -     }
> > > -
> > >       return cpuidle_curr_governor->select(drv, dev, stop_tick);
> > >  }
> > >
> > > --- a/kernel/sched/idle.c
> > > +++ b/kernel/sched/idle.c
> > > @@ -221,7 +221,7 @@ static void cpuidle_idle_call(void)
> > >
> > >               next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> > >               call_cpuidle(drv, dev, next_state);
> > > -     } else {
> > > +     } else if (drv->state_count > 1) {
> > >               bool stop_tick = true;
> > >
> > >               /*
> > > @@ -239,6 +239,15 @@ static void cpuidle_idle_call(void)
> > >                * Give the governor an opportunity to reflect on the outcome
> > >                */
> > >               cpuidle_reflect(dev, entered_state);
> > > +     } else {
> > > +             tick_nohz_idle_retain_tick();
> > > +
> > > +             /*
> > > +              * If there is only a single idle state (or none), there is
> > > +              * nothing meaningful for the governor to choose.  Skip the
> > > +              * governor and always use state 0.
> > > +              */
> > > +             call_cpuidle(drv, dev, 0);
> > >       }
> > >
> > >  exit_idle:
> > >
> > >
> > >
> >
> > Duh, good catch.
> > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> 
> OK, so any objections or concerns from anyone?
> 
> I'm about to queue this up for the next -rc.

LGTM too
