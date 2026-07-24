Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB63DD86A
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882661; cv=none; b=Pi7N20QUmDWYMfcu2EHN0gGsbx0OURKcKFCv1UM46+PO353sQgfp4TR0pt26+94fRKN+BnZfku0N3BmAH3WohU18puuHuHcJ9n9M1+99G8sG6NUdMCDnQlQYBhJwlWqHpS5A1m1kWnT+3aV+nttkAzUOFMy+gV01I0+D0efGpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882661; c=relaxed/simple;
	bh=GfR2p9/Kj/F0C3wXj1i4wv7w/Gl8fUFvNscov5zqDHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXWJuG41u3V5DFy3b6lpzM0UXVIgWje4cEQyIRPmOBAqvJ+XU4wRaiwbLHn0RMZdvzrN1skZzPEbXPPP6r2mk8c1QQoxVgeVqhTY3qdWtS/v8XRFQuXQm6vv2F5j4vqs8bb+Be91/hKdu7sZPnURWDryCizP/jFu59ukJKREDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fMKUjVI7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMKUjVI7"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e08baf860so156875a91.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882659; x=1785487459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8J9f0ysj5iLgXAfZrr4tNewoNqni8L/Xnuw2lNVMgtk=;
        b=fMKUjVI7GAYqn9Hu6WFkqtdYMARneNf6Jo37kWGxlX7KOaRFbP+ayHIwwgCSbyCyXI
         eF0rPAEJcwrzBQgoNHttV8gXnefRInwHBdo+DYw/d2feX1PRBPuVTI6578LyjhxZl1dX
         wFV0FIqiCy6E7vX1gVm3RwRJjDRgFx+K5/0gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882659; x=1785487459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8J9f0ysj5iLgXAfZrr4tNewoNqni8L/Xnuw2lNVMgtk=;
        b=f513f93qunpBLGCzjtq9AwvoMwb90+SmGo4ZmbTdYbZFEyGYk3v98NY6RCn+i4xpEb
         VYWA2BN3LD8IWYjBM3j6whb6eSP6ZScTfESzFSO3L/G4ygDWoCqxqpvKgK309s8UFV2n
         irSs+XuvEK72+yzqwPxg+8BZiUw6vbhGyxuvoRMf2Uzz1805aA02zG/SjvlXCbDIGPZx
         LzMJnVpvjvMy1me1RnuMHfdSjYyJ2TdEpvJ3+GXSqWIqDh4e8nJQXKuQT9D3WI0nN5JA
         lcxtxR51IfUE8aSK+M/1rZd77nK/k7OIOe1zCMV8MWjNqDHbRKM0D3OTOi9JeENq8vf3
         jTaw==
X-Forwarded-Encrypted: i=1; AHgh+RrYB+RAxHFkGowq1A5EIolV0012yGdfXg5y0NSVbA6XCifcfW7t9piu8YF2+jZ9m0x3SPwgiWP3rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcO9yI0bfk0e8mxVOfDM/2x14kHMj42TK/nE1RmTmFkA1iJC87
	3rI2FREg9jywtZpakeqlVZKD4U3IyuJXz5eTtVBnnu4t0QCTR9pN4QT0HKADhF0QeA==
X-Gm-Gg: AR+sD12Evt5W6E4AwPt2Mo7za3/tg2g4MFp5Dxj6rGNetRMV34gapsLC5tftPAkycZM
	NjpBOCeHTEfGnwvSWUwsca3dCSxjb4Ew3Atcd6cSEBCn3TQllLwIw6bIIT4nng4nZITdF4DUl77
	9YEK1csAQtkauM3ls6HAvlB3uAXRNfFX30SxuZgw5bib9JFEEC+TrznQA0UPPaE02fZo3zCrW+s
	VqGMIdbjtO5cqyl4hl5xprARsHX2WO0wHIhU+PJK82xr6WEywg5vq8wezoKjvoS28s0bhtu9I7R
	b2wzX5xPobsTKuCBLgKyg0jc+WaD+YiitayxLWiAHFb+wOV4F4mhdKAVjvJWY/qauFSkUqlJic3
	lzgt7zKRXTXMYORh0lO4aaITtTGYP27QQ9JTfoeR1zJFEUE6v2J4IguSNhFJvM7vOqBsdJ2tktE
	zMKyRoBEuRxgNFpJWwXwb5B9/ZbyIaw28CDZJ574/EpJ8xc5IvytpnkCvck9Q=
X-Received: by 2002:a17:90b:1d48:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38ec665050cmr7371473a91.41.1784882658880;
        Fri, 24 Jul 2026 01:44:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:18 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 03/16] power: sequencing: Add pwrseq_get_state()
Date: Fri, 24 Jul 2026 16:43:12 +0800
Message-ID: <20260724084328.3943997-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
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
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
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
index 02f42da91598..701728e60a26 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,25 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
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
index 3c907c9e1885..af949e756bbd 100644
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
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_get_state(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -53,6 +60,11 @@ static inline int pwrseq_power_off(struct pwrseq_desc *desc)
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
2.55.0.229.g6434b31f56-goog

