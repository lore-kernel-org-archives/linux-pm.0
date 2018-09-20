From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Thu, 20 Sep 2018 18:58:47 +0200
Message-ID: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com>
 <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2im6fa4l5wivfec"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Craig <ctatlor97@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--s2im6fa4l5wivfec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Dropped a couple of people from CC, added Baolin]

Hi Craig, Baolin and Rob,

On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
> On 16 September 2018 13:10:45 BST, Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> >Sorry for my long delay in reviewing this. I like the binding,
> >but the "qcom," specific properties should become common properties
> >in
> >
> >Documentation/devicetree/bindings/power/supply/battery.txt
> >and referenced via monitored-battery.

> Thanks for the review, what bindings for ocv would you prefer? The
> spreadtrum ones or mine?

Most importantly I want to see only one generic binding supporting
both use cases. As far as I can see there are two major differences:

1. Qcom uses legend properties and SC27XX embedds this into data
2. Qcom supports temperature based mapping

The second point is easy: Not having temperature information can
be a subset of the data with temperature info. The main thing to
discuss are the legend properties. I suppose we have these
proposals:

Proposal A (from Qcom BMS binding):

ocv-capacity-legend = /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45 ...>;
ocv-temp-legend-celsius = /bits/ 8 <(-10) 0 25 50 65>;
ocv-lut-microvolt = <43050000 43050000 43030000 42990000

Proposal B (from SC27XX binding):

ocv-cap-table = <4185 100>, <4113 95>, <4066 90>, <4022 85> ...;

I prefer the second binding (with mV -> uV), but I think it becomes
messy when temperature is added. What do you think about the
following proposal (derived from pinctrl style):

Proposal C:

ocv-capacity-table-temperatures = <(-10) 0 10>;
ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;

-- Sebastian

--s2im6fa4l5wivfec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluj0b8ACgkQ2O7X88g7
+prcyg//SsMRNfaAnkvK4BqXeDhuk1A8QHu2iJLMyfQacPLpt9p5/QVXbmdxsTf1
X2EjvKJVtOs/tP+saYD7NPK1ShhX4Shryf7LbyzpGz8HFLar1TKqA3C+8g53bWZ2
unPCWezkLy5IjFTi7To36byC8/woOUZu00jMZhaRFQ9I1bnT9Wf1iMYUqBasXB9b
34aOH0oaNJcRWqfBhyqkWmoM1xgetRy2vJD6Ef+ct2GA/OscI+l9Og1tF8xKQwR+
I2BiFYPiIJmc6yVLWXva5wO2KHHUUh8MBaRLz4mQvx7vawz7sBos1VG7hCIVki1u
rkEVksvHjLTo5OK1wDdjSM66LjwFmTC84AWWG+jiALwgZa/7ohKHtRu/25rb3KsE
0VUW3ckKRM/UKsFtwASPzCmVZcBmQrGAKEqE5ep45ZXHHnWEoS23DZdEQDHnw+gz
NbnI1gqrwjtxedraJS/0j0B8kEbEiIotvRdChUI+fyUSO9fESnRf9sMhARy89Pl0
1ZgkN3+8Fk/YgOauvQY3QZVkuCpiZ55OVzmZZ8sUxzOPfKEu3kBtFEwi5bJst1E9
OAgC8wwaCIj/0i1e3XLApuPKKfLyX4xXg77/CaGl5GPw6O6+0zw6a2rRdvcnp3H+
sidDINWz/DuygOtYwlb2t6aVedLMG+4thQLhjJuDiQeK61l0lDE=
=5hQf
-----END PGP SIGNATURE-----

--s2im6fa4l5wivfec--
