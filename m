Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627282;
	b=Y54sctswa3EcxS1QNOk9c7tQxp7LDXrjozNG5nYoUAfV6GYBDe4/dDP2rQ8i6ST9eaHv
	 1cKCOxRbX7ecsVw5DBAdTI7irKKClg0ptdWnyTMARyxJvVNygJxeO+zMb2S2Ut1g5gZxz
	 9Fx5IA9otQB7pwBBq6BedFIRLPeLv0e1yCuJBSp8Ss5XCN42+cB5PTz9mmYKwTLwBePfi
	 a6/nQtASvRwOtcUps715Nv9slTXzT2p+PO6SLjsepoaruieikrt3xtsFi+CkLyTOMvxny
	 B+3wUqxVkScSNjp0gXWzN51x4nFd3DyN4kJX/T6mhOvV0GMwOtIu0rt2Zk1RfDwB4lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QhFY06BE5+5Ny++OsMlUpBWCJIit6t0dr+PR4S2GFPQ=;
	b=Bb7uzrx+iqSAYymWXR2UAYljd7sfuJFUnny2+PpAce5em/NWSNv6oT/AN6vliDAf8fu/
	 hPZWWLKhb83+X0w73fmXjo55Yxmt8DcYZ+jrnk3xBkxszIVEH7pfk7T7SpOqnD4JRqM+G
	 U8HDlqi0WQ4aMjn95RNaU8fxGy1FmIlklQDf53XsJCGaAazGrulbWGILiLr3ppCh8j2QF
	 ZHodszUKxMdL6vYHbwURdKS5m4JhzacHFxFkMT99L0WgdB3lLQ+1vbFR1EIIKU96AQPNx
	 nyu2hrQWZi+tW/EYmF7mVBrEK92Mj/PdA3A7RceLkKfR9blhWVBk+Wh9ur1nFnqNd6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mHDJQO7R;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D16606A31F
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D16606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mHDJQO7R
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3550c917fd3so1717451eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627281; x=1793232081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhFY06BE5+5Ny++OsMlUpBWCJIit6t0dr+PR4S2GFPQ=;
        b=mHDJQO7RHSt8C0nb9o9/P45YFrQ1u2ObK225d5PFwb5QNfM4xlE+GGtv0JoPBXuB34
         ECuaEzjJI13qpryHWfPrRyJVVa2l2nJoXe1xZqMOX7A9A3+01CPCv16KrOykup3V4MbK
         RNZ/MpnN9sSljSGHlKVFMNor1VaBXPQ5hVFrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627281; x=1793232081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhFY06BE5+5Ny++OsMlUpBWCJIit6t0dr+PR4S2GFPQ=;
        b=HuDBCkJE/KYwnzz6kD32EB1Q/1ZYBXjO3Oroe3tansQOL4CkLKvE4amDsco4gJt9Sz
         TENkfwKBPLDkHh85y0wBySMot1YQahEuG/lhAtJpxFkWVWx8aLIvrvm6zcrsO39TwFCO
         jYQtSxwCefCE3PE4GMXsK9PlJ3vz2HFiaXa6VCoqVjB86pkxYhGAFJZqql7BFrMldPbx
         kJhVseWuS8SdZaRO7He4qMJopbBxx+QsM52re4u7vO1M0M5mRAraWtxsEhN3CzNJ4Pn5
         8HKPDn+lVscHStZ3aVnkhFmXkWhjpKyh823jIKnj16LzOgSG/aQjKAQxpPioiFAkaZyL
         zORQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZCi7N8Apf6RnjLQZIx9+JWRPT/87+Vl2kAM/YwP5emN24yGaohzRlSNnDBTWBA6gupIvIYv3nVQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1z6JWaC0rY6GtNWdXueQvRPDoxebV3vdLmMuMM3gl7s3sZ24w
	VVHtY7zP3znTfQvFpX2NNdV8nygugXOSFddw2MBTakMm4juXJXGHhvtmbo40iGOsPw==
X-Gm-Gg: AYBFou28cdiCA2HpiEFE0LOdE1MNUU2aRPqxWnXKqoiVeq2+SXvWWtctxG0so/fFSy0
	aTip/3Wi8uQmUX+NKtJPWxxoDvzSb9TrTqGvkAN82K2jUZt5XTnb02ZoaE6P+8ygsm/321KU0Gp
	P4GdilZI2OqDOSa7Hwjwg0el7QhzEtNfVO0DnXBNbis+4Fcy7mPGla1yq1BytNLBVVI/Bpuwk77
	N6Qj/A/76aeKMrL+sEgzgiZA7v6otQsjVm8Mwnu1Lp/oTSesaxXJYHPxmNwKciOADexB4ptPniT
	J3+UZqVgTe/hjyz3kFH4LMONS8s11iFGyr09omch8KybhbZSHFb4bZwdpGJC+53wVWptCInbsjT
	FhXCUxn/YDiP9oqIX4ErnuoNWfoVXpmJ5Wbs65R541pTs+JLsP97tR7/hWn34L2dsrIzqr9HE+z
	vfr9Jvux+TYQcq+vwF1z0jjygculuamOJ0p7SS/a9cYKmVbtPCzc32DFiNHDkMWR1KNyteFB+TU
	1j3Z/zC09r2XNRgJ4zJpwGiJLnxtLkcwuRn+LIra4tRC5bHdHbCj6IJOi5LLAyJuHvUnn+vsT9X
	0n8Ul5Ff5eEtGosXMSA=
X-Received: by 2002:a05:693c:8399:10b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3674a40738emr5533249eec.5.1792627281152;
        Wed, 21 Oct 2026 17:01:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3674198f1d8sm15879233eec.24.2026.10.21.17.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:20 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] iio: accel: bmc150: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:06 -0700
Message-ID: <20261021165858.v2.5.Ib5830d24f9dc7f06103c568f53134ecb7825ca4f@changeid>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
References: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value, and inline the pm_runtime
helper, now that it behaves the same with and without CONFIG_PM.

While at it, I notice that bmc150_accel_set_interrupt() mismanages the
reference counts. It should only drop a reference after it's done
touching the hardware in question. Adjust the local &intr->users
reference count alongside the error handling too, to ensure proper
balance.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining
 * Refcount ordering

 drivers/iio/accel/bmc150-accel-core.c | 75 +++++++++++----------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..9ad6429fb584 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -326,29 +326,6 @@ static int bmc150_accel_get_startup_times(struct bmc150_accel_data *data)
 
 	return BMC150_ACCEL_MAX_STARTUP_TIME_MS;
 }
-
-static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0) {
-		dev_err(dev,
-			"Failed: %s for %d\n", __func__, on);
-		return ret;
-	}
-
-	return 0;
-}
-#else
-static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_ACPI
@@ -530,24 +507,18 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to resume: %d\n", ret);
+			atomic_dec(&intr->users);
+			return ret;
+		}
 	} else {
 		if (atomic_dec_return(&intr->users) > 0)
 			return 0;
 	}
 
-	/*
-	 * We will expect the enable and disable to do operation in reverse
-	 * order. This will happen here anyway, as our resume operation uses
-	 * sync mode runtime pm calls. The suspend operation will be delayed
-	 * by autosuspend delay.
-	 * So the disable operation will still happen in reverse order of
-	 * enable operation. When runtime pm is disabled the mode is always on,
-	 * so sequence doesn't matter.
-	 */
-	ret = bmc150_accel_set_power_state(data, state);
-	if (ret < 0)
-		return ret;
-
 	/* map the interrupt to the appropriate pins */
 	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
 				 (state ? info->map_bitmask : 0));
@@ -564,10 +535,18 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 		goto out_fix_power_state;
 	}
 
+	if (!state)
+		pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 out_fix_power_state:
-	bmc150_accel_set_power_state(data, false);
+	if (state) {
+		pm_runtime_put_autosuspend(dev);
+		atomic_dec(&intr->users);
+	} else {
+		atomic_inc(&intr->users);
+	}
 	return ret;
 }
 
@@ -625,8 +604,9 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
-	ret = bmc150_accel_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
+		dev_err(dev, "failed to resume: %d\n", ret);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -635,16 +615,14 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 			       &raw_val, sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
-		bmc150_accel_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
-	ret = bmc150_accel_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
 
 	return IIO_VAL_INT;
 }
@@ -1477,8 +1455,14 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 static int bmc150_accel_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "failed to resume: %d\n", ret);
 
-	return bmc150_accel_set_power_state(data, true);
+	return ret;
 }
 
 static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
@@ -1540,8 +1524,11 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 static int bmc150_accel_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 
-	return bmc150_accel_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
-- 
2.56.0.218.g1ec904b173-goog

