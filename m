Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB823DDDB0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243969; cv=none; b=j8xUr5SuFXMKiCgc5VbxZ5MIE8F6B3vr+SigbqUSWWkZFxPTmDv0s7G0sWY0Y3pyIO9mPS8942FEK8vNC/vN7EizNxZtumlLlemWpwbWUaaFC0N1g1lOC2sDAND4p5QBWds+gZJ00a6iKtkO2PdFYuI3YDb1O0Aka5pmQxlzK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243969; c=relaxed/simple;
	bh=x21rpCj2MmWyH5v65OaxPiuzKvSW4AaipSpIKhwJrLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHPMPmaZ4iVlUuVQdAidyQe4DNIWTw01FyKGb9v0qrv508qzDHKED0lOLaNzjH/1c6NRzqsyNpGqkSutvTK/DgMPl84fv5Az7Ba6ersuoRz49iBJCv3OCEhTnbfWLUt0Pduk3P44LRhAXuhzsMlC1aClUlZF7I08G3CgZh9CStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OATle7KI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OATle7KI"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39396f873adso22281351fa.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243962; x=1778848762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rFfqTD2TBGaZTLksk3KUxZXH9uYFCtiZXBW3shTh70=;
        b=OATle7KINkcwJisGtE20AnMDLqjtDjsMTw3zhh166tHhiiz4V6eu/5fxw+KGwSMyh0
         6eIP7eidlAZQM13jWuO7XVnlZE7yBOJCQiQY8WMRsDYZ3cgKdAi7oerJZyr61jG8Vhdz
         7+31MMDQ486CK2MiK5HVfx97ztniU6KAjcfc7VwmKTnxZl1Ii/l4/p3ZHWETIPxKSHf+
         bAnPRh2kgxWkm3FHb0pPU1qNtwiFDX2XvT1w5FFzKOetSYaMz6A1VnJhvg6pxJj3aS/p
         FPEk+w/fCCN/bRFJ6APuU0D2GKmvQP/HOqjEHfmGWKRIWA+iQmMgg1Wfv+rX2oQXjBxJ
         PAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243962; x=1778848762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rFfqTD2TBGaZTLksk3KUxZXH9uYFCtiZXBW3shTh70=;
        b=XusZ/ZhALQGWUqZuuRvIk5n0n2bjKMaB2z7qjO/e3I04m5PHapiI8Zx2/fROY5ve4l
         9vkk66ndDh3bZcRot6T2tThb0fRLkkVjvQ1zAASuNsDRUbw7pJqmUY4wbtDMYZppFOkO
         NMDWthZqEjwmMvw5EE420K7NO3kx3+3VWbXTHX293ptF9PJ8r9Ub9OpVHTuG/l6hzNKK
         EZwbp4vwA7JVGv0FG1dX1FK3CkTpZ6Szrph1cmca2O4l3qQZ5ibaqFtrb/faOw7nA47y
         g6qEvF2Twt8KwTpF7kbOrdUcWjGzTb1irRgSiHoMNHjUkadMHsJVn4+M2S+daDEhfUoi
         CLxA==
X-Forwarded-Encrypted: i=1; AFNElJ+zvNhh02rrcK4Ks8YZw7wxX2nIagww1gt+hM0qyIhB6SZUosaF6Q/PlWcgzJe6m0YFPggiwpzd4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgMUdaWMzfhcurWduaE6Np3P42Xzbo1CBwqzRCsCU43hGDvrT
	l/9/USZO37JImpeDyYToccRCVa6QD+h4ikXJNz/2kLfFxyPewzlYo9y3+97deqeGdug=
X-Gm-Gg: Acq92OHM4uGWl1s5pY5zUd3ajSm355g+PZ//+jzVCc/OInusaogvLMhT0Ffv7xKdu01
	o/fC9fmFA5wFly6uTnzpKe7Bgbr4p8t0PCTAC027xb++7eyzNcG0SXupCXQ91gO33KKIcniI1j+
	rAooLm6RbyrWmn3CoiKMXrM2RnYtinisdBFbUQzdB0pwoBHbT/L8H6rQUcepn4+Den/Wgv5GYlF
	1l/8nrYDYIAtPKWehzP8twPGorQXodIAns/V9sz9zxL87WQaxQgf0vIEQere9KhIdd2yr9mO0Vu
	RiCBz56lHEn1jh7TnMFj7N5YP1atnKhX429R3JatTLu4dJsjN59vNMOBjxzKYPRHAJSYxJmAX3b
	+aJvbApnCOI84T/lokwLvu00b+7faTeWiY4hbpWBAWmXS6R1MmO7EW/9Eqhj+aHrdx5WkhzOipK
	KG8RG2dWm2Mkzn726z2FqtW2uPAPKA2z3+27uYGKDeKSDeGexdI45HSOHOlRjquY5LRuZc2q6C
X-Received: by 2002:a05:651c:318:b0:38c:6b42:3d77 with SMTP id 38308e7fff4ca-393c40ccf92mr30580291fa.2.1778243962364;
        Fri, 08 May 2026 05:39:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:22 -0700 (PDT)
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
Subject: [PATCH v3 04/13] driver core: Add dev_set_drv_queue_sync_state()
Date: Fri,  8 May 2026 14:38:53 +0200
Message-ID: <20260508123910.114273-5-ulf.hansson@linaro.org>
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

Similar to the dev_set_drv_sync_state() helper, let's add another one to
allow subsystem level code to set the ->queue_sync_state() callback for a
driver that has not already set it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Added documentation.

---
 include/linux/device.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 209feea8050e..e32f85e8d80c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1097,6 +1097,26 @@ static inline int dev_set_drv_sync_state(struct device *dev,
 	return 0;
 }
 
+/**
+ * dev_set_drv_sync_state - Assign the ->queue_sync_state callback for a device.
+ * @dev: The device.
+ * @fn: The callback.
+ *
+ * This function dynamically tries to assign the driver's ->queue_sync_state()
+ * callback for the corresponding @dev.
+ */
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

