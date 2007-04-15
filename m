From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Subject: Re: [linux-pm] Linux 2.6.21-rc6
Date: Sun, 15 Apr 2007 21:40:24 +0200
Message-ID: <20070415194023.GA2538@melchior.yamamaya.is-a-geek.org>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org> <200704151316.26136.rjw@sisk.pl> <200704150814.01747.david-b@pacbell.net> <200704151837.40756.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753413AbXDOTk1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200704151837.40756.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.linux-foundation.org, pavel@suse.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Sunday, 15 April 2007 17:14, David Brownell wrote:
> > On Sunday 15 April 2007 4:16 am, Rafael J. Wysocki wrote:
> > > On Sunday, 15 April 2007 10:02, Tobias Diedrich wrote:
> >=20
> > > > > > > Yes, it's a Asus M2N-SLI-Deluxe Mainboard with a Athlon64=
 3200+
> > > > > > > single core CPU.
> >=20
> > And NVidia southbridge, so OHCI not UHCI (plus EHCI) ... one experi=
ment
> > would be to disable the EHCI (high speed USB) support in BIOS, to m=
ake
> > for a simpler hardware configuration, and see if that makes BIOS ha=
ppier.
> > (Or better, just take EHCI out of your Linux config.)  Likewise, ta=
king
> > the 8042 drivers out of Linux.
> >=20
> > I wouldn't be surprised if those factors didn't matter, but it'd be=
 good
> > to rule them out.
>=20
> I think the disabling of i8042 support might help.

Still hangs with "# CONFIG_SERIO_I8042 is not set".

> > > Dmitry, could you please have a look?
> > >=20
> > > > And I can now confirm that unpatched 2.6.21-rc6 works fine as l=
ong
> > > > as USB legacy support is disabled (however without legacy suppo=
rt I
> > > > can't use the USB keyboard to control grub).
> > >=20
> > > I think using the 'shutdown' mode of suspend would be better.  Th=
ere's a little
> > > point in using 'platform' on desktop systems anyway.
> > >=20
> > > Frankly, I don't know what to do about it.  If we move platform_f=
inish() after
> > > device_resume(), some systems may be broken ...
> >=20
> > What I'm curious about is exactly why the patch matters.  What ACPI
> > magic is being invoked to confuse, or unconfuse, those controllers?
>=20
> I think the patch helps, because it makes the ACPI magic be done whil=
e the
> i8042's .resume() is being executed.
>=20
> Which makes me think the following patch might help:

Unfortunately not, I tried this before disabling CONFIG_SERIO_I8042.

>  drivers/input/serio/i8042.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Index: linux-2.6.21-rc6/drivers/input/serio/i8042.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-rc6.orig/drivers/input/serio/i8042.c	2007-04-07 12:1=
5:19.000000000 +0200
> +++ linux-2.6.21-rc6/drivers/input/serio/i8042.c	2007-04-15 18:30:01.=
000000000 +0200
> @@ -846,7 +846,8 @@ static long i8042_panic_blink(long count
>  static int i8042_suspend(struct platform_device *dev, pm_message_t s=
tate)
>  {
>  	if (dev->dev.power.power_state.event !=3D state.event) {
> -		if (state.event =3D=3D PM_EVENT_SUSPEND)
> +		if (state.event =3D=3D PM_EVENT_SUSPEND
> +		    || state.event =3D=3D PM_EVENT_PRETHAW)
>  			i8042_controller_reset();
> =20
>  		dev->dev.power.power_state =3D state;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Tobias						PGP: http://9ac7e0bc.uguu.de
=E3=81=93=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E5=8D=81=E5=89=B2=
=E5=86=8D=E5=88=A9=E7=94=A8=E3=81=95=E3=82=8C=E3=81=9F=E3=83=93=E3=83=83=
=E3=83=88=E3=81=A7=E4=BD=9C=E3=82=89=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E3=80=82
