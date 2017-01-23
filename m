From: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Subject: Re: Delayed acpi frequency governor call
Date: Mon, 23 Jan 2017 15:24:08 +0100
Message-ID: <086bc55f-d1cc-b893-49c6-1667f6067f1b@tik.ee.ethz.ch>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
 <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
 <20170123101145.GB26681@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from virgo01.ee.ethz.ch ([129.132.2.226]:35778 "EHLO
        virgo01.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAWOYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2017 09:24:13 -0500
In-Reply-To: <20170123101145.GB26681@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, venkatesh.pallipadi@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 23.01.2017 11:11, Viresh Kumar wrote:
> On 20-01-17, 16:27, Philipp Miedl wrote:
>> This is not my issue. The code I'm referring to can be found in
>> cpufreq_governor.c:
>> <-->
>> if (unlikely(wall_time > (2 * sampling_rate) &&
>>         j_cdbs->prev_load)) {
> This only confirms that the CPU was idle for sometime.
I would say it only checks whether the elapsed time since the last 
governor call. My question is whether the call to the governor can be 
delayed for such a long time without the CPU going into idle? If it can 
be guaranteed that the governor call cannot be delayed without the CPU 
going to idle than it is true - otherwise not.
>>    load = j_cdbs->prev_load;
>>
>>    /*
>>     * Perform a destructive copy, to ensure that we copy
>>     * the previous load only once, upon the first wake-up
>>     * from idle.
>>     */
>>    j_cdbs->prev_load = 0;
>> } else {
>>    load = 100 * (wall_time - idle_time) / wall_time;
>>    j_cdbs->prev_load = load;
>> }
>> <-->
>>
>> How can it happen that "unlikely(wall_time > (2 * sampling_rate)" is true
>> although the CPU utilization was 5%?
> I am not sure how your test works, etc. Maybe try to generate traces for your
> CPUs to see if they are going into idle or not. Maybe you are having a hard time
> because of SMP platform ?
Possible that I'm having problems with the platforms. Its a quadcore 
with 2 hyperthreads. I have two applications running, one should keep 
the CPU its pinned to busy at around 5% utilization by doing 
calculations. The second one is pinned to another core (its also another 
physical core) and records all the timing values etc. The rest of the 
CPUs are not utilzed by me and besides my stuff there is just a bare 
Linux running without GUI.
I checked the values I get from get_cpu_idle_time(), which gets its 
values from get_cpu_idle_time_us() (tick-sched.c) or if that is not 
possible assembles it from the cpustat, and the according to these the 
CPU is never idle longer than sampling_rate - so the if statement from 
above should never be true.

Do I interpret the values wrong or can it be that the call to the 
governor gets delayed by something else?

-- 
--------------------------------------------------------------------
|  Philipp Miedl                                                   |
|  PhD Student @ Computer Engineering and Networks Laboratory      |
|  ETH Zurich, ETZG76, Gloriastrasse 35, 8092 Zurich, Switzerland  |
|  mail: philipp.miedl@ee.tik.ethz.ch      phone: +41 44 632 70 61 |
--------------------------------------------------------------------

