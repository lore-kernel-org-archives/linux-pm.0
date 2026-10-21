Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627315;
	b=VeKRefsWns1ttKXOO7AT0CzWZQjELMBtkco1A8BddVcxllQMI2fgYAaIcTrXE+J56Kyk
	 qBnvBTk02IY0EZONXLsLmt7BpfEcsCA4WEndMovfSUW+4DW6N2uGnXLC7/4bjvxeuz7Yw
	 ZAD3hlDJwzthD0MbqLilia5xZx4odR8Z5nUl7h3ppZBOsnFEkAr/A18KjnxoLC3qrjRID
	 MU46JcvWQAE/7Ljd0/P+wMe+Vwcy+DAN36FIddLXM8+V/0pvPF9V1gJSHWPsARiQYqblB
	 4akjF3M+JMCew+CQDbqiHelCNzStDVxaFLh03Rlj+iMCLjadit6gfYIekkPORu96mDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n3xDMUCpAKA+W1udgKw6gUi4Aniek2eVFJ0ny2jPCSQ=;
	b=1Qs7OkqqXw87UaYhgWm0zuJkfXDl4VhiYuLrRk94hN39aD539GAHpvbgIRjugsVrIE8k
	 YIQaYbFuxnzKOKawheQeuK77OOB8UzhdW91FlvQM9c1xKXTX7Rmoh2/5QU/5nHK1w670T
	 TkPmugDWERCze3raYeAyp+1oAmxiCx3WGR2KDKcB3FfCSCl3L8hU/dYS16jV6QZdDZ18l
	 g9/eHb1dv+pJdudIkWdO5f9ByLvw4YW7ZqB7doiZg/Tfv3nSfBRWwQ1nIEjitPzLejT64
	 NK8gl7dGKUoSvrne+XbBrmQPKv/mj3BHJWklR3uLSxKRpXKR9B2b+kKIBmNIiwc/oaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kvIRrwjF;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605B60A380C
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C605B60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kvIRrwjF
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-157fe9d771bso1659464c88.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627314; x=1793232114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n3xDMUCpAKA+W1udgKw6gUi4Aniek2eVFJ0ny2jPCSQ=;
        b=kvIRrwjFl/SmlvjoHbZEubwmV1VUTKswii2wq2ZZEjoyn9z+qojvyG+qmSgXdXNLPQ
         07CFtQMCqOO1ZmBsLY8ITCgQvab7T6BG59XbmrP2u9l2tvkPuelMWZBZ/o1evdAlIgPf
         IqygWD7HfNf8t1a35mOslK+V/a6f6Ijkih2Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627314; x=1793232114;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3xDMUCpAKA+W1udgKw6gUi4Aniek2eVFJ0ny2jPCSQ=;
        b=aTlvMcKhIalkDVRYGukULgiBagK9raQIY7E0bJPzUaM4J1LEcmfWKW7n6cW5OJTuLD
         szw/h7gwea8G920SU4jjnqR7w5xmI9EFRKleVuSWbYgC/HuznFuU64kUJTbkYepFFwvf
         tgthH5JrCNHHXMh0ZnNkvCDKytD9kQcWW6WWTdPLOXmIMaEyzlc4fQZ4TwfdH5T07osj
         YFPdbn2OFHZXFiOO6Kz0a+hJYYI4Vm+7jRqQXMVUZ6xENE6Bcbhi3eXigVIqCBlTmBe2
         aRwJ5cuFIq5jWdlIihjTahp1i7qt0mYrwpDZTchUgyp012IkydPhjG83OKWPVBwROmX/
         bLRw==
X-Forwarded-Encrypted: i=1; AKwUvBzH5sEgyn944nafy247+nBaH98+PbQtRmSiiJUbR88/HRtCOhLLu7HgiJw77U5kp3ANbbTbGNkZ7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKdgtzW0reKYqDcduuhYxB0WLkr5nX8CyYedMxryzfpFaN713y
	1GbOB2uj9CvQKKWE6Z4Z8YJqORHIXqShObAgxY7yP+78A2gmFamP4EcD0EE8t4fRGA==
X-Gm-Gg: AYBFou1FRH2V04ySMFAqH8h0856BnNnsiF+QZWlKDpSKf4UeAt8kcvGq7+Ol6R0O1kI
	409IdGjdsOIIK+zm96SY3yTw+E29CGEABSZtjobtfqHRfDHP80/tIirMSHJ2hBmw7eFuhdBV2TI
	ztmFF51F9sjxCWYFCtsHLgfvhomcopT1i3+ElD48X9gCC+YDCv809kyMGRLDQQqRvwvY4lQ1Q92
	N7q7YF/vXmegTnaPuodU70Q+XabPF1llWWUIx8qqnAFVwaxpAc2So5NOcr/lIKaNrg43YSoTUj4
	bnBiL00LqMmRk8MLDn00AdnZDSrcoVEBI8jnIlRUeiM64iVNBbXDSzu4Glnoff497vYwzsyKqqN
	v7KaQxe0fDeWgnt3hIyxH1E7yy3M/uaHWFK2DlcLR9Lhj6R9UDPlm4BbGRu7N3msoTKOYcGkMO9
	W8uLQAVSf7L6xhBWWM+0eCaUm+IGTAtttzHO/A9hwntnoVERjFU6IBiYN1Ywt3N8dmiwvBjLskT
	WdOXwKXiTxyx6BfSrFgZeMzT/lkJodj9/JFRD/XtB4BZ1h9HB0dzDPwJr1e7jIO9zcWYev3sPiw
	QvRRBulnUixOViRA5tw=
X-Received: by 2002:a05:701b:4194:10b0:15b:7f7a:730d with SMTP id a92af1059eb24-190a632f93fmr4268943c88.28.1792627313833;
        Wed, 21 Oct 2026 17:01:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903d87ab1bsm10000732c88.21.2026.10.21.17.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:52 -0700 (PDT)
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
Subject: [PATCH v2 17/17] iio: light: us5182d: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:18 -0700
Message-ID: <20261021165858.v2.17.I2a58d2ac56600e492fd431e173bd0d67f180c6a3@changeid>
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
pm_runtime_put_autosuspend() return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches

 drivers/iio/light/us5182d.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index ab518311fd79..98279bd1ab25 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -366,45 +366,36 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 	if (on)
 		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return 0;
 }
 
 static int us5182d_read_value(struct us5182d_data *data,
 			      struct iio_chan_spec const *chan)
 {
-	int ret, value;
+	int ret;
 
 	mutex_lock(&data->lock);
 
 	if (data->power_mode == US5182D_ONESHOT) {
 		ret = us5182d_oneshot_en(data);
 		if (ret < 0)
-			goto out_err;
+			goto out;
 	}
 
 	ret = us5182d_set_power_state(data, true);
 	if (ret < 0)
-		goto out_err;
+		goto out;
 
 	if (chan->type == IIO_LIGHT)
 		ret = us5182d_get_als(data);
 	else
 		ret = us5182d_get_px(data);
-	if (ret < 0)
-		goto out_poweroff;
-
-	value = ret;
 
-	ret = us5182d_set_power_state(data, false);
-	if (ret < 0)
-		goto out_err;
-
-	mutex_unlock(&data->lock);
-	return value;
-
-out_poweroff:
 	us5182d_set_power_state(data, false);
-out_err:
+
+out:
 	mutex_unlock(&data->lock);
 	return ret;
 }
@@ -676,11 +667,8 @@ static int us5182d_write_event_config(struct iio_dev *indio_dev,
 		goto err;
 	}
 
-	if (!state) {
-		ret = us5182d_set_power_state(data, false);
-		if (ret < 0)
-			goto err;
-	}
+	if (!state)
+		us5182d_set_power_state(data, false);
 
 	if (!data->falling_en && !data->rising_en && !data->default_continuous)
 		data->power_mode = US5182D_ONESHOT;
-- 
2.56.0.218.g1ec904b173-goog

