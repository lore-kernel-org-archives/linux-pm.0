From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / clk: Fix broken build due to non-matching code and
 header #ifdefs
Date: Mon, 19 Oct 2015 10:48:53 +0200
Message-ID: <20151019084853.GA12164@amd>
References: <1445242567-24032-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445242567-24032-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Ungerer <gerg@uclinux.org>, linux-pm@vger.kernel.org, linux-m68kvger.kernel.org@ramsan.of.borg, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2015-10-19 10:16:07, Geert Uytterhoeven wrote:
> If an architecture's main Kconfig file doesn't include
> kernel/power/Kconfig, but CONFIG_PM=3Dy and HAVE_CLK=3Dy (e.g. m68kno=
mmu
> allmodconfig):
>=20
>     drivers/base/power/clock_ops.c: In function =E2=80=98__pm_clk_add=
=E2=80=99:
>     drivers/base/power/clock_ops.c:106: error: =E2=80=98struct pm_sub=
sys_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
>     drivers/base/power/clock_ops.c: At top level:
>     drivers/base/power/clock_ops.c:120: error: redefinition of =E2=80=
=98pm_clk_add=E2=80=99
>     include/linux/pm_clock.h:64: error: previous definition of =E2=80=
=98pm_clk_add=E2=80=99 was here
>     drivers/base/power/clock_ops.c:135: error: redefinition of =E2=80=
=98pm_clk_add_clk=E2=80=99
>     include/linux/pm_clock.h:69: error: previous definition of =E2=80=
=98pm_clk_add_clk=E2=80=99 was here
>     drivers/base/power/clock_ops.c:171: error: redefinition of =E2=80=
=98pm_clk_remove=E2=80=99
>     include/linux/pm_clock.h:73: error: previous definition of =E2=80=
=98pm_clk_remove=E2=80=99 was here
>     drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_remov=
e=E2=80=99:
>     drivers/base/power/clock_ops.c:180: error: =E2=80=98struct pm_sub=
sys_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
>     drivers/base/power/clock_ops.c:180: error: =E2=80=98struct pm_sub=
sys_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
>     drivers/base/power/clock_ops.c: At top level:
>     drivers/base/power/clock_ops.c:207: error: redefinition of =E2=80=
=98pm_clk_init=E2=80=99
>     include/linux/pm_clock.h:54: error: previous definition of =E2=80=
=98pm_clk_init=E2=80=99 was here
>     drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_init=E2=
=80=99:
>     drivers/base/power/clock_ops.c:210: error: =E2=80=98struct pm_sub=
sys_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
>     drivers/base/power/clock_ops.c: At top level:
>     drivers/base/power/clock_ops.c:221: error: redefinition of =E2=80=
=98pm_clk_create=E2=80=99
>     include/linux/pm_clock.h:57: error: previous definition of =E2=80=
=98pm_clk_create=E2=80=99 was here
>     drivers/base/power/clock_ops.c:234: error: redefinition of =E2=80=
=98pm_clk_destroy=E2=80=99
>     include/linux/pm_clock.h:61: error: previous definition of =E2=80=
=98pm_clk_destroy=E2=80=99 was here
>     drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_destr=
oy=E2=80=99:
>     drivers/base/power/clock_ops.c:246: error: =E2=80=98struct pm_sub=
sys_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
>     drivers/base/power/clock_ops.c:246: error: =E2=80=98struct pm_sub=
sys_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
>     drivers/base/power/clock_ops.c: At top level:
>     drivers/base/power/clock_ops.c:263: error: expected identifier or=
 =E2=80=98(=E2=80=99 before =E2=80=98void=E2=80=99
>     drivers/base/power/clock_ops.c:263: error: expected =E2=80=98)=E2=
=80=99 before numeric constant
>     drivers/base/power/clock_ops.c:293: error: expected identifier or=
 =E2=80=98(=E2=80=99 before =E2=80=98void=E2=80=99
>     drivers/base/power/clock_ops.c:293: error: expected =E2=80=98)=E2=
=80=99 before numeric constant
>     drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_runti=
me_suspend=E2=80=99:
>     drivers/base/power/clock_ops.c:384: error: called object =E2=80=98=
0u=E2=80=99 is not a function
>     drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_runti=
me_resume=E2=80=99:
>     drivers/base/power/clock_ops.c:400: error: called object =E2=80=98=
0u=E2=80=99 is not a function
>=20
> This happens because:
>   - drivers/base/power/clock_ops.c depends on CONFIG_HAVE_CLK,
>   - the failing code inside clock_ops.c additionally depends on
>     CONFIG_PM,
>   - the forward declarations and other definitions in <linux/pm_clock=
=2Eh>
>     depend on CONFIG_PM_CLK,
>   - CONFIG_PM_CLK is defined as PM && HAVE_CLK in kernel/power/Kconfi=
g,
>     but it is not included on all architectures.
>=20
> Fix this by protecting the failing code inside clock_ops.c by
> CONFIG_PM_CLK instead of CONFIG_PM, so it matches <linux/pm_clock.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
