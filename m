From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] [RFC][PATCH -mm 1/5] PM: Make
	freeze_processes SMP-safe
Date: Thu, 30 Nov 2006 22:55:52 +0100
Message-ID: <200611302255.53312.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl> <200611300121.53975.rjw@sisk.pl>
	<200611301607.05122.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200611301607.05122.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: suspend-devel@lists.sourceforge.net
Cc: pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 30 November 2006 16:07, Rafael J. Wysocki wrote:
> On Thursday, 30 November 2006 01:21, Rafael J. Wysocki wrote:
> > On Thursday, 30 November 2006 00:55, Pavel Machek wrote:
> > > Hi!
> > > =

> > > > > > I do not like the counting idea; it should be simpler to just c=
heck if
> > > > > > all the processes are still stopped.
> > > > > =

> > > > > I thought about that but didn't invent anything reasonable enough.
> > > > > =

> > > > > > But I'm not sure if this is enough. What if signal is being del=
ivered
> > > > > > on another CPU while freezing, still being delivered while this=
 second
> > > > > > check runs, and then SIGCONT is delivered? =

> > > > > =

> > > > > Hm, is this possible in practice?  I mean, if todo is 0 and nr_st=
opped doesn't
> > > > > change, then there are no processes that can send the SIGCONT (un=
less someone
> > > > > creates a kernel thread with PF_NOFREEZE that will do just that).
> > > > > =

> > > > > Anyway, for now I've no idea how to fix this properly.  Will thin=
k about it
> > > > > tomorrow.
> > > > =

> > > > As far as this particular problem is concerned, I think there are t=
wo possible
> > > > solutions.
> > > > =

> > > > One of them would be do disable the delivery of continuation signal=
s before
> > > > we start freezing processes, but I don't know how to do this exactl=
y so that
> > > > it's not racy.  Also it would be quite intrusive.
> > > > =

> > > > The other one may be something along with the lines of the appended=
 patch.
> > > =

> > > There has to be a better solution. Stopped tasks are suspended
> > > somewhere in kernel, right? One try_to_freeze() and problem should be
> > > solved, in regular way, and without tricks...?
> > =

> > Why?  _This_ is a regular way, IMHO.
> > =

> > The problem is that stopped tasks aren't actually running (obviously) s=
o they
> > _can't_ execute try_to_freeze() until someone sends them a signal.  How=
ever,
> > once they actually have received the signal, we want them to freeze, so=
 we
> > must tell them to do so.  Still, if they don't receive the signal, we w=
ant them
> > to stay stopped (IOW, the freezer by itself should not wake them up).
> =

> <--snip-->
> =

> In fact, I really mean that if we want a process to go to the refrigerato=
r, we
> have to set PF_FREEZE for it (otherwise try_to_freeze() won't do anytning=
).
> Thus because we want stopped processes to go to the refrigerator once they
> have received the continuation signal, we have to set PF_FREEZE for them,
> so we should call either freeze_process() or just freeze() for them.
> =

> Now once we have set PF_FREEZE for a stopped process, we shouldn't count
> it as freezeable any more, because we can't do anything more with it.
> Moreover, if the process hasn't received the continuation signal before we
> call freeze_processes(), PF_FREEZE set will still be set for it, so we ha=
ve to
> clear it (otherwise the process would go to the refrigerator as soon as it
> receives the continuation signal).
> =

> Now the question remains if we should call the entire freeze_process() or=
 just
> freeze() for stopped tasks and I think it really doesn't matter.  Still, =
since we
> call recalc_sigpending() in the refrigerator, I think it's reasonable to =
use
> freeze_process() in this case (less lines of code).
> =

> Additionally, we can move the try_to_freeze() in get_signal_to_deliver() =
so
> that processes receiving continuation signals are frozen immediately rath=
er
> than some time later, but this doesn't really change the rest of the patch
> (which follows - untested for now, but I'll test it later today).

Now tested and it doesn't break anything, at least.

Greetings,
Rafael
