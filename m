From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Fri, 09 Aug 2013 15:45:50 +0200
Message-ID: <5204F28E.1050204@linaro.org>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com> <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com> <5203C098.9000701@linaro.org> <20130808161826.GB3742@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:59186 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967741Ab3HINpo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 09:45:44 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so3618488wgh.30
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 06:45:42 -0700 (PDT)
In-Reply-To: <20130808161826.GB3742@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

On 08/08/2013 06:18 PM, Lorenzo Pieralisi wrote:
> On Thu, Aug 08, 2013 at 05:00:24PM +0100, Daniel Lezcano wrote:
>> On 08/07/2013 01:43 PM, Lorenzo Pieralisi wrote:
>>> The big.LITTLE architecture is composed of two clusters of cpus. On=
e cluster
>>> contains less powerful but more energy efficient processors and the=
 other
>>> cluster groups the powerful but energy-intensive cpus.
>>>
>>> The TC2 testchip implements two clusters of CPUs (A7 and A15 cluste=
rs in
>>> a big.LITTLE configuration) connected through a CCI interconnect th=
at manages
>>> coherency of their respective L2 caches and intercluster distribute=
d
>>> virtual memory messages (DVM).
>>>
>>> TC2 testchip integrates a power controller that manages cores reset=
s, wake-up
>>> IRQs and cluster low-power states. Power states are managed at clus=
ter
>>> level, which means that voltage is removed from a cluster iff all c=
ores
>>> in a cluster are in a wfi state. Single cores can enter a reset sta=
te
>>> which is identical to wfi in terms of power consumption but simplif=
ies the
>>> way cluster states are entered.
>>>
>>> This patch provides a multiple driver CPU idle implementation for T=
C2
>>> which paves the way for a generic big.LITTLE idle driver for all
>>> upcoming big.LITTLE based systems on chip.
>>>
>>> The driver relies on the MCPM infrastructure to coordinate and mana=
ge
>>> core power states; in particular MCPM allows to suspend specific co=
res
>>> and hides the CPUs coordination required to shut-down clusters of C=
PUs.
>>>
>>> Power down sequences for the respective clusters are implemented in=
 the
>>> MCPM TC2 backend, with all code needed to clean caches and exit coh=
erency.
>>>
>>> The multiple driver CPU idle infrastructure allows to define differ=
ent
>>> C-states for big and little cores, determined at boot by checking t=
he
>>> part id of the possible CPUs and initializing the respective logica=
l
>>> masks in the big and little drivers.
>>>
>>> Current big.little systems are composed of A7 and A15 clusters, as
>>> implemented in TC2, but in the future that may change and the drive=
r
>>> will have evolve to retrieve what is a 'big' cpu and what is a 'lit=
tle'
>>> cpu in order to build the correct topology.
>>>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> Cc: Amit Kucheria <amit.kucheria@linaro.org>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> ---
>>
>> A nit below :/
>>
>> [ ... ]
>>
>>> +
>>> +static struct cpuidle_driver bl_idle_big_driver =3D {
>>> +	.name =3D "big_idle",
>>> +	.owner =3D THIS_MODULE,
>>> +	.states[0] =3D ARM_CPUIDLE_WFI_STATE,
>>> +	.states[1] =3D {
>>> +		.enter			=3D bl_enter_powerdown,
>>> +
>>> +		.exit_latency		=3D 500,
>>
>> Extra line between enter and exit_latency.
>=20
> Gah, not anymore :)
>=20
> Other than that, is it ready to go ? If nobody complains I have plann=
ed
> to send a pull request early next week, as soon as a stable branch fo=
r
> TC2 MCPM gets in arm-soc.


It sounds good to me.




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

