From: rcochran@linutronix.de
Subject: Re: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Tue, 5 Apr 2016 06:30:17 +0200
Message-ID: <20160405043017.GA24357@linutronix.de>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
 <20160404195535.GQ1778@windriver.com>
 <20160405031152.GA22836@linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C94846A1C854@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36321 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcDEEaY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 00:30:24 -0400
Content-Disposition: inline
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94846A1C854@fmsmsx115.amr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Apr 05, 2016 at 04:20:47AM +0000, Brown, Len wrote:
> The first idle driver to register with cpuidle wins.
> 
> intel_idle should always get the opportunity
> to probe and register before acpi_idle (processor_idle.c)
> 
> When intel_idle was allowed to be modular,
> some distros build their kernel and loaded modules
> such that acpi_idle could probe first.  In such
> a kernel, intel_idle became dead code.
> 
> As intel_idle is a small driver, the q	uick fix
> was to make it Y/N so that it would always probe
> before acpi_idle, no matter how acpi_idle
> is build and loaded.
> 
> Yes, even though intel_idle is a tiny driver, I think
> it would be good to be able to unload it when it doesn't probe.

And that means fixing the race with acpi_idle, right?
 
> Today, it appears that acpi_idle (acpi/processor_idle.c)
> is compiled Y/N.

So it, too, needs work?

> No, I do not believe that cpuidle should bother
> supporting changing idle drivers at run-time.

Huh?  But you just said, "it would be good to be able to unload it
when it doesn't probe."

Thanks,
Richard
