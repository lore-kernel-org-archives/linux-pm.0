From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sat, 7 Aug 2010 01:14:32 +0100
Message-ID: <20100807001431.GA3252__15236.8090967231$1281140215$gmane$org@opensource.wolfsonmicro.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008061517130.30564@asgard.lang.hm>
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
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 06, 2010 at 04:35:59PM -0700, david@lang.hm wrote:
> On Fri, 6 Aug 2010, Paul E. McKenney wrote:

Guys, please try to cut unneeded text from the quotes - it makes it much
easier to find the new text.

>>> Well, not really from the Linux point of view.  It's not massively
>>> different to something like keeping an ethernet controller sufficiently
>>> alive to allow it to provide wake on LAN functionality while the system

>> The wake-on-LAN and the lights-out management systems are indeed
>> interesting examples, and actually pretty good ones.  The reason I
>> excluded them is that they don't do any application processing -- their
>> only purpose is the care and feeding of the system itself.  In contrast,
>> the embedded processors are able to do significant applications processing
>> (e.g., play back music) while any CPUs are completely shut down and most
>> of the memory is powered down as well.

This isn't a particularly meaningful distinction, things like the LoM
systems on servers are generally at least as capable as things like the
DSPs doing tasks like offloaded MP3 decode and often provide useful
services in themselves (like system monitoring).  It's really just
semantics to treat them differently to something like a cellular modem -
at a high level they're both just independant processors ticking away
without the application processor.

> one other significant issue is that on the PC, things like wake-on-LAN,  
> lights out management cards, etc require nothing from the main system  
> other than power. If they do something, they are sending the signal to 
> the chipset, which then wakes the system up. they don't interact with the 
> main processor/memory/etc at all.

I don't see that it makes much difference what gets kept alive - at the
end of the day the point is that we're making a decision to keep bits of
the system alive over suspend.

> So as I see it, we need to do one of two things.

> 1. change the suspend definition to allow for some things to not be  
> suspended

This is essentially what's already happening.

> 2. change the sleep/low-power mode definition to have a more standardized 
> way of turning things off, and extend it to allow clocks to be turned off 
> as well (today we have things able to be turned off, drive spin-down for  
> example, but per comments in this thread it's all one-off methods)

Currently things like clock trees are frequently managed orthogonaly to
the system power state to at least some extent anyway - for example,
perfectly normal wake events like button presses will often require
clocks for things like debouncing.
