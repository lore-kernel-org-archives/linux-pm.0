From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Tue, 5 Apr 2016 05:53:47 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94846A1CD40@fmsmsx115.amr.corp.intel.com>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
 <20160404195535.GQ1778@windriver.com> <20160405031152.GA22836@linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C94846A1C854@fmsmsx115.amr.corp.intel.com>
 <20160405043017.GA24357@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47104 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbcDEFxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 01:53:49 -0400
In-Reply-To: <20160405043017.GA24357@linutronix.de>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rcochran@linutronix.de" <rcochran@linutronix.de>
Cc: "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



> -----Original Message-----
> From: rcochran@linutronix.de [mailto:rcochran@linutronix.de]
> Sent: Tuesday, April 05, 2016 12:30 AM
> To: Brown, Len
> Cc: Gortmaker, Paul (Wind River); linux-kernel@vger.kernel.org; Len Brown;
> linux-pm@vger.kernel.org
> Subject: Re: [PATCH] drivers/idle: make intel_idle.c driver more
> explicitly non-modular
> 
> On Tue, Apr 05, 2016 at 04:20:47AM +0000, Brown, Len wrote:
> > The first idle driver to register with cpuidle wins.
> >
> > intel_idle should always get the opportunity
> > to probe and register before acpi_idle (processor_idle.c)
> >
> > When intel_idle was allowed to be modular,
> > some distros build their kernel and loaded modules
> > such that acpi_idle could probe first.  In such
> > a kernel, intel_idle became dead code.
> >
> > As intel_idle is a small driver, the q	uick fix
> > was to make it Y/N so that it would always probe
> > before acpi_idle, no matter how acpi_idle
> > is build and loaded.
> >
> > Yes, even though intel_idle is a tiny driver, I think
> > it would be good to be able to unload it when it doesn't probe.
> 
> And that means fixing the race with acpi_idle, right?
> 
> > Today, it appears that acpi_idle (acpi/processor_idle.c)
> > is compiled Y/N.
> 
> So it, too, needs work?

"needs" is somewhat subjective.
Some may argue that this driver is so small,
that an effort to save memory might be more effectively
directed elsewhere.  But if the goal is to save the memory
consumed by this driver when the driver doesn't probe,
then yes, it would have to be made modular.

I don't remember what ACPI dependency made it non-modular.
ACPI has some tricky initialization ordering issues
that are BIOS dependent, and sometimes out of our control.

> > No, I do not believe that cpuidle should bother
> > supporting changing idle drivers at run-time.
> 
> Huh?  But you just said, "it would be good to be able to unload it
> when it doesn't probe."

being able to switch the registered driver at run-time
does not require the driver to be modular.

cheers,
-Len


