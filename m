Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7095374A0D
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843323; cv=pass; b=LS8+blNX8UhqgsDUPkhfhL/ll0mHH+fPpzC69QajxAROXtTbPasNeXhSzXNPimhDXyBnVJNMEZekz/rw3kuhma62j9yEuqhqvQ6XdtZ7P7mS3LohhTY1j7lGsMh+AfYf9r6Qy7iLy8i56LQV45j+OthlqpzqG/90Jz33RGYAQAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843323; c=relaxed/simple;
	bh=CECvrklXu3ex6EzfGgtlEfLqawSDQLf8UXGyG/TNXfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bn89KeFLKkKXjvKGRt+onPZvXlo708YtdpojuAwQGNkvV9SKnbNL38xXh13FOhIrb7N2EXnuOnfyeuYTwDl0y8vxC413519PcQ4F93XYQOyU8RyMBGobGwmi5S6dRbIRvJRLdJKv8Z+L74LtX9dA4j9XEf0bWdv4+jukJyfyGYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmO4nqlt; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmO4nqlt"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb11c7347so2779797e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 11:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843318; cv=none;
        d=google.com; s=arc-20260327;
        b=jAcBCBYG9nlXBsemofmjtOfywEcALviIYS//Q8CUM/HlJfp6Ocv73wfve/2vwdmiuD
         rNN/6naf/3uW/bYc1XAk1YsgmIyhg0kT/+PZvfV1+b1keLIxY5fKXLgXZ8qD0E82AufC
         ChuneacZGTfOspA8uVNeXH1QSFrU95jHHhdg4+uqayHGzz8c1xg/2loUuC4oX4pDCYuI
         TO32VSV9XC0BIHOL38WkZpumUoboZZl4Rr3HVwqhbf8+IkeVt30xLdiI7bAGbokO5t2x
         YjZcBPcifqe2lFyMwoNvux3OFsYr7CT0YN/B72FB2t9dmpxxp8KXQ5tQBb/7GnE1dNhT
         YOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D5+NNVuz/78npjn+WBVd7tH9J0s1hX9Om4dXEd+goZE=;
        fh=3hMc4xFMOSDRXpXGkmqMyA1bmVzAuWoxmczc2osF5Ts=;
        b=RatMjEEFP9LNy4UYvLNR0ddQrf85gYpWElQGCnRYCLNsxxhSqXghOtgFMtN/Hww+id
         PiLLS3C/rsIfXf4Vk3zn5PGln7FVrHIxGxR9T9gfbviZnByywm/GJ7dgMbZ6g31GVGSP
         dS0xuf2e/ideNYPWrmYBi4bOd13IQLhrBzdUPpWR4gX/8iQTqsCjrYX2NQO7BiI/aLRF
         kWU2uUthDVs2VbDY9d/BG4rvBoLXXodC7x92IphzqiIKdLPfn127OPPiBVJWvzOfPOig
         21ZZt9l76qx07dBP5GKc1oEanqAAKAJSawWdQcG5GxD6XPMmIz/PsdsaVhu/gT4r58nk
         8jBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843318; x=1783448118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5+NNVuz/78npjn+WBVd7tH9J0s1hX9Om4dXEd+goZE=;
        b=nmO4nqlte9qDj6P4v6U0mT7U+xl5/CFwB4aahxaofY7dafSqGT3O5OlzlSQe6h3Mg+
         gwxi0/OEUYRRpAaQSK/Gpna4CEtd/w6qiJ/o5EbjXUGZVZsDrhh+ySXwzuElEYVVAM+3
         mpBcPWIbttQg/Dmxbcm2qgrLGqfca6x2c6rsH+zVkXXoMPutyynmLhkdb7oL6Gr34Rvv
         5Wt9b9hwWTOO9xnRP7LVMSBGcRTL4zksvM3kwjZ6zdWC508LGwXtkC1Vancxc4Xxsa3h
         PV1QqvDcVlVArVig0V/+8Oid+sz9mloB+JylNAo1qFoIi0LIILRpxvGPUhnaEhZQEjnH
         vHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843318; x=1783448118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5+NNVuz/78npjn+WBVd7tH9J0s1hX9Om4dXEd+goZE=;
        b=fZR97s6YeUkJ7LxteXzRjCcX8oNRmfU84fNDDbKOELe/J2s3O9zC2+MunIJI68ANyd
         Vi3Ld5pEs0GHi9VodmYPxENkxvL4gSwuje9NWD1ZzTaRssXPJ3XFTtHwlH3WktENpmkC
         4PtCCvhod/Ddm244BzLEo5g/YiVo+BcvKN+JNm9X7SRnmGnJeeZq4Ipr23bx01c/GmUl
         xgARO0Z38nn4oqN2lB1gj8a3bR8mpLWxcDzDm26TjUbgtNzY+wifvzRDkDVEwCy+8TWe
         GTculUWJ9FsroCmkyeAUaei3AZA4GMouDwQCmvywsdyJgXIRMTqRSlmf+h5KzZ1+gMRg
         TpkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp860XQ6Xd/7NzOuqWneL338lJQvBbibMgSIP+2vacyrhIK3A1f2iDsv+rdL2KVVaw3Tnu1KRXn+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRat+F9NyIAaXgHcDNbXZy3/Ext1OqYiDk7qv5lBxQK1Fjy3mk
	+RCRaMh3dDHsoYYj2x/KaxY3m95jeGpj8kWg/Vs+fWuMipZ4VtRITPSt3pfyMHI+EWZO9Deq/FM
	vgRyAWZQqCAsxYoO5QYWqLbCmMMX0mvA=
X-Gm-Gg: AfdE7cn/03W2uT2wo3RIP+Up68GaJPpMp9mlj88XCOPaHQqRZ3VMHVlD+hPEUx21BwI
	k17Mf2twWIESfkjPoiKIsQ19SU7W6vXEVuj3pOTLHCPzLnqRK7EXTk4BnfAOrd0wYdMdzaVySLj
	qVezSOV59SzS6ETmclj3DQd2Vc53bjSoxLAjRbP84FJWmBTpVsmoCZNH3lP2s3zg5NS/C/6TJ0N
	rIVDGimEnfBZgCE1KuORKjKoJy6cSSCpcRaC51TbM3OCwoAYIXJvN5bKIGlSFSydqD14eXLMYw3
	hEAPk6caz4ot3Dq+bJAFONutddgUMQ==
X-Received: by 2002:a05:6512:1248:b0:5ae:b2cf:8204 with SMTP id
 2adb3069b0e04-5aec10a3841mr527354e87.2.1782843317436; Tue, 30 Jun 2026
 11:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
 <6021784.DvuYhMxLoT@rafael.j.wysocki> <CAMVixxV83tSLEi_o1vmHjqfgPnnXDwo2LjP_m-Y7iEWfvUAP2g@mail.gmail.com>
 <CAJZ5v0h=u3dGbujFpU2yObyLXT0ZLZTxpG2+zLZLP7wpKsBvQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h=u3dGbujFpU2yObyLXT0ZLZTxpG2+zLZLP7wpKsBvQw@mail.gmail.com>
From: Lucas Lima <lucaslnobrega38@gmail.com>
Date: Tue, 30 Jun 2026 15:15:03 -0300
X-Gm-Features: AVVi8CfOYvRgKX1BVKZ9ztJkm1g1dlsELv7d9f73_ROHxL9yp_qLWTCJsZ7m5FQ
Message-ID: <CAMVixxXpT90bkwGTpL+T-d3ve7BTK3xXwBcaMfhvJ7R+DkxXiw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em ter., 30 de jun. de 2026 =C3=A0s 10:07, Rafael J. Wysocki (Intel)
<rafael@kernel.org> escreveu:
>
> On Tue, Jun 30, 2026 at 10:11=E2=80=AFAM Lucas Lima <lucaslnobrega38@gmai=
l.com> wrote:
> >
> > Em seg., 29 de jun. de 2026 =C3=A0s 16:06, Rafael J. Wysocki
> > <rafael@kernel.org> escreveu:
> > >
> > > On Monday, June 29, 2026 5:16:17 PM CEST Rafael J. Wysocki (Intel) wr=
ote:
> > > > On Mon, Jun 29, 2026 at 10:36=E2=80=AFAM Lucas de Lima N=C3=B3brega
> > > > <lucaslnobrega38@gmail.com> wrote:
> > > > >
> > > > > EAS currently refuses to enable energy-aware scheduling on a root
> > > > > domain unless schedutil is the active CPUFreq governor for all of=
 its
> > > > > CPUs (cpufreq_ready_for_eas()). This requirement exists to protec=
t the
> > > > > accuracy of the energy estimate: EAS predicts the OPP a CPU will =
run
> > > > > at from its utilization, which is only meaningful if the active
> > > > > governor actually requests OPPs that way, and schedutil is the on=
ly
> > > > > one that does.
> > > > >
> > > > > That requirement does not apply to artificial Energy Models
> > > > > (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> > > > > get_cost() callback instead of real power numbers, and only encod=
es a
> > > > > cost ranking between CPUs (e.g. P-cores cost more than E-cores at=
 a
> > > > > given utilization). It never claims to predict real energy use at=
 any
> > > > > specific OPP, so there is no per-OPP accuracy for the governor
> > > > > requirement to protect, regardless of which governor is in contro=
l or
> > > > > whether it tracks utilization at all.
> > > >
> > > > But it is still about comparing the cost of running on different CP=
Us
> > > > at different performance levels.
> > > >
> > > > For instance, say the scale-invariant utilization of a task is 256 =
and
> > > > it can run either by itself on a P-core, or with another task whose
> > > > utilization is 128 on an E-core, and say the P-core's and E-core's
> > > > capacity is 1024 and 512, respectively.
> > > >
> > > > Say the cost function tells EAS that running a P-core at 1/4 of the
> > > > capacity is cheaper than running an E-core at 3/4 capacity, so it w=
ill
> > > > pick up the P-core to run that task, but if cpufreq ramps up the
> > > > frequency of the P-core to the max when the task gets to it, it may
> > > > actually turn out to be more expensive.
> > > >
> > > > This means that EAS still has an expectation regarding cpufreq whic=
h
> > > > is that it will generally tend to run tasks at the performance leve=
l
> > > > corresponding to the sum of their scale-invariant utilization at le=
ast
> > > > roughly.
> > > >
> > > > IIUC this actually has nothing to do with whether or not the energy
> > > > model used by EAS is artificial.  The schedutil requirement is abou=
t
> > > > choosing a performance level proportional to the utilization (which
> > > > schedutil generally tends to do by design).
> > > >
> > > > > intel_pstate registers exactly this kind of artificial EM for hyb=
rid
> > > > > (P/E-core) systems without SMT, regardless of whether it operates=
 in
> > > > > active or passive mode. In active mode it never uses schedutil, s=
ince
> > > > > HWP picks frequency autonomously, so on these systems EAS never
> > > > > engages even though SD_ASYM_CPUCAPACITY, frequency invariance and=
 the
> > > > > EM are all in place: find_energy_efficient_cpu() is never reached
> > > > > because is_rd_overutilized() is hardcoded to true whenever
> > > > > sched_energy_enabled() is false. cppc_cpufreq registers the same =
kind
> > > > > of ranking-only artificial EM and is affected the same way with a=
ny
> > > > > non-schedutil governor.
> > > > >
> > > > > Allow EAS to be enabled when every CPU's EM in the root domain is
> > > > > artificial, even when schedutil is not the active governor.
> > > > >
> > > > > Tested on a Raptor Lake-P laptop with nosmt=3Dforce and intel_pst=
ate in
> > > > > active/HWP mode: find_energy_efficient_cpu() was never called bef=
ore
> > > > > this change (confirmed via the sched_overutilized_tp tracepoint a=
nd
> > > > > ftrace) and is exercised as expected afterwards.
> > > >
> > > > If this is about allowing EAS to work with intel_pstate running in =
the
> > > > active mode, you may argue that what the processor firmware is doin=
g
> > > > when intel_pstate runs in the active mode is not much different fro=
m
> > > > what schedutil would do.  So a driver implementing an internal
> > > > governor (that is, using the .set_policy() callback) would need to
> > > > declare that its internal governor is as good as schedutil from EAS=
'
> > > > perspective and so it will pass the "cpufreq readiness" check.
> > >
> > > And I have a prototype patch (on top of 7.2-rc1) doing this which is
> > > appended.
> > >
> > > I wonder if it works for you (that is, if it allows intel_pstate and =
EAS to
> > > work together both with schedutil and when intel_pstate operates in t=
he
> > > active mode with the "powersave" policy on your system).
> >
> > It does work, thank you.
>
> Great, thanks!
>
> So this approach is more straightforward IMV and that's why I prefer it.
>
> I'll need to revise the new flag description so it mentions the need
> for a "matching" EM to produce reasonable results and there are a few
> intel_pstate patches in-flight, so this one will need to be rebased.
> It also needs a changelog, of course.
>
> > >
> > > Also I wonder why exactly you want intel_pstate in the active mode to
> > > work with EAS.  Do you see any significant improvement in that case?
> >
> > About that specific topic i do not have any testing data, but it felt
> > like schedutil drains more battery than pstate active (likely due to
> > worse c-states management) and presents more stutters in general usage
> > (I would guess it's slower to react to load changes). After bypassing s=
chedutil
> > those very observations were gone, and the responsiveness of the system
> > looked very similar to EAS disabled, pstate active. Since EAS does
> > prioritize spreading
> > onto E cores, which do consume less energy by my testing, IMHO it's
> > almost too good
> > to be leaving it unused.
>
> Fair enough.
>
> > I also want to point out that gaming (mainly minecraft) stutters a lot =
more with
> > EAS on, even when pstate is set to active. So i wonder what do you thin=
k about
> > capturing the system power mode (currently only clamps frequency) and
> > disabling eas_compatible when set to "performance"? That would need
> > updating cpufreq_policy, but feels reasonable to let the user disable E=
AS
> > for latency sensitive tasks, since E cores struggle at those.
>
> Switching the governor (or policy if you will) to "performance" on any
> CPU should cause eas_compatible to be cleared for it due to the
> cpu->policy !=3D CPUFREQ_POLICY_PERFORMANCE check and then the scheduler
> will refuse to use EAS after rebuilding the sched domains.
>
> Or do you mean something else?

I actually mean performance mode in platform profile really, as it's the mo=
re
straightforward way for the user to request for more responsiveness
from the system.
For now, putting platform profile at performance does not change the
governor from
powersave, and as such, EAS is not disabled. A notifier from platform_profi=
le
to re-evaluate eas_compatible when the profile changes would address this."

>
> > I know that for now, my observations are only anecdotal, but if needed
> > I'm eager to test those assumptions!
>
> So it would be good to have some data indicating that it is beneficial
> to use EAS when intel_pstate operates in the active mode ("powersave"
> policy).

Will be on it.

>
> Also, enabling EAS by default for the active mode may be problematic
> because people may see (and report) performance regressions due to it.
> OTOH, EAS can be disabled via sysctl, so that may not be a big deal.

I feel that concern further motivates my proposal. I would not expect
the average user to use sysctl to change EAS or even to know
about cpufreq governors at all, so linking EAS to platform profiles
already exposed by the desktop might avoid complaints.
