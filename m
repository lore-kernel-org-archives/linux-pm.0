From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 19:39:26 +0200
Message-ID: <20160615173926.GD30309@pd.tnic>
References: <20160615100029.GB32588@pd.tnic>
 <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
 <20160615165618.GF32588@pd.tnic>
 <CAJvTdKnDUDXwmj_Yy=Z-ScugHX_2sHtijk7WESWc26rNqPzGpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45090 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbcFORja (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 13:39:30 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKnDUDXwmj_Yy=Z-ScugHX_2sHtijk7WESWc26rNqPzGpQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Jun 15, 2016 at 01:21:01PM -0400, Len Brown wrote:
> The API -- the name -- must be clear about what MSR it talks to.

Didn't I say that?!

"Surely we can make the new interface work too - perhaps add a new sysfs
file for the new thing."

> I suggest that the name exactly match the name of the actual MSR,
> because you are about to need a 2nd one with a name so close
> that it will otherwise be ambiguous.

So from looking at IA32_HWP_REQUEST, it sounds like you'd need a whole
new dir:

hwp_req
|-> package_control
|-> energy_perf_pref
|-> ...
|-> min_perf

and both interfaces will be visible only when the CPUID bit is set.

I.e., for the energy_policy_pref_hint, I'm checking X86_FEATURE_EPB and
I'm sure the HWP ones have CPUID bits too.

> Again, I support your direction.  I'm not trying to work against it,
> I'm trying to tell you that you are just scratching the surface
> and there will be more steps to complete the task -- because
> there are more MSRs.

Oh, I know that. That's why this is a first RFC, to poke at people.

Also, I'm looking at the WRMSR use cases first. The reading can be taken
care of later.

> Your new API doesn't exist on the installed base, and so the old
> /dev/msr method must be available to the installed base. Sure, in the
> future, when the new API is available, we can update the utility to
> use it going forward.

Well, since the utility is part of tools/, it goes with the kernel
version. Just like perf.

Or are you dying to be able to use new tool on old kernels?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
