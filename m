From: =?iso-8859-1?Q?St=E9phan?= Kochen <stephan@kochen.nl>
Subject: Re: Interrupt driven thermal OF sensors
Date: Fri, 29 Jan 2016 01:16:24 +0100
Message-ID: <20160129001624.GA29675@Stephans-iMac.lan>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-3-git-send-email-stephan@kochen.nl>
 <56A24278.8050909@roeck-us.net>
 <20160122223238.GB21534@Stephans-iMac.lan>
 <56A2EB3E.4080002@roeck-us.net>
 <20160127211853.GA28555@Stephans-iMac.lan>
 <56A9A184.90001@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50822 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189AbcA2AQb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 19:16:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id 5CC15149B
	for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2016 19:16:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <56A9A184.90001@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, lm-sensors@lm-sensors.org, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Wed, Jan 27, 2016 at 09:05:08PM -0800, Guenter Roeck wrote:
> ... and thus disable any external chip signals associated with those =
limits.
>=20
> The idea with most if not all temperature sensors is that multiple tr=
ip points
> would be configured as multiple limits in the chip. Often those limit=
s,
> when reached, are tied to pins to cause a specific action (eg to caus=
e
> an interrupt, turn on a fan, or shut down the hardware). In effect, y=
ou
> suggest to re-define this mechanism and, for all practical purposes,
> use just one of the limits provided by the chip(s).
>=20
> Personally I don't think that would be a good idea, because it would =
have
> impact on hardware design. It would effectively limit the use of the =
thermal
> subsystem with temperature sensor chips to hardware designs which tak=
e
> the thermal subsystem's expectations and assumptions into account.
> At the same time, it would for all practical purposes mandate the use
> of the thermal subsystem on such systems, because the hardware would =
depend
> on the thermal subsystem's implementation to control the temperature
> in the system.

Ah, whoops. That makes a lot of sense. And I think I even saw the
poweroff in action once, when I misconfigured the temperature offset
register.

> While it may be feasible in some situations to have the thermal subsy=
stem
> dynamically set free-moving limits, there are many other situations w=
here
> those limits are tied to hardware responses, and the limits need to b=
e static.
>=20
> Maybe this is just a different world view. The thermal subsystem may =
see the
> world assuming that it always has an unlimited number of trip points =
available,
> and the chip it supports only support lower and upper boundaries (or =
trip points),
> which can be set and changed as needed. This is somewhat different to=
 the
> traditional world view, implemented not only in many temperature sens=
ors,
> but also in fan controller or Super-IO chips, where a set of temperat=
ures
> is programmed into the chip only once. I hope that it is possible to =
support
> both mechanisms.

That would be nice.

=46or starters, I think it should be possible for a driver to enable
thermal subsystem stuff only if an of_node is present. (Though I haven'=
t
checked what that's set to with `status =3D "disabled"` in the device
tree. Hopefully NULL.)

So, one option is to, instead of thermal OF telling the driver what the
limits are, we simply have thermal OF only notify the driver of trip
changes, and the driver does all the work of inspecting defined trips.

In the LM90 case, it can set low/high and critical alerts nicely based
on trip types (critical or not). But, for example, MAX6696 has an
additional 'emergency' alert. Should that just be left untouched?

Either way, this means hardcoding thermal trip to sensor alert mapping
in the driver. A more elaborate solution would be to define that mappin=
g
in the device tree, and have thermal OF handle it, instructing the
driver to set specific alerts. (And then the device tree author may
choose to leave certain sensor alerts alone.)

--=20
St=E9phan Kochen
