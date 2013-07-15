From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT infrastructure
Date: Mon, 15 Jul 2013 08:33:48 -0400
Message-ID: <51E3EC2C.2030803@ti.com>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com> <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com> <loom.20130715T124843-388@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2MEEXKGTQSKCBUOSOHBRH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42002 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005Ab3GOMd6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 08:33:58 -0400
In-Reply-To: <loom.20130715T124843-388@post.gmane.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com

------enig2MEEXKGTQSKCBUOSOHBRH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15-07-2013 08:12, Lucas Stach wrote:
> Hi Eduardo and others,
>=20
> Eduardo Valentin <eduardo.valentin <at> ti.com> writes:
>=20
>>
>> This patch improves the ti-soc-thermal driver by adding the
>> support to build the thermal zones based on DT nodes.
>>
>> The driver will have two options now to build the thermal
>> zones. The first option is the zones originally coded
>> in this driver. So, the driver behavior will be same
>> if there is no DT node describing the zones. The second
>> option, when it is found a DT node with thermal data,
>> will used the common infrastructure to build the thermal
>> zone and bind its cooling devices.
>>
>> In either case, this driver still adds to the system
>> a cpufreq cooling device.
>>
>=20
> I really like the idea to configure thermal zones using devicetree, it'=
s a
> step in the right direction. We might follow suit with the i.MX6 tempmo=
n
> driver to use this infrastructure.
>=20
> What I strongly dislike is the notion of the sensor drivers instantiati=
ng
> the cooling devices and the resulting devicetree binding. This seems re=
ally
> backward to me.
> I would rather see the drivers associated with the cooling devices (lik=
e
> cpufreq and the respective gpu drivers) to instantiate the cooling devi=
ces
> and the thermal zone referring to them through phandles. I think it
> shouldn't be too much work to go in that direction.
> The current method might be enough to work with the current thermal pla=
tform
> drivers, but if you want to go down the route to eventually use plain i=
2c
> devices (likely with an existing hwmon driver) you have to get away fro=
m the
> sensor devices instantiating the cooling devices.

I agree with you. While implementing the RFC, it looks awkward that the
ti-soc-thermal driver had to do the job to load the cpufreq-cooling
device. Problem is that a cooling device is not really a real device,
and might get flamed while represented as a device tree node.

I could try to push something following the same idea as the one I am
trying to sell with this series for sensor devices. For instance, in a
sensor node I am attaching a phandle to describe how thermal fw must
behave. Then the sensor driver it is supposed to load the thermal data
into the thermal fw. Same could apply for instance for cpufreq cooling
device. at the cpu node we could have a 'cooling_device' node at the cpu
node, while loading cpufreq-cpu0.

>=20
> Regards,
> Lucas
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2MEEXKGTQSKCBUOSOHBRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHj7CwACgkQCXcVR3XQvP3FTQD/TsI5bEXCUct15YTQSdhCC/1i
AAGbg1g3vPKUqxUiC6UA/2QhF1kaYEuHQ1kDXYYvwNGg1ABFQEAptXdeQ83MNS7E
=0Qis
-----END PGP SIGNATURE-----

------enig2MEEXKGTQSKCBUOSOHBRH--
