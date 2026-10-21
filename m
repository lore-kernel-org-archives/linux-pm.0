Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627278;
	b=nUEqiHklJq10t/CqmEQdXCDIWaGcpYVwMTPQe1OtFCOcl5H4yhznTgX1brKYJp6cSZmu
	 pNryxkawBWr5ZeVWbKu3Xw/sXyO/2R7gDxw49fQxnlwG/Yflt3ZWygTqrdxKPbT8oiq1d
	 OxqU10Mq0d4OAbUk0BvANCw9QK5SZhdpI4RHAEea4mYHlYkDUseI5jDDrsJJrFxX9s4go
	 wGLhig7wxQ8eRJZEzUfucb2mZRvr1nLbXGl0v6nIUkOHwpHdd3wA1bO0fec3ndR58N/X4
	 qYSGw5tmyb6I1FSkIVDm4RvatSDitrWLgxq/91jkqpnNVwniJSrO6J9FJAe3C3a7P8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UkAsoLMeActYKyns6ZTYz7sV5mC0lERrrNy6cvdT+bo=;
	b=NQR3VymlHAoFiZagDcjRgAGVznJiQRsB1cDrNrk4RPyGd1vTQW7PS7eKqkjd9BGO4AWo
	 QrhzVjG9ncp6yFsMsAkUrWaQiuhN2DW0mCUrmaRW+bcEAg7/k5BC1KYGc8IWMkpZ7gm6S
	 qaX8N1hjBFIIvlWq5Rm11fZFTGm+MXs6BSvT20x+f31/QUTfSCsqwJONGKsCEpP//NdHY
	 q3WOx9hzxgANiYkg4tLXXRI5rhdwivESHGAzcqfKBNFnKN6Y8ipCFSc5m7AyAI6Hbufz1
	 Z9uMdb6gRsIWko7rn2v3QQQJmmVsC0C+27UOkdy0x8V8jL2A+wmxeScRxefD6F2mjfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OkvbgxbH;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23790606A333
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23790606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OkvbgxbH
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so3491051eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627276; x=1793232076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UkAsoLMeActYKyns6ZTYz7sV5mC0lERrrNy6cvdT+bo=;
        b=OkvbgxbHMZnSAk8CTquPIubABB8DrdxIk8wRnLiASUwQGSmYvdGCzV1C02/c6B13qF
         IgEcHEBHUQ7iCzGKwuOlGzo/rXfYtEUeVNjm/RelAayCIIboVTtN9b6vH3yRHaTucRb9
         hu/3+YqfTzzHcbGoYGlkRRW655YChl20icXuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627276; x=1793232076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkAsoLMeActYKyns6ZTYz7sV5mC0lERrrNy6cvdT+bo=;
        b=KnC2RNpD7pFnb33yHDw/XPBG+sKoP1gxPMD8o1YKWDJ0of7EOGTvObCxkcVgmkJDcp
         Nbieqdty0NmMlFpiIR032iNOBIyQPYLoBfAj56wGX3DiC0gfKW4FuPb/43glPSXeA29q
         4VGKYqU35WCFnb1BWdb2j0t2CDV6i5nieKd4mCV1bEArBVuRojLA2B71Fx8dyLR/0gBY
         PBvNrxqpVB3RZZOGn5LlOrRm4KKoWqtFfuZ2YwYvYLjXlFUNT21LYu4cptyUILzupy/d
         81ezwdu/Gf9wmonW5DZrlCWz3vQzpjq597X3/rg5/synj/cO3HFc5G501+QWy98pDCHu
         lSig==
X-Forwarded-Encrypted: i=1; AKwUvBydaxfxzl4Cj25E05u6E9JERPVq364z+q9OZ8i9+S74PyDU47f/lqjD3Pl2c0H8CEqjo4EW8xBgHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK5/aOanZBokettSecwEV7oD4AOjIjGqodM6wq2dL2MxDz9KCLD
	qTavRIBZOl01CNP3Ms/THbm/eivjyozKLPN2IaP/IUoysaNsijRyUmSX2oIZVkz4xQ==
X-Gm-Gg: AYBFou305Hy2btzvKvkQ4QohgbEPDAoFRQ0K5h9A4EjO8X7/4D/TGnw9DDUipedWPI/
	im64k8yw6kwR2W/i/GPyEQlFDbE9cgKZGRXDBJbwc+p0Hvf5RnZfJrIXWnfThwLT9vwo4P1Fylu
	ZKL/8jo9lufZezjGxkm26ZtVd2xuHNR/3ud6Mm+KsNZr3DVk/3cKOpPYmRLGrNYsjCXQbFDI6NH
	StfJhxBFiI//PH350DB/uXUtUVaJf4lklm0kSJITOeBO5oSw9UYdowldVTC3O1CZX1+a3yJ4iKa
	TLsdo1vrVRpNslcmG5aMicoz1N5qy6pqY71oASr0FjEICklLQeHqLuSP2IorJO/j7vZdc7Vi/xo
	PXoN5ypfaM6VQohGw5wYBgVeTzPelMAy0zvGIm7+witD4tNrf06etNa3YT4tuGzQ26AEQx9OJ3m
	mtiP4A843rtx0VJAuGC40uLJDEPCeYIX99VHaY9DlukUy9WLGrUiyhZ3JL9xJRho6zs4DHqvWMi
	kzXYSShT80cBNowGuCYgnjrn+K69hlsnZupub/C0cs5n6wT8Rk73yIflwyWCwYPEJlrPTqWa7S/
	fVp6y0MQolRSVe8M3WQ=
X-Received: by 2002:a05:7022:4586:b0:144:fd7c:84fe with SMTP id a92af1059eb24-190a67fc71cmr6323768c88.35.1792627275807;
        Wed, 21 Oct 2026 17:01:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903d3ae06fsm9737854c88.19.2026.10.21.17.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:10 -0700 (PDT)
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
Subject: [PATCH v2 03/17] iio: accel: mma8452: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:04 -0700
Message-ID: <20261021165858.v2.3.I0ce530b298f72acf4015d898d8b2aaee89482b8e@changeid>
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
helper, since the behavior is the same with and without CONFIG_PM.

While I'm at it: I see that mma8452_data_rdy_trigger_set_state() and
mma8452_write_event_config() mismanage the runtime PM reference count,
and instead rely on (racy) autosuspend delay for correct ordering.
Undo this choice, and instead properly drop the reference count only
after we're done touching the hardware.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Rebase to linux-next properly
 * Drop a few drivers' changes, as they stopped checking
   pm_runtime_put_autosuspend() return code already
 * Split iio patch into per-driver patches
 * Inlining
 * Autosuspend race fixes

 drivers/iio/accel/mma8452.c | 100 ++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index fe62a903f0e2..7466c40f6239 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -220,26 +220,6 @@ static int mma8452_drdy(struct mma8452_data *data)
 	return -EIO;
 }
 
-static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
-{
-#ifdef CONFIG_PM
-	struct device *dev = &client->dev;
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0) {
-		dev_err(dev, "failed to change power state to %d\n", on);
-
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 {
 	int ret = mma8452_drdy(data);
@@ -247,18 +227,20 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 	if (ret < 0)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, true);
-	if (ret)
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "failed to resume: %d\n", ret);
 		return ret;
+	}
 
 	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
 					    3 * sizeof(__be16), (u8 *)buf);
 	if (ret < 0)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, false);
+	pm_runtime_put_autosuspend(&data->client->dev);
 
-	return ret;
+	return 0;
 }
 
 static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*vals)[2],
@@ -974,17 +956,25 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, state);
-	if (ret)
-		return ret;
+	if (state) {
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to resume: %d\n",
+				ret);
+			return ret;
+		}
+	}
 
 	switch (dir) {
 	case IIO_EV_DIR_FALLING:
-		return mma8452_set_freefall_mode(data, state);
+		ret = mma8452_set_freefall_mode(data, state);
+		break;
 	case IIO_EV_DIR_RISING:
 		val = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
-		if (val < 0)
-			return val;
+		if (val < 0) {
+			ret = val;
+			break;
+		}
 
 		if (state) {
 			if (mma8452_freefall_mode_enabled(data)) {
@@ -997,7 +987,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 					ev_regs->ev_cfg_chan_shift);
 		} else {
 			if (mma8452_freefall_mode_enabled(data))
-				return 0;
+				break;
 
 			val &= ~BIT(chan->scan_index +
 					ev_regs->ev_cfg_chan_shift);
@@ -1005,10 +995,23 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 
 		val |= ev_regs->ev_cfg_ele;
 
-		return mma8452_change_config(data, ev_regs->ev_cfg, val);
+		ret = mma8452_change_config(data, ev_regs->ev_cfg, val);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret) {
+		if (state)
+			pm_runtime_put_autosuspend(&data->client->dev);
+		return ret;
 	}
+
+	if (!state)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+	return 0;
 }
 
 static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
@@ -1447,20 +1450,39 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int reg, ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, state);
-	if (ret)
-		return ret;
+	if (state) {
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to resume: %d\n",
+				ret);
+			return ret;
+		}
+	}
 
 	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
-	if (reg < 0)
-		return reg;
+	if (reg < 0) {
+		ret = reg;
+		goto err_put_pm;
+	}
 
 	if (state)
 		reg |= MMA8452_INT_DRDY;
 	else
 		reg &= ~MMA8452_INT_DRDY;
 
-	return mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
+	ret = mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
+	if (ret)
+		goto err_put_pm;
+
+	if (!state)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+	return 0;
+
+err_put_pm:
+	if (state)
+		pm_runtime_put_autosuspend(&data->client->dev);
+	return ret;
 }
 
 static const struct iio_trigger_ops mma8452_trigger_ops = {
-- 
2.56.0.218.g1ec904b173-goog

