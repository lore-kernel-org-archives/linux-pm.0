From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 4/7] Freezer: Introduce
	freezer-firendly waiting macros
Date: Thu, 12 Jul 2007 12:33:14 +0200
Message-ID: <200707121233.15239.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl> <200707120013.32672.rjw@sisk.pl>
	<20070711225636.GC11127@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070711225636.GC11127@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 12 July 2007 00:56, Pavel Machek wrote:
> Hi!
>=20
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >=20
> > Introduce freezer-friendly wrappers around wait_event_interruptible()=
 and
> > wait_event_interruptible_timeout(), originally defined in <linux/wait=
.h>, to
> > be used in freezable kernel threads. =A0Make some of the freezable ke=
rnel threads
> > use them.
> >=20
> > This is necessary for the freezer to stop sending signals to kernel t=
hreads,
> > which is implemented in the next patch.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> ACK, but...
>=20
> > +/*
> > + * Freezer-friendly wrappers around wait_event_interruptible() and
> > + * wait_event_interruptible_timeout(), originally defined in <linux/=
wait.h>
> > + */
> > +
> > +#define wait_event_freezable(wq, condition)				\
> > +({									\
> > +	int __ret;							\
> > +	do {								\
> > +		__ret =3D wait_event_interruptible(wq, 			\
> > +				(condition) || freezing(current));	\
> > +		try_to_freeze();					\
> > +	} while (!(condition));					\
> > +	__ret;								\
> > +})
>=20
> ...
>=20
> > Index: linux-2.6.22-rc6-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.22-rc6-mm1.orig/drivers/media/dvb/dvb-core/dvb_frontend=
.c	2007-07-11 20:48:04.000000000 +0200
> > +++ linux-2.6.22-rc6-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c	20=
07-07-11 20:51:14.000000000 +0200
> > @@ -528,7 +528,8 @@ static int dvb_frontend_thread(void *dat
> >  		up(&fepriv->sem);	    /* is locked when we enter the thread... */
> >  restart:
> >  		timeout =3D wait_event_interruptible_timeout(fepriv->wait_queue,
> > -			dvb_frontend_should_wakeup(fe) || kthread_should_stop(),
> > +			dvb_frontend_should_wakeup(fe) || kthread_should_stop()
> > +				|| freezing(current),
> >  			fepriv->delay);
>=20
> Should this use the new helper? This change does not seem to match the =
rest.

Yes, because it uses something like the new helper already, but with some=
 code
in between., so I decided to add the freezing(current) only to it.

BTW, please see the updated patch in the reply to Oleg (the macros have b=
een
fixed).

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
