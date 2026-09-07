Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388B40DB40
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763663; cv=none; b=dosmTqvyDb7zYxse3tFjJGxxG3XnoGtjyRGvpVdezHb5LWlyU1OkJ+KaTav9ANNVjZUD59VEi3BGe2Y3kMsm7ErlSW44qjlloJmPGq15OS/uRUwBgp/Sv/Crkg69ksnC4XGYL2f1ze7loZUdTeLuylHLU4Kz/ZqA6TnmJNKj93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763663; c=relaxed/simple;
	bh=Q3bBIxz90yEEYsWH5ikWyXfUpYba5QGg5QwQbHT02IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbnme+JDCu1nTVwur2p35dKStOw0/GXIIMbZsGEiLXLRj3ziZsphzlnX+Xi6GnRlT6neOhJHaZnRSaOtb9POcfx/84gNtkD8tdjmDNAdsZo6skaHJk1BhhawZmXsQ/WA665mgo6/SYbDC/DhKX8/JgLputLB7zzfeKVcDleDBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAZsVs8m; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAZsVs8m"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso3418506a91.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763660; x=1789368460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rh6WnyF7wCSbyOvDJNwh7JY6+tMlKujEj6rsY7bD4mU=;
        b=KAZsVs8mh7GDKrQAO6O6sFD1lealyJfsfycKd4Cq8TDv5qJRo2Xv0wNqiSeksip3Jo
         bwaG3maYCK0tnc5KilVd1m53J6omDjYYFBn71RxoIQn2CjnFrZid49ZKQGlVORxQXQ4w
         3EuR+ppm5eOflUmC3jMnalDFXyARUu58qNYhC6WPGNF3VwWzx6L02Cx+4pq2qxgM6SbI
         GRZZgP026U+q7V9bSSs7Kb2SDFe+0hz87+JGgLz9N6gsHe4Cy7Xg9Uu/nYOxbahxER4q
         PD9R9MH5gP9ZU/kkKV1i5mf2HjR19R+PZXTecqVEkWMSuD7YDtCw/JMxaIZ3gYBTtH32
         0YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763660; x=1789368460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh6WnyF7wCSbyOvDJNwh7JY6+tMlKujEj6rsY7bD4mU=;
        b=EwE+LMxrI4RnF6YgPvfLtRM03PQIx9rR/kWn7BlT8qfHckXrhdmNPd8GV4pEk0Kwf9
         e7JWsXd01WC10UyF+8zcDGte+G5TlkoKQeAVatrNATzWJBuIKiKOdjLr2Mdj3T5651JW
         hzomiaN5lMv/YC5Njp81/1pNINzHPeR4HgrOIQyAjt2e0TDIynXzKNryw3vPPa0mhWWx
         JYa5PKyGsTSoxSTJ+FnY53wXw7Ease+LvOv15N6xzHapY2WlzFc9cbM5/Z0gLyel4aOH
         br718xKvNwENUg3Iaj2vxzEoFtUKU3Z3cSiPo+MVX2cR5Uxt3UTnQ0kZFFXfXCjXQqYH
         CjvA==
X-Gm-Message-State: AFuF++nnRz0ZoV6rorvZx+Ug+dekVAWRyIwa7t6oKm26mWhlDbRjHWx5
	11PWvruvOwfTntUslZBJbeeX9UsW/efShQ+pvE9mWSl69QvkCQEKb4II
X-Gm-Gg: AYBFou1T3tyYGjQQEbSlQ2UgkkkcSsB/vf32P+gJCE7G72no7xsEu0Uovg04ZI+EIWo
	ybdcNexrK81dxEwn1joDNfdt4y1iAnTo3F8tX+x7gRmdca2818QtAEYF4vznQYDb3ADwUtFw64x
	TZq0gL1ReURccFBHvK/eJ2Uyc7kKH40YOfPKoqRX3oCwHMMVilopRg2WT0QEi+kHizR7t9q4hAw
	s5C+OC4a1eMYC10qDlnRUDt7d+S0TmkE0MhaKV1axvbTvw/CsKHyhqI+1lpfXAR4nkU82y9aROl
	zMy4R+MNBeQFNhr52TXMrHRtkIlsPxEZSC3F4XdU4/B7tshxSQUpBnsaC9u5+cXsg03NLy9hWT+
	n1In6s1B11SlKIJX3+G9Pj7FCGIpsZGm98y+KWeQRNnRGJ3BrTTMlsoDoIHYsAWclEgFSDB0wrj
	KWNWlNlljJXQQPXW5i7j3H5Jfq4RIi3OiiDnRadP9cv9XizppzPyuKDQu4W8XbvMs1ahREDtre2
	qNGwIzVH7K8mg==
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr31452068a91.23.1788763659995;
        Sun, 06 Sep 2026 23:47:39 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:39 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/5] driver core: fix typo "sucessfully" in comment
Date: Mon,  7 Sep 2026 12:17:21 +0530
Message-ID: <20260907064725.10686-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "sucessfully" to "successfully", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e8244c..3b8ba27802a8 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
-- 
2.48.1

