From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] blackfin idle: Fix compile error
Date: Thu, 21 Feb 2013 17:24:05 +0100
Message-ID: <4371891.o6DvZ68ieT@vostro.rjw.lan>
References: <1449748.lzaK5NRLYV@vostro.rjw.lan> <1361440603-7209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40877 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab3BUQR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 11:17:29 -0500
In-Reply-To: <1361440603-7209-1-git-send-email-lars@metafoo.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Thursday, February 21, 2013 10:56:43 AM Lars-Peter Clausen wrote:
> Commit 26bab0c ("blackfin idle: delete pm_idle") introduced the follo=
wing
> compile error:
> 	arch/blackfin/kernel/process.c: In function =E2=80=98cpu_idle=E2=80=99=
:
> 	arch/blackfin/kernel/process.c:83: error: =E2=80=98idle=E2=80=99 und=
eclared (first use in this function)
> 	arch/blackfin/kernel/process.c:83: error: (Each undeclared identifie=
r is reported only once
> 	arch/blackfin/kernel/process.c:83: error: for each function it appea=
rs in.)
> 	arch/blackfin/kernel/process.c:88: error: implicit declaration of fu=
nction =E2=80=98idle=E2=80=99
>=20
> This patch fixes it.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to linux-pm.git/linux-next, I'm going to push it to Linus later=
 this
week.

Thanks,
Rafael


> ---
>  arch/blackfin/kernel/process.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
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
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
