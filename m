Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A383D669B
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882650; cv=none; b=WpuSzM+ld2tWvZIYHSU1Ng0BuLRksRpg57TUOLrL/aLvWXP7Bi90BWKuojEh5uT9zuMU0Nonbe/UKholV15+KcOA5Z1SWK66iG0vreyVQBHCiDDs4uVSAEoS/A5w2Tx36bT/3ub+o8NUkcT4RzJLZO1ndSNX3qlSyqKR6N3LW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882650; c=relaxed/simple;
	bh=rN8bGYfPxlquy6cQeK5GYz3ym6oKo/FOx8yU0FBCzV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxtESSO/fzVVOeAAhOlz5DwDuDLiQ8Qpmy5apD/Iy7dxwNf11g0tlXHEIMA7hYRuQRGqvLEuZUIY5+JCoRzIjuSv79w5jebCJjCmJh0RS96EgZq2BR/Coa76LkuX88Dhxs8oV783fSZ171N+z5W+hxErQHbytT7GTdFhJ76XZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hXHF/C1i; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hXHF/C1i"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so151217a91.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882648; x=1785487448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZPli2S6cZzTtPxNu5kCcB+M+KQUeHMnkMABY4ADLcw=;
        b=hXHF/C1iFP+DzsSdCDcke6XtH45FLhGqmJxDPybdM0yRDfbEOsigMesemAKruvD4Y8
         NbDh11LPukF6dWMm7h1fXmBA0NG/a1omudCKRimwAt1eEDIbJOsSpEpmA3rT6daaP64i
         UjNN8IydQz2sdOKPDz7dzSTe9VAUG76EmTXk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882648; x=1785487448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZPli2S6cZzTtPxNu5kCcB+M+KQUeHMnkMABY4ADLcw=;
        b=h+CJcyXomOPTMRefPl2gZdaRSUBnkfZsX1tIQnDbfoKvVRLmpjuWZ0MsWO0ASTm/zh
         F0XKHXLTErz6LOeFOlZKYXFXykumDuNiKzexj4uzGsx4Fp24+s46E7u3a6yIj0GlNyWh
         cMkCT2e6V6/gyblsDutd9ZYVl2Sdb32+Ig/Pgd5BYPLdnbpQuFqVGyBle46k63RH1rrH
         Dwp29zPJN/+VwjTZr5gQq1TZ7/Ms3GLx2DYfCRFiBHZc6Uv5oMxO5FzlPj3aKqsdVADl
         DCpYLcoG3iUWzOk1VThh7DCIAYzrkKH6tvDPTixmJ+8s5h/A4mUFy6n9IwvFN7L7IpSd
         HhLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkMFH5HUl8xwAWEkVIm8v1En3rpf9fjZUV8Cyy7/3GBqKz/s/d6uSoRKtGniG37rDWy3C7QHKpcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1XYYgr72vdxuadvRCMwRuRw1D3YXJ+ffv+mdpNDWguIR31ia
	dJYnPwgHeAUMxfxmyRhl3ueP1lpPuMP4CXyqTBq4kSYp7x/LE0NeuV2jdWIYm5wfcQ==
X-Gm-Gg: AR+sD11yQ/j3ZDyEZ2q+4k28RvHbAV4TPOORonJpfnijOxMMYBN3E0kaxkyX7gyuF6G
	ECTdWc82p/7Mvztr4efLFmydieSU2bvpy7kRJmevTKXBM6yi7w0TYszwXNDH3Kkbime3i1hVWha
	vCEIepa9xLGWubbxyzqdAmwPRoWv+vLNxzi587hFFe1grwXwbimbhPg4eJ7XIWRqDBBrA6k8xae
	XwRfaQWg/h+zxSho4Gx06GJzfCPIVZXn25EKNCbQg1J6gTgY8hFoBUBLcNH8f+RWa7093F2mgRO
	9Z4JyMHmWJZZSdXg6KOe84QLIZ0s7+wbblyXUF/bYLQuzIHC3clFzbxbwJcF51ONoqLLCFaz/7f
	uK6TEX/SIrsZY2P7UY+d1zUgjLM6GLRv80KmN7LI2f5tG9GZhswrS9GJL8MedzfcSyq2Gx/inOs
	ot8U/4lS8pA3tyk38CTTbbnL7H4GpLIZajabsTdMUunY2T9MtkMIEP12sptuE=
X-Received: by 2002:a17:90b:2750:b0:381:5ab5:b667 with SMTP id 98e67ed59e1d1-38ec6637d1amr6238598a91.31.1784882648264;
        Fri, 24 Jul 2026 01:44:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:07 -0700 (PDT)
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
Subject: [PATCH v7 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Fri, 24 Jul 2026 16:43:10 +0800
Message-ID: <20260724084328.3943997-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
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
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 31 insertions(+)

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
index 14c304db4664..01ea010cb2f9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -505,6 +505,8 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
+						  unsigned long flags);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.229.g6434b31f56-goog

