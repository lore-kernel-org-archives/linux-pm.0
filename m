From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 15:55:38 +0200
Message-ID: <201006061555.38526.rjw__33109.0086875067$1275832539$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006060044.16950.rjw@sisk.pl>
	<AANLkTikrPTvkXZM2yybiDfkHraRkw4oCH9nC8R4d3KS5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikrPTvkXZM2yybiDfkHraRkw4oCH9nC8R4d3KS5@mail.gmail.com>
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
Cc: tytso@mit.edu, Andrew Morton <akpm@linux-foundation.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> >> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
...
> >
> > Arve, we're still learning you have some more requirements we had no id=
ea
> =

> What new requirement are you talking about. Did you assume all our
> user-space ipc calls went though a single process?

No, but I didn't assume that your wakelock-holding processes depend on the
other processes in a way that might prevent them from acquiring or dropping
a wakelock.

...
> >> >> Trusted code that calls into untrusted code has to deal with the
> >> >> untrusted code not responding, but we only want to pop up a message
> >> >> that the application is not responding if it is misbehaving, not ju=
st
> >> >> because it was frozen though no fault of its own.
> >
> > When Android starts opportunistic suspend, all applications are frozen,
> > "trusted" as well as "untrusted", right?  So, after they are all frozen=
, none
> > of them can do anything to prevent suspend from happening, right?
> =

> Not if you mean when we write to /sys/power/state. Processes are not
> frozen until the last suspend blocker is released.

That doesn't matter.  In the opportunistic mode you don't need to write into
/sys/power/state to start suspend, this is done by the kernel automatically=
 as
soon as the last wakelock has been released (at least this is my assumption
about how this works).  Now, at this point the processes that don't use
wakelocks can't really prevent themselves from being frozen and only the
wakelocks users can do that.  So, if a wakelock user depends on a process
that doesn't use wakelocks in such a way that (because of that dependence) =
it
can't acquire its wakelock while processes are being frozen, things don't w=
ork
as they are supposed to.

> > Now, in my proposed approach the "untrusted" apps are frozen exactly at=
 the
> > point Android would start opportunistic suspend and they wouldn't be ab=
le
> > to do anything about that anyway.  So if one of your "trusted" apps dep=
ends
> > on the "untrusted" ones in a way that you describe, you alread have a b=
ug
> > (the "trusted" app cannot prevent automatic suspend from happening even=
 if it
> > wants, because it depends on an "untrusted" app that has just been froz=
en).
> >
> =

> I don't think what you said here is correct. If a wakeup event happens
> all processed are unfrozen since the driver blocks suspend.

This only means that the theoretical failure you gave as an example doesn't
happen in practice.  No problem, then. :-)

> The app that reads this event blocks suspend before reading it. If it was
> busy talking to a less trusted app when the event happened it still works
> since all apps are running at this point.

And how is this different from an approach with cgroup freezing?  Apps that
use wakelock within the current framework would use "freeze locks" to preve=
nt
the "untrusted" part of user space from being frozen or to thaw it.  Where's
the problem, then?

Rafael
