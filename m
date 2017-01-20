From: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Subject: Re: Delayed acpi frequency governor call
Date: Fri, 20 Jan 2017 16:27:30 +0100
Message-ID: <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from virgo01.ee.ethz.ch ([129.132.2.226]:53061 "EHLO
        virgo01.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbdATPot (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2017 10:44:49 -0500
In-Reply-To: <20170120100725.GO11478@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, venkatesh.pallipadi@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 20.01.2017 11:07, Viresh Kumar wrote:
> + PM list.
>
> On 20-01-17, 10:48, Philipp Miedl wrote:
>> Hi!
>>
>> I'm using the kernel version 4.4.0-59-generic and 4.4.0 with acpi cpufreq
>> drivers (cpufrequtils 008) on a Lenovo T440p laptop. Now I've bumped into
>> some weird behaviour:
>> it can happen that the call to the governor is delayed for so long, that in
>> the governor the if-statement in cpufreq_governor.c line 138
>> is true, which means the governor thinks the cpu was idle. This can lead to
>> the case that the frequency is still scaled up when it should in
>> fact be scaled down.
>>
>> Now I've written a small programm which ensures that the cpu is never idle
>> for longer than 850us, but does not generate a cpu utilization higher
>> than 5% - still the behaviour is the same. I've looked a bit closer at this
>> and I figured out that if I increase the utilization of the observed CPU,
>> at utilzations higher than 80% the maximum delay between two governor calls
>> increases and can rise almost to 10x sampling rate
>> (/sys/drivers/system/cpu/cpufreq/sampling_rate).
>> Weirdly enough, after a long time (>1s) the average call time of the
>> governor is always around the specified sampling rate.
>>
>> I could not fully understand how the governor is call and this work queue
>> works and therefore I also have a hard time making sense of this behaviour.
>> Can anyone please help me out?
> Have a look at below commit:
>
> commit 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster
> for deferred updates")
>
> It may be related to what you are observing.
>

This is not my issue. The code I'm referring to can be found in 
cpufreq_governor.c:
<-->
if (unlikely(wall_time > (2 * sampling_rate) &&
        j_cdbs->prev_load)) {
   load = j_cdbs->prev_load;

   /*
    * Perform a destructive copy, to ensure that we copy
    * the previous load only once, upon the first wake-up
    * from idle.
    */
   j_cdbs->prev_load = 0;
} else {
   load = 100 * (wall_time - idle_time) / wall_time;
   j_cdbs->prev_load = load;
}
<-->

How can it happen that "unlikely(wall_time > (2 * sampling_rate)" is 
true although the CPU utilization was 5%?

Thanks

-- 
--------------------------------------------------------------------
|  Philipp Miedl                                                   |
|  PhD Student @ Computer Engineering and Networks Laboratory      |
|  ETH Zurich, ETZG76, Gloriastrasse 35, 8092 Zurich, Switzerland  |
|  mail: philipp.miedl@ee.tik.ethz.ch      phone: +41 44 632 70 61 |
--------------------------------------------------------------------

