From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 00:04:44 +0200
Message-ID: <20070705220444.GD3881__15485.3190914311$1183673158$gmane$org@elf.ucw.cz>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070705091801.GB3084@elf.ucw.cz>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > > I have discussed the benefits elsewhere. =A0As for the deadlo=
cks -- do=20
> > > > > > you still observe them if you use the version of the freezer =
which=20
> > > > > > doesn't freeze kernel threads?
> > > > >=20
> > > > > In general the only way to guarantee there are no deadlocks is =
to
> > > > > construct the graph of dependencies between tasks. =A0Those dep=
endencies
> > > > > are not in practice observable from outside the tasks, so it is
> > > > > virtually impossible to construct the graph.
> > > >=20
> > > > In which way can user space tasks depend on each other in a way t=
hat
> > > > allows a them members of that cycle to be in uninterruptible slee=
p?
> > >=20
> > >  - process A calls rename() on a fuse fs
> > >  - process B, the fuse server, starts to process the rename request
> > >  - process B is frozen before it can reply
> > >=20
> > > Now process A is unfreezable.  We cannot make rename() restartable,
> > > hence it cannot be interruptible.
> >=20
> > Yes, we are claiming fuse is very special in this regard, and perhaps
> > even broken.
> >=20
> > Let's see. If I SIGSTOP the fuse server, I can get unrelated tasks
> > unkillable (even for SIGKILL!) forever.
>=20
> Actually fuse allows SIGKILL, because it's always fatal, and the
> syscall may not be restarted.

Okay, and you should handle refrigerator in the same paths where you
handle SIGKILL. Just add try_to_freeze() there...
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
