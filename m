From: mark gross <mgross@linux.intel.com>
Subject: [PATCH]PM_QOS-to-use-handle-based-requests-pcm-update 5/5
Date: Tue, 1 Dec 2009 13:38:40 -0800
Message-ID: <20091201213840.GE19688__6192.31250971115$1259703588$gmane$org@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>, perex@perex.cz
List-Id: linux-pm@vger.kernel.org

This is the patch to update sound pcm's dependencies on the pmqos api
that was changed in the first patch in this series.

Updated per input from RFC.

--mgross

Signed-off-by: mark gross <mgross@linux.intel.com>



>From 7a0daea4708a2fca0e615ba36daeac60efea3cd6 Mon Sep 17 00:00:00 2001
From: mark gross <mgross@mgross-hp8510w.(none)>
Date: Tue, 1 Dec 2009 13:01:04 -0800
Subject: [PATCH 5/5] PM_QOS to use handle based requests pcm update

---
 include/sound/pcm.h     |    3 ++-
 sound/core/pcm.c        |    3 ---
 sound/core/pcm_native.c |   14 ++++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index de6d981..91daac3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -29,6 +29,7 @@
 #include <linux/poll.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
+#include <linux/pm_qos_params.h>
 
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
 #define snd_pcm_chip(pcm) ((pcm)->private_data)
@@ -355,7 +356,7 @@ struct snd_pcm_substream {
 	int number;
 	char name[32];			/* substream name */
 	int stream;			/* stream (direction) */
-	char latency_id[20];		/* latency identifier */
+	struct pm_qos_request_list *latency_pm_qos_req; /* pm_qos latency request */
 	size_t buffer_bytes_max;	/* limit ring buffer size */
 	struct snd_dma_buffer dma_buffer;
 	unsigned int dma_buf_id;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index c69c60b..6faf4b5 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -647,9 +647,6 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 		substream->number = idx;
 		substream->stream = stream;
 		sprintf(substream->name, "subdevice #%i", idx);
-		snprintf(substream->latency_id, sizeof(substream->latency_id),
-			 "ALSA-PCM%d-%d%c%d", pcm->card->number, pcm->device,
-			 (stream ? 'c' : 'p'), idx);
 		substream->buffer_bytes_max = UINT_MAX;
 		if (prev == NULL)
 			pstr->substream = substream;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ab73edf..2aab6cf 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -447,11 +447,13 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_timer_resolution_change(substream);
 	runtime->status->state = SNDRV_PCM_STATE_SETUP;
 
-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
-				substream->latency_id);
+	if (substream->latency_pm_qos_req) {
+		pm_qos_remove_request(substream->latency_pm_qos_req);
+		substream->latency_pm_qos_req = NULL;
+	}
 	if ((usecs = period_to_usecs(runtime)) >= 0)
-		pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY,
-					substream->latency_id, usecs);
+		substream->latency_pm_qos_req = pm_qos_add_request(
+					PM_QOS_CPU_DMA_LATENCY, usecs);
 	return 0;
  _error:
 	/* hardware might be unuseable from this time,
@@ -506,8 +508,8 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
 	if (substream->ops->hw_free)
 		result = substream->ops->hw_free(substream);
 	runtime->status->state = SNDRV_PCM_STATE_OPEN;
-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
-		substream->latency_id);
+	pm_qos_remove_request(substream->latency_pm_qos_req);
+	substream->latency_pm_qos_req = NULL;
 	return result;
 }
 
-- 
1.6.3.3
