Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C5279DCA;
	Tue,  2 Jun 2026 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365168; cv=none; b=JoqqP6sRDxvYz9aoXGulL3QfVYAZZzNbqvhJgv4b8zzg9n0kOr35x7FGv0/8OwGeM3ONSP4197a791By1FFzmthlAj5UrGLAMAj9avk2ZLIUQuSq4OvZ3lBxPGA6xqSGZbkjWJGliMt9DchmTGd39ZI/lUbE1bnimDkDCrNFjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365168; c=relaxed/simple;
	bh=AbAm/pIqtcsFljma7tItx2r/3qntGqzm/Mi6uO74WGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f28xiIOewxAIDoG4cNTV1rGNP/TdFXaiZbet57t+W63B3TZrGwKVNyZ2JEx0hXJu3DgGGcYk0WXTitCcBTnuJhoP+lyyHp9Gj0rBbLYJrMbKqFPc2VkGUb0TUxZgFLcHOpwfQycP4CcEYW+hjIJqUnsWR1IzKMWqu6QxZXENOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsI2b1o5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsI2b1o5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780365167; x=1811901167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AbAm/pIqtcsFljma7tItx2r/3qntGqzm/Mi6uO74WGY=;
  b=ZsI2b1o5dvX15akgTyS17/gw+rVQqA18RJD4f4oMNsTkie629MYNtO1W
   +TVvsobUVGbuyzZ2UdlACT1uAUsGlCoexNgEdjEulmqCVTEnzQa+EUG5D
   Kq8Zs7JLUJjLXIg84PVHSq3xZ2WukJMlB9Gz0n+QRHWuK4JuiK781Mzf+
   2yjVLW61L6uhk9Hmv7D8toNW8yREfTfpy3wNlmQE9Xuwg7Zb6Rf5clMLZ
   GMz71nXaS+5R0Gc5pjCgVujvM0dQeV86M74Xi1+uCFpIKFa8L4gmfy0M4
   jHq5Y7j0TcmN5zkxNCzbg2UFNHciUiCcn6exOOd6M1u2mo/Zce5QSUdhn
   Q==;
X-CSE-ConnectionGUID: Q5HOhfRUSta4V+Fyuv9Y9g==
X-CSE-MsgGUID: 54D4CsB2Q/KGyuX/MNTkjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91706655"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91706655"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 18:52:46 -0700
X-CSE-ConnectionGUID: bfuuTtEXRQS5ksNV1MMc5w==
X-CSE-MsgGUID: zFCdL4mySXqTmH5qdGI6uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="243574530"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 18:52:46 -0700
Date: Mon, 1 Jun 2026 19:01:58 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v2 0/5] thermal: intel: Add support for Directed Package
 Thermal Interrupt
Message-ID: <20260602020158.GA23099@ranerica-svr.sc.intel.com>
References: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
 <CAJZ5v0g3SncgrYri0Xo28MCKseOVSDGbx1L=mBAWATJYJRv7iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g3SncgrYri0Xo28MCKseOVSDGbx1L=mBAWATJYJRv7iw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jun 01, 2026 at 08:26:42PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 28, 2026 at 5:15 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Hi,
> >
> > This is v2 of this series. The main changes are a new patch fixing a pre-
> > existing bug and a redesigned error rollback strategy that disables
> > directed thermal interrupts across all packages when enabling fails in any
> > one of them. Please see the changelog for details.
> >
> > Package-level thermal interrupts are currently broadcast to all CPUs in a
> > package. Only one CPU is needed to service package-wide events.
> > Broadcasting creates unnecessary resource contention. Thermal interrupts
> > generated for Hardware Feedback Interface[1] updates are an example: all
> > CPUs in the package receive the interrupt and race for a lock to update a
> > shared data structure. Idle CPUs are needlessly woken up.
> >
> > Newer Intel processors allow directing package-level thermal interrupts
> > only to CPUs that explicitly request them. A CPU opts in by setting a
> > designated bit in IA32_THERM_INTERRUPT. Hardware acknowledges the request
> > by setting a designated bit in IA32_PACKAGE_THERM_STATUS.
> >
> > This series enables directed package-level thermal interrupts and
> > designates one handler CPU per package using the CPU hotplug
> > infrastructure. A new CPU is selected if the handler CPU goes offline.
> >
> > Because CPU0's hotplug callbacks are not invoked during suspend and resume,
> > syscore callbacks are added to restore the handler for the boot package.
> > The series also disables directed delivery during kexec reboot, avoiding
> > stale interrupt routing when rebooting into a kernel that does not support
> > the feature.
> >
> > This patchset introduces a change in behavior in the /sys/devices/system/
> > cpu/cpuN/thermal_throttle/package* sysfs files. These files reflect per-CPU
> > variables updated when a CPU handles a package-level thermal interrupt. In
> > broadcast mode, all CPUs update their variables. When directed package-
> > level thermal interrupts are enabled, only the handler CPU's variables are
> > updated.
> >
> > Lastly, nothing changes for processors that do not support this feature:
> > they fall back to broadcast delivery.
> >
> > [1] Intel Software Developer's Manual Vol. 3, Section 17.6, March 2026 https://www.intel.com/SDM
> >
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes in v2:
> > - Fixed an existing bug in the error-handling of thermal_throttle_online()
> >   CPU hotplug callback.
> > - Redesigned the rollback mechanism to handle all packages, not only
> >   the boot package.
> > - Fixed the handling of the return value of cpumask_any_but(), which on
> >   failure returns small_cpumask_bits, not nr_cpu_ids.
> > - Renamed the Directed Package Thermal Interrupt CPUID and MSR bits for
> >   consistency and brevity. (Boris)
> > - Added measurements of the latency of setup acknowledgment from hardware.
> > - Removed an unused argument from directed_thermal_pkg_intr_supported().
> > - Reused the global rollback mechanism in the syscore shutdown callback.
> > - Link to v1: https://lore.kernel.org/r/20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com
> >
> > ---
> > Ricardo Neri (5):
> >       thermal: intel: Fix dangling resources on thermal_throttle_online() failure
> >       x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt
> >       thermal: intel: Enable the Directed Package-level Thermal Interrupt
> >       thermal: intel: Add syscore callbacks for suspend and resume
> >       thermal: intel: Add a syscore shutdown callback for kexec reboot
> >
> >  arch/x86/include/asm/cpufeatures.h  |   2 +
> >  arch/x86/include/asm/msr-index.h    |   2 +
> >  drivers/thermal/intel/therm_throt.c | 272 +++++++++++++++++++++++++++++++++++-
> >  3 files changed, 272 insertions(+), 4 deletions(-)
> > ---
> 
> sashiko.dev has some feedback on patch 4 that appears to be valid to me:
> 
> https://sashiko.dev/#/patchset/20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36%40linux.intel.com
> 
> Can you have a look at it please?

Sure, Rafael. That feedback looks valid to me too. I made the necessary changes
in preparation for v3.
