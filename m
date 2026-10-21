Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627292;
	b=ox9l0vzsFlb1yKBFRcqY6wA/0Z+PgTyAglTavzBQTojvtYUm8JqiF5wlH+CWyfPEMHyM
	 f2/4LBeY8oK2a1FKkyHNL7jyQRZIaZFwyICJvz7uwycNrdu2xcMuk4yfmPJgA1aUtxybH
	 pr2JC1j0cdA40Hf8IDY9rCGcWCQTDgLDQgJ4EvY+kux1cnIsLzdgUa6H8CWC/LcjsdsXx
	 ABJlcaqP6IflJHPybD4eWAH0el+s7h3KPZEbnILGR2/iKoSIm7onJDk4hnMwkI8pXh0e5
	 pHBko5/STRS6DfPnbHrwa/TXopDQVS9YDnsqsfNGzhCPxEafMI+J29kOQeu1hUD04iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x/XHFLeuklX28g57VcXmkzvZarjLghDnz4MbxZ3DLl8=;
	b=uwqSYEcwJByQ9+U7kgEFz4hFuDaJHn4ZGvAGx49UIY0OXvZimmXZMUQqPd2wZMQLCHPN
	 V3r+lsj4RR7JROpLwWujs/tTfHOKN28caUUFdOYN41ZEtE6SoUQQahYBng1WenrMRd8Ym
	 vIuL1f7Br6qHTaj5cH70UP+YuWUhUS+iZEGF9FCEy5LUOBxa1HOTl6ASFZQccS9DCnbFR
	 eYaaGc3t1BtkFTAifpG2QcLxX/Dq6FRG84MbnmlR/1wDbntvbLX6MBbnplhfgapKMZSrU
	 gdhWWpZOZPB47M7BSVToUxpfNFdE09+EZGS05gaW6zfH0tiarUFYk84P5IcqVrvnQGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F+55gpLc;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710560A3810
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1710560A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F+55gpLc
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so2357115c88.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627291; x=1793232091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/XHFLeuklX28g57VcXmkzvZarjLghDnz4MbxZ3DLl8=;
        b=F+55gpLcgKIi59jDG/3y17J2mxJwaqdwqcW86tiRBV2JAs/BaAbfIOeFgAGyLUYzKH
         LIFB0gfg+W+YxjLa8c3aGFpPveB7TcYCc2z+T0FySZsflkSLkcIH4kmtcB1mbU+JbBIt
         tjJsT9HgE/HsItHIeujqomYP5BMBYSz5vhReA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627291; x=1793232091;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/XHFLeuklX28g57VcXmkzvZarjLghDnz4MbxZ3DLl8=;
        b=J02gsg46L+jlhiFEdSg4CYU1NKBITYyn3oTlWBM3KHnsCfz1qCNcearc8Jb6jsEi9c
         M4z/t/YJBBPfQkT8CiXvoAZhFUun900LkLQAEQjFndczh94Squflc3skDCQglHtsTAd9
         wPMh7VlK2k7cXzMM6XjM5oP1EPwyof96Wlg9XZhOsXaLLV4Hdm89MsiqkO3//Vsn3H6j
         5NGPlAK0YeKM9Gp0AjAoWpK3KgNBgTE3JomfEqOEhRDVsTaCI0Ibq6KizYDL1IuHp0ow
         v2lkPTCJFdJStHILwl2NAtclCTwvwAgOBMJnmE1n0dNUU00DEPRmt1KChU4nvX+mmGSu
         Dlyw==
X-Forwarded-Encrypted: i=1; AKwUvByR76ygi9udYdL/zegB/Pe3xciX4DvNegf403H0vzdgcntywQGFpEPid91bEk/VzXdRydldqS/GmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKeJ29QhHspAVA0T4YfqJsJ6SSpsGUd1AfbD+6jRyZObIvRorKk
	YHb3adlfOq2W1sE6DIuhZ9h/y6qvWzgufMOa3GrRiYd6tDkVjxjTvYJdHWFxezb/6w==
X-Gm-Gg: AYBFou2bzUZDIN6ifqLBZKZtL14j8Q+btm+xDxl1j0xNsG9FnQTbTsVEiZV8Rr0je7Z
	bwunDg8K53OnLtig7ctTHr7yB8Sf7nXlFHWCRRsCV5ErrDGYdT+2huHIyLLn/bMkhghkzhkquth
	VlJId9G6TTfPr9wCRZk17mAP00UoQW/8YMWdavsNOlxThKs3LOS06T8q4Hpxzf0McCDOPXyRkL+
	7MgUuqJTyNSb2dQ8fSmzqhS9KYquiw6JJy+DL0Di59h8Z2ONAhYYj99wsMKYWkIjqNbJUc/lXdC
	nw77G7PJ+yR3lYWG57sPKxK0kU+dxxzXQNjVpnejcOf3LvXEXl3JUvOvIHIVPmpY0i16T+1nPpM
	YoX2eVrwOA0k8ag628VtvjG0yBg8eXpLyh+gwSrHMiBRaXoBibEF1ogl25Hazf5bWIOtB9VTNK3
	U/MnchKtIujx7KTlOmBq8w/0iWrx0onHfOIwM+dMI2ebvZuUhXLfIf2tZ0/kyCncyKZAHbs7XPc
	5OQal3iiMfQA3Gzsff2VQkQtDSdacaQ1QPrcout/9WNpea0+K2aiMdmeLmV1N8BgIyXEgx65OFp
	lKbFmGntiv60kwGz2ds=
X-Received: by 2002:a05:701b:4518:20b0:143:3617:c5ae with SMTP id a92af1059eb24-1909f5c8459mr4538483c88.2.1792627291054;
        Wed, 21 Oct 2026 17:01:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903a275026sm14432191c88.5.2026.10.21.17.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:30 -0700 (PDT)
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
Subject: [PATCH v2 09/17] iio: hid-sensors: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:10 -0700
Message-ID: <20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
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

The hid-sensors driver propagates the return value of
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

 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 60808e2430ca..d76a6d9f04f6 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -154,21 +154,17 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 
 #ifdef CONFIG_PM
-	int ret;
-
 	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
 		pm_runtime_enable(&st->pdev->dev);
 
 	if (state) {
 		atomic_inc(&st->user_requested_state);
-		ret = pm_runtime_resume_and_get(&st->pdev->dev);
-	} else {
-		atomic_dec(&st->user_requested_state);
-		pm_runtime_use_autosuspend(&st->pdev->dev);
-		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
+		return pm_runtime_resume_and_get(&st->pdev->dev);
 	}
-	if (ret < 0)
-		return ret;
+
+	atomic_dec(&st->user_requested_state);
+	pm_runtime_use_autosuspend(&st->pdev->dev);
+	pm_runtime_put_autosuspend(&st->pdev->dev);
 
 	return 0;
 #else
-- 
2.56.0.218.g1ec904b173-goog

