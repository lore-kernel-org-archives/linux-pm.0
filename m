From: 640E9920 <640e9920@gmail.com>
Subject: [RFC]PM_QOS api update to use handles 5/5 (pcm updates)
Date: Sun, 29 Nov 2009 17:10:46 -0800
Message-ID: <20091130011045.GE4732__48514.5575403751$1259543616$gmane$org@mgross-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0141158966929221705=="
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
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, perex@perex.cz
List-Id: linux-pm@vger.kernel.org


--===============0141158966929221705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is the patch to update sound pcm's dependencies on the pmqos api
that was changed in the first patch in this series.

--mgross

Signed-off-by: mark gross <mgross@linux.intel.com>



---
 include/sound/pcm.h     |    3 ++-
 sound/core/pcm.c        |    3 ---
 sound/core/pcm_native.c |   12 ++++++------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index de6d981..91daac3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -29,6 +29,7 @@
 #include <linux/poll.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
+#include <linux/pm_qos_params.h>
=20
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
 #define snd_pcm_chip(pcm) ((pcm)->private_data)
@@ -355,7 +356,7 @@ struct snd_pcm_substream {
 	int number;
 	char name[32];			/* substream name */
 	int stream;			/* stream (direction) */
-	char latency_id[20];		/* latency identifier */
+	struct pm_qos_request_list *latency_pm_qos_req; /* pm_qos latency request=
 */
 	size_t buffer_bytes_max;	/* limit ring buffer size */
 	struct snd_dma_buffer dma_buffer;
 	unsigned int dma_buf_id;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index c69c60b..6faf4b5 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -647,9 +647,6 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream,=
 int substream_count)
 		substream->number =3D idx;
 		substream->stream =3D stream;
 		sprintf(substream->name, "subdevice #%i", idx);
-		snprintf(substream->latency_id, sizeof(substream->latency_id),
-			 "ALSA-PCM%d-%d%c%d", pcm->card->number, pcm->device,
-			 (stream ? 'c' : 'p'), idx);
 		substream->buffer_bytes_max =3D UINT_MAX;
 		if (prev =3D=3D NULL)
 			pstr->substream =3D substream;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ab73edf..e52eeec 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -447,11 +447,12 @@ static int snd_pcm_hw_params(struct snd_pcm_substream=
 *substream,
 	snd_pcm_timer_resolution_change(substream);
 	runtime->status->state =3D SNDRV_PCM_STATE_SETUP;
=20
-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
-				substream->latency_id);
+	if (substream->latency_pm_qos_req)
+		pm_qos_remove_request(substream->latency_pm_qos_req);
+
 	if ((usecs =3D period_to_usecs(runtime)) >=3D 0)
-		pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY,
-					substream->latency_id, usecs);
+		substream->latency_pm_qos_req =3D pm_qos_add_request(
+					PM_QOS_CPU_DMA_LATENCY, usecs);
 	return 0;
  _error:
 	/* hardware might be unuseable from this time,
@@ -506,8 +507,7 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *su=
bstream)
 	if (substream->ops->hw_free)
 		result =3D substream->ops->hw_free(substream);
 	runtime->status->state =3D SNDRV_PCM_STATE_OPEN;
-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
-		substream->latency_id);
+	pm_qos_remove_request(substream->latency_pm_qos_req);
 	return result;
 }
=20
--=20
1.6.3.3


--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksTG5UACgkQhK5OsmQOmSDwsgCfZJj4AdOe6mBhiZ37C8r8YSNM
f98An0gqnZzTdnh1BXhbDJDIlR035PAR
=ZAOP
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--

--===============0141158966929221705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0141158966929221705==--
