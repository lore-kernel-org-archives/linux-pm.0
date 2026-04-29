Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092F382360;
	Wed, 29 Apr 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494134; cv=none; b=dd6YEvDPpeUrOd5M7iDLeC2jx7hElKd6tZwo1vIBu8hLiL8liABDIcgk+Sebee54h0Mf8D4ICRVg860pb5n5D8KxKn+OSMqCG1vfp80p84NHGSq8gbb1bh7FUyqLMDW0hu3kdaq8dpPpRifyR7jpVxbVQkcOKu9G8iUbABpdo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494134; c=relaxed/simple;
	bh=uujATwqZbHsf5CcifUR+pQoMSJPiKFY+7M1V6oHwMBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwrtk0VXv34SA0Q6iF6ePkPyCWBx992M60zyJNtCNWwsPtvQavTS0i85R2zVdkBs8XMxszq6nhxP/M/0xYjMk5CTrOPyKQlMW+JS731ZCcOPEewqI3blGtn0fW89c8vLJBzNH5RUxNpUzYPERIgaqct6ww548OiYtByJlujL+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1IQGrmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1IQGrmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D449AC19425;
	Wed, 29 Apr 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777494134;
	bh=uujATwqZbHsf5CcifUR+pQoMSJPiKFY+7M1V6oHwMBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1IQGrmJCfXFvKrkBxAoVC1cmG9/r24YpFVqSEXhUmxqB1j5U+9wTTsBZnKR4GosD
	 hABexQ8ZXYmPqS0dsaUb6LPkkPeN/9mlwiD9IZU2A2Oh100om21b1tnhoeHEyS2m+m
	 6ytixpZzUBqovVoOjS1dE1quByWxj1WH6CL8oDCAChB5yRFhDfBLIHbF6BCQOXu/Wh
	 uFP/K8nIESS/DyV6Cq5ydBA2TSdXViOxzc91pzPxGFKsLtiAw55kCmCz8PbjlmWbAY
	 i5Evwv2KglcOMai9q4wKQgErXIbOMRTeLlWvF0XbA57yrOtynWRFIA63/C0DYM0k9g
	 u7J1OIVOS2OQQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Subject:
 Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
Date: Wed, 29 Apr 2026 22:22:10 +0200
Message-ID: <6010375.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki>
 <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, April 29, 2026 8:24:02 PM CEST Rafael J. Wysocki wrote:
> On Tue, Apr 28, 2026 at 11:05=E2=80=AFPM Evgeny Sagatov
> <evgeny.sagatov@gmail.com> wrote:
> >
> > The PC also froze with this patch when I pressed the power button.
>=20
> Which means that the issue is not simply a matter of the lack of
> synchronization between different I/O space accesses, so most likely
> the problem lies deeper.
>=20
> Let me summarize what we've learned so far (and expand the CC list somewh=
at).
>=20
> For those who have not seen the previous discussion, it is at:
>=20
> https://lore.kernel.org/lkml/CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5Z=
Gq7Je6Q@mail.gmail.com/#r
>=20
> 1. The issue is basically that the platform locks up completely when
> the power button is pressed
>=20
> This is reproducible 100% of the time.
>=20
> The power button processing flow is that, if the power button event is
> enabled in the ACPI PM1_ENABLE register, pressing the button causes
> the corresponding status bit in the ACPI PM1_STATUS register to be
> set, which in turn causes an ACPI interrupt (SCI) to trigger (both
> PM1_STATUS and PM1_ENABLE registers are accessible through the I/O
> address space).
>=20
> The SCI processing involves reading both the power button status and
> enable bits and clearing the former if set (this needs to be done or
> an interrupt storm would start if the status bit was not cleared).
>=20
> We don't actually know which of the steps above specifically causes
> the platform to lock up, but that doesn't matter too much because all
> of them are necessary.
>=20
> Clearing the power button enable bit in PM1_ENABLE prevents the issue
> from occurring (but then the power button obviously doesn't work).
>=20
> 2. The issue only occurs if the schedutil cpufreq governor is used
>=20
> If either the "powersave" or "ondemand" governor is used instead, the
> issue doesn't appear.
>=20
> Also switching over to a different cpufreq governor (on all CPUs)
> before pressing the power button makes the issue go away.
>=20
> 3. The issue didn't occur at all before commit e37617c8e53a
> ("sched/fair: Fix frequency selection for non-invariant case")
>=20
> Reverting the merge that introduced commit e37617c8e53a into the
> mainline makes the issue go away.
>=20
> 4. The issue occurs regardless of how schedutil invokes the cpufreq
> driver ("fast switch" vs sugov_deferred_update())
>=20
> 5. The cpufreq driver in question is acpi-cpufreq and it uses a
> control register located in the I/O address space (the same control
> register is used for all CPUs)
>=20
> 6. If acpi-cpufreq is not allowed to write into the control register
> at all, the issue doesn't occur
>=20
> 7. Synchronizing all of the I/O space accesses in the ACPI-related
> code (via a spinlock), including acpi-cpufreq, doesn't prevent the
> issue from occurring
>=20
> So overall, it looks like the control register access pattern in
> acpi-cpufreq that results from schedutil's use of it after commit
> e37617c8e53a somehow puts the platform into a state in which a power
> button event causes it to lock up at the hardware level.
>=20
> While there are a couple of things more to check, I'm afraid that
> there may not be a viable way to address this issue other than
> replacing the schedutil governor with ondemand on this platform.

Below is one more patch to try.  It should cause acpi-cpufreq to use
one shared cpufreq policy instead of 4 per-CPU policies which is
more adequate because the CPUs share one control register.  It should
also cause acpi-cpufreq to update the control register only on CPU0.

Let's see if this changes the control register access pattern sufficiently
to work around the power button problem.

In any case, please send the output of

$ grep -r . /sys/devices/system/cpu/cpufreq/

from a kernel with this patch applied.

=2D--
 drivers/cpufreq/acpi-cpufreq.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

=2D-- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -743,7 +743,7 @@ static int acpi_cpufreq_cpu_init(struct
 	if (result)
 		goto err_free_mask;
=20
=2D	policy->shared_type =3D perf->shared_type;
+	policy->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
=20
 	/*
 	 * Will let policy->cpus know about dependency only when software
@@ -751,9 +751,9 @@ static int acpi_cpufreq_cpu_init(struct
 	 */
 	if (policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ALL ||
 	    policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) {
=2D		cpumask_copy(policy->cpus, perf->shared_cpu_map);
+		cpumask_copy(policy->cpus, cpu_present_mask);
 	}
=2D	cpumask_copy(data->freqdomain_cpus, perf->shared_cpu_map);
+	cpumask_copy(data->freqdomain_cpus, cpu_present_mask);
=20
 #ifdef CONFIG_SMP
 	dmi_check_system(sw_any_bug_dmi_table);
@@ -913,7 +913,9 @@ static int acpi_cpufreq_cpu_init(struct
 	data->resume =3D 1;
=20
 	policy->fast_switch_possible =3D !acpi_pstate_strict &&
=2D		!(policy_is_shared(policy) && policy->shared_type !=3D CPUFREQ_SHARED_=
TYPE_ANY);
+		(!policy_is_shared(policy) ||
+		 policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) &&
+		perf->control_register.space_id !=3D ACPI_ADR_SPACE_SYSTEM_IO;
=20
 	if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");



