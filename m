From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Subject: Re: [linux-pm] Linux 2.6.21-rc6
Date: Wed, 25 Apr 2007 22:09:56 +0200
Message-ID: <20070425200956.GA10758@melchior.yamamaya.is-a-geek.org>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org> <200704152154.09212.rjw@sisk.pl> <20070425171409.GA9990@melchior.yamamaya.is-a-geek.org> <200704252136.58470.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2993052AbXDYUKG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200704252136.58470.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.linux-foundation.org, pavel@suse.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 25 April 2007 19:14, Tobias Diedrich wrote:
> > Rafael J. Wysocki wrote:
> > > On Sunday, 15 April 2007 21:40, Tobias Diedrich wrote:
> > > > Rafael J. Wysocki wrote:
> > > > > On Sunday, 15 April 2007 17:14, David Brownell wrote:
> > > > > > On Sunday 15 April 2007 4:16 am, Rafael J. Wysocki wrote:
> > > > > > > On Sunday, 15 April 2007 10:02, Tobias Diedrich wrote:
> > > > > > > I think using the 'shutdown' mode of suspend would be bet=
ter.  There's a little
> > > > > > > point in using 'platform' on desktop systems anyway.
> > > > > > >=20
> > > > > > > Frankly, I don't know what to do about it.  If we move pl=
atform_finish() after
> > > > > > > device_resume(), some systems may be broken ...
> > > > > >=20
> > > > > > What I'm curious about is exactly why the patch matters.  W=
hat ACPI
> > > > > > magic is being invoked to confuse, or unconfuse, those cont=
rollers?
> > > > >=20
> > > > > I think the patch helps, because it makes the ACPI magic be d=
one while the
> > > > > i8042's .resume() is being executed.
> > > > >=20
> > > > > Which makes me think the following patch might help:
> > > >=20
> > > > Unfortunately not, I tried this before disabling CONFIG_SERIO_I=
8042.
> > >=20
> > > Well, this means i8042 can be ruled out, so the problem probably =
is related
> > > to the ACPI resume which makes it _much_ more difficult to debug.
> > >=20
> > > Can you compile the ACPI drivers: processor, thermal, fan, batter=
y, etc. as
> > > modules, boot the kernel with init=3D/bin/bash and see if the pro=
blem is still
> > > present (please keep CONFIG_SERIO_I8042 unset just in case)?
> > >=20
> > > Rafael
> >=20
> > I first tried it with acpi+cpufreq completely disabled (works).
> > Then I tried it with acpi enabled, but everything as modules and
> > those not loaded (init=3D/bin/bash, hangs at second suspend).
>=20
> Have you tried with ACPI and without cpufreq?

Yes, the second one was with ACPI enabled and cpufreq disabled
(CONFIG_X86_ACPI_CPUFREQ is not set).

--=20
Tobias						PGP: http://9ac7e0bc.uguu.de
=E3=81=93=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E5=8D=81=E5=89=B2=
=E5=86=8D=E5=88=A9=E7=94=A8=E3=81=95=E3=82=8C=E3=81=9F=E3=83=93=E3=83=83=
=E3=83=88=E3=81=A7=E4=BD=9C=E3=82=89=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E3=80=82
