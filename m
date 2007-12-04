From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] HWMON: coretemp, suspend fix
Date: Tue, 4 Dec 2007 20:59:30 +0100
Message-ID: <200712042059.31229.rjw__2093.65872801772$1196797500$gmane$org@sisk.pl>
References: <1196624925-17220-1-git-send-email-lenb@kernel.org>
	<200712031801.51513.rjw@sisk.pl>
	<200712040129.56505.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712040129.56505.lenb@kernel.org>
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
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 4 of December 2007, Len Brown wrote:
> Applied to suspend branch.

Thanks!

BTW, the 4 topmost non-merge commits from the suspend branch are supposed=
 to go
to Linus ASAP.  Any chance to push them upstream?

Rafael

=20
> On Monday 03 December 2007 12:01, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > =A0
> > It's not permitted to unregister a device after devices have been sus=
pended.
> > It causes deadlocks to appear on systems with coretemp hwmon loaded. =
=A0To avoid
> > this, we can make coretemp_cpu_callback() do nothing if the _FROZEN b=
it is set
> > in action.
> > =A0
> > Also, in other cases it's generally too late to unregister the corete=
mp device
> > if the CPU is already dead, so it should be unregistered on CPU_DOWN_=
PREPARE.
> > =A0
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Mark M. Hoffman <mhoffman@lightlink.com>
> > Cc: Jiri Slaby <jirislaby@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  drivers/hwmon/coretemp.c |    5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > Index: linux-2.6/drivers/hwmon/coretemp.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/hwmon/coretemp.c
> > +++ linux-2.6/drivers/hwmon/coretemp.c
> > @@ -337,11 +337,10 @@ static int coretemp_cpu_callback(struct=20
> > =20
> >  	switch (action) {
> >  	case CPU_ONLINE:
> > -	case CPU_ONLINE_FROZEN:
> > +	case CPU_DOWN_FAILED:
> >  		coretemp_device_add(cpu);
> >  		break;
> > -	case CPU_DEAD:
> > -	case CPU_DEAD_FROZEN:
> > +	case CPU_DOWN_PREPARE:
> >  		coretemp_device_remove(cpu);
> >  		break;
> >  	}
> >=20
> >=20
>=20
>=20



--=20
"Premature optimization is the root of all evil." - Donald Knuth
