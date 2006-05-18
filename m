From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Thu, 18 May 2006 22:50:13 +0200
Message-ID: <20060518205013.GB2571@elf.ucw.cz>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605090857.07853.david-b@pacbell.net>
	<20060516204021.GA5846@ucw.cz>
	<200605181256.35174.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0070469259300134368=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605181256.35174.david-b@pacbell.net>
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

--===============0070469259300134368==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Of course what I _would_ like to see is Linux distros that autosuspend,
> > > entering "standby" after they're idle for a while and then, if they're
> > > not woken up quickly enough, entering "suspend-to-RAM".  No point in
> > > having laptops burn all that energy all the time, after all ... or
> > > automagically inflicting long resume-from-STR latencies on them.
> > 
> > Actually, it is quite hard to decide when it is okay to suspend
> > machine. You do not want it to fall asleep during compilation/cd
> > burning/download.
> 
> Any "is the system idle" test that ignores high cpu or block i/o
> loads is obviously buggy ... but that's easy enough, even those little
> system monitors in X11 can get that right.  And if they get it wrong,
> things would wake up right away.  (The X11 server is a good example

Well, will it ever go to sleep? In such case? There are many things
that wake up periodically.

> As for downloading, that's why ethernet adapters have wake-on-lan (WOL)
> mechanisms.  Likewise for other wakeup-capable devices, like a keyboard
> or mouse.  Or even 3D engines, DSPs, SPUs, ...

?? WOL is for different functionality, I'm afraid. Or do you know
ethernet hub that automagically wakes machines when data come?


> > > > If you guys used a sleep name in the kernel
> > > > sleep_for_not_longer_than_6_minutes_but_more_that_2_seconds() I really
> > > > don't mind -- but if the user has to click a button, I would rather the
> > > > button was marked suspend or hibernate :-)
> > > 
> > > Well "not_longer_yadda_yadda()" would be a bizarre model.  The user-visible
> > > issue is the latency to suspend or resume ... where "standby" is quick, and
> > > "suspend-to-RAM" is relatively slow. ...)
> > 
> > Well, entering/exiting s2ram eats more power than idle; so if you expect to
> > sleep 4 seconds, it is probably best to do nothing, maybe enter
> > standby if you are fast.
> 
> Yes.  Those policy decisions are appopriate for userspace though,
> NOT for a kernelspace "not_longer_yadda_yadda()" API call.

Agreed.

> Are these numbers you sent real ones?  For what computer system?

Well.. no, they are guesses...

> I _might_ have one system to which they apply, but 10W "idle" system
> power seem either way too high (by at least two orders of magnitude!)
> or pretty low (for many current x86 systems).

..based on thinkpad x32 notebook. 10W in idle is pretty much okay,
sleep is around 3W IIRC (linux sucks here), and full cpu load at
minimum speed is 13W... so I was not *that* off.

> Linux could optimize the process of entering/exiting system sleep
> states, if that starts mattering much.  For true suspend states, that
> mostly means suspending drivers, which ought to be cheap when the
> system is already idle enough that autosuspend could kick in.

Yep, you are right, taht was just for ilustration.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--===============0070469259300134368==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0070469259300134368==--
