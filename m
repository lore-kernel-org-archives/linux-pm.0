From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 15:29:36 +0530
Message-ID: <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	<20140327093050.GA27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40679 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0J7g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 05:59:36 -0400
Received: by mail-oa0-f49.google.com with SMTP id h16so4057558oag.22
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 02:59:36 -0700 (PDT)
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 27 March 2014 15:00, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> As of now, I prefer this patch be based on code that is in the -next
> tree. I'll get rid of the per-core locking once the serialization
> patch of the core is accepted.

Okay.. Then divide this patch into two parts, second one doing all
the serialization stuff and I will review only the first one from V5 :)

Maybe mention that in Patch2 as well, that once serialization patches
are accepted, its not required.

>> don't know how Rafael want this, but probably this part could have gone
>> through ppc tree..
>
> That would mean multiple patches :-)

I wasn't opposed to multiple patches at all, but multiple patches for
basic functionality of same driver file. Otherwise separating things
into patches is the best receipe.

>> > +#define pr_fmt(fmt)    "powernv-cpufreq: " fmt
>> > +
>> > +#include <linux/module.h>
>> > +#include <linux/cpufreq.h>
>> > +#include <linux/smp.h>
>> > +#include <linux/of.h>
>> > +#include <asm/cputhreads.h>
>>
>> I thought I gave a comment on missing headers here?
>
> Ok, so these seem to be the missing ones.
>
> #include <linux/kernel.h>
> #include <linux/percpu-defs.h>
> #include <linux/mutex.h>

This may shift to Patch 2 ..

> #include <linux/sysfs.h>
> #include <linux/cpumask.h>
>
> #include <asm/reg.h>
>
> Have I missed anything else ?

Not sure :) .. I will see if I can find anymore..

>> > +static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>> > +static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
>>
>> I though we don't need this anymore? Either Rafael will take my patch as
>> is for the BOOST fixup or we will end up creating .isboost field in
>> struct cpufreq_frequency_table and so you could have used .driver_data here.
>>
>
> I mentioned in my reply to your BOOST fixup patch that we would like
> pstate_ids to be of the type "signed int", while the .driver_data is
> an "unsigned int". If we end up using .driver_data, we would have to
> be careful and not use it directly but reassign it to a signed int (or
> typecast it) before using it.

Probably many people would want it to be unsigned it, so that they
can put some strange hex values there..

Which part of your code conflicts with this right now? I can see only
this line in powernv_set_freq()

freq_data.pstate_id = powernv_pstate_ids[new_index];

And I don't think we will have side effects here.

> Not just that, the pr_debugs in the core which are printed during
> frequency transitions will then end up printing large positive values
> (since it will interpret negative pstate_ids as unsigned int) in the
> place of pstate_ids, which would not be particularly useful.

I have checked it again, those prints shouldn't have used that field.
Will fix them.

And so you can use that field in your code and I will get core fixed
for you..

>> Why do you need to get these from DT? And not find that yourself here instead?
>
> Well, I think we can obtain a more accurate value from the DT which
> would have already computed it. But I'll let vaidy answer this.

Can we simply refer to frequency values here for finding min and max
pstates? If yes, then probably this is the better place as there can be
human errors in DT.. Also those binding are just not required then.
And obviously less headache for you as well when you are changing
pstate tables.

>> > +       freq_data = (struct powernv_smp_call_data *)arg;
>>
>> don't need casting here ?
>
> Doesn't harm having it there. Just like the #includes :-)

Do you ever have these typecasts while you do kmalloc? It also
returns void *.. That's the same..

CodingStyle: Chapter 14: Allocating memory:

Casting the return value which is a void pointer is redundant. The conversion
from void pointer to any other pointer type is guaranteed by the C programming
language.

>> > +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d kHz \n",
>> > +               smp_processor_id(), pmspr_val, freq_data->pstate_id,
>>
>> s/smp_processor_id/raw_smp_processor_id ?
>
> No. This function is called via smp_call_function(). So we have
> preempt_disable on and it is safe to use smp_processor_id.

My question wasn't about being safe, but avoiding the complexity
of debug_smp_processor_id(). raw_smp_processor_id() can execute
very quickly.

> You mean s/clock/core ?

Oops!! yes.

> Thanks for a detailed review again.

Its my job :)

> I'll send out the updated patch today incorporating the comments. It
> shouldn't be hard since most of the comments do not affect the
> functionality.

Probably they do now ? :)
