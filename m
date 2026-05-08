Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB853DDDC4
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243966; cv=none; b=e9UrRlDXHnMG1qKloKSsr5aQB1Pe7cdvApuXLJgo8PqGfM+uU0vxnKfskTEv0q+FxFb5E1f8v27fMr4d05QuX6ptZcjwdarAn/Lb1y2764IVwdcn+dqiX78aufsmooulns3WpGFfLmANIW8PuZJ6Lpj9Q64XS59gsirKze9hcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243966; c=relaxed/simple;
	bh=G5akryWM8vUlizcTYEH4n9P7Fe2yWjCrGils/cTwsKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXJF5BanPa/fJwYXC4l0aKFmZVwv6g63iZkMoaJVbyq91WIHCUBtHYEkK3AV3z3vzZi1663BBOiREaMQogh6JZNHi4U4R1SoC8eNZxux0XOO+yLsBRGqSk0o/gfMp1LLvm6krUzVzl236cI7GDFsEPAb0swQ31nhFy5Va+bhclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fymJMKCf; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fymJMKCf"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393da8f389bso17122171fa.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243961; x=1778848761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqUco5wqhLucFlDbE4HzM7pJWTB6souJwvWVN2LvT1g=;
        b=fymJMKCfRqyRNfo0ek+QV6xQomsWu3roanMIOF92u805bfN4PCUJPaqHi2rZjSALAG
         jPPqLz4KqD7iD6T/Z9DrAbezKxo3IA2POx5rD4MlwNLsOnzOrQnCRUXlMrgZ1MgGAPo8
         glUEY5Xrx/H3q4ZjRpIOOEjRfFJF8FLmL5Wz7o4+AUWf85ENkyOa5bEexiqtyX78nysk
         /87ZAyDgub/Gq2+uvB2TCllNS2tozsG4w/hmRZN/8bvppmYWFJn6Ivw/GKK1XD2w/1tn
         s6Nt2JaVDQc9KfU5dBE8/KE+Ljjj1LwA8Bsa1ogSL4PqXR6LBachXvZnGFUflUFQ+t/V
         Lumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243961; x=1778848761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqUco5wqhLucFlDbE4HzM7pJWTB6souJwvWVN2LvT1g=;
        b=SxW/Fft0okep/Wbe3X4fvni2O0JV2YlfHAL+7MKhb+3t4aFD2zVp3mpFW897JyTNcf
         /aWrX1meyKj5hH8gRuAz67F/hwB9xFKmaI6ce1rxMWk0i5AwPWPQtfSla1Cao8YCRQzN
         79ovGF2VVteZSqMZxJBDp2xC7Fg6W3B9aO1lB14tKGb99alr/9BJ033x/EUs7kSeKJIF
         5EcCoHSrzkh5+VGW9fvhvBnpw9WdLF50BUm5kClfVynbzOGpa229mein5ZCsGOQX3ev2
         qfFK7+YJmr0F3Vwn4d4qoqRkHroAGk6nkoaiYCwZNpBbmuWud+dCj+j6hf4iz+rt6Pb7
         eJIg==
X-Forwarded-Encrypted: i=1; AFNElJ+2+SDd9MY7DCFW6MdGPmT9TvpnqA9vT3xDtgY370NeZc+IqOvVG1J9BtxGD/A5HDJjtdnmHF7ffQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Br9yKMZu0mFQvF+DEDn5CmpNYYjHELTifNgcwIx4nFzwu152
	aTLYcKMAg2uzYHmnHcXreGoBx2LviTwNKLI+go+D/zqXhS4vSiLy71jFcaB2GHfJ99k=
X-Gm-Gg: Acq92OFEF2WeQmRUhFs+UWYoQgNP/NUGInOIfCrJpNDnpmb0mIBeX4cyHJVSDe732fh
	oHkE1f8i2u8uK37HLeZx0B9o+Hme1hqWIESuLzf4kbwZ39QOncR6MkYlaZ7mbJUyT/cAsXt8hxd
	XBy4ycFjvBVWMy2UxVZ1ey2EN47YxWQ3Lrz+bkCeM00l5qrBkt8ann+bj0WUWGB1NiEREsOlG68
	bRCS8fJaNvmtKLS257vP3mq8FIrh7sgW/mx3AVoWXNbnMvZj2/CNDcbM7s74FPHcEiZSyosILiH
	MQVUIo+0QeE/PnBUI0ik0GiI8cnxnJl3STWx4Y8VRY2DqoyVk1UWy8k4llhrT9fJ1DCzrfCBrLS
	vb7R9MQbMHT1ZqHdnYuLU8TfyAOwsUxVUFYHHrT7MTg37HFIOy2vrTM/QAfHNcOOfcCYcP+oX8Z
	0409FN/9o597Uv2TVsrBkP444bxNnu0Nv/Z4WDFlxRDBLW13L0jzTY4WFagsU0juyxjseQRnje
X-Received: by 2002:a05:651c:4187:b0:393:d6dd:e8a1 with SMTP id 38308e7fff4ca-393d6ddee4cmr27954951fa.2.1778243961174;
        Fri, 08 May 2026 05:39:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:20 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
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
Subject: [PATCH v3 03/13] driver core: Add documentation for dev_set_drv_sync_state()
Date: Fri,  8 May 2026 14:38:52 +0200
Message-ID: <20260508123910.114273-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508123910.114273-1-ulf.hansson@linaro.org>
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As dev_set_drv_sync_state() is an exported function, let's add some
documentation of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 include/linux/device.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6848b0a2c2d9..209feea8050e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1077,6 +1077,14 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+/**
+ * dev_set_drv_sync_state - Assign the ->sync_state callback for a device.
+ * @dev: The device.
+ * @fn: The callback.
+ *
+ * This function dynamically tries to assign the driver's ->sync_state()
+ * callback for the corresponding @dev.
+ */
 static inline int dev_set_drv_sync_state(struct device *dev,
 					 void (*fn)(struct device *dev))
 {
-- 
2.43.0

