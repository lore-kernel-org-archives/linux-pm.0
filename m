From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RESEND v2] power: reset: keystone: Enable COMPILE_TEST
Date: Fri, 3 Jun 2016 04:13:39 +0200
Message-ID: <20160603021339.GC8921@earth>
References: <1459298988-20530-1-git-send-email-k.kozlowski@samsung.com>
 <20160415142752.GC24087@earth>
 <CAJKOXPdACNfhYj8cbrU6sUU+R7vSe+TOsRCPizhvu753KjavoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33703 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbcFCCNo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 22:13:44 -0400
Content-Disposition: inline
In-Reply-To: <CAJKOXPdACNfhYj8cbrU6sUU+R7vSe+TOsRCPizhvu753KjavoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 23, 2016 at 08:12:31AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Apr 15, 2016 at 4:27 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Wed, Mar 30, 2016 at 09:49:48AM +0900, Krzysztof Kozlowski wrote:
> >> Enable the COMPILE_TEST to get build coverage, except on platforms
> >> !HAS_IOMEM (required by selected MFD_SYSCON).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >
> > Thanks, queued.
>=20
> Hey,
>=20
> I can't find this patch in your recent pull request. What happened?

Sorry, I noticed, that I forgot to push it to -next and didn't want
to include untested patches in the pull request. It's the first
patch being queued for 4.8.

-- Sebastian

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUOfRAAoJENju1/PIO/qajm4QAKBkwlzR9uYzK+Tc4njcfJ1X
KIyIJQFxfr2Er2pTnhNK1dd3HYKrezIieT2mfKlT5RFsl/mcCtjnDYubc08+WQUF
fq09tv3s+uR30d51ksXcl7xwHSF+RKvREbRC3Dn8wriHEGlb707jbvbpTKbJZY3f
cJA2v9wOHc5nysHkmL1e2RNS926h4vM6KFyCgv38Kb+KVu+cC3y2mk03zPBaItAy
lWKdeIhJ/xpBXe65CMraxgfL4F09waOYUgtOAnrDZFTqY9uvR5o+3HwZr3nBgvG5
4MIpNu9DbhD5ilAIdL/vkJ/eB5xgEelL20cw61Gms6qf54dFcMDYpWKT2OjEFL4E
J/M7ZWOWTOelvrBJFjdfGJRqzrYPzIiIVb1+BFWB0GyhoWZ+APHcoeEkzRXl7TzT
K6vCCsJMMstjZOah5yJWPhFpWSg1JZ9HBGZWT1xxdiCKMTbxQGPmTreM6Fl2CzxO
xx97SRvoGUoC83maNdfvHLts9VRN3C1PVcIr0qE/2Pjh53QkSwy11O+CCNz3pNL+
X+t/BU/BL4/ETk4OZZjIIRhLUSOamYQmjj7rdE5hneCZhYRL6a0ulENq5/54fWh7
m9RZbmx7UKhBTJyDgX8Bj19A+MVIE5vEWbUX/YvTLKnfE8waPhZiMReFuxMCj5Rv
d5Dejg0BAsrTxE4kp86F
=UJeL
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
