Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627312;
	b=BwSuItsek1xSCVL49ZpPYNOnJTXeT756bM6CXokfv2Fd/rsVZjTch7IgLGSpi2FlKHfw
	 CljzYJQOp0kZx8j5Q6AVva8HVsa6pLSAcmTnale8XZr0vnPE2mEBoZZvOncDmO2cDePv3
	 1p94FNYJFYgxlq7VFhMRGK9JN3N9wHiSOv9YMG5VroG7KP4iqBeBN94hIYbDDNJVXCWXr
	 bVOpwp95JuZFI269ZmRYSJqM2gFe8udwTDTaheQbx27M4DNJOeEUHfmS0UaOcJ41Ud6H1
	 flLBM18MnmLAsQeTpsQcu1nOs1vhXsgIldaT/Cs+y3ACm6MRiNjhbUPln6wKutaLOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A2hj0UfttoWfWnVmfQgXmyBs/YW0e/AChXA2zyZLurE=;
	b=FynjbZM1BR+cP6XGMSVfiY5L1SAqfpxDvLjLKvQKSwbWmQ3u9k7jwV39t39Iq9tB+Wgl
	 rDBqjLfY03K+aGC3RoZTrdP3hvywJPWTONuE+0EITV6O5FoozjwKNcqqDzFu9GNkgUtFM
	 sB6t/iYfdJrWYFNkWlKTkN1liKQS9mCV95sWfHdA4o6ckWUaEzT1zSflmN7OuR96jYbAq
	 nDKuOTqcyoWO0RCXkbxRfEI6SOzTvy4gpJQccAQvSz2d7KkZkJKJmf+f/nUK9czdt/Xp7
	 WbZz1x9yYk/tkyTjCln9dkwD+hF9oLzzQUSY6ZSmKMjoi3uUfFpPkefrqHMaqEaeq9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afzVRXlH;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D160A4AF6
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D01D160A4AF6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afzVRXlH
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-353804b591eso2389038eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627311; x=1793232111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A2hj0UfttoWfWnVmfQgXmyBs/YW0e/AChXA2zyZLurE=;
        b=afzVRXlH7AyuOv6MQn72cix8RjgPhIb/LYyiVfbScV3+/W3r+nXIxRv7O+d96h6sDo
         6dtVNUUUkNbYBYO7WruxmW1s1NtFcoKPzex0Gr8p5sp9U/4RR2cKDpQrY9M8ibdCj/5S
         kF5x57ccX229im/onuXbSpaJR4+sgQuzDP6Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627311; x=1793232111;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2hj0UfttoWfWnVmfQgXmyBs/YW0e/AChXA2zyZLurE=;
        b=ccquwGQbF5zz4A45TX84dNHB46+RowUaaWBiNSaaqDb6REBK94fuvBK/lcqxruwk9C
         NEFNmFrZP3AHbN+Om4GfzKYSvAbWeqvn/HnYZ4CgZr6aaGWuKrZl+iDWhiefRl+qhIm2
         bwtfg6xWBa4GA72/nFRD1sDGtFQ2plkQMaj3auTbxuqtAksf+HtfNQ4tYzn/GbJwPPrI
         lWhDZWLRHPbUI6d9ZcFEH2Qx2IybLED8Bw8GrHuZtHZTLzqZvaM72lsrK6ZmuodzDe/M
         3O8CaZBxMD7NJ0xM8WBB+TkGu5vD8k3tch7MeviN9It3qJTCVkRZVLrfor44i1F2c/yZ
         mN3A==
X-Forwarded-Encrypted: i=1; AKwUvBxJDkre2QtHUkMXAthX6xS+glAVj7DuWJ2PDyehYDPeToLH4/d28iCURUbgRQuJADu2a5o7kL9jkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdBeMIiCaJxtDMSRLz0jaIdGicrXKUmLSbfhbgpnlnzbXKeyAM
	miIbfVs31WfS8oZUpOVOyrhdGxayEOGiYLNZbdgdaGdyAJGCTEjt5EI8ZUSPCe45cg==
X-Gm-Gg: AYBFou3834mIRZQaHo99jSvFGyPE3KGDsrpLvWaeI5ILXUjs74B0LmSoe+Jroa9k2dj
	qsFaA0fVNaK6QvvHHCHxmXUTRCqd/4vEYYmfS4ETuISQ5f6Gpc+CZHSIwB9yPdJ53qliD1r9Ax9
	SFuyUkRNs1MYG+18uCxH6+yxcCliumK5vG0ogtjWESBbj7xdHnBJ8jqaJ4shzqYZGdW+Bojro7f
	K2QOI0cUxkcb6hFUlUCslO51717M282J/Z6x4nlTaofwKXtzzd+pFOvPqNP4p2RkqHJTmbBLv3K
	A7TSPvGJa2fuFuV+eGR/GGPtt1IHDLdFHvw29t/lBxLo657JqzCIe1/4HLUwGxAvzA+z3J24IOd
	+TJIUkH2mTuPvamS1ChD1jCaxu0wuJWoIfmE1XJXH6/lkBeb3EEGcU1q8WShWjFJ0Yt2WRPLtgF
	VYx33urFNk67A/e2VNAxm+RtlanuSLkxp30ZQ5s3gQgjQzP3bUTGdBYYN8kD2ItEmhGgbnWRRP7
	Z/aRWF/9P7E7xOXT/f0nBd/50CHzumAUDqDwnfbQlhhMlGZYPx+summdb9foOwy47Shb3f5QpsR
	1xSeI1wWYEAwxVMAwbW6d4a19Vw6la6d1N1sKqnD
X-Received: by 2002:a05:701b:4248:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-190a7e0c294mr4435702c88.46.1792627310929;
        Wed, 21 Oct 2026 17:01:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903a180ca2sm8704538c88.6.2026.10.21.17.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:50 -0700 (PDT)
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
Subject: [PATCH v2 16/17] iio: light: tsl2583: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:17 -0700
Message-ID: <20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
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

 drivers/iio/light/tsl2583.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 2d041b7530e6..a5b2b7fb6dd9 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -647,7 +647,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret, pm_ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(&chip->client->dev);
 	if (ret < 0)
@@ -716,19 +716,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 read_done:
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(&chip->client->dev);
-		return ret;
-	}
-
-	/*
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	if (pm_ret < 0)
-		return pm_ret;
+	pm_runtime_put_autosuspend(&chip->client->dev);
 
 	return ret;
 }
@@ -780,16 +768,9 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(&chip->client->dev);
-		return ret;
-	}
+	pm_runtime_put_autosuspend(&chip->client->dev);
 
-	ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static const struct iio_info tsl2583_info = {
-- 
2.56.0.218.g1ec904b173-goog

