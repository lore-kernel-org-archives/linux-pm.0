From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 9 Dec 2015 23:20:45 +0100
Message-ID: <20151209222044.GB32712@earth>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
 <20151209041153.GA29549@rob-hp-laptop>
 <566824AD.4080003@sonymobile.com>
 <CAL_JsqL0BjD6A1quSZOYmLNeRZAYo1UwSsTPPvMUbC1pSwM6CQ@mail.gmail.com>
 <566867F1.7000906@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566867F1.7000906@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: Rob Herring <robh@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, =?iso-8859-1?Q?Andersson=2C_Bj=F6rn?= <Bjorn.Andersson@sonymobile.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 09, 2015 at 09:42:09AM -0800, Tim Bird wrote:
> Or maybe our power maintainers will chime in with some wisdom. I
> can't be the first person to be adding a charge pathway switch to
> mainline, so I'm open to doing it the "right way". :-)

I don't think there is a standard way for this so far. Another
otg charger coming to my mindis bq2415x, which basically just
exposes the enable bit via sysfs.

Exposing the switch as regulator would be fine for me.

> > Thinking about this some more, the node name should be generic, so
> > just "regulator". The label does not need to be generic.
>=20
> There are other switches in the charger block that are not
> exposed yet.  This one handles the the OTG (vbus) charge pathway.
> Others handle other charge pathways (some of which are used on phones
> and some are not - they're used, e.g., on the dragonboard).  I'd
> rather not give it a generic name, because eventually the driver
> should expose those other switches as something as well.

otg_regulator: regulator@0 { }
other_regulator: regulator@1 { }

-- Sebastian

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWaKk6AAoJENju1/PIO/qaND4QAJsU451KXZTLRbku5ELBstm1
D2N1NglwTXqHKejPG8A7dKfsh+W8Rmrk0VFOP/2rwBmkqabbzHwJm1Hpc9g3h/ar
3Jehkf2wM6JwODGJ+2uFmjuEgIL7FcftDPvEntD6OJMiB41ekO8TdzjR3vKHPt0N
zRaXvtA6XMyEtoLXPZUMz5DbC5rfwcr0cfcE/dRcCHQZMbL0glaHOfRyvpzJyZET
AsIXQngnKGgSB4grMLSlPkC/oTmMXOcPkbJXchFBfRhsdXAx4yBdRJeW037EQOhF
WTIu2INsAq15OT8ZbqrUevZEvGlJAgGiryNNgPYzXfTm6J2D3WFXTYF0vU9eh+DL
dJckg66Kiyjf5izN5nbySYNXsFP51cSWBwT221rRXh9cfQLWxiIC1TkLBHy7AgSe
DDivmrRB2fbwFBlcH/qWphl5VoLyK9+oGp2+PA0yqmpIph3MS6ApU20OCuNqOTJP
FXYMmnq3gImq4sgJHMYYu36EX1CZzewS/VO0Kn5hRS3bdjNM/19Rz7v5HxNhu6/E
rhdS6WaMnmpdhnAkKu5m2s6dHYY1TJawFw3tBSzaR3ci2wpom3TG/ftzaVFMk9ai
btymIgg/rKcy/s4WlcRmzmYY0CrnfpglgulNjacP4LnUvvQSz3frPlu8RbX2s4mN
XJ+PJz2KVd3aZUH42jyr
=u5Vq
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
