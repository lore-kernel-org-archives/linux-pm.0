Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39742DA39
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616888; cv=none; b=a0wNbpDPpkh8FWP9Rb50wkcJ44Nr2YjKCqLdfJre+gVYRwGjFeWFjYwWSOhM7VEkz1IevGyoo5h7pUTnAjxffZWvBCpzdC2KJnxdUsYSDI0A3piQme0rRJul/zGJTP8uprAhu1pchaEaOl2rZEUNITtrWK4Jldzf/y1w+cmBMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616888; c=relaxed/simple;
	bh=K/CXr8sGOQIlsbuegDLGNruY8OXemH3+DJMD2gXrC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZLon0hiu+/IYbIfqFG/yaY0cSTo2J4ihVbIZUkfFqcj2pvIS9htydMpreKHeNTtTtwzVjO+ee1eRDy/jNtVIEjO9Bn+1Qdqd3bm2OHHb5ncQgbOFZXUBIInMlN0o1Qn+8uLCMOIDJE0ytE1+jvE7bR+c46/Op4sn99UPAMh9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIx/TyVR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIx/TyVR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso86495385ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616886; x=1785221686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=lIx/TyVRtZrlwFniXWRGEHfwmAduhmlywwFuRvNQ1TbhXzyFoyXkqLMDYTqhHuGNcT
         u9Wa4cW6aynB4+uk90JhRPtMdmZH3lAVQpA9hAyB4Yn/VK8bklOrkI6sYeIAMA0rZ4kz
         FGW9iNk4/Kkb3sU/nYnZtyDt3b9ruuG7Uguq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616886; x=1785221686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=Ic26ZqGz8NCcaes4uxQwma9LRI736ashzbgqfj5jW8PGu4MXliPe8Z6GRzJWHULcVo
         MJRJmjTRHWHB9cGIzBLOg7RFJ46qrX7mE+sY3IAB6iidN4ulxxnAeuznOqQkDIpkoLbx
         HOzQtWT51dq13R5Wud2hMPtNhx3egDGhxv0NsNjGj/Yl7OHx2BiTDK6XIbB4S58GPTS9
         jRYwOuPuN7x1pfD37sLhUaC4iVrbUG3r12qgamFWk1TASIoeckydZLBfdZ5jyL6cjnFl
         IuFjYVAAqdZf0B0bRIFCGboxoUAIew7LN3xiN+935A/eHB+zoC+j1hl/Sj0jzI1j2y1h
         Hcig==
X-Forwarded-Encrypted: i=1; AHgh+Rq7t/oCuO6QwfXwuTkiqo64CTIwe7AWF6HPbGLWa9E2k7grZgKsrdpdHIrwq32oUmH+wWo2vFeNVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxirzgFjP8uN3zJX7ebBWwHiAuen5u1ejjXnCjBmcOVmqiDb2hC
	7JMZdhxsmFnloqtYewEfYnXdy6kZV0fLBdYnMXR8pepKgpJUKlNWZMWF8N00tpxgMw==
X-Gm-Gg: AR+sD13pXEqdjHk+HjnCN0yzwvhTtqzVZxIDYhXHdDc1F//sj5eewiB3fzhzdnBiFoB
	wdDTBocsHo7gbzBhJrQqQmSjtJi7bsJpG/x3au3rFIz3uoBdhLcmLv72e266TFrbkcYEapgQwU2
	AwSm9Oy/3YPnPeM8DZassWRarufV9U5C/fOoj1OxGBeQiQkaBGstSey1bdEBv2UfBMuoTM+7Weq
	uziRuuF5PhPzKjRNqZT5/wkGsz/3H3220DNLKpjeHi9rpysTRMhCQCPlALKm9hxE9D/EV9jWxtT
	AdqxP6XxcjFPvoyfYC9ZF9O/z0zqfY3ZnKNEr0gPN1nkpZOxh1Oj1uuv0yAR45+wXBAEIAkiJwb
	TfqPklDPuCh/MuCw/66muz9FKNIdKrO9Gfjfvp5xzcLa2Ey3SdE9TC9ozmTBB1wzUoQQImN7a82
	tOmAZ03Mu9icmU1CqZtFjvT1OFfZOG8JLRTpfD2mdAk7YGcRf+qMiuGQyn2as=
X-Received: by 2002:a17:902:c412:b0:2cc:86a9:ebfb with SMTP id d9443c01a7336-2cf349b839amr193173875ad.33.1784616886249;
        Mon, 20 Jul 2026 23:54:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:54:45 -0700 (PDT)
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
Subject: [PATCH v6 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
Date: Tue, 21 Jul 2026 14:53:57 +0800
Message-ID: <20260721065413.2306137-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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

Sashiko points out that the |prev| reference put is not done if |port|
is NULL. However it seems that the fwnode_*() and of_*() API design
implicitly makes the functions no-ops if the passed in node is NULL.
So this new addition follows the same pattern.

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
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
 include/linux/property.h |  2 ++
 2 files changed, 27 insertions(+)

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
index 01ea010cb2f9..9a784a856773 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -507,6 +507,8 @@ void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
 struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
 						  unsigned long flags);
+struct fwnode_handle *fwnode_graph_get_next_port_endpoint(
+	const struct fwnode_handle *port, struct fwnode_handle *prev);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.229.g6434b31f56-goog

