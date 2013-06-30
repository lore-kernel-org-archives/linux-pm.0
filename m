From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Mon, 01 Jul 2013 00:46:03 +0200
Message-ID: <19337614.Mnu5DqParj@vostro.rjw.lan>
References: <51C08370.4050906@gmx.de> <51D06556.7080204@gmx.de> <51D07E7F.2030709@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51D07E7F.2030709@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 01, 2013 12:22:47 AM Srivatsa S. Bhat wrote:
> On 06/30/2013 10:35 PM, Toralf F=C3=B6rster wrote:
> > On 06/30/2013 06:33 PM, Srivatsa S. Bhat wrote:
> >> Toralf, can you please
> >> try out the below patch and see if it improves anything? (Don't re=
vert anything,
> >> just apply the below diff on a problematic kernel and see if it so=
lves your
> >> issue).
> >=20
> > applied on top of a66b2e5 - issue went away (either fixed or hidden=
 now)
> >=20
>=20
> Cool! So here is the proper patch, with changelog added.
>=20
> Regards,
> Srivatsa S. Bhat
>=20
>=20
> ---------------------------------------------------------------------=
--------
>=20
> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Subject: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
>=20
> Toralf F=C3=B6rster reported that the cpufreq ondemand governor behav=
es erratically
> (doesn't scale well) after a suspend/resume cycle. The problem was th=
at the
> cpufreq subsystem's idea of the cpu frequencies differed from the act=
ual
> frequencies set in the hardware after a suspend/resume cycle. Toralf =
bisected
> the problem to commit a66b2e5 (cpufreq: Preserve sysfs files across
> suspend/resume).
>=20
> Among other (harmless) things, that commit skipped the call to
> cpufreq_update_policy() in the resume path. But cpufreq_update_policy=
() plays
> an important role during resume, because it is responsible for checki=
ng if
> the BIOS changed the cpu frequencies behind our back and resynchroniz=
e the
> cpufreq subsystem's knowledge of the cpu frequencies, and update them
> accordingly.
>=20
> So, restore the call to cpufreq_update_policy() in the resume path to=
 fix
> the cpufreq regression.
>=20
> Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> Tested-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Thanks Srivatsa, I'll queue it up as 3.11 (and 3.10-stable) material.

Thanks,
Rafael


> ---
>=20
>  drivers/cpufreq/cpufreq_stats.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufre=
q_stats.c
> index fb65dec..591b6fb 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -349,6 +349,7 @@ static int __cpuinit cpufreq_stat_cpu_callback(st=
ruct notifier_block *nfb,
> =20
>  	switch (action) {
>  	case CPU_ONLINE:
> +	case CPU_ONLINE_FROZEN:
>  		cpufreq_update_policy(cpu);
>  		break;
>  	case CPU_DOWN_PREPARE:
>=20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
