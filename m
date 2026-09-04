Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3C41A55D
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511350; cv=none; b=TVOp2Cdi3DIhup77SHQpyNIXfdmoSj/sq4QgOhGFxn8h0gJIc6HAB1bfEbP6Ip2sfq3uzy9pA83Q5NQ3+RsSAwdneURJ3lHw0SBQ4s7Kri/AP3T5s1NgGOA6daiHGuNMUnSpLy2hjQjcB/5+txO9J4Vh9nYYiykuhOr8vqQqUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511350; c=relaxed/simple;
	bh=yg835mCmcfMqyyZMo2K7NS9o2JVbGcnLZ8ClgruKi9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biRhSCooWT9xTfQhc22Y4zY4+0uJ/ePEM24Pa3dugEclJU58v/YCY2Q1vAMYhvYQA9Z4ocybTm3d2XVNgNZbwOimGsYwb6v/FOoKdvsTSzNuIxla+QaFeQE5kPNTrrqA+BJWesB1abGUxypehP/nXFdDpmt5XRpDOZjue/ivfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=evdxVCBc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="evdxVCBc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9b60c652aso8817435ad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511347; x=1789116147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUco8k8loeDw75nokYqtCIPRhQuEjxppf2mE5m0ZQ1k=;
        b=evdxVCBcqS+HCayUlvdKFyn97wTgOKWdKmoENSJrTiTSvNwm/ZLcz2dhJ47UbjcN9B
         0GEKf7qxQ/JMNrREgojXwHExamElQBxuFeinGcVvfXD6voLptR/ES0KmBOvduKBXxFIO
         6DPePZR0Mo6qC3TFN5rEnx+Q8EljE5B5dI0mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511347; x=1789116147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUco8k8loeDw75nokYqtCIPRhQuEjxppf2mE5m0ZQ1k=;
        b=SGnMriB3gUHSVMlCaBl7trrs0VoFlLPUDRlkAHETVrZjA1ZjgO0xB8LUFd5FQk59Go
         dN+BgNbVFsGFK+YBNcqPGJU/Wkf4GkKMAppJ35DqHr0666nhhq1sxZMQr87S3ES7fx5n
         5m/LR0qoPohzf/993aebdUmCbXWCkB423lS7v5PYUlva1lIDf/URNSPeSlQu8rWoYqHL
         oBH3/XINzBz6KE3MWnYO2cpAhe9s3cwgjzjXj4Yq4bj5ZgN1eViVvi+735O1yIJjTz2X
         7BJpStFE+OJ4FvA8a3X/yWm7CYFanVwSt5gbE8ZpYXEpwM3WvRqkjeAL5E/Gmtylf2xe
         rPnw==
X-Forwarded-Encrypted: i=1; AKwUvBxxS+TYshGv76369P3vvfeQu5MmMVezgfX/wIjSy29AfgZJXtBTEAj8V24NhjQAH5nV6AkBSw8W3g==@vger.kernel.org
X-Gm-Message-State: AFuF++kGko1InJz+jDmyaseNGg8xKjk/SLsz5z8vFb1ZTpOV+helb9gK
	gfw1K986ywlU+ZNl1gZCv5opuXDaI7SD+JYu+lxsJpARPgpsmQPCJnM9us43HPkLKw==
X-Gm-Gg: AYBFou2N1Ltu0DccZVWa7cOlzyhwpL96FbKCSswAtZ/rLzJmaAOaX3qSt28ouXNt06q
	qURHjxIkXQoKtZEaStJhZCRMrtBTQGhP8I19VlwsLX+9vNJnh7xb/1jYvF5ETbOPFk1uUFBkAFp
	TGORwPTLFdp2ZdU84pP6AnRMMHFzja1sK3WG2LXI0inBt3C8ST4LkWYr0RZrQE9D90qxOxgR0jo
	TiCzlH1S7eCEvb6pSOU9OtNQG4R+CAEDS8t06Cjkfsa/a4xNYHg7xOSsS1rVE0gfPqWMMJvZEDy
	v4GbM3ZOgwac8Zn2I/G/WHl4LisdcPQQpkhbrH/8Z4cUhwTGT8LjjIfF/lLwZrvPWl0xGQFdgrj
	e6xbiDGeD88FowL7sSoU6AHXntC4KWhvH6/ZeUTuWEpDGw7bstT58pQz8NuyiZFVhpjca14hH9M
	dTJmVVs7uk38oVg+5VimBzXG2PHkZSPk2mkVUJ6j9YFsR+r05ZscXmb6XJAuQHcjsDIu8rVuV2P
	wxxpwcuMS8Xk4g2OOQIIO5ldlechpG/sNVkk+WWULfD
X-Received: by 2002:a17:90b:3a8e:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39b260d2eb3mr6786889a91.7.1788511346596;
        Fri, 04 Sep 2026 01:42:26 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:26 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v8 03/16] power: sequencing: Add pwrseq_get_state()
Date: Fri,  4 Sep 2026 16:41:42 +0800
Message-ID: <20260904084158.1341550-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
index 721e888b658d..dbb2bd2f8864 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,25 @@ int pwrseq_disable(struct pwrseq_desc *desc)
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
2.55.0.979.g7e5102b832-goog

