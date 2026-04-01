Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175A44B696
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052337; cv=none; b=P1neyREMskmw3KRBxVp0a+k2GA8dBo+fZ4ewglowCHAhYpH/TR6wrDBcmlrm8tSiBvN6uhjvFEwir2xyqq7GrppHf/Fja7QcN2OkKK3AD3o7FFjJfB+JyvNmgyWQMh0cc6EYIx+lV6TK5iH42mP0kjYW91OLnTPiAs7zQ7zHfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052337; c=relaxed/simple;
	bh=nqAGqrxP8VX9uPtqPxhafTyUEPWCaXcYArOOfrwATwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv9bZO5WS5ZKt6MU6pLrKQQ2wm7Gym/uRBCAJMc5Rf3IYzjAO+9GLa7uIUoHCsdvHbodY9qsz7olWNnGKmcDUB8/QEQhuMhFiOnRBujTk392bKvCUWsprCbZP5lACQ2VoE8ATbodmLzB9EOsreqTVpm1aSb+oH/wKJSVhQp/HoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKC19+09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKC19+09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29297C19421
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775052337;
	bh=nqAGqrxP8VX9uPtqPxhafTyUEPWCaXcYArOOfrwATwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lKC19+09emhz49mwfnmsycC6x6xyHwf3S4A1WJCdJFPKcD2+U1NIAiZTmSZDKrw9s
	 dDlHgvaBgUCh8LG9B5/owmJPGVRJIdCIcud+B22U0PQ2jB7ft+NEWLbFn9FEs8/Bkf
	 tAwCYxL4sEH4z9BKLwMMYRXEyk79y7rAccEHjaT7qBWil2EDOi1Dud7KYES8nokjRC
	 1swdpKHGZljmy62mDFHqdjtI4suzEtIfCCqZLUE90jHLA4Ch/VrW/MFswt1aP7lW/C
	 xB+YGBdy5vW7bAZncVmf6QDr8i83qCq2LzjiigAtREWWa1RhLss0yCOC8EK6XEuDZm
	 oho7vSR2Ud7kQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d77b179b52so6402148a34.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 07:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlXmlww11soaGBqZNpEek0a52tqFLI8cKzfB7hNf8FTdA6RdvP9zR3JGT3iOEntZnSseCSXA1Xpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJhAYZU3p0yIPAwhCaX+3h2veVv/FcFojHuOUZ9HspZTujpYn
	ufHPlNqnQhE1+qkeYftjGbbHh0dLHjcATkBWA+ibBhJ9vxPsIcT4PRr8zek5V36U4TsjfYTqxgs
	O9n+NCbvr5CzmE5f6B3gi81vUtO9Hc+w=
X-Received: by 2002:a05:6870:708a:b0:315:b768:bd1d with SMTP id
 586e51a60fabf-422cfbd7f63mr2230090fac.6.1775052336226; Wed, 01 Apr 2026
 07:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 16:05:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hw9aZY3c0p23S-wxnUsW4CtyN6ACEzzxf=7etDUi2KbA@mail.gmail.com>
X-Gm-Features: AQROBzCy1VZUeRXCA6Pwa48kUitgrGcBoZUHUuFleTCJhQUKY7Yj_7AdU7TxOCs
Message-ID: <CAJZ5v0hw9aZY3c0p23S-wxnUsW4CtyN6ACEzzxf=7etDUi2KbA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] RAPL fixes (for linux-next)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:20=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Rafael,
>
> This series consolidates and rebases patches from three previously
> submitted cleanup series that were dropped from your linux-next due
> to a circular locking dependency issue:
>
>   https://lore.kernel.org/linux-pm/202603300921.b5dc709c-lkp@intel.com/
>
> The three series are:
>
>   Move RAPL defaults to interface drivers:
>   https://lore.kernel.org/linux-pm/20260212233044.329790-1-sathyanarayana=
n.kuppuswamy@linux.intel.com/
>
>   Move RAPL primitives to interface drivers:
>   https://lore.kernel.org/linux-pm/20260313185333.2370733-1-sathyanarayan=
an.kuppuswamy@linux.intel.com/
>
>   Consolidate CPU list in RAPL MSR drivers:
>   https://lore.kernel.org/linux-pm/20260313190052.2370963-1-sathyanarayan=
an.kuppuswamy@linux.intel.com/
>
> The circular locking dependency was introduced by a patch in the first
> series that registered and unregistered the PM notifier dynamically
> from rapl_add_package_cpuslocked() and rapl_remove_package_cpuslocked(),
> which are called from CPU hotplug callbacks leading to circular
> dependency between PM notifier lock and hotplug locks.
>
> That patch has been dropped in this series. The PM notifier
> registration is kept in rapl_init()/rapl_exit() as it was originally,
> and the remaining dependent patches are rebased on top of this.
>
> This series is based on top of:
>   https://github.com/rafaeljw/linux-pm/tree/pm-powercap
>
> Kuppuswamy Sathyanarayanan (7):
>   powercap: intel_rapl: Move MSR default settings into MSR interface
>     driver
>   powercap: intel_rapl: Remove unused macro definitions
>   powercap: intel_rapl: Move primitive info to header for interface
>     drivers
>   powercap: intel_rapl: Move TPMI primitives to TPMI driver
>   thermal: intel: int340x: processor: Move MMIO primitives to MMIO
>     driver
>   powercap: intel_rapl: Move MSR primitives to MSR driver
>   powercap: intel_rapl: Consolidate PL4 and PMU support flags into
>     rapl_defaults
>
>  drivers/powercap/intel_rapl_common.c          | 421 +-----------------
>  drivers/powercap/intel_rapl_msr.c             | 392 ++++++++++++++--
>  drivers/powercap/intel_rapl_tpmi.c            |  53 +++
>  .../int340x_thermal/processor_thermal_rapl.c  |  72 +++
>  include/linux/intel_rapl.h                    |  34 +-
>  5 files changed, 522 insertions(+), 450 deletions(-)
>
> --

Applied, thanks!
