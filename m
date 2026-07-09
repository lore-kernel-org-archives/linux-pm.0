Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12195406278
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591065; cv=none; b=nVtYC9zC//9deQ7Uqtep+XbJi2IZ4+G9ArhhLr1OAtK9gyur2Rsuwy6BpR8qjFEMFUQ6WN3f43A6a0E8LLt6aAAPFVrPGm/YZODg5Zn9YJFuD9UGqH09ynKvhAJm/AWGoYIsq/xzZQpdq29IYalOtCJMwfhS753nSFMVIw2aX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591065; c=relaxed/simple;
	bh=4DJIO6YuC356lqlH329zbmGaURuVWRrLiiMzUuEp/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swAXomxfp+UzlTgN0rXgnjmOB/6zYE4QGk3QTHWYlPJYsUHk+SszrDSNgg/+Cd7QSDfJS0OL5jrjxfNEQVsjOWFqxaXBP8MhRYzZwKrHhgSTjbNFbTBm+zz6bIlUeM5zqMN8zq/Xsz6YN+jy4f6JqHSICdbUKkTd2Tu3W9gPh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VpKb4dF2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VpKb4dF2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso8762825ad.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591063; x=1784195863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZ53TpctVBGf+9janmV3YEfLWaus5++lNyVuWbfltaU=;
        b=VpKb4dF2OYREU2Hx9QoLP97g5mKbnBggXT2OWukVfXdk1/SZvYRh5fLCxkYBgpBOyA
         RSuiEiLkXSoueOxR2U0Ggnq9VUVXc+icvoA+JP+oU+JFoXNpFXjSJyiKTaR73UfINlV0
         v1APqjhI5j94k6EjFZ4Na1CPy7LwtNEnH5FOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591063; x=1784195863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZ53TpctVBGf+9janmV3YEfLWaus5++lNyVuWbfltaU=;
        b=m0NrKOAOznysWnUziTF6+LLZbPj5f8HALbfrNx8fXrmKaenuPIiSM7V4UVqlLKN75M
         lEMrdjhYucin39lnuFxq80Oh0if7oqlRl0BdH2pam8YQ/GoBdpYw6tF+8+qF1md70vbN
         VOyiOjSN0J62z9hUSW/W/EsTHwP+aD8VXdHAYeNeEYC10Ixiz6FQDOUPRtG9/hzxNuHk
         c+Q0bMXTllBajW0FP5UseIJYkPUQ8VEsYfN9qZ4KEBt1bs5ldosj/ztt3Zq+qM98kM8Y
         UxQP3TUKT1T/ObinW9Flks0LJebDlVhjlp8wWrA2h1pDlG18dVrAtZOxKqr4ZJ8AVwMW
         oH8A==
X-Forwarded-Encrypted: i=1; AHgh+RpRz34/wn19/GEg0OKl4GZ4u5YRQQUkpIGrYSoD6XJP73k438erBJevTdRuikh2Iomk2ALwyrE15g==@vger.kernel.org
X-Gm-Message-State: AOJu0YymZBxWc9cNhktfUHsJs1qfekGFhVcv+M+tRi4jBaXohAfzI/he
	apZeCXsnGejl4mZA5iWLHTQZpFx7MP0/MWitvqf9rjbbuCZh9JwNI5rqSuIrYxBFaQ==
X-Gm-Gg: AfdE7cneHOcUbBVSUkF9ao0nOp0TKJzII+y6QJpmrxtd+t+i3+NuhHJxqVpmG6qMdXd
	4luW6MqDdvUz6MAc/RLsKJuYI9EhU650NSnaAEftZsNyLjllNKUsSoXzTQ0b+B9nNTtDBu2+UVx
	YcKhRRoZJSHh99K4D6Di9TpemGSd35jrzoLVczGDdyNZvVwAMGlyOT9PlDDRgp1GPgk3QRCAGuM
	545i6D8ALKHnbRK8iHx2KZcr72fEx4YrYCHI3IEs527Zj124p31CQB9yR/jRslHZvdPUuM+sda9
	Kxui6p+lEapp/z+LfX5RuWQiNj9nuGyU9+IwFF+kVUdjcq8wdl71gIQYUWhVOGRM9brVkpiFBQ0
	8I4wrK2pTsj9JkegNR20759swn6VukO7YMNrGWTchhGq0ERHFm34hmVlL7Zp7mXYVK6av4D3IP6
	NkcIcJ/y7dlL2MX3FxnpkcD0kK7oqxqjR3y60OsBdE57hXR32aYCMp2dUwJ4Js3udSqfTjEg==
X-Received: by 2002:a17:902:f68f:b0:2ca:c411:78a with SMTP id d9443c01a7336-2ccea371ddamr71754425ad.3.1783591063427;
        Thu, 09 Jul 2026 02:57:43 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:57:42 -0700 (PDT)
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
Cc: Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v4 01/14] device property: Add fwnode_graph_get_port_by_id()
Date: Thu,  9 Jul 2026 17:57:06 +0800
Message-ID: <20260709095726.704448-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
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
Changes since v2:
- Moved "Return:" kernel-doc section to the end. (Andy)

Changes since v1:
- New patch
---
 drivers/base/property.c  | 22 ++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9387bb83eb54..3e3e19ef66a9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1346,6 +1346,28 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
+/**
+ * fwnode_graph_get_port_by_id - get the port matching a given id
+ * @fwnode: parent fwnode_handle containing the graph
+ * @id: id of the port
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: A 'port' firmware node pointer with refcount incremented.
+ */
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id)
+{
+	struct fwnode_handle *ep;
+
+	ep = fwnode_graph_get_endpoint_by_id(fwnode, id, 0, FWNODE_GRAPH_ENDPOINT_NEXT);
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
index 14c304db4664..e04901c0bd8f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -505,6 +505,7 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.795.g602f6c329a-goog

