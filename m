Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FD563FA3
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183219; cv=none; b=WjuFTDRSA5INDxZ+5j/edfcWW0G1MIyqsRaotgtZOhpilqSLj8DRZuVz5+mHZWPsZJS8icmrrdfP+q4IqMYQQrQutgSAeiz+MX3EsNRvpRxSuAxG68QiHTrsF2PS6mkJoXQNqBy61GoQ4AzEv3HUvWUq1MyAJoRVzlYgFHIpSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183219; c=relaxed/simple;
	bh=um7azPzT+cpu/Z3dPCGHhgpFzY4gBww/iFYc5g1PgIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZbVfOa8p3T6WgJftps8a8NGKKaGUx2Ppj16TlrtpmSUAdmpjFRwtDSyryIDOS3NvFePiYeRpWthv7wQsKLDCa2WQ29hUZKemfDiAumRqXfl/rfp/Ny6WVO+stE+3RucXDyBmtwrrjR+4kXLE3Unr984sJhNlfTK8GbJKmF7bCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7BXmsKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7BXmsKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D1D1F0089F
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183207;
	bh=um7azPzT+cpu/Z3dPCGHhgpFzY4gBww/iFYc5g1PgIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I7BXmsKwhKFK+ObKxTTFo7SvNB6TFTGCEbn6JY+nkQCp64WFx0K7mLNTQPA9I7BVD
	 kAtIsvBsAiaQacA8YrMSEZWw7C8c1cCvXqodrbbo2qpCIWqIsPfqRgSZnPL8pYpOjn
	 TEkd0IA3wZ+Wesf84PwJ7uonZrRIdoai+tvAMhI2SmZ0kB/yT8GJQACfC5RVNrb8OU
	 QJuInnZEdeEP9cQMvMci4BHfixdQjWiiqZU65hKnV4IT/tcmtrXE1+i4FNcVGDHa3u
	 +DHPqA8VX0Yb4smRWhFk/WosRnqdOmG+esuLMaahUjrKfqFIXDhvMnXNO5VZ9nQEfR
	 MGzfYC6LjO+jw==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c5231570so1136092e87.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:06:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzdXmZyMb7EYfWw9j1XtNvDAPEXEaTbgRcEjxlOheOb9GZKM6eaQxJyiCqM/lcKKU9qSmR6AVU26A==@vger.kernel.org
X-Gm-Message-State: AFuF++lCirPI7Zdepuwg/KdVbp0zBc1EfBFOuxB67bx1VoPEtbQckrTb
	oPsOJOJuLywrDPTVCqsDG4WtTmDkZSkLaOBmffszYKAygmBe697x+T48wiGv3N2jAk2SF14MYEf
	DDIxGHAb6QOt0uuJjWnSn9oPAr0XIMZc=
X-Received: by 2002:a05:6512:3b23:b0:5b6:4b2:15e7 with SMTP id
 2adb3069b0e04-5b8d89b8d82mr1079941e87.31.1790183206096; Wed, 23 Sep 2026
 10:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12975163.O9o76ZdvQC@rafael.j.wysocki> <arP8Fv9z0ozmVP1t@chenyu-dev>
In-Reply-To: <arP8Fv9z0ozmVP1t@chenyu-dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 19:05:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jqPwJk2Lbb4GTGFP_Y8mS4PDoUxOub3KVseZDa-qG9mQ@mail.gmail.com>
X-Gm-Features: AclHuK9YBSRor6NxCAp7WbaMN5yYI2c1RPMMTXJVUUomWmb7uD7TYFBfSUodXSo
Message-ID: <CAJZ5v0jqPwJk2Lbb4GTGFP_Y8mS4PDoUxOub3KVseZDa-qG9mQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Fix max_freq fallback in cpufreq_update_pressure()
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Jianyong Wu <wujianyong@hygon.cn>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 6:32=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> On Mon, Sep 21, 2026 at 09:12:00PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > After commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fal=
l
> > back to cpuinfo.max_freq"), cpufreq pressure appears in the CPU load
> > balancer unexpectedly in some cases in which it was not present before,
> > leading to confusion and uncertainty.
> >
> > Clearly, the scheduler assumes that cpufreq pressure will not be set
> > unless the capacity reference frequency of the CPU is known, and the
> > commit mentioned above violates that assumption.
> >
> > However, in some cases the capacity reference frequency of the CPU is
> > in fact known even though arch_scale_freq_ref() returns 0 and in those
> > cases it should be possible to set cpufreq pressure as appropriate.
> >
> > For this purpose, introduce a new cpufreq driver callback returning
> > the CPU capacity reference frequency, .scale_freq_ref(), and make
> > cpufreq_update_pressure() invoke it, if present, instead of falling
> > back to cpuinfo.max_freq unconditionally.
> >
> > Add that callback to the intel_pstate driver and make it return 0 unles=
s
> > the scale-invariant capacity of the given CPU has been explicitly set,
> > in which cases its reference frequency is always cpuinfo.max_freq.
> >
> > Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back=
 to cpuinfo.max_freq")
> > Reported-by: Jianyong Wu <wujianyong@hygon.cn>
> > Closes: https://lore.kernel.org/linux-pm/20260915065747.1671965-1-wujia=
nyong@hygon.cn/
> > Tested-by: Jianyong Wu <wujianyong@hygon.cn>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I did not observe any issue on a 4LLCs per node Xeon server when running
> cache-aware-schedulings santity test,
>
> Tested-by: Chen Yu <yu.c.chen@intel.com>

Thanks!
