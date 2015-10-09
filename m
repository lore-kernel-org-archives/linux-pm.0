From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 9 Oct 2015 16:17:27 -0500
Message-ID: <87oag7u4go.fsf@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org> <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org> <20151001172932.GG4469@saruman.tx.rr.com> <20151008155052.GH11776@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36216 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754799AbbJIVSY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 9 Oct 2015 17:18:24 -0400
In-Reply-To: <20151008155052.GH11776@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
> HI!
>
>> > +	int ret;
>> > +
>> > +	mutex_lock(&gadget->lock);
>> > +	ret =3D raw_notifier_chain_unregister(&gadget->nh, nb);
>>=20
>> Greg, this is the kind of thing I wanted to avoid adding more of.
>>=20
>> I was wondering if you would accept subsystems using kdbus for
>> this sort of notification. I'm okay waiting for kdbus for another
>> couple merge windows (if we have to) before that's merged, but
>> if we take this raw notifier approach now, we will end up having
>> to support it forever.
>>=20
>> Also, because soon enough we will have to support USB Power Delivery
>> with Type C connector, this is bound to change in the coming months.
>>=20
>> Frankly, I wanted all of this to be decided in userland with the
>> kernel just providing notification and basic safety checks (we don't
>> want to allow a bogus userspace daemon frying anybody's devices).
>>=20
>> How would you feel about that ?
>
> So init=3D/bin/bash boot no longer provides machine that charges itself?
>
> That would be bad. Traditionally, hardware controls battery charging,
> and if hardware needs some help, we should do it in kernel, to mask
> the difference from userspace.

this is a very valid point which I hadn't considered :-)

Seems like kernel it is, no matter how easy or how difficult it gets.

Mark, when can we try to have a discussion about how to get this
upstream ? It seems like designing everything in the mailing list will
just take forever. Any ideas ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGC7oAAoJEIaOsuA1yqRE6m4QAIkXvJYxqcSMQCRFj8tsEUtJ
J+GU+GJh4vgJ+qZhQo8aEQvhwz9vsHWV+WW9AfcuaNS8WU9Q5Rjqko8OkZzKt9F3
TQqRIZWJYZ3mvJLvc7wObZxgvOfmaXtNpmLJnKH7QKqWz/OEW5J/t+YX6FhgaEGG
bFz2BixoC2YVqdpw7jsJU/OnrrmrycjS3PboYI6GFlgsaBG+GL+A80bc3jEie+DV
BTXnRptvUNXh2qWlkP8hCorfIo6xK2s3+FuBLAy0z4FMKiKzAJLGNcMPnWm2d2wU
18y8I00zoAncsTgkv62cV7H4A0R/ZY+OGPr95eYEddUgLqD5eoxKmRAgZS4UzOSJ
zWp5/5mpI64oJ/MD7wLq8pJmYzVaRYj1hhNJBvSWYL0jqAeC+pM98qYMbRvPNoJ9
mMvDFuruNDRv7lw2f6JVvF6kmMMn5XJirEGZxjAdqBWcmf9QGhnpv+l++dBz/Fdj
ffRQqx7shncHS+gHS6eKipytcdf7MImeCZu8o6eNzcTlgzz11U3XNofMlSD+S2Zy
KVVyQZCZ8XbK6Wjfc4ei5fV+3ItYS4u0nvcR7B0/0g/z1S/pEqqi2+uVBCcm/JbL
vmVgifvQx9IwIFe4z9i9qHTVIe0W5UFC3CLlhiwRfIszROJdigXe0CZwGVqxQ+I2
EWU6UaAswX14DAiW8kMZ
=Iq3W
-----END PGP SIGNATURE-----
--=-=-=--
