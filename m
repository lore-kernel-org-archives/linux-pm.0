From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 18:56:18 +0200
Message-ID: <20160615165618.GF32588@pd.tnic>
References: <20160615100029.GB32588@pd.tnic>
 <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45989 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbcFOQ4W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 12:56:22 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Jun 15, 2016 at 12:41:21PM -0400, Len Brown wrote:
> Recent hardware has an additional MSR field
> 
> MSR_IA32_HWP_REQUEST.ENERGY_PERFORMANCE_PREFERENCE
> that replaces
> 
> MSR_IA32_ENERGY_PERF_BIAS
> for the purpose of P-state control.
>
> 
> Both MSRs/fields exist and have effect at the same time.
> 
> so the API
> energy_policy_pref_hint
> 
> will not work -- as it isn't clear which MSR it refers to.

Surely we can make the new interface work too - perhaps add a new sysfs
file for the new thing. The old MSR_IA32_ENERGY_PERF_BIAS would be
needed on those older boxes.

Or we can have a sysfs file which is called something like
"perf_preference" or whatnot and that thing either maps input to the old
MSR_IA32_ENERGY_PERF_BIAS or to the new thing.

> I've updated x86_energy_perf_policy to talk to this MSR
> and a number of others for the benefit of HWP.  The
> patch is over 1000 lines.  I'll post it shortly.

So we should *not* give ourselves the example that using msr.ko for
other things *besides* debugging is ok. It is very wrong to talk to
naked MSRs and we have done it by now because this thing was there and
well, sure, why not use it.

But poking at MSRs is dangerous and we need proper abstraction. And we
should work towards that instead perpetuating wrong use.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
