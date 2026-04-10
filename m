Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038E38CFF7
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817672; cv=none; b=jyFat0sJpSI09D77is+efZMiu0UV+1g+FhQ30sIdY4L8iJJ4cTstpVN0bypoB2qa9848W15U1t3R4DNoGHVNnGedobCCWF7//xek9CbKRxsQNu6nA9qxQPNn0n0tyTfofAdsW8TzwueeAT0Mo3XJlOmCgoruHZz4f/nzh+orLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817672; c=relaxed/simple;
	bh=YnkcGtx8iAEVtzUA/GgIFUdFTLKhu7OI6fU88Arifyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4whriQL602xv4tnFsJZEBKDeDMXH8zksaqf6eLjZMpByS/oLDq+AiNiLRXxgbZeUqTk1uBtLbJNE113KnyjyF9JOiOSsXgA7ebLaMCDQKL1fpPCYm9edcUIqGZcXBv0jFXbf9f23YyecwX3RmWydt38gaQHF5GEVrreKUoX4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkYB5RGM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkYB5RGM"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2beddab48so1813810e87.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817669; x=1776422469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jw17PSEZKCRGEFR6RMdIihAAVWvt1U/1bx2cCz28f68=;
        b=NkYB5RGMa6mijdw4IWMIzjlRXN/ETzzJSmAUa7P78Y3UHWTXUvKmMCuBfGdEiImst+
         xjun1OwP0nVrBgCiXOoNvOb+TUJnjereYe1Az3kZ8Ocd9tbLGoPBysFHAGMF+h727x0P
         KypWOgAJo9JGYDcR7dUuVUnBZkbsw7jmMEDW4qm3B3xtwAjD5rYvh2O4XKCnSCoSIzGw
         0Zfy/VkEAZt1ZZdYpjelpa1pgE6alRrS7bij+/IyDNAse+8brscuI5M8S7ZdQPbEyZJe
         j93wmHzyQ8arqG331KEjsHJxF4DOS9BB15PgQZ+l2pqgI8NvzqvIsPlutkjfEAjnbQzB
         9DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817669; x=1776422469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jw17PSEZKCRGEFR6RMdIihAAVWvt1U/1bx2cCz28f68=;
        b=IONYHfuFQYtPyCO2aAvJrO4bsUo5PS5dbR4annaI5/q8GHIVlOXLBnxWTadqitV9G2
         7BCdO94RYZTQqygr/T1irRgslySQjMaotAmfItPV6hOkVCwN0wCclt5L0ESf35XO9KiO
         LWYYOnicl+WHizOJ3MFfWCzCrso9EI5qXXq57wyz1vxJLVi41m307aEQhVsuWUUnioDi
         UpkPMjgdN+Dc2kxYg0A4DHS/nu5inozo0yR1BhlRo8CmzVkdv0hglNPc0zpL4jex7Yju
         bjNW0ua3f3KMMMEod1dXqc5JJSi7vG1hIYQKNFbFKXU9vYYikmWcwi+7s+6BejNxdCun
         bm9g==
X-Forwarded-Encrypted: i=1; AJvYcCUs4/srpmimbV2ltVCrRCtCCpGKs/zQ77B26IdzlyFhOALh028JGUU8eJHzapepIq1zYv9ZtcRJoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCUIzQ8Gr6/etQblOPcABEi+9h8WFfUAiDuKWtr725p+yRCY1
	UIov1uy+hAoJkNSdBdD+xmOV9/o9jGOhtpd74h2y4UYBalolSqeafdtgjxocRmxOuGE=
X-Gm-Gg: AeBDievfq85upJxdV8CavJFcAMUe0DWAxGeFzKDKkVFx5b2Fnum34FUFDTg+uLS5TCI
	l7j4RqoCmV+L6jdSe+GFUPaH+/nhCKbydNFjGnBb6c62A8R5rQ402F0pY8NiiABn0wUsDUH4Oa6
	QOE3XsFhCjTF6SITavE46rvYeijQXiVwLz8UUnpyMC8D4GfnJDAfiip7CLIqZqZ3vpXPoEgRQy9
	Zi8xtyHsm3EHd4xhnNL8XrFjV8A5W/xl3k0qSElzoYTs2txqCWyPB0p1/U15x0T7uLZ37T1bVwS
	iVkmELY/BQQjLzw12RJ419wJdSjKgct5EaBYtTyI5vhDAge/ogRpnRaD2FLrKbRDBLe7iW3+fu+
	N7fBKLBNAZvovmJBAb2MsRQmNUI3H7YbbyCwLPriFt1OFqJCuog9UXBUcJC3MED14zXetx4Tk4D
	FHUwUrlzQxF0Ycm/OmW67OP2Wrdqxh01Y8EATqnQrpt5h6UsLvXqTssDtxlOVqXw10tuY9vibc
X-Received: by 2002:a05:6512:1293:b0:5a3:d375:f587 with SMTP id 2adb3069b0e04-5a3efe991e8mr817900e87.35.1775817669011;
        Fri, 10 Apr 2026 03:41:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:08 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/9] driver core: Add dev_set_drv_queue_sync_state()
Date: Fri, 10 Apr 2026 12:40:45 +0200
Message-ID: <20260410104058.83748-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410104058.83748-1-ulf.hansson@linaro.org>
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
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

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index e65d564f01cd..f812e70bdf22 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -994,6 +994,18 @@ static inline int dev_set_drv_sync_state(struct device *dev,
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

