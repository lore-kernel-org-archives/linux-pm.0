Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33355408009
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679909; cv=none; b=BUSmG4Uzk9spZs7TBsKx5R88TF5lYirQEPJJsj/UJ0MiPtvEknjg9dyEab3X4TIny3A61mwRFqKEG+VHRKFopQwdrpsHEagz4DJUXiEBFyfrjlEUYiAeCbybVoiVcBiR5PR2Hgd9rF2fY+0cZRSHloNlcQGzP56z5yoWVbOU704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679909; c=relaxed/simple;
	bh=WOb+uX8gE+wYG8Dsh6sXom/leQkc2LizHwqTacE2JBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ1SQHkZC8lV/bgqxbqlacC11AWmtMdDctS/TOQ2E7KVLy+9H0nOYWKhifFyoW6qt+LBxax/3I7GAXJWEHQncV6oywrvviVMXjLUby4ZMSPREcKpBaCuh896FbdTk9+UBSmMLyK7ndSkmxt0aTqzBvUVi+S6LBg1f8tltJpITt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/DZEQ4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/DZEQ4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98981F00A3F
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783679907;
	bh=b1UWf3hc2p/e6E6J3PavjnKbVKNggOrUZMoz2TnIfaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l/DZEQ4/eM05lsuYhYHaPzGO8uwHlWIlejinwFn4jvb/dYkwevL1MNaepiK2n16Js
	 UwLqdZtw8BojGj6QGaTs1iM1olyt0UljdHBUypiQzJ75AKX1JYVN8D413aP4yGGOVs
	 qXaXqNGsJFkGPCZfhYXNS3XBOBn25E7EDJ1CmSo7yBi/WUdLHS86Fwpce7KFRVIgh5
	 qGp+wpUnU5dnqIduDvOgmTMFmoTAO6Axnxa6qzn/NAH3MnXDGpuQwZScWG++k5r0yR
	 /yD0fnSz72KLn/sr9EqGykp+dvjhwmxr9Oxeq+xr7s3L748tKuBDrbz82D0xuwm4lM
	 qKQA8Abx14tjg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso903396e87.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 03:38:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpxm5QC1dR4CzIFwmcW/su8EFt8x5W6BHM6xP+9SXF6dISSr0l80U+loN2ltb4JrhYgjiRBQzT7Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Z1cqk7I11YGMM4Tp6ooBemPWR4LnyRygZa1SvOCuRMGsvMcB
	gQeuhbsz1q0e+3duefMCzIBcX1EGu7hVI39eKZ/iRKZUPsfELF/0n/+1KYl0bfQuNSNDAfy+S3q
	+Bpj1x9+svaVx5QKB7gcBcjZwB20d5eM=
X-Received: by 2002:a05:6512:252b:b0:5b0:11e5:6bd5 with SMTP id
 2adb3069b0e04-5b011e56fcdmr3010392e87.40.1783679906244; Fri, 10 Jul 2026
 03:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
In-Reply-To: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 10 Jul 2026 12:38:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVTvi_nYfx0UEFLQbbJiiHHBuMyDFaxHy1EmbJsoo-4A@mail.gmail.com>
X-Gm-Features: AUfX_mw8eWBm_ayEt-v_tt2IFxeMHt_gt5MwucRLxHsA3nOhSlpky83O27WJfGQ
Message-ID: <CAJZ5v0iVTvi_nYfx0UEFLQbbJiiHHBuMyDFaxHy1EmbJsoo-4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] thermal: intel: Add support for Directed Package
 Thermal Interrupt
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 12:07=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> This is v3 of this series. The main change is the reworking of the
> rollback mechanism to fix a bug in which kfree() could be called with loc=
al
> interrupts disabled in PREEMPT_RT kernels. Please see the changelog for
> details.
>
> Package-level thermal interrupts are currently broadcast to all CPUs in a
> package. Only one CPU is needed to service package-wide events.
> Broadcasting creates unnecessary resource contention. Thermal interrupts
> generated for Hardware Feedback Interface[1] updates are an example: all
> CPUs in the package receive the interrupt and race for a lock to update a
> shared data structure. Idle CPUs are needlessly woken up.
>
> Newer Intel processors allow directing package-level thermal interrupts
> only to CPUs that explicitly request them. A CPU opts in by setting a
> designated bit in IA32_THERM_INTERRUPT. Hardware acknowledges the request
> by setting a designated bit in IA32_PACKAGE_THERM_STATUS.
>
> This series enables directed package-level thermal interrupts and
> designates one handler CPU per package using the CPU hotplug
> infrastructure. A new CPU is selected if the handler CPU goes offline.
>
> Because CPU0's hotplug callbacks are not invoked during suspend and resum=
e,
> syscore callbacks are added to restore the handler for the boot package.
> The series also disables directed delivery during kexec reboot, avoiding
> stale interrupt routing when rebooting into a kernel that does not suppor=
t
> the feature.
>
> This patchset introduces a change in behavior in the /sys/devices/system/
> cpu/cpuN/thermal_throttle/package* sysfs files. These files reflect per-C=
PU
> variables updated when a CPU handles a package-level thermal interrupt. I=
n
> broadcast mode, all CPUs update their variables. When directed package-
> level thermal interrupts are enabled, only the handler CPU's variables ar=
e
> updated.
>
> Lastly, nothing changes for processors that do not support this feature:
> they fall back to broadcast delivery.
>
> [1] Intel Software Developer's Manual Vol. 3, Section 17.6, March 2026 ht=
tps://www.intel.com/SDM
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes in v3:
> - Fixed a potential deadlock when calling kfree() with interrupts
>   disabled in PREEMPT_RT kernels. (Sashiko)
> - Introduced cleanup_directed_pkg_thermal_intr() to tear down DPTI
>   resources on error.
> - Split patch 4 into two since it had become too big.
> - Miscellaneous changes to inline comments.
> - Link to v2: https://lore.kernel.org/r/20260528-rneri-directed-therm-int=
r-v2-0-8e2f9e0c1a36@linux.intel.com
>
> Changes in v2:
> - Fixed an existing bug in the error-handling of thermal_throttle_online(=
)
>   CPU hotplug callback.
> - Redesigned the rollback mechanism to handle all packages, not only
>   the boot package.
> - Fixed the handling of the return value of cpumask_any_but(), which on
>   failure returns small_cpumask_bits, not nr_cpu_ids.
> - Renamed the Directed Package Thermal Interrupt CPUID and MSR bits for
>   consistency and brevity. (Boris)
> - Added measurements of the latency of setup acknowledgment from hardware=
.
> - Removed an unused argument from directed_thermal_pkg_intr_supported().
> - Reused the global rollback mechanism in the syscore shutdown callback.
> - Link to v1: https://lore.kernel.org/r/20260309-rneri-directed-therm-int=
r-v1-0-2956e3000950@linux.intel.com
>
> ---
> Ricardo Neri (6):
>       thermal: intel: Fix dangling resources on thermal_throttle_online()=
 failure

This one is there already in 7.2-rc.

>       x86/thermal: Add bit definitions for Intel Directed Package Thermal=
 Interrupt
>       thermal: intel: Add resources to handle directed package-level ther=
mal interrupts
>       thermal: intel: Enable the Directed Package-level Thermal Interrupt
>       thermal: intel: Add syscore callbacks for suspend and resume
>       thermal: intel: Add a syscore shutdown callback for kexec reboot
>
>  arch/x86/include/asm/cpufeatures.h  |   2 +
>  arch/x86/include/asm/msr-index.h    |   2 +
>  drivers/thermal/intel/therm_throt.c | 284 ++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 284 insertions(+), 4 deletions(-)
> ---

Assumed no objections from the x86 folks and applied patches [2-6] as
7.3 material, thanks!
