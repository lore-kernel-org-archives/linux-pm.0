From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [TuxOnIce-devel] Nigel's current for-rafael queue
Date: Tue, 28 Sep 2010 21:45:37 +0200
Message-ID: <201009282145.46948.Martin__33345.6905362711$1285703210$gmane$org@lichtvoll.de>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
	(sfid-20100925_095651_884433_67642C74)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3388483287195462120=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

--===============3388483287195462120==
Content-Type: multipart/signed;
  boundary="nextPart1949636.cTmNjiBp7y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1949636.cTmNjiBp7y
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Samstag 25 September 2010 schrieb Nigel Cunningham:
> Hi Rafael.

Hi Nigel,

> Please find attached a slightly updated version of the patchset I sent
> a few months ago. The main change is that I've prepended and additional
> patch which lets the user see the speed at which the image is being
> read and written. This is accomplished by recording the MB/s in a
> single byte in the image header, and using a couple of __nosavedata
> variables to get the data back through the atomic restore. I realise
> the char limits us to 255MB/s at the moment. In future patches, I
> intend to address this by storing the data in a 'proper' image header
> (it's a real problem - TuxOnIce reads and writes on the same set up at
> speeds around 250MB/s).
>=20
> Results on my Dell XPS M1530, which has an SSD hard drive are:

I found one issue with this patchset or more precise I think with the=20
state of in-kernel-suspend before:

I accidentally booted a kernel without your patches and it didn't seem to=20
stop on the hibernation image from the kernel with your patches. Well I=20
let my laptop unattended for a little while, so when there has been a=20
(short) timeout, I might have missed that message.

I lost a hibernation image this way which caused successful journal replay=
=20
on my Ext4 filesystems.=20

Does a kernel without your patches offer to reboot into the correct kernel,=
=20
then it finds a hibernation image from a kernel with your patches?

If not, I think for the future it should give a warning with a quite high=20
timeout, and offer to reboot into the right kernel.

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1949636.cTmNjiBp7y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkyiReIACgkQmRvqrKWZhMedSwCgtODcl0S2Mwv+qlU3V8KfA3YY
b9oAn1eAPwnsmKX9+yVndhWpGD6A9AkB
=CyH4
-----END PGP SIGNATURE-----

--nextPart1949636.cTmNjiBp7y--

--===============3388483287195462120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3388483287195462120==--
