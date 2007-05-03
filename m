From: Marcus Better <marcus@better.se>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Thu, 3 May 2007 20:08:15 +0200
Message-ID: <200705032008.16329.marcus@better.se>
References: <f129n6$mro$1@sea.gmane.org> <200705031341.05023.marcus@better.se>
	<200705031506.28559.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6697019583810530249=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031506.28559.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============6697019583810530249==
Content-Type: multipart/signed; boundary="nextPart7464909.P5WkinEbce";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7464909.P5WkinEbce
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rafael J. Wysocki wrote:
> Hmm, perhaps we should do something more, like the following:

No, almost same thing. Screen goes blank, but then there is disk activity=20
before poweroff. (That makes me a bit unsure as to whether there was disk=20
activity with the previous patch, I might have missed it...) At the next bo=
ot=20
it doesn't resume, just reboots from scratch.

Marcus

--nextPart7464909.P5WkinEbce
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOiUQXjXn6TzcAQkRAuYkAJ0W7JVybfDtPpb0lyRtx1lXCfR1XQCbB1mJ
10fe66aoOJtlcugIhw0UiFc=
=+Fjj
-----END PGP SIGNATURE-----

--nextPart7464909.P5WkinEbce--



--===============6697019583810530249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6697019583810530249==--
