From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 8/8] cpufreq: intel_pstate: Use CPPC to get max performance
Date: Fri, 9 Dec 2016 16:02:24 +0100
Message-ID: <CAJZ5v0jUCHSM90yEoygAbKVY3ySaWQk-Cp6qkd+6ESH74J2_8A@mail.gmail.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <20161207190608.boi7svavwrkx3epm@breakpoint.cc> <1481152373.3064.77.camel@linux.intel.com>
 <4248602.ecJ9y5gJMR@aspire.rjw.lan> <20161209144551.jhnbfsxdxsk4ld6s@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209144551.jhnbfsxdxsk4ld6s@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 9, 2016 at 3:45 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2016-12-08 00:29:29 [+0100], Rafael J. Wysocki wrote:
>> Agreed, but the bug fixed by the first hunk is real too.  I'd fix it a bit
>> differently, though:
>>
>> Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Is there anything you want me to do here? The hunk in
> acpi_cppc_processor_exit() is unchanged and is the one that led to the
> crash. The other hunk I made (the one you changed) was something I
> noticed while looking at the code - nothing that hit me directly.

OK, thanks.

I'll add a changelog to the patch and resend it later today.

Thanks,
Rafael
