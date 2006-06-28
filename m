From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: x86_64 restore_image declaration needs asmlinkage?
Date: Wed, 28 Jun 2006 22:00:32 +1000
Message-ID: <200606282200.36268.ncunningham@linuxmail.org>
References: <200606282048.38746.ncunningham@linuxmail.org> <200606281353.15252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5939733.ATl6dilPFm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423295AbWF1MAj@vger.kernel.org>
In-Reply-To: <200606281353.15252.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

--nextPart5939733.ATl6dilPFm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 28 June 2006 21:53, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday 28 June 2006 12:48, Nigel Cunningham wrote:
> > I received a report of problems with CONFIG_REGPARM and suspending, that
> > led me to recheck asm calls and declarations. Not being a guru on these
> > things, I want to ask advice from those who know more.
> >
> > Along the way I noticed that current git has:
> >
> > extern asmlinkage int swsusp_arch_suspend(void);
> > extern asmlinkage int swsusp_arch_resume(void);
> >
> > This is right for x86, but for x86_64, we actually call a C routine in
> > arch/x86_64/kernel/suspend.c, which calls restore_image in
> > arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c
> > as
> >
> > extern int restore_image(void);
> >
> > should it be:
> >
> > extern asmlinkage int restore_image(void);
> >
> > Having swsusp_arch_resume declared as asmlinkage doesn't matter, does i=
t?
>
> No, it doesn't.  It would have mattered on i386 if the function had taken
> any arguments.  AFAICT, on x86_64 it desn't matter at all.

Right. But what about restore_image lacking the asmlinkage? I'm also wonder=
ing=20
if that does matter.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart5939733.ATl6dilPFm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEom9kN0y+n1M3mo0RAjs7AJ4/q/0+9YrDdjrgTuL1VtSkU03bJwCgxIiC
yc9U85V7tJCbdrT4Y3eZtK4=
=EyaI
-----END PGP SIGNATURE-----

--nextPart5939733.ATl6dilPFm--
