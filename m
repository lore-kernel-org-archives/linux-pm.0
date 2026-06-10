Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE03B4E8A
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080894; cv=none; b=nYHM0xkMQJEcfREh+GGTm3AnAiSpa73MZyG975zy7WN+hIWy6exwRB48SHXaFXET8fBT8iXMsy0GfddJ1K4tA3SAaB6SQe3Tcv6C7wbBqPOMsqABCgZzXjDQiRIT9ktX4MzjTORF+m/2DFEoGtNB1Ri0Y2+fafygUdFFYQmn+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080894; c=relaxed/simple;
	bh=sAi0MURaPjHAXe7GjHIr2vzfcZt5+QnjAoJMj8LuBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpfwtCjm2xE02V2OTI6U+vns0ZgvmgIZvSSBXnZnsme5GFi4JGtkv1H09xreC8IzjNNOXpr4vaKmEOMKmeOEruExgo00vbz9f392TWkoPRspAzH7tdETM1JKLOILIrf9fK3CgHu7TcL4JuwcNXDN53rPcmUov6PZh7r0UlflvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WUVjfzI8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUVjfzI8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf36a6905cso46294645ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080892; x=1781685692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDEOB4zDGGA532YGopw6vfAouEtuG7p7cdbO9K1VfZ0=;
        b=WUVjfzI82etRAabNHQ6HbAxofP3BN440TN41o5OswepdmNA8IVuahtLZUskHeFe+o/
         axAbywQs3Mf+ku4DOxzed2TnCrSoOZY5yy8S2xiVd0LtTfG70YB5KO73ZwqsVA6qC+h+
         YP/HsFEWVAeCYU/AfFm+fdP4tOJSRyX/fjSUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080892; x=1781685692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDEOB4zDGGA532YGopw6vfAouEtuG7p7cdbO9K1VfZ0=;
        b=JSgIMmVw9shzNSskED4oBxK+aBMIM0nZZ3TNj8BYUr+VR43BL2ToofEx5TBLppR9JT
         Ui/6YfJhsYFotzk13JUlXpIxM8/Rx+x9O3qO3TS/waLSBA+putE9PnPaTCDixXeGuFzA
         0ecxV1frtry6DXAPP6FSwT8jJ0hpPh84l6gplJs1iFFPrYe3aIfugG4jCQSUEF7mBh01
         vIr44dw/eknBqjHIGKm/uDa0j01qI4P67P1L0OCxCdfm0znyISahBwlSReaktb8gKpPz
         r4IE8W+gscsaMaQkSe8H9KvfQfETRgSseVja49LlfK7pPVTYTjgzNXnH7PXkAwj1g7KP
         ZSUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8MxoNd8CE950DekkWkSDsALyqeMrXfS3rq1e6fjv5bkQHmiZuVMrRlkuabqqIoLsdLu1yw5MOeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMDLwJmYXCkd/KQmH329uN8eL/bEZayb67YEgm9jLtGrGuUlx
	8cTFlwyyP+E5hVM5YMEXCrb5ck8B28DPBhuxdfLAr2ob+9FpJ8K7W/INhTNm37sM5g==
X-Gm-Gg: Acq92OERzR7n+uny1tW4DjYE7CMl/IWVa9W5AwUhSuqvXStR/oFqsTayQurb5B8VEuy
	IqsQacrXN3RiYjVzmphsWc84qc5IsgcFSgfRcbauSz3wcHqompTC0HHM1C4lkDzhkutDd4Bfyst
	GhKd5X9EZketlmJq7wAfL2xHP29xjY4yJHc7oJO5xhrve8nnfVc/mEBiy/OzO/fIU2uSne5GRUe
	RB19SM19O2p9iVd7DPvWzhN5Q25gMNl6yShD3u28SXkTu9FjUAaZub6kOpnwl0meDv5K19+OsxB
	nQ5HMeEKHp/LsZkKWxWlo7FFb+pQZMrcg1fLDpfQCX0UqqigVhX7ig0dJQWxsm3saiBr9YZ5f98
	NM5H+H2hKQlJ0HcJfwNN/Atcb/J4R3ud0jztZZ9xJ2vDvzE5PJ10FVEj8vy/HLuicneLz91uBfK
	6ULJFXm2ZwiQJs7giH+bG8SX4T8jM4vmEpC8D+CIOiJba1mK6H6ZiZvK9Ycj/aBwfQ0cYjqhj8o
	mU5HdK/PqtNI07TJg==
X-Received: by 2002:a17:902:e74a:b0:2c1:8fea:4dbf with SMTP id d9443c01a7336-2c2a1bafeb4mr79293415ad.8.1781080892355;
        Wed, 10 Jun 2026 01:41:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:31 -0700 (PDT)
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
Subject: [PATCH v2 03/16] power: sequencing: Change CONFIG_POWER_SEQUENCING to bool
Date: Wed, 10 Jun 2026 16:40:37 +0800
Message-ID: <20260610084053.2059858-4-wenst@chromium.org>
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

USB support, including the core and hub driver, is bool, no modules. To
be able to use the power sequencing API in the USB core, the former must
also be bool to avoid the latter being built as a module.

Change CONFIG_POWER_SEQUENCING to bool.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1c5f5820f5b7..27448fba9dc5 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig POWER_SEQUENCING
-	tristate "Power Sequencing support"
+	bool "Power Sequencing support"
 	help
 	  Say Y here to enable the Power Sequencing subsystem.
 
-- 
2.54.0.1099.g489fc7bff1-goog

