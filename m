From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v5] thermal: add temperature sensor support for tango SoC
Date: Tue, 29 Mar 2016 20:48:43 +0200
Message-ID: <56FACE0B.9060606@free.fr>
References: <56D5C7FE.7010807@free.fr> <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain> <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr> <20160329020050.GA15721@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:51573 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbcC2Ss7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Mar 2016 14:48:59 -0400
In-Reply-To: <20160329020050.GA15721@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

On 29/03/2016 04:00, Eduardo Valentin wrote:

> Again, only minor comments, as follows.

I do hope we can get this driver sorted out in time for the 4.7
merge window.

>> +The SMP8758 SoC includes 3 instances of this temperature sensor
>> +(in the CPU, video decoder, and PCIe controller).
>=20
> Would you be able to add a link to sensor documentation?

I couldn't find any documentation online, even on Chinese sites.

>> +	cpu_temp: thermal@920100 {
>> +		compatible =3D "sigma,smp8758-thermal";
>> +		#thermal-sensor-cells =3D <0>;
>> +		reg =3D <0x920100 12>;
>=20
> I believe you have to put #thermal-sensor-cells as last entry.

I've been using the node as-is in my DT, which works as expected.
What kinds of failure did you have in mind?

>> +	  Enable the Tango temperature sensor driver, which provides suppo=
rt
>> +	  for the sensors used since the SMP8758.
>=20
> Please add a better description, e.g. which sensors are supported,
> locations, accuracy, and more meaningful info an engineer could read =
out
> of the help section.

I will try to give a few more details, but AFAICS the majority
of entries for other SoCs are as short as mine...

What do you mean by "which sensors"?

Locations isn't really relevant here because different SoCs
will have them in different places.

> No license/author/contact section here?

License is given by MODULE_LICENSE("GPL");
author and contact are given by git log or git blame.

>> +	writel(thresh_idx << 8 | CMD_READ, base + TEMPSI_CMD);
>> +	usleep_range(100, 200);
>
> nip: blank line here.

Did you mean "nit"? :-)

>> +	return readl(base + TEMPSI_RES);

Hmm, I don't see this rule in the CodingStyle document.

There are even examples to the contrary:

		kfree(foo->bar);
		kfree(foo);
		return ret;

>> +	if (temp_above_thresh(base, idx)) {
>> +		/* Upward linear search, increment thresh */
>> +		while (idx < IDX_MAX && temp_above_thresh(base, ++idx))
>> +			cpu_relax();
>> +		idx =3D idx - 1; /* always return lower bound */
>> +	} else {
>> +		/* Downward linear search, decrement thresh */
>> +		while (idx > IDX_MIN && !temp_above_thresh(base, --idx))
>> +			cpu_relax();
>> +	}
>=20
> Did I understand this right? We can only read if the temperature is
> above an index or not, right?

Right, the hardware's output is a single bit:
"Is the temperature above the programmed threshold?" yes/no.

> and we spin for 100-200us after every=20
> attempt to check if temperature is above and index.

Nit: we don't spin, we sleep.

100-200 =B5s is a bit conservative, the hardware doesn't need
that much. But I wanted to give Linux the opportunity to
group multiple checks together, and even switch to a different
task if necessary. I assumed that it doesn't make sense to
context switch for only tens of microseconds?

> So, worst case,
> if we start from IDX_MIN, and temp is at IDX_MAX, we spin for
> 40 * (100 .. 200) us (with cpu_relax in between).

On my system, cpu_relax is just a compiler barrier, so barely
a blip. And the worst case doesn't occur. But I will change
IDX_MIN to 10, because I don't care about sub-zero temperatures.

> Does the chip support different temperature read strategy?

I'm not sure what you mean.

> How does this perform in average case?

Typical idle temps are index 18-20 (43-52 =B0C)
When I load the CPU with cpuburn, the temp climbs to
index 22-24 (61-70 =B0C).
But obviously, these numbers depend on the thermal solution.

> How about a local search within +-2 indexes of thresh_idx?

What problem would that solve?

>> +	priv->zone =3D thermal_zone_of_sensor_register(dev, 0, priv, &ops)=
;
>=20
> Would it make sense to use the devm_thermal_zone_of_sensor_register
> version instead?

Does that automatically call thermal_zone_of_sensor_unregister
in the remove() method?

I prefer having the symmetry of register/unregister, but
I guess it's your call as maintainer.

Regards.

