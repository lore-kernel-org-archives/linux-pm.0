From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: cpupower reports uninitialized values for offline cpus
Date: Wed, 30 Sep 2015 14:25:47 -0400
Message-ID: <560C292B.5030905@redhat.com>
References: <560ADF55.6090901@redhat.com> <560AF3CB.1090401@redhat.com> <2397035.37ChXSYNtU@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932190AbbI3SZt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 14:25:49 -0400
In-Reply-To: <2397035.37ChXSYNtU@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jacob Tanenbaum <jtanenba@redhat.com>, linux-pm@vger.kernel.org



On 09/30/2015 12:23 PM, Thomas Renninger wrote:
> On Tuesday, September 29, 2015 04:25:47 PM Prarit Bhargava wrote:
>> On 09/29/2015 02:58 PM, Jacob Tanenbaum wrote:
>>> Hi guys,
>>>
>>> I have found a bug in the cpupower tool. In the most recent pull of
>>> linus's tree cpupower reports bogus information for offlined cpus.
> ...
>> Thomas,
>>
>> I'm not sure I see any benefit in reporting the offline cpu status here.
> There have been discussions to use CPU offlining as a power saving mechanism.

Yeah, I think in the past that this suggestion had been made but ISTR some
question as to exactly how much power would be saved in a "soft-remove" scenario
for a core & socket, and if there is any real benefit.

> This is afaik no real option on x86, at least not too frequent, but it could
> be on other archs?
> So the info would be nice to have...
> 
>> We
>> could I suppose output a message at the beginning of the output to indicate
>> that some cpus have been hotplugged, but I'm not sure that is even
>> necessary.
> Yep, just that people do not complain that cores are missing...
> May make sense.

Ok -- let's go with that for now, post, and see if anyone complains loudly about
that "loss" of info.  Jake, are you comfortable with that?

>>
>>>   3. Change the sysfs to retain topology data for offlined cpus, may
>>>   require
> 
> I had a quick look. I think this could be done.
> /sys/devices/system/cpu/cpu*/cpuidle
> also is kept, not sure why, because I cannot see any advantage to access
> this info on an offlined CPU.
> 

I think I see the problem.  When the intel_idle driver is loaded it registers a
cpu hotplug notifier, cpu_hotplug_notify(), which registers (and creates the
sysfs cpuidle dir) as each cpu is created.  This is done via a call to
intel_idle_cpu_init(), which calls cpuidle_register_device().

The reverse isn't true, however, and AFAICT, _all_ the cpuidle directories are
only destroyed when the driver is unloaded in intel_idle_exit().

I think that's a bug too FWIW, and I agree -- there isn't any point in having
that data lying around.

> But reading the topology of offlined CPUs makes sense.
> Argh, but yes. For real on-/offlining this is hard...

Yeah, we'd have to add an additional state to the CPU hotplug callback state
machine (CPU_ADD_PHYSICAL?) to identify when a cpu was hot-added.  I suppose it
could be done but it seems like an awful lot of churn for little gain.

P.
