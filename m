Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804265;
	b=3S9WCwVR/gGg4ZrMytAa7nNpR3yks7bWeCTGEkt+DD8CsEbNmDIINpqI4zuwuOVGFb59
	 7lAZ5oVgEDVRIGcT2dvNRpE8b+RR/OL/+6aI3xHFglzHOuw9YP7Xu5VqajuUuUKPVeChn
	 GuFf1INTiFbSmEOWgd8OPAeE7iJMOgIlD8cccaCsH0i/zAPYzjFGqi2FpZiQ2DMSKA0hH
	 +cndwkjnHCVcd5RCAqW5heSIvAWQY0JpnlTc3jTW+/mmSAbCCBlV1Sz3b5n0+OLzTZbFd
	 TNrQYRqX6OTSMjimfI86afgedXJIejA7fFpzumhNK4GedVp95yvzDf8EXhymxmKIOaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804265;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KUz2D34UCSVw+yqhvoh+RPWtDjdbKvsiINtzwSInBU8=;
	b=Xs51AOW0RPVYGNGbZTfKcfvw4tMIVaswULlUl1ueNEVDYjh3glAGSmLq52371hyTMuzy
	 81M/R+RYX0C9Aykm6YJ3gghonUFyW4gDy1fyfwWYneyiaxTcXOQ5q0BxcLjfbpY14yDXp
	 jK91p918hRYLZZcrx2OxOoVfQLDcesliP1bvN+Moc/L6WWb4ZlDXJwpOVLqBcFoGF0ZFO
	 a+IwlJ8mPc3dRh4JTuqmfDaSS4zOSmkLhWWZeZ4R6X5Ei7udAWu7A5HE6BFg1uPogTgow
	 1kCjT6hAYivbP7P288bU2gWLc+ZENJYZAmslqOiNxD7DqshAItQIIRZz12ZNHUUsOWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75603606A326
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75603606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afbd2c386so581559f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 06:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804263; x=1794409063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUz2D34UCSVw+yqhvoh+RPWtDjdbKvsiINtzwSInBU8=;
        b=PVh99XltizoiISkN0xoF571am/MdPdGsIfz/ujNMMouukYox8pBb1FmhR5Uw58yhSn
         B8+MXFHxM2unVKpe1z/Hr2DJIqOveX4EXDwqXbu1jXnKdvbTOPxzWUF0gRytpBmP7wKd
         w3E20WcPPLtFZ8Pp8IgrnLR1ZPSXDfAEItACM5QdKm6dt8EG2n8d4Lz4Qth5stofLhgd
         CmENP91X3e9aCHO3ZEkSHVcbYnNmxXx4I/O6/KJ4nOP6kbEr5KiroSVYX+yxfXBeMGtd
         eaqq22L3nwZIw0i9QkLnHw/6lDwIXm2A+jMGN6ZM7JGiRUqrHevMjkai3OYfInhVDJ3a
         MGSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHvlwb4r5jZKXhP9PMBP63CtrsIKJooS4r52icdO6LT13SAKQh9Fu1QZBamlO05O7sQZc6pEDW5A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y7wZUl4iPcy0bycDVISQKeqFJWu7axjIx/QmyRzWbpUnBl7HQ
	r3Fz9kNWuutnv/hDBWfvO5rBziEHC86kAyxEHBhaugX1WINJMv6kK9vNAhAv/nksmCc=
X-Gm-Gg: AYBFou3fFi2xJxlwdtJLFSrYG6IL+8JSUMCRyg2Xqkrbi8Huj3cGiUg/FYD4G7bGJa4
	T2PhGvuPutF6xmlnQPhUxHt7zzBkjmsTlXvcJCKVjLkrXrLWdr11I8ZxjMisFkcM7v0O/Z1pnJu
	GvfUYPSCEjME8iq6R1sWmN/9RE+ShGQ7eD+TjLWm6FMUIQnUYfIgsRrm1vF80KwEN9ctSXvR8Rq
	QphAh08xfs+OF774CLLRAEXQOcggCLOfZ3/RhrJWi6tMxjfQyaL5/9P106aPW6J8Nly+XTPjFnE
	lwAGHOSC9EMUGXqquwBiJfq8cRoDDSY2U8L8+Al//WnbV7PaUON+diUfQELEDPbsPDBFXwSneJN
	E6Izi/rUPMz3WpKm4o/4RU7ERDS6m449HUH7fL8hyWU0NACRvkK6hFL6+v1GsOqaj2IxUr4fO9R
	4y1gvL854FsmPuR+A4YDY0W0iamxgNsHh7+9pg/qJ9xU4Hri81ReEuSA3x6S+TvgBuaRAJf9CUc
	n6bBPqgZNJEz+ERByZVvsZykYQ1+PgeGYYAEbdfMuPSJSCXD5k5vn9uepVN8EYClxD8EJoE9+gD
	JldfzMHsRRbVK+CSnmu2qXnmcwAehsSNEAZgGv1nE9CbdUo=
X-Received: by 2002:a05:6000:310f:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48e6e2c33admr32579809f8f.4.1793804262816;
        Wed, 04 Nov 2026 06:57:42 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecf8ef85sm4830051f8f.27.2026.11.04.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:57:42 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Schmidbauer <opensource@grische.xyz>
Subject: [PATCH 1/2] thermal/drivers/qcom/tsens: Drop __init from init_common()
Date: Wed,  4 Nov 2026 15:57:39 +0100
Message-ID: <20261104145740.2623473-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104145740.2623473-1-opensource@grische.xyz>
References: <20261104145740.2623473-1-opensource@grische.xyz>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tsens_ops instances store init_common() as their ->init
callback, which tsens_probe() calls through priv->ops->init().
init_common() is marked __init, but tsens_probe() is a normal platform
driver probe and can run after free_initmem().

This happens on IPQ8064 when CONFIG_IPQ_LCC_806X is disabled.  In
qcom-ipq8064.dtsi the tsens node is a child of gcc, which uses a clock
from the LCC.  Because no driver binds the LCC, fw_devlink defers the
probe of gcc until deferred_probe_timeout_work_func() runs.
deferred_probe_initcall() schedules that work to run
CONFIG_DRIVER_DEFERRED_PROBE_TIMEOUT seconds later, when kernel_init()
has already freed init memory.  On an Aruba AP-325 the probe then
crashes:

  Unable to handle kernel execution of memory at virtual address c0e1ffe0
  Workqueue: events_unbound deferred_probe_work_func
  PC is at init_common+0x0/0x540
  LR is at tsens_probe+0x138/0x4b4

With CONFIG_QCOM_TSENS=m the driver has the same problem, because the
module loader frees __init code once the module's init function returns
and a later bind then calls into freed memory.

Removing __init from init_common() covers the ops that store it
directly, but the per-SoC init functions that wrap it are also marked
__init and need the same change.

Tested on an Aruba AP-325.

Fixes: 9066073c6c27 ("thermal: qcom: tsens: Add a skeletal TSENS drivers")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4d7013fc79d6..710c78aff8bc 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -929,7 +929,7 @@ static const struct regmap_config tsens_srot_config = {
 	.reg_stride	= 4,
 };
 
-int __init init_common(struct tsens_priv *priv)
+int init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
-- 
2.54.0

