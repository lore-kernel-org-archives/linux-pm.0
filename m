From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] cpufreq: Add Broadcom BCM2835 CPU frequency control driver
Date: Tue, 02 Feb 2016 14:48:57 -0800
Message-ID: <87r3guybhi.fsf@eliezer.anholt.net>
References: <1444592815-15271-1-git-send-email-lkundrak@v3.sk> <5626FE5F.8060209@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5626FE5F.8060209@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-rpi-kernel@lists.infradead.org, Dom Cobley <popcornmix@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Jones <lee@kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 10/11/2015 01:46 PM, Lubomir Rintel wrote:
>> +static u32 bcm2835_cpufreq_set_clock(int cur_rate, int arm_rate)
>> +{
>> +	int ret =3D 0;
>> +	struct prop msg =3D {
>> +		.dev_id =3D VCMSG_ID_ARM_CLOCK,
>> +		.val =3D arm_rate * 1000,
>> +	};
>> +
>> +	/* send the message */
>> +	ret =3D rpi_firmware_property(fw, VCMSG_SET_CLOCK_RATE, &msg,
>> +							sizeof(msg));
>
> Why does this driver call the firmware directly, rather than using the
> clock API?

The firmware's running a thread, watching our temperature and setting
the ARM and SDRAM clock according to its policy.  This call asks the
firmware to kindly go to a higher ARM and SDRAM (note: we can't do SDRAM
From=20Linux) clock from the default, and it will when it feels it can.
We do expose the ARM clock from Linux, but we can only really use it
informatively with the current firmware.

I may not like this architecture, the option we have available for now.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWsTJZAAoJELXWKTbR/J7oK3YP/i+XUhCIOKpoU20q0Mb+gX2U
lBrzTRsVXRZHcq2JcUXcxyI0DG9/H0mGiVngtmRp9e8zM1d858sjH8+O/GqLkqgx
EGbLJJbcPrsHknY+4ep/2ChyYeyvNX3ha/3psekImOdH3f0Lcha1P24w0doj0o9Y
iU0YEK/gc9K5LuG0Nm85qi9y1BE5u01eOrFvHz/1RvtVTfZvAkOohOhkyTeQq8te
u9IkIpCmVswBOGRmpLccAaNeIVgLYqAuNbZ24d3hYVhMY8cT0UMLS30ltby8Asbs
PjdxxsGwakHjrnjzl4U98upqmWzdqwUXVOY0nOrQLFh+zUqhNC4v5q8QDxcYeLgg
uKAwDXHxd2d7Q0ysYpsWg/ohaM1yVXsPYnZJ9g2LgdZsZAbfIa1o5HP6aB1B3c8a
Cxz213QEBiACscCcMSTJym7Fn5q8zIBuQfWookxo+nSnYn8L9VgCj05OHXHR2Dg7
vquFJW1sSIWnaudFhReOWotQpQZx/1UDZRqBr6XrnQUs9lXLKkE1lX9+5QgFsCsA
FTKs71x540hFvzH2LjJB6Dcw3WYwmWYW2RN1YCiGHm2ZLgtCF9uAF7PYwL5Z3uFU
igm2em0HH4rI9dp9TuLn6QcZuVFxhvmE7Xzu1PRtzG8QvMOkSD5J1ksrs0Bicwxk
a2FpYys6QYAQ+cdQ3iXH
=ltVX
-----END PGP SIGNATURE-----
--=-=-=--
