From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 16:34:02 +0300
Message-ID: <87ega3f3cl.fsf@intel.com>
References: <87poubgnbh.fsf@intel.com> <20160322113012.GC26924@xo-6d-61-c0.localdomain> <87fuujgwsm.fsf@intel.com> <20160418102316.GA27936@amd> <877ffvgqe9.fsf@intel.com> <20160418103945.GA29123@amd> <87y48bfaye.fsf@intel.com> <87vb3ffap6.fsf@intel.com> <20160418111342.GA30694@amd> <87shyjf8hp.fsf@intel.com> <20160418125853.GB3769@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418125853.GB3769@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel@ucw.cz> writes:
>> Pavel Machek <pavel@ucw.cz> writes:
>> > On Mon 2016-04-18 13:55:17, Felipe Balbi wrote:
>> >>=20
>> >> Hi,
>> >>=20
>> >> Felipe Balbi <balbi@kernel.org> writes:
>> >> >> But cellphone user knows what he connected his charger to, and tha=
t's
>> >> >> why it is useful to be able to lower the current. Even when you sa=
id
>> >> >> "less is just stupid" I demonstrated it is not, at least in case w=
hen
>> >>=20
>> >> and btw, you haven't demonstrated anything. You merely stated that it
>> >> isn't without references or numbers, or any source of trustworthy
>> >> information. I'm not really into 'believing'.
>> >
>> > You are not really into reading, either, it seems. Or into the
>> > electronics. Or into physics.
>> >
>> > You seem to understand that charging li-ion from li-ion produces too
>> > much heat. (And yes, it does, DC-DC convertors are not 100%
>> > effective). Converting energy into heat is not a good idea.
>> >
>> > If you need numbers or references to understand basic physics, you'll
>> > need to google it yourself, I'm afraid.=20
>>=20
>> still doesn't change the fact that you haven't demonstrated anything. If
>> you can't be helpful and/or constructive, you may also go away and use
>> whatever unsafe setup you want to use.
>
> So you still claim that it is "stupid" to charge at anything lower
> than maximum allowed current?
>
> Even after I described the example with device running off power bank
> on a train? Would you explain your reasoning?

you still haven't produced evidence of your claim. Claiming without
evidence has virtually no meaning. Anyway, I'll just google a bit later
seen as if you're just unwilling to produce evidence of your claims.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFOJKAAoJEIaOsuA1yqREFsMQAJTPwvXcCWnTPjU6Z+16/0Hc
pLOo0xGGRCr3G046K1oN77f/1y4L8lEQZPKecgN6hmOe3kB+FHCqrS4GUqJHJHOi
Su6kXd1zaNp5ZkTNG0Ai126+fSow+fi3smawpt4dYOfG9vBvlr/R4pSu9CLGq453
gk/WP3kVAP7cbcbL8ma4TKKW4BTr8tifDbV9DWqHRTiGOlB/UDomPMH7fN/0r2s3
IWt8or2QsfXaR1be43xvumuTbap82MFAfKVQgGA01CXWNKaq80ogvncmhWQTZY+3
iyz0dkhmE5MY8yDLEHlyYETe/0DzvrEUTLE93HNCvvGWGiUMl644lIqLAcEhuXQY
aeOlRnFWAAK0gQLFclOb8A/6T0uZBiZw9ELf4SE9/m+Z9v5Xw3GNhFYRerDkLTCx
zx3z92LgiNGKhJlEmyd2xGc91OHGH2fTuYy7lUWLr8ujpfNQuufNj6LFb6O6s9b/
dn7pV0Inv4dc9xrRPvs+2PwVbyRdJly3e3CbLAD9AzPlmVrApnuiYt/wBSawFXJ4
aQpvuJqwaYohW41T8kr4ROiMq6gSRPeLldsUpqhlU54EPC723L07CUOygFlVu1/u
WaV85OoQiNkesT4s1jB4cil0DhYv1kgl0zYxv+LSnxpD2m2Hsm4NuBufhErCVIbd
1sCFhHtCq7dHvRv3ROaH
=TMq+
-----END PGP SIGNATURE-----
--=-=-=--
