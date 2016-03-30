From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5] thermal: add temperature sensor support for tango SoC
Date: Tue, 29 Mar 2016 17:05:04 -0700
Message-ID: <20160330000503.GA2625@localhost.localdomain>
References: <56D5C7FE.7010807@free.fr>
 <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33426 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758197AbcC3AFJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 20:05:09 -0400
Received: by mail-pf0-f174.google.com with SMTP id 4so27266826pfd.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 17:05:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56FACE0B.9060606@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

On Tue, Mar 29, 2016 at 08:48:43PM +0200, Mason wrote:
> On 29/03/2016 04:00, Eduardo Valentin wrote:
>=20
> > Again, only minor comments, as follows.
>=20
> I do hope we can get this driver sorted out in time for the 4.7
> merge window.

Well, I hope for the same, but the driver needs to be clarified and
properly documented, don't you think?

And now that you are here, and you have written this nice driver, it
would be good to make sure whoever comes to patch it later have enough
groundings to do the right thing.

>=20
> >> +The SMP8758 SoC includes 3 instances of this temperature sensor
> >> +(in the CPU, video decoder, and PCIe controller).
> >=20
> > Would you be able to add a link to sensor documentation?
>=20
> I couldn't find any documentation online, even on Chinese sites.
>=20

How did you come up with this code then? How do I know it is actually
working? Can somebody else verify this and reply with a tested-by?

> >> +	cpu_temp: thermal@920100 {
> >> +		compatible =3D "sigma,smp8758-thermal";
> >> +		#thermal-sensor-cells =3D <0>;
> >> +		reg =3D <0x920100 12>;
> >=20
> > I believe you have to put #thermal-sensor-cells as last entry.
>=20
> I've been using the node as-is in my DT, which works as expected.
> What kinds of failure did you have in mind?

No failures in fact, that was just a pattern.

>=20
> >> +	  Enable the Tango temperature sensor driver, which provides sup=
port
> >> +	  for the sensors used since the SMP8758.
> >=20
> > Please add a better description, e.g. which sensors are supported,
> > locations, accuracy, and more meaningful info an engineer could rea=
d out
> > of the help section.
>=20
> I will try to give a few more details, but AFAICS the majority
> of entries for other SoCs are as short as mine...
>=20
> What do you mean by "which sensors"?
>=20
> Locations isn't really relevant here because different SoCs
> will have them in different places.

This is confusing now. You mention in your commit message that the SoC
has three sensor instances, and they are in the CPU, video decoder,
and PCIe controller. Now, you are mentioning location does not matter.

So, what to expect from this driver ?

>=20
> > No license/author/contact section here?
>=20
> License is given by MODULE_LICENSE("GPL");
> author and contact are given by git log or git blame.
>=20
> >> +	writel(thresh_idx << 8 | CMD_READ, base + TEMPSI_CMD);
> >> +	usleep_range(100, 200);
> >
> > nip: blank line here.
>=20
> Did you mean "nit"? :-)
>=20
> >> +	return readl(base + TEMPSI_RES);
>=20
> Hmm, I don't see this rule in the CodingStyle document.
>=20
> There are even examples to the contrary:
>=20
> 		kfree(foo->bar);
> 		kfree(foo);
> 		return ret;
>=20

That, as mentioned, is a coding suggestion, based on what I have been
seeing as pattern.=20


> >> +	if (temp_above_thresh(base, idx)) {
> >> +		/* Upward linear search, increment thresh */
> >> +		while (idx < IDX_MAX && temp_above_thresh(base, ++idx))
> >> +			cpu_relax();
> >> +		idx =3D idx - 1; /* always return lower bound */
> >> +	} else {
> >> +		/* Downward linear search, decrement thresh */
> >> +		while (idx > IDX_MIN && !temp_above_thresh(base, --idx))
> >> +			cpu_relax();
> >> +	}
> >=20
> > Did I understand this right? We can only read if the temperature is
> > above an index or not, right?
>=20
> Right, the hardware's output is a single bit:
> "Is the temperature above the programmed threshold?" yes/no.
>=20
> > and we spin for 100-200us after every=20
> > attempt to check if temperature is above and index.
>=20
> Nit: we don't spin, we sleep.
>=20

Well, we are using timers, you are right, but we are still using the CP=
U
to check the hardware status. Is there a better way to do this? If it i=
s
threshold based, does the hardware produces IRQs?

> 100-200 =B5s is a bit conservative, the hardware doesn't need
> that much. But I wanted to give Linux the opportunity to
> group multiple checks together, and even switch to a different
> task if necessary. I assumed that it doesn't make sense to
> context switch for only tens of microseconds?
>=20
> > So, worst case,
> > if we start from IDX_MIN, and temp is at IDX_MAX, we spin for
> > 40 * (100 .. 200) us (with cpu_relax in between).
>=20
> On my system, cpu_relax is just a compiler barrier, so barely
> a blip. And the worst case doesn't occur. But I will change
> IDX_MIN to 10, because I don't care about sub-zero temperatures.
>=20
> > Does the chip support different temperature read strategy?
>=20
> I'm not sure what you mean.

Does this hardware support reading temperature in a different way? I
must say this is an awkward way of doing this, even worst blindly witho=
ut
documentation.

>=20
> > How does this perform in average case?
>=20
> Typical idle temps are index 18-20 (43-52 =B0C)
> When I load the CPU with cpuburn, the temp climbs to
> index 22-24 (61-70 =B0C).
> But obviously, these numbers depend on the thermal solution.
>=20
> > How about a local search within +-2 indexes of thresh_idx?

I am just attempting to understand this code and if it makes sense at
all. Of course, without hardware doc all this is just guessing.

>=20
> What problem would that solve?
>=20
> >> +	priv->zone =3D thermal_zone_of_sensor_register(dev, 0, priv, &op=
s);
> >=20
> > Would it make sense to use the devm_thermal_zone_of_sensor_register
> > version instead?
>=20
> Does that automatically call thermal_zone_of_sensor_unregister
> in the remove() method?

yes

>=20
> I prefer having the symmetry of register/unregister, but
> I guess it's your call as maintainer.
>=20
> Regards.
>=20
