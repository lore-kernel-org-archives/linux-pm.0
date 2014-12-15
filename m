From: Yadwinder Singh Brar <yadi.brar@samsung.com>
Subject: RE: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 18:58:41 +0530
Message-ID: <002f01d0186b$2700b730$75022590$%brar@samsung.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <7573578.UE8ufgjWuX@vostro.rjw.lan>
 <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16444 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaLON2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 08:28:17 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGM00A48LF30G40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 15 Dec 2014 22:28:15 +0900 (KST)
In-reply-to: <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
Content-language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 'Eduardo Valentin' <edubezval@gmail.com>



> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Monday, December 15, 2014 9:27 AM
> To: Rafael J. Wysocki; yadi.brar@samsung.com
> Cc: Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org;
> linux-pm@vger.kernel.org; Eduardo Valentin
> Subject: Re: 3.18: lockdep problems in cpufreq
>=20
> On 15 December 2014 at 03:53, Rafael J. Wysocki <rjw@rjwysocki.net>
> wrote:
> > On Sunday, December 14, 2014 09:36:55 PM Russell King - ARM Linux
> wrote:
> >> Here's a nice Christmas present one of my iMX6 machines gave me
> tonight.
> >> I haven't begun to look into it.
>=20
> Is the culprit this one?
>=20
> Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq
> policy with thermal constraints")
>=20
> As this is what it changed:
>=20
> @@ -316,21 +312,28 @@ static int cpufreq_thermal_notifier(struct
> notifier_block *nb,  {
>         struct cpufreq_policy *policy =3D data;
>         unsigned long max_freq =3D 0;
> +       struct cpufreq_cooling_device *cpufreq_dev;
>=20
> -       if (event !=3D CPUFREQ_ADJUST || notify_device =3D=3D NOTIFY_=
INVALID)
> +       if (event !=3D CPUFREQ_ADJUST)
>                 return 0;
>=20
> -       if (cpumask_test_cpu(policy->cpu, &notify_device-
> >allowed_cpus))
> -               max_freq =3D notify_device->cpufreq_val;
> -       else
> -               return 0;
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> +               if (!cpumask_test_cpu(policy->cpu,
> +                                       &cpufreq_dev->allowed_cpus))
> +                       continue;
> +
> +               if (!cpufreq_dev->cpufreq_val)
> +                       cpufreq_dev->cpufreq_val =3D get_cpu_frequenc=
y(
> +                                       cpumask_any(&cpufreq_dev-
> >allowed_cpus),
> +                                       cpufreq_dev->cpufreq_state);
>=20
> -       /* Never exceed user_policy.max */
> -       if (max_freq > policy->user_policy.max)
> -               max_freq =3D policy->user_policy.max;
> +               max_freq =3D cpufreq_dev->cpufreq_val;
>=20
> -       if (policy->max !=3D max_freq)
> -               cpufreq_verify_within_limits(policy, 0, max_freq);
> +               if (policy->max !=3D max_freq)
> +                       cpufreq_verify_within_limits(policy, 0,
> max_freq);
> +       }
> +       mutex_unlock(&cooling_cpufreq_lock);
>=20
>         return 0;
>  }
>=20
>=20
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >> [ INFO: possible circular locking dependency detected ] 3.18.0+
> #1453
> >> Not tainted
> >> -------------------------------------------------------
> >> rc.local/770 is trying to acquire lock:
> >>  (cooling_cpufreq_lock){+.+.+.}, at: [<c04abfc4>]
> >> cpufreq_thermal_notifier+0x34/0xfc
> >>
> >> but task is already holding lock:
> >>  ((cpufreq_policy_notifier_list).rwsem){++++.+}, at: [<c0042f04>]
> >> __blocking_notifier_call_chain+0x34/0x68
> >>
> >> which lock already depends on the new lock.
> >
> > Well, that's for Viresh.
>=20
> Maybe not as the rework I have done is queued for this merge window.
> I was afraid really after reading the "offenders" discussion on IRC :=
)
>=20
> Cc'd Yadwinder as well who wrote this patch.

Thanks :).

Unfortunately, I didn=E2=80=99t get any such warning though I tested
patch enabling CONFIG_PROVE_LOCKING before posting. It seems
Russell is trying to load imx_thermal as module and parallely
Changing cpufreq governor from userspace, which was not my
test case.

Anyways, after analyzing log and code,I think problem is not
in cpufreq_thermal_notifier which was modified in patch as
stated above. Actual problem is in __cpufreq_cooling_register
which is unnecessarily calling cpufreq_register_notifier()
inside section protected by cooling_cpufreq_lock.
Because cpufreq_policy_notifier_list).rwsem is already held
by store_scaling_governor when __cpufreq_cooling_register is
trying to cpufreq_policy_notifier_list while holding cooling_cpufreq_lo=
ck.=20

So I think following can fix the problem:

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coolin=
g.c
index ad09e51..622ea40 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -484,15 +484,15 @@ __cpufreq_cooling_register(struct device_node *np=
,
        cpufreq_dev->cpufreq_state =3D 0;
        mutex_lock(&cooling_cpufreq_lock);
=20
-       /* Register the notifier for first cpufreq cooling device */
-       if (cpufreq_dev_count =3D=3D 0)
-               cpufreq_register_notifier(&thermal_cpufreq_notifier_blo=
ck,
-                                         CPUFREQ_POLICY_NOTIFIER);
        cpufreq_dev_count++;
        list_add(&cpufreq_dev->node, &cpufreq_dev_list);
=20
        mutex_unlock(&cooling_cpufreq_lock);
=20
+       /* Register the notifier for first cpufreq cooling device */
+       if (cpufreq_dev_count =3D=3D 0)
+               cpufreq_register_notifier(&thermal_cpufreq_notifier_blo=
ck,
+                                         CPUFREQ_POLICY_NOTIFIER);
        return cool_dev;
 }



Best Regards,
Yadwinder
 =20

