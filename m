From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 02:21:32 +0600
Message-ID: <20120412202132.GH12852@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
	<Pine.LNX.4.44L0.1204121607520.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3087099276291811553=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121607520.1496-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============3087099276291811553==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 04:09:43PM -0400, Alan Stern wrote:
> > Do this with the ehci_reset added and all the other changes present as=
=20
> > well.
>=20
> More precisely, keep the ehci_reset call (in both places),
Which both places?

> the dev_info call, and the pci_prepare_to_sleep call.  You don't need to
> set the configflag register to 0; the reset will do that anyway.


--=20
WBR, wRAR

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhzlMAAoJEDNi9wMaSZLhW7UP/0QdTMgFMC1tlA+fiPxU3Xs9
Cqep39C9w1dnyETbJPmC7xX1+ngETgiEvYP1xL4Gj3SY9Xeodqma1scZejKzKYYt
ldnKQz035a76UH2ClUhdBMoQuirSTBUcNhTohSlp+1kBh6qu4gTnZZi1gU08G2BA
1AP4bQHXirtwvB2cU1zWW5qpnFBzf+x5QAcV0kzkfDxHtcFoi7pg7TFgRDrbu/4R
Ia0YRkKQKsfXPHUxQP6WcyPrUq0PhcWIkNMPUQ1Dl50AU1AS9hkCpVTSsDDbGoCY
iVcjTm1J00G6MrqMbuTTvnV8GjflP5pSpZ3n3QXW1ae9v/pgUloTSK2CaTPTmmyI
09yTTyzUNFCtPleOgTum3hsnuqvu5sCDfVBAG+i+zTenLwMvJeAfQGRvjIKHleWq
Q+lv/iC0PbCc36CXUaIIDjk+tia9NWqxF1OqdV+YSYyWTfcrMEyWk0kAcy1SvGFQ
GvPBo22egI3DTtbqfXTdDQ0PHHjER5qzERMbWbIEWYr8mIIddPtTia2+fy56q7LS
7kUFvoh6v/5gdBipHZ2HlRjwo8Sh5IiXsH/0Ah7r/cDFwU7q+toW2ckQh9KhnnRV
oXCPa+mPrLxXBgN9mi3bffAR4LI3RWGXUNypN6p06z+ywmuT1lAeLLTvhMcUNdIH
DLa4mSsbAjXOwZKsDHf/
=uR/c
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--

--===============3087099276291811553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3087099276291811553==--
