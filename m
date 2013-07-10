From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Wed, 10 Jul 2013 22:50:02 +0200
Message-ID: <51DDC8FA.4020609@gmx.de>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D07E7F.2030709@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:62382 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab3GJUuM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Jul 2013 16:50:12 -0400
In-Reply-To: <51D07E7F.2030709@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

I tested the patch several times on top of a66b2e5 - the origin issue i=
s
fixed but - erratically another issue now appears : all 4 cores are run=
s
after wakeup at 2.6 GHz.
The temporary hot fix is to switch between governor performance and
ondemand for all 4 cores.


On 06/30/2013 08:52 PM, Srivatsa S. Bhat wrote:
> On 06/30/2013 10:35 PM, Toralf F=C3=B6rster wrote:
>> On 06/30/2013 06:33 PM, Srivatsa S. Bhat wrote:
>>> Toralf, can you please
>>> try out the below patch and see if it improves anything? (Don't rev=
ert anything,
>>> just apply the below diff on a problematic kernel and see if it sol=
ves your
>>> issue).
>>
>> applied on top of a66b2e5 - issue went away (either fixed or hidden =
now)
>>
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
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
