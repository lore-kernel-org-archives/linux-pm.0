From: 640E9920 <640e9920@gmail.com>
Subject: Re: [PATCH] PM_QOS updates 5 of 6
Date: Sat, 13 Mar 2010 16:35:17 -0800
Message-ID: <20100314003517.GF17812__25428.0500500046$1268527237$gmane$org@mgross-acer>
References: <20100313214857.GA3079@mgross-acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100313214857.GA3079@mgross-acer>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, aili@codeaurora.org, khilman@deeprootsy
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 13, 2010 at 01:48:57PM -0800, mgross wrote:
> Date: Sat, 13 Mar 2010 13:48:57 -0800
> From: 640E9920 <640E9920@gmail.com>
> To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
> 	dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com,
> 	aili@codeaurora.org, khilman@deeprootsystems.com, pavel@ucw.cz,
> 	mgross@linux.intel.com
> Subject: [PATCH] PM_QOS updates for 2.6.34-rc1
> User-Agent: Mutt/1.5.20 (2009-06-14)
>


 
>From 4c9730c7043359b99acc0fcc07b3417f6fb65493 Mon Sep 17 00:00:00 2001
From: mgross <mgross@linux.intel.com>
Date: Sat, 13 Mar 2010 08:23:27 -0800
Subject: [PATCH 5/6] PM_QOS-to-use-handle-based-requests-pcm-update

Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 include/sound/pcm.h     |    3 ++-
 sound/core/pcm.c        |    3 ---
 sound/core/pcm_native.c |   14 ++++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 8b611a5..dd76cde 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -29,6 +29,7 @@
 #include <linux/poll.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
+#include <linux/pm_qos_params.h>
 
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
 #define snd_pcm_chip(pcm) ((pcm)->private_data)
@@ -365,7 +366,7 @@ struct snd_pcm_substream {
 	int number;
 	char name[32];			/* substream name */
 	int stream;			/* stream (direction) */
-	char latency_id[20];		/* latency identifier */
+	struct pm_qos_request_list *latency_pm_qos_req; /* pm_qos request */
 	size_t buffer_bytes_max;	/* limit ring buffer size */
 	struct snd_dma_buffer dma_buffer;
 	unsigned int dma_buf_id;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 0d428d0..cbe815d 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -648,9 +648,6 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
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
index 8728876..605c86d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -481,11 +481,13 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
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
@@ -540,8 +542,8 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
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
