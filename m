From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/16] blackfin idle: delete pm_idle
Date: Mon, 18 Feb 2013 17:28:19 +0100
Message-ID: <512256A3.6050100@metafoo.de>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <8408629d64626937a5202751703dae7f41941f7a.1360475150.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8408629d64626937a5202751703dae7f41941f7a.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-pm@vger.kernel.org

On 02/10/2013 06:58 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> pm_idle is dead code on blackfin.
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> ---
>  arch/blackfin/kernel/process.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/pr=
ocess.c
> index 3e16ad9..8061426 100644
> --- a/arch/blackfin/kernel/process.c
> +++ b/arch/blackfin/kernel/process.c
> @@ -39,12 +39,6 @@ int nr_l1stack_tasks;
>  void *l1_stack_base;
>  unsigned long l1_stack_len;
> =20
> -/*
> - * Powermanagement idle function, if any..
> - */
> -void (*pm_idle)(void) =3D NULL;
> -EXPORT_SYMBOL(pm_idle);
> -
>  void (*pm_power_off)(void) =3D NULL;
>  EXPORT_SYMBOL(pm_power_off);
> =20
> @@ -81,7 +75,6 @@ void cpu_idle(void)
>  {
>  	/* endless idle loop with no priority at all */
>  	while (1) {
> -		void (*idle)(void) =3D pm_idle;

Hi,

This results in the following error:

arch/blackfin/kernel/process.c: In function =91cpu_idle=92:
arch/blackfin/kernel/process.c:83: error: =91idle=92 undeclared (first =
use in
this function)
arch/blackfin/kernel/process.c:83: error: (Each undeclared identifier i=
s
reported only once
arch/blackfin/kernel/process.c:83: error: for each function it appears =
in.)
arch/blackfin/kernel/process.c:88: error: implicit declaration of funct=
ion
=91idle=92


This change on top of your patch, fixes it.

diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/proc=
ess.c
index 8061426..9782c03 100644
--- a/arch/blackfin/kernel/process.c
+++ b/arch/blackfin/kernel/process.c
@@ -80,12 +80,10 @@ void cpu_idle(void)
 		if (cpu_is_offline(smp_processor_id()))
 			cpu_die();
 #endif
-		if (!idle)
-			idle =3D default_idle;
 		tick_nohz_idle_enter();
 		rcu_idle_enter();
 		while (!need_resched())
-			idle();
+			default_idle();
 		rcu_idle_exit();
 		tick_nohz_idle_exit();
 		preempt_enable_no_resched();


Otherwise the patch seems to work fine.

- Lars
