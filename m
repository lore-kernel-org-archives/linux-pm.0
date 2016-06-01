From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] powercap/rapl: add support for denverton
Date: Wed, 1 Jun 2016 08:57:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606010857080.3629@nanos>
References: <1464727290-5400-1-git-send-email-jacob.jun.pan@linux.intel.com> <1464727290-5400-3-git-send-email-jacob.jun.pan@linux.intel.com> <574E0DF2.2010408@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35665 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281AbcFAG7W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 02:59:22 -0400
In-Reply-To: <574E0DF2.2010408@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>

On Tue, 31 May 2016, Dave Hansen wrote:
> On 05/31/2016 01:41 PM, Jacob Pan wrote:
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1137,6 +1137,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
> >  	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
> >  	RAPL_CPU(0x8E, rapl_defaults_core),/* Kabylake */
> >  	RAPL_CPU(0x9E, rapl_defaults_core),/* Kabylake */
> > +	RAPL_CPU(0x5F, rapl_defaults_core),/* Denverton micro server */
> >  	{}
> >  };
> 
> Not to derail this individual patch... but do we really want to continue
> open-coding CPU model/family combos all over arch/x86?
> 
> For instance, arch/x86/events/intel/core.c has:
> 
> >         case 142: /* 14nm Kabylake Mobile */
> >         case 158: /* 14nm Kabylake Desktop */
> >         case 78: /* 14nm Skylake Mobile */
> >         case 94: /* 14nm Skylake Desktop */
> >         case 85: /* 14nm Skylake Server */
> 
> Which duplicates the two Kabylake family numbers from the RAPL_CPU()
> context above (just in decimal instead of hex).
> 
> Should we just start sticking these things in a header like:
> 
> #define X86_INTEL_FAMILY_KABYLAKE1 	0x8E
> #define X86_INTEL_FAMILY_KABYLAKE2	0x9E
> #define X86_INTEL_FAMILY_DENVERTON 	0x5F
> 
> So we have this:
> 
> 	RAPL_CPU(X86_INTEL_FAMILY_DENVERTON, rapl_defaults_core),
> 
> instead of having to explain our magic number in a comment.

Yes please. 
