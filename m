From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 10/14] dt-bindings: Add support for SAW documentation
Date: Tue, 17 Apr 2018 12:09:08 +0100
Message-ID: <20180417110908.GE8973@sirena.org.uk>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-11-git-send-email-ilialin@codeaurora.org>
 <20180409202144.76gjmc6kcn2msffl@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409202144.76gjmc6kcn2msffl@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, lgirdwood@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 03:21:44PM -0500, Rob Herring wrote:
> On Fri, Mar 30, 2018 at 12:26:43AM +0300, Ilia Lin wrote:
> > Add support for SAW controlled regulators in 8x96.
> > Document it.

> Perhaps some clue in the subject what subsystem and/or device this=20
> applies to.

Right, especially given that if people can't find the documentation for
driver binding changes that's likely to be one of the first compliants.

> > +- qcom,saw-leader:
> > +	Usage: optional
> > +	Value type: <boo>
> > +	Description: SAW controlled gang leader. Will be configured as
> > +		     SAW regulator.

> Would the coupled regulator binding work in this case?

Someone would need to get the code working first though depending on
what the hardware does that might not be the right thing.  It's fairly
common to have hardware support for grouping multiple physical
regulators together into a single supply in order to provide more
current with all the control being done from one of the regulators.

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrV1dMACgkQJNaLcl1U
h9C0bQf+J8T+z/WFL4FRphSZwjRTU+0HhnZzffI5jjGTCYxiT8QBq3RCb2St3qz/
ZiEqf0N7TGQSwDb3TxMnSmZPJVop2UrKOMKVFDmO6j9i2b8ZsqFgC+PsJ9fEpJyr
nvaaZZ+TTepltFDR0qFFllIKwB5m1hi+Do+hg/84of5IVXm17OuNY9xEqDSjSKWh
SIUk2S684iXlHrWhkYgfrfpi1FrwdM/LNcAEUcn85Pd0os1R7pj2cXYONlt0SxQS
ype0JVeh5/6fLe9rSbJy+4yC4L1FIgvnIu8RY6DloLGLjN5+gpnewq+9ku8ia2W+
+6tF2ug17EqAwRKsjMYk21BGkuUYYA==
=Wr8V
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
