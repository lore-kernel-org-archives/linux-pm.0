Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94095502791
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739253; cv=pass; b=TiMuZ8r+gLnVOOzsd7qUuOmLPajZ3G6wj7FejsII3MIo3jgdMV7O1RIKRp8DH3S6nsFM9SFe6GNjq9ZieOJn9CGcQA7J4jYTRSzS4a5Us+r1tkWRPaYmmD1hAUN6LVBnwD4VZE0a+W2hOR06B1GzmZxiXhHe+oOUIZ3lFvKFuh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739253; c=relaxed/simple;
	bh=fudkRpOvqijVuJwy/VHO9zMcAmf9hSjmeOSE6UueqG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grfBfVeDi8g+VW/zA09lNoxB8Vsuy5GhnsEMlFbs8tkhs7rtkUo4pphZAO07b7HJrsIM26ZTeSSLqWoi2fSWXruMN0IDYneR3Gsx2u4zSC7bDfqzEMyYPx9JzcfRArJCzoRCn/YL1xo+b08cV7rqRDkGKT6Ab9GMk+oPknS0IW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuA/HkPG; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuA/HkPG"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a56so99015866b.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789739249; cv=none;
        d=google.com; s=arc-20260327;
        b=AjvclxkrBJ6fIluxkmZfQEADRjWXtJtkcDtFuf8oS6sHKH+OaShScDlXeBSJRcngNy
         AD9EcNDS/12ELul/GQejcqZJLyfqBlePM4FY1DGHcAOmlWGLzNvDQopbdaeq9yHlYvSq
         caaiPtCyMgj+36LyocaFqodzwRgJWJzdcgf9kOJ/xH63AErmYi3ZGcED+SirqFQH75Ub
         tbiWenME56SkdJo8EuGj7Qe2aD7rydEw9J9JpsSaFGUh8liBQekpIJga3tEtej3DLUOY
         xmMnEt0eA9YRHXEDMVQALiC+xOKAOI629OeXL/iyqiPHkY662Up/Po0lW1y2CmZhH0iy
         9wXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QO8ZLWws9kX6Lxf9eVXFyTYmcZBNVguGNqNy3JkPkOY=;
        fh=NUS5me/+xqrUEonad5DjFRgnEPm7JKOMvaG2zhuU3aw=;
        b=RN3TfaXc5wveANGtkIpjVRSD5WUDEqkxmWSuJUiVmzYispZfgb0JRWNEGvwdLZ/jUA
         RjPCl+lCJdnjvl39OZgXAgPhdPTtAfULgkIDS8UKfkupudTH68flNeIHIuJFg13IuOk2
         YfsPyUITyCy47LNhv+4xzVj1BFk4o5gM+ifE0hnicb+tKiEyxIA1Wm5ekBS9Cn+V7UNg
         3/AZgxP6LuxWiiGahjCCxRA9J8FAU6ED8dQKVIIDj6mwnn78BM3Zgw5x5MXFsrb3PVAQ
         YEgPr0C1k4P/kMHQ7VMwkHVoC4/zHpuHN3PEy3XozRM8PBy0L735riaDxIkSi3Y3Jnwh
         S81Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789739249; x=1790344049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QO8ZLWws9kX6Lxf9eVXFyTYmcZBNVguGNqNy3JkPkOY=;
        b=FuA/HkPG+vVEQoZv3L8gIP7ubjwnz/F9kId+vgTAAEGuPZonzjMBEEdT6S4AF0EQWy
         UYt1SiwIpCSNiVFHTpQlluXnXB3ogytUaUuXxiGkNqKvRrbjF82yF3plSDcNIqtd1719
         OxqVwBcllaPcb7vLuScjiy5u7CLBTlx9kWk+Tx3zY7cseNWy3cz1S09OgzIQFP8euR51
         HYJXoph7PorVWFfvDJ7rpsZI75LWrHkGA873olAPMSCO7LsrmN470RH49IQogIRshkPV
         vzwWfmQEdDlJU8q0u1vT/kgH8qxJ6MRkfow7z4FFd5TtcBndN656eePmr7297F8J0k9l
         TAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739249; x=1790344049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QO8ZLWws9kX6Lxf9eVXFyTYmcZBNVguGNqNy3JkPkOY=;
        b=1iViJwaSWgDGe+L4vmN4zUwYkm4EoZ3d4LGYp4X1p117UOfk7lrlNw511Tw3+Loy5j
         dy91fDBk2feixtqAGFwj5no+SxLrrvZSoIuXY/lgn3js59IunBbFNs4x5ZN8uHgPD9J+
         Y7uI4z3nhNqvMCJmTcidVq+wBcJmT2gmYSK+/wy1I9BYmAUAalCM2O3kb9o+4eEKtbZU
         XWOAFZLehIJt9eroZ4GANllyef61mPeI56Xgcrpwut5NSH7tRSIpdpPF4KeXKRsFX2vs
         aRgy4mh2zmaCKnGo6ynutudwRy2Gz5K8k8UbNzhxYwR8GoIMtNGu9zdRlYdfa0rSfF1N
         u5cg==
X-Forwarded-Encrypted: i=1; AKwUvBy/fginycuBvQRWnOWOMPHaiSTa2gFNWxRDy+XcivLJTo/t7PtyYqnV8qsY7DyHWFuPI0gCm2o3aQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lV5zt1NDYGF45Zw0GIYvMtDdG5A5w5HcHFaueVwZOvvcwYoI5Y
	qHMG/WzrqHhTNECRcw5OScZpM9e4uJQQTo2jlYIRry4HxVZ3tFzz/Kx+ArHrXjwe/DteRiiosIH
	vQO5/zKnyKhsHOmcqdajtzkJuqOYbUljcLg/ckg75Jw==
X-Gm-Gg: AYBFou1ArlmzwrTJ3nir3AR1Sv1gTfUzAk+H5VQn8fWiOr6Dv/F1jHZ2JJShb+ou3RX
	K65DNXqqUo8a3/QbZGHqQU247Q488bMwq3IO5ML52gBavnjUiSWY0y/+SulDDVDkXum/lWG4dn8
	GAbqLOQ+n93QqBUkhUa0evgTE2sf8DmfhHbiX+scFh7E6+hSO7Awmwdw+Ni6IdXCWFloGo9elTV
	sp+qX/PcJ5Fi0ZSx+JeZUnAG+A/7FR53Twll5N1QaFYKb7qESnr4mx8e+kZNoM6/kCQb/rV7um2
	uqNA+1eB5gzjeEDU4Dm9j73Hbtsw/e1hd1B7L8zCOA9kdGMx8lBmEBv7okkAIy7ytEL7gmz45dN
	QCkp9l27I4sW1
X-Received: by 2002:a17:907:1ca4:b0:c26:1649:47b4 with SMTP id
 a640c23a62f3a-c2a15b992d7mr309203166b.42.1789739248591; Fri, 18 Sep 2026
 06:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
 <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com>
 <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com>
 <CAKfTPtATz-aToAVh4sGsTRKM+0sOoVW4AC6gjufAjrFyZg1zFA@mail.gmail.com> <CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 18 Sep 2026 15:47:15 +0200
X-Gm-Features: AcwNN1W01KcSqUZt1AGSU22f1iJKGB9-Hw3ulW0-SUdG6V6LxuDXDp0Zb6T8r5k
Message-ID: <CAKfTPtB2YZDy11sXgu06v9WBORBeMQ6z5riCfajyqvC_kAfXLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ananthu C V <ananthu.cv@oss.qualcomm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sept 2026 at 15:34, Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Sep 18, 2026 at 2:36=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 18 Sept 2026 at 14:05, Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> > >
> > > On Fri, Sep 18, 2026 at 8:24=E2=80=AFAM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Thu, 17 Sept 2026 at 21:07, Rafael J. Wysocki (Intel)
> > > > <rafael@kernel.org> wrote:
> > > > >
> > > > > On Tue, Sep 8, 2026 at 10:31=E2=80=AFAM Ananthu C V <ananthu.cv@o=
ss.qualcomm.com> wrote:
> > > > > >
> > > > > > capacity_freq_ref, the per-CPU frequency-invariance reference u=
sed by
> > > > > > schedutil, is seeded from policy->cpuinfo.max_freq at policy cr=
eation.
> > > > > > If boost frequencies are filtered out of the frequency table be=
cause
> > > > > > boost isn't yet enabled at boot, max_freq only reflects the non=
-boost
> > > > > > ceiling, so capacity_freq_ref never learns about boost frequenc=
ies for
> > > > > > the policy's lifetime. Enabling boost later raises policy->max,=
 but
> > > > > > capacity_freq_ref stays stale, leaving schedutil unable to scal=
e
> > > > > > utilization or target a frequency above the non-boost maximum.
> > > > > >
> > > > > > Track the highest frequency in the table regardless of boost st=
ate
> > > > > > (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.ma=
x_freq,
> > > > > > max_table_freq), so the invariance reference is boost-aware fro=
m boot
> > > > > > regardless of whether boost is currently enabled. Runtime enfor=
cement,
> > > > > > still handled by policy->max, is unaffected.
> > > > > >
> > > > > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > > > > > ---
> > > > > >  drivers/base/arch_topology.c | 3 ++-
> > > > > >  drivers/cpufreq/freq_table.c | 6 ++++++
> > > > > >  include/linux/cpufreq.h      | 1 +
> > > > > >  3 files changed, 9 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_t=
opology.c
> > > > > > index 8c5e47c28d9a..da94f77441da 100644
> > > > > > --- a/drivers/base/arch_topology.c
> > > > > > +++ b/drivers/base/arch_topology.c
> > > > > > @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_=
block *nb,
> > > > > >         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->re=
lated_cpus);
> > > > > >
> > > > > >         for_each_cpu(cpu, policy->related_cpus) {
> > > > > > -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpu=
info.max_freq;
> > > > > > +               per_cpu(capacity_freq_ref, cpu) =3D max(policy-=
>cpuinfo.max_freq,
> > > > > > +                                                     policy->c=
puinfo.max_table_freq);
> > > > >
> > > > > So isn't capacity_freq_ref supposed to correspond to the CPU capa=
city
> > > > > returned by arch_scale_cpu_capacity()?
> > > >
> > > > capacity_freq_ref is the frequency that has been used when computin=
g
> > > > the capacity at boot
> > >
> > > I get it, and so it is what I wrote above: The frequency of the CPU
> > > when running at the arch_scale_cpu_capacity() performance level.
> > > Isn't it?
> >
> > Original it was not strictly tight to arch_scale_cpu_capacity but to a
> > ref capacity but it ended up being arch_scale_cpu_capacity
>
> OK
>
> > >
> > > > and it should not change at runtime wether the
> > > > boost is enabled or not, otherwise you will have some fluctuation o=
n
> > > > the system capacity that will create issue with PELT and scheduler
> > >
> > > So the capacity should be constant and consequently, capacity_freq_re=
f
> > > should be constant.
> > >
> > > Also, if boost is not enabled when capacity_freq_ref is set and there
> > > are frequency levels marked as "boost" in the table, it cannot be the
> > > maximum frequency in the table because that's not what is used for
> > > computing the capacity.
> >
> > I'm not sure I follow your last point above. It's not because boost
> > isn't enabled at boot time that we can't the highest boost OPP in the
> > table as a ref freq to compute  arch_scale_cpu_capacity. In this case,
> > the CPU will have a pressure on its capacity until the boost is
> > enabled. Do I miss something ?
>
> Well, I'm not sure if my understanding is correct.
>
> Suppose that the cpufreq driver has a frequency table which is
> processed by cpufreq_table_validate_and_sort(), right after the
> driver's ->init() has returned.
>
> That function calls cpufreq_frequency_table_cpuinfo() for the first
> time and policy->cpuinfo.max_freq is set.  However, if boost is not
> enabled (that is, cpufreq_boost_enabled() returns false or
> policy->boost_enabled is false), it only takes frequency table entries
> without CPUFREQ_BOOST_FREQ into account, so policy->cpuinfo.max_freq
> is one of those frequencies.
>
> I would think that the CPU capacity has already been set at this point
> and now the question arises whether or not it corresponds to
> policy->cpuinfo.max_freq because that is what is assumed by
> init_cpu_capacity_callback() invoked subsequently (via the
> cpufreq_policy_notifier_list chain).

init_cpu_capacity_callback() will normalize the capacity of all CPUs
once all cpufreq drivers have been probed and it will then trigger a
rebuild of the sched domain with these final CPUs' capacity

>
> The $subject patch seems to suggest that the answer is "no" and the
> capacity really corresponds to the highest frequency in the table
> which may be flagged with CPUFREQ_BOOST_FREQ.  Is that always the case
> though and if not, then how can we tell?
>
> > Can the boost OPP be added later?
>
> Not really.  It is already there in the frequency table, but the
> question is if that's the capacity OPP.  I guess we need to assume so?

okay, I was just to confirm that this can't happen

>
> > We keep taking the max between freq table and cpuinfo.max_freq fo the
> > case where the boost freq is not listed is the freq table or there
> > isno freq table. Or there is another way to get teh boost freq in thsi
> > later case ?
>
> No, I think it's the only way.
>
> So init_cpu_capacity_callback() should find the highest frequency in
> the table (regardless of whether or not the "boost" flag is set) and
> set capacity_freq_ref to that one for each CPU UUIC.

yes

>
> That's roughly what the patch does, but it can get away without adding
> a new field to struct cpufreq_policy.

Yes, That was my point: we don't need a new field to find the highest
frequency in the table (including Boost OPP)

Thanks

>
> And the changelog needs to be rewritten to tell the true story.
