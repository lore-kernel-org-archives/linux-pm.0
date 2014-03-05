From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 0/8] PM / Sleep / Runtime: Fixup some driver's system suspend
Date: Wed, 05 Mar 2014 14:02:24 +0100
Message-ID: <2429070.qaGktSfi2s@vostro.rjw.lan>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org> <7021741.2WcVMr4q95@vostro.rjw.lan> <20140305061647.GS13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2260156.gUV1Y7p9va"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57628 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752258AbaCEMrT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Mar 2014 07:47:19 -0500
In-Reply-To: <20140305061647.GS13126@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>


--nextPart2260156.gUV1Y7p9va
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, March 05, 2014 02:16:47 PM Mark Brown wrote:
> On Sun, Mar 02, 2014 at 12:38:47AM +0100, Rafael J. Wysocki wrote:
>=20
> > OK, I've queued up [1-2/8] for 3.15.  The rest generally didn't app=
ly for me
> > and I think it'd be better to push them through the respective subs=
ystem trees
> > later anyway.
>=20
> Is there a tag we can pull to get those patches?  The driver changes
> depend on the new API introduced in patch 2.

They are in the pm-drivers branch of linux-pm.git.

Thanks!

=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart2260156.gUV1Y7p9va
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJTFyBlAAoJEILEb/54YlRxEZYP/AgWVWirsXuhqT2a84JsadXX
8uQYS5HWvoZSDkM4lEw7FUXN1Keja7gKcbXNaACwX70KAgnmAQEYrpxp9jtLEBfh
qxJx5ZWhNY71Gki1d+l/Y2BezDDAlTMQWd/A26omZbQSaegx+RWiCObLsLsgWbsA
5R4jcOcXZH3F7f3/2ymZlZ2zq+ixEkhsVo5SHoT/0XS/0i0pqI6BZUShIioLJZhT
hicgkgZAGOTobDzQCdkclJEzu7X3ZyNKVNnNXKbzFEPphWJz4oPK68PoUp+S8aYc
xecQPKULA3wuHLLnvDgFCsQkzohqe+ylnE3gMbO0E99nnDqYEkC7DhtmnYWOxWoI
lIZ3llrnmaAT4v9swoYrapkmJm0qIBlnMqPYoC5QmZhIMLaDMGNoiL6pM6b4WWxO
gpNPpp8amydPaZJ/+6k0Yu6mKLMoqrluWC5g8JQSarhn8UxVU9q8C6pD/pYdMxeK
VSqg6/2Oj4YSbiRF0cL9Yx6ElIz4tMLrlWyTuq7KA35IYXS5CS8XBx0yqK2UZoc2
Z7HsurgC4cpfyjMvWOHIYoBhIb/ewCg7j6gp+APQkvx5CLzXfMM8wf2AQjLYEsb0
h6E60SId3tw8+Y7xBbf9mdNkPGO9aqM9nsMK5E/wWQ98Hu/mWooplNpXx40K8vNs
WoGV4ToIFHvnPhQEHaHx
=jWB7
-----END PGP SIGNATURE-----

--nextPart2260156.gUV1Y7p9va--

