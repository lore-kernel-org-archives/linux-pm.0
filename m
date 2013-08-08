From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Thu, 08 Aug 2013 18:00:24 +0200
Message-ID: <5203C098.9000701@linaro.org>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com> <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34570 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3HHQAT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2013 12:00:19 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so2767065wgh.30
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2013 09:00:17 -0700 (PDT)
In-Reply-To: <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

On 08/07/2013 01:43 PM, Lorenzo Pieralisi wrote:
> The big.LITTLE architecture is composed of two clusters of cpus. One =
cluster
> contains less powerful but more energy efficient processors and the o=
ther
> cluster groups the powerful but energy-intensive cpus.
>=20
> The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters=
 in
> a big.LITTLE configuration) connected through a CCI interconnect that=
 manages
> coherency of their respective L2 caches and intercluster distributed
> virtual memory messages (DVM).
>=20
> TC2 testchip integrates a power controller that manages cores resets,=
 wake-up
> IRQs and cluster low-power states. Power states are managed at cluste=
r
> level, which means that voltage is removed from a cluster iff all cor=
es
> in a cluster are in a wfi state. Single cores can enter a reset state
> which is identical to wfi in terms of power consumption but simplifie=
s the
> way cluster states are entered.
>=20
> This patch provides a multiple driver CPU idle implementation for TC2
> which paves the way for a generic big.LITTLE idle driver for all
> upcoming big.LITTLE based systems on chip.
>=20
> The driver relies on the MCPM infrastructure to coordinate and manage
> core power states; in particular MCPM allows to suspend specific core=
s
> and hides the CPUs coordination required to shut-down clusters of CPU=
s.
>=20
> Power down sequences for the respective clusters are implemented in t=
he
> MCPM TC2 backend, with all code needed to clean caches and exit coher=
ency.
>=20
> The multiple driver CPU idle infrastructure allows to define differen=
t
> C-states for big and little cores, determined at boot by checking the
> part id of the possible CPUs and initializing the respective logical
> masks in the big and little drivers.
>=20
> Current big.little systems are composed of A7 and A15 clusters, as
> implemented in TC2, but in the future that may change and the driver
> will have evolve to retrieve what is a 'big' cpu and what is a 'littl=
e'
> cpu in order to build the correct topology.
>=20
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---

A nit below :/

[ ... ]

> +
> +static struct cpuidle_driver bl_idle_big_driver =3D {
> +	.name =3D "big_idle",
> +	.owner =3D THIS_MODULE,
> +	.states[0] =3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1] =3D {
> +		.enter			=3D bl_enter_powerdown,
> +
> +		.exit_latency		=3D 500,

Extra line between enter and exit_latency.

> +		.target_residency	=3D 2000,
> +		.flags			=3D CPUIDLE_FLAG_TIME_VALID |
> +					  CPUIDLE_FLAG_TIMER_STOP,
> +		.name			=3D "C1",
> +		.desc			=3D "ARM big-cluster power down",
> +	},
> +	.state_count =3D 2,
> +};

Thanks
  -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

