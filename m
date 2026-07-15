Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9C3D88F5
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105665; cv=none; b=h3bmWjViLArmicp4DIs5i2n0HRPlxtaX/5X0EybaXyNhkKU/E0gQtUnG+ML/px6JKQfwNnu9lVze/5bRLr7Fsr2DC3PFcrugoEYLjDOHC9z5qWlv7DgORNGAiXVhZWlrZG0lEL1YrT+PrFzNTEkE+xFG/xiP0HiuSIcXDbu5Swg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105665; c=relaxed/simple;
	bh=sHMrDgD936gJSs9bJLfV9Xhglpv5Agcq8aSC2pp7OfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfo9kbKFb/AtpypScJ7MvA7MOPcms2xIbvASr9qbnd23bKUcl3zveEHo4E4CXviGYoaNCJSNb4FSZ+5qOnD3535o8xfxNd6VIwLLPOHa7tUagkFkfubMwLbLMDtnem0wmR+b9hjVwO1e1WZ+B0b8JcKOO6X+sz40T1ayV0Tx2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ParLHhyM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ParLHhyM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848743155bcso787337b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105662; x=1784710462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XAlo36/cvqlWCfJP/st8V9NvEK1f/LvSK5OHVxavmM=;
        b=ParLHhyMLjNtZyB47iyTQu6bup3gTadNnJF4K/RdC43t9WZqyYxs41M01cpNtDEuDZ
         gKWxPz2jeK7D5s91p4R71J5TPrecM4fjNCnl2sHMivWga/g1OP3YR35F7cyuz/1v2/RQ
         EXKC+264rTh6Z1T/5knxodQ6pq8aZTSwK8jCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105662; x=1784710462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XAlo36/cvqlWCfJP/st8V9NvEK1f/LvSK5OHVxavmM=;
        b=Bz2+2AIxWLjlpHRUbMbbpn1Tgrjp2zrNoM/tSbBBnozckdouvMAqVmjRYf7R9SI3MB
         mtWgTKwONk2DqBUfjUsFHpEaML56uat7R07z+S1CaRJBz/NtRNTRXh9jpZi/11yM/0PY
         bMJ0yawV0jR2r6DQbki/6LvJHZWgXZTR3BephaV7GaVxRx0pw164xc56XURkERy9D+6l
         XrF0cyzioY8NCftBaXx0920VfPwqbAQ8kYB4GcZxnGV3intXbzXK8KufKEzRUm8rA133
         wWDhKSZyuvthcplcHldz7+gP1WedgBA3RYhNAvYBmf8xjv+tB+8gPM3jjoetUzg0il3d
         dVSw==
X-Forwarded-Encrypted: i=1; AHgh+RoklIOY84Cuvbh1O1AxqUc6Qdwi6ZwwY6tgbMV/MHHE45aKSP9kpc7JeZtAVEhGiaNOAoEHHNkNVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFrzskXWKmbnQM0QZ9k5mZYYUx9+VC0xo1codyNSl6R2oKoZCd
	7mhCQy9/buXdloUV7EjGFl/EfbAB2SX8qMuLTN7oaW7OcoKOT4lUxFKcKfoj+hj4zA==
X-Gm-Gg: AfdE7cneLkE2HYrmzvNOXv8fo7p/Z9GYwpa2owJ+PubVLY3UQ0JxNSTI+hAfGyMD9sy
	Z42NcjksYI3RXKYakERnK9oUfb9J/kkivITm/672jVsS1t8rGd07nl/01JHYTjXx5U4FKT773UE
	hWRKZHakHltvokszCswpYg9Lt1tpekORjyFiNLx4WqsYFepmDAThOakNo/fs3M3Mjo/1FWJGg1m
	+KEDUSNTXvfc6Lb1uWeP2YIJyt0Fi3OPny0dudM8tqkzKQz0jiAxdOAqWFwjHf4R0sljaDsWW1/
	3xvsS5uTZ4Xj9v0VAXJ/jFEJY95Z8gVG9HHGVQmI1MccMPaymE6d6h32xn2QFu4cCemFRqdPPPE
	Hw/VNeHfpg7xgJrVMDDzd5NFq8lkXY1/tfToAInGpGv4GhTB4dIiaacQqeQA7NrkD+ExOAOZNy6
	x5WHMVGD/asbZZ9wpJHe9ATLFhCHoG/1Zt9KgcRa2foXtF/vSVYjh7KbvblPaMLEu8Uyuyzw==
X-Received: by 2002:a05:6a00:21d2:b0:845:c6fc:2821 with SMTP id d2e1a72fcca58-84889604f51mr14884898b3a.22.1784105661732;
        Wed, 15 Jul 2026 01:54:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:21 -0700 (PDT)
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
Subject: [PATCH v5 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Wed, 15 Jul 2026 16:53:31 +0800
Message-ID: <20260715085348.3457359-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases the driver needs a reference to the port firmware node.
Once such case is the upcoming USB power sequencing integration. The
USB hub port is tied to the corresponding port firmware node if it
exists.

Provide a helper for this.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Added flags parameter so users can specify whether incomplete ports
  are returned or not (Sashiko)

Changes since v2:
- Moved "Return:" kernel-doc section to the end. (Andy)

Changes since v1:
- New patch
---
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9387bb83eb54..950defc0c55a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1346,6 +1346,35 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
+/**
+ * fwnode_graph_get_port_by_id - get the port matching a given id
+ * @fwnode: parent fwnode_handle containing the graph
+ * @id: id of the port
+ * @flags: fwnode lookup flags
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Does not return ports that belong to disabled devices or endpoints that
+ * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
+ *
+ * Return: A 'port' firmware node pointer with refcount incremented.
+ */
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode,
+						  u32 id,
+						  unsigned long flags)
+{
+	struct fwnode_handle *ep;
+
+	ep = fwnode_graph_get_endpoint_by_id(fwnode, id, 0,
+					     flags | FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!ep)
+		return NULL;
+
+	return fwnode_get_next_parent(ep);
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_port_by_id);
+
 const void *device_get_match_data(const struct device *dev)
 {
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index 14c304db4664..480ba8646bcc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -505,6 +505,9 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id);
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
+						  unsigned long flags);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.795.g602f6c329a-goog

