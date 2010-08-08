From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sun, 8 Aug 2010 17:38:21 -0400
Message-ID: <20100808213821.GD3635__43895.4694000587$1281303604$gmane$org@thunk.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 08, 2010 at 08:40:28PM +0300, Felipe Contreras wrote:
> 
> My guess is you haven't used a truly multi-tasking device like the
> N900; now that I've got used to it, I consider that functionality
> *essential*.

I've used an N800, and I wasn't impressed; if anything, the fact that
I have to worry about manually killing off applications when memory
gets low, I actually thought it was incredibly sucky.  It was a
miniature, badly done laptop.

Maybe the N900 is different, but the bigger question is what do you
mean by "multi-tasking"?  Definitions are critical here, which is why
Paul was so careful in his definitions section of his document.

Do you mean:

  * allowing multiple processes running at the same time?
  * allowing some applications to be able to update mail, play audio,
    upload location information so your friends know where you are?
  * allowing arbitrary applications that users can interact with
    simultaneously (which implies a window manager, the need to have
    the concept of window focus for keyboard input), etc?

or something else?

> The argument in favor of suspend blockers is that you could take
> applications that are not designed for embedded, and make them run on
> an embedded device without draining excessive battery life; those
> applications would have to be background services not conflicting with
> Android's design.
> 
> I agree there probably would not be that many background apps, and
> probably even less ported background apps, but that is actually an
> argument against suspend blockers.
> 
> The rest of the apps (UI apps), cannot be ported, but have to be
> written specifically for Android, and therefore should have PM in
> mind, and not require suspend blockers to have good power usage.

If you are using a GUI framework which is optimized for a single-
application-focus-at-a-time UI that isn't GNOME or KDE, then that will
require the applications to be written.  However, that's not because
of suspend-blockers.

If you assume a GUI framework which is flexible enough --- maybe Qt
falls into this category, maybe not --- for the rest of the
applications, they don't need to *know* about suspend blockers, and
they certainly do't have to be rewritten or modified specifically for
suspend blockers.  So if your argument is that applications that don't
need bacground services (which you've admitted comprises majority of
applicatios) need to be modified or written specifically to support
suspend blockers, that's simply not true.  They don't need to be
modified at all.

As far as whether they *should* require suspend blockers to be in the
kernel to get power usage that is suitable for cell phone batteries, I
would agree that in the ideal world, it would be nice if you could
have applications that make the correct performance/battery
utilization tradeoff for devices running on 800 mWh batteries, 94,000
mWh batteries, and while running on the AC mains.  But I don't believe
that it's likely to be true, and if you want to try to beat up on
application writers one at a time to be power optimized --- as far as
I'm concerned, that's an argument *for* suspend blockers, since I'm
not big believer in plans that begin, "First, you command the tides of
the sea to go back", King Canute style.  :-)

						- Ted
