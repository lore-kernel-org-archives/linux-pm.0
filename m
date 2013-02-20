From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/16] blackfin idle: delete pm_idle
Date: Wed, 20 Feb 2013 20:59:39 +0100
Message-ID: <1759773.UdmLmFNAfS@vostro.rjw.lan>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <1656351.lki82jZfSs@vostro.rjw.lan> <512529C2.4050909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40411 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934450Ab3BTTxC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 14:53:02 -0500
In-Reply-To: <512529C2.4050909@metafoo.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, uclinux-dist-devel@blackfin.uclinux.org

On Wednesday, February 20, 2013 08:53:38 PM Lars-Peter Clausen wrote:
> On 02/20/2013 08:52 PM, Rafael J. Wysocki wrote:
> > On Monday, February 18, 2013 05:28:19 PM Lars-Peter Clausen wrote:
> >> On 02/10/2013 06:58 AM, Len Brown wrote:
> >>> From: Len Brown <len.brown@intel.com>
> >>>
> >>> pm_idle is dead code on blackfin.
> >>>
> >>> Signed-off-by: Len Brown <len.brown@intel.com>
> >>> Cc: uclinux-dist-devel@blackfin.uclinux.org
> >>> ---
> >>>  arch/blackfin/kernel/process.c | 7 -------
> >>>  1 file changed, 7 deletions(-)
> >>>
> >>> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kerne=
l/process.c
> >>> index 3e16ad9..8061426 100644
> >>> --- a/arch/blackfin/kernel/process.c
> >>> +++ b/arch/blackfin/kernel/process.c
> >>> @@ -39,12 +39,6 @@ int nr_l1stack_tasks;
> >>>  void *l1_stack_base;
> >>>  unsigned long l1_stack_len;
> >>> =20
> >>> -/*
> >>> - * Powermanagement idle function, if any..
> >>> - */
> >>> -void (*pm_idle)(void) =3D NULL;
> >>> -EXPORT_SYMBOL(pm_idle);
> >>> -
> >>>  void (*pm_power_off)(void) =3D NULL;
> >>>  EXPORT_SYMBOL(pm_power_off);
> >>> =20
> >>> @@ -81,7 +75,6 @@ void cpu_idle(void)
> >>>  {
> >>>  	/* endless idle loop with no priority at all */
> >>>  	while (1) {
> >>> -		void (*idle)(void) =3D pm_idle;
> >>
> >> Hi,
> >>
> >> This results in the following error:
> >>
> >> arch/blackfin/kernel/process.c: In function =E2=80=98cpu_idle=E2=80=
=99:
> >> arch/blackfin/kernel/process.c:83: error: =E2=80=98idle=E2=80=99 u=
ndeclared (first use in
> >> this function)
> >> arch/blackfin/kernel/process.c:83: error: (Each undeclared identif=
ier is
> >> reported only once
> >> arch/blackfin/kernel/process.c:83: error: for each function it app=
ears in.)
> >> arch/blackfin/kernel/process.c:88: error: implicit declaration of =
function
> >> =E2=80=98idle=E2=80=99
> >>
> >>
> >> This change on top of your patch, fixes it.
> >=20
> > Lars, I need your sign-off for the patch below.  May I add it?
> >=20
> > Rafael
>=20
> Sure, I didn't realize the patches had already been merged, otherwise=
 I'd have
> sent a proper patch.

Please do now, if you can.  Sorry for the trouble.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
