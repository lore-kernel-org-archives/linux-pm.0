Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF14F93B9
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328814; cv=none; b=jHwTHGOCWtJP3MRxCwmYVQKlSqgeI66+Jt07wIhcIMOHfcICmqF3NgNMBCbbqudJDexdyvt5cSOr19QgCyQsAKt0u6dBppplZnOQFLsDhgj82nHlLMSbI4U2P4KvNzEH4rEzngdsvtyTnzWOF93yM3CHpNyJU9G5x7JxkhM1yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328814; c=relaxed/simple;
	bh=+r6PH4HB+WQWJr62dZukEIypy3+RL/XccpRzbSn9Log=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwWtQOxJWlcGerh64OQngFyDMOron642dJ4dfznRFh0qex4MSpRobU1oGmwKNNxujq4D1jwP3uvzSbVKcTSLz8H9lD8ED/ACruk1BAeRbYhzm9AJrr1YMWLRYEJyswCSwpfHAQejsDIsH4bDFbXVFGNCYh/qLjgmOxtDywixkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nU6vSTfz; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nU6vSTfz"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35115b52125so1367988eec.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328795; x=1791933595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vAcYfvRf3dP6Vfas4zYsUbJKP9wdfOC0aJvUADv+txA=;
        b=nU6vSTfzUBeQmsLTx0KlZ/8QFQdCaRqwt2umTY6pj2MbAbpe+HKVV9ISz762r/Lnwn
         Ltq1ECfFyoB4wg7MAthtZ1x1rUxt8xRADnsQ6ZIwIj47RO3w5r3ykBLGRGxQgr2gzJIC
         HcNp410VUf0Itvsx88OuefYmqk6wliEWdWcU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328795; x=1791933595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vAcYfvRf3dP6Vfas4zYsUbJKP9wdfOC0aJvUADv+txA=;
        b=QYTUBEra+8RirpttOC7nbYJCKsEXkcldjKIbY/1/ITxNfsV3ZFhXy1ojdkBl2W/jZb
         jT5FZF2FMB2WRy138qtk2tlKx8o2Fr9bVlBhJJBMOLC96TwXJ0XgcM8S1eRJRR4KQ1tb
         wN7Wf1qTaU+qaSyIfE/RaiLGotyeIEoG/ds2qkbtEo7FPyd19rvLE4Yoh5MWWff8MIYq
         XkxDlRNIwM6o+kjs5X51Ar63q9QhGGbyNg+ArEWXnqTGKm5VZQnUhbTDzQ+e4AGcHeGx
         HBnNOF31RH4h59UnKaVGzdR6XVVNPa1pf8/xdzwRZdg4sx/9XKw57rSjB1q6Nlvr3Lbi
         qbvQ==
X-Gm-Message-State: AFq9FYIQXY3PtMUuVmUPaI0ZGI9gErBXe5N8mEnZ9QWz3XFPt7GXgAUo
	zpJPshVMMbVnX3c7JLB6gfDIg7cklkFrJP2zZ5kfpOFSpCHQz5+yaXRFse/R5cqx5g==
X-Gm-Gg: AYBFou07AHlKcNJPga5JLk+eY2sLHA77foxz8m6KL9eU2ToNMU9pemwHmzwmBcKys4f
	upqyypoXG4flqzwlhvIli0LNneaCwaFo1wOeNh32Algagt51ViATpTY09aRku1QtOGp+DYwRWry
	kn9zoQP9rswuNgNiRcqRATjNjBKVrREbf+l2lwD8+OQ7O3kbxtIux6E8mns3BIm6WHdHwT9fb6U
	2Q9dQXoXCldhTkJgEcgLwgb1+zd8e0ek+C1s4Z0lsxkATt0Bd5J/3d/ChJhrPL3lSQEFUswczFe
	9eV//z3BvzKmij91MrblsM+8kESBAezkeZma5/SaayyJ30hJwM9knEEh+ZnVyglRvxnnmb6D5O2
	bv31yEaj/OtQGAUJq1/z1s+fdkVN8NegGP9p2n0B85zF1jQZXoOC994WNqFdZEDeg91XefAlMaB
	l1JRhIjmb9fSLUIL+f48AgRRzVNrN6k3FhqloByTa5Bio3mmk8k+ND16JgELrBynZ/thLkOHi2d
	YOdME+GMr1u5xPfnNT4QU1hZKFWU9LEduKH59Q=
X-Received: by 2002:a05:693c:65d7:b0:351:202c:c7a5 with SMTP id 5a478bee46e88-3515d7183femr385288eec.0.1791328794653;
        Tue, 06 Oct 2026 16:19:54 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3515a8b7c5dsm1985276eec.0.2026.10.06.16.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:19:54 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 04/13] media: venus: Discard pm_runtime_put_autosuspend() return values
Date: Tue,  6 Oct 2026 16:13:32 -0700
Message-ID: <20261006161337.4.I574fc3def9965f603755a968ae88309aafdfa285@changeid>
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

Propagating the pm_runtime_put_autosuspend() return value to callers is
not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update the Venus vdec and venc drivers to simply discard
the return value of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 drivers/media/platform/qcom/venus/vdec.c | 10 ++++------
 drivers/media/platform/qcom/venus/venc.c | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6a43ea191da1..35c1b6ec1f9f 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -644,12 +644,12 @@ static int vdec_pm_put(struct venus_inst *inst, bool autosuspend)
 {
 	struct venus_core *core = inst->core;
 	struct device *dev = core->dev_dec;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&core->pm_lock);
 
 	if (autosuspend)
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	else
 		ret = pm_runtime_put_sync(dev);
 
@@ -671,7 +671,7 @@ static int vdec_pm_get_put(struct venus_inst *inst)
 		if (ret < 0)
 			goto error;
 
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 error:
@@ -1200,9 +1200,7 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		if (ret)
 			goto put_power;
 
-		ret = vdec_pm_put(inst, true);
-		if (ret)
-			goto error;
+		vdec_pm_put(inst, true);
 
 		ret = vdec_start_output(inst);
 	}
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 79acf7c1ec9a..3c7c24dd7159 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -617,12 +617,12 @@ static int venc_pm_put(struct venus_inst *inst, bool autosuspend)
 {
 	struct venus_core *core = inst->core;
 	struct device *dev = core->dev_enc;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&core->pm_lock);
 
 	if (autosuspend)
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	else
 		ret = pm_runtime_put_sync(dev);
 
@@ -644,7 +644,7 @@ static int venc_pm_get_put(struct venus_inst *inst)
 		if (ret < 0)
 			goto error;
 
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 error:
@@ -1275,9 +1275,7 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto put_power;
 
-	ret = venc_pm_put(inst, true);
-	if (ret)
-		goto error;
+	venc_pm_put(inst, true);
 
 	ret = venc_set_properties(inst);
 	if (ret)
-- 
2.56.0.360.g66cac248cb-goog

