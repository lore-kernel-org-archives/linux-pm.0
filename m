Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511223;
	b=hyVr1duJoHUQIOPGwk4VSp3HqBW4LL15EDD3LdB7FmjhlgAh1FNsAnt0Ag/DeqBOO8sP
	 rA35bIqdtah9g+mgdCodIlz46y1f4Mdk46S3hzD/FT8oOBZH2TnIlo/6qZRyFBec8cIQ5
	 zXL2mV8CcLmo7ap3yIki9oILS3u2IpgbNm9+nHLuP58a2iJQM/rpytSQL0oy7qeK/tsP4
	 d2iw1PyqoJCQNsFzcwHRb85E/nLWsxRLMgoqwF71LG5FGeubRHxf8Cct/VWXZvUqbzF63
	 8gWNq55s3uKkx5eEIzrFXEW9Ou5VZPLtunVIhs6PM6gjFShECArBRDgOIbr1Zu2SAjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=shpIHoIpuW8NEcMIStzNPtZc+ZJ+NknyxjQZ++Y99Y8=;
	b=WS5tOfSpLmVnl2sK1qsbJ3Dkakxf70EmgFJrW3Fx4LPq5DkSw4XEKoTYgv3RICUw4WSm
	 My96W7PIVy5eKV2rKpMr5TeY4GwkIN5zj8v5ce/V47OmKKqAn6ZgQYR5yN7URz/JfeC2A
	 kJpcv7lGrqMqRuyBnxCom9IVScQye4zKakX7Kn8eazJsL4ljpp5kQt0SRIjx/MIiS+cUm
	 6wh+eQjEHU+JSHLhMnvzSk7vKphFeoKt7AsbPMzyD/B1fC12pmC0xXa/x5PDteozUmisl
	 fH+ORepTKYxpJO82B7rEg2cNvCLcBms2iD+3edAN07/CPYkBK0Ue7xNbx0FR6Aq/0yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZHJG9udv;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A2606A880
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 19:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491A2606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZHJG9udv
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so99872a12.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794511222; x=1795116022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shpIHoIpuW8NEcMIStzNPtZc+ZJ+NknyxjQZ++Y99Y8=;
        b=ZHJG9udvp1IRPSAhP/ZSpTMPUMKLOMI0evX6tE4z698cB54u5bbGg5AxuPfDBmkRbY
         Vsuu2u5QX0XnMkiqVJNCviBqGGojWSdkKqnTaWeFddgTVFrUoeTCe39uMzkotYOgSodu
         xgK1HEoK4Tukkp2A3gkSlmJLmV0u6QRDqkW2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511222; x=1795116022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shpIHoIpuW8NEcMIStzNPtZc+ZJ+NknyxjQZ++Y99Y8=;
        b=dtEJlZpBWZUzW20mGHCJlrBAfzeAN9iTdX/LMU0K9XJxoe8XsgnNt4a+a8E8ZGCAAy
         74jrJV0hET8JiTlfRgewuA+P1IUI/n2mVgRrYOzxYc2SlELkqHHvby6BaF90aWXyc3VU
         Y3ddx5KWcPzlmdI+KcrenP6NVQI5KKtm+HbaqPNs/edghgUun4FCm+t+Udo4ue6ODzk2
         nhS1+lXHfeWPGcSdXuE+5S++hweeBJ/+WUqcIgc/C6wo6qIGQG1OQZKnzQNbMc95HaMp
         bRhgX4g6ek5avJ9WCX/dZiULk1yCGniOEkYuAfMzVRtFlbLrB5POOSsfil93n0XqTgv+
         Xhmw==
X-Forwarded-Encrypted: i=1; AL+hErGI0Or8h7ihlnyqIQRmXPVkViToN9l7Ak5X0bn1SbKky9c79hOVtlHMNZgwT8IWgAz9ldi7o1Owqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wBsTIdcSM8ufttJA7ioqs+NM3Ak2FUlq73pdpJ603urk5p8C1
	sVZGFNT5XaHaizNPZygGI8KE3oV0JnlxQ5qlFBQyX8wTVXvocJjD/AME7kCpNNC/pg==
X-Gm-Gg: AYBFou1PBRS68QwtWxHHQ6DkfsuBO0VVV5xozTbs7dfZzia6hzKQ3RCypS0lSAqzewh
	4Uphpxcy/P4mxl9wmPiDnJvwYxAfU6GZZksqFKLKh8EsLqXCykuTitl44VcN1sVl/sN3PB44hes
	YyM2P2nd4ms2sma4H0EUgvWOVxx+xcPpvHdp+WpJagCh8AtoPl73y6yCEY9NUMRz93rrYvbzjHj
	l4qSescpZrxU/nMQhrfn0ibPKYtZJ8uOvQoV/++5a4yd1oqop4EyKxGuxDRiZ/pVqtzppuh8euN
	NtvDDc4QdnU2sZXNKhwV+Q0ETzs4khLpfWL397+LfOLIYzltBb32BwuUNnGN3SpIHw6BIUSAF3B
	/hQ+at1U7tUcAwk0HC2SS1qFoOmyEEqdDZykvzRxCd4ba8sGF87LpgHUmax+ciPqhnqRfBmxWHN
	m4ejiQeka6XB9eLJLa7AuEZy76DbhdXRlDdmtnABD4qWI/vlp9+TVmkRa1Jk1VF0rmjY5KeRdCp
	Fkp7MDlLQpL6J6gKuHX0kfq+1IFPXQs8WosLB/7iKvn7tiiE9EYfjTe4ueuM2hLPYjj0GmePze/
	iLo0SCr9oQu0YNUHPkSjAXwXKZOkEyE8ohOaFWs3BCTncQp/xKyUH8Vi/leCWWpXtvaF
X-Received: by 2002:a05:7300:828e:b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-37966a5ce93mr98368eec.29.1794511222122;
        Thu, 12 Nov 2026 11:20:22 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-37955f02ff0sm496854eec.16.2026.11.12.11.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:20:21 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Brian Norris <briannorris@chromium.org>,
	sound-open-firmware@alsa-project.org
Subject: [RESEND PATCH 3/3] ASoC: SOF: Discard pm_runtime_put_autosuspend() return values
Date: Thu, 12 Nov 2026 11:19:39 -0800
Message-ID: <20261112111937.RESEND.3.I90762189ee6537c5deb0725ede365d641607377e@changeid>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
References: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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
This patch was originally sent as part of a larger series here:
https://lore.kernel.org/all/20261006161337.11.I90762189ee6537c5deb0725ede365d641607377e@changeid/

I expect it should be merged by subsystem maintainers, and we can make
the return type change later.

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
index 0e8a0262b795..b0d8419addc7 100644
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
index b5bca9258f42..16deb117b7b9 100644
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
index c98307cf7eee..bd10fb39457a 100644
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
index 286486945abd..b3ae232e578a 100644
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
2.56.0.611.g1030f0b940-goog

