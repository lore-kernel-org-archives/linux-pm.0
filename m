From: Mason <mpeg.blue@free.fr>
Subject: Re: RFC on cpufreq implementation
Date: Mon, 19 Jan 2015 23:13:53 +0100
Message-ID: <54BD81A1.6030301@free.fr>
References: <54B7F7CD.7030903@free.fr>
	<CAHLCerMq0HnhS3ki3U1te5A8+NiDwpFNL_5_bm-CR4LoYFLo=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAHLCerMq0HnhS3ki3U1te5A8+NiDwpFNL_5_bm-CR4LoYFLo=A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 19/01/2015 10:22, Amit Kucheria wrote:

> On Thu, Jan 15, 2015 at 10:54 PM, Mason wrote:
> 
>> This is a follow-up to my previous thread.
>> "How many frequencies would cpufreq optimally like to manage?"
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669
>>
>> As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
>> based SoC (namely Tango4 from Sigma Designs). I'd like to get
>> some feedback on the cpufreq driver I wrote for that platform.
>>
>> I decided to expose only a small subset of frequencies (namely
>> {999,500,333,111} MHz) because, in my tests, the ondemand gov
>> chose mostly min and max, and the intermediate frequencies not
>> so much; so I figured "2 intermediate freqs" is good enough.
>> (I'm ready to hear otherwise.)
> 
> How many states are really enough depends on the main workloads
> running on your system. In a closed system (limited number of
> applications) you can easily characterise your workloads and see what
> operating points (OPP = voltage, frequency pair) the system spends
> most of its time in (CPU_FREQ_STAT_DETAILS) and optimize out the
> remaining OPPs.

Testing with CPU_FREQ_STAT_DETAILS enabled is on my TODO list.
Thanks for reminding me!

> In an open-ended system where you don't control what applications will
> run on the system (e.g. android phone), it is probably a good idea to
> expose more OPPs while keeping in mind that exposing 50 frequencies is
> probably overkill (and silly) since you're spending more time reaching
> the "optimum" OPP. Pick some high-impact ones e.g. ones that allow you
> to lower your voltage.

The current SoC does not support dynamic voltage scaling at all.
So I'm just tweaking the frequency. IIUC, if I divide freq by 4,
power should be divided by 4?

>> I tried to use as much generic framework as possible, but I've
>> read about the clk framework, and it looks to be an even greater
>> generalization. Are new platforms encouraged to use that, rather
>> than provide a cpufreq driver? Does it work when voltage scaling
>> comes in play? (This SoC doesn't have it, but the next will.)
>>
>> I'm also wondering how cpufreq and cpuidle interact? Is one a
>> subset of the other? Are they orthogonal?
> 
> These queries have been answered by Krzysztof.

The current SoC does not support any "deep" sleep; I was told that
the core just powers "itself" down after a WFI, nothing fancier.

Regards.
