From: Mark Brown <broonie@kernel.org>
Subject: Re: Extending OPP bindings
Date: Fri, 31 Jan 2014 15:46:48 +0000
Message-ID: <20140131154648.GF22609@sirena.org.uk>
References: <52EA570A.8040501@arm.com>
 <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7faAIFVyKtREcqXC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33355 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbaAaPq7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2014 10:46:59 -0500
Content-Disposition: inline
In-Reply-To: <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>


--7faAIFVyKtREcqXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 12:46:20PM +0000, Lorenzo Pieralisi wrote:

> Indexing does not mean that the index in the DT is the same as the one
> allocated by the OS. Indexing is there to point at specific OPPs from
> different DT nodes, a good example are clock bindings and that's exactly
> how they work.

> Can you provide me with an example where the indexing would go wrong
> please ?

This does depend on what you mean by indexing but if you're talking
about having bindings where you have things that refer to the nth
element in an array in that form then it can become hard to read the
resulting DT and the potential for errors is increased.  Changes to the
original table need to take into account all the references to the table
and (especially if the number of entries gets large) it can be prone to
miscounting when checking references.

With OPPs this might happen if new operating points are characterised or
some are removed, for example due to new SoC variants or binning.

> Certainly relying on implicit ordering is not great either, actually I
> would say that it is broken.

Yes, that too - some sort of explict reference does help.

--7faAIFVyKtREcqXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68VkAAoJELSic+t+oim9P40P/3YzpMTOKCzdHHpdzFMGnNw7
/VtuGzjKUmA7QhvtOqaxn5HmzlrXu6jgb8nYIZqIQePEsp1pc4BOijuz9+h21ryQ
pV8LOSRjc8Kzfay/TpsQ5F2fYS47e8rkPv0GI9+9F3mLsZFK4nxklBg/XqmH8bij
vdRK5PA3Qfus087QtuIn4CxoUO9FQIRcTETrJiY0zzhldogFh0fHQ+SoqNUAvLKQ
1SzWlVqwgUes4hUdIyG7VRy2Ztk82qQZe8EiqOGpMHqylav4PrZA5u34o19g28wc
pRhmwaDivyg56JJJgwtgUvIQmHJ2YZJlroNASactZDuGmpK7Yh/+wc2Lh7KVBx9z
KK3Y0U1Ng34C1Tn55nN1fTkLtDrR9mPyFgoLIUpi3xfp42vVC+RwOEuknWKHfA4S
5/HWMajER8kDq6B/thyS7sqveWNwqrxmK26RmN410CCfZEFltdHwst59ky0shoJF
ENujBtRTt6G7Mj+UxyUOGRj/3stp4YamCiqIzbdg9SazBx14RXs0jDHY8gyNNfz/
ycMKBA7mcDIdlk1DQCEMeLcr2RfqxxBqUMLtN1Ntrk7P6ID/5s/UQ8olwAv+AR1b
K8AdYOTVRtTt48j61uwYcyFMIlfcTnho+DUUq63d+ejr1A2x29kYddcSxdnRT0Rq
W4mdpl8xXhENC9ZTyy+5
=ZQCg
-----END PGP SIGNATURE-----

--7faAIFVyKtREcqXC--
