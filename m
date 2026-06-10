Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8D3B14D0
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080886; cv=none; b=cgjUYcFhLFilPVAhaCL/YjUZhmEiaVT/Ggov5bow6NpOmmxcJfTNhFNwJZCkRUddU5vuUZCSoNAoPbs0/RqxUKMZrdq8JOS8XdjH9HoYLL5+IPR/d2bfd5OqnWdtXtuMjj7qj8i770rE3DsDChLNvLvoEnIcZobIkTsF3yhSD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080886; c=relaxed/simple;
	bh=DzZj1fIJIKJKGnQbn8uPuOz0dFp4PhGSgOkWpDGy4sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwAmKzV6DZUY7h85bXPpHXForF0k78/wLTeT+xxB8Q+VxGMDW9LCPGbok6KKuXHKyXzPfHeK6TywcJXsjKSYdl4BAw5d2oerBbsDdgjNjDda2aB7FqdvarJ0PqA7fAq1kYehveuiNwKFAr03ms+KSQMmDXHEwfY9WlzNKOtCKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lSS5MGF/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lSS5MGF/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2247e38eso67366355ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080883; x=1781685683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRsKkRuXXrcRjbvRngvMO9bdz13WA7D5wKB/6fXyEG0=;
        b=lSS5MGF/yeef+r+Jc1KoAYuYYIrl5M7mG84EXuWybuu36dzej+lYnrc+Dn/WXSyzfM
         0K/uYQbMwKFYPFQV7Zkrs6agmfzcKI0fgNT5lVOwVwiznAbXbfczUcuzRX/TM5LoneHt
         vl5eQoNQCDq5JWIFYbpb2fogm/9j7l394sY/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080883; x=1781685683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRsKkRuXXrcRjbvRngvMO9bdz13WA7D5wKB/6fXyEG0=;
        b=plBsz61yIDZLXoNKs5SAVID3rIcvSI1PmSCy7xtqT3ay75CfnqROHccPKGVFQIy6K6
         FajDKr+xYOADqnNBuN6Txhgdj0eBCETg+30cAMT+SrBINJeDeK1QJPkjUDgYiAbCJ67J
         Av5pdCOexiLYutBCjrjsNCRyJfPwWwA/2Ygx0MPIN1EZ6PxWvFTKVbIbhU1XZNTuA8WR
         R3SxFtH/wa0SeYV4z9iwBeG28Yd4xObpFrsDoU5Xv3EtaRUwlLR5LCI4sVDx2LfRh8Qd
         cMPWeUiEj+MyaxoauIZmR7EJiK95wDARWrhCOMY1I8xhkf/6fYV6HgodUlyEdsdi6kOo
         Px7g==
X-Forwarded-Encrypted: i=1; AFNElJ+ZwjKczux8v8jEMaeu/aeoaPcXLDSp1VVl9Z3p7QQjGcp2GJKKgXGMaveC4roI1NQYgi51P60PsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaIxZyLjWlieriUtT6fG3xYhWAysdbj1tzsGT64+LvRxl9Xa9
	droW63jsf38AuZJMWs7bJcev0YivFe/5mscRdDLxQUah9vI5hRiGLA7ptj+OMbSrFg==
X-Gm-Gg: Acq92OEE73wVYJFw+2Ti6SI3w487d9VY9oLe9NrYiYElP/KBtPZRUcTeUcpYvfTtP1F
	0KF5hgKUfiUSn7IiqHIWegknx7IglyzfV/daTmXD3LjcrrHYrUASUG1rX6qgiWxCQVPMVfIimNy
	1fDzaAO2oc1TNZoASl4vBcEFZTuyifOVGFx2u1xcy9BcP8fTOwcl/TabAwt2/wB9nOIA7Xc/yEr
	tHvaXqE/Q+st9dnM6hRb4KLFF3QbMKC/ieHM+pWVVHfvxhnJkcgaCvG/FPoM/xda8hUKotYsEiS
	3Piza7cd5puZJ6QVuQ+3F+mnjufQgFA2sw5WWFLTjVbt/IrYfkcM2Sc9ahUJJwI/PaiCAHkvVKx
	pG7px1fX0DjzOQqOqE6d/oM2cs1RCZKZJFCIbFQcDa5HmqPGNxZ6bXqSQjZv262yLBL5Zkhe1F+
	qxHB1VynMq/pEpjGZrayQWp61UYdqxpj0551bQydAQTYcZzx8RzLzoHCEUBidHXlT8nFY4Amw98
	o4aQ2UgCXgKdUDpEg==
X-Received: by 2002:a17:903:3b8b:b0:2bf:114b:924 with SMTP id d9443c01a7336-2c1e85ca6b6mr285765545ad.34.1781080883374;
        Wed, 10 Jun 2026 01:41:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:23 -0700 (PDT)
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
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Wed, 10 Jun 2026 16:40:35 +0800
Message-ID: <20260610084053.2059858-2-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/base/property.c  | 22 ++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9387bb83eb54..a2afd854a604 100644
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
+ * Return: A 'port' firmware node pointer with refcount incremented.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
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
index e30ef23a9af3..11f3b54c7de0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -499,6 +499,7 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.54.0.1099.g489fc7bff1-goog

