From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Fri, 12 May 2006 12:19:16 +0200
Message-ID: <20060512101916.GC28232@elf.ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz>
	<20060512031151.76a9d226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060512031151.76a9d226.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On P=E1 12-05-06 03:11:51, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > It is very ugly, and we really should use names instead.
> >=20
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> >=20
> > diff --git a/Documentation/feature-removal-schedule.txt b/Documentati=
on/feature-removal-schedule.txt
> > index 421bcff..dfcfc47 100644
> > --- a/Documentation/feature-removal-schedule.txt
> > +++ b/Documentation/feature-removal-schedule.txt
> > @@ -6,6 +6,16 @@ be removed from this file.
> > =20
> >  ---------------------------
> > =20
> > +What:	/sys/device/.../power
> > +When:	July 2007
> > +Files:=09
> > +Why:	Because it takes integers, and different userland applications
> > +	expect different numbers to mean different things.
> > +	(Pcmcia expect 2 for off, some other code expects 3 for off).
> > +Who:	Pavel Machek <pavel@suse.cz>
> > +
> > +---------------------------
>=20
> What will be impacted by this?

Some obscure place PCMCIA utils, IIRC. There was one more user, but I
do not remember who it was. Plus there may be few people doing echo
manually.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
