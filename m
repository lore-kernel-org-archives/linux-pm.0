Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260C2F2910
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760057; cv=pass; b=XtG9FH1zx/gm1C0AJpzsg4dkWmlYldGeBz9FhR9k93DKt5if08vuX6Qi6o9YnfGl/4nZ17RDfhD7eKi9TdpbvRYhcSi7IlstwUUBTMm8cChwEMPKRy9UT6RNc/R9wB5FyYB2P8AQ4BuXuoCHpKr0ApD4V7OmCN0rev+nBqx2Ihs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760057; c=relaxed/simple;
	bh=+Z2OEmnJdgjqS1g3yj57KCVy6mHfzWTsN+WLdqFjrxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUp9G+VBNbFN0TuKVtHq7svRmTjlGohUccR+/k6dqQEnOfpPAK1ZwQbJM+N0JkKDTQfdaYgh66N7SBUK2LNhtlA4D6EqOfg8bsWxxexyRZSUbuTqb51i1oOpxfwX+uG6ch2h/Wk7Us2J557Fzx3vloE1rAeMByT3PggB7j/EMX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3m+w0MW; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3m+w0MW"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39aeb9513efso19090951fa.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782760054; cv=none;
        d=google.com; s=arc-20260327;
        b=MpqH1SIbyt2mm0IcJD3kG0zrtvgVtMecpqjYt7pgjQdNQsiOOmaGGqJO7Qmfd2cTgC
         rZE1jq+ZwFYpNXnj2S2bdHH1GtArV2ud3fLF1lLxz+wwfJAaykZTLfB4vuKSLXaYlOHQ
         ZVRC/WRbyaM6dwXxnW1xZ03ylx0/gjsgk/hlUgSQFL5+BrFW2Uei2g9Ox+xIUGYOcYvK
         SI9xHVoDJF00An7tcken3f2cpXfvSQV6Lb5LhVIir2xYAp7DLb+YesO80u6WmEZ7G4g1
         t8tXeOcv4kpKJ835/hA95sgqWhoXZRSWgQgdoS5xGf8q3Bg8IBxOhd6lS2bi5hXmG7eW
         RxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Z2OEmnJdgjqS1g3yj57KCVy6mHfzWTsN+WLdqFjrxY=;
        fh=TRMxe37u0lnIz7MsdaDhamIwVfqfGN6j51yZxSo579c=;
        b=K6qg1iYkI5DFDElTJPdOhQEptlt078CsBswDpB/eHZiPVsIcay0LIxqVx2sAD7lz7X
         h+w34mjb8LeblP77+okh0Ul1HMvKtJHrtyb7b8cCqpHJYEL+6ULFHZgnR7bWhIKhdS+d
         0ggR9Oz/81CCP2/M51taf+61ecCD2+5wx40xd/cB4tCyjMDFhD/OueWLkjlUS/PAEUsM
         M5ebKlfTOTMktO+6rNpOMhCz0/VylP81Us+y5iKlF/pvgEwYmd+ow75gKnKVGFgV7gaZ
         gB/ZjAJCyirG6MyWd6KwIfbXPjQtttFOu9je8cUhBdVPf3lsrdHbnPVy05rO8AMuZkCm
         pLbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760054; x=1783364854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Z2OEmnJdgjqS1g3yj57KCVy6mHfzWTsN+WLdqFjrxY=;
        b=Q3m+w0MWqSARc7l05a9STTULeSH4k1Xw1lNOw9sZ0oxr/YasLAwl26qBjYsrRX0bpA
         OtpHXE3zppcuFQotUbLaeC62HhhqwGYlrbYHUNLWXLKG9ZpnSJRWtTe8aqMJVZkQL91r
         fwh7q0tN8jKWtnEk3P1r0snyB0JVWw7MLAP3pf1c5zV3HfOAKGt+jiqiqH+5jPZVmA0F
         XkQJTVxiMgW1zHLWHD8oMmjVC3QCBmVkMhClXnmZjLp8tuKS354xcGOibg0wxsKVmsUO
         hTonyu9cS40fj2c23Km/dlLGI2BBA2Xqw/0EXgC70uwkp61jwd+4MZignHhborJip0g3
         M9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760054; x=1783364854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Z2OEmnJdgjqS1g3yj57KCVy6mHfzWTsN+WLdqFjrxY=;
        b=fI5k84B4TVXvcYxP8BfiZl6wzBpSrU+To/TyRairjmc2U3EPyiRacvO2Xfhs/WQZLL
         AVOMuoRNNCB1E7TXQmhQS0yZ4yPrWrfdlWcHCmswuOMc/2FCbyilUmVkALd73tmDZiTg
         pssucDpp0LjQqC3CHgL3bP3C1Sy+dvV84hOlTcCTWJ3L9A72maMyzagd3U1G5kASFhxv
         V6nqImu8/NmmROvIdO1LXIYLcdQowjhJXkdtwGXGANLk0E0F74+yy68bYertnxB5y7DG
         0EmEJEMugzVAcRV8mJdTm0IG3tciptRyjSb2Jngm525r/w4mj970e8I9OQ9MmsdDG85N
         HwxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrymqnrbu07akb51GL4y4K/jyAALT9pZJ1DwnnQgoCdHXkRnwsaGXE2lgCojLkfMJj0//x3jy2RSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtrQCbutRl71iTFlFSNt4TZ0qTV9R1NkL/ak39Tg5WrIiaJwt
	uwc96PpWdE8Czvv47lM2uevF/ER29MFaKeE6TcnAG2ZIBnLWfX7Fynd9p5x7nH33FnsHWwVm5Iv
	YVUGldER67fmnWRbEEDqPFVOzHQuXdZA=
X-Gm-Gg: AfdE7clvxtEtjnO0IAHoX3jywDRLAsJ667Xcn9rciSOh1OcAlWPxg7Zsr40JPsu2e7h
	tLZUu4mVIHn+KtZkTORzH06nN8u2qubi2BPDeY5myI2pWI8zo+XjwC0LU4BZ3WkjqqvkXHkv1c/
	KueDuCnQ7PwTV3GJeqcSo6B3hJkjVR60PKcq4CLxYf6/21QD2Gegry5zyT34hJEhcgclwmD2gF5
	JS1ISmde0LXeXkn+AO4+UROZA06C8x5U0jFYIkOLJH4Zx10eIFMrDfuWXUscNacyoRMb9XBIpra
	gBWzxFkmmiUH2mhaEs86KjG3y1t/xS277xUxvuUJ3g==
X-Received: by 2002:a05:651c:2223:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-39b1da8f5f6mr1003691fa.6.1782760053776; Mon, 29 Jun 2026
 12:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com> <7f960dca-2de2-4831-8690-a40fdec848dd@arm.com>
In-Reply-To: <7f960dca-2de2-4831-8690-a40fdec848dd@arm.com>
From: Lucas Lima <lucaslnobrega38@gmail.com>
Date: Mon, 29 Jun 2026 16:07:21 -0300
X-Gm-Features: AVVi8Cf5-wN9nhSYqnSyz5AgBk1jFBqAT648csCtFWb1IIWF-rBqtEJoG7PzYJo
Message-ID: <CAMVixxXdTHKVS+oOd6f6qjOWA9-fg329=58e6fXqAO8_hJ9mUw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, vincent.guittot@linaro.org, 
	mingo@redhat.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 29 de jun. de 2026 =C3=A0s 11:05, Lukasz Luba
<lukasz.luba@arm.com> escreveu:
>
>
>
> On 6/29/26 09:35, Lucas de Lima N=C3=B3brega wrote:
> > EAS currently refuses to enable energy-aware scheduling on a root
> > domain unless schedutil is the active CPUFreq governor for all of its
> > CPUs (cpufreq_ready_for_eas()). This requirement exists to protect the
> > accuracy of the energy estimate: EAS predicts the OPP a CPU will run
> > at from its utilization, which is only meaningful if the active
> > governor actually requests OPPs that way, and schedutil is the only
> > one that does.
> >
> > That requirement does not apply to artificial Energy Models
> > (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> > get_cost() callback instead of real power numbers, and only encodes a
> > cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
> > given utilization). It never claims to predict real energy use at any
> > specific OPP, so there is no per-OPP accuracy for the governor
> > requirement to protect, regardless of which governor is in control or
> > whether it tracks utilization at all.
> >
> > intel_pstate registers exactly this kind of artificial EM for hybrid
> > (P/E-core) systems without SMT, regardless of whether it operates in
> > active or passive mode. In active mode it never uses schedutil, since
> > HWP picks frequency autonomously, so on these systems EAS never
>
> When frequency is picked autonomously then EAS and energy estimations
> don't make sense IMHO.
>
> Do you have any data from experiments how it runs?
>
> Regards,
> Lukasz

Through my testings, HWP does seem follow an strictly non decreasing
duty-cycle to freq curve, with or without frequency clamping and turbo
boost activated. For me, that feels enough to justify the use of the
simplified energy model already implemented.
