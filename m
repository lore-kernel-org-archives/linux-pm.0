Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365863D9527
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105669; cv=none; b=JUUfyyEY4xRgUisceFSsFDFGpiH09jVaAapk0SMA57eK+C0QrMOmPBXmfZo7h+K2cI3Xc243DfF6ZkyCBe5MgSYrXE3hF3Sou3HVOOB3wLHIcMo7wEQL7bk2MJCadh2vrDs4shrfEmbu+oTVg1ZpvOzGDlXs338dasPgP3SB+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105669; c=relaxed/simple;
	bh=sqdob5TVS1N4bmSmguYYfBBqYJRqBaCnxbFmD0sCAjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubdrfF9G1dTfVxMnBbFoGcuxpDEPBy5ByO4GH4I+N59nMzmCcECGbnB/b0dwX2YAFMWTihu6+TH9gvm0NAOHfuLdL8zQW4NXFAWRbTb95OnWIopaqeEVmwLYpgaMt9lyhK84oQTkjfPc/IhyjLl0qzLGkXMRGyDseLZzOdLr324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F49u4kTA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F49u4kTA"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845c92bc464so1817387b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105666; x=1784710466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZ7tYQ51+XcWWhdGhKfBc+Z+vMHf2l2pRpxpCrkBTOs=;
        b=F49u4kTAOR0K7VBexydgAZXRUTsm+VJhRyAQqv+Ve/qdyP4gV6MoLTVLx4ZjL2uWhX
         cKN42UmTfQw0V6/saDUKC0qBMqh1v/l0wcQnTE6Mxkn8DOh0cdBRkRs6qY59HLxrOD7n
         LF/NITZHrx3sbvIplWvgVamTrnrmC/WxuUMTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105666; x=1784710466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZ7tYQ51+XcWWhdGhKfBc+Z+vMHf2l2pRpxpCrkBTOs=;
        b=ixiWNm+BM0zqhMXXj4A4QrXPfnSBlMDqjb9k56Ohwoi7rsebOmyAJ0PbrGxUoB6TNs
         0gn//C14vnWNw714xPjRc98/9dPgcVbaihQwcnbb28MOoN2PMW+HBgUvR5JSQ9CduKgK
         TCl9Ui8TCNG27BLZrUuHM8+rnisT/Ton6MYf/9mxsc3nWXzNHH+IFQMy3jtq97A/vWHz
         r86L/jKBaaGH/XbDOol1OXhd8XX40YK/MuPIzgjrVWIiDliEf/7y8SBi0+SwkGbgc1F7
         R+/8RX6u3FCVXTUSeUx9ixjWvM9+25W6DAXX2pVYZd9cVOA2A3giSm5YIAX2fTBj8k9q
         Nu9g==
X-Forwarded-Encrypted: i=1; AHgh+RrWGiUDnFAkfVxGBgC+R8mxCCFy3zf0vS6IS4UIRGFC+wrfimPRqfTdfpW3a6/YyjK0AcCNyFfdbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf5LuyTnffXV3whNUKT/Og44XyXGrPEywb6ehMkuTTZxEIlhN
	Kx5bdEQCVfvzQqS3ybswtvOZcCFUmKgH8zuOPi3rCkYGdKy8p0tKksCgwKL/OFGacg==
X-Gm-Gg: AfdE7cmSyrh5oUWCEP5NTa5rxXeaIZE0KuqDF3X3NqPt8YV7kKgNO/rgLMIhwn8S7nf
	ep/t4Naol6DxS06zAO98RITxVR4A84GowLFrxlUklZDMYbnu2z2umV7V/+OuGp6OGUxCsHa+QIX
	W3/4UXQPRMzdAWTzlhlufQg5j8JihzlWFb3J/EnAGsWfoh8bfOyx0oFSQ4z++e8vt1fSskB0vwZ
	zbd+yt3velQXUMwGTXE65lv7RnO+uoRQQywoUNtifpU3DW4XU3LU6wCWKtAwSbd4POI833K6IpN
	VCVLdUeQQ4xG9aTRUpOP2PkFh+Jpq5tJPeUSR/xK/vkaOmr39hve1FkKfRMWBiSPrU1Mlrtfu1o
	XQzkc4LZhiMsXkMoOmdQg9QCv7JblEQR+8YgOpgzBBV7B86aJSBISt3RBZco6vCNDUkTLkXCURV
	PEott2dimSrBd86J4bq9DM3LwqkgNP+BUQxtXGGHxW/nh0DNuJuh7TYDSpuGGdOSOjQE16Vg==
X-Received: by 2002:a05:6a00:228f:b0:848:2f74:1d65 with SMTP id d2e1a72fcca58-84889744e25mr15178478b3a.75.1784105666556;
        Wed, 15 Jul 2026 01:54:26 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:26 -0700 (PDT)
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
Subject: [PATCH v5 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
Date: Wed, 15 Jul 2026 16:53:32 +0800
Message-ID: <20260715085348.3457359-3-wenst@chromium.org>
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

Due to design constraints of the power sequencing API, the consumer
must first be sure that the other side is actually a provider, or it
will continually get -EPROBE_DEFER when requesting the power
sequencing descriptor.

In the upcoming USB power sequencing integration, the USB hub driver
first needs to check whether a graph connection exists, and whether
the other side of the connection is a supported connector type. The
USB port is tied to a "port" firmware node, and this new helper will
be used to get the endpoint under the known "port" firmware node.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Dropped unused |ep| variable
- Rewrote as do {} while()
- Dropped WARN() use
---
 drivers/base/property.c  | 25 +++++++++++++++++++++++++
 include/linux/property.h |  3 ++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 950defc0c55a..5d3993bd8fc4 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1099,6 +1099,31 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
 }
 EXPORT_SYMBOL(fwnode_irq_get_byname);
 
+/**
+ * fwnode_graph_get_next_port_endpoint - Get next endpoint firmware node in port
+ * @port: Pointer to the target port firmware node
+ * @prev: Previous endpoint node or %NULL to get the first
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @prev
+ * unconditionally.
+ *
+ * Return: an endpoint firmware node pointer or %NULL if no more endpoints
+ * are available.
+ */
+struct fwnode_handle *fwnode_graph_get_next_port_endpoint(const struct fwnode_handle *port,
+							  struct fwnode_handle *prev)
+{
+	do {
+		prev = fwnode_get_next_child_node(port, prev);
+		if (fwnode_name_eq(prev, "endpoint"))
+			break;
+	} while (prev);
+
+	return prev;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_next_port_endpoint);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 480ba8646bcc..9a784a856773 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -505,9 +505,10 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
-struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id);
 struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
 						  unsigned long flags);
+struct fwnode_handle *fwnode_graph_get_next_port_endpoint(
+	const struct fwnode_handle *port, struct fwnode_handle *prev);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.795.g602f6c329a-goog

