From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] powercap: intel_rapl: PSys support
Date: Thu, 17 Mar 2016 23:51:00 +0100
Message-ID: <20160317225100.GA3805@pd.tnic>
References: <1458253409-13318-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57964 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934678AbcCQWvE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 18:51:04 -0400
Content-Disposition: inline
In-Reply-To: <1458253409-13318-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Thu, Mar 17, 2016 at 03:23:29PM -0700, Srinivas Pandruvada wrote:
> Skylake processor supports a new set of RAPL registers for controllin=
g
> entire platform instead of just CPU package. This is useful for therm=
al
> and power control when source of power/thermal is not just CPU/GPU.
> This change adds a new platform domain (AKA PSys) to the current
> power capping Intel RAPL driver.
> PSys also supports PL1 (long term) and PL2 (short term) control like
> package domain. This also follows same MSRs for energy and time
> units as package domain.
> Unlike package domain, PSys support requires more than just processor
> level implementation. The other parts in the system need additional
> implementation, which OEMs needs to support. So not all Skylake
> systems will support PSys.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
> ---
>  arch/x86/include/asm/msr-index.h |  3 ++
>  drivers/powercap/intel_rapl.c    | 63 ++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/=
msr-index.h
> index 2da46ac..bd383f5 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -190,6 +190,9 @@
>  #define MSR_PP1_ENERGY_STATUS		0x00000641
>  #define MSR_PP1_POLICY			0x00000642
> =20
> +#define MSR_PLATFORM_ENERGY_STATUS	0x0000064d
> +#define MSR_PLATFORM_POWER_LIMIT	0x0000065c

Please add those defines to intel_rapl.c as they're being used only
there, apparently.

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--=20
