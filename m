From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 9 Aug 2010 11:24:53 +0100
Message-ID: <20100809112453.77210acc@lxorguk.ukuu.org.uk>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100804195704.GA23681@linux.vnet.ibm.com>
	<20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100808213821.GD3635@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Brian@smtp1.linux-foundation.org, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

> I have to worry about manually killing off applications when memory
> gets low, I actually thought it was incredibly sucky.  It was a
> miniature, badly done laptop.

Likewise I thought the lack of proper multi-tasking apps in Android was
comically bad. Nice device completely wrecked by the inability to flip
between running apps each with their own screen - something that was old
tech in 1990.

It's no use looking at this from an "In my opinion" angle. A proper
solution works for most if not all opinions except maybe around corner
cases.

>   * allowing arbitrary applications that users can interact with
>     simultaneously (which implies a window manager, the need to have
>     the concept of window focus for keyboard input), etc?

That's also untrue as anyone who has worked in industrial control or
entertainment systems will tell you. You may well have fourteen apps
driving fourteen display/input devices and no window manager.

> would agree that in the ideal world, it would be nice if you could
> have applications that make the correct performance/battery
> utilization tradeoff for devices running on 800 mWh batteries, 94,000
> mWh batteries, and while running on the AC mains.  But I don't believe
> that it's likely to be true, and if you want to try to beat up on
> application writers one at a time to be power optimized --- as far as
> I'm concerned, that's an argument *for* suspend blockers, since I'm
> not big believer in plans that begin, "First, you command the tides of
> the sea to go back", King Canute style.  :-)

Suspend blockers drive the system policy part way into the apps, that in
turn makes the apps very vulnerable to change in their environment because
you've specialised them. I am sure that in the Android world it's
considered fine, and that the marketing and business people even like
this binding together - but it doesn't generalise and will blow up in
people's faces in the future.

To consider your tide analogy - suspend blockers is like trying to
program the waves individually. Show me a suspend blocker aware open
office patch 8)
