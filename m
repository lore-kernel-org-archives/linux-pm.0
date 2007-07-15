From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Sun, 15 Jul 2007 19:08:04 +1000
Message-ID: <200707151908.05388.nigel__1177.08858238093$1184538229$gmane$org@nigel.suspend2.net>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8728071423618710389=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184483593.1898.98.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

--===============8728071423618710389==
Content-Type: multipart/signed; boundary="nextPart2387600.KdldWAbgaJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2387600.KdldWAbgaJ
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 15 July 2007 17:13:13 Huang, Ying wrote:
> The complete changelog of the patch is as follow:
>=20
> ---
>=20
> Kexec base hibernation has some potential advantages over uswsusp and
> TuxOnIce (suspend2). Some most obvious advantages are:
>=20
> 1. The hibernation image size can exceed half of memory size easily.
> 2. The hibernation image can be written to and read from almost
>    anywhere, such as USB disk, NFS.

This isn't right. TuxOnIce has no problem with image sizes exceeding half t=
he=20
amount of memory, and both uswsusp and TuxOnIce could write to a USB disk/k=
ey=20
or NFS as well. Historically, the issue with writing to USB devices has bee=
n=20
an issue with USB device drivers, not hibernation implementations. I haven'=
t=20
tried writing an image to USB, but with the work on the drivers, I wouldn't=
=20
be surprised if it was usable now. NFS? Again, I haven't tried, but wouldn'=
t=20
expect it to be impossible. I did try writing an image to an NBD device a=20
couple of years ago. It didn't quite work, but wasn't far away.
=20
Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2387600.KdldWAbgaJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGmeP1N0y+n1M3mo0RAoHhAJ9YREzwIWYaoPvbA4ET8xBpobd93gCgg9TC
j7gTdHPM36nEygefLK6wyC0=
=q9qY
-----END PGP SIGNATURE-----

--nextPart2387600.KdldWAbgaJ--

--===============8728071423618710389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8728071423618710389==--
