From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 16 Dec 2015 11:20:42 +0000
Message-ID: <20151216112042.GF5727@sirena.org.uk>
References: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
 <20151215231350.GA7421@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vnj+srGq+/SN26DJ"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151215231350.GA7421@earth>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org, Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com
List-Id: linux-pm@vger.kernel.org


--vnj+srGq+/SN26DJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 16, 2015 at 12:13:50AM +0100, Sebastian Reichel wrote:
> On Tue, Dec 15, 2015 at 11:52:10AM -0800, Tim Bird wrote:
> > Add a binding for the regulator which controls the OTG chargepath switch.
> > The OTG switch gets its power from pm8941_5vs1, and that should be
> > expressed as a usb_otg_in-supply property in the DT node for the
> > charger driver. The regulator name is "otg-vbus".

> I would like to get an acked-by from either the regulator framework
> maintainers, or DT binding maintainers (or both ;)) on the binding.

Please submit any patches you want reviewing using the process in
SubmittingPatches.  If this is a regulator driver it should be in
drivers/regulator though.

--vnj+srGq+/SN26DJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcUkJAAoJECTWi3JdVIfQvJkH/Rs4tA573JujATMXufW5AGEt
+GMBBXsOVeGWaBLUFhl8STsu0Ljkpa2KdgorfbR42aD8HuQuKtq2jszBx86PAz9X
0QHn+LBDc9+v5gCooNJmcS6fB5MPXV5BOROcVPK+Ak2fPHjRbmalgOPEBiXUWF4x
zPjoJVh9qX5fl9qG/EUvpvDtX8+2ioQVSaXDk5CZ2o1CpY46SsVFAt8BrPVNGqAP
2Hcj3dU/7POSKRJAPZhTovMA8oPVaUvPZ4V/5xOO2ornIDWPcHlPbAIW6Perkpzp
4t+5P8+gdcsfBk6IAh442a9BrYAJc6yiRtOfCwyn5n3YMYuDsvFSA1HBHFuk+6s=
=AtGi
-----END PGP SIGNATURE-----

--vnj+srGq+/SN26DJ--
