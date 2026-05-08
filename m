Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73C3DCD96
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243962; cv=none; b=h4k3vIuO76Ntrerku3Ru7FzxEeeKbdzguGAmas+lp7d3yZ9oNbz1IMnaUiA4AjEbYC6A/XU/3nUMndgcM7Nu/ayRx/qAawgff/51/KuGS+22pJ3gDruHQazPzYvEjt988DEPWz8SCJ1MKn5i9Eq7P5wCyb4ikYEwPDdxDlp4BV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243962; c=relaxed/simple;
	bh=/FNkLhSYKy6TJa1EV5G4UhF+wEANeDUJfI9WWCNYAYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXK0UUMD8PAojBBaa/Aj4N43X0dlwBIojoiVbXVjWzIRm/wAUcPVTG58Gin0mONcvVX/PG6rIKiyGuxKpoVU7462wIhhhczavf/rP30zSdzocGEJ+fZ6z1iHX7SH94TU9UkppJt/cZMiSL30+XRmxBKTZGxsvgd+mV4C6Z6qGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cyy1S6s5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cyy1S6s5"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-393d07e8938so18074981fa.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243959; x=1778848759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZZm1gLHrIJZUIiM9XL9gym+JUwXXpMXWNiMLD+uRZ4=;
        b=Cyy1S6s5JXPuJweuRX4TDxzj4hgNMF8ZPOoL8xx/mUX4lDivbmMUL9ow6UXz4P4PJj
         1qSYJ6goTNuBwv4OlbsKepf705Cj6O9anDCxWzQpA4Cz9jWfed3xZLeCejLXO2cXybYx
         NNv6v8XQURYH2PjdhIbwjg+a2+FHwTXA0vQdDC/RLSoEL73e44AM9OXMUMlR8ceZ90yG
         opSrGisO0bmsxl86TAQGDV3Sl/wtS1U1iNQfvUa68tTGpMzOvYr728pbbXwdfjLiLrAF
         f4MwjoUQ8eKQXP7ChJVRNzwlx6RxQ+HN4xUsUxHpYIXQREFnPnCwuc5AfMxQTHvGlOwV
         zQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243959; x=1778848759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZZm1gLHrIJZUIiM9XL9gym+JUwXXpMXWNiMLD+uRZ4=;
        b=LFQX5GAyjof8r9S4JqXZxsTz/ziXjyVvnmeksTP0U0R8eze0L81j5Ht+gJZDmXRCLY
         L7Maw4Qmgn0xD3Eg10kVPQs+hxMFwQhEK3fJ8ODTLK52Z9AwDcM+CrneHPMrAOWz4hlS
         DkBX27Ej7RFh0jq5CyfrOKakU7MhJSXa5CrruTEA2JOWKes4n43jVugxhjocW7ZoYVUW
         q8KnWLF/Fi1btmCSSuKs82NNmpj2Igt72k+Cj09Oh5daugo3D6lIue+3N59ahysFrPKq
         HBFJcYVj0VKaD7Zhj+nwGovjzUzILm1c65YY4LYx/xh3XH1rtc9inY4SviuQmMbocoMB
         QJsA==
X-Forwarded-Encrypted: i=1; AFNElJ852ElnRldoHOwJLSYW6+D9bytOG+JzW8W99/M3nNa5Uh/367P2m72WK2eZdbG/7zFwk213lq/ZmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWv6qinJm09/rCY9Ivj/FespcdZJpEZdLqW9RRStCU4ZLS3OF+
	GE75BXm4TUReXn992NbF561+1l68JBePKtF5NM0t0jghK6OhzPCEKWwyKcuboxaeoPo=
X-Gm-Gg: Acq92OHklF7O3ZlDp8oE8L4TZmPJR+JL1rEWiaDN5K9bI4tVerKlMeK2sHSUI1x34xr
	QnF6j9BatQfMOBs2m7X49dzh0QtIQJa9/8EjQKBMjU0GzMHUZTPJDAL7/FjsMGdznUQnbjat/RD
	4rvmJ3c19jQxs3MJ9nu5QjC2H5QHknZbweiqsPafjjHniG3zpN9ZiUzBZ/Daz2DcYjbAGZMQo5P
	tGWTxjLijiGa+aY5Tzr606Vx7cITaOjfzJG5L/C8R+ac68+L+xFH5IT65xbrci/SjgKjSTYC9iK
	kfmgYWFYiZq/YMBSEzy1i46jyYSnGNt2Mk+pDDJ7INmM+P/k03h/0nnPXpRFjWtqfA0l6vrMATz
	olmpN3OSx06SlcRG5Zob+6DdlGuLw76qrchTGRX0XPEwgP7b95NctMD4X/MhzpiUj+ylnuaDJsC
	PBHzsqBL38ZmUqd+bs+zxehXNFU+NPpQ1QHzyNueKrSA5g/v3tVgs3T7rQec3h4pHURFvoBE+R
X-Received: by 2002:a05:651c:1050:b0:38e:8411:c304 with SMTP id 38308e7fff4ca-393c41c6deemr33966421fa.16.1778243958791;
        Fri, 08 May 2026 05:39:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:18 -0700 (PDT)
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
Subject: [PATCH v3 01/13] Revert "driver core: move dev_has_sync_state() to drivers/base/base.h"
Date: Fri,  8 May 2026 14:38:50 +0200
Message-ID: <20260508123910.114273-2-ulf.hansson@linaro.org>
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

It turns out that the dev_has_sync_state() is needed outside the driver
core. A subsequent change to the pmdomain subsystem starts making use of
it.

Fixes: 9db268212e0d ("driver core: move dev_has_sync_state() to drivers/base/base.h")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/base/base.h    | 14 --------------
 include/linux/device.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0ed1e278b957..30b416588617 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -188,20 +188,6 @@ static inline int driver_match_device(const struct device_driver *drv,
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 
-static inline bool dev_has_sync_state(struct device *dev)
-{
-	struct device_driver *drv;
-
-	if (!dev)
-		return false;
-	drv = READ_ONCE(dev->driver);
-	if (drv && drv->sync_state)
-		return true;
-	if (dev->bus && dev->bus->sync_state)
-		return true;
-	return false;
-}
-
 static inline void dev_sync_state(struct device *dev)
 {
 	if (dev->bus->sync_state)
diff --git a/include/linux/device.h b/include/linux/device.h
index d54c86d77764..56a96e41d2c9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1061,6 +1061,20 @@ static inline void device_lock_assert(struct device *dev)
 	lockdep_assert_held(&dev->mutex);
 }
 
+static inline bool dev_has_sync_state(struct device *dev)
+{
+	struct device_driver *drv;
+
+	if (!dev)
+		return false;
+	drv = READ_ONCE(dev->driver);
+	if (drv && drv->sync_state)
+		return true;
+	if (dev->bus && dev->bus->sync_state)
+		return true;
+	return false;
+}
+
 static inline int dev_set_drv_sync_state(struct device *dev,
 					 void (*fn)(struct device *dev))
 {
-- 
2.43.0

