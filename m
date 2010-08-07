From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 18:00:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008061741460.30564@asgard.lang.hm>
References: <20100805230304.GQ2447@linux.vnet.ibm.com>
	<AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y@mail.gmail.com>
	<alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
	<AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
	<20100806123047.GE31326@sirena.org.uk>
	<20100806172226.GH2432@linux.vnet.ibm.com>
	<20100806173325.GA25367@rakim.wolfsonmicro.main>
	<20100806181832.GJ2432@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061517130.30564@asgard.lang.hm>
	<20100807001431.GA3252@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100807001431.GA3252@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Aug 2010, Mark Brown wrote:

> On Fri, Aug 06, 2010 at 04:35:59PM -0700, david@lang.hm wrote:
>> On Fri, 6 Aug 2010, Paul E. McKenney wrote:
>
>> So as I see it, we need to do one of two things.
>
>> 1. change the suspend definition to allow for some things to not be
>> suspended
>
> This is essentially what's already happening.
>
>> 2. change the sleep/low-power mode definition to have a more standardized
>> way of turning things off, and extend it to allow clocks to be turned off
>> as well (today we have things able to be turned off, drive spin-down for
>> example, but per comments in this thread it's all one-off methods)
>
> Currently things like clock trees are frequently managed orthogonaly to
> the system power state to at least some extent anyway - for example,
> perfectly normal wake events like button presses will often require
> clocks for things like debouncing.

I recognise that #1 is essentially what Android is already doing.

I'm asking the question, "Is this what Linux should be doing?

Personally, I think that suspend should be treated much more like a 
low-power state and much less like hibernation than it currently is (I 
believe that Linus has also voiced this opinion). And I think that the 
situation with Android suspending while audio is playing between busts of 
CPU activity is a perfect example.

for the moment, forget the problem of other apps that may be running, and 
consider a system that's just running a media player.

the media player needs bursts of CPU to decode the media so that the 
output device can access it (via DMA or something like that)

the media player needs bursts of I/O to read the encoded program source 
from storage.

What we want to have happen in an ideal world is

when the storage isn't needed (between reads) the storage should shutdown 
to as low a power state as possible.

when the CPU isn't needed (between decoding bursts) the CPU and as much of 
the system as possible (potentially including some banks of RAM) should 
shutdown to as low a power state as possible.


today there are two ways of this happening, via the idle approach (on 
everything except Android), or via suspend (on Android)

Given that many platforms cannot go to into suspend while still playing 
audio, the idle approach is not going to be able to be eliminated (and in 
fact will be the most common approach to be used/deugged in terms of the 
types of platforms), it seems to me that there may be a significant amount 
of value in seeing if there is a way to change Android to use this 
approach as well instead of having two different systems competing to do 
the same job.

David Lang
