Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E7312832
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932855; cv=none; b=I3JBLTqn67i2RP2zTz/SS6WolE/IO2MQGL1lm8KRD9ty3Q0MTTJRKsyipAiof8p5Rxwg9iVs/9PhqlBeVjSXjQvpq/oI8UrHEP8O9e3z/IfPpDmCpQ2rLNNo8RY8AAsU1cxnO8lznnpd1Sd+iJIMG45ve8pYHXO61MXVKREBmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932855; c=relaxed/simple;
	bh=ybRJP9N8fJ4LMlfnZbSbGgW57lzccxaW3vj6fFjgYQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikr9HlWQ2+rBYmLHM2U7dzA+GW6k42mKKEsUoiX/jdjkmBb34go3pMKvlI6RL2Vd5GKHYGt92b4kPPz+dPab2GLjKa/DW+ZP9KrqEJJAFwa/WbpudVRiPJ/VCC0f+8L+pCO3xySqhUNsQkg6o1s0LoLGqlnFkaNrJ7ULj8nf9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU78Jp3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU78Jp3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D961F00A3A
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782932854;
	bh=nS4RYYyfSxGzq77VwDh5EQMcy9j35GbfaZS350HdWxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hU78Jp3fCQRKTXoG3WXVguShN7gS/Dy3pdU8IWQwXPq6gdA3SK8+BN4LIDaAyXoCG
	 JFYkf8CSIMtcDGX9gMi0CYXuugNlJnV7cgNwwvvy0j1NpoOK5uPlzyNdme7ZG65LG/
	 6GE8Ylle1QjTynX5D6icHeLEELv9fKdMcjawyD6mHUK78hPh9CguspgEgK5ZYaiXp7
	 dZTt/LbqCENBbLwxA3f8K0cET/RU91lYt33/cauuTvLjmQx6rEwIgRv+zxg9XYA0Q8
	 qrW2Z/3pWXcjdqEiUzXQJ8Jyzim8riJWEz4lPp50VYAelzwcUNyll3ArJlx0OVcen6
	 qK6ca4byjFbaA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeae771c49so957568e87.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 12:07:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqiDQNNw39tXb0T8cRQhjcbLynlX7ttm6y2YMWsGwPbypaAJ0nh/Hd7LW7eP1Kf73C0wWSmklS8gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6zIFlf4KRCuW5aT0ztjD+K70od6pR9LQpqduZoc2a/2NDIgR
	bG4lOmLNKY1uIemc9cGYLs9YLv94Sq6dPEjSUUzeryeL1aZtQ1LcLnjKY/X08h7Xv17cEr843ag
	BIdefN46WR/At83nlpC1dsvxZrhUTFSs=
X-Received: by 2002:a05:6512:1114:b0:5ae:b629:4517 with SMTP id
 2adb3069b0e04-5aec742fa32mr814683e87.63.1782932852839; Wed, 01 Jul 2026
 12:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2832945.mvXUDI8C0e@rafael.j.wysocki> <0878786a83120630ce4e8c601f41927e82866b16.camel@linux.intel.com>
In-Reply-To: <0878786a83120630ce4e8c601f41927e82866b16.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 1 Jul 2026 21:07:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jB-6V8AqFOggR-PE_ZSiFJek8m_t4OLLEjvPy3dZa+1Q@mail.gmail.com>
X-Gm-Features: AVVi8CfHwjIZISIHJuj9NzxAPrD8u2RKDIgKWYl8s-gNSDWQVJWcO0pGeCx8bF4
Message-ID: <CAJZ5v0jB-6V8AqFOggR-PE_ZSiFJek8m_t4OLLEjvPy3dZa+1Q@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Rearrange checks in hybrid_get_cost()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:08=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2026-06-17 at 19:02 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make the checks in hybrid_get_cost() more straightforward.
> >
>
> Please do the same for hwp_get_cpu_scaling()
>
> if (hybrid_get_cpu_type(cpu) !=3D INTEL_CPU_TYPE_ATOM)
> to
> if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE)

I don't think this is necessary and it would break Razor Lake-E - see
commit 0e7c710478b3 ("cpufreq: intel_pstate: Use correct scaling
factor on Raptor Lake-E") - and Bartlett Lake.

The check in hwp_get_cpu_scaling() is only done for the processors
having nonzero hybrid_scaling_factor that are explicitly listed in
intel_hybrid_scaling_factor[] and on those the TYPE_ATOM cores all
have the default scaling factor.

I'm going to apply the patch as is.

Thanks!

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c |    8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -979,12 +979,10 @@ static int hybrid_get_cost(struct device
> >        * capacity.  Similarly, P-cores start to be populated when
> > E-cores are
> >        * utilized above 60% of the capacity.
> >        */
> > -     if (hybrid_get_cpu_type(dev->id) =3D=3D INTEL_CPU_TYPE_ATOM) {
> > -             if (hybrid_has_l3(dev->id)) /* E-core */
> > -                     *cost +=3D 1;
> > -     } else { /* P-core */
> > +     if (hybrid_get_cpu_type(dev->id) =3D=3D INTEL_CPU_TYPE_CORE) /*
> > P-core */
> >               *cost +=3D 2;
> > -     }
> > +     else if (hybrid_has_l3(dev->id)) /* E-core */
> > +             *cost +=3D 1;
> >
> >       return 0;
> >  }
> >
> >
> >
