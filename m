Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627285;
	b=J28UBZXuhZZ603miLGQ6j+2htxXVs8wdh+jB8FiditbDsoS/9QtCirHsn3Iikz0FYhtY
	 J3HdttVAhpEJr4ndNqD6mma0qT4ysKz3qaVrUFEy595VPIgZku/HXS9nyU7MFQlt0ZXRd
	 xKL+idnxxCbUwUPK2Ba5HlF0AaJ9fMKAszTi3PngFcoOBH5coW7lyqiX83hyp4mNzJlKT
	 xxjL4c4qig+GJ9sLEOggBnSJ5K0vuSsovNLim9CCjDjA40b0iM7DZZjfpR3wWIADUcbkq
	 79+4eYtJEeNFeDjXZqci6xQdpAnGuL1nEgdT1hgM1hB8Gt6rcV7EDAdZgZdOAfWugNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9rsuU/zpvGVZ6N3nvTXW6aQt3MLOdJQFmOTT1iINVYg=;
	b=gClGSjVZL3C9wKXEOTCucHggr7k/k86PwmFdySSQpsZTFG1FzFOYtlMHJrLdZaTN8Hcv
	 rczrcvweMwmJVxn/DAUU19aN8Vv2qaov5qjCQba9AP1m0LysRfqbgaPsIZcdIRXAEPRFn
	 eFoyiPhuC8VNyC+X/gz+p2UJcl2C6z/GklkEh97wIUBkLtKeY3+yuSb8kExjKMnGWn3OG
	 1fL0CJao3EX5d0tlchUMoWr0IgGfMWRiW9pLaWcCoWt7eEZuI1JqRBO5Qje76L6vFWkNh
	 sm4bzsB7Und/tESRPxHOx0ZVx2xc8Hls5MtEtimu06kXCPfkYjkcN3CV1NInVyNJwIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=m5yg9UoE;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21660A261E
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD21660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=m5yg9UoE
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-368581df789so454926eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627284; x=1793232084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9rsuU/zpvGVZ6N3nvTXW6aQt3MLOdJQFmOTT1iINVYg=;
        b=m5yg9UoEpcdYE8egFZeIgIiw+eoQYctsAkRwAViGsNT06ip2KWN83KgAyDKgQ+L1QV
         SlsKZ13l0t35zjsjJg3dfmFvJP5BVklcHpBUWEIVatgaa2HInySG0PQHaAeLoV6oY8AB
         +A9l/nh9nQQx8ljsyMwVjjiyaRbLxs2l2hiw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627284; x=1793232084;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rsuU/zpvGVZ6N3nvTXW6aQt3MLOdJQFmOTT1iINVYg=;
        b=FdxVK5yspu5r5VbZsN7RAy8eRtzw63qkC1zNWqX9xfEB8bpo5sWt1wb3GkPiDO1LPc
         TnnNs120J/LicQdWZZKW1wSUGaNO6lgmaCHHh8PpZX56IE0nCNVnIA1CF2BzLbMGQz0X
         7kEEkJcNlFXzedj8x4b3/Q5CRrKnaJvTzuGvqDKPndJKhqFehBO45KxR6Fe7oc1dLxlF
         xNNjQTLRPRdKcshKmyRyHizXlRMjmflz15eU4rivZF+KOoDblPwXb9qoIvWu0ExaT90n
         hfGZ3fTB97Svb5sRTH+axEMy7PsR9xC8Fi90lhlLss2ZklnlestzpiLyJjSpIeAvJUH4
         jnQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfgXZquppj9Q3iSU260g5GGbZ/JdaAUQqe5LA7jYXKxbz37xIu1d+Ate1kVig8urzrV+ZEC+9HSQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKvJe2PvpwtRfrbPBt8kxPrUR3eoeAWHWifxgigWTLc7YZDlchm
	zlkwJHP6qiK4le4duhdbKIBfnBa8lCSwWPxfF8SLtf6QhGNXDrJhR8U0iWsKJDMcdg==
X-Gm-Gg: AYBFou0972moAawqxNmQbr0kAgFgQzek8N4h4ZI7Z8uQg+x0peA5gZspiFUIqukCaBy
	hQwEtXQ56ZMKhFib2V1nuxShOWXsi3q0gZ24Wo5PMVepQt0H5OknfHyZAMBtR8SKLZHl7/oNp1y
	vtAXWKi2g+R/Aqv9HcPkc4Cjkwcm5FtZeETuRM9Np6jBEE63wTZ6UM/euDESMkmMiRUnpIQob75
	Czhs9zD5MqBQD0LQmjnzuKKplquEpMfL5KYV7PL7hvz0TK6Q1P4jguXRhewsr5DOWe35j78Erde
	DVIIV74JBJRrY5SS/QVnQVjKy14WPdKaUw9IIquiIi2v2FqNtJql4siRmQa+oiStuskDKZjRZo6
	j/Q/PTQZr769psJdIBiRhVYeZCIk8jowpBfHIuOUDottCCN28qGCVdCe+6KAGrMbBwPnhqy/0tI
	2WNgk72Po3+SZy6KANFXiAI9OeLpA32o+oWXhAEeMBYPO0MNDMiRMxe65GGPrU6hp9/LKtIm+PB
	dkKj+RfKjMu8GH6GXhFLpEgZyWcfQJHdjexeRXCk85yGCsXzVJh5hmYbbDhiid+gLKJMLh3Wnlr
	OgStyf9vOGQJaQbnhXPZ
X-Received: by 2002:a05:693c:8102:b0:351:606f:2832 with SMTP id 5a478bee46e88-368ae2d4b25mr1068928eec.3.1792627283594;
        Wed, 21 Oct 2026 17:01:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367411bc89fsm13245730eec.16.2026.10.21.17.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:23 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 06/17] iio: adc: rcar-gyroadc: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:07 -0700
Message-ID: <20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
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

 drivers/iio/adc/rcar-gyroadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index d38cf3caeae0..0d3b061d6ec2 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -199,10 +199,8 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		*val = readl(priv->regs + datareg);
 		*val &= BIT(priv->sample_width) - 1;
 
-		ret = pm_runtime_put_autosuspend(priv->dev);
+		pm_runtime_put_autosuspend(priv->dev);
 		iio_device_release_direct(indio_dev);
-		if (ret < 0)
-			return ret;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.56.0.218.g1ec904b173-goog

