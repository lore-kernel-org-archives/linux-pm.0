Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE33B47DF
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080916; cv=none; b=rwMMSAPgciMf9b133LPgN1m88KCObxZ4kFuBxAclO8pd3lcFIGl1Trw4VAOaFwa6U6JOTJndFtvMLdPRzgiogTVZQq7kdbd8OmCfAZtzWIYfSvVH8InZ0Wx1wwpa0VQJ0Um038nnX3ucDg9tadJdKZIWwziTD+HPY8dn++uF/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080916; c=relaxed/simple;
	bh=Pm31+hL6qrgMtRuUHHiRRIlqVHF08y0dXaprDA+L5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JstpVGFqa0RmhmwZqhtSMJcH+I/JiquaH1HUm+ZhPX3KQbsyh2CNmH8KaLcIATjh6ZsEUMKzLEpbH4etB8p1OLPisZbuDphOD/F3XxyHNJ9BqkkQrbEfysIxKK80lBt0gcEddoDJVjIGPoH8/rES1gHGluJGbSK3lhIWpdShxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e0MJTeSt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0MJTeSt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso62700495ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080914; x=1781685714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnO3yRdxbnlh4RjwbvilfqRxY8jsmsz+8SVoyh3JZE0=;
        b=e0MJTeStxs1K2v8xXr5iAdoAKYw/aTID2+7aH4ULJdHr+jUKUekXK5kky8CbD6UHi0
         bMz0yD1cO2yESHa1YBfh3dgbhXbqMHo/2nXSoifuqWxOV2YF2eu/6o32l4RWcRMnMDGA
         eLyjaKLHw2StxBFiPS79XDLPHezB2oMVMK3Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080914; x=1781685714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnO3yRdxbnlh4RjwbvilfqRxY8jsmsz+8SVoyh3JZE0=;
        b=NEL9jOGEnFuurUzOMe+o7rZZgwyJCVMOMwCKuJYC7BslwV/6F8AlGRaVljVuxKmUls
         gPK9T4P+tcfL2UExFsLaZyoj8NJrgOopQifcR4yZzO1G5lqQSxrT8zZ3TCXcGwMD4bE0
         oh5zwLhR6ab1ybdzGTp6G5wN8/Ky8RD4v+dX3+wq7pSIb1R+VR4qiwtaz7Zt6PksRtb9
         +86rxPQtzEBOw6AeMZacp/T3fCHWaQjlXgt7HumVGp147na6Ow9BBgszmiBjJ7Te2Rxc
         04iTd98e7/mFrMeR4VZ4eZB+Tu9t6O3i0/UorRDMbkPzpWFUlW4YIGp6ePJ6LfaTk8Wa
         kOIA==
X-Forwarded-Encrypted: i=1; AFNElJ98mYBORbZGIXu/Nml8WAE7HCGFJmG8E6zeJV5+LJ/bOXXbvbkZk/+jCD2Gk6eOkn7aAv+qmI+4Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnHkldlzLNrjQDT7sFi589GuF2yqsRNEGGge3EOjaN1ujlWc7
	P9ehHRDHe9qjGlrsuRxrr5vtFhaocPyf04Ro4s6qjYiMg+ms41tL+0CX5zgjjI5jbA==
X-Gm-Gg: Acq92OF04A6Y2KHftLh60p5hECbQD4YllQ1w/d+AbcBzcOTGY7wGDjazr2PNbpl4FFi
	gppVYrqKncfuZCA3OPkM3jG3E7V+hsOvJMjybOnvxWibt5kzb4rLFNlIwFveKqDA5SlJ7ch9vWF
	U5Yq8uv1JA3+lHsunLokLP7xiKF1aJxvOFvPpbMKN7bKYMt/FC5qrlOe+CEDbcxipKIL6MzsZoR
	akQeUdF8a4N6ohJWOWKqzZemPIKAOTDzP75cQBCHFfqznUJhdcDSleOcqcD90xDPEY+mtRR6UfM
	74BE0n9aKNmMnBE+o+q0nzFxkJqTdzU5o4Q40zPjAGUwUPNBvZIjCTcTZxRw3dgxfVefcH1/lwr
	0Jt5qrLxFMNzYVYA0Y2XPlRuVTZ6WusM9FMjoaj1AJQPx4ldReLQ2oDx9UEAzLX+Fueg8hI1aFZ
	Q/JyQTCApA3njB7+qc1wGabm5mg+5hr2CdBeNjU8fZqBoMn/Ug3jjBFdZxwKv0sL+ve/793IOct
	62MAorw/sT4CucmQw==
X-Received: by 2002:a17:902:da8b:b0:2bf:2e06:2ebf with SMTP id d9443c01a7336-2c1e85ac571mr292987545ad.31.1781080914415;
        Wed, 10 Jun 2026 01:41:54 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:54 -0700 (PDT)
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
Subject: [PATCH v2 08/16] Revert "dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP"
Date: Wed, 10 Jun 2026 16:40:42 +0800
Message-ID: <20260610084053.2059858-9-wenst@chromium.org>
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

This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.

mtk-xhci handles both USB 2.0 High Speed (HS) and USB 3.x SuperSpeed
(SS) host connections. And there are USB 2.0 only mtk-xhci blocks.
The SSUSB controller handles the device or gadget mode. Saying that
SSUSB handles the HS portion is wrong.

Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 231e6f35a986..75ecce3bdc7a 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -107,10 +107,6 @@ properties:
       - description: USB3/SS(P) PHY
       - description: USB2/HS PHY
 
-  port:
-    $ref: /schemas/graph.yaml#/properties/port
-    description: Super Speed (SS) Output endpoint to a Type-C connector
-
   vusb33-supply:
     description: Regulator of USB AVDD3.3v
 
-- 
2.54.0.1099.g489fc7bff1-goog

