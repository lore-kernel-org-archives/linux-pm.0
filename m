From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 9 Dec 2015 18:56:06 +0000
Message-ID: <20151209185606.GE5727@sirena.org.uk>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
 <20151209041153.GA29549@rob-hp-laptop>
 <566824AD.4080003@sonymobile.com>
 <CAL_JsqL0BjD6A1quSZOYmLNeRZAYo1UwSsTPPvMUbC1pSwM6CQ@mail.gmail.com>
 <566867F1.7000906@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OAsA6xQjj2jRKPG2"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566867F1.7000906@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: Rob Herring <robh@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, =?iso-8859-1?Q?Andersson=2C_Bj=F6rn?= <Bjorn.Andersson@sonymobile.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org


--OAsA6xQjj2jRKPG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 09:42:09AM -0800, Tim Bird wrote:
> On 12/09/2015 06:36 AM, Rob Herring wrote:

> > You need a regulator-name property. Also, should should define valid
> > values for regulator-min-microvolt and regulator-max-microvolt.

> All of those are listed as optional properties in
> Documentation/devicetree/bindings/regulator/regulator.txt.

I have to say I'm also a bit confused about why a binding using a
regulator would need to do anything other than reference that document
except in cases where using some functionality enabled by the generic
bindings is a key part of the functionality of the device (which do tend
to be rare).

> The regulator-name seems redundant, since the name of the DT
> node becomes the regulator name in the Linux system.  This is

The purpose of the regulator-name property is to allow you to put in a
descriptive name for the supply which would normally correspond to the
name the supply is given on the schematic and may not fit into the DT
conventions.  It is entirely optional but strongly recommended to aid
people in understanding how both the DT and the running kernel relate to
the schematic.

> not currently used anywhere, as the node is "connected up" via
> phandle, which uses the label.  That is, there's no code in
> the kernel that looks up this regulator by name, although it
> does get a name.

The name is purely for use by humans in logs and/or userspace, it is not
used in the kernel.

> As for the microvolt references, I'm a little stumped what
> to do with those.  I could use regulator-min-microvolt of 0
> and a regulator-max-microvolt of 500000, but that's not
> exactly right.

You should only specify voltages if the intention is to either allow
consumers to vary voltages at runtime or have the kernel set a specific
voltage for the regulator (eg, if the hardware defaults are wrong).

> This is actually representing a voltage switch, which is being
> represented in the regulator framework in Linux, because it
> seems to fit there best.  It has regulators it's related
> to, which should be adjusted when this one is.  However, it
> intrinsically does not have a voltage of it's own, so it's a
> bit of a weird case.  And the voltage can either be going
> "out" or "in".

If you want consumers of the supply to be able to vary the voltage you
need to permit that on the child supply as well as the parent supply so
we know we can pass requests up.

--OAsA6xQjj2jRKPG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaHlFAAoJECTWi3JdVIfQ1UMH/1orvf1RRuojBjiRAHAhdTPS
K3RWcxAYnVQOPu9gcoXWOCDsSdIQnVHjAq5v94na5mxzEIGtJ1ycCa8JbQlt3bTN
aZdNDpYZkkCd8FsggAAToRftlc/TB+++XAWvqOVvzWEN2xtqkQr6BilQerWaH6Bn
w4+3l6xdrtL8Hkz5xh26rAEmyhGIyiX5wX0Tj/FdwhGN35/6h+SfnM/NJhayB3dC
goZ3RreMCEMSQb4Fqc/2IRcBWZwlbBNv32RNuZLAoiRuQQ5dALo0ckDpw12nWquG
1NLcN7BmeuDH0tHzIMK5F9jd1Rl5fL1mv1kDJCmvcSQvpGaiy+RUZIPVzMMYjek=
=YI4n
-----END PGP SIGNATURE-----

--OAsA6xQjj2jRKPG2--
