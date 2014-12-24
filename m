From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: rt5033-regulator: Use
 regulator_nodes/of_match in the descriptor
Date: Wed, 24 Dec 2014 12:56:00 +0000
Message-ID: <20141224125600.GB17800@sirena.org.uk>
References: <1418901216-19030-1-git-send-email-beomho.seo@samsung.com>
 <20141222151025.GY17800@sirena.org.uk>
 <54992212.8050707@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5O+LjL9oTw7vAELi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47234 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaLXM4S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Dec 2014 07:56:18 -0500
Content-Disposition: inline
In-Reply-To: <54992212.8050707@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lgirdwood@gmail.com, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com


--5O+LjL9oTw7vAELi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2014 at 05:04:34PM +0900, Beomho Seo wrote:
> On 12/23/2014 12:10 AM, Mark Brown wrote:

> > This isn't replacing existing code with use of the framework, it's
> > adding new bindings where there were none before so it needs to add a
> > binding document too.

> Actually, RT5033 device tree binding document sent at mainling list already.
> link is below,
> http://marc.info/?l=linux-pm&m=141890859525642&w=2
> It include regulator device node but above patch not applied yet.
> If you want, I will revise dt binding document patch and send to mailing list.

OK, I've applied this but please in future send the code and binding
documentation together to avoid such confusion.

--5O+LjL9oTw7vAELi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmrfgAAoJECTWi3JdVIfQ5wsH/Au5IVLShw44GaOvb5kM8Xh5
qoT0WC4zTJ8TMF/IDrXso52MNq6SJip6XIZNTyDvJ8Sh90FtMf8221yuqaaua2Cy
/0fGPCPM1QdOIsPBs3UcoV0gatN3ivFbhUHXrqkKe+VoxruzUaOFEc88uJw+bLPV
kh+r71McMbOAJpeAtxrk362DKF4SfqDZR0wynzuu8NqVY970a1Ds63Mwk5KGh383
x3dG0mnqcYNYENcvsCWSM8hSQNCnG2/4dN1NvlpgbFWmOInyIYX8dHfDM6JX5San
HZ1MPQcwqK6y36lHC8R5aXqhjT6ApmrMHE+S7J+g4Qw7EB4NRzg7dB4MMc6X0rM=
=SD5D
-----END PGP SIGNATURE-----

--5O+LjL9oTw7vAELi--
