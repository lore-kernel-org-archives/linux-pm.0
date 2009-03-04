From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.29-rc: PM notifiers are not called during
	hibernation
Date: Wed, 4 Mar 2009 19:33:26 +0300
Message-ID: <200903041933.40837.arvidjaar__7914.81847777522$1236184597$gmane$org@mail.ru>
References: <200901292254.09562.arvidjaar@mail.ru>
	<20090304074733.GA1405@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2927295440339354627=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090304074733.GA1405@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============2927295440339354627==
Content-Type: multipart/signed;
  boundary="nextPart1287186.uxLbmaekjt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1287186.uxLbmaekjt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 4 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2009 10:47:33 Pavel Machek wrote:
> On Thu 2009-01-29 22:53:57, Andrey Borzenkov wrote:
> > rc2 and now rc3
> >
> > Orinoco driver uses notifications to request firmware before
> > suspend/hibernation. This is OK for suspend, but does not seem to
> > work for hibernation. I get what suspiciously looks like 60 seconds
> > timeout for request_firmware, but I do not see either usual
> > request_firmware output, nor debug output.
> >
> > Suspend is OK.
> >
> > orinoco notification handlers is:
>
> Is it fixed in newer -rc?

yes

> If not, does rafael know?

under different subject :)

--nextPart1287186.uxLbmaekjt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmurVoACgkQR6LMutpd94yA+QCfUUxTQjFmPuEedxyjp3IznFSq
MYEAoM8EZW4ihhRiwFLXOuWsfDlR/2Hu
=uWNP
-----END PGP SIGNATURE-----

--nextPart1287186.uxLbmaekjt--

--===============2927295440339354627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2927295440339354627==--
