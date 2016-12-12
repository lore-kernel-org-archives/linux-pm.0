From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / CPPC: Fix per-CPU pointers management
Date: Mon, 12 Dec 2016 02:00:36 +0100
Message-ID: <CAJZ5v0iZ31AyuE2fHYLrr=2JKFO==mkjh7G0VHy8bEQjxDfOPA@mail.gmail.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <20161209144551.jhnbfsxdxsk4ld6s@linutronix.de> <CAJZ5v0jUCHSM90yEoygAbKVY3ySaWQk-Cp6qkd+6ESH74J2_8A@mail.gmail.com>
 <296282606.tnoJCKgU2l@aspire.rjw.lan> <20161210185106.eyj356w3ffgibaqi@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161210185106.eyj356w3ffgibaqi@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 10, 2016 at 7:51 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2016-12-10 00:52:28 [+0100], Rafael J. Wysocki wrote:
>> Hi Thomas,
>>
>> The crash fixed by this is exposed by the ITMT (asymmetric packing) series
>> (which involves using ACPI CPPC on x86), so IMO it would be good to route it
>> through tip along with that series.
>
> can we get this merged into the original patch please?

Functionally, that patch has a little to do with the fix, so I'd
rather not do that.

> This is default y  and breaks bisecting.

Instead, I would reorder the series to put the fix in front of that patch.

Thanks,
Rafael
