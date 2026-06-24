Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC53B38B7
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308172; cv=none; b=ZSnBAPeA6Us6Aroyj6BqVykMlQN9u+y1eWqxKjo9+Mj+ypHLWEreLFJ2S8Vp1fih1WGa+M7/tbSynGsLyOG/JtuDewBBug5d6LGqqu/+YpvZ89i5QmCiUD7gT1fCel4CSohx3QVMTB4O/i5gjf0v2H6HtS7lNKprmuFMMK+QyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308172; c=relaxed/simple;
	bh=fJgYKuTeumlAmQBLTcqAa2MPjW0sx4rAMEED5KVoepw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hy3CY3fqEFhdHYcPkeEUd2PgLglaX3IrpWsA6ZMwBwAXQFJv8DvhaDn+8D9aYGxl4w4Kn0TI3YRnUx1io+DtrPqj1OCe3LsIzD7/4CR7srjhF1NtXksJ4MaLD1X5XhjGYW8lzUfnPIRv61pyk19yWJbGJ8aRQkrErVIzxXn8RHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbx1wEQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbx1wEQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C2E1F0155C
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308169;
	bh=tuY+ZoOzQpLm5q0KFZmGWp6DKQmJ5wEe6PDOUs4cBS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Lbx1wEQDN/6tu6DdJrei0THldtdNajIemSoHMGZ74tAvtdARIEa1uWCvC60qT+PL3
	 x32Nqk35IL9kti0haTWoekJ/VItFyAbbqlqWKFmiepihScaoYJ+5JF/wmNVU7NSAYN
	 LBxana5hcvvj+mZm1TVl/JJXD1JWIoyscDowc4WMQZgSMnYEKd+FAf2qyrBgifmU57
	 +xRryF+BPwkPo+hM0GyEDgRJe/uPvCTVWpOlfopk5HFhFd4/T1rOk1+RdA2EkgNKIC
	 OHARn9PlYeUvKEUV81cWUauTi9P4O5A+NtxVvw3l9SO8NZf7fB152JYhJ/u1JNg2V/
	 sorAUls8jLrQg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ad49c55ce1so800111e87.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:36:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrPr/hSOycDu5TKkxkDuBfGrdWZffrphiCnlZf65/hUzIuLMpm1ATNis6k64wNRRk5D6ihdplno8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8lVQMzzRScSVl2Z+MufTn03b+Yt9uju2B57P2qvUDV/MC+RU
	cAeEKjX/4+39XBky9agDqt8susnbhgDr0E6/QwPgt9rwzBlZPvOorjsNAu7ThDbFHganPHQ41jl
	VswLli7oBW34yakVdICLQAGrt5twx8VE=
X-Received: by 2002:a05:6512:3991:b0:5a8:6e64:e88b with SMTP id
 2adb3069b0e04-5ae9d54e5a5mr1085505e87.4.1782308167583; Wed, 24 Jun 2026
 06:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com> <20260618224527.1506419-4-jmattson@google.com>
 <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com> <a962064f-fcd5-4ad2-bc7d-4249ec8fa495@oss.qualcomm.com>
In-Reply-To: <a962064f-fcd5-4ad2-bc7d-4249ec8fa495@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jun 2026 15:35:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJ=gLpjX2ZGhH7v0QQKROkoOto6R6-pOk=76ADrNWySw@mail.gmail.com>
X-Gm-Features: AVVi8CfjQ-g9msinsRP9O--Y6SLuc4vBB4GUuh45U33IfEet7LQR0SrSKSxjjBY
Message-ID: <CAJZ5v0iJ=gLpjX2ZGhH7v0QQKROkoOto6R6-pOk=76ADrNWySw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in cpufreq_boost_down_prep()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jim Mattson <jmattson@google.com>, bp@alien8.de, 
	tglx@kernel.org, x86@kernel.org, viresh.kumar@linaro.org, yosry@kernel.org, 
	andrew.cooper3@citrix.com, ludloff@gmail.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 1:26=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 6/23/2026 8:47 PM, Rafael J. Wysocki wrote:
> > On Fri, Jun 19, 2026 at 12:45=E2=80=AFAM Jim Mattson <jmattson@google.c=
om> wrote:
> >>
> >> During driver exit or CPU hotplug, acpi_cpufreq_cpu_exit() calls
> >> cpufreq_boost_down_prep() to re-enable boost on the target CPU.  Howev=
er,
> >> cpufreq_boost_down_prep() ignores the target CPU parameter and calls
> >> boost_set_msr(1) locally. Since this runs in an unbound process contex=
t, it
> >> updates the local CPU's MSR while leaving the target CPU's boost state
> >> unchanged.
> >>
> >> On Intel platforms, the open-coded read-modify-write of
> >> MSR_IA32_MISC_ENABLE in boost_set_msr() is vulnerable to preemption an=
d
> >> thread migration if executed in process context.
> >>
> >> Fix both issues by routing the MSR update through
> >> smp_call_function_single() to execute boost_set_msr() synchronously on=
 the
> >> target CPU. This ensures the correct CPU is updated and that the RMW
> >> sequence on Intel executes safely in IPI context with interrupts disab=
led.
> >>
> >> Fixes: a3605c46e0c0 ("cpufreq: acpi-cpufreq: drop rdmsr_on_cpus() usag=
e")
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://sashiko.dev/#/patchset/20260612215729.1532175-1-jmatts=
on%40google.com
> >> Assisted-by: Gemini:gemini-3.5-pro
> >> Signed-off-by: Jim Mattson <jmattson@google.com>
> >> ---
> >>   drivers/cpufreq/acpi-cpufreq.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpu=
freq.c
> >> index 21639d9ac753..48d678812fd6 100644
> >> --- a/drivers/cpufreq/acpi-cpufreq.c
> >> +++ b/drivers/cpufreq/acpi-cpufreq.c
> >> @@ -528,10 +528,11 @@ static void free_acpi_perf_data(void)
> >>   static int cpufreq_boost_down_prep(unsigned int cpu)
> >>   {
> >>          /*
> >> -        * Clear the boost-disable bit on the CPU_DOWN path so that
> >> -        * this cpu cannot block the remaining ones from boosting.
> >> +        * Clear the boost-disable bit on the target CPU so that
> >> +        * it cannot block the remaining ones from boosting.
> >>           */
> >> -       return boost_set_msr(1);
> >> +       return smp_call_function_single(cpu, boost_set_msr_each,
> >> +                                       (void *)1L, 1);
> >
> > While I have not investigated the history of this code, I'm wondering
> > why cpufreq_boost_down_prep()  is a separate function and why it takes
> > the CPU number argument.
> >
> > The only caller of it is acpi_cpufreq_cpu_exit() which could just do
> >
> > set_boost(policy, 1);
> >
> > instead of calling it (and might check if boost was supported at all
> > for that matter).
>
>
> 1) It seems that set_boost(policy, 1) would be a no-op here, since
> policy->cpus appears to be empty by the time ->exit() is called.

All right, but this means that ->exit() is not quite suitable for this
type of cleanup.

> acpi-cpufreq only implements ->exit (no ->offline), and ->exit() is
> reached only when policy_is_inactive() (i.e. cpumask_empty
> (policy->cpus)) is true. set_boost() does on_each_cpu_mask(policy->cpus,
> ...), which on an empty mask runs nothing.

Arguably though, .offline() should take care of the boost cleanup for
the CPU going offline.  .exit() is too late because it can't clean up
CPUs that went offline before.

> 2) The patch's restore on only policy->cpu
> (smp_call_function_single(policy->cpu, ...) will not fully cover shared
> policies, and how much it covers seems to depend on the boost-disable
> bit's scope (but that seems to be already discussed in the cover letter
> and is probably a separate topic).
>
> Please feel free to correct me if I'm misunderstanding the scope of the
> boost-disable bit:
>
> On driver unload the policy CPUs are removed from policy->cpus but seem
> to stay hardware-online, so a stale disable bit on a non-last CPU might
> still matter (those CPUs are presumably still running and may want to
> boost). Abstractly:
>
> - if the bit is per-CPU independent: clearing policy->cpu seems to fix
> only that CPU, and the other still-online CPUs in the policy may stay
> disabled.

Yes.

> - if the bit is shared within a group (e.g. core/package), "disabled if
> any member set": clearing policy->cpu maybe only covers its own group,
> and other groups spanned by the policy could stay disabled.

Yes.

Thus it is better to clear it at offline time for the given CPU.
