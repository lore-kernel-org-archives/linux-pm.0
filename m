Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1084071FF
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591076; cv=none; b=qdeiBltBAR8g0jP/qA9Dlt8cBqll/byd34Sgl9GNAIILDrWDUUI6JnAIb30+Sx5qAjxny3aRp1xUdhPJZeB/ZketbH0V0HrSEf5Ar39KAzye63ppLx6XHCVQpuu+U6BDmZctrqRNqi0pqVLyti+wRmNFiM/a0zGDzItVp/CVfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591076; c=relaxed/simple;
	bh=4YELuM6VQCMV9D/MX880V9r7Pxe8hDDUHlHe/gFvXP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM7uKmgX9LojMu+036RzQrNjsszsWflu/rRDKFU8aSX+eYy9cN+5d/+vr1St6PX0dIFTSeV5GhZFBcYL/C+QDo7mgLeIsxV3DuGX4fq77lW9MJ4mY96fdqP8lmbekNXbrf4iJxRZq1E5aHMQbvbyz8BTiISYFYS0ApdSoE0Glqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mciUxcJD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mciUxcJD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc61541f8cso10537875ad.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591073; x=1784195873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGS4xa617bTzeR6KQL6sDpcq2So7IhszuqJtV9dz6uY=;
        b=mciUxcJDfy1r4z9AvL1ctzwjmZwtOhOfoI1qcJvrdfTlkXKNkHPRHevDQcIEtHvoKk
         AmNWSnHYrZDRyrcTnLOgMq2Me0byHl5BsqTdyIDkteotad4DFwxF56/3Q1jTuDtWYln7
         MnxX7xPTCW58M3lnhtwkNqpezed5XxWXHt6hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591073; x=1784195873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGS4xa617bTzeR6KQL6sDpcq2So7IhszuqJtV9dz6uY=;
        b=c8Ufzj+wd8N2A6Daox9ONHEJn+WkKo3C26pEp0IPRhQcZT4myyWMuqidgy0jeVQYFA
         2Od1IHLfHiIsr4IVEaAN1qgQLzTKwsJtpLI6FbXvSKGsCU9lI5kcIg9Rb96oLZUORnMz
         6PI5Ujl0rGtBxoA9t4zBzsbQGrQc58WWSQDvlyUxVu7MadqNaF2fj1skduin+6cQUQiT
         24u/RZHIaIm+KAzhsEhpRixC+6yYVFI3D65GOuHJwVOWxITCE9OS7vwLX6bVLMkjQAfv
         AlzzfQR428WY+p5Rar0omyuOc6UIpShj1dJEtYjw4Uj6XOB0+444ZpmeBtNaG8NuQ6Qn
         GZsw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Y9uppwR4ybUDYE5XGQnqNLk3ZHjRiX+Yo0zDJliVTegNLREXQVon7//dYjuDLRmVD8cJuxvbcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6lO7gbUsde4NQaRZysuwDuz7/Rt7bvqoAHUrEl80tzg0+DJh
	6a/ANrQCwnrmVyk8ySR9zarus6tOGM0qmcoT8p1BlYkgqJJA2f99kwvODM1d1eMutg==
X-Gm-Gg: AfdE7cmEZddDwF/OcaYWeU4ytZUx4AP1ZZcYIogQgFeWBYlhx/CED6WDshqE+V/YxHc
	lJMuhW2Oh+0XEc7B8HNeQHR9VZD/IiPYT4xr9i6lWLyAb90sZg/qE4jJxmbTqBTtcpPsprmKcXe
	fmCBJt6qbl6ldhm6q6Wpo/zIsSSUVI+1L5c/iqFuMOhyjSO9VQVmpBi+wyzpJ7TTT+7r3xvQzHZ
	ewASzrLZHv82csjNFZrp4uk1pHN+SAIiGXMmEr4YAfwbA/wo0wQRzdqwtr/Y9u5Kc2189DNZNhW
	FcM75v8u1/GHUPdrKaXy0m44NHjMi7QQf2XX+2EYhPYBssd+2oTjf2l+REwcTKluCTbeGmS5y25
	1dIX3Z3v8PJQv7PlXeaG+AmqWxe+0Ds8Z46KrHsfyfeis/ujZAHmKLhQnCqAshDRaKzEcdiWAFS
	qfWuC/D71D7HKo4W+ZyXZmY2w8/izTPYOoTYoFFi03FQgMq+XrDdpPBr1Qfzipltrmow6Xfw==
X-Received: by 2002:a17:902:d2ce:b0:2cc:841d:cd7e with SMTP id d9443c01a7336-2cdd8b2ebdamr22781535ad.21.1783591073109;
        Thu, 09 Jul 2026 02:57:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:57:52 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 03/14] power: sequencing: Add pwrseq_power_is_on()
Date: Thu,  9 Jul 2026 17:57:08 +0800
Message-ID: <20260709095726.704448-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power sequencing consumer API already does power on state tracking
internally. Expose the state to consumers through pwrseq_power_is_on()
so that they don't have to reimplement it locally.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Added missing stub function for !POWER_SEQUENCING

Changes since v2:
- New patch

Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
as it is a build time dependency.

Side question: I wonder if making the !POWER_SEQUENCING return success
would make developers' lives better? At least that is what the clk and
regulator consumer APIs do.
---
 drivers/power/sequencing/core.c | 18 ++++++++++++++++++
 include/linux/pwrseq/consumer.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da91598..72b96d36920e 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,24 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
+/**
+ * pwrseq_power_is_on() - Queries the last requested state of the power sequencer.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This returns the last requested state of the power sequencer.
+ *
+ * Returns:
+ * On success, 1 for on and 0 for off; negative error number on failure.
+ */
+int pwrseq_power_is_on(struct pwrseq_desc *desc)
+{
+	if (!desc)
+		return -EINVAL;
+
+	return desc->powered_on;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
+
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
  * @desc: Descriptor referencing the power sequencer.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885..3c6122bd0205 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -22,6 +22,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_power_is_on(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -53,6 +54,11 @@ static inline int pwrseq_power_off(struct pwrseq_desc *desc)
 	return -ENOSYS;
 }
 
+static inline int pwrseq_power_is_on(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
 static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 {
 	return NULL;
-- 
2.55.0.795.g602f6c329a-goog

