From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/2] powercap/rapl: add support for denverton
Date: Wed, 1 Jun 2016 08:08:13 -0700
Message-ID: <20160601080813.3beecc54@icelake>
References: <1464727290-5400-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1464727290-5400-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<574E0DF2.2010408@intel.com>
	<alpine.DEB.2.11.1606010857080.3629@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58589 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbcFAPKq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 11:10:46 -0400
In-Reply-To: <alpine.DEB.2.11.1606010857080.3629@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, jacob.jun.pan@linux.intel.com

On Wed, 1 Jun 2016 08:57:27 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 31 May 2016, Dave Hansen wrote:
> > On 05/31/2016 01:41 PM, Jacob Pan wrote:
> > > --- a/drivers/powercap/intel_rapl.c
> > > +++ b/drivers/powercap/intel_rapl.c
> > > @@ -1137,6 +1137,7 @@ static const struct x86_cpu_id rapl_ids[]
> > > __initconst = { RAPL_CPU(0x57, rapl_defaults_hsw_server),/*
> > > Knights Landing */ RAPL_CPU(0x8E, rapl_defaults_core),/* Kabylake
> > > */ RAPL_CPU(0x9E, rapl_defaults_core),/* Kabylake */
> > > +	RAPL_CPU(0x5F, rapl_defaults_core),/* Denverton micro
> > > server */ {}
> > >  };
> > 
> > Not to derail this individual patch... but do we really want to
> > continue open-coding CPU model/family combos all over arch/x86?
> > 
> > For instance, arch/x86/events/intel/core.c has:
> > 
> > >         case 142: /* 14nm Kabylake Mobile */
> > >         case 158: /* 14nm Kabylake Desktop */
> > >         case 78: /* 14nm Skylake Mobile */
> > >         case 94: /* 14nm Skylake Desktop */
> > >         case 85: /* 14nm Skylake Server */
> > 
> > Which duplicates the two Kabylake family numbers from the RAPL_CPU()
> > context above (just in decimal instead of hex).
> > 
> > Should we just start sticking these things in a header like:
> > 
> > #define X86_INTEL_FAMILY_KABYLAKE1 	0x8E
> > #define X86_INTEL_FAMILY_KABYLAKE2	0x9E
> > #define X86_INTEL_FAMILY_DENVERTON 	0x5F
> > 
> > So we have this:
> > 
> > 	RAPL_CPU(X86_INTEL_FAMILY_DENVERTON, rapl_defaults_core),
> > 
> > instead of having to explain our magic number in a comment.
> 
> Yes please. 
This open coding also applies to other x86 vendors. I can make change
for Intel since in some case, there is not even a comment about
what the model is. e.g.
in amd_nb.h
   (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))

Should the model numbers be in
arch/x86/include/asm/processor.h?
