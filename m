Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257851AEFF
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328850; cv=none; b=YVpB4M6wo43nkDfMU9IqHPqxR/9OmTx47oXn4WZM64+fpDyaTZ9jX7NlKan758+aia+TKQFkbo+Kde0Bu4WgIYbBrFYx1/rv5Jgiwj10cByuwBLK8IWqygdHsUZ7W7da5N1XLjudZh16GFeTLFRGTu1PqIM6HeLqmo00HlXx5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328850; c=relaxed/simple;
	bh=CTerUSH9LQfA2XtEGuqOy5Es4RXD9p0qFPYTOjjvblc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOmjcwLiREvokFaFI9//s0QAgmAOjg0DXA13tOGamzBrtTF0z4XMYn7Zw0SItcEjG7ZFP+RylgLmWss2Jo4VF6lVTCOslCgLyurmN6jiXVSsHZx5LLdqUDd4eNYysIKe9gu+33cm4SjBRlzjHnb0KQC0qccj0myvxDRmT63K/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TNjL9HZz; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TNjL9HZz"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-34c89609923so254974eec.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328825; x=1791933625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZAE9NSsGVCNDJfkFk+D3J312SzagpTg6rFyuPqGum8=;
        b=TNjL9HZzZpu5z/SjIRgpH+HCSOmkxC1Oke/1kAW8HHvdr930o5tHgkByUcLDyjAotr
         ldrsMMRBChk+2pG4XuDOqHWYF+4zaoxuMgHk4u2hf7x4UJ0VBPuWkoKuOLJ7YTVNbeLl
         9LoSBschgNUR4RYPPK+eiIY3bTedGS1RvKId0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328825; x=1791933625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZAE9NSsGVCNDJfkFk+D3J312SzagpTg6rFyuPqGum8=;
        b=lWZHQeugT0n6UvUQ5evGxuXufJ4tR48pWRaRrFZoouN48fKgbZcohyd8GdvzLWQ3yZ
         FLDmI/VdVP02ZYREXBhqb1hv6Nl7b+M646oOD52oyfIV3G/H+SHUCFBpxTdDO73pWOsC
         ZsHxysEIaw/beg7xZGDyWG52MqyO28xhy0HXMTj3yl+/usGwdeL/Tp6wfhDyfrDkInis
         NOjSgh/ggjelcg9lS0RKB9VRor3gKN0YXRuP2lhakXAOpYOSAi5zrEkQf+wCDqTE16tv
         O71+ifQ7gEpQxsMlhGu8uVjBwRjHAAgAWkZSFU0mcBo63yJVE71uy3mEo1FHcXUTqLsC
         liSw==
X-Gm-Message-State: AFq9FYIZoZ8xqpgX+dQjYY0obZf8BidSGTjG5Xy6bD6OHO1zkzkYMm9V
	bspG6/oqdSsumtIBA3PPI6Ha75tlsExZ8PjKG19vXxNvj/czLY5nZbhRSbi+VQ5buQ==
X-Gm-Gg: AYBFou09gJ5iZC1Q5MtPBRfmJIal+c5jwt0hsWk7SaAMy+fC+B6Ln313XMtMJrWn6Ti
	KQbMO1hU8Cn72Bhb4CA4gRHPjIXa/kuOvfUmnnGik6MBxvHGJtoPeplFfbZfsI9QXikicjlwRAc
	eHdPvwK374fXMGTzTCqgKq3Vlw+VSqz3vdhqKR0f02flPqjUlu9qBxuM2oe4DsC4wmKuQUKecTK
	anGWXW8Uwtt7df1uexJVU72+TgE6wlKRt8mYcdWOTondT5PFwRRIS5+xUoJSaEtFhZsVKQWftsu
	Uc4+C8vf77d6hy4Dh9bTe4TuNTjwwAFDdV769sIMl+G06kRdipEbDg0hwmhO+3Z3V+47/TbunDb
	fQKoe5sB2yS1ys6TroBbK8zLISMWkh3yt1DqkzdYmkNT0tl34244R16P99cGJ+ivU6gNEmfBK8X
	AIA2Ko8ICCBeWl52nSLoVlug/kdjJJpKvBGHwWp2ywwepMOPay//8jkT0bmGK45tyCuS4lYV6JO
	VmggwweKbUf7d2XheFlxf9abf3hB6uPgu2Vzw==
X-Received: by 2002:a05:7301:488e:b0:34b:529d:6263 with SMTP id 5a478bee46e88-3515de84167mr350155eec.33.1791328825471;
        Tue, 06 Oct 2026 16:20:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3515af67000sm1727136eec.17.2026.10.06.16.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:20:24 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: [PATCH 11/13] ASoC: SOF: Discard pm_runtime_put_autosuspend() return values
Date: Tue,  6 Oct 2026 16:13:39 -0700
Message-ID: <20261006161337.11.I90762189ee6537c5deb0725ede365d641607377e@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Printing error messages on pm_runtime_put_autosuspend() returning
negative values is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update the SOF driver to simply discard the return value of
pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 sound/soc/sof/control.c                        |  6 ++----
 sound/soc/sof/sof-client-ipc-flood-test.c      |  5 +----
 sound/soc/sof/sof-client-ipc-kernel-injector.c |  4 +---
 sound/soc/sof/sof-client-ipc-msg-injector.c    |  6 ++----
 sound/soc/sof/sof-client-probes.c              | 18 ++++++------------
 5 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 74d997a4f620..8718c293c5b9 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -185,7 +185,7 @@ int snd_sof_bytes_ext_volatile_get(struct snd_kcontrol *kcontrol, unsigned int _
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
-	int ret, err;
+	int ret;
 
 	/* ignore the ext_volatile_get call if the callbacks are not provided */
 	if (!tplg_ops || !tplg_ops->control ||
@@ -205,9 +205,7 @@ int snd_sof_bytes_ext_volatile_get(struct snd_kcontrol *kcontrol, unsigned int _
 								binary_data,
 								size);
 
-	err = pm_runtime_put_autosuspend(scomp->dev);
-	if (err < 0)
-		dev_err_ratelimited(scomp->dev, "%s: failed to idle %d\n", __func__, err);
+	pm_runtime_put_autosuspend(scomp->dev);
 
 	return ret;
 }
diff --git a/sound/soc/sof/sof-client-ipc-flood-test.c b/sound/soc/sof/sof-client-ipc-flood-test.c
index 2396cc35489a..a86dd5630790 100644
--- a/sound/soc/sof/sof-client-ipc-flood-test.c
+++ b/sound/soc/sof/sof-client-ipc-flood-test.c
@@ -157,7 +157,6 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
 	unsigned long ipc_duration_ms = 0;
 	bool flood_duration_test = false;
 	unsigned long ipc_count = 0;
-	int err;
 	char *string;
 	int ret;
 
@@ -223,9 +222,7 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
 		ret = sof_debug_ipc_flood_test(cdev, flood_duration_test,
 					       ipc_duration_ms, ipc_count);
 
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
+	pm_runtime_put_autosuspend(dev);
 
 	/* return count if test is successful */
 	if (ret >= 0)
diff --git a/sound/soc/sof/sof-client-ipc-kernel-injector.c b/sound/soc/sof/sof-client-ipc-kernel-injector.c
index 02d0d97ad1a0..751d6a0bef79 100644
--- a/sound/soc/sof/sof-client-ipc-kernel-injector.c
+++ b/sound/soc/sof/sof-client-ipc-kernel-injector.c
@@ -66,9 +66,7 @@ static ssize_t sof_kernel_msg_inject_dfs_write(struct file *file, const char __u
 	if (!ret)
 		sof_client_ipc_rx_message(cdev, hdr, priv->kernel_buffer);
 
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", ret);
+	pm_runtime_put_autosuspend(dev);
 
 	return count;
 };
diff --git a/sound/soc/sof/sof-client-ipc-msg-injector.c b/sound/soc/sof/sof-client-ipc-msg-injector.c
index 932ab459c079..2eaec52ab439 100644
--- a/sound/soc/sof/sof-client-ipc-msg-injector.c
+++ b/sound/soc/sof/sof-client-ipc-msg-injector.c
@@ -122,7 +122,7 @@ static int sof_msg_inject_send_message(struct sof_client_dev *cdev)
 {
 	struct sof_msg_inject_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
-	int ret, err;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
@@ -140,9 +140,7 @@ static int sof_msg_inject_send_message(struct sof_client_dev *cdev)
 			dev_err(dev, "IPC message send failed: %d\n", ret);
 	}
 
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index 124f55508159..32e31d6aa9bb 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -211,7 +211,7 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 	int remaining, offset;
 	size_t num_desc;
 	char *buf;
-	int i, ret, err;
+	int i, ret;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
 		dev_warn(dev, "no extractor stream running\n");
@@ -258,9 +258,7 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 	kfree(desc);
 
 pm_error:
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs read failed to idle %d\n", err);
+	pm_runtime_put_autosuspend(dev);
 
 exit:
 	kfree(buf);
@@ -294,7 +292,7 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 	struct sof_probe_point_desc *desc;
 	u32 num_elems, *array;
 	size_t bytes;
-	int ret, err;
+	int ret;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
 		dev_warn(dev, "no extractor stream running\n");
@@ -327,9 +325,7 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 			ret = count;
 	}
 
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
+	pm_runtime_put_autosuspend(dev);
 exit:
 	kfree(array);
 	return ret;
@@ -360,7 +356,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 	struct sof_probes_priv *priv = cdev->data;
 	const struct sof_probes_ipc_ops *ipc = priv->ipc_ops;
 	struct device *dev = &cdev->auxdev.dev;
-	int ret, err;
+	int ret;
 	u32 *array;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -385,9 +381,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 			ret = count;
 	}
 
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
+	pm_runtime_put_autosuspend(dev);
 exit:
 	kfree(array);
 	return ret;
-- 
2.56.0.360.g66cac248cb-goog

