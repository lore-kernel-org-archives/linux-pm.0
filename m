Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956542B725
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835733; cv=none; b=Rw8PiJ0pRqqhaudsIIz/p4g8IWKvv+p+zU01pupnLr/epSuW/ON1zkQOeKjA3UH+H9lJWMrs3YXWVkZ87lIlMrErmkyRBOS84HniAQ/AuieVApQQuRK48kvzkwcpPQP1/KU0quT6Cu3XTtUqFb/3hlqglcswIIif7CGDiReCwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835733; c=relaxed/simple;
	bh=aAFwJQgIt7xDHMJ5j64aG3AQ7uDImuBxz1E2PHKbomw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFFJ6ccIrR+f+AtJBBd9eOmKLKu+hJd+WFk6kiKJrBShdbar1+VDLTQHedmHwR6uaOaxpAt+kMkByiRjmtuXfRXx1BDWqdoW9oTyLfwLzoAviU0uUNG90QviCIqYi6zprh5QZdZtqzZGMNjXXQWhcTxkSPUerEkyZ8gw/nmyjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=liyPZIAL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liyPZIAL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-367d88b9940so4928774a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835731; x=1779440531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXZt6qBmARZ13tXsBdYUa2P85z9cDemCtuWb0vwC4yk=;
        b=liyPZIALxM6+z9ZGu5nXZEUgIre9qgeNd9WxG3qRseUNupPzCzh+tPk/eKHRVXJlHd
         1j2ITUUxG+UAMVEnnFt66KZw4NDq+aIjgrVwO3uGt8stuh9cz6LBvbMMFXi9TJxexRNy
         PzUZfQwRC9d2U1vVBxXvikdtfcfu/xMIDAa1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835731; x=1779440531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VXZt6qBmARZ13tXsBdYUa2P85z9cDemCtuWb0vwC4yk=;
        b=p5JZzSwKuH714Q9MZ61O5lUSYQO5pKg02zXVdZ2TEdzHiiGXQeyTzm+J7MUu+jdo5f
         4JeRYGwAP1CG3kIow1FpPHw8iGNm6cR8vtgx++qYipWJ8f4cOGk6loeAdTBywfgPcata
         JNuRD39CZjCTkF2CXlu3IssNh3tJ4WVkL4N59FVqsBAnWPQKx0+wpaYZSlAaait2jIGg
         XYWW9bmj6L14B4PRpUo9SAcVY3Ae14ST7gALCOqlbVgGNWYwKBA6D8HT2+xN4VBCbkss
         YR/8pKS+YPkJRyj9uU58z9Zhli8ODr3PwOCIbnkaEUM5Gcc47paFjvI5xelLxv47cTpg
         u3EQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1SaUsOO7qsffxP6Y+1ke4VRnZlB7W0h5RTquiC4Ha3D7E7VqmXxOr6bdJoHOrzC3eJ3nDuLPMMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPShdEsxA2x28zS0xDbP97b2RGybDXARwoax84Z6DD93wjh1cR
	/bLn8yYwqkcC0zpBuMvJDtCfQGH3BkcPgvzLAzJgXGqe9hcRGHxhi63dPOUrHRkdFg==
X-Gm-Gg: Acq92OEnQLfdSzFqHQRONdj+lKkQMgzqXINPPbNakplv7msRfV32GSXDSq7dMgNk1I9
	3bh+aKupmvYSDUmdVk5tGdJN6RiBB7orZ2/0yTKZpSZjr/wAwr3eL4y9TXN0qmZB0R/t2247QUS
	WkQC4bsm1tLa+nVFEjDRzRFDirGXkZJCuvDhEUNjHAWuNZfGyDn7FRk6LcFfEA7j9kI4guncdVE
	49DfiS68h4hN78byDb/Z3qscxCxLFmAWdbnoF+rzu8nLQD3M4OErIU9Y/e05CNUPmx90NqKbydd
	MkVjtRGIB0OgwgrTYNhDuFtrwMSX3icXwZzMTM1p1pLtmvq87uVLjRMYLgsXQkgAPfURVcRJTi2
	xeD1fS8fcIXhQSyRABkpzVAbvzlQ3I9gfRYKrHRcUHfaLrJDhGrA+Q82eO+NalYFarp8ngELSfp
	xztdw5P38+5bUtYVhKuBCVrDEmXRgPR5Sb9bdPsXD1iawQYYfyTGForE6rk0/jzdkJbMEpVXk+l
	PZBscJs
X-Received: by 2002:a17:90b:548b:b0:366:2668:b5b6 with SMTP id 98e67ed59e1d1-36951b9e004mr3400112a91.22.1778835731362;
        Fri, 15 May 2026 02:02:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:10 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH RFC 01/12] power: sequencing: Add index parameter for getting power sequencer
Date: Fri, 15 May 2026 17:01:37 +0800
Message-ID: <20260515090149.3169406-2-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515090149.3169406-1-wenst@chromium.org>
References: <20260515090149.3169406-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases more than one sequencer could be associated with a
particular device. For example, a USB hub has multiple downstream ports,
and each port could be connected to a different M.2 E-key slot. In this
case the index would be the port number. The index tells power
sequencers for different slots (connected to different hub ports) apart.

For the consumer API, add a new pwrseq_get_index() for new users. The
original pwrseq_get() now calls pwrseq_get_index() with index = -1.

For the provider API, add the index parameter to the .match function
signature, and tweak all existing providers to match. Actual use of
the new index parameter will be introduced in the next change.

Other than the API change, no functional changes are intended.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/core.c             | 12 ++++++++----
 drivers/power/sequencing/pwrseq-pcie-m2.c   |  2 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c  |  6 +++---
 drivers/power/sequencing/pwrseq-thead-gpu.c |  2 +-
 include/linux/pwrseq/consumer.h             |  6 ++++--
 include/linux/pwrseq/provider.h             |  2 +-
 6 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 14335c4f813e..1a91ee6d416f 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -612,6 +612,7 @@ struct pwrseq_match_data {
 	struct pwrseq_desc *desc;
 	struct device *dev;
 	const char *target;
+	int index;
 };
 
 static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
@@ -627,7 +628,7 @@ static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
 	if (!device_is_registered(&pwrseq->dev))
 		return 0;
 
-	ret = pwrseq->match(pwrseq, match_data->dev);
+	ret = pwrseq->match(pwrseq, match_data->dev, match_data->index);
 	if (ret == PWRSEQ_NO_MATCH || ret < 0)
 		return ret;
 
@@ -655,16 +656,18 @@ static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
 }
 
 /**
- * pwrseq_get() - Get the power sequencer associated with this device.
+ * pwrseq_get_index() - Get the power sequencer associated with this device.
  * @dev: Device for which to get the sequencer.
  * @target: Name of the target exposed by the sequencer this device wants to
  *          reach.
+ * @index: Index of the sequencer associated with the device.
  *
  * Returns:
  * New power sequencer descriptor for use by the consumer driver or ERR_PTR()
  * on failure.
  */
-struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
+struct pwrseq_desc *pwrseq_get_index(struct device *dev, const char *target,
+				     int index)
 {
 	struct pwrseq_match_data match_data;
 	int ret;
@@ -676,6 +679,7 @@ struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
 	match_data.desc = desc;
 	match_data.dev = dev;
 	match_data.target = target;
+	match_data.index = index;
 
 	guard(rwsem_read)(&pwrseq_sem);
 
@@ -689,7 +693,7 @@ struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
 
 	return_ptr(desc);
 }
-EXPORT_SYMBOL_GPL(pwrseq_get);
+EXPORT_SYMBOL_GPL(pwrseq_get_index);
 
 /**
  * pwrseq_put() - Release the power sequencer descriptor.
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index ef69ae268059..16a332f9da7d 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -158,7 +158,7 @@ static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
 };
 
 static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
-				 struct device *dev)
+				 struct device *dev, int index)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 	struct device_node *endpoint __free(device_node) = NULL;
diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index b55b4317e21b..ac6b34e01c51 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -335,7 +335,7 @@ static const char *const pwrseq_wcn3990_vregs[] = {
 };
 
 static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
-				     struct device *dev);
+				     struct device *dev, int index);
 
 static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn3990_of_data = {
 	.vregs = pwrseq_wcn3990_vregs,
@@ -436,13 +436,13 @@ static int pwrseq_qcom_wcn_match_regulator(struct pwrseq_device *pwrseq,
 }
 
 static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
-				 struct device *dev)
+				 struct device *dev, int index)
 {
 	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vddaon-supply");
 }
 
 static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
-				     struct device *dev)
+				     struct device *dev, int index)
 {
 	int ret;
 
diff --git a/drivers/power/sequencing/pwrseq-thead-gpu.c b/drivers/power/sequencing/pwrseq-thead-gpu.c
index a45318b4b2c1..cb7a6ea66c4b 100644
--- a/drivers/power/sequencing/pwrseq-thead-gpu.c
+++ b/drivers/power/sequencing/pwrseq-thead-gpu.c
@@ -115,7 +115,7 @@ static const struct pwrseq_target_data *pwrseq_thead_gpu_targets[] = {
 };
 
 static int pwrseq_thead_gpu_match(struct pwrseq_device *pwrseq,
-				  struct device *dev)
+				  struct device *dev, int index)
 {
 	struct pwrseq_thead_gpu_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 	static const char *const clk_names[] = { "core", "sys" };
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 7d583b4f266e..d5d57cdb0c8e 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -11,10 +11,12 @@
 struct device;
 struct pwrseq_desc;
 
+#define pwrseq_get(dev, target) pwrseq_get_index(dev, target, -1)
+
 #if IS_ENABLED(CONFIG_POWER_SEQUENCING)
 
 struct pwrseq_desc * __must_check
-pwrseq_get(struct device *dev, const char *target);
+pwrseq_get_index(struct device *dev, const char *target, int index);
 void pwrseq_put(struct pwrseq_desc *desc);
 
 struct pwrseq_desc * __must_check
@@ -26,7 +28,7 @@ int pwrseq_power_off(struct pwrseq_desc *desc);
 #else /* CONFIG_POWER_SEQUENCING */
 
 static inline struct pwrseq_desc * __must_check
-pwrseq_get(struct device *dev, const char *target)
+pwrseq_get_index(struct device *dev, const char *target, int index)
 {
 	return ERR_PTR(-ENOSYS);
 }
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
index 33b3d2c2e39d..a2ec6c612c8b 100644
--- a/include/linux/pwrseq/provider.h
+++ b/include/linux/pwrseq/provider.h
@@ -11,7 +11,7 @@ struct module;
 struct pwrseq_device;
 
 typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
-typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
+typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *, int);
 
 #define PWRSEQ_NO_MATCH 0
 #define PWRSEQ_MATCH_OK 1
-- 
2.54.0.563.g4f69b47b94-goog

