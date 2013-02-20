From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/16] blackfin idle: delete pm_idle
Date: Wed, 20 Feb 2013 20:52:18 +0100
Message-ID: <1656351.lki82jZfSs@vostro.rjw.lan>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <8408629d64626937a5202751703dae7f41941f7a.1360475150.git.len.brown@intel.com> <512256A3.6050100@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40402 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934682Ab3BTTpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 14:45:42 -0500
In-Reply-To: <512256A3.6050100@metafoo.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, uclinux-dist-devel@blackfin.uclinux.org

On Monday, February 18, 2013 05:28:19 PM Lars-Peter Clausen wrote:
> On 02/10/2013 06:58 AM, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> >=20
> > pm_idle is dead code on blackfin.
> >=20
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Cc: uclinux-dist-devel@blackfin.uclinux.org
> > ---
> >  arch/blackfin/kernel/process.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >=20
> > diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/=
process.c
> > index 3e16ad9..8061426 100644
> > --- a/arch/blackfin/kernel/process.c
> > +++ b/arch/blackfin/kernel/process.c
> > @@ -39,12 +39,6 @@ int nr_l1stack_tasks;
> >  void *l1_stack_base;
> >  unsigned long l1_stack_len;
> > =20
> > -/*
> > - * Powermanagement idle function, if any..
> > - */
> > -void (*pm_idle)(void) =3D NULL;
> > -EXPORT_SYMBOL(pm_idle);
> > -
> >  void (*pm_power_off)(void) =3D NULL;
> >  EXPORT_SYMBOL(pm_power_off);
> > =20
> > @@ -81,7 +75,6 @@ void cpu_idle(void)
> >  {
> >  	/* endless idle loop with no priority at all */
> >  	while (1) {
> > -		void (*idle)(void) =3D pm_idle;
>=20
> Hi,
>=20
> This results in the following error:
>=20
> arch/blackfin/kernel/process.c: In function =E2=80=98cpu_idle=E2=80=99=
:
> arch/blackfin/kernel/process.c:83: error: =E2=80=98idle=E2=80=99 unde=
clared (first use in
> this function)
> arch/blackfin/kernel/process.c:83: error: (Each undeclared identifier=
 is
> reported only once
> arch/blackfin/kernel/process.c:83: error: for each function it appear=
s in.)
> arch/blackfin/kernel/process.c:88: error: implicit declaration of fun=
ction
> =E2=80=98idle=E2=80=99
>=20
>=20
> This change on top of your patch, fixes it.

Lars, I need your sign-off for the patch below.  May I add it?

Rafael


> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/pr=
ocess.c
> index 8061426..9782c03 100644
> --- a/arch/blackfin/kernel/process.c
> +++ b/arch/blackfin/kernel/process.c
> @@ -80,12 +80,10 @@ void cpu_idle(void)
>  		if (cpu_is_offline(smp_processor_id()))
>  			cpu_die();
>  #endif
> -		if (!idle)
> -			idle =3D default_idle;
>  		tick_nohz_idle_enter();
>  		rcu_idle_enter();
>  		while (!need_resched())
> -			idle();
> +			default_idle();
>  		rcu_idle_exit();
>  		tick_nohz_idle_exit();
>  		preempt_enable_no_resched();
>=20
>=20
> Otherwise the patch seems to work fine.
>=20
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
