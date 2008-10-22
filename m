From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI suspend: Fix CONFIG_ACPI_SLEEP
 dependence and some compilation warnings (was: Re: [announce] new tree:
 "fix all build warnings, on all configs")
Date: Wed, 22 Oct 2008 14:58:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810221458510.3010__27473.5848805451$1224702216$gmane$org@localhost.localdomain>
References: <20081017171139.GA1792@elte.hu> <200810212137.58020.rjw@sisk.pl>
	<alpine.LFD.1.10.0810220008050.2984@localhost.localdomain>
	<200810221423.44216.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_j9WwPo0eWegfJNOkoRV1pA)"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810221423.44216.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_j9WwPo0eWegfJNOkoRV1pA)
Content-type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id m9MIxvtD004465

applied.

thanks,
-Len

On Wed, 22 Oct 2008, Rafael J. Wysocki wrote:

> On Wednesday, 22 of October 2008, Len Brown wrote:
> >=20
> > > >   drivers/acpi/sleep/main.c:67: warning: =E2=80=98acpi_pm_disable=
_gpes=E2=80=99 defined but not used
> >=20
> > > >=20
> > > > Shows that this code has an identity crisis due to a maze of #ifd=
efs, in
> > > > the PM_SLEEP && !SUSPEND && !HIBERNATION case for example.
> > >=20
> > > This case is invalid, because PM_SLEEP =3D=3D SUSPEND || HIBERNATIO=
N !
> >=20
> > I though so too, but 2.6.27 appears to have added XEN to the mix:
> >=20
> > config PM_SLEEP
> >         bool
> >         depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
>=20
> Yeah, which breaks things. :-(
>=20
> The patch below should fix it and BTW I think ACPI_SLEEP should not dep=
end
> on XEN_SAVE_RESTORE anyway, so this is a bug fix really (please conside=
r as
> .28 material, probably -stable too).
>=20
> Thanks,
> Rafael
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> ACPI suspend: Fix CONFIG_ACPI_SLEEP dependence and some compilation war=
nings
>=20
> Initially CONFIG_PM_SLEEP was defined as
> CONFIG_SUSPEND || CONFIG_HIBERNATION and some ACPI code, most
> importantly the code in drivers/acpi/main.c, was written with this
> assumption.  Currently, however, CONFIG_PM_SLEEP is also set when
> CONFIG_XEN_SAVE_RESTORE is set.
>=20
> This causes some compilation warnings to appear in
> drivers/acpi/main.c if both CONFIG_SUSPEND and CONFIG_HIBERNATION
> are unset and CONFIG_PM_SLEEP is set (this was impossible before).
> To fix this problem, redefine CONFIG_ACPI_SLEEP do depend directly
> on CONFIG_SUSPEND || CONFIG_HIBERNATION, as originally intended, and
> use it instead of CONFIG_PM_SLEEP in drivers/acpi/main.c, wherever
> appropriate.
>=20
> Additionally, move the acpi_target_sleep_state definition from under
> the #ifdef to prevent compilation from failing in some cases.=20
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/Kconfig      |    2 +-
>  drivers/acpi/sleep/main.c |    7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> Index: linux-2.6/drivers/acpi/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/Kconfig
> +++ linux-2.6/drivers/acpi/Kconfig
> @@ -42,7 +42,7 @@ if ACPI
> =20
>  config ACPI_SLEEP
>  	bool
> -	depends on PM_SLEEP
> +	depends on SUSPEND || HIBERNATION
>  	default y
> =20
>  config ACPI_PROCFS
> Index: linux-2.6/drivers/acpi/sleep/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/sleep/main.c
> +++ linux-2.6/drivers/acpi/sleep/main.c
> @@ -23,6 +23,7 @@
>  #include "sleep.h"
> =20
>  u8 sleep_states[ACPI_S_STATE_COUNT];
> +static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
> =20
>  static int acpi_sleep_prepare(u32 acpi_state)
>  {
> @@ -45,9 +46,7 @@ static int acpi_sleep_prepare(u32 acpi_s
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM_SLEEP
> -static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
> -
> +#ifdef CONFIG_ACPI_SLEEP
>  /*
>   * ACPI 1.0 wants us to execute _PTS before suspending devices, so we =
allow the
>   * user to request that behavior by using the 'acpi_old_suspend_orderi=
ng'
> @@ -132,7 +131,7 @@ static void acpi_pm_end(void)
>  	 */
>  	acpi_target_sleep_state =3D ACPI_STATE_S0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#endif /* CONFIG_ACPI_SLEEP */
> =20
>  #ifdef CONFIG_SUSPEND
>  extern void do_suspend_lowlevel(void);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--Boundary_(ID_j9WwPo0eWegfJNOkoRV1pA)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--Boundary_(ID_j9WwPo0eWegfJNOkoRV1pA)--
