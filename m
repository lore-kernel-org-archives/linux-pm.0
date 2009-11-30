From: 640E9920 <640e9920@gmail.com>
Subject: [RFC] PM_QOS api update to use handles 2/4 (cpuidle
	update)
Date: Sun, 29 Nov 2009 17:10:05 -0800
Message-ID: <20091130011005.GB4732__2945.12419864095$1259543605$gmane$org@mgross-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9038097550823167778=="
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============9038097550823167778==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is patch 2 in the update to the pm_qos api to use handles.  This
patch updates the cpuidle dependencies on pm_qos

--mgross


Signed-off-by: mark gross <mgross@linux.intel.com


---
 drivers/acpi/processor_idle.c      |    2 +-
 drivers/cpuidle/governors/ladder.c |    2 +-
 drivers/cpuidle/governors/menu.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bbd066e..1f524a2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -696,7 +696,7 @@ static int acpi_processor_power_seq_show(struct seq_fil=
e *seq, void *offset)
 		   "max_cstate:              C%d\n"
 		   "maximum allowed latency: %d usec\n",
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
-		   max_cstate, pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY));
+		   max_cstate, pm_qos_request(PM_QOS_CPU_DMA_LATENCY));
=20
 	seq_puts(seq, "states:\n");
=20
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors=
/ladder.c
index a4bec3f..5f93084 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -67,7 +67,7 @@ static int ladder_select_state(struct cpuidle_device *dev)
 	struct ladder_device *ldev =3D &__get_cpu_var(ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx =3D ldev->last_state_idx;
-	int latency_req =3D pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
+	int latency_req =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
=20
 	if (unlikely(!ldev))
 		return 0;
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/m=
enu.c
index 6810443..f75aec5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -176,7 +176,7 @@ static void menu_update(struct cpuidle_device *dev);
 static int menu_select(struct cpuidle_device *dev)
 {
 	struct menu_device *data =3D &__get_cpu_var(menu_devices);
-	int latency_req =3D pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
+	int latency_req =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 	int multiplier;
=20
--=20
1.6.3.3


--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksTG20ACgkQhK5OsmQOmSDVHQCfZTLbrs8sVCEjAc8YsLFONBo2
hKUAn0ZLQsEldBqt2T1H9iAL0494zcvU
=kwD0
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

--===============9038097550823167778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9038097550823167778==--
