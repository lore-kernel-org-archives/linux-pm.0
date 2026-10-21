Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627290;
	b=v34nzFMhAidosMeeUYK9pCZ73z8+ics+S9ytkC/txH0RH3xud/DtLFYSylUsi7nycR49
	 rX0f6+i85LNPVDADuiLOl0zB/tTVPPPtZlIcEYvLcIsNoCgxizIMuMcEhGTveJG+FkC/A
	 pjQIeHXP3jhlI++QOYFp3IuKqEEzRN2taervipV+isaeIiANYkMNscksbGAN+ALwU2gsp
	 62BLpJR846FOOvVImd+FuFEdKP/OTKiuTdZbKsFTGfDh4dvPugaTIRUtiRpkbbTC3lIby
	 wLDznAwH8t6/8QNW/IJ0xkGZz0NWjh7rqb+vNPMUIr7JqScxndnWyNCHN6moL0edJ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qGPgAY2uzbFWVW1gwGK7OSQ0FTtWRIw5OwqDXn3zsW8=;
	b=FY9Ts2sqeNSTDGpADtMUennoymDUDrqqW/u+2G4OqOYC8OEaN0qWxpK0bc653Y3oMXB2
	 BhAJJiuuidWj5WCefmE4Ko0GttmyMMnF/g682NJ+LFdQVhmzc7BSIn1c7jPdy4p+7WlIV
	 9TOQSrF6toNV+vCVwMrfGUyR9t+k520EDrvtS+KgvzGVBas673W720T1BI8ckXvTy2Rd7
	 gNxsj558NKroUjjeCpTaNBTYUcwIfrRtcN+Ge3Ml3KpvG51A2rFfbgxaI3Qk/em5LAYHm
	 765Kuo40JftPTnQ9ZMJgTfs4rNWhR+V86+ozqTclKSLlod7G3viwiYixrD0D+LjhX0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WIFND+kT;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8060A3804
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E8060A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WIFND+kT
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so3012091eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627289; x=1793232089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qGPgAY2uzbFWVW1gwGK7OSQ0FTtWRIw5OwqDXn3zsW8=;
        b=WIFND+kTBwBCsBYJNd1wpQLhBQ+sITxmOuOQV6VZxXbnAKapDVGgjeSp26Q37/WxrX
         CupVn8dGVWLQLfysitFEgwtRNtjR/s1eV/liJOqQVF69QLg8Yum64TcWI1pFs2S7yAUy
         ogArNfoZMqceGQfsV5l+PUi6SDdOX+qgbIvYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627289; x=1793232089;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGPgAY2uzbFWVW1gwGK7OSQ0FTtWRIw5OwqDXn3zsW8=;
        b=Ma6VPjwwkaMGJGVGAK455j1unSxXGHcfSKBBtaArGoBHH7Lfm/Wtj2MHWfSeXZhrsx
         cFhOtgoP/5u5Mybvg5VfSOzju3QrMOnURB237f3/o/uj96OvQl06n/q+zSm1k8pk4vXw
         h0G/OMY6Gu6huw6/95J5uefTnwYyztiLkpZzBsm4yD2tnKBbPliM/vjSOZ1XsZvvr+tA
         XD4vOhJs9no0RsFL4pDefWoyAoKiVFuwDqUXC5ZROCI31skTVbStwWNFuS69ZiDgvj1x
         qcGfBysw5ej8Zvnsosizl9W2m/LAZEJq5HNMXby25/s0HH3ax77GKK2qah4n8U0H4QiZ
         PsUg==
X-Forwarded-Encrypted: i=1; AKwUvBz1LcXJsHGL4gAVcdW7+6VPgie3MphmTj+ORsIlZR0dcrdLBsJlwcOCBoX/6fiqVkIuTduB0abfbA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIpptzRN6Y9n3R3syBWFaNRZw5siurdtt0cX38AkfTwksoHKOyI
	rW/lGvyJk/JoRbgh17JeiKU84IHx+JMMk4jjikcuBKQmnR7k8hQeQGbybpeOAid4+Q==
X-Gm-Gg: AYBFou3KHE+vMB5U5PlkJM6k3e4o5cVoiCMZ02uJ1p3kBizBpyCMKWDFKqvIkMZ8NdU
	x1Xy8o7yhqwWiUFqEE7Anf7yJYes3LXk5Mu37NpRyTQKlWmI/FSEgXyRtIDHZsMfYVuMKGUcdxw
	saGF3rq/AzCQlXpKWp/Qm5qGcNrKT2n0bs03yqwCol8QBeaWu/yyIWE+grPFbC0UVu+NGFtFuuo
	pNLcbKUsd/ZgW22E2WPJ8u9xYG8hcNKaZmtuQLe1Ljo5Q+hU3rFB+Vct6k4SpzuK/jPlMGUlRUM
	SsDivx4u6Zw9Cl+p/rGbptVE3oQRKKmeuv7Qc7Am6VPLwTd/pZB/S0rTTRyZrMBVH+ksGJxr8fg
	acTeSKc+h5FKbdKX8gFrzziaaLO39p+ZkP1DBSJedrQ8LNfCvb5A91sZXHBJcXSvyNEOvzAzewM
	EFFz718Y5EIJAaETSjU2xNAL+JF1xuIOYozhOAJpZpq0U6VkZgedZnOd31CEcBWKO3q9HQom4Vf
	pjS6/8zDmLPyEvanF2JKxUxFJN30EAc18n4iRvSLa3q1X4I2A/NQrvlVYtiGLvUFLU54gbHvX0P
	R1q1ubyY72rFCUWJasI=
X-Received: by 2002:a05:693c:8092:b0:368:2548:c08b with SMTP id 5a478bee46e88-368255807aemr2585617eec.21.1792627288539;
        Wed, 21 Oct 2026 17:01:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36740cc848fsm10850448eec.13.2026.10.21.17.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:27 -0700 (PDT)
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
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] iio: chemical: atlas-sensor: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:09 -0700
Message-ID: <20261021165858.v2.8.I55d76837b3feb481080e43d358375445ca0993c6@changeid>
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

The atlas-sensor driver propagates the return value of
pm_runtime_put_autosuspend(), which is not particularly useful.

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---

Changes in v2:
 * Split iio patch into per-driver patches

 drivers/iio/chemical/atlas-sensor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 1d4a9919df1a..48598475512f 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -426,9 +426,7 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret)
-		return ret;
+	pm_runtime_put_autosuspend(&data->client->dev);
 
 	return 0;
 }
-- 
2.56.0.218.g1ec904b173-goog

