Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5153F7A9B
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511339; cv=none; b=V/Ii/2KhLEoyKZsrELo4TCGtHM6KnCSCIwv2XuDfJqvqTNlAlXD6IxD9mzmV4VqM37oAee12llPjQoJTNkPK4jWb7ja0KuiFc/diDCof67tcQgT12p79AXu9xNNI1R4Tzes2jKTKU0DRGom8oE8mQfmJtwgU/roa3xwdDF0O79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511339; c=relaxed/simple;
	bh=RGLL0tPfDP6uNlWVczfepdqpvZGR4BjUGaRZ583Zkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbIZl8gRrGfzhnb2bu70H9MpoCkJS3DjMBwKWQaaLtnShwzHuBDCu15OBlPbfOWVUP518L0E66sbfw5naRGxI2Wlw3BCShMLXKYV6evYQDQ8fDAUX1QWZXzLDibsbK8Fxgtfp1dI2BeDlJ914uHMgOCd5+KNRZ7S3khC/M2mNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SdoxKF/l; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SdoxKF/l"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d91ded8174so6493675ad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511337; x=1789116137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRetEA2OXFI4SKJH2CBFzorRJvZCDQyI99zumpuCSb8=;
        b=SdoxKF/l8oxoFHgKxIo2orVm21tVNJeFZDYAAxz/og1s6K6/DLU1+vy+GxEnQ+d0O0
         fH3coiOH9Oliz/lEqLyhSc1d8a8rS/4hCT7ewMQ+3J5qSbEMzkxbHxURGEcATdhgisYI
         P4/Zw0UjWnATRqqNQXFB8t1U7BgppgBSCHS9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511337; x=1789116137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRetEA2OXFI4SKJH2CBFzorRJvZCDQyI99zumpuCSb8=;
        b=Q5pMAGHQqvGhwWuTDO+zB1FxVQq4GcAcpvN5GDjyhVK/PsklGgtVKKAGcfG5ZsKqhs
         xqrIMrt91ul5tsbKFHEPeR9fI0jxrVwCV77gTAisR4xZdqR57a9N0fbHQVEMjJCkcdfr
         UBopDuqgP0b2PmTfNZyLL2KxGGHt3aXFx3IdDT19KJrI/bihVzz43xNeBd9/J6hkU0YQ
         fApqrzaSFLw8gEcNEDBNsQ8uuM9qwFewhq275oMoJ9vYn6/SZMvFRZXoZvZHwWQ2l5gl
         GHRx2BSk5xYFrDV8CeKQ1UGPHaUnq/mQbrX7TvrjZee6RwUDBdji6upyPl/tUu65HRWC
         AnCw==
X-Forwarded-Encrypted: i=1; AKwUvByaWWhYQ8tGJKYNptUvNyxSE7f7kF9yoLs6LuEywrAdtB7yYrk22ATGuMFsSBNTgkEnloL57l725g==@vger.kernel.org
X-Gm-Message-State: AFuF++l22cgi+q07Xro3waxwAd2bn7XLUeqdAXH0Pd7YxuHSLPmxPIYV
	y3JmZZhe9AgNKighlak7Vw72ppESdB7o14KtHpen+80iAfFNeNKtKA1iVILvm6SAKg==
X-Gm-Gg: AYBFou1Ce+Q4IMs/kHc+/4VNA4MfVN8iJCIkfwoJMW9oy2rWKi4u76IqlETOucReqz7
	mSVQq7uGbcMwQ26aInQHrCvy76AMmhr/GEI74YQyYJQHVqbF8qrg1qCJsSl8qPAlFHage+OLuf1
	m+yZWkbmbVMjUW4f6H9RV5XNrSeOu3qZAmUDtrcece0LWriwwvduLrcnCWrBtCaUizlO3TdAK1M
	INVudeyjZubsyqv0GF5PI6DY4ICRvumKkR2d3rgOrt9EikxL1OH9bBmpvAlywTWmR+c0F4ZZ4TE
	Bqnp7zd+NCNy70FInPZHXzAWEQ+Jr9hOtltdQXlSzG/uoJjQnrbE98BwcW38E8sYS/jd242dhLQ
	r6yYp3x8ip47zJ6b0Uz5S2VlnrV60MpQYp36Yx90mCWBNYbHKmwGPfKK+awvi0206RohuZU5I07
	VNj0pn5rlRRlcCGzes8l9SZQj1Wko2s39O6oh0PxD+A0jVuFq4+GEedookEK1fgPaZjQQp5m3x4
	oXX/jYHj/Q8NhXBaRuUfXqsKWcLxYgR6s5FjJpEfcso
X-Received: by 2002:a17:90b:314e:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-39b261500fdmr6024537a91.4.1788511335746;
        Fri, 04 Sep 2026 01:42:15 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:15 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Subject: [PATCH v8 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Fri,  4 Sep 2026 16:41:40 +0800
Message-ID: <20260904084158.1341550-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
Changes since v7:
- Mention in kernel-doc that the function does not return ports that
  have no endpoints (Sakari)

Changes since v5:
- Dropped left-over declaration in header (Sashiko)

Changes since v4:
- Added flags parameter so users can specify whether incomplete ports
  are returned or not (Sashiko)

Changes since v2:
- Moved "Return:" kernel-doc section to the end. (Andy)

Changes since v1:
- New patch
---
 drivers/base/property.c  | 31 +++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b136c339ddae..68108805482d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1353,6 +1353,37 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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
+ * Does not return ports that have no endpoints.
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
index 907c790a3f01..3dbbd01a52d0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -507,6 +507,8 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
+						  unsigned long flags);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.979.g7e5102b832-goog

