Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF53E1231
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338416; cv=none; b=mbvP7htH1wPLBH7M/dcYdB9tvQqvEQj8z7kpF0Y8hgm259TW+XSIc8+yv908025iGQFlBtboV3eHpGlyqq4qofnbFK3/DknsBSxoBtgTbIfqQ4uWx3Ctc5DCnlIsbL4dJPN/AIhUTaAX8vqAp7tTggQL4myQMhsnk58pFIjjOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338416; c=relaxed/simple;
	bh=RbU1kZHqjqFtfTsq+ic0zkG8gB1+osgpzJ2ahcO9/0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=groFEVmWA5zHAzhm8iNThNT6W05Qo2Ljf67/MHMy9r70Drjx+vNRaAveqo+Tnigkps81auxGJLDzV1A1vfxZL/h1pQseRCNKacB3YkKBqG70fMhRtKJQtXG/ZGk1BASOrsdit49BBmKjhPM6/ntiq2pdGmgByM6ai+BGwfRTOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEwr1DcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEwr1DcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D59A1F0089D
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780338415;
	bh=kh42sMWmTOO471jKcUUzqN/uJW2KiBLalBsKUVrgVM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bEwr1DcCBcRa5yUuf0bxcb14xNHvMHO2/pNUpPOW1kK/bTLlVEGOzNA2tQREIMLc5
	 OcBDPH5x+wIIvsz6N5e7GeYNLN1n6zyizQeyQ/OfIvkraZaGm0wiVCixGZafDp+OS2
	 /f7DlQfhdFVtKH9RG1KZFC/g96HfebHLhPH11DJWduhZkty1lQdCEE3x50Ee6GWos9
	 B4zLcvz46H3LmE9U/uY1ZHqAbK+mgRbkfZpOI48ztH1Oc8sehE8SYQACDwe2wQozIm
	 JO17AbZPLX8lx+sRLt3nzSARrFFfDoIUGH92vK6v03o2mSnmoknx0DMxbD/nnuZM5y
	 lXX9q04ljGmEw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3967738c801so18573901fa.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 11:26:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+aoDaUbcDFHR8QraIbTUAtIIihFffjiJvfXsQQr11McXajs0Vaoar8oDFnNWVPCz0oqOC+4XpY5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVmo3vtw9O1I1M8t7KhrZLzXeIijmeNPqH/UZ/Vv8afSNaEIv
	go0obrr07j8+f2jAAhJTnwdM+v0kP4P7Umoq9y2tJTmS24+KXs0u6yhTNKgp3IFbD1UgRijbBwq
	2dNMb5RxFK0M8cw+V7MPqlc+TPN4RgIA=
X-Received: by 2002:a05:6512:224c:b0:5aa:6ede:1a69 with SMTP id
 2adb3069b0e04-5aa6ede1b21mr1497253e87.17.1780338413755; Mon, 01 Jun 2026
 11:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
In-Reply-To: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 20:26:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3SncgrYri0Xo28MCKseOVSDGbx1L=mBAWATJYJRv7iw@mail.gmail.com>
X-Gm-Features: AVHnY4J6T7lVdYx8yPjGVC-h2YJx8ci9Ct92sNufXkZBaC1w-0MC1R4lL4XbpAI
Message-ID: <CAJZ5v0g3SncgrYri0Xo28MCKseOVSDGbx1L=mBAWATJYJRv7iw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] thermal: intel: Add support for Directed Package
 Thermal Interrupt
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:15=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> This is v2 of this series. The main changes are a new patch fixing a pre-
> existing bug and a redesigned error rollback strategy that disables
> directed thermal interrupts across all packages when enabling fails in an=
y
> one of them. Please see the changelog for details.
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
> Ricardo Neri (5):
>       thermal: intel: Fix dangling resources on thermal_throttle_online()=
 failure
>       x86/thermal: Add bit definitions for Intel Directed Package Thermal=
 Interrupt
>       thermal: intel: Enable the Directed Package-level Thermal Interrupt
>       thermal: intel: Add syscore callbacks for suspend and resume
>       thermal: intel: Add a syscore shutdown callback for kexec reboot
>
>  arch/x86/include/asm/cpufeatures.h  |   2 +
>  arch/x86/include/asm/msr-index.h    |   2 +
>  drivers/thermal/intel/therm_throt.c | 272 ++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 272 insertions(+), 4 deletions(-)
> ---

sashiko.dev has some feedback on patch 4 that appears to be valid to me:

https://sashiko.dev/#/patchset/20260528-rneri-directed-therm-intr-v2-0-8e2f=
9e0c1a36%40linux.intel.com

Can you have a look at it please?
