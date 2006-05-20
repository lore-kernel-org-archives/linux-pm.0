From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Sun, 21 May 2006 00:39:55 +0200
Message-ID: <20060520223955.GB8490@elf.ucw.cz>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605181925.30967.david-b@pacbell.net>
	<20060520172051.GL2946@elf.ucw.cz>
	<200605201354.41229.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49877119609500664=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605201354.41229.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============49877119609500664==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Things that really *must* wake up periodically should be using some API that
> > > interacts with RTC alarms, and those RTC alarms should be acting as system
> > > wakeup events.
> > 
> > But that means completely rewriting userspace.
> 
> Completely?  No.  Hardly anything really _requires_ real-time wakeups.
> 
> In any case, I can't possibly believe it's news to you that userspace code
> which uses periodic polling is troublesome ... it wasn't news in the 1980s,
> or 1990s, so it can't be news now.  That's not just from the power management
> perspective; it also makes trouble in GUI applications architecture
> too.

Well, maybe it is not news to _me_, but it is certainly news to
application writers.

Battery applet requires polling -- we have no battery interface that
is event-driven, for example. Then you have clock on the desktop. Then
there's blinking cursor (in X) at HZ/5 or something like that.

How can kernel know which sleep is "important enough" to wake up
system for it?

Like, yes, we can probably do that on embedded platforms, but for
something running KDE/Gnome?

[Now, it is true that things are getting better. One of tricks is to
make sure all the periodic polling happens synchronized (=> cpu can
sleep for longer intervals between polls), and there are tricks like
"only blink X cursor 5 times", but... try running timertop on
KDE/Gnome system...] 

> > > There's also non-automated sleep too ... what "apmsleep" used to do when
> > > you told it to suspend until 7am (or for two hours, etc).  The same thing
> > > can be done with /sys/power/state and a wakeup-enabled RTC.
> > 
> > Yep, I should get it working one day.
> 
> See the attached.  "rtcwake -t $(( 5 * 60 * 60))" to sleep in standby mode
> for five hours, or until some other wakeup event kicks in.  :)

Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--===============49877119609500664==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49877119609500664==--
