Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06032449B04
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517518; cv=none; b=g3b7EbfLneugvhojjvEqvuP1kSZ+Lh5P+t9hwj1ip5OUfPjE3yf41blwKpq31sFF0Wa89Egw0nMugfCg42u77h9tH3AG42apsAUygGZuGx2GB6B+ehqHYIF8g8eaF54j2VhbhvbCiSrJGoOb0OfeVeBynXhZEcpZJYDt0qBdelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517518; c=relaxed/simple;
	bh=zMkrIy9DkzJKISOJGXhUeNaHj+90PEcEm86baMPgoCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKrnw7Cak/uhWyrv4wiImWqoajmNcw11a0iylyFFfjVMTyEEZEgJHrSIqyEbDMFWbmBj+FRrdtkUTH6BvP2pRGAa4dTYGXimzSJGXgly+H6QdfEwK7SpOOBqIjX8tyMqqrrIvMVrE41lRf0N7dGTJSkjZ0+it/qeQsco5QtWdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2s0TLVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2s0TLVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CCF1F00ACF
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517516;
	bh=3lgsgSMCQLyv8/uTJMTP8FPS+DF3MahfiywwNCQnfO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C2s0TLVVQ2fA7oR/0Q+oCHjSUzBNYgLgg57uzIL6ZPT/ypRjbIi0OxBaGhUqykzJr
	 5/mFoizoVJNGh3Am7QrqSsKHkNA787xvaZjOqOjNB1j+r8W4bLKBUzDS5aHTM+Lb/h
	 V2aO542nx7I9DknTxrqH9sQ0r58I2xTnpHYEis2gTJ/218EWIOUasGvWaKrGsWjkjk
	 jq14CNkfXWoPWbM1eT7yjejsX8vgI+skEDrC+VuAPB2usrLwXFUQkjAGX+a67n09RJ
	 TTaTQo3N3jymnlZ9kN9qZrsX1+8loJDiew9v9TMhioU8+Rw57ZRwsN8rC6JVZ+tgi0
	 y7EP5HjBcraxg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c83acb86eso10774791fa.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:05:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rol+CO5SflihSS+UHH5+Au9Sunzz7kX6KcgEANIeNSwwxdtoaa//ohY+SVMpvhB09tMkjKkfpQykQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRusT5HGoadY7aBRvFz/YsOwh9IzgR78k0UyE+7k2mShChMwy
	q/e8n0e05eijevCcMlSKvjErR7J3OSRRZVKnrWSlqV1OQQ8H70ve8DBOcCumqfHgo7ngrNC1hFg
	fZTdlmqbshjW2BXNKIJa0Snn8RtrHmic=
X-Received: by 2002:a2e:a9ab:0:b0:39f:6700:9257 with SMTP id
 38308e7fff4ca-39f8641fc40mr619121fa.30.1785517515358; Fri, 31 Jul 2026
 10:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
 <5144014.31r3eYUQgx@rafael.j.wysocki> <000d01dd1fb2$1da56040$58f020c0$@telus.net>
 <000401dd2034$4ed282b0$ec778810$@telus.net>
In-Reply-To: <000401dd2034$4ed282b0$ec778810$@telus.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 19:05:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGNEbE2xsM_y36+YyaeeNoj+Q5X6gP=o4=_9jC+OH3_Q@mail.gmail.com>
X-Gm-Features: AUfX_mwLsdxIas6DvEEkPWflDHT-BaWWT3v4GL-7Dj3n-zC2YySzkIZi-jHTA4I
Message-ID: <CAJZ5v0iGNEbE2xsM_y36+YyaeeNoj+Q5X6gP=o4=_9jC+OH3_Q@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Adjust policy->cur in active
 mode to policy
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jing Wu <realwujing@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:01=E2=80=AFPM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2026.07.29 16:30 Doug Smythies wrote:
> > On 2026.07.29 11:40 Rafael wrote:
> >> On Wednesday, July 29, 2026 10:59:24 AM CEST Jing Wu wrote:
>
> ...
>
> >>> arch_freq_get_on_cpu() falls back to cpufreq_quick_get(), i.e.
> >>> policy->cur, whenever its APERF/MPERF sample goes stale. A CPU whose
> >>> tick keeps running refreshes that sample constantly and rarely hits
> >>> the fallback, but an isolated CPU covered by nohz_full with a single
> >>> runnable task never gets another tick, so it permanently reports the
> >>> floor through this fallback - even though it is genuinely pinned to,
> >>> and running at, the frequency computed just above.
>
> I was unable to recreate your described situation.
> With some isolated CPUs and a single runnable task, the reported
> frequency was always accurate, and when there was no task the stale
> frequency was as expected.
>
> ...
>
> >> Good idea overall, but it takes a bit more to do this.  In particular,=
 the HWP
> >> case needs some more care.
> >>
> >> Also, I don't think that this really is a fix.  The code works as inte=
nded,
> >> although what it does is sometimes confusing.
> >
> > Yes, and by agreement at the time (or so I think I recall) we
> > were trying to get all CPU frequency scaling drivers and governors to
> > display the same thing when the frequency was stale.
> > We wanted to: 1, make it more obvious that the frequency was stale;
> > 2, keep the listed stale frequency within the currently set limits.
> > The drivers were intel_pstate (with both HWP enabled and disabled),
> > intel_cpufreq (with both HWP enabled and disabled), and acpi-cpufreq.
> > We decided on the currently set minimum CPU frequency.
> >
> > There was a problem with driver =3D intel_cpufreq, governor =3D schedut=
il,
> > HWP enabled, where it would might not show the current minimum
> > frequency as the stale frequency, that remains to this day.
> > (i.e. I have never figured out a fix after my initial attempt was rejec=
ted, [1])
> >
> >> Below is my version of this change (on top of linux-next), please let =
me know
> >> if it works for you.
> >>
> >> Thanks!
> >
> > I was part way through looking at and testing Jing's version of the pat=
ch.
> > I'll abandon that and try yours.
>
> Thanks, your patch also eliminates a lingering difference in reported sta=
le
> frequencies with the performance governor between the intel_pstate and
> intel_cpufreq CPU frequency scaling drivers.
>
> A table of all combinations is attached.
>
> Reviewed and tested by dsmythies@telus.net

Thank you!
