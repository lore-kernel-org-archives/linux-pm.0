Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133192;
	b=jLxI54g+st6h//WzBWBUTXp7yaUfR66NGav+K+HCCgL0QeIYw4N+SEdkfr6BZqCLll4y
	 2GmB20G85vywPYlmYwRsiUzOVMHgk077Sj++fRu7tWYoKo8JEfZE0Afuo4a1WsdaUsDEU
	 vGQDQ8JStPetXMLuezo2soPF7noyK28ZKKOSZf0tbcA/BhL9nSdbOfjWA0fJJVD7dWlXY
	 5jXTAdbNVrgHVkT1wDX30BUG0JozVXmeKvy88tSf+wjJwVJYemk4JR2r349oErQqYY4e1
	 6ze6KhX66JXTZZKGxLAeAHTJRDUvi0cVQAw1EG+dDtzTh1ppDQTwVlWHfm4tIOj42Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133192;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2FqCr0vtvC5ycn1qRHHA8CslBTsR5N+niQDKzSUxH7I=;
	b=WYYxRcq+SZ1M+bZEhQRVGZ/3XwI/ihzG6agficWfMarnLIfvGUkPNgytxF75GztY5UNH
	 XF/s2SGpRXw4L1oh/ucC+idJHxUyWyqrkiMSQ/AIOQH/QYn4bjwKJveTUmuHfIRKmZRRS
	 GnsxbwoVFSFRS+WYIkZXJbXOR37Aon4C8ZgqeVNYrWl/9jlI4UgQ2VwQGmS9OuEhV/6Hq
	 IQWcERHXaHTZlmTITgUrxBDODQfoJqsIrrilv3/+gNPAJigGhowsWYO5zpult/htJubE7
	 uGGGQ6vMnN5dfOK0WrvpSsQbNztDo2mMuWg0l2MbKTpcnuLqMYxHkGaEN30V1/a5pcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcpRYrvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85276606A31D
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcpRYrvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6258A1F01829
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133192;
	bh=2FqCr0vtvC5ycn1qRHHA8CslBTsR5N+niQDKzSUxH7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WcpRYrvOVG1aJ37ezXi3++Z7WlV+yaXEVRPzmcezPwocvQFKIp8H+GG5uUjI++Nlp
	 NjnzdunOl/mEpIb5AwgBuMsZMpkeIueQD8yZp6XdNwiyRW38+OnH4/3KoywxcXW3Mn
	 6bqAldWChKWaIfMMrT7oJlx7eHqLAgD1mkazaQsOL1kEtij9qKNY8BxNLGFeT9p1xy
	 Kd4w+7+y+Xd9tBjEx/ZnGpjL3yLRzYwBcuvvN5iGzMFJS4BgSfwljz3+nYCNmn/W5B
	 rFaqIuCzTrCwV+DiYUF6+ta7KlyrNke+cH96rNeAHYeSGtfDcyGlbug1b92+xUyHlM
	 mj+CiLPCSWh3Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be42ae8eb1so269116e87.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:33:12 -0700 (PDT)
X-Gm-Message-State: AFq9FYJ/HMoxJ4SpKsAJv+lx7syyiBCTRxbK89S0TWIEAZrpdvNoTeEU
	xP5FXfWbNoCqlm88+on2Fi3UT/P0fcUeC0kIwkfUQvjYJuh0hkfF3b0i3RNM/zaDmP/yj4CQJBA
	OE7U9PwfTACDSxQkuaV+6sTEWQA5BRCI=
X-Received: by 2002:a05:6512:3090:b0:5be:5b2c:4a1f with SMTP id
 2adb3069b0e04-5bfcad78817mr180065e87.10.1793133190799; Tue, 27 Oct 2026
 13:33:10 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com> <001101dd6631$6167dbd0$24379370$@telus.net>
In-Reply-To: <001101dd6631$6167dbd0$24379370$@telus.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 21:32:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
X-Gm-Features: AclHuK9Y_aC0Z6Lw00AFtAqmLqdfvn5xP7iTM98AIvXgIjtr9f-bXfHMUUyvUFE
Message-ID: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume
 without HWP
To: Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>
Cc: linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2026.10.27 07:37 Zak Brighton Knight wrote:
>
> > From: Zak Brighton Knight <zakbrightonknight@gmail.com>
> >
> > On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
> > the CPUs stop using turbo after every suspend to RAM when intel_pstate
> > is in passive mode with the performance governor: they stay at the
> > 2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
> > policy limits change or the system is rebooted.
> >
> > During resume, the firmware sets each CPU's P-state request register,
> > MSR_IA32_PERF_CTL, to the base ratio (28), and the kernel never writes
> > the requested turbo ratio (38) again.

Well, not quite.

If this is suspend-to-RAM, all CPUs except for CPU0 are taken offline
during suspend and brought back online during resume.

So what happens is that cpufreq_suspend() runs first and calls
intel_pstate_suspend() for each CPU.  Without HWP, this just sets the
cpu->suspended flag.  In addition, in the passive mode,
cpufreq_suspend() stops the governor for all CPUs (which does nothing
for the performance governor).

When CPU offline takes place subsequently, intel_pstate_cpu_offline()
or intel_cpufreq_cpu_offline() is called for the CPU going offline.
The former clears the util update hook and invokes the latter.  The
latter sees the cpu->suspended flag set and bails out.

During resume, CPU online takes place first (except for CPU0) and
cpufreq_online() runs for each of the affected CPUs.  Each of the
involved policies is inactive at that time, so cpufreq_policy_online()
runs.  It invokes intel_pstate_cpu_online() which doesn't do anything
interesting without HWP, and then cpufreq_init_policy() is called and
it ends up calling cpufreq_set_policy().  That one calls either
intel_pstate_set_policy(), in the active mode, or the governor
->limits() callback that for the performance governor ends up calling
intel_cpufreq_target(), in the passive mode.

intel_pstate_set_policy() does the right thing and sets the P-state to
the max in the "performance" case, but intel_cpufreq_target() doesn't
update the PERF_CTL register if the new P-state value is equal to the
cached one.  That only happens for the performance governor though.

Subsequently, cpufreq_resume() runs.  It calls intel_pstate_resume()
for all CPUs (that doesn't do anything interesting without HWP) and
starts the governor for each of them in the passive mode, but that
does nothing for the performance governor.

This means a couple of things.

First of all, the fix is not needed in the active mode for CPUs other
than CPU0 because "online" takes care of them properly.  It may be
needed for CPU0 in that case because its PERF_CTL is never updated
throughout suspend-resume.  However, in the active mode, if the
performance governor is used, it is actually fine to access
pstate.current_pstate and call intel_pstate_set_pstate() without
synchronization because the update util hook is not set in that case.
If the powersave governor is used in the active mode, the update util
hook would need to be cleared at suspend time and restored at resume
time (modulo the possible offline and online in between).

Second, in the passive mode the fix is generally needed, but it is
safe to do in that case because the governor has been stopped during
suspend and will be re-started only after calling
intel_pstate_resume() (IOW, the needed synchronization is already
there).

> > Without hardware-managed
> > P-states (HWP), intel_pstate caches the last P-state it wrote and
> > skips writes that would not change it.  In passive mode the cpufreq
> > core also skips requests for the frequency it believes is already set
> > (policy->cur), because intel_cpufreq sets CPUFREQ_NEED_UPDATE_LIMITS
> > only with HWP.  Neither cached value is updated across suspend and
> > resume, so as long as the governor keeps requesting the same P-state,
> > as the performance governor always does, the register is never
> > rewritten.

Not entirely the case as you can see from the above.

> > Governors that change the request often, such as schedutil, mostly hide=
 the problem.

Well, the question is whether or not it makes sense to restore a
pre-suspend value that's going to be overwritten immediately.  Maybe
not.

Since in the passive mode it is always safe to carry out that
restoration, it is kind of straightforward to do it always then.  In
the active mode though, it's probably better to just do it only in the
"performance" case and only on CPU0 (that doesn't undergo "offline"
and "online", but since it appears to work for you anyway, fixing the
passive mode may be sufficient for now.

I'll cut a patch for this unless someone beats me to it.

> >
> > Fix this by writing the cached P-state back to the register in
> > intel_pstate_resume() when HWP is not used, as is already done for
> > the HWP request when it is.
> >
> > The problem was found and root-caused, and this patch was drafted, with
> > the help of an AI coding assistant (Claude, by Anthropic) during a
> > performance review of the machine described above.
> >
> > Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support"=
)

I'm not sure about this.  Maybe some other change related to "offline"
and "online" support.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> > ---
> > Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
> > with v7.3 plus this patch and a temporary module parameter, not part
> > of this patch, to turn the fix off.  intel_pstate.c is the same in
> > v7.3 and in the base commit below.
> >
> > Each row is one suspend to RAM and resume (rtcwake -m mem -s 25).
> > "Request" is the P-state read back from PERF_CTL on all eight CPUs
> > 5 and 17 seconds after resume; "clock" is the measured speed of a
> > single-threaded busy loop.  Before every suspend, all CPUs requested
> > 38 and the clock was about 3.8 GHz.
> >
> >  mode     governor     fix  request after resume  clock
> >  passive  performance  on   38 on all CPUs        3.8 GHz
> >  passive  performance  off  28 on all CPUs        2.8 GHz
> >  active   performance  off  38 on all CPUs        3.8 GHz

Had the changelog been accurate, this would have been 28.

> >  active   performance  on   38 on all CPUs        3.8 GHz
> >
> > The passive-mode failure was also reproduced twice on Fedora's 7.2.11
> > kernel.  In active mode the request was back at 38 after resume even
> > without the fix, so on this machine the fix only makes a difference in
> > passive mode, the default without HWP.
> >
> > Not tested: systems with HWP (their code path is unchanged, only
> > restructured), other machines and firmware, and suspend-to-idle.  The
> > patch adds no warnings with W=3D1; sparse was not run.  The tests were
> > scripted and run by the same AI assistant.
> >
> > drivers/cpufreq/intel_pstate.c | 16 +++++++++++++---
> > 1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
> > index 17158cb..53db91a 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1371,6 +1371,7 @@ static void set_power_ctl_ee_state(bool input)
> >  }
> >
> >  static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> > +static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate);
> >
> >  static void intel_pstate_hwp_reenable(struct cpudata *cpu)
> >  {
> > @@ -1404,11 +1405,20 @@ static int intel_pstate_resume(struct cpufreq_p=
olicy *policy)
> >       else if (power_ctl_ee_state =3D=3D POWER_CTL_EE_DISABLE)
> >               set_power_ctl_ee_state(false);
> >
> > -     if (cpu->suspended && hwp_active) {
> > +     if (cpu->suspended) {
> >               mutex_lock(&intel_pstate_limits_lock);
> >
> > -             /* Re-enable HWP, because "online" has not done that. */
> > -             intel_pstate_hwp_reenable(cpu);
> > +             if (hwp_active) {
> > +                     /* Re-enable HWP, because "online" has not done t=
hat. */
> > +                     intel_pstate_hwp_reenable(cpu);
> > +             } else {
> > +                     /*
> > +                      * PERF_CTL may have been changed by the platform
> > +                      * firmware, but it is only written when the requ=
ested
> > +                      * P-state changes, so restore it explicitly.
> > +                      */
> > +                     intel_pstate_set_pstate(cpu, cpu->pstate.current_=
pstate);
> > +             }
> >
> >               mutex_unlock(&intel_pstate_limits_lock);
> >       }
> >
> > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > --
> > 2.56.0
>
> I confirm your findings and tested your proposed patch. It all worked fin=
e.
> I had not seen Rafaels's reply about a possible race condition until now.
>
> Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.

Passive or active mode?
