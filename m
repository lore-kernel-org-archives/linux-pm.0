Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA53BB12D
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080902; cv=none; b=uEqmWcbuZ5OgoVQ67Z26rPp2kbEOdWMR4wZV5ZOzYW9FPEvVRoOqVhS8aam4bZCVQmQk+j3fMOdLULzqpEcQSIsCT+cUkLCW0kNr0FyNwx6ZwGTVG9nRM40GuYkaeOEwasOWxqjmxmkpDgunmFW4udz72k7p7jTC6OULZttM0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080902; c=relaxed/simple;
	bh=R0+Z0BHMYu5U4Yu7kD4UWXq+2W/gGTv98A8HYveuJQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKZ57LwSroUadJ1mG+woeI+PNLF0aFz5jzicF6rdTmDTxYBbTNn8Q9BZDEpZ1jq27xoTzF2U3z+51NSA40qKv2TLwHc+OUjr1+tCsTxZjlpq2zbpUj2pHX/QVYM3CwVqSfkSb42gKLkSIER1OIR+OGELZR4fHsWNxOZl4AKmXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JdLVyMAl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JdLVyMAl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso62698855ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080901; x=1781685701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTomCA2OQTIcAcWrVI1pDKUJSWSpTuGc9xeNsAJVzUg=;
        b=JdLVyMAlePWYtAxi75yrYHjcBr7CvOeRurE6HQUnMcRhS8UHz39OpP7Y1/KqNYZ0eg
         RtsVZhfCveetdt872SVd/CBQpeKjt3/3R8w3aH/P9iORfAKXhu1I8J7GdMk14LJBRPn6
         eZL469YAH3n7fwc4egkD0faL7QMz+9tawR0eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080901; x=1781685701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTomCA2OQTIcAcWrVI1pDKUJSWSpTuGc9xeNsAJVzUg=;
        b=poFHz6h2hQWGH1PHyHuJEai7RQLAT7Y9m/aXmwoz7EbxVxCQwEMH4n3fa5CKxzeAD1
         +AoDFz17/NonkQQBoqMMk3SG9YthY49Tc+TZOUnUJmvKPlwgF+NJaXKYc6bRn92+c3eW
         pD3QBfi4bZAeHgW2cA7MKa0WD9n24C+j4lNmTQ/d7OojDn3EOz6YhCBNUYH8Jfzfumn2
         LdE+dhnq6FXU7M4q6dKqGhU9VS4yW1XAxp+mt3TnUU9Si7m1K7CNrDxaTPQAF7X8FxH/
         WrQmZt1/CBj49clsGZJsfhst4JAWvYrjs5vTPTBDrJL8OYQQs2WwabzE/vkAF2Hr5DEJ
         8YaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Zr1AucM8K1RXRp6JIXKNhMKCP8r4yZcU+gxwl4F876iShdZS/E7BVXa/M1u/L8fQoE1KPek27mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5ncRUwK/zfEw9toG7w1+aH9DsKopPfjoU6jYWhVg3fvKAywM
	vX2yu+FJhKcAsG+yqmuu5+9Z8lEf93IqzBPSFZ8QvwD1HTuWxBk4feY7AFWRULuSRw==
X-Gm-Gg: Acq92OEEuWdDl6n5gejpmfaPPllrz6N7jr5LM9OYA0B3xcJL+q0eYF+w64j8EXKIwrm
	dMPu6YFIwDBhJdBHjgkG8jUmGBxapJpuXMvjw1FDa5dzQ1VTsSdTjUNnPFJh+65JcPnk7UDzeq4
	VtQ8Q945sMOiAdL4Rdmb3jKGC/LWmg4mBxY25ujlKpyNw8e0wEcSeFNFvJpmok0QIjpGXFhIkmR
	tFB2mb96xkrpZlymYJmysA68++zoGzwHdPo8EaFzHommH3KaqWyYPAIb92uT8lZMxbvzA8rAwKc
	2WOuHI0eUfrPL0QEZFUtZIbSiw11hBZqw4q4JlFUInWWHCBLY9JcEqxNqgYdVgz2VNE2H+Rk0gv
	OmVJKw27unJf2z8rRuytZt2dlsycYCsP0p47cXiswkgp/cDdAik9Ffdnz75UGJp+16Jkdv0Sip7
	6ngbrL2V/faZp2bH4AYr2TaJX8zeAgRm+XnetHn+aHDD1xXpJ9y50wDPBYmVI0ky2JbvOHoJkGU
	TzKxLc0JIeEabj2mQ==
X-Received: by 2002:a17:903:46cf:b0:2c0:d91d:c3e8 with SMTP id d9443c01a7336-2c1e80cd78emr274569985ad.4.1781080901116;
        Wed, 10 Jun 2026 01:41:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:40 -0700 (PDT)
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
Subject: [PATCH v2 05/16] usb: hub: Associate port@ fwnode with USB port device
Date: Wed, 10 Jun 2026 16:40:39 +0800
Message-ID: <20260610084053.2059858-6-wenst@chromium.org>
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

When a USB hub port is connected to a connector in a firmware node
graph, the port itself has a node in the graph.

Associate the port's firmware node with the USB port's device,
usb_port::dev. This is used in later changes for the M.2 slot power
sequencing provider to match against the requesting port.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/usb/core/port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b1364f0c384c..1846eb1206a4 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -780,6 +780,8 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	port_dev->dev.driver = &usb_port_driver;
 	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
 			port1);
+	device_set_node(&port_dev->dev,
+			fwnode_graph_get_port_by_id(dev_fwnode(&hdev->dev), port1));
 	mutex_init(&port_dev->status_lock);
 	retval = device_register(&port_dev->dev);
 	if (retval) {
-- 
2.54.0.1099.g489fc7bff1-goog

