From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
Date: Wed, 26 Sep 2018 14:45:10 +0200
Message-ID: <20180926124510.2ewnaw3jyzm3qkbm@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
 <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5sdzrxlcfxsqscbx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org


--5sdzrxlcfxsqscbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 26, 2018 at 04:30:39PM +0800, Baolin Wang wrote:
> Hi Linus,
>=20
> On 26 September 2018 at 16:00, Linus Walleij <linus.walleij@linaro.org> w=
rote:
> > On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wr=
ote:
> >
> >> Introduce one property to present the battery internal resistance for =
battery
> >> information.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >> ---
> >> Changes from v1:
> >>  - New patch in v2.
> >
> > I'm a bit confused by the physics in this patch.
> >
> > The internal resistance of a battery is not a constant in its life cycl=
e,
> > this varies over the age of the battery, and the reason I thing is
> > chemical residuals accumulating on the anode and cathode inside
> > the battery and the energy storage medium aging. (Plus/minus my
> > ignorance about how batteries actually work.)
>=20
> Yes, you are right. The internal resistance can be affected by
> temperature or battery age or other factors. But our solution just
> uses one constant internal resistance to calculate OCV value to look
> up the capacity table when system boots on, in this case we do not
> need one more accuracy OCV, since we will calculate the battery
> capacity in future. So we just introduce one estimation constant
> internal resistance.
>=20
> >
> > AFAIK the fact that the internal resistance varies is of high
> > importance for people developing algorithms of battery capacity
> > and longevity. Such that some (hardware) capacity monitors go
> > to great lengths to measure with high precision the current
> > internal resistance of the battery for their algorithms.
> >
> > Sorry for making things more complex, but should it be named
> > "factory-internal-resistance-micro-ohms" or
> > "typical-internal-resistance-micro-ohms"?
>=20
> I am fine with this change. If Sebastian also agree with this change,
> I will fix. Thanks for your reviewing and comments.

Ack.

FWIW for proper battery status you need to collect battery specific
statistics, that is the reason fuel gauge chip providers recommend to
combine the chip with the battery cells into a "smart battery".

-- Sebastian

--5sdzrxlcfxsqscbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlurf1MACgkQ2O7X88g7
+prdag/9HpJdthcFfUo/R15YTEMK4hm97zOgcj0ea5Ouhl9/h6C8Zwwgj4FdJQmG
IyEw1h2jgd/t8mFKieQ9lAg0PxZPx4Jon63JpNQZcZZ9lXk1JsvJo7X36aAQyhgN
pS6nB9aR+TW58FefD4C6CTKo+RMLrQqaQA7GrBXcPE06NrLAIcTCgk/ozjjjfOLF
HkBGOzFcGgwVBbHv79RQJ1b3vQ1Olb8fKaekEb6Q99LK0lvTpStiBbAlO2u7WcJF
RQdZ+zapIokl4vcRhMPtYasedCzlkBCbGdc3/PxMMN4UJwdUDEj8iNUFaKC1ELE7
zM2I4DdNsMMh7kj9ForxMfS4SbrII4PuyZL2j//BtV/Wkss61kwfzPBSgHP8dL5c
xx+aLelWITWQgq3JipRMmXyNPKHRtHO3hiCHyD+vexAGK9uVwrJv6hw1VZkrw4tK
9znek1s3hu30A/AmxK2CC7u1rHKRUGrf0n3FUDv1PvJC27PW7fZCL0agyuEVkJJB
qaHDIUIhmW56ZvdzdnEuXmGIuD4pxzRz2VIoyHtdq1igvolhuDAJ4mjTMNgTPbN1
U46SIDueinYiDrRpMTAcvWTTz75DJEFkNwIEhBAkhY442Ox0UA+4xuYZbJ6J+4Ch
tNxRmPgu1bMr4CmvXFcFlrVlYySXVkvAHqt87zj52dVLvGN9ils=
=gnFq
-----END PGP SIGNATURE-----

--5sdzrxlcfxsqscbx--
