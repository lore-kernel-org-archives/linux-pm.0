From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 14 Aug 2010 12:41:30 +0200
Message-ID: <20100814104130.GA29894__39036.5836480216$1281782629$gmane$org@elf.ucw.cz>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<AANLkTimjfU2zu4reEVdOwWwtFHPQ33_Gna6xS2XHRG-h@mail.gmail.com>
	<20100812125712.48b7fc26@virtuousgeek.org>
	<201008130528.21887.rjw@sisk.pl>
	<AANLkTinMmVdAVaCFXyDZpVRmZ9FCWYhtdeM=o4hdoZnT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinMmVdAVaCFXyDZpVRmZ9FCWYhtdeM=o4hdoZnT@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > =A0Arguably, though, this isn't the only possible way to implement a
> > mechanism allowing the system to be suspended automatically when it app=
ears
> > to be inactive.
> >
> > Namely, one can use a user space power manager for this purpose and act=
ually
> > the OLPC project has been doing that successfully for some time, which =
clearly
> > demonstrates that the Android approach to this problem is not the only =
one
> > possible. =A0Moreover, the kernel's system suspend (or hibernate for th=
at matter)
> > code has not been designed to be started from within the kernel. =A0It'=
s been
> > designed to allow a privileged user space process to request the kernel=
 to
> > put the system into a sleep state at any given time regardless of what =
the
> > other user space processes are doing. =A0While it can be started from w=
ithin the
> > kernel, this isn't particularly nice and, in the Android case, starting=
 it from
> > within the kernel requires permission from multiple user space processes
> > (given by not taking suspend blockers these processes are allowed to us=
e).
> >
> =

> Why is starting suspend from within the kernel not nice? Personally I
> think reentering suspend from within the kernel is nicer than being
> forced to wake up a user space thread for events that are fully
> handled within the kernel (for instance the battery monitor on the
> Nexus One).

For events that are fully handled within the kernel -- like battery
monitor on Zaurus/spitz -- doing wakeup all the way to the userspace
is not neccessary. But that's implementenation detail with no impact
on user/kernel interface, and we are doing that today. (Or were doing
that few releases ago; charging is broken on spitz just now).
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
