Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67E4FE2E0
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668719; cv=none; b=KsKjeZHKtGKfzg0jQ5WMZAC/ttRJ+fBbBgo7RM7zgDiiF6IQlxdR7yNERmGGMp8ax0X35YsyvUbptWuK1RRjQf830YkrswDAFtt8Wfe8R6ra1mNXSoSFTLG3CQITkeE2sND1Oh/9pJCAXiKlBFKBaqigtA+irYRtrymSZ7/3C3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668719; c=relaxed/simple;
	bh=JdBVjgiLF+LfTWyDPjdZ0Ler+mATxkgx/NrxbmnfWcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dlvkfz7OnP22W3omMSD9s/YhEi3RUl1+W1kxORJpyF3MZJweJAfxdMpMkptk61FskjlHhsdGrDX9D8BgbQbku8jgDDl+zpfJ7EQTnwwz4jCLU0Rz8CNGCu6iZeLV8dWctcOFk7YNAZHUQA9Hj9f8+JVrc24ZyMuEhmQg5FfBMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+G7xJwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+G7xJwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F9B1F008A2
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668717;
	bh=EbP28uDo6ifWQjSsYPtF0OSTEKqjklYhZOU78M+KyY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y+G7xJwLW1LYbtGwg+BSMto+sa7T13bwFfVcO/nSzbV+X/a2kXwoS66ZDqCSffJlR
	 fIVIrynIDz0Q18sK/+hyeVKqYGiSfwc9jQpuFlvQqaNG+kyqWHZJ6whX9P1yb5JaVG
	 /a6fl/9ndJFmJvUbun1k4fhuUxWx57tHAx1/AenPiyO50oAbQbDvcacqHfnLbXLOde
	 oBCz4NZOxSslkLNGJT2ENIMATMGX7xQ0qSH39X5eea9dJT6SXQIF+SsLWXs8GEMz+g
	 PzdqFPpqQZ7wHh9x66toIkw/GAuy8Nd96zf8WYs1t2SCqZSR7jLzSaVMoPpO4qgV9/
	 hi9wWVLSWSXEQ==
Received: by mail-lr2-f23.google.com with SMTP id 38308e7fff4ca-3a306a4f735so10020561fa.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 11:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJqPYwzElJCMNMdDTgGmyoEDI+vjoC+3nIyGPLSlUmcpsDurs7zAiLf28WB5IPvcfR2LXm+rptGw==@vger.kernel.org
X-Gm-Message-State: AFuF++ktz6TIxIch8dRaEiC06LZDXtQKsqm5eP6LTdqRDhGZ8kj0dE6S
	edDME/nF3rhoyGdzs4VRiByq6ycDifCkocZNNvbqrhlBX/bMz5u8+OMHobYDvVTv4jxxGSHURLC
	aybntKUPtYFBPS3338dO8xSIOnImZCgs=
X-Received: by 2002:a2e:be86:0:b0:3a3:27f6:69b9 with SMTP id
 38308e7fff4ca-3a5dc99e99fmr14666301fa.11.1789668716222; Thu, 17 Sep 2026
 11:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAKfTPtCR8SnQwpxzE-=WXenhTU=Hv5hrf7Vz22tMipX7uP_xxA@mail.gmail.com>
In-Reply-To: <CAKfTPtCR8SnQwpxzE-=WXenhTU=Hv5hrf7Vz22tMipX7uP_xxA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 20:10:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkgMK=4Vksm2wwBV9cENRPGELVifcCZgaGD33=7CZTKg@mail.gmail.com>
X-Gm-Features: AcwNN1XspAB1t0lbFuIcMtXYYLIlMwemR7Tvz3-dS82Fe1yBm31AMh89Igc0VZE
Message-ID: <CAJZ5v0hkgMK=4Vksm2wwBV9cENRPGELVifcCZgaGD33=7CZTKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: Vincent Guittot <vincent.guittot@linaro.org>, Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:58=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 8 Sept 2026 at 10:31, Ananthu C V <ananthu.cv@oss.qualcomm.com> w=
rote:
> >
> > capacity_freq_ref, the per-CPU frequency-invariance reference used by
> > schedutil, is seeded from policy->cpuinfo.max_freq at policy creation.
> > If boost frequencies are filtered out of the frequency table because
> > boost isn't yet enabled at boot, max_freq only reflects the non-boost
> > ceiling, so capacity_freq_ref never learns about boost frequencies for
> > the policy's lifetime. Enabling boost later raises policy->max, but
> > capacity_freq_ref stays stale, leaving schedutil unable to scale
> > utilization or target a frequency above the non-boost maximum.
> >
> > Track the highest frequency in the table regardless of boost state
> > (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_freq,
> > max_table_freq), so the invariance reference is boost-aware from boot
> > regardless of whether boost is currently enabled. Runtime enforcement,
> > still handled by policy->max, is unaffected.
> >
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > ---
> >  drivers/base/arch_topology.c | 3 ++-
> >  drivers/cpufreq/freq_table.c | 6 ++++++
> >  include/linux/cpufreq.h      | 1 +
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.=
c
> > index 8c5e47c28d9a..da94f77441da 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_block *n=
b,
> >         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cp=
us);
> >
> >         for_each_cpu(cpu, policy->related_cpus) {
> > -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpuinfo.max=
_freq;
> > +               per_cpu(capacity_freq_ref, cpu) =3D max(policy->cpuinfo=
.max_freq,
> > +                                                     policy->cpuinfo.m=
ax_table_freq);
>
> I will let cpufreq maintainer comment about the need for a
> policy->cpuinfo.max_table_freq field or not

Well, there are cpufreq drivers that don't use frequency tables at
all, so I'd rather not add it.
