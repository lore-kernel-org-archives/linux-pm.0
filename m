From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 30 Aug 2010 17:04:37 -0700
Message-ID: <20100831000437.GS2420__2051.40239927477$1283213250$gmane$org@linux.vnet.ibm.com>
References: <20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<AANLkTinNxZoMab=tG9KXJ9n_nxB1dXHkfk-7xUMWXACW@mail.gmail.com>
	<AANLkTin3H0o+WQocUYjUcPGRpkRqK9H2LJ0OwHXFNBdj@mail.gmail.com>
	<20100813144236.GB2511@linux.vnet.ibm.com>
	<20100828085135.GA2711@ucw.cz>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100828085135.GA2711@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 28, 2010 at 10:51:35AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > You are *one* user of the kernel. Let's suppose Android wasn't using
> > > suspend-blockers, and there was another equally successful linux
> > > mobile platform, Foobingo, and they were using them, and they were the
> > > only ones interested on implementing them.
> > > 
> > > What does that change? Nothing. They still need to convince the
> > > community that what they are proposing to be merged is actually
> > > useful, and somebody will use it. If not, they can just keep the patch
> > > for themselves until they do. I don't see the big deal.
> > 
> > So the current users of the Linux kernel are the following?
> > 
> > o	GNU/Linux
> > o	Android
> > 
> > Do any other distributions or devices with unusual user-space layouts
> > qualify?
> 
> QTembedded distros are somehow similar to android (one big binary).
> 
> Then there's minor stuff, like webOS and Motorola A1200...

It does sounds like there is some variety, then.  Thank you for the info!

							Thanx, Paul
