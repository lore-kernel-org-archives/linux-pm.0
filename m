Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804263;
	b=OsMIOTnL9NpKxZhVamPbi0j7qKMfNW7YKgR87eYln7/8EhQfnS66W3WKyBFztdHa81Ql
	 mu87yuIA2JDBQMGh/+NUXOdAZJB2pawYboLMz7B8DJO9KrSmzC3397p4Ih6bYHtj+JFCS
	 fAYibTOrcEqnONx+TZ7QbU0x4vkazfqfXPuEHrLQztdu7FVZ3ONz/2dUDZAijr/UDNqOp
	 QSWmK9xjgelt42TcUCE0W6eeA/flc8zmwOjXC/QRaSZk0/KVFytghTfzV2YQrx/LKRqtD
	 qlgi9FdyTHdIUsynwx6faBdYaSZjq66esuj2wJTOEg8awgD304g3T6IzvwzsoW+YylA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804263;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NVAsAR5zG4xnELhxbpW9Ha7FNFWibj9egzi66nB2Mtw=;
	b=IIuDsCRh/wNkRcL+VyBTvj0hO9uha3Y6ljJdTNzNigO0kH8ENECV/edDT7bR8284XUwV
	 tkCFyeGvoszV1v5MwGAxXICOwXfSNKnMPhmJm0iqTlIjAXRJHPV5HaB1wsLS+axfrnDAO
	 6z+NSIZj9r+wNPODzZPnXLeCICF25rQk6V1KKA1sFL5oQ+rpTBJ3XCG5Hr6hVnwMS7TKR
	 CexoE8LUrWdI2+pTFLE+lDfgdIChMW9L/8HvOklZiUQxhozzXnlzImWPkMC5lVq/BxyAc
	 80ks1qWbrWsy6aQDEO9uus421KOFTr4JH3vgvl2hFbPdrTBEAqH0AALUuHyUksoHf3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5B606A328
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 14:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C5B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490f38e9688so47424f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 06:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804262; x=1794409062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVAsAR5zG4xnELhxbpW9Ha7FNFWibj9egzi66nB2Mtw=;
        b=c86MgUCf1dGmLI7EpJ6qYMeNOcuurGPpwgUzpaGYe2FGg9u2jEzBlUh6nL3xj2eF7u
         KFdxo8ECHGk42FD1SINvZA9I4EAAbc+8wmcLT/LiwAIFBpN6YYhe2EXDMbqH5o9oBIgR
         QNJ1Z2G6STcN8URcuvTacWVOcaX9MYIQOQJAEMWZj88OOnHgxg5NHdE3DHjgjg8CrjmG
         eTicSPV7mKFdAz+QaQAcCvlWmnhGn5VAPQbaVqB4rzYNG7JK76erFYKgtoCWvVqW8Xih
         a5UhhpYA0JH/nVxx3u3hoFXF1vBoSXc7x3tBsPjj1mpU8UX966pkcS4NB1X3dfxSVe8q
         0chQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2goV2A6cQKh+i0puBEnZvPrjbW3+PE2XcVfWLBJiNmh15R7WzKyVO+H+86j8TT/W5i4TU5FYTGA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VpESsT+zD66GNlmnW8Y+eAuJANZT/fgb9EJMtWWgPAgolvzvJ
	APTjIAh78UTWz2ZR5VcuJV6FeSHhq4j1FNKCC8ZGHPu5F7+PGnMlV0L3JuMhVYuq3aY=
X-Gm-Gg: AYBFou1LO8Gkiju0RFapCupm/GpjLpIpEpHI9VkCqTzViZ2Xeq7mvUoNQfqK2HI8WkZ
	mqUJZ9pw93JXqMT1FB9GSFOfKmL8C7VWez1zD2gQucmMyRvDjZarbnWo2Zb2KWj6tUm4h81DWxi
	fluNPYbLU1wwplAmwQ1tNCs+1r+2m+auD0zUqrzi3n+JrLSAlLQX2TLyBvp7UaT+XTMDHkxGzhS
	efd/aEX/xCumCdreUtd8DfH8Marzz6EoeLlEP3pbLj7cXHJsd2i/eyg3ampwfk2lpjLh9mC9/T4
	OoBvPUqIyVkVGz321TYeu76gVwoSPtI4lQEU4Zb04qse2T5LQfYDxeH/E+fnIyFpJd26qOQW9jz
	sEsVSAi6cyqlHjTXnqV0gdc0TdxRmOwI+eMv/SXKADW51w/zxoyyzV8e8rtTS2ZO9G4+GZTX7jQ
	G2JdLmlkRkJmkiDdKdaVwY2XWXxNCgdGXWRTVHvNzojxlbajCzjgp7W6j06cflpI3us+xlIxJKg
	GpVa2T02pokushElQufCyK2pvePHexHqtHLQ3ZReUO0dzjrsAHIgB/oE5GojfprVfwWulvO0Fx/
	ZD9+7niarpxDxZeLbqRvMXIPdQ==
X-Received: by 2002:a05:6000:4010:b0:48e:55bd:9cdf with SMTP id ffacd0b85a97d-48e6e2dd3a4mr40175116f8f.21.1793804261780;
        Wed, 04 Nov 2026 06:57:41 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecf8ef85sm4830051f8f.27.2026.11.04.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:57:41 -0800 (PST)
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
Subject: [PATCH 0/2] thermal/drivers/qcom/tsens: Drop __init from the ->init callbacks
Date: Wed,  4 Nov 2026 15:57:38 +0100
Message-ID: <20261104145740.2623473-1-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
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

Every function that tsens_probe() calls through priv->ops->init() is
marked __init, so a probe after free_initmem() jumps into freed memory.
On IPQ8064 with CONFIG_IPQ_LCC_806X disabled, fw_devlink defers the
probe of gcc and its tsens child until the deferred probe timeout,
which expires after init memory is freed.  On an Aruba AP-325 the probe
then crashes in init_common().  With CONFIG_QCOM_TSENS=m the driver has
the same problem once the module's init function has returned.

Patch 1 drops __init from init_common() in a one-line change that
applies to every stable tree.  Patch 2 drops it from the eight per-SoC
callbacks.

Patch 1 was tested on an Aruba AP-325 on a v7.2-rc7 based tree.

Not tested:
- Patch 2 on hardware.  None of msm8226, msm8909, msm8939, msm8952,
  msm8956, mdm9607, ipq5018, ipq5332 or ipq5424 was available, so patch
  2 is only compile-tested.
- CONFIG_QCOM_TSENS=m on hardware.

Christian Schmidbauer (2):
  thermal/drivers/qcom/tsens: Drop __init from init_common()
  thermal/drivers/qcom/tsens: Drop __init from the per-SoC ->init
    callbacks

 drivers/thermal/qcom/tsens-v0_1.c | 9 +++++----
 drivers/thermal/qcom/tsens-v1.c   | 7 ++++---
 drivers/thermal/qcom/tsens-v2.c   | 2 +-
 drivers/thermal/qcom/tsens.c      | 2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)


base-commit: 2dc1f296b5754dd2441fc8b6613a362a47f6b98f
-- 
2.54.0

