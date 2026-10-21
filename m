Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627264;
	b=GolTwGjWhWyjNOuje2Qhnl28ve4a9D3tVXyf/bh6EIxSvCZjSkEpdhudgOXa0hYkwr/u
	 2p0UDJvBj061CzB84WZmnuzIvzvuuoOUuLbb70k4/A5yQDSTDOGPFe0hfrNoiX0i6cy3I
	 4MazZVz3Q98U7VLOMqq2YPD1563x6lpoy02FuoEKGgGM8UDtZQITHlcszQi4PZ7PRy7Ck
	 c+Rks0VY6grZX9h3cD9HkVkYxy5a8VLjMK1ERYEx8xHvRwpkD65igKtaH8BQcOYviht55
	 T6R9gW58YiA3W9H7zTz8dBRx5EnqtBXCj4rmQISnRjBExftS9vlNTVmwfOwRGEYVWPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vdQ15CY2t8acOR+daJ/by7IbMKM9K/k4D2pVTlpzkNk=;
	b=ZDVxq2pkZ5PF1Ykwweuy1Hn804qwbmYQctjHNrkQUL9APJTPgS54/hVUASrbA5b2CRFo
	 sEPRllgjDU60KLVzh6TccJsXL7pR7SEoVLbU9Duise/6cpVIfSFFYoxhJZrg2ogTQFBqG
	 wYz07ikIof/XKmJhbwZTwyD50YzKZ/S954CCMd4EqSQJdV/RibNeJETRaBL/tlMjflSYR
	 iSDgdrSHBOWCXns9OEgK4DtBCvh7z+EOzyiADN5YuZK1RFS0u1HjFivWMOyRen7mw/dpp
	 ceo7OkRf7U1zReIT4CvROXhfmKhLHqkS9VuD1URkpee18yMW1ddA5Kp1YOU0Wn4uc0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UmA2bOuU;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26710606A31B
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26710606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UmA2bOuU
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo1568689eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627263; x=1793232063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdQ15CY2t8acOR+daJ/by7IbMKM9K/k4D2pVTlpzkNk=;
        b=UmA2bOuURe6zzZcz6sNdn2qZsqHZK5yINxkcZrAhLL8QDaeRg9nf09OXJdDZpSCRYf
         +aUzwszLCLnOIgj3vFHUtMtabk1DMoHgTSs8fG9CjMPPuBumBiza6waGhaeaMQRTjq3X
         8j8BEdih2gmRULB+bP5mlObW3UOjqcRdummgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627263; x=1793232063;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdQ15CY2t8acOR+daJ/by7IbMKM9K/k4D2pVTlpzkNk=;
        b=N0Y13dBAwRZdUbG7ggFd0TeouptsfDAWunnBkXI0ddqeDVR53+vDsVtO0/rNPNeo1b
         Kvn4kwXiB2+5eBugThQkJW3yXTUtrjl/UtIgM6ufrugKfRa/ODPI/ghszth8Wayz5q6T
         ify0mpfHEAQTXI8sCwjM0H1V2/fxe6qiABz8Wocv58VAYTaYEvuuXjIV+1QrxCiNpS3U
         su9B3rB4b/VMm4dPCGRoeNq/fXUHYQCN0xuVJGLEQkrph0k7E9zjN4OX0li6PXA7Rv4u
         Ac1zh1cNn7cIvGCqj5x/zoDeuWfp+sZLItNBavq7kV2Pjf3ouaNj7qN30N9kPw217JFh
         jTLg==
X-Forwarded-Encrypted: i=1; AKwUvBxzKikOh3o2KrZszmuEaIeilYpJnQ6qDglVZcll34gwMSdvjRWglCG7vDUiAqFsuXNfdaDnCTmXqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLXm+fF95SgNDwQ8C1TKYSY6zCw5umoSxiTBuaHNkLV3QCZf1Im
	4HKt14OAsN5h/iJhV+ohk5lO91qr72BejUw9aUdkLdR/IMlgfFz6SWKkzbMmxx1SXA==
X-Gm-Gg: AYBFou2dTxcPGacWZDwxIt4OWgOefX+WH6lHhkLbDc4JVY39Eqx8frl2f2cwmhd9Gb+
	g10JXhwKmzeeyuU8ZJLWqIqOpJA59ourwxsi3NFjERZnMIT3663MAgbQ1Md1DKBqt79i0/bZPw+
	wOu2996iF7I9w8UTbmDm52yhLGmkyBqgpPPn7n4v4J26llbnlWeDZc8Tiyd9TCkZElKGTw0Yfb/
	aI9zftZ4e9PNCLSuQFq5sPqE2exaBt4WKloBq2sUGKaT/zOS+sFlKepzBMLIexBK8GXw5S2WCqy
	NN/mHqYnaLdNz6ebknAl3EsBVGddvwZt6hmZedR16pioKDBDCyKstV2E+44BVx0xR8sVEHVJIH9
	Yg+zUB30vhKNlg/9HpcJZgy0+cZxmlbUlddB+yMKIbYbRbQ9KpYjbdEvglyaQZeGoo6vVr/JUWl
	y0U48BIwQDqmwjyjl1vgG8YBZkzI05yv0XFFb2nzI+VTv7rjZCzBLx0ypAG6SF4njpKwizDgCQ1
	kVThw8dStd56sKTfZvhFZ6kfJQZuOgi41SAWVM/3dPNDmNQS8lOZIqLJ/XV+1FG+zXdRdD3G6gU
	hinLUAy1/mJZSow8aPYf
X-Received: by 2002:a05:7301:2f1d:b0:361:6dc4:d0b2 with SMTP id 5a478bee46e88-3674b52acc3mr4938338eec.2.1792627262898;
        Wed, 21 Oct 2026 17:01:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367405ed295sm12097312eec.9.2026.10.21.17.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:02 -0700 (PDT)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 00/17] iio: Stop looking at pm_runtime_put_autosuspend() return codes
Date: Wed, 21 Oct 2026 16:57:01 -0700
Message-ID: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
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

Similar to this effort:

  Subject: [PATCH v1 00/23] PM: runtime: Convert pm_runtime_put() to a void function
  https://lore.kernel.org/all/6245770.lOV4Wx5bFT@rafael.j.wysocki/

i.e., commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void") and friends.

As with pm_runtime_put(), there is very little value in return-code
checking for pm_runtime_put_autosuspend().

Checking the return code is more likely to produce a race condition
(fighting with user space writing "on" to the "control" attribute) than
to tell a consumer useful info.

Because the IIO subsystem has the bulk of drivers that inspect
pm_runtime_put_autosuspend(), and because those drivers have a lot of
other issues touching the same code (which Jonathan suggested [1] I
fix -- I fix some, but not all), I'm sending an IIO-specific series
under a v2 label (since many of the changes are still borrowed from the
earlier series).

For reference, the larger v1 series can be found at [2].

- Brian

[1] https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
[2] https://lore.kernel.org/all/20261006231900.3230373-1-briannorris@chromium.org/

Changes in v2:
 * Split iio into its own series
 * Split into per-driver patches
 * Fix various usage bugs in these iio drivers in the adjacent code
 * Remove now-unnecessary helpers
 * Maintain Reviewed-by from v1 for drivers where there was no
   additional change (aside from splitting up patches)

Brian Norris (17):
  iio: accel: fxls8962af: Discard pm_runtime_put_autosuspend() return
    values
  iio: accel: kxcjk-1013: Discard pm_runtime_put_autosuspend() return
    values
  iio: accel: mma8452: Discard pm_runtime_put_autosuspend() return
    values
  iio: accel: mma955x: Discard pm_runtime_put_autosuspend() return
    values
  iio: accel: bmc150: Discard pm_runtime_put_autosuspend() return values
  iio: adc: rcar-gyroadc: Discard pm_runtime_put_autosuspend() return
    values
  iio: adc: ti-ads1015: Discard pm_runtime_put_autosuspend() return
    values
  iio: chemical: atlas-sensor: Discard pm_runtime_put_autosuspend()
    return values
  iio: hid-sensors: Discard pm_runtime_put_autosuspend() return values
  iio: gyro: bmg160: Discard pm_runtime_put_autosuspend() return values
  iio: gyro: fxas21002c: Discard pm_runtime_put_autosuspend() return
    values
  iio: imu: kmx61: Discard pm_runtime_put_autosuspend() return values
  iio: light: apds9960: Discard pm_runtime_put_autosuspend() return
    values
  iio: light: pa12203001: Discard pm_runtime_put_autosuspend() return
    values
  iio: light: rpr0521: Discard pm_runtime_put_autosuspend() return
    values
  iio: light: tsl2583: Discard pm_runtime_put_autosuspend() return
    values
  iio: light: us5182d: Discard pm_runtime_put_autosuspend() return
    values

 drivers/iio/accel/bmc150-accel-core.c         |  75 +++-----
 drivers/iio/accel/fxls8962af-core.c           |  56 +++---
 drivers/iio/accel/kxcjk-1013.c                | 118 ++++++------
 drivers/iio/accel/mma8452.c                   | 100 ++++++----
 drivers/iio/accel/mma9551.c                   |  21 ++-
 drivers/iio/accel/mma9551_core.c              |  39 +---
 drivers/iio/accel/mma9551_core.h              |   1 -
 drivers/iio/accel/mma9553.c                   |  36 ++--
 drivers/iio/adc/rcar-gyroadc.c                |   4 +-
 drivers/iio/adc/ti-ads1015.c                  |  50 ++---
 drivers/iio/chemical/atlas-sensor.c           |   4 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |  14 +-
 drivers/iio/gyro/bmg160_core.c                | 178 ++++++++----------
 drivers/iio/gyro/fxas21002c_core.c            |  33 +---
 drivers/iio/imu/kmx61.c                       |  25 +--
 drivers/iio/light/apds9960.c                  |  48 ++---
 drivers/iio/light/pa12203001.c                |  26 +--
 drivers/iio/light/rpr0521.c                   |  57 +++---
 drivers/iio/light/tsl2583.c                   |  27 +--
 drivers/iio/light/us5182d.c                   |  32 +---
 20 files changed, 401 insertions(+), 543 deletions(-)

-- 
2.56.0.218.g1ec904b173-goog

