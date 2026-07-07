Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05C3FDBE5;
	Tue,  7 Jul 2026 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423122; cv=none; b=KP66+heNjBC4Nsv77OEICIfthV4ytZylvT7Gh/XtIGUO+MZgosLykHoIYZHBbtk+Wkq9eF68aw8AIulIYU8sC7wdr32GkgWt26cYHb0YN416lw1YmihjOIoP5/JQh7eWRtnc3XVorJxtxFVAh1dKDrvIRmwHiElhq3Wt6Omfbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423122; c=relaxed/simple;
	bh=OQO/bpNIbqgwedjJgJd1peQziQOZa6VYWkfGNzRXRmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFaCljg/sC4yCwO8dIIjnblcXKr1aYn2jGjAeMTYo2EgGGFdtgcHY0vZLdUWm9xef3ZztbOSGgm7ewrstvoT/MV1sMvbjEPTrsAnHt6zzwwisVT9PE9plqSIksvdHvI/9+9srqYEieKugqWkWrR+nHzDkeVHy2VO5rNW2buHPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iM9yeYzP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iM9yeYzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783423119;
	bh=OQO/bpNIbqgwedjJgJd1peQziQOZa6VYWkfGNzRXRmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iM9yeYzPmoSe1Tsr4pqAX4xstQ86eqArKF+VbRsxMB047JYwaDvAQQRJbfhLD9Od4
	 zi5MTvvBCOjdcZqnENNAiTKU+yGQeIUMlMYkF9mZl8axbo7vR+TYVb3dB1Na3/105C
	 7RX6kyevhNarNv0t9khIJhbjpKmw/IHCrO5BIb+lUJx0pBQjzJYxZrbEgTkud1a3D0
	 Kdg7XDP6Ti/vFfH16vGu+I4yhkchtFO3Ng++xaylAO5MlCr3rAfIIy4Qzc3kxG8mIy
	 dKM/3H1bzSkGWY82DOgn0dIoOUGdDDfu6csBRZ9DBk/hUCSpuaZ9DMN3LD9ql1jCV3
	 SPV/7hNm6BoHQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AAFD17E0713;
	Tue, 07 Jul 2026 13:18:38 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org,
	sboyd@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v12 06/12] spmi: Add helper to get a parent SPMI device
Date: Tue,  7 Jul 2026 13:18:23 +0200
Message-ID: <20260707111829.180158-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
References: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers that register a SPMI sub-device as a platform_driver are
not guaranteed to have a SPMI device as their parent: add a new
helper `spmi_get_parent_spmi_device()` that takes a struct device
and checks if there's a parent, and if that parent is actually a
SPMI device by checking if its device type matches with SPMI: if
so, returns a pointer to the relative struct spmi_device without
incrementing any refcount.

As a note, in the specific case of using this helper to retrieve
a SPMI subdevice's parent, the spmi_subdevice_alloc_and_add()
function does actually call device_add(), which will already take
care of raising the refcount of the associated parent device.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c  | 23 +++++++++++++++++++++++
 include/linux/spmi.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index e218c8140545..a0a6ea9b1d2d 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -433,6 +433,29 @@ struct spmi_device *spmi_find_device_by_of_node(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(spmi_find_device_by_of_node);
 
+/**
+ * spmi_get_parent_spmi_device() - get the parent SPMI device from current dev
+ * @dev:        pointer to a subdevice on SPMI bus
+ *
+ * Checks if the passed device is a child of an SPMI device and returns a
+ * handle to the parent SPMI device without incrementing any refcount.
+ *
+ * Return: Handle to the parent SPMI device or NULL
+ */
+struct spmi_device *spmi_get_parent_spmi_device(struct device *dev)
+{
+	struct device *parent;
+
+	if (dev && dev->parent) {
+		parent = dev->parent;
+
+		if (parent->type == &spmi_dev_type)
+			return to_spmi_device(parent);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(spmi_get_parent_spmi_device, "SPMI");
+
 /**
  * spmi_device_alloc() - Allocate a new SPMI device
  * @ctrl:	associated controller
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index a78a8924b2ac..4daebc980501 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -189,6 +189,7 @@ static inline void spmi_driver_unregister(struct spmi_driver *sdrv)
 struct device_node;
 
 struct spmi_device *spmi_find_device_by_of_node(struct device_node *np);
+struct spmi_device *spmi_get_parent_spmi_device(struct device *dev);
 int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
 int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
 			   size_t len);
-- 
2.54.0

