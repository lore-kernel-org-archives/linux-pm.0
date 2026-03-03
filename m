Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41976426D1F
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544210; cv=none; b=OySveWJiMq8SJO8otFTjtMJeQ/+4UnvQXI2/s7OQ0lIA7Q3fv2SlJ6y8oqLgmfVNynHnTsKiRDl5WHHOXTtgPfwxfYiIo/X9NsYsumGQVGtSHUqtR6W8AV0rKcOLrh5zf36+D74Twsddsa+ZBeRvtkNN61VM/xBXj0aVPIIw1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544210; c=relaxed/simple;
	bh=1RmUB4J0WmVWcQ6AXCjH1JjPWiLUQ3vlFDkTR2NbKIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loNueWNp6891BeS+gCTuyKqIrVgn2L46Y06qiJBLwwA550YdBUG/s6BZx4BFcsiR8rDQGodHFXOfRc8XKywpizOqzBOS3RQoUR+pmuKr1JwBexiBRk8YgCZm9zHx19dnD4yAKAPUxfTkCtMjkGYOnyNKnR0uVcL/IRi9hp9k7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=exIebbbe; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exIebbbe"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389f9e70ae6so96052881fa.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544207; x=1773149007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrTcqboCNhMKSZmhSq2Q2fHRWd6h/WAqYEJUXJORyrA=;
        b=exIebbbeTzbG8AM3ibLGDe+oMWsWqhRz6sOCoXirdZKnhpG1aecqWNRIaJh7YzYRKt
         2X2ZMjZx0KEqwWmwT8G/D3XQh5hODNMnG0a4DD1yqIS/ef8EZGfr3wvqLnv0UlEqgpJd
         PuMhD9gsmWttOfL6UYRu0VOgkIlR6W7WjkqGZw8dNuGtsfruPwhMkoxI8gO+XAxo3zqM
         Ibg48Hz25/A4oi5OC0CxABUVUY26YL04xBpeiGNIodDkz5pWGUrkYvf8zT68II2QP1S7
         BM1Z5kcewSGVLsMt7bbgU7gRMnIxrWvFg55/Ha5U0fyI592l+hxL93KjL7pRhwU424ap
         UOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544207; x=1773149007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrTcqboCNhMKSZmhSq2Q2fHRWd6h/WAqYEJUXJORyrA=;
        b=XGKK2hzraUJuZa+RqzYX2hkGyyVTmSCEqKr18r7xXJgxKwKRI5ZF5QVDgPjkNnDiV8
         L/W+vcBteTYE9ENvnM5oyxfJHXLomIN/NFC6PJkL15Rvxuld5u8b0ju1POVocfV+9g58
         e7Oh5QWeBPELt1GUZkLMBDkkDkSEo8m4Oo4UrW3KxGkG/AQrZAtcIBRfb+UL0UDUg7ql
         e3z51QKYzjvPwunultRBhp44zx/iJCRJjwRMPD1qUgOex864roaVqM/+l7UYXPQ1W80I
         fu3EqXjiI3H104JRJxG9qHLlm/k648PFYFmIRn1NZydoUXxHovd5zr+/diaJHA4canzJ
         ZYKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4yaBSQFrk31jVw/YwSenKt1KPWcwBMVgOlySbt/mncqeNiyG8dsrRcMDCCowgU6Jes8gxcllSFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuppghimKc5LG8d5gib6SiZpL+YDzmcAODqIa7aI25ZmHntEP+
	whxg9HCzsA+WiW+Jey4JZgLLQrr4rn4UlPNtPe7AbhHQvZ2EFlU45udBQ2p1Vs2J+Ao=
X-Gm-Gg: ATEYQzw7/wQsrmz6M+sLebwNNWtPMLJ1PBCqp1LrtItaQe1zmaR09yphU+zIM0PGMcM
	wVNFbV+3UNxgW6nWJcW4zDnw2E3HfXDoaB11+QGIZMkpoqhIbkKf5Gu48fOC12e7tAkSHC3aXEg
	q0KURCeB7eKBemwErA6qGN8JIICMvLLucSMKfk2qUvSRza0qjwvaCFASlPSiVF+axh0YhI3OjAy
	+fmF1Sp+HWZOl7AwKGmQX2zurdiftsrTu/6olJZE+JIeoDCY1PD0VyqEctRj83E2t5gfEpSaSbX
	jDCD5VmknpbT/cpnWWVof8rbz6ezuNHVexoQhizLfDHStw/VX1VL57KZNCex4FVla35QuwP6lhM
	GNIviWpMOUk/XKceq0omEMq5sUZrzXrDQXsR0mxZyz9bdP25l5WpZcUyb7HtiV7dodSQ2Tv6aCD
	XlxUgyoXQI93EiEXW9C3di2WB0XE/PbjTq4Hh2b29iiO/GUg8VQQPaO2UsXhR44osSrKndswmD
X-Received: by 2002:a05:651c:25d1:20b0:385:f235:51c9 with SMTP id 38308e7fff4ca-389ff363773mr101440641fa.34.1772544207434;
        Tue, 03 Mar 2026 05:23:27 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:26 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] driver core: Add dev_set_drv_queue_sync_state()
Date: Tue,  3 Mar 2026 14:22:48 +0100
Message-ID: <20260303132305.438657-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the dev_set_drv_sync_state() helper, let's add another one to
allow subsystem level code to set the ->queue_sync_state() callback for a
driver that has not already set it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e6..eeb18548ea4f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -940,6 +940,18 @@ static inline int dev_set_drv_sync_state(struct device *dev,
 	return 0;
 }
 
+static inline int dev_set_drv_queue_sync_state(struct device *dev,
+					       void (*fn)(struct device *dev))
+{
+	if (!dev || !dev->driver)
+		return 0;
+	if (dev->driver->queue_sync_state && dev->driver->queue_sync_state != fn)
+		return -EBUSY;
+	if (!dev->driver->queue_sync_state)
+		dev->driver->queue_sync_state = fn;
+	return 0;
+}
+
 static inline void dev_set_removable(struct device *dev,
 				     enum device_removable removable)
 {
-- 
2.43.0

