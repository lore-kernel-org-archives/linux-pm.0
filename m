From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 17:13:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0608251702230.3307-100000@netrider.rowland.org>
References: <EA12F909C0431D458B9D18A176BEE4A5074D0573@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5074D0573@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Aug 2006, Woodruff, Richard wrote:

> > ?  Wouldn't suspending the entire bus completely stop the throughput
> of
> > any attached device?
> =

> Not necessarily (right?).  If I shut off VBUS then yes then I need to
> re-enumerate for sure.  One might figure out a cleaver way of shutting
> it off and turning it back on in between host requests.

No, you can't do that.  Without VBUS power there's no reliable way to
detect disconnects or media changes.

>  If I have a USB
> drive attached it might well be the protocol layers are smart enough
> keep using the device once it is restarted at the low layers.  They just
> have to wait longer for the data to arrive.
> =

> If I just do USB bus suspend the device at the other end can signal
> remote wake up to me.  I tell him suspend and he agrees to drop to a low
> power state, then I lower current capacity.  When he has some data he
> can let me know and I'll up the VBUS current capacity and then go talk
> to him.  If I have data I want from him I directly wake him up.

Assuming the device has remote wake-up capability.  And assuming the =

latency of a remote wakeup isn't too high.  I tried doing some tests using =

a USB keyboard; when the device was suspended and I woke it up by typing =

on it, nearly every time the first few keystrokes were lost.

> > But this doesn't require any over-reaching global coordination.  All
> it
> > needs is for each driver to know when it's not being used.
> =

> Applying an activity time of sorts to each driver 'might' end up in
> situations where you get good power savings.  Assuming everything lines
> up.  However, given hardware and software bugs and errata, it seems
> forcing the situation is much more likely to succeed and make sure you
> hit your targets.

Activity timers might be appropriate for some devices but not for others.  =

For instance, a USB mass-storage device will always have a lower-level
driver below the USB driver (for instance, a disk or CD driver that uses
the USB driver for its transport).  Suspending the USB driver can't be
done unless the lower-level driver is suspended first, because it might =

have unexpected side effects such as spinning down a drive.  My point =

being that an inactivity timer might be appropriate at the level of the =

disk or CD driver, but not at the level of a USB mass-storage driver.

> Even with a per-driver activity timer how does one set the time out
> levels for the whole system?  You need some kind of policy pieces to set
> all the knobs.  Letting the self adjust won't likely work for QOS
> (quality of service type things) unless they are set very
> conservatively.

I would imagine it depends very heavily on the type of system you're =

talking about.  On desktops and laptops, for example, Windows seems to get =

along okay with a small handful of system-level inactivity timers.

Alan Stern
