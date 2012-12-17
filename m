From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [regression] cpuidle_get_cpu_driver livelocks idle system
Date: Mon, 17 Dec 2012 22:59:09 +0100
Message-ID: <50CF95AD.8030406@linaro.org>
References: <20121217193612.GA28600@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35042 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab2LQV7L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Dec 2012 16:59:11 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3537900eek.19
        for <linux-pm@vger.kernel.org>; Mon, 17 Dec 2012 13:59:10 -0800 (PST)
In-Reply-To: <20121217193612.GA28600@sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russ Anderson <rja@sgi.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Sivaram Nair <sivaramn@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shuox.liu@intel.com" <shuox.liu@intel.com>, "yanmin_zhang@intel.com" <yanmin_zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/17/2012 08:36 PM, Russ Anderson wrote:
> The 3.7 kernel grinds to a halt on boot of a system with
> 2048 cpus.  NMI showed most of the cpus in
> _raw_spin_lock in cpuidle_get_cpu_driver().  (backtrace below)
>=20
> A quick look at cpuidle_get_cpu_driver() shows the hot lock.
>=20
> In drivers/cpuidle/driver.c:
> --------------------------------------------------------
> /**
>  * cpuidle_get_cpu_driver - return the driver tied with a cpu
>  */
> struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *=
dev)
> {
>         struct cpuidle_driver *drv;
>=20
>         if (!dev)
>                 return NULL;
>=20
>         spin_lock(&cpuidle_driver_lock);
>         drv =3D __cpuidle_get_cpu_driver(dev->cpu);
>         spin_unlock(&cpuidle_driver_lock);
>=20
>         return drv;
> }
> --------------------------------------------------------

Hi Russ,

thanks for investigating the problem. You are right, there is a
bottleneck here.

Regarding how is used the cpuidle code, I think it is safe to remove th=
e
locks.



> This change was added in on Nov 14th, 2012.
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dco=
mmit;h=3Dbf4d1b5ddb78f86078ac6ae0415802d5f0c68f92
>=20
> The patch says it adds support for cpus with different characteristic=
s,
> but adds a big global lock.  The comment claims "no impact for the ot=
her
> platforms if the option is disabled", which leads me to believe the
> spin_lock was added inadvertently.  CPU_IDLE_MULTIPLE_DRIVERS is off
> in my config file.
>=20
> linux$ grep CPU_IDLE_MULTIPLE_DRIVERS .config
> # CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
>=20
> As more cpus become idle, more cpus fight over the lock until
> the system livelocks on the crushing weight of idle.
>=20
> The fix may be to move the spin_lock into __cpuidle_get_cpu_driver,
> which has different versions for CONFIG_CPU_IDLE_MULTIPLE_DRIVERS,
> to avoid impacting the disabled case, or get rid of the spin_lock
> all together.
>=20
>=20
> --------------------------------------------------------
> =3D=3D UV NMI process trace cpu 12: =3D=3D
> CPU 12
> Pid: 0, comm: swapper/12 Tainted: G           O 3.7.0.rja-sgi+ #38
> RIP: 0010:[<ffffffff81614e45>]  [<ffffffff81614e45>] _raw_spin_lock+0=
x25/0x30
> [...]
> Call Trace:
>  [<ffffffff814c891c>] cpuidle_get_cpu_driver+0x1c/0x30
>  [<ffffffff814c871d>] cpuidle_idle_call+0x7d/0x1b0
>  [<ffffffff8101d08d>] cpu_idle+0xdd/0x130
>  [<ffffffff8160a3ea>] start_secondary+0xc6/0xcc
> --------------------------------------------------------
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

