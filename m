From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [git pull] pcmcia fixes
Date: Thu, 12 Jan 2006 20:26:22 +0100
Message-ID: <20060112192622.GA9908@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============69773423766380094=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: torvalds@osdl.org
Cc: linux-pcmcia@lists.infradead.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============69773423766380094==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull from

	git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git/

for additional device IDs and a new independet runtime powermanagement
interface (which was discussed on the linux-pm mailing list as well) for
PCMCIA cards and devices, as the existing "device/power" one is said to be
on its way out.

The diffstat and list of changes follows:

----
 drivers/pcmcia/ds.c           |   37 +++++++++++++++++++++++++++++++++++--
 drivers/pcmcia/socket_sysfs.c |   25 +++++++++++++++++++++++++
 drivers/serial/serial_cs.c    |    2 ++
 3 files changed, 62 insertions(+), 2 deletions(-)
----
Dominik Brodowski:
      pcmcia: add new IDs for serial_cs.c
      pcmcia: runtime powermanagement interface

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDxq1eZ8MDCHJbN8YRAqcCAJ9NMefls/osz2nIY7s1YF3mlIQIIQCfXZaG
oouJuS+ZSS/SsxlyonVRGIY=
=jeKm
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============69773423766380094==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============69773423766380094==--
