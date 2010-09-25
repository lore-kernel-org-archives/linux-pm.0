From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: Nigel's current for-rafael queue
Date: Sat, 25 Sep 2010 17:04:41 +0200
Message-ID: <201009251704.50186.Martin__17753.33307819$1285427227$gmane$org@lichtvoll.de>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
	(sfid-20100925_095715_038909_A9814B83)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6816454140543402107=="
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
To: linux-pm@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

--===============6816454140543402107==
Content-Type: multipart/signed;
  boundary="nextPart4127678.rHa97IMe2R";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4127678.rHa97IMe2R
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Samstag 25 September 2010 schrieb Nigel Cunningham:
> Hi Rafael.

Hi Nigel,
=20
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

I like to help by testing these. Is it sufficient to check out your latest=
=20
tuxonice tree, checkout branch for-rafael and switch the hibernate script=20
to TryMethod disk.conf?

Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart4127678.rHa97IMe2R
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkyeD4oACgkQmRvqrKWZhMcgLwCeM/lEmXqxTzd9HDXzA9TKGpoK
sOEAmwV6unoKnH80BkrtAMhQfLdJcIwD
=ndGy
-----END PGP SIGNATURE-----

--nextPart4127678.rHa97IMe2R--

--===============6816454140543402107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6816454140543402107==--
