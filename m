From: Johannes Berg <johannes@sipsolutions.net>
Subject: some task not stopped during resume
Date: Tue, 29 May 2007 14:42:17 +0200
Message-ID: <1180442538.1396.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2107179067537935813=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============2107179067537935813==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5qoZbDXDOsrjfczPFDFj"


--=-5qoZbDXDOsrjfczPFDFj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Oddly, I just got the following on 2.6.22-rc1:

[164571.322432] PM: Preparing system for mem sleep
[164571.883809] Stopping tasks ... done.
[...]
[164573.454973] PM: Entering mem sleep
[...]
[164574.580359] PM: Finishing wakeup.
[...]
[164578.238895] Restarting tasks ... <4> Strange, evolution not stopped
[164578.456389] done.

The interesting thing is that when I resumed, the gdb crash window came
up because evolution had just crashed (this is an option, otherwise
bug-buddy comes up.) But I'm not entirely sure how this could have
happened since it was definitely running while I suspended and must have
stopped at that point. Maybe some bad ptrace interaction? Though it
shouldn't have crashed when tasks were stopped? I'm confused.

johannes

--=-5qoZbDXDOsrjfczPFDFj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGXB+p/ETPhpq3jKURAvXdAJ9R6y/L736af86l+zxNA0oUbsv1JQCfSx6Z
vgBNTSepWdBqPzKcjIygMR4=
=wzUa
-----END PGP SIGNATURE-----

--=-5qoZbDXDOsrjfczPFDFj--


--===============2107179067537935813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2107179067537935813==--
