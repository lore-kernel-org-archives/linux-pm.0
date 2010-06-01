From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 00:00:52 +0200
Message-ID: <201006020000.52992.rjw__47992.450829088$1275429623$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<AANLkTimIzm7fEczlaDT5QqkiBFAjbe46rciLxxsoLSya@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimIzm7fEczlaDT5QqkiBFAjbe46rciLxxsoLSya@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 June 2010, Arve Hj=F8nnev=E5g wrote:
> On Mon, May 31, 2010 at 3:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday 31 May 2010, Neil Brown wrote:
> >> On Thu, 27 May 2010 23:40:29 +0200 (CEST)
> >> Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> > On Thu, 27 May 2010, Rafael J. Wysocki wrote:
> >> >
> >> > > On Thursday 27 May 2010, Thomas Gleixner wrote:
> >> > > > On Thu, 27 May 2010, Alan Stern wrote:
> >> > > >
> >> > > > > On Thu, 27 May 2010, Felipe Balbi wrote:
> >> > > > >
> >> > > > > > On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wro=
te:
> >> > > > > > >If people don't mind, here is a greatly simplified summary =
of the
> >> > > > > > >comments and objections I have seen so far on this thread:
> >> > > > > > >
> >> > > > > > >   The in-kernel suspend blocker implementation is okay, ev=
en
> >> > > > > > >   beneficial.
> >> > > > > >
> >> > > > > > I disagree here. I believe expressing that as QoS is much be=
tter. Let
> >> > > > > > the kernel decide which power state is better as long as I c=
an say I
> >> > > > > > need 100us IRQ latency or 100ms wakeup latency.
> >> > > > >
> >> > > > > Does this mean you believe "echo mem >/sys/power/state" is bad=
 and
> >> > > > > should be removed?  Or "echo disk >/sys/power/state"?  They pa=
y no
> >> > > >
> >> > > > mem should be replaced by an idle suspend to ram mechanism
> >> > >
> >> > > Well, what about when I want the machine to suspend _regardless_ o=
f whether
> >> > > or not it's idle at the moment?  That actually happens quite often=
 to me. :-)
> >> >
> >> > Fair enough. Let's agree on a non ambigous terminology then:
> >> >
> >> >      forced:
> >> >
> >> >          suspend which you enforce via user interaction, which
> >> >                  also implies that you risk losing wakeups depending=
 on
> >> >                  the hardware properties
> >>
> >> Reasonable definition I think.  However the current implementation doe=
sn't
> >> exactly match it.
> >> With the current implementation you risk losing wakeups *independent* =
of the
> >> hardware properties.
> >
> > Define "losing", please.
> >
> > Currently, we simply don't regard hardware signals occuring _during_ the
> > suspend operation itself as wakeups (unless they are wakeup interrupts =
to be
> > precise, because these _are_ taken into account by our current code).
> >
> > The reason is that the meaning of given event may be _different_ at run=
 time
> > and after the system has been suspended.  For example, consider a power=
 button
> > on a PC box.  If it's pressed at run time, it usually means "power off =
the
> > system" to the kernel.  After the system has been suspended, however, i=
t means
> > "wake up".  So, you have to switch from one interpretation of the event=
 to the
> > other and that's not an atomic operaition (to put it lightly).
> >
> >> Even with ideal hardware events can be lost - by which I mean that the=
y will
> >> not be seen until some other event effects a wake-up.
> >> e.g. the interrupt which signals the event happens immediately before =
the
> >> suspend is requested (or maybe at the same time as), but the process w=
hich
> >> needs to handle the event doesn't get a chance to see it before the su=
spend
> >> procedure freezes that process, and even if it did it would have no wa=
y to
> >> abort the suspend.
> >>
> >> So I submit that the current implementation doesn't match your descrip=
tion of
> >> "forced", is therefore buggy, and that if it were fixed, that would be
> >> sufficient to meet the immediate needs of android.
> >
> > I don't really think it may be fixed with respect to every possible kin=
d of
> > hardware.  On platforms where I/O interrupts are wakeup events it should
> > work right now.  On other platforms it may be impossible to overcome ha=
rdware
> > limitations.
> >
> =

> There is no reason you cannot make the rtc alarms work reliably on x86
> hardware.

They usually work, but not in 100% of cases.

Generally, "x86 hardware" is a broad category, where modern ones have much =
more
interesting capabilities than the older.

> Even if you may loose key events while suspending I think it
> is still valuable to have reliable alarms.

I don't think anyone will argue with that. :-)

Rafael
