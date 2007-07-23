From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 20:50:47 -0700
Message-ID: <1185162647.2714.35.camel__15030.0515852452$1185162827$gmane$org@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185145766.2714.27.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> I disagree with you here. for each frequency setting you can say how much 
> power the cpu/system is expected to use (especially as a percentage of the 
> full power mode). creating this value requires you to take two things into 
> account, the voltage you are running things at (by far the biggest 
> effect), and the minor difference that the frequency makes at that voltage 
> (possibly small enough to ignore entirely).
> 
> the API I proposed has no problem with there being multiple modes that 
> have the same %power but with different %capability numbers.

how do you deal with the "power at idle" vs "power at full load".. you
need both at each level to pick the best one, as well as relative
performance etc.

> 
> I'm willing to bet that the current cpufreq software just looks at the 
> voltage as the value that tells you how much power the thing is going to 
> use at that setting

it doesn't. 
> 
> the fact that you want to run at the max frequancy for a given voltage is 

no I want to run at the max frequency PERIOD. On just about any PC, it's
more power efficient to go full speed when executing code, and then idle
for as long as you can. (there are some second order effects that make
this a bit more complex, but as first order approach it's a sound
approach). Voltage follows, and that's fine.


> a reasonable strategy, but it's a power saving _strategy_, not a 
> capability of the hardware and the API I'm mentioning should be enough to 
> let you pick the highest performance setting that has the same power 
> rating as the minimum performance you need (or for that matter to go one 
> step futher and go with the most efficiant setting in terms of 
> performance/power that has a performance number higher then what you need, 
> which could actually be better)

why would I care about voltage? Most PCs don't expose it, and that's
fine, they can switch to the voltage needed REALLY quickly (single or
double digit microseconds). PCs in fact only expose numbered states (P0
to P7 at most), and some number that you can use to show the user, but
doesn't mean anything beyond that. Some people interpret it as
"frequency", and that's nice, but it doesn't really mean that. You
really don't know anything beyond that....

and that's ok. As I said before, as a general strategy you want "highest
speed when running code" for race-to-idle, with some 2nd order effects
for when you execute code really shortly coming out of idle; in which
case you don't want to do a voltage transition twice (most cpus have the
idle voltage be the lowest-execute voltage as well).



> this strategy should work well on the normal unpredictable workload that 
> most people deal with, but there are some cases where the workload becomes 
> pretty predictable (media players for example) where there really is less 
> variation, and a need for a constant availability of the cpu, so it may 
> actually save a smidge of power to run below the highest freq that the 
> voltage allows rather then running faster and being idle more cycles.

that actually is the example showcase of race-to-idle where you
absolutely want to run at the highest frequency..

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
