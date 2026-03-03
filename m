Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEE426EDB
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544211; cv=none; b=FzG7+u4kbl/iCJHOaXcoHIoRA4n0CtIjwm27MGsAb+1aMZPzwhnBxrqRS+VIwmFGksS9jsGs3mTHUotIcUISY/9gdRFqzTNoadWVhtOZbzeUwqjIX7P7h0Xu/lhrmnifMCt6O0Hk0Xzo5tIVtVDRIA2yF5XQXr/BU3LKiYgZOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544211; c=relaxed/simple;
	bh=PgRK7Z/ELlFf1grrwRkzttg710p9L9+z9DNAt0f3fH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny7p+t0Eb61HSlBrjQ9nS6YTIJzVZeSZAyWyeb9Ld7Sh7egbZpcURJ8JU1wuH5B7/5jnks04uYg7PfdIcb7NtXk/nhnBDEJpg47M/YqgqPlRjcKnth/37mX5phPkz63SNEs1WVZSFXLz7RokE0hme+qkRYGsMziusjmI98VRAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlXjXBfM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlXjXBfM"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3870902760cso93881921fa.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544209; x=1773149009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I/ac7CjNwYFvttLqOBBZxSN0B1UQ8w+5WLt0DDXeQY=;
        b=mlXjXBfM2oYpMtcicb53SRRF9wIt3kfHLC2QKkl1QQZq4K5/JcMNHknKPRE0iElGgS
         +XM6OptTcoLEkKQBG/juienNP6/tbjKJGdYamikaLI6zSjXc/cvaOmnFc5T45hbbP6RQ
         iXYY7u9UjEWVyUixe1qV9qpDVAXuMNSRvTu7L4UMdMecd1Ggl7E9Wkp3M0LyY1V2rvzP
         V5S6xq51aG3zPxjyI2encKEdMIqmRVOhP+hil2VCpsw7eyRfBswgetI1SOGkHEjMhzoC
         YC5BI2j6t2bde5pQAo7Qwg5iJhYhV2ZfI8r7Z0YtAOvTiDgB8mfsQl3ECRf9nSCZxi4C
         I9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544209; x=1773149009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1I/ac7CjNwYFvttLqOBBZxSN0B1UQ8w+5WLt0DDXeQY=;
        b=CC2hmPr0vcQZXnELQ22j52d03PtVJgom4jqUE9nhy/4kowyyZ+9KUNeHBlHE7+u/fd
         evY2jDymTsXYkWOOa2SsEI7AX8sl4ggxhXmSXju3EmVAc8rTpZuwZ0gVbbsZRev7HJzQ
         FZLg04Iefqy15Ii9T24XXU9CjiRhpPJy5FukDTKwRGbRUR9jQYi1mUSEx30P8zPJ69Ol
         pDJr/1J7LVc9qzfIAYxykXIyP7A2QI3ChrWLdQngiUmyqq+WST9sWV033wVBb1+hDIf0
         WZkgXNip8VJOHMPL+UqqazbVaOEzULh2hXxqsDvlAa7Daz6Wamiwc304EXe1U803AqYp
         IkGw==
X-Forwarded-Encrypted: i=1; AJvYcCVLnCDxkxrF1BXZeS3+d3S1XVPwfR1tVNHXsLwsSDQkBYCXQkpbDIsQvqENmFVCNT9ZQx2Nt8LQcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiQtSQLHjeiMy0Kj5ja5gQA2zVPgWnLHFfHmC6VhUDH0rexKq
	kSX6E86+NudVam2PMq4xk9Zm/oU2gN5QquEyvBsZspswLeTRdMJBgzIfTLB2DGn+RBc=
X-Gm-Gg: ATEYQzz6NCYKBQlzRboRShnDXPemVPb57Lu/FZrVnVpHQbCZE4jiAt3LU57gCWwHaPo
	Lce33mW+OtnXEkgtAJ6KqJhUBBesox5XJUTa7Gf9mKN9cTd8s2Y6gCZPb8rBvlPSPnKihyA7zGz
	nDwm6+VuFuINDHXvAf4PVH13aFI/yam8Wdfj1k/FVIjQai8wBfFshNz9f0SJCj/PmJYF85mpijX
	psqHCPybDKVmmJNM6lNy06YBmnUSipcZxaBT7awTTZREOpr8Mvg28ITH6n5vVASW58xCBcrVJRI
	lehXuCO0tZxJ6cvUdSE/DaYgqV/ttpJ7BkG5Cf6iosM/VRFTa/paRq5Dj6/CVvUrd0gWWBS7Byt
	E7YjW6BJWmaeLKStsTOTnNEzNdJqxyvSc1uFbJt2Vbu/lyQMVhL1VS+ts1SZDkNGMjA6nCstZfF
	ieVzWB37B/7PlJ/0fP9l7Y+qtDh9VDnYO9olHERQzs0sr0u+Chr5a/5JkOVnwdJB1KGI1vshY5
X-Received: by 2002:a2e:be25:0:b0:38a:9c3:f0b2 with SMTP id 38308e7fff4ca-38a09c3f59fmr82542031fa.29.1772544208542;
        Tue, 03 Mar 2026 05:23:28 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:28 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] pmdomain: core: Move genpd_get_from_provider()
Date: Tue,  3 Mar 2026 14:22:49 +0100
Message-ID: <20260303132305.438657-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for subsequent changes and to avoid an unnecessary function
declaration, let's move genpd_get_from_provider() a bit earlier in the
code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4d32fc676aaf..ad57846f02a3 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2664,6 +2664,41 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 	return ret;
 }
 
+/**
+ * genpd_get_from_provider() - Look-up PM domain
+ * @genpdspec: OF phandle args to use for look-up
+ *
+ * Looks for a PM domain provider under the node specified by @genpdspec and if
+ * found, uses xlate function of the provider to map phandle args to a PM
+ * domain.
+ *
+ * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
+ * on failure.
+ */
+static struct generic_pm_domain *genpd_get_from_provider(
+					const struct of_phandle_args *genpdspec)
+{
+	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
+	struct of_genpd_provider *provider;
+
+	if (!genpdspec)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&of_genpd_mutex);
+
+	/* Check if we have such a provider in our array */
+	list_for_each_entry(provider, &of_genpd_providers, link) {
+		if (provider->node == genpdspec->np)
+			genpd = provider->xlate(genpdspec, provider->data);
+		if (!IS_ERR(genpd))
+			break;
+	}
+
+	mutex_unlock(&of_genpd_mutex);
+
+	return genpd;
+}
+
 static void genpd_sync_state(struct device *dev)
 {
 	return of_genpd_sync_state(dev->of_node);
@@ -2889,41 +2924,6 @@ void of_genpd_del_provider(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
-/**
- * genpd_get_from_provider() - Look-up PM domain
- * @genpdspec: OF phandle args to use for look-up
- *
- * Looks for a PM domain provider under the node specified by @genpdspec and if
- * found, uses xlate function of the provider to map phandle args to a PM
- * domain.
- *
- * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
- * on failure.
- */
-static struct generic_pm_domain *genpd_get_from_provider(
-					const struct of_phandle_args *genpdspec)
-{
-	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
-	struct of_genpd_provider *provider;
-
-	if (!genpdspec)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&of_genpd_mutex);
-
-	/* Check if we have such a provider in our array */
-	list_for_each_entry(provider, &of_genpd_providers, link) {
-		if (provider->node == genpdspec->np)
-			genpd = provider->xlate(genpdspec, provider->data);
-		if (!IS_ERR(genpd))
-			break;
-	}
-
-	mutex_unlock(&of_genpd_mutex);
-
-	return genpd;
-}
-
 /**
  * of_genpd_add_device() - Add a device to an I/O PM domain
  * @genpdspec: OF phandle args to use for look-up PM domain
-- 
2.43.0

