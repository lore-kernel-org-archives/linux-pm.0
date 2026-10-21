Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627267;
	b=Caq4ydj00CFF066Cpn1y8CWWhb0beH683fzM8ix5cW+ziK8CTyuw2Y9l+ovCn0E7MvC3
	 5g98QaO+wgpO5DUj2SrJRUem6Fz0iENMrYaCrlmp7eTgbKlQqQDPBsdmTWNmtzUBY9X18
	 3dkjZeB75o7esEI+Iq5t6Qg9nOCo4Xr3msDkuRTnCDNXhFOycG07Pa7GjzLGhsexG2Urb
	 uWNXGeESTr700dNTY+aTwYC1OTKMghy0qru1/+8Q4NXx9pKw67MxAx++SDUxPCqH5J8Al
	 j5oAtwTcYAkI59QJ4ALI9shK3NsdVekffTGGKOKrhVQAGWOlrxqXj6Khb9pZ43omU/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mf2nUSBZHg9n9GyE2dcfq2rqWF1N/c1mtDtHbnucmkk=;
	b=U7lPjye0J2zZbUkrOxaPH6DLGHIjJQVS73QRGfsX6k0q62bs1LkTzZCDh8OMtOKaa08O
	 3tj+QXHMZG+fMZ/kS6UeggzoC3cLnTl92c3Fg8wzVUIo0EkjS87P8rDfUvYZiQ5d1ePdh
	 iM55pbBAuvC+n945cN8SoCXYqK98r4GCv9tDX006AEBEU83DGXACnKimr5Q5EkFmk1qQC
	 dkvwCxiVn5Zcp7f97VDqSv52b11FvjIqPH36iAIFJjJWiGX8Npt+z3q+UIOBPUCyYiPC+
	 bzMxOqrpo7ZbHEQyMH/7CNt0lhK9uDEyJdCLWE/89vE9tiVTW0NSAcR3cgFZAGV2ojQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bs7IRrXP;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB258606A326
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB258606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bs7IRrXP
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-368581df789so454650eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627266; x=1793232066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mf2nUSBZHg9n9GyE2dcfq2rqWF1N/c1mtDtHbnucmkk=;
        b=bs7IRrXP6KaRq8TCe+cmiL9uWNrA0bUEqu7Jsy8dC0OibGUFzA89HuC9kx0yu3s8sJ
         MJtavlPsc87FCp8GTTmg+P5qrcB8tFQJGops1yPhXwKmvBUlP05CJxV4vEbpSSSnYYN/
         113QKNtG0m2PCxLRcpmSzPcL3C9UgoADd1XsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627266; x=1793232066;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mf2nUSBZHg9n9GyE2dcfq2rqWF1N/c1mtDtHbnucmkk=;
        b=lkQepMSBn2FUOLijru1EKfhOM2RWHtJlolFAbqLRgiRcxonMSZnBOAHrZ10Hd3Dn+a
         eEM93jEIk2SP1z9V9lQ236oEuVZSsQkwf3rqfNipukOe7E/rhNKkdEnjvvVLbxb6elkO
         LNOVUiZ/+MOvwePBA6fkxl+4LTx4eo79MhQnLfWJnayWcJGpcYBafSMnz3bQ3EzcUzCM
         ePburNrVSVttEPUJnmFMLbRD3NmV5H+yhAm/9p9BRvTblagajO/qADHY2sMJn1ONKUkf
         GlAeakKBxN45oMkT8frOiA+lcp3S2DKdVnI9jlzP8STu1p26JKFmwRTE+SOIfkmQGtLN
         fUwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKw3Se40YrRc2MXZJTNcd+irGs0cksM59ImYTQxrQiX1RPFMzkAYPFJdzwSb9te0EfBHaDFLeOSQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIVOdzhapZ8Oo30cq5f3Y1ju/bVRQYduaKD0G0T5pHYH/BfXPZj
	g3RS87Ka8HExkveSA3TNm1Gs863OMV8OAm9wDXGTTtMcJ8KO3A7myCNi0BMISrGWzw==
X-Gm-Gg: AYBFou3gAVtafoty2p7XB1vGyHWx9ozFAfFJSV1FYhsJNdSS/QGDbLQdX1BhFpDEYIS
	O/I95D1ubfP6YQrFRHFQGViaCFkbs9QmobulF1oU9g07ryctoFe/I895sUqi+G7ryAuOzjsC3Jp
	g4Nvj8WGjVXO+OtKT2Ms3yNbAxXzg0KV0K88SnrEjOecjKcpKpQ1ahrqbbf2Wo7JMpXbIQ5iycN
	J2Sk5FopOHzgoPyiB6B3c9q/Rno0+znVyLptdZCtzz+UlMpFkng4P6v40yDlBBqARX4/MqhSzar
	+f0EleY9IDnUYCLUdSAGKL2WtEMgHo+AC/Vzfz0egVc9TCk4UznnlCIjwCozMHlAHsn/Nkznkj2
	gBaQ+FKwEmgj1imz+9s2vd2x5hpzpjqo9uGroeMBkgmytrAuwo6GsbQObLSG0Vp5/t/qb7VZ5kz
	EkbXKL9+D0aaV6EWCQwUQceaZBl/LeD1T5RZvOaiwOTHY7qCl1HztUiOj71AMRcnjwVx/XzDsNU
	JXnZl0xZ+31rjDDtPjmTWJRbAEP6C0V1PV6+u+9I4C5BVlGqptEn544HufLY5IozvwQFd+Q7hYP
	wa7xNKQ3XJvA1Oe3gqnx
X-Received: by 2002:a05:693c:400c:b0:367:a092:3c73 with SMTP id 5a478bee46e88-368b065757fmr1049136eec.12.1792627265560;
        Wed, 21 Oct 2026 17:01:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367411bc89fsm13244263eec.16.2026.10.21.17.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:04 -0700 (PDT)
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
Subject: [PATCH v2 01/17] iio: accel: fxls8962af: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:02 -0700
Message-ID: <20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
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
pm_runtime_put_autosuspend() return value, and inline the
fxls8962af_power_off/on() helpers to their callsites, as they're even
more trivial now.

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

 drivers/iio/accel/fxls8962af-core.c | 56 +++++++++++++----------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 55183c69465d..496e9bf2c4ea 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -205,30 +205,6 @@ enum fxls8962af_int_pin {
 	FXLS8962AF_PIN_INT2,
 };
 
-static int fxls8962af_power_on(struct fxls8962af_data *data)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		dev_err(dev, "failed to power on\n");
-
-	return ret;
-}
-
-static int fxls8962af_power_off(struct fxls8962af_data *data)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret)
-		dev_err(dev, "failed to power off\n");
-
-	return ret;
-}
-
 static int fxls8962af_standby(struct fxls8962af_data *data)
 {
 	return regmap_clear_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
@@ -263,16 +239,18 @@ static int fxls8962af_get_out(struct fxls8962af_data *data,
 
 	is_active = fxls8962af_is_active(data);
 	if (!is_active) {
-		ret = fxls8962af_power_on(data);
-		if (ret)
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on: %d\n", ret);
 			return ret;
+		}
 	}
 
 	ret = regmap_bulk_read(data->regmap, chan->address,
 			       &raw_val, sizeof(data->lower_thres));
 
 	if (!is_active)
-		fxls8962af_power_off(data);
+		pm_runtime_put_autosuspend(dev);
 
 	if (ret) {
 		dev_err(dev, "failed to get out reg 0x%lx\n", chan->address);
@@ -628,6 +606,7 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
 			      enum iio_event_direction dir, bool state)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	u8 enable_event, enable_bits;
 	int ret, value;
 
@@ -687,18 +666,22 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
 
 	if (data->enable_event) {
 		fxls8962af_active(data);
-		ret = fxls8962af_power_on(data);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on: %d\n", ret);
+			return ret;
+		}
 	} else {
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
 		/* Not in buffered mode so disable power */
-		ret = fxls8962af_power_off(data);
+		pm_runtime_put_autosuspend(dev);
 
 		iio_device_release_direct(indio_dev);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct iio_event_spec fxls8962af_event[] = {
@@ -840,7 +823,15 @@ static int __fxls8962af_fifo_set_mode(struct fxls8962af_data *data, bool onoff)
 
 static int fxls8962af_buffer_preenable(struct iio_dev *indio_dev)
 {
-	return fxls8962af_power_on(iio_priv(indio_dev));
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		dev_err(dev, "failed to power on: %d\n", ret);
+
+	return ret;
 }
 
 static int fxls8962af_buffer_postenable(struct iio_dev *indio_dev)
@@ -889,9 +880,10 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 
 	if (!data->enable_event)
-		fxls8962af_power_off(data);
+		pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
-- 
2.56.0.218.g1ec904b173-goog

