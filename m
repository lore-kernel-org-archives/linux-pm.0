From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 19:45:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707221914550.6350__18434.5285794281$1185158923$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185145766.2714.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185145766.2714.27.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Jul 2007, Arjan van de Ven wrote:

>>>> son anyway)
>>>
>>> I don't think you have got it right: the only info being passed is the
>>> standard cpufreq list of frequencies; everything else is part of the
>>> cpufreq driver.
>>
>> to make the decisions the software makeing the decision needs to know how
>> much power would be used at each freq setting.
>
> power used at a certain frequency is not a single variable.
> In fact, on most laptops and other similarly power aware devices, it's
> in fact better for power consumption to always go to the maximum
> frequency as quickly as possible, so that you can be idle for the
> longest possible time after that. Good luck finding a generic way to
> represent such things in a (userspace) interface....

I disagree with you here. for each frequency setting you can say how much 
power the cpu/system is expected to use (especially as a percentage of the 
full power mode). creating this value requires you to take two things into 
account, the voltage you are running things at (by far the biggest 
effect), and the minor difference that the frequency makes at that voltage 
(possibly small enough to ignore entirely).

the API I proposed has no problem with there being multiple modes that 
have the same %power but with different %capability numbers.

I'm willing to bet that the current cpufreq software just looks at the 
voltage as the value that tells you how much power the thing is going to 
use at that setting

the fact that you want to run at the max frequancy for a given voltage is 
a reasonable strategy, but it's a power saving _strategy_, not a 
capability of the hardware and the API I'm mentioning should be enough to 
let you pick the highest performance setting that has the same power 
rating as the minimum performance you need (or for that matter to go one 
step futher and go with the most efficiant setting in terms of 
performance/power that has a performance number higher then what you need, 
which could actually be better)

the fact that you currently want to use this strategy doesn't mean that 
the other possible modes don't exist, and even if you don't use them now 
they should be available within the API (including the cpufreq api)

this strategy should work well on the normal unpredictable workload that 
most people deal with, but there are some cases where the workload becomes 
pretty predictable (media players for example) where there really is less 
variation, and a need for a constant availability of the cpu, so it may 
actually save a smidge of power to run below the highest freq that the 
voltage allows rather then running faster and being idle more cycles.

David Lang
