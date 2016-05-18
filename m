From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] powercap/rapl: Do not load in virtualized environments
Date: Wed, 18 May 2016 08:38:31 -0400
Message-ID: <573C6247.3000605@redhat.com>
References: <1463484845-9839-1-git-send-email-prarit@redhat.com> <CAJZ5v0g59CvQVePgCbEsXvw5UqOcqvn-Snh3=0Jcnj=mhT_mfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g59CvQVePgCbEsXvw5UqOcqvn-Snh3=0Jcnj=mhT_mfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 05/17/2016 08:50 PM, Rafael J. Wysocki wrote:
> On Tue, May 17, 2016 at 1:34 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>> intel_rapl is currently not supported in virtualized environments.  When
>> booting the warning message
>>
>> intel_rapl: no valid rapl domains found in package 0
> 
> You seem to be saying that this message is problematic for some
> reason, so why is it?
> 

I thought about my previous answer and after thinking about it realized I didn't
give you enough background Rafael.  Virtual environments won't use this feature
as this is meant for restricting power consumption at the HW level.

So ... here's the situation.  Most CPU features from Intel have a CPU feature
bit (also known in some circles as cpuflags) set for them.  For example MCE has
an mce bit that is exposed in /proc/cpuinfo.  Unfortunately, for Intel RAPL
there is no bit (I don't know if someone dropped the ball or if Intel
intentionally left this feature off ... I've heard both explanations :)).

In any case the Intel RAPL driver is one of the few cpu based drivers in the
kernel that still does a x86_match_cpu() against supported CPUs.  This means for
virtual cpus which export the host cpu's cpu model number, the intel_rapl driver
will attempt to load for each cpu.

As a result the message

intel_rapl: no valid rapl domains found in package 0

is output as a *visible* error to the user for each virtual core.

The error is valid for native cpus (although over 100s of systems I can say I've
never seen the warning output on a native cpu) but it is clearly not valid for
virtual cpus *because virtualized systems don't use this feature*.

The driver shouldn't load on virt systems.  That's the bottom line here, and the
patch prevents that from happening.  Would I prefer that there were some other
mechanism to detect RAPL?  Yep.  I really really would.  But beyond mucking with
MSRs (which is definitely more complicated and awful than this simple check) I
don't see any easier method than the one I've proposed.

I really don't want to be the one who sets the precedent of abusing x86_hyper in
this way.  I know it isn't the "right" thing to do -- but I honestly do not see
a better or cleaner way out of this.

P.


>> is output for every virtual core.
>>
>> This patch stops the driver from being loaded in virtual boots.
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: Jacob Jun Pan <jacob.jun.pan@intel.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> ---
>>  drivers/powercap/intel_rapl.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
>> index f2201d42a9cd..bebfbe8acccd 100644
>> --- a/drivers/powercap/intel_rapl.c
>> +++ b/drivers/powercap/intel_rapl.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/sysfs.h>
>>  #include <linux/cpu.h>
>>  #include <linux/powercap.h>
>> +#include <asm/hypervisor.h>
>>  #include <asm/iosf_mbi.h>
>>
>>  #include <asm/processor.h>
>> @@ -1600,6 +1601,10 @@ static int __init rapl_init(void)
>>                 return -ENODEV;
>>         }
>>
>> +       /* Intel RAPL is not supported on virtualized environments */
>> +       if (x86_hyper)
>> +               return -ENODEV;
>> +
>>         rapl_defaults = (struct rapl_defaults *)id->driver_data;
>>
>>         cpu_notifier_register_begin();
>> --
