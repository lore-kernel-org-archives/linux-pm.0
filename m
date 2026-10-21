Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627300;
	b=ijEodMJUKDLr3kkK4YP27+e6WZjRk/Sev378ei5BH+MzWBlPk9KxEZa8uIE/X9m4gvhX
	 fNC0pAIP7aRLsHrxNYoSEB/prxSnQi6hrzyIGPGubE9ie7VEBkA/r1lhvj4NRyBAPhQSC
	 AI8jVkCQCckrALjjmTXWmyI9/r+nIiPhNnB5XqxyWMCSTbc6G0CfQhHNkxFwa5BTTaiFM
	 4Q+9POARCLd2IroTPRKEjCkREVjlYTMOQC+T/3mPUAc0qLalL/1gpd5dOq1N0efcX/Ehe
	 yLRyDa3LCUeQb5+1ZcIzz6K9piGWhLh2hVho8ngxHWBLxsC06PsFEaYo9sDOQOYQ5Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/GMv02swmZTGafXC+zgXG/S425qXp9I+QwglxrC5H34=;
	b=PGzn0UOIZwUqsOM95EIb9p+yCliOUUYLeB6NHf0ENMvNwmgJnfB/nK1cu/q81qJSDz41
	 t3NcRvbvR3oUYbLoTTbtsOxTjpUxAbS0Dd+ou6yD5jyLS7DIPHq6pYteLLrY6GVmx7ue5
	 NYDLK8oDEXVThIAvcBA/Wy/F1AXMpznlcAjic2Z99+VxgEsts+jfNYxT+wdzFYo5yiRj0
	 CT6i4+7/Jt9oA1ujWY9foJef2z5nBaAmKakugms5qbZ7273tAw00RV7ZHjLAWCsS8g9Om
	 Nsnweo8yvKxpEomPQBs9W7Edv1SWghh124BCk+4Qj8vTyKl55Ds27PElKDeUDH7TMZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MWkMTRS8;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA502606A328
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA502606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MWkMTRS8
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so3012376eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627299; x=1793232099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GMv02swmZTGafXC+zgXG/S425qXp9I+QwglxrC5H34=;
        b=MWkMTRS8ZhEtf2LO+YZAG/BGXXBLmrdQVgMsI4F2HXEMzbhWeBHLHQYi4y/LMBdAuE
         t+X+1E1LrDwxZnfXFjOrXD3Q8p6k2ll3d8KnpEKtfzaAW2Zfq9I5BEq7b0l1Uju77Edd
         AqUGcdg3o+3Ffgl0cv8pZlA2yuCobNDyh8PuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627299; x=1793232099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GMv02swmZTGafXC+zgXG/S425qXp9I+QwglxrC5H34=;
        b=eYNARgGL/OyP6HcKLpN8/MR9kmTQG2wz7AOuChI2O9Pmxx7mdsAoe/g4elPB4LSND2
         2qPf3QxnX5PtFV3H+RyFQ9Ke0FJWkXj9QyngM4gojBk75HttDLVntmTQFqmEuK1QHyEM
         TAD2QossQahwZ1Ofdi4jjDrXreLsPFnjTR88YNQwelUWjIxFxOa9LsMtQe50y7E3phC2
         fBKI9Yej4rLiEazBMEoed3L+5Snp+XD3JLxKGIZhqQvtj4nMNoXbC8N/bAPi/Z5hTe6w
         798RU8sdIaBxggiO7KYWQnjjvVyF6vFymAlvk2CeWdclYcG3JZTT9VFlJK6T1SoWIOd7
         lbIA==
X-Forwarded-Encrypted: i=1; AKwUvBzb5d46t8D6JNULuh1su88PBzR1FT01nOpOXOQZxkh6gMOGcU7TqUoH9ROV3i+CMfL5UAFkR0IahA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKy+m/sd0FXtZzqDodSWSv4hb6KdJ4oA/vHUqN4zw0oStWdPzxN
	GpkFo7/SPPegGvpPKXl47KdZ71tIXZAqInL+PGRgfN1cqZBl/FbXdHXsrAkGlfoVjA==
X-Gm-Gg: AYBFou0eJSBDRK3z+GEyPy2alIFM1wmLoToYhgsveIFyHhzsV8FbWvbwv55QiwZH5qE
	AWc9OYNs6hsUM6KtjS8vlVgsNd3pjZmFcKqx0nFpffolNp/GTb1WBM6h8dEwUTpW5mY6kAYWVe+
	AIRtDnOhjRNuzJcN0gK6suHOVyf6Ec5gsqoDl/Ss/2G15AlPR56BoAxpJAEKTZboF3YgeGmMjXh
	PMg6Z2bfCoFID9muujhHaq2QgcHZsig4OcdvGItfexSmvuOrMucLUzudOZKMQOTLMtspmfKGcD5
	cV6LNJqteUIrAc0Hy1wG/3U29k74vvrPOa2s1yta6pw7bBk6hGuby1qEyjoyr1Udg5wqUQzgJSi
	UX3jVCtRIYpRunt8W1T1Nfc0wWet0WGWrfTZsZ6GZzKmsyWWhG7YBLkhx/Xb3/EZt6sZ/+Mspb3
	K+4EelJNwIYS8sGpcDw7VmmdUxosGF1JXOYe0X5d4x0NKJezgBlgeqxom38HTruDT0yMFqxCl+k
	fOfadWbRZZ7hA2amdZ8qKWRrWtWYyEYe4Sqczv/l7SNTVZZsMXD46BvgDXT7Zu8eLKKgysSBHwP
	5fgzkIZ9dWWb7nnNE+Y=
X-Received: by 2002:a05:693c:62d2:b0:351:13b4:9c59 with SMTP id 5a478bee46e88-3674a40e089mr4985582eec.2.1792627298780;
        Wed, 21 Oct 2026 17:01:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-368ee692656sm909622eec.28.2026.10.21.17.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:37 -0700 (PDT)
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
Subject: [PATCH v2 12/17] iio: imu: kmx61: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:13 -0700
Message-ID: <20261021165858.v2.12.Ibb6be74faca4446a1147537fa1a82bb6b9d5c580@changeid>
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

The kmx61 driver propagates the return value of
pm_runtime_put_autosuspend(), which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value.

Note: kmx61_set_power_state() is a possible inlining candidate, but it
performs some non-trivial logic on the {acc,mag}_ps fields, so I leave
it alone.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches

 drivers/iio/imu/kmx61.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index a4962b88ef58..9d626882adb0 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -747,16 +747,15 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		data->mag_ps = on;
 	}
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: kmx61_set_power_state for %d, ret %d\n",
-			on, ret);
-
-		return ret;
+		if (ret < 0) {
+			dev_err(&data->client->dev,
+				"%s: failed to resume: %d\n", __func__, ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
 #endif
 	return 0;
@@ -801,15 +800,11 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
-		if (ret < 0) {
-			kmx61_set_power_state(data, false, chan->address);
+		kmx61_set_power_state(data, false, chan->address);
+		if (ret < 0)
 			return ret;
-		}
 		*val = sign_extend32(ret >> chan->scan_type.shift,
 				     chan->scan_type.realbits - 1);
-		ret = kmx61_set_power_state(data, false, chan->address);
-		if (ret)
-			return ret;
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
-- 
2.56.0.218.g1ec904b173-goog

