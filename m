From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 12:41:21 -0400
Message-ID: <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
References: <20160615100029.GB32588@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36694 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbcFOQlX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 12:41:23 -0400
In-Reply-To: <20160615100029.GB32588@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Jun 15, 2016 at 6:00 AM, Borislav Petkov <bp@alien8.de> wrote:
> Hi people,
>
> so we've been talking about this for a long time now - how loading
> msr.ko is not a good thing and how userspace shouldn't poke at random
> MSRs.
>
> So my intention is to move away users in tools/ which did write to MSRs
> through the char dev and replace it with proper sysfs et al interfaces.
> Once that's done, we can start tainting the kernel when writing to MSRs
> from that device or even forbid it completely at some point.
>
> We'll see.
>
> Anyway, here's a first attempt, please scream if something's not right.
> Functionality-wise, it should be equivalent as I'm exporting the
> pref_hint of the IA32_ENERGY_PERF_BIAS in sysfs and it lands under
>
> /sys/devices/system/cpu/cpu?/energy_policy_pref_hint
>
> where anything with sufficient perms can read/write it.

turbostat reads MSRs, but never writes.  And it will still
need /dev/msr for all kinds of counters it reads.  So updating
turbostat to use this new attribute for EPB reads is sort of
a demo, rather than a functional change.

I agree the kernel should be tainted if user-space uses
/dev/msr to scribble on MSRs behind the kernel's back.

When EPB was first invented, I proposed a sysfs attribute to
control it.  But that proposal was system-wide, and affected
more than EPB.  Maybe that was too ambitious.  The
energy_perf_policy utility was a "plan-b".

Recent hardware has an additional MSR field

MSR_IA32_HWP_REQUEST.ENERGY_PERFORMANCE_PREFERENCE
that replaces

MSR_IA32_ENERGY_PERF_BIAS
for the purpose of P-state control.

Both MSRs/fields exist and have effect at the same time.

so the API
energy_policy_pref_hint

will not work -- as it isn't clear which MSR it refers to.

I've updated x86_energy_perf_policy to talk to this MSR
and a number of others for the benefit of HWP.  The
patch is over 1000 lines.  I'll post it shortly.

thanks,
Len Brown, Intel Open Source Technology Center
