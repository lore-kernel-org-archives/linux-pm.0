From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Need help understanding the logic of __cpuidle_set_driver
Date: Thu, 21 Aug 2014 04:04:25 +0200
Message-ID: <53F553A9.7050104@linaro.org>
References: <CAHu9=sOwSuw5igPp0UQWJe8fwMb_vt3PPrc1A9nK4pJB5QmXDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:60728 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaHUCE1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Aug 2014 22:04:27 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so3913826iec.12
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2014 19:04:26 -0700 (PDT)
In-Reply-To: <CAHu9=sOwSuw5igPp0UQWJe8fwMb_vt3PPrc1A9nK4pJB5QmXDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

On 08/15/2014 12:20 PM, Mohammad Merajul Islam Molla wrote:
> Hello,
>
> I was looking into the code of drivers/cpuidle/driver.c. I have some
> doubts regarding the implementation of __cpuidle_set_driver function
> when CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is defined.
>
> If CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is defined, the code for
> __cpuidle_set_driver/__cpuidle_unset_driver looks as -
>
>   39  * __cpuidle_unset_driver - unset per CPU driver variables.
>   40  * @drv: a valid pointer to a struct cpuidle_driver
>   41  *
>   42  * For each CPU in the driver's CPU mask, unset the registered
> driver per CPU
>   43  * variable. If @drv is different from the registered driver, th=
e
> corresponding
>   44  * variable is not cleared.
>   45  */
>   46 static inline void __cpuidle_unset_driver(struct cpuidle_driver =
*drv)
>   47 {
>   48         int cpu;
>   49
>   50         for_each_cpu(cpu, drv->cpumask) {
>   51
>   52                 if (drv !=3D __cpuidle_get_cpu_driver(cpu))
>   53                         continue;
>   54
>   55                 per_cpu(cpuidle_drivers, cpu) =3D NULL;
>   56         }
>   57 }
>   58
>   59 /**
>   60  * __cpuidle_set_driver - set per CPU driver variables for the g=
iven driver.
>   61  * @drv: a valid pointer to a struct cpuidle_driver
>   62  *
>   63  * For each CPU in the driver's cpumask, unset the registered dr=
iver per CPU
>   64  * to @drv.
>   65  *
>   66  * Returns 0 on success, -EBUSY if the CPUs have driver(s) alrea=
dy.
>   67  */
>   68 static inline int __cpuidle_set_driver(struct cpuidle_driver *dr=
v)
>   69 {
>   70         int cpu;
>   71
>   72         for_each_cpu(cpu, drv->cpumask) {
>   73
>   74                 if (__cpuidle_get_cpu_driver(cpu)) {
>   75                         __cpuidle_unset_driver(drv);
>   76                         return -EBUSY;
>   77                 }
>   78
>   79                 per_cpu(cpuidle_drivers, cpu) =3D drv;
>   80         }
>   81
>   82         return 0;
>   83 }
>
> Apparently, the comment should be - "set/register the driver per CPU
> to @drv" instead of "unset the registered driver per CPU to @drv" in
> case of __cpuidle_set_driver.

Right, it is a typo.

> However, regarding the logic, I have a few doubts -
>
> 1. for each cpu in drv->cpumask, if there is already a driver
> registered, its calling __cpuidle_unset_driver which loops over for
> each cpu in drv->cpumask again. Isn't it unnecessary to do this neste=
d
> calls?

It is to rollback the previous changes done in the loop.

> 2. after calling __cpuidle_unset_driver, if drv equals already
> registered driver, it sets per_cpu driver to null? Isn't it wrong whe=
n
> we are trying to set to a new driver? Why do we need to unset and mak=
e
> the driver null when we are returning EBUSY from __cpuidle_set_driver=
?
>
> Would it be correct and cleaner if the code is written as below -
>
>   static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>   {
>           int ret =3D -EBUSY;
>           int cpu;
>
>          for_each_cpu(cpu, drv->cpumask) {
>                  if (drv =3D=3D __cpuidle_get_cpu_driver(cpu))    [if=
 drv
> is already the registered driver, do nothing]
>                           continue;
>
>                   per_cpu(cpuidle_drivers, cpu) =3D drv;  [if only dr=
v !=3D
> already registered driver, set per_cpu driver to drv and set ret 0]
>                   ret =3D 0;
>           }
>
>           return ret;     [only if all cpus already had drv as
> registered driver, return -EBUSY. Otherwise return 0]
>   }
>
>
> Please let me know your views.
>
> --
> Thanks,
> -Meraj
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

