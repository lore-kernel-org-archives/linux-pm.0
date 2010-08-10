From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 10 Aug 2010 04:53:11 +0200
Message-ID: <201008100453.11958.rjw__23508.8169378743$1281411019$gmane$org@sisk.pl>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
	<201008082117.39082.rjw@sisk.pl>
	<AANLkTimncsuARHeavMCHL4imEOVXMomTJoDQns4-wq5o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimncsuARHeavMCHL4imEOVXMomTJoDQns4-wq5o@mail.gmail.com>
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
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 09, 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/8/8 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/8/7 Arve Hj=F8nnev=E5g <arve@android.com>:
> >> > 2010/8/7 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
> >> >>> 2010/8/6 Alan Stern <stern@rowland.harvard.edu>:
> >> >>> > On Thu, 5 Aug 2010, Arve Hj=F8nnev=E5g wrote:
> >> ...
> >> >>> >> total_time, total time the wake lock has been active. This one =
should
> >> >>> >> be obvious.
> >> >>> >
> >> >>> > Also easily added.
> >> >>> >
> >> >>> Only with a handle passed to all the calls.
> >> >>
> >> >> Well, I'm kind of tired of this "my solution is the only acceptable=
 one"
> >> >> mindset.  IMHO, it's totally counter productive.
> >> >>
> >> >
> >> > How do you propose to track how long a driver has blocked suspend wh=
en
> >> > you have an unblock call that takes no arguments.
> >> >
> >>
> >> Also, I did not not see a response to my question about why you don't
> >> want to pass a handle.
> >
> > It doesn't really matter what I personally want.  In fact, I'm not tota=
lly
> > opposed to that idea, although there are disadvantages (eg. a "handle"
> > would really mean a pointer to an object with certain life cycle that n=
eeds to
> > be managed by the caller and it's not that clear to me who should manag=
e the
> > objects that the PCI wakeup code would pass to pm_wakeup_event(), for o=
ne
> =

> Wouldn't a single global handle work for the way you are handling pci
> wakeup events?

Not really, because I'd like to know the number of wakeups associated with
the given device.

> It looked like you just reset a global timeout every time a pci wakeup ev=
ent
> occurs.

We bump up the per-device counter of wakeup events in addition to that.

> > example).  I sent a pull request for your original patchset to Linus af=
ter all. :-)
> >
> > I said I didn't think "it would fly", meaning that I was afraid the oth=
er kernel
> > developers wouldn't like that change.
> >
> > The reason why I think so is that you'd like to add a whole new infrast=
ructure
> > whose only purpose would be debugging that would only be useful to syst=
ems
> > using opportunistic suspend.  That, however, is only Android right now =
and it
> > cannot use the mainline kernel for other reasons, so basically we would=
 add
> > infrastructure that's useful to no one.
> >
> =

> I'm not sure what you mean by this. The debugging is useful for anyone
> using the api, not just Android, and a handle is also needed to mix
> timeouts and pm_relax.

The purpose of the debugging would be to be able to figure out why the syst=
em
is staying in the working state, which is only relevant for systems that use
opportunistic suspend.

If opportunistic suspend isn't used, it makes sense to ask which
device caused suspend (initiated by the user) to be aborted and for this
purpose it is sufficient to count wakeup events associated with each
device (you need to preserve the pre-suspend values of these counters, but
that can be done by a user space power manager just fine).

> The handle can be the device, but some drivers need several handles per
> device.

That depends on how precise the collected debug information should be and
that, in turn, depends on what it's going to be used for.

Anyway, as I said I'm not opposed to the idea of using a special type of
objects for collecting debug information on wakeup events, so please free to
submit patches modifying the current mainline kernel code in that direction.

Thanks,
Rafael
