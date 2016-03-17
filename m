From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: PSys support
Date: Thu, 17 Mar 2016 15:56:03 -0700
Message-ID: <1458255363.3861.40.camel@linux.intel.com>
References: <1458253409-13318-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160317225100.GA3805@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45811 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcCQW4I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 18:56:08 -0400
In-Reply-To: <20160317225100.GA3805@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Thu, 2016-03-17 at 23:51 +0100, Borislav Petkov wrote:
> On Thu, Mar 17, 2016 at 03:23:29PM -0700, Srinivas Pandruvada wrote:
> >=20
> > Skylake processor supports a new set of RAPL registers for
> > controlling
> > entire platform instead of just CPU package. This is useful for
> > thermal
> > and power control when source of power/thermal is not just CPU/GPU.
> > This change adds a new platform domain (AKA PSys) to the current
> > power capping Intel RAPL driver.
> > PSys also supports PL1 (long term) and PL2 (short term) control
> > like
> > package domain. This also follows same MSRs for energy and time
> > units as package domain.
> > Unlike package domain, PSys support requires more than just
> > processor
> > level implementation. The other parts in the system need additional
> > implementation, which OEMs needs to support. So not all Skylake
> > systems will support PSys.
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> > =C2=A0arch/x86/include/asm/msr-index.h |=C2=A0=C2=A03 ++
> > =C2=A0drivers/powercap/intel_rapl.c=C2=A0=C2=A0=C2=A0=C2=A0| 63
> > ++++++++++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 66 insertions(+)
> >=20
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index 2da46ac..bd383f5 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -190,6 +190,9 @@
> > =C2=A0#define MSR_PP1_ENERGY_STATUS		0x00000641
> > =C2=A0#define MSR_PP1_POLICY			0x00000642
> > =C2=A0
> > +#define MSR_PLATFORM_ENERGY_STATUS	0x0000064d
> > +#define MSR_PLATFORM_POWER_LIMIT	0x0000065c
> Please add those defines to intel_rapl.c as they're being used only
> there, apparently.
OK. I will move them.

Thanks,
Srinivas

>=20
> --=C2=A0
> Regards/Gruss,
> =C2=A0=C2=A0=C2=A0=C2=A0Boris.
>=20
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham No=
rton,
> HRB 21284 (AG N=C3=BCrnberg)
