From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v7] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Thu, 26 Nov 2015 15:34:04 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64028677FF5@shsmsx102.ccr.corp.intel.com>
References: <c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com>
 <20151126090940.GA30403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57724 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbbKZPeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 10:34:10 -0500
In-Reply-To: <20151126090940.GA30403@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, "luto@kernel.org" <luto@kernel.org>, "bp@suse.de" <bp@suse.de>, "linux@horizon.com" <linux@horizon.com>, "Kaszewski, Marcin" <marcin.kaszewski@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Ingo Molnar [mailto:mingo.kernel.org@gmail.com] On Behalf Of Ingo
> Molnar
> Sent: Thursday, November 26, 2015 5:10 PM
> To: Chen, Yu C
> Cc: mingo@redhat.com; tglx@linutronix.de; hpa@zytor.com;
> rjw@rjwysocki.net; pavel@ucw.cz; Brown, Len; luto@kernel.org;
> bp@suse.de; linux@horizon.com; Kaszewski, Marcin; linux-
> pm@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH][v7] x86, suspend: Save/restore extra MSR registers for
> suspend
> 
> 
> * Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > A bug was reported that on certain Broadwell platforms, after resuming
> > from S3, the CPU is running at an anomalously low speed.
> >
> > It turns out that the BIOS has modified the value of the THERM_CONTROL
> > register during S3, and changed it from 0 to 0x10, thus enabled clock
> > modulation(bit4), but with undefined CPU Duty Cycle(bit1:3) - which causes
> the problem.
> >
> > Here is a simple scenario to reproduce the issue:
> >
> >  1. Boot up the system
> >  2. Get MSR 0x19a, it should be 0
> >  3. Put the system into sleep, then wake it up  4. Get MSR 0x19a, it
> > shows 0x10, while it should be 0
> >
> > Although some BIOSen want to change the CPU Duty Cycle during S3, in
> > our case we don't want the BIOS to do any modification.
> >
> > Fix this issue by introducing a more generic x86 framework to
> > save/restore specified MSR registers(THERM_CONTROL in this case) for
> > suspend/resume. This allows us to fix similar bugs in a much simpler way in
> the future.
> >
> > When the kernel wants to protect certain MSRs during suspending, we
> > simply add a quirk entry in msr_save_dmi_table, and customize the MSR
> > registers inside the quirk callback, for example:
> >
> >   u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> >
> > and the quirk mechanism ensures that, once resumed from suspend, the
> > MSRs indicated by these IDs will be restored to their original, pre-suspend
> values.
> >
> > Since both 64-bit and 32-bit kernels are affected, this patch covers
> > the common 64/32-bit suspend/resume code path. And because the MSRs
> > specified by the user might not be available or readable in any
> > situation, we use rdmsrl_safe() to safely save these MSRs.
> >
> > Reported-and-tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v7:
> >  - Use the improved version of changelog, and
> >    modify the patch according to:
> >    https://patchwork.kernel.org/patch/7637861/
> > ---
> >  arch/x86/include/asm/msr.h        | 10 +++++
> >  arch/x86/include/asm/suspend_32.h |  1 +
> > arch/x86/include/asm/suspend_64.h |  1 +
> >  arch/x86/power/cpu.c              | 94
> +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 106 insertions(+)
> 
> Ok, this version looks mostly good - I've applied it with some other minor
> edits to field and variable naming. Please double check the end result that
> you'll see in the tip-bot notification email once I've pushed it out after some
> testing.
> 
OK, thanks!

Yu
