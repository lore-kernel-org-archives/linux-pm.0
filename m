From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 13:21:01 -0400
Message-ID: <CAJvTdKnDUDXwmj_Yy=Z-ScugHX_2sHtijk7WESWc26rNqPzGpQ@mail.gmail.com>
References: <20160615100029.GB32588@pd.tnic> <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
 <20160615165618.GF32588@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615165618.GF32588@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 15, 2016 at 12:56 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Jun 15, 2016 at 12:41:21PM -0400, Len Brown wrote:
>> Recent hardware has an additional MSR field
>>
>> MSR_IA32_HWP_REQUEST.ENERGY_PERFORMANCE_PREFERENCE
>> that replaces
>>
>> MSR_IA32_ENERGY_PERF_BIAS
>> for the purpose of P-state control.
>>
>>
>> Both MSRs/fields exist and have effect at the same time.
>>
>> so the API
>> energy_policy_pref_hint
>>
>> will not work -- as it isn't clear which MSR it refers to.
>
> Surely we can make the new interface work too - perhaps add a new sysfs
> file for the new thing. The old MSR_IA32_ENERGY_PERF_BIAS would be
> needed on those older boxes.
>
> Or we can have a sysfs file which is called something like
> "perf_preference" or whatnot and that thing either maps input to the old
> MSR_IA32_ENERGY_PERF_BIAS or to the new thing.

Maybe I wasn't clear.
The API -- the name -- must be clear about what MSR it talks to.
I suggest that the name exactly match the name of the actual MSR,
because you are about to need a 2nd one with a name so close
that it will otherwise be ambiguous.

>> I've updated x86_energy_perf_policy to talk to this MSR
>> and a number of others for the benefit of HWP.  The
>> patch is over 1000 lines.  I'll post it shortly.
>
> So we should *not* give ourselves the example that using msr.ko for
> other things *besides* debugging is ok. It is very wrong to talk to
> naked MSRs and we have done it by now because this thing was there and
> well, sure, why not use it.
>
> But poking at MSRs is dangerous and we need proper abstraction. And we
> should work towards that instead perpetuating wrong use.

Again, I support your direction.  I'm not trying to work against it,
I'm trying to tell you that you are just scratching the surface
and there will be more steps to complete the task -- because
there are more MSRs.  Your new API doesn't exist on the
installed base, and so the old /dev/msr method must be available
to the installed base.  Sure, in the future, when the new API
is available, we can update the utility to use it going forward.

thanks,
Len Brown, Intel Open Source Technology Center
