From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 9 Aug 2010 11:16:38 -0700
Message-ID: <20100809181638.GI3026__42163.0760575228$1281377889$gmane$org@linux.vnet.ibm.com>
References: <20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100809112453.77210acc@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 09, 2010 at 11:24:53AM +0100, Alan Cox wrote:

[ . . . ]

> > would agree that in the ideal world, it would be nice if you could
> > have applications that make the correct performance/battery
> > utilization tradeoff for devices running on 800 mWh batteries, 94,000
> > mWh batteries, and while running on the AC mains.  But I don't believe
> > that it's likely to be true, and if you want to try to beat up on
> > application writers one at a time to be power optimized --- as far as
> > I'm concerned, that's an argument *for* suspend blockers, since I'm
> > not big believer in plans that begin, "First, you command the tides of
> > the sea to go back", King Canute style.  :-)
> 
> Suspend blockers drive the system policy part way into the apps, that in
> turn makes the apps very vulnerable to change in their environment because
> you've specialised them. I am sure that in the Android world it's
> considered fine, and that the marketing and business people even like
> this binding together - but it doesn't generalise and will blow up in
> people's faces in the future.
> 
> To consider your tide analogy - suspend blockers is like trying to
> program the waves individually. Show me a suspend blocker aware open
> office patch 8)

But wouldn't an office suite run as a power-oblivious application on an
Android device?  After all, office applications do not need to run when
the screen is turned off, so these the applications do not need to use
suspend blockers.  That said, I could easily imagine that significant
work would be required to make OpenOffice run on Android, not due to
suspend blockers, but rather due to Android's unusual user space.

On devices that do not have suspend blockers, a normal application runs
in a manner similar to a hypothetical Android application that acquires
a suspend blocker when it starts and holds that suspend blocker until
it exits.  In contrast with Android, this situation requires that each
and every application be carefully written to avoid battery drain,
which I suspect is what Ted is getting at with his King Canute analogy.

							Thanx, Paul
