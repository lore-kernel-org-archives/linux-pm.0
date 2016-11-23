From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch 0/5] powercap/intel_rapl: Fixes, hotplug conversion and simplifcation
Date: Wed, 23 Nov 2016 22:12:00 +0100
Message-ID: <CAJZ5v0hCtb42GOaLOA2CPBQjGAaTDxH6qTMrRQSYCOVjQGyVMQ@mail.gmail.com>
References: <20161122210518.079483154@linutronix.de> <20161123110647.37485542@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123110647.37485542@icelake>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@sisk.pl>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 23, 2016 at 8:06 PM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> On Tue, 22 Nov 2016 21:15:56 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> The driver fails to:
>>
>>  - initialize packages which are not available at driver init time,
>> though the value of that initialization is completely unclear as
>> nothing ever uses these values. I fixed it up nevertheless and leave
>> it to the maintainers to decide whether it should completely go away.
>>
>>  - to propagate error codes in the hotplug online path, where a
>>    registration fails and the package data is freed, but return code
>> is 0.
>>
>> The initialization/removal code of that driver is a maze of
>> duplicated code which is more or less the same as the cpu hotplug
>> code. After switching over the driver to the hotplug statemachine,
>> the whole init/removal machinery can be replaced by
>> installing/removing the hotplug state.
>>
>> The total damage is:
>>
>>  intel_rapl.c |  363
>> ++++++++++++++++------------------------------------------- 1 file
>> changed, 104 insertions(+), 259 deletions(-)
>>
>> and the binary size shrinks as well:
>>
>>    text          data     bss     dec     hex
>>    7996           625      32    8653
>> 21cd    Before 7216       593      32
>> 7841     1ea1   After
>>
> I have successfully tested this patchset with various cpu online/offline
> scenarios on both single and dual socket systems.
>
> Looks good to me. The cpu topology management is much more streamlined.
> Thanks. I also sent out this patch below on top of yours.
>
> [PATCH] powercap/intel_rapl: fix and tidy up error handling

OK

Thomas, I'm assuming that this series will go in via tip.  Please let
me know if you want me to take it instead.

Thanks,
Rafael
