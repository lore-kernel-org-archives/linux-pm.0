From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 1/4][RFC v2] PM / sleep: Avoid accessing frozen_cpus if
 it is NULL
Date: Sun, 26 Jun 2016 04:25:29 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402877B82A@shsmsx102.ccr.corp.intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <f9847b8bd15ad5056255150c71df37f2f74bc080.1466844557.git.yu.c.chen@intel.com>
 <20160625165113.GA4362@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16792 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbcFZEZe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jun 2016 00:25:34 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> -----Original Message-----
> From: Chen, Yu C
> Sent: Sunday, June 26, 2016 9:17 AM
> To: 'Pavel Machek'
> Cc: linux-pm@vger.kernel.org; x86@kernel.org; Rafael J. Wysocki; Len Brown;
> Peter Zijlstra; H. Peter Anvin; Borislav Petkov; Brian Gerst; Thomas Gleixner;
> Ingo Molnar; Varun Koyyalagunta; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 1/4][RFC v2] PM / sleep: Avoid accessing frozen_cpus if it
> is NULL
> 
> Hi,
> 
> > -----Original Message-----
> > From: Pavel Machek [mailto:pavel@ucw.cz]
> > Sent: Sunday, June 26, 2016 12:51 AM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; x86@kernel.org; Rafael J. Wysocki; Len
> > Brown; Peter Zijlstra; H. Peter Anvin; Borislav Petkov; Brian Gerst;
> > Thomas Gleixner; Ingo Molnar; Varun Koyyalagunta;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/4][RFC v2] PM / sleep: Avoid accessing
> > frozen_cpus if it is NULL
> >
[cut]
> >
> > I'd say that whoever allocates frozen_cpus should just abort the
> > hibernation if there's not enough memory for the operation...? This
> > seems like checking for the problem too late.
> >
> The allocation of frozen_cpus is alloc_frozen_cpus, which is in core_initcall, and
> do_initcall during boot up  seems not to care about the return value from these
> functions.  So I think either we add the check in disable_nonboot_cpus, or we
> can set noresume = 1 and nohibernate = 1 if alloc_frozen_cpus fails.
> 
Besides, disable_nonboot_cpus is not only used for hibernation, but also for
suspend to ram, kexec, etc, so it might be better to check before we use
it, thus to avoid introducing new flags IMO.

thanks,
Yu
