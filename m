From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Subject: Re: Linux 2.6.21-rc6
Date: Sat, 14 Apr 2007 14:31:54 +0200
Message-ID: <20070414123154.GA2863@melchior.yamamaya.is-a-geek.org>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org> <20070413212954.GA2545@melchior.yamamaya.is-a-geek.org> <20070413235017.GR5907@stusta.de> <20070414120900.GA3001@melchior.yamamaya.is-a-geek.org> <20070414122447.GA2827@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932279AbXDNMcJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070414122447.GA2827@melchior.yamamaya.is-a-geek.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.osdl.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Tobias Diedrich wrote:
> > ed746e3b18f4df18afa3763155972c5835f284c5 is first bad commit
> > commit ed746e3b18f4df18afa3763155972c5835f284c5
> > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > Date:   Sat Feb 10 01:43:32 2007 -0800
> >=20
> >     [PATCH] swsusp: Change code ordering in disk.c
> >    =20
> >     Change the ordering of code in kernel/power/disk.c so that devi=
ce_suspend() is
> >     called before disable_nonboot_cpus() and platform_finish() is c=
alled after
> >     enable_nonboot_cpus() and before device_resume(), as indicated =
by the recent
> >     discussion on Linux-PM (cf.
> >     http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.h=
tml).
> >    =20
> >     The changes here only affect the built-in swsusp.
> >    =20
> >     [alexey.y.starikovskiy@linux.intel.com: fix LED blinking during=
 image load]
> >     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >     Acked-by: Pavel Machek <pavel@ucw.cz>
> >     Cc: Greg KH <greg@kroah.com>
> >     Cc: Nigel Cunningham <nigel@suspend2.net>
> >     Cc: Patrick Mochel <mochel@digitalimplant.org>
> >     Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> >=20
> > :040000 040000 7eca5b3a8f9606bc4f2ff41192ec8c9d4ca90d18 8313b674e1d=
1bdf6849350af06d28a89b3bb3054 M      kernel
> >=20
> >=20
> > Now, the remaining test is to try reverting this commit from -rc6. =
:)
>=20
> Doesn't apply cleanly against -rc6, but fixes the problem when
> reverted from -rc1.

Now, this was already reported in
http://lkml.org/lkml/2007/3/16/126
and I even flagged that message in my local folder, but apparently forg=
ot
to follow up on it... *sigh*

--=20
Tobias						PGP: http://9ac7e0bc.uguu.de
=E3=81=93=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E5=8D=81=E5=89=B2=
=E5=86=8D=E5=88=A9=E7=94=A8=E3=81=95=E3=82=8C=E3=81=9F=E3=83=93=E3=83=83=
=E3=83=88=E3=81=A7=E4=BD=9C=E3=82=89=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E3=80=82
