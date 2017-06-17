From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/5] intel_pstate: remove intel_pstate.get()
Date: Fri, 16 Jun 2017 21:10:39 -0400
Message-ID: <CAJvTdKmmHSM8FJq=1d4vQAYg=orgHb7OFRLmZ7EH2yWM7mQcAg@mail.gmail.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
 <1968308.WZqDeDH7Bi@aspire.rjw.lan> <CAJvTdKm461G0HGmxZbQuk4Bp_N8tF94o8J-YAZKGBvjKvLeYDA@mail.gmail.com>
 <1963166.eOk3pBXQhq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1963166.eOk3pBXQhq@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

>> >> -             get_avg_frequency(cpu),
>> >> +             aperfmperf_khz_on_cpu(cpu->cpu),
>>
>> Note that I deleted the line above in an updated version of this patch
>> that I'm ready to send out.
>>
>> There were a couple of problems with it.
>> The first is that it was  ugly that tracing (which occurs only in the
>> SW governor case)
>> could shorten the measurement interval as seen by the sysfs interface.
>>
>> The second is that this trace point can be called with irqs off,
>> and smp_call_function_single() will WARN when called with irqs off.
>>
>> Srinivas Acked that I simply remove this field from the tracepoint --
>> as it is redundant to calculate it in the kernel when we are already
>> exporting the raw values of aperf and mperf.
>
> This changes the tracepoint format and I know about a couple of user space
> scripts that consume these tracepoints though.
> What would be wrong with leaving it as is?

I'm fine keeping get_avg_frequency() for the purpose of just this tracepoint
compatibility, if you think it is useful to do so.

I removed it because its only function was the (removed) intel_pstate.get()
and this tracepoint.  And this tracepoint already includes aperf and mperf,
which can be used to calculate frequency in user-space, if desired.
Srinivas Acked' that updating his user-space script would be fine --
dunno if that is sufficient.

cheers,
-Len
