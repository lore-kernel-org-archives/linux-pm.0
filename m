From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: Enforce _PPC limits
Date: Wed, 25 May 2016 12:36:04 -0400
Message-ID: <cef22f9e-d60e-2065-e8a6-74c43e9b78f7@hpe.com>
References: <21572dff-ea5d-c0f3-6f48-66c9d38eda65@hpe.com>
 <1464127905.4603.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g2t4622.austin.hp.com ([15.73.212.79]:53879 "EHLO
	g2t4622.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbcEYQgH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 12:36:07 -0400
In-Reply-To: <1464127905.4603.11.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Srinivas,

On 5/24/2016 6:11 PM, Srinivas Pandruvada wrote:
> Hi Linda,
> 
> On Tue, 2016-05-24 at 16:37 -0400, Linda Knippers wrote:
>> Hi Srinivas,
>>
>> I have a couple of questions about this patch set.
>> http://comments.gmane.org/gmane.linux.power-management.general/75263
>>
>> Sorry I'm a bit late to the party but I've just booted 4.6 on my
>> system and noticed some things.
>>
>> My first question is about enabling the feature by default on
>> enterprise and performance servers.  Is there any way to disable it on these
>> servers?  I didn't see a way.  I'm always nervous when something starts looking
>> at a table that perhaps wasn't used before or introduces a new behavior
>> that might be unexpected.  Having a way out or not making it the default
>> for a while would be nice.

> If you were using acpi-cpufreq ever , this would have been active
> anyway.

In that case we're probably ok with the tables.

> This was requested by some server vendors to turn on by default as they
> want to be able to use node manager to control and don't want to have
> any kernel command line addition.

I can understand the desire to avoid more knobs.

> Don't you want to be able to use _PPC to control. If you don't use _PPC
> then this will not be effective.
> You can turn off from kernel command line processor.ignore_ppc=1

I guess I've lost track of what intel_pstate is doing these days.  When it
first came out, it totally disregarded ACPI information, which is why code
was added to not load the driver on some platforms that are doing their
own power management.  The rationale for not using ACPI was that ACPI
couldn't express all the information necessary to describe the hardware
capabilities.

Now it is using ACPI information for some things, but not all things?
Perhaps intel_pstate.txt could be updated to clarify that?  Depending
on what the future is for intel_pstate and ACPI, I'm wondering if that
vendor-specific code is no longer needed.

This might be a nit but I'm also confused about whether it's really
enforcing _PPC limits or _PSS.  Are you actually limiting based on
the _PPC value?

>>
>> My second question is about the 48 instances I got of this when I
>> booted my
>> 2 socket, 48-CPU box:
>>
>>> intel_pstate: _PPC limits will be enforced
>> I suppose in theory I could have limits for some CPUs and not others
>> but
>> even in that case, the message isn't helpful.  I think it should be
>> made
>> useful or go away, or at least only be printed once.
>>
> Agree, I will downgrade the message to pr_debug.

Thanks.

-- ljk
> 
> Thanks,
> Srinivas
>>  
>> Thanks,
>>
>> -- ljk
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
