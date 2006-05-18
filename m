From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend and hibernate nomenclature
Date: Thu, 18 May 2006 12:56:33 -0700
Message-ID: <200605181256.35174.david-b@pacbell.net>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605090857.07853.david-b@pacbell.net>
	<20060516204021.GA5846@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45257666254385054=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060516204021.GA5846@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============45257666254385054==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tuesday 16 May 2006 1:40 pm, Pavel Machek wrote:
> Hi!
> 
> > Of course what I _would_ like to see is Linux distros that autosuspend,
> > entering "standby" after they're idle for a while and then, if they're
> > not woken up quickly enough, entering "suspend-to-RAM".  No point in
> > having laptops burn all that energy all the time, after all ... or
> > automagically inflicting long resume-from-STR latencies on them.
> 
> Actually, it is quite hard to decide when it is okay to suspend
> machine. You do not want it to fall asleep during compilation/cd
> burning/download.

Any "is the system idle" test that ignores high cpu or block i/o
loads is obviously buggy ... but that's easy enough, even those little
system monitors in X11 can get that right.  And if they get it wrong,
things would wake up right away.  (The X11 server is a good example
of the worst case.  Mine often ignores mouse and keyboard events, and
will do things like kicking in the screen saver while I'm paging through
a document ... it comes right back, but it's _very_ annoying.)

As for downloading, that's why ethernet adapters have wake-on-lan (WOL)
mechanisms.  Likewise for other wakeup-capable devices, like a keyboard
or mouse.  Or even 3D engines, DSPs, SPUs, ...


> > > If you guys used a sleep name in the kernel
> > > sleep_for_not_longer_than_6_minutes_but_more_that_2_seconds() I really
> > > don't mind -- but if the user has to click a button, I would rather the
> > > button was marked suspend or hibernate :-)
> > 
> > Well "not_longer_yadda_yadda()" would be a bizarre model.  The user-visible
> > issue is the latency to suspend or resume ... where "standby" is quick, and
> > "suspend-to-RAM" is relatively slow. ...)
> 
> Well, entering/exiting s2ram eats more power than idle; so if you expect to
> sleep 4 seconds, it is probably best to do nothing, maybe enter
> standby if you are fast.

Yes.  Those policy decisions are appopriate for userspace though,
NOT for a kernelspace "not_longer_yadda_yadda()" API call.

Are these numbers you sent real ones?  For what computer system?
I _might_ have one system to which they apply, but 10W "idle" system
power seem either way too high (by at least two orders of magnitude!)
or pretty low (for many current x86 systems).

Linux could optimize the process of entering/exiting system sleep
states, if that starts mattering much.  For true suspend states, that
mostly means suspending drivers, which ought to be cheap when the
system is already idle enough that autosuspend could kick in.

- Dave


> 4sec idle: 4 sec at 10W
>
> 4sec s2ram: 2 sec entering s2ram at 15W, 0 sec sleep, 2 sec exiting
> s2ram at 15W. bad
>
> 4sec standby: 1sec enter standby at 15W, 2 sec sleep at 5W, 1 sec exit
> standby at 15W

--===============45257666254385054==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45257666254385054==--
