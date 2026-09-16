Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AA45DF7A
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545535; cv=none; b=qYEkKLTL4X22SnUdc5ceVWAt+7D9LPC1NwdA7isum0kDmMPgeLo4jW06KwsmP1VRx+DG7DzYtqfffRDDlelxziIiqeGZVB2h0ywZuJlztitfEl0Np2/p2iXnHqJHe4b/g8X9jsyJbt89Vdj0J2cXf2ioU0ESIQR6F06eIjI6T8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545535; c=relaxed/simple;
	bh=L6VSMNKkPXg4l9VS1SCcav8nfu3ymTFtfF0ofUQlcoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibqIoMQTefdi35CED35B/3mcjOTTI3eujmd+z9Kh/7TKXiGikfwiKHZaaAu4cgR9CTRHW5yFSTczo6JKwuzYjt2S8D7L5CzfnvXOQDwiVtEybTchyY4a0zyQ08VEKV2imoTbVbIiaTbo3L+cg0fbT2GbnLg6ynlBdKKtYH9Fjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GBzusWew; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GBzusWew"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4ae616175so416320a12.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545518; x=1790150318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fm2NU1dVk2SpuJ0fFyLgsSQpwqAtZZWxE/JzixP9q9s=;
        b=GBzusWewVtBHhHke5RksqATpbU0/huc+d336SYPaxyosNfiesaXKtV1JgWg0Jzote7
         f0roi3BJSDAhn5jtc4jwhwyBeYGHfyAaASrTMR2G8i1AtFJNbyzNkh27gYu5wvEWIyZC
         /AasNZCngh+Vrs6oFwRqMyrj3mTU0TGUCj3Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545518; x=1790150318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fm2NU1dVk2SpuJ0fFyLgsSQpwqAtZZWxE/JzixP9q9s=;
        b=y6gw2hayuDwR8rf6yS8jWr43WF9aYtMGLN43nX+1M9PzTbp/FowCoOW1Ci/5EMnCBf
         iDIFR+yh4e0PbhI9BlXpKGBiW6WKSSjl+6QENxtct5QqcUEIuk2JYE/1DHSxEfZTugxL
         Tnw2n6Fp12BmteDw+gnmcOYIyjfeiPdJd92L9Jplqq84QX0aEMw0iLg3bFqo8agN2bwc
         3AXd/z9UttjXZoFfZs6Hk+FQzMKaPNclfhlVv53RqZaRLtUGZvb9mGjCxujgtULfbXLc
         SIU8/T+K8zLyZMZdSsqUFWa5BAc4J93DdoqLxIMOuFPFkHd8LAwHMlbolqcL6/x5Roo5
         4x9w==
X-Forwarded-Encrypted: i=1; AKwUvBzt9o0rO5A5qVn8VOGxaLIswtsnfo823q4sJHhsyAYuvXdSC/cNJe1IfwgIM5MRhd1EWKykex/9Jw==@vger.kernel.org
X-Gm-Message-State: AFuF++mdoBBvZIp42YzBpo22mngHSXbgvU9rWF5q77AasovpPjnw4id2
	GYab1u8HZSftNAgn70Jqb0aNuL/saIBdyosDP7g8mQUhy9R0asd7vSurRbwwUDZfSQ==
X-Gm-Gg: AYBFou2vV1cvFnopZKdZRFvGPcKqja1ylq9JS/W0uQamvY3oGlcwk1dC0H0McaymiUi
	eWXqLow+YXJ2wgycxtptlAeF0as/3GoT4ILyML3NSprLOZFrp2CXxHsMwSRawdVHXJFdnTo6FYk
	D09OmzTv59YMMx2M4jpsRBiProxs7OqEVOw2tj7RkJfk0h+6c5tcZ3lVaYa2NJFGNPjdah5bM/+
	YkF6o/zuD+iFIghegTQlOCdFCO+MdVjP1rjxgE2ZkBDcSCfwcuI0Xw3/UQn/zfKsSa6hcgOmTFd
	c5VkEy3dFo5E9qfP0ZzA/sWUlEUfziCVVIOVbJUMT8YDZvt+h1bw5JvQclzvncecXC/5Sfr5qHL
	mncr++wAFFL9oX89lC/8jRO/aoogYW4DoZFyzJmHzdoz6VqKNTg03RW6t4gvapXNrAfoHpEQ3SC
	i8ghNKGtY/tP2IGmMvHhO94tuwkMZxePFBbM9ucjJBDJBkaizmMDXSaLs6iY0BVp1fHHX3TCl0b
	cxiF8genSuwgM9l/SkZBqfsC863aSVhfZcKK5n0oVpGJN5b/38nuoQJJA==
X-Received: by 2002:a17:90b:2885:b0:39d:f130:8f13 with SMTP id 98e67ed59e1d1-39e1e4d3357mr4064349a91.21.1789545517871;
        Wed, 16 Sep 2026 00:58:37 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:37 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v9 03/15] power: sequencing: Add pwrseq_get_state()
Date: Wed, 16 Sep 2026 15:57:29 +0800
Message-ID: <20260916075745.3549953-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power sequencing consumer API already does power on state tracking
internally. Expose the state to consumers through pwrseq_get_state()
so that they don't have to reimplement it locally.

Instead of just on/off and error codes, the function can also return
"unknown" state. This is in anticipation for "uncontrollable" power
sequencers (such as GPIOs left unconnected).

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v7:
- Adapted to pwrseq_enable/disable() rename

Changes since v6:
- Changed to pwrseq_get_state() with enum return value

Changes since v5:
- Reverted back to returning -EINVAL if descriptor is NULL

Changes since v4:
- Make pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
  the descriptor is optional, matching the other pwrseq consumer APIs

Changes since v3:
- Added missing stub function for !POWER_SEQUENCING

Changes since v2:
- New patch

Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
as it is a build time dependency. Bartosz wants the change on an
immutable branch to pull into the pwrseq tree.
---
 drivers/power/sequencing/core.c | 19 +++++++++++++++++++
 include/linux/pwrseq/consumer.h | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 3076b3879af9..8e06fe77fd6a 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -971,6 +971,25 @@ int pwrseq_disable(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_disable);
 
+/**
+ * pwrseq_get_state() - Queries the last requested state of the power sequencer.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This returns the last requested state of the power sequencer.
+ *
+ * Returns:
+ * On success, PWRSEQ_STATE_ON for on and PWRSEQ_STATE_OFF for off;
+ * negative error number on failure.
+ */
+int pwrseq_get_state(struct pwrseq_desc *desc)
+{
+	if (!desc)
+		return -EINVAL;
+
+	return desc->powered_on ? PWRSEQ_STATE_ON : PWRSEQ_STATE_OFF;
+}
+EXPORT_SYMBOL_GPL(pwrseq_get_state);
+
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
  * @desc: Descriptor referencing the power sequencer.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 16fad5f3e3ab..e2a2991b20c2 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -11,6 +11,12 @@
 struct device;
 struct pwrseq_desc;
 
+enum {
+	PWRSEQ_STATE_UNKNOWN,
+	PWRSEQ_STATE_ON,
+	PWRSEQ_STATE_OFF,
+};
+
 #if IS_ENABLED(CONFIG_POWER_SEQUENCING)
 
 struct pwrseq_desc * __must_check
@@ -22,6 +28,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_enable(struct pwrseq_desc *desc);
 int pwrseq_disable(struct pwrseq_desc *desc);
+int pwrseq_get_state(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -53,6 +60,11 @@ static inline int pwrseq_disable(struct pwrseq_desc *desc)
 	return -ENOSYS;
 }
 
+static inline int pwrseq_get_state(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
 static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 {
 	return NULL;
-- 
2.55.0.1032.g73a4cd73de-goog

