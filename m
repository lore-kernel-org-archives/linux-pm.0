Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7E3C1082
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076633; cv=none; b=tXLPO9NnGeqPJnX+3tzz079sRtc/i3QIV0+gAucQiuhW2ytk78odRyjVI45OcNCr8SJf3LLrJXOGY62L8FOiDWb0VoJDokD96Rpg0wjfwRBQ3Tyh/g5PXas/9DRct9z4efbyr6EvztBg0xxPF4osi8fIf1c5JyrnYODptBOnm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076633; c=relaxed/simple;
	bh=AzJgC/RVsjJ6k/SwatcooMrO5iTJhfE4K7EewIxT/yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0ql1sXLGmkltcfrHAMwjg/ibEh/8z4by4dMQlTdH7/n6x0g548CcHMmYHo0nzqBypq6A4odJY1tqBMZHaBfpMPXTwMR10dFriDNVOPohyLZAsoGFvj/LUkEdFzMlWtM+kWLJuPCkRAsMS4HWkSTchf1y+SPYM2MYTfmHUKsgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gbs5uP8o; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gbs5uP8o"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caed617615so628965ad.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076631; x=1783681431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRSQjBy62puZgUQngLjPxg+AegEI44LbaTaSEWvc+ks=;
        b=Gbs5uP8ozw1JQlSQnh0yXwdTHI5FERylCKPEkmA4LPHdMOFN9l5ixriYiyLapiQpaq
         QbqvJx9onMxQZgbuGmj1murrw7lC6/j4j/MKoUvfxTuHmUN2tCi8ykZHS6Xx6HmpnZVR
         gsoiVadah7COv31sQiN3j/MjbeSsGPPvkDG28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076631; x=1783681431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRSQjBy62puZgUQngLjPxg+AegEI44LbaTaSEWvc+ks=;
        b=ExgHhYMeU7604lQZFWqMnH9PIPg75G8uWgKPT9HDFUhye6X2LnqHq9hVVO8oBhk/ML
         gWlcF024w6+VyViyY0Zuxkt4MGNGTWTFI0oZiWS9n4qVSo2Sv0kiamS2SjPpKNx8s24O
         n2OqzUGoLKcvNN+FmB1X5tBT9j+/qM+LKKcGIcy5bd4s9GM67mi2GW2gq5uZIndWy+O3
         lD5Q6EyCQAxSn9n1t0LrYWHpJ7HvHIxT84Ac77JDZMkyAL745DPiUVPndS30VYJrvvp2
         BtJGrWVVrjlIhe+4YAh5b/uax6ZPBnxp38cYlarG8OkQnwB55Ow5cpQ54c1/49iJC4y2
         UJGA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6PNs+vVQ762jJsNOLtrKHXlk9uTN2jgiOz9YX/zpeYvonVURKiL9s5W2WrH7owQFr7X/Fq1d4/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvWKUJWOY2i/I7KyVB8Bs6ydgpmizfxNdA3HI4cUch3BxiaUd
	veRn3RLSZPtRtxspcReRTtc35w6gMQE1zK3tAaBmgcEWmZcC5MkxrNXjQPLD9QDQig==
X-Gm-Gg: AfdE7cml1Nmg1vf7/yO99zJr37Ao66BDMiVQLeViKUJgAx9rxtUvSPurtmg4xWeg8+M
	DMb75zjxJg3XevKAdepuvby8ax4p+jxAEbrWOVui3PtBQ6+ImBS+CDfPedaa6ZgU3tEuTwAHma+
	W8PK0v5idiozJIKUhdCogHrpN4EESjdXtnEmg9DMkzpM18OynFK2r0oTba5hZQiEhaG79S24S9u
	aVOaFK6rGjrIKD3J3VjbZkFUGZBsc0V3ZLw6VYge6gwBuRhZI2QF7GnCJ8zR9RbsrpMHuIL+Hdy
	tGTEpLn+RFf30Sb92aMCxDaF6Mwr+PKU9Ub5cBhxjTntEv5ZONA/5bLwu057dnLOxBeRmFEcR5W
	QvXq3GR1bP/BZuSsrCyLefwpYcYh8W12mJQ6CeEL8Vbof5KnrjNZHF+LhHEYF9RXGqOGQs0U8CJ
	bHldEMCabc7XkjlhCIFtryBl3SyEQSYIcxgUH3GE1baWHEuc1pi78rmSEotGEJ7vVvGtskiQ==
X-Received: by 2002:a17:903:2383:b0:2c9:e261:95c4 with SMTP id d9443c01a7336-2ca7e8d9f8fmr111666555ad.30.1783076630618;
        Fri, 03 Jul 2026 04:03:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:03:49 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 03/13] power: sequencing: Add pwrseq_power_is_on()
Date: Fri,  3 Jul 2026 19:03:04 +0800
Message-ID: <20260703110317.1283411-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch

Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
as it is a build time dependency.
---
 drivers/power/sequencing/core.c | 18 ++++++++++++++++++
 include/linux/pwrseq/consumer.h |  1 +
 2 files changed, 19 insertions(+)

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
index 3c907c9e1885..5a5eaf85d5db 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -22,6 +22,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_power_is_on(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

