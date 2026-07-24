Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293243515F9
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882656; cv=none; b=t6hqjfoDHU/ip7RqbEft/P/FSSvk9MMFzBRews3iIP4PkMq0i8roLqFIvApuC2ZmIIVg0WI6e87nDZudrp5AaAcmFa39XaO27Ynv9LXLw6u/SY87uKy68z1+7Go/UVOmCEdqlMzlKzgl4144X870xfvZvxwTdkHi5d2vSO35nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882656; c=relaxed/simple;
	bh=K/CXr8sGOQIlsbuegDLGNruY8OXemH3+DJMD2gXrC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mkn9NtPT4BBL83rRAbIbUau8yLBQCwYjrPFCjo1N0MzduTeZAE22PW7UsJoNYv7IzTfASep2AUxMZigLk7oSK3I7+KQWNNosztSgPLNJJvJexlbV9GQ6YvZFZAu2XC4aarAKn8beodQhbFnJ1dcXsq+/QjBC8Ng7XS4/M4wEoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xic4eBlT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xic4eBlT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso132730a91.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882653; x=1785487453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=Xic4eBlT78W9I04d2CEONJApzA+CYXES3lepeP+ZemSqti47+9bORS/wJVBIutncD9
         shFhpqdmTpSxbycJeuzPOoeZGONL2/yQ1OSDHusiQ4vE8CqOCrVEShWTbECN9PVs/tjW
         yYkQAWsDBEhEKHP5B9XEqRlxQddDxY3yI8iuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882653; x=1785487453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=gvdGgDpgRJcVMr3//3GVGAvkzBrFvJFBYYreaXRR7VQngFY/mU7Bw9RTKU8LVmi7GB
         o1qcHBD2M4gnVGsSd35faPNsXEqyGIJvw7/3ZXn6IzaCX55P8AW7jgy6z2iuhODiab1B
         HYqTUs/X1gztLjp1CcDvKd398NSPQRtCHuZR55AkwxxrbTQyy7+nUkS6xQ+foP5Fn5TQ
         UOQybe8Mh4s0FqxQYl7I/mj3pZkeGatSo3ydxjJYuw7M+UnSjmnKnPPExG2W6NZiM6Sd
         uItZRnEk6GEuf3mJexcjNxBlm00bw8mD1Ntr6HKKM9gu9HAdIrSH8WeEXucp+AgCygPA
         Rp7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq2tg1TGHCKIBmjMEgOy8zHkSXK9E2dQnJEXJRmvXa87WE9tFE1Z/LX4mVAYixDtd+7fASPjo955g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/d+z7c8Tw0+0o1tkrvNVbEZxnupNbapYRnQ2nKEkQ1F8Q1OE2
	MRrCic/s5yPewswomTdpW+RpsTynyJfPLhMMhtd6Gk3M3B2mY3X8FN5YqxeCUQ2ntA==
X-Gm-Gg: AR+sD132+Q6CPLO7uM4RALL6uPDyfKQ/PRfZLrxnUV2edh6fY3rJ42eIZq1v2asDUe9
	yMiyEPpfwG2fLdRFaO8k7JlaetJf/HiznKSDaLM1YDAyRnsPzlWYjjMelMdrQzirLIYObsuHIK7
	D37b2pVGRp2P/f3Hob5hmn3/B21FK0MaNJhXkW3JBcI1oCxxuMkP/eNwzxFVduuOAiq4ofxekuh
	0ZSQAbpt/rV6hLv/Nq4cj/rs89CcGCmB/i78JyOfAnc0ezac3P5l/2f0eLsT7ItmynXpYkrYIuH
	tCMMy8whZstRor5EiDYVe/d/6AfjJByBYrbI1sk4MjpNM62zD9koEPbcoGX033hGftpOnoSQKdx
	WyxYbx0zfTzPyXjkCZSZqPS4Tc0cmkmpLWNMdjYunoIXtXNQNn20tJfHjbd7JlgzpkclXIHvmPi
	i82b4VGGX4JM9NY6RdpwLh9gomAf1NuI7v/+dmeQAtrhfq7VH+H7QVJnPQJlk=
X-Received: by 2002:a17:90b:56cf:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-38ec6610d34mr6642066a91.23.1784882653597;
        Fri, 24 Jul 2026 01:44:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:12 -0700 (PDT)
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
Subject: [PATCH v7 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
Date: Fri, 24 Jul 2026 16:43:11 +0800
Message-ID: <20260724084328.3943997-3-wenst@chromium.org>
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

