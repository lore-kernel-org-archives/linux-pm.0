From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 16 Dec 2015 00:13:50 +0100
Message-ID: <20151215231350.GA7421@earth>
References: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org, Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com
List-Id: linux-pm@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 11:52:10AM -0800, Tim Bird wrote:
> Add a binding for the regulator which controls the OTG chargepath switch.
> The OTG switch gets its power from pm8941_5vs1, and that should be
> expressed as a usb_otg_in-supply property in the DT node for the
> charger driver. The regulator name is "otg-vbus".

I would like to get an acked-by from either the regulator framework
maintainers, or DT binding maintainers (or both ;)) on the binding.

-- Sebastian

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcJ6rAAoJENju1/PIO/qa9REP/3RwpU33vbdQjc1ONCgLedVV
c38y4B0rJdJCMoeGwJLETEsTT9V6CSJYkrQ/yOmpS6n/r7IHMX4DFxc9CPaLWKt9
SIwy0Qk2/HA9FZRUcXAxM7nGMWXnOSJUPMZ6TQoHOToW4PtjsccHt1tfnx3LRt0e
PD7vllQTAljR+6+VVK7pA7busbK9M3esG54VGPeJzPx046r6APlzeOlt6xdVgOoc
Xw4Qf3fEzVZ6WSOjdg7bl45LFoEIbuhqs14y2BRqR65bHPGVBWgdzHrxbf5llkzW
JN9CaRWrjr//WU5tm8U9RBULCj7JapVOXxuHVcQ0PESSNMMf3ogGPUQejSrM5AhC
au0Ku3jFrJvgD1x74G+/NOBUbXMlY0k8gK38cVZIHHFz3cEZiSoTTnxA6Wpx2T9d
HG02YXD1yfoW4BizIPBskf0dQkAElV7khhoNkMiGXMbxSAnA9tRYOSYPhF7aoP89
mzaEZptbhAplRNc1Y9VGQiqnoOkatlI08O9QEQesXSuunJ4+35RdHIFKmqtFqkpC
USOgzeRLYeObKfJQU1ZNOKeBzZkhAkMxwQHHp0LHPssDMEi1FxwIjQ0p0uDl3Er3
/h+k7dwrOchqu8pBaKAoiw8L76JmkDwCGOCsJJNVlmnq8sxJvFnHAsWgfIl7fiEq
TZn8A8LHaH2HfV9cJCAV
=yu06
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
