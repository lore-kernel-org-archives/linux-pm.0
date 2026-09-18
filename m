Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1C3A8FE1
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734993; cv=pass; b=TF7CDP7+sqDeXXuH6a3FbTUMStIZcOVMe+Wxhd01rUPZmgldJc6RhuJQSaL92NdScgJpIznas4KnAxMxBzCuMPaM/Doh7bC+R4A747Yz7eay0NLqvVRkQ5fsowZ3BFQB+iXHGT0ydbW6WvFT85KZpScWw9CJshEEKl8+tg2P+6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734993; c=relaxed/simple;
	bh=ysnMiBH8a51PedUXUP+ET751iYcNEGGXFcUmatH4p/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnAblOw2XMC6FbQYePoyiPRlQ8+CUd+aKI6sVFXiXU+SjtQobnTI/KYmMhB4fJQVwm+/ExHtXWq2zO9ck2XIteu19lTTmQVm4hcio7VfcVg8BtXM716FcoUlO/XFG+PMPdXt8i86KOtHI1q5lpgpnF0jPcwa+d6tCPUsZeECLlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHnRMvlR; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHnRMvlR"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a56so89005366b.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 05:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789734989; cv=none;
        d=google.com; s=arc-20260327;
        b=q9F02D/gwJ0bZyGjx/F4t2NScR+9FJBDmWQVG4Wf/H9+XdLXwSD4Ofqk9lR53QvNbJ
         r08uOUTBF/S/37uYCBEty1pV9v1DyO4Y8tyaNkm/kP3C+3Qz7EMDsxb762cnGQC2Asfr
         6wjjXL2oJQBbd2AW3Is3qh3YIGzLIC18Ec+gI345YtJOCglMqtzZBmWg4w+aBo9auerE
         j7FbG66akL/UEhn6IuwGL9H5kHdc1mYE8I6ajQkSI71NPhhgEf7jHoi5EayPycP4lAHb
         eZUyzAEx/0d5BypQtrlNZ7Gskn9TFLgBqyh2WZgaAIEsUGmiNyrcyCz22TVVuTkJBsry
         M7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKsYx66twfZvJriia1T7NKBKpGPrJrg+q151uNCCMjs=;
        fh=XWWsk5ftP+fBVchB8penryj7AvOxf5N1UJRbJIH0n3s=;
        b=cdRh2LORa5Pxx+wfOPwI6tz/oBC/D/p845w8m4kBLdOVNpyhUI+125gDOqLJe+szyv
         dSCbeysM+T1EG+kdkjAVolMi/MFBaicKfY7jBszDa93lEMtL9ql/Az5dDOjEwFz/lbWv
         0MqHVVdmBy2ltbgf+4S+huDlTnIS0mLjBP3hZEGrEJ6zKGi3evNqg0DMLLJSy3EZxexZ
         QArEk2aoZObPWA3Yn6dbIlAFkv8bZgw9eW5MyjIRzIKeKi6e5XoMf7CW3cXDgC7EY+RQ
         MHD3ouGgcseHNTxPUVN9HXBCg2pQSOq2SE4tn/02QlAjsETfdUh9mNMnvZtqczHw/sYx
         WKeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789734989; x=1790339789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKsYx66twfZvJriia1T7NKBKpGPrJrg+q151uNCCMjs=;
        b=IHnRMvlRUhcxMd+as1RG51JqHG02A1pi+oT22Wg98qDmLmehrPscBKdNddnl62tTI6
         qyOf6b8ltD3YWWUaaMJvDOemBE7E5Dyphq07rk+3AiNMSE89A6ILBCTvAQI2GLARuCvW
         ig3OVsD2QaVWaJ0YEMTbTi7Jyh2TGCRyiG+Sixk4Bh5qsQVgq7WR6l1Uf4TrpsLA4o4k
         LMjFevVyR4aghoMDsRv/wf4KQ7eMpwOSCPYZVXSlAhfYiYiZDo9niN0CXJ8WzI82IFHj
         JvM+O1bLO5AXomo8QikNffMKnqNPJhkA1enGglXMg1pka6k8fulr+tN7MVSy2rI57wrJ
         R4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734989; x=1790339789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKsYx66twfZvJriia1T7NKBKpGPrJrg+q151uNCCMjs=;
        b=bTASBHxZbSGLuZVZT7I5yRk8tp5XAvieEKzjk5Mi9+o4H2+2FHJSqnLU5P0VlvIPCW
         bbrSniixnbbg0HS9fKPK/bBfuBOw5z7/m6MNduVHyKH/knWWlkWhgf0KkWUATuwGRuOp
         3GzWAX8tUHwOwkttJyD3fGncFEMge9bdNPsg8dKo9Wy9REtuI68aL/6MFWIW76KtbrZg
         FZlX5AXDDHSe0C0vkNdjoe4rGO2THF0sMHyXIdCBIFjkBgomVbMPyk7BC4Rx8PbtlB1e
         Yuii4oiXdJQnhSHRXZyrv1ZiyvxyBJeTiXK/px+vWN85YdScaCDFEesmIRH+iRaetego
         8yxQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0b+OnyHyKssnk0A+CqtkhP1fTvKOtYfnAr0JZFUXuM0+S5JqDKX5DEZgY+qshMvPetPvmiFPcmg==@vger.kernel.org
X-Gm-Message-State: AFuF++mi0aM21qhtsKeo94HyFl9nExiQWEosBTxEVGLfRGz2g3WsQREH
	XF5LMtHVW9kUbN4qNT5DM2omGi+3OrH43/aVlYSdztOwyNxoMiakudCQ6me06YefHD0u6nmvXUW
	QZkSyqwrQ4NMpKaZRAkcjvpvQ0yEBNjebG2ildOTwCA==
X-Gm-Gg: AYBFou2M8GH2R/SQVo0lYAZHb9eunBsKVAUcJHcDdDnHoZh5pokGDiWXZLnMhGThZfn
	FPvTTUqIX4GAsPP1snW2ZLPWPZfp+E8hkW+RRBBb8vj0uPBj2dbNZCysNCDg+vIyZWy0DOikFUk
	BH1P8AapCxiKdxeSzqXTyy6gHqTGuPmu+/EfLopiI30GZqmjBZF8xtc6LSh4tP2ujJCnjDrF07F
	qICTmcQ2hml3zYw/nGJ6IsdGZGg9S9bZVPjGXYyfAZbmHQMG2Nw5I9p6wC/bnZO1XM0rPzE6OR5
	y4i3nqWysoG2Ba8J9NRpX/DscBDUINCzpnBp7GJsmun733IkudKTYEDj1rStj0Y0bOfGsywSYF/
	KEvghwi6TXav+
X-Received: by 2002:a17:907:a88f:b0:c29:f0a4:a4f8 with SMTP id
 a640c23a62f3a-c2a1547f700mr254964066b.0.1789734989460; Fri, 18 Sep 2026
 05:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
 <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com> <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 18 Sep 2026 14:36:17 +0200
X-Gm-Features: AcwNN1X-haI5NlBDtJXpiUSlIDI7Ing7knQH9apUE4h3FDeBzBoyuWxWIfi5Cts
Message-ID: <CAKfTPtATz-aToAVh4sGsTRKM+0sOoVW4AC6gjufAjrFyZg1zFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ananthu C V <ananthu.cv@oss.qualcomm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sept 2026 at 14:05, Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Sep 18, 2026 at 8:24=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 17 Sept 2026 at 21:07, Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> > >
> > > On Tue, Sep 8, 2026 at 10:31=E2=80=AFAM Ananthu C V <ananthu.cv@oss.q=
ualcomm.com> wrote:
> > > >
> > > > capacity_freq_ref, the per-CPU frequency-invariance reference used =
by
> > > > schedutil, is seeded from policy->cpuinfo.max_freq at policy creati=
on.
> > > > If boost frequencies are filtered out of the frequency table becaus=
e
> > > > boost isn't yet enabled at boot, max_freq only reflects the non-boo=
st
> > > > ceiling, so capacity_freq_ref never learns about boost frequencies =
for
> > > > the policy's lifetime. Enabling boost later raises policy->max, but
> > > > capacity_freq_ref stays stale, leaving schedutil unable to scale
> > > > utilization or target a frequency above the non-boost maximum.
> > > >
> > > > Track the highest frequency in the table regardless of boost state
> > > > (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_fr=
eq,
> > > > max_table_freq), so the invariance reference is boost-aware from bo=
ot
> > > > regardless of whether boost is currently enabled. Runtime enforceme=
nt,
> > > > still handled by policy->max, is unaffected.
> > > >
> > > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > > > ---
> > > >  drivers/base/arch_topology.c | 3 ++-
> > > >  drivers/cpufreq/freq_table.c | 6 ++++++
> > > >  include/linux/cpufreq.h      | 1 +
> > > >  3 files changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topol=
ogy.c
> > > > index 8c5e47c28d9a..da94f77441da 100644
> > > > --- a/drivers/base/arch_topology.c
> > > > +++ b/drivers/base/arch_topology.c
> > > > @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_bloc=
k *nb,
> > > >         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->relate=
d_cpus);
> > > >
> > > >         for_each_cpu(cpu, policy->related_cpus) {
> > > > -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpuinfo=
.max_freq;
> > > > +               per_cpu(capacity_freq_ref, cpu) =3D max(policy->cpu=
info.max_freq,
> > > > +                                                     policy->cpuin=
fo.max_table_freq);
> > >
> > > So isn't capacity_freq_ref supposed to correspond to the CPU capacity
> > > returned by arch_scale_cpu_capacity()?
> >
> > capacity_freq_ref is the frequency that has been used when computing
> > the capacity at boot
>
> I get it, and so it is what I wrote above: The frequency of the CPU
> when running at the arch_scale_cpu_capacity() performance level.
> Isn't it?

Original it was not strictly tight to arch_scale_cpu_capacity but to a
ref capacity but it ended up being arch_scale_cpu_capacity

>
> > and it should not change at runtime wether the
> > boost is enabled or not, otherwise you will have some fluctuation on
> > the system capacity that will create issue with PELT and scheduler
>
> So the capacity should be constant and consequently, capacity_freq_ref
> should be constant.
>
> Also, if boost is not enabled when capacity_freq_ref is set and there
> are frequency levels marked as "boost" in the table, it cannot be the
> maximum frequency in the table because that's not what is used for
> computing the capacity.

I'm not sure I follow your last point above. It's not because boost
isn't enabled at boot time that we can't the highest boost OPP in the
table as a ref freq to compute  arch_scale_cpu_capacity. In this case,
the CPU will have a pressure on its capacity until the boost is
enabled. Do I miss somethign ? Can the boost OPP be added later? We
keep taking the max between freq table and cpuinfo.max_freq fo the
case where the boost freq is not listed is the freq table or there
isno freq table. Or there is another way to get teh boost freq in thsi
later case ?
