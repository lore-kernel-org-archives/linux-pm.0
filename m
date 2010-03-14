From: 640E9920 <640e9920@gmail.com>
Subject: [PATCH] PM_QOS api update for linux-next
Date: Sat, 13 Mar 2010 18:16:04 -0800
Message-ID: <20100314021604.GA22158__5616.35913695699$1268533037$gmane$org@mgross-acer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6105810382369372480=="
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Helmut.Schaa@gmx.de
List-Id: linux-pm@vger.kernel.org


--===============6105810382369372480==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch assumes the pm_qos update just posted is included int
linux-next.

Signed-off-by: mark gross <mgross@linux.intel.com>


=46rom 361b695e0f6468214e6e8c8c789bdb651e163374 Mon Sep 17 00:00:00 2001
=46rom: mgross <mgross@linux.intel.com>
Date: Sat, 13 Mar 2010 18:09:04 -0800
Subject: [PATCH] PM_QOS function name update pm_qos_requierment --> pm_qos_=
request

---
 net/mac80211/scan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 75a8597..077eef1 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -506,7 +506,7 @@ static int ieee80211_scan_state_decision(struct ieee802=
11_local *local,
 		bad_latency =3D time_after(jiffies +
 				ieee80211_scan_get_channel_time(next_chan),
 				local->leave_oper_channel_time +
-				usecs_to_jiffies(pm_qos_requirement(PM_QOS_NETWORK_LATENCY)));
+				usecs_to_jiffies(pm_qos_request(PM_QOS_NETWORK_LATENCY)));
=20
 		listen_int_exceeded =3D time_after(jiffies +
 				ieee80211_scan_get_channel_time(next_chan),
--=20
1.6.3.3


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkucRuQACgkQhK5OsmQOmSCblQCcDBrdBncwhra2tA3r0SSR+/o9
oyUAnisC0JS+AhGjSE3CvHVTE61MEXaP
=P4sd
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============6105810382369372480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6105810382369372480==--
