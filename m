Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33003DE439
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243967; cv=none; b=VBMzQbmS0SE1FQ+AiZXdcyLa0qwAK0EklzUY8ox/s2YpoXnmMzUvglEfD6MSuFvfnisLGvjo1k94Tx1wPTTAyvv9IGsyxhLcEtIUxALix/95hmgg259QT8mcGRDl6lps374T06cp9Fv/Nb/tKVOVJP+g59knlKjXIpzZfZjwGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243967; c=relaxed/simple;
	bh=Xs/HtiPO1xtJDcZVerZ8/69q45pZoH9BAsnH8Q37rk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEyHbN+2H2HOOgTJQjw4Q2qalb1Mj0oPakOB+ZaYOFY6RlxAki7wDfkzjX4LWI2xNJVRVWi/FUFJ9s8faNmmlVB/HtVn+RAZW6oy0FECmsZMvcHY13BNMd8rzMnrckDznEqjNZG4V0qF+93qn4sWS/LAU9wCiCWJRyjw4sBLabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7+ruDgR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7+ruDgR"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so2092579e87.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243964; x=1778848764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n9228Bd6H5JKp1KPGvBUKX9yk7WrbeWnXK2gI0yqVU=;
        b=d7+ruDgREprDZ99L65wfXyNkugCrd8mQ9X9Cudvb4wKtFj8UEfh0XwE51X7NnwP1X6
         2H9XN0okfzjXFcEkoBW03gcZhC5ovzsuTxgrAD0JDOvQJWgjKKObaB3rgFLv5OJ1l7rV
         aATzy+Y+ylLywxZhfYWEuWtabI+GQo0h8pVvw5z3HxTKAa42/UwOVWOHhGmHlfPgRcJd
         LYr/ElX2t4StdhDxS6crdDXRSBNgAdd+R4C7OMGvy8Iv0cMr2VlMz1fAVJpErNeFCmxi
         MkfYYSz/G7b3qyRYmmhmKpQ93CMb4hwY4Jet7w4Snu7tzx2RSo7TgKkOktyKga/zJrlz
         lpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243964; x=1778848764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9n9228Bd6H5JKp1KPGvBUKX9yk7WrbeWnXK2gI0yqVU=;
        b=niF73qLJNd52+8VHZI2N1GrvbwVeAThJhRQm4PVYzHW4hZoiWbQ2f+UJfgvU5215+C
         ShgzWnpDInF6B/m6u2lJfcZcU/iQrdxC3v3O5hbmYIuEXGYaBmsvuDQwoTaZ819kzyGY
         2DH+HrjBSYdSph3VXIeMFLS21yAwphd+GEh6zKN9FlZTWoT11/nqinslv2sQKCa/qXBA
         7hNZZh5eQr0NujmEC4Pym70uFngKDKdnHBYOMY4Spa+WALtxB0CtKu7HJ6hivz+mf6QT
         1720U/erKYCkGG6Kxay4wm7sc6rAA4iQp5hfkOUipndBaIqQ2AWQ5x0jEpoiIopqf3VK
         zaXA==
X-Forwarded-Encrypted: i=1; AFNElJ8g8mvJNY3sx9FM8Gpf/UhbuliXGgbq6TaVynmaU+3HX/0oAngH9Lxvyi9u8P+EYZu66x01irj4iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFhILGV3krXiNGAN9tTKkZF3EcCNWoUyxli9qLeMEA+GskQub
	8AJYQwlH/Al8ukz3tUCwD5opQ0IriBDCEZ9tKZ3WPd74pK3bBkn4PMDPxFxyF/8BnsM=
X-Gm-Gg: Acq92OHF9t5anrqVMxa9uEgDgAy8hNgfrWBpmjZ9IPdbWsQfre35RUdn84B9yTL2fKG
	EC/lIv7Bif8rJaWwhPDqmKReTfp0artsT4KZu9Z4cAGLbSvjMNWZlqdZK1QvVZcUjPHT5WKZghp
	6mtw3oRWfB68MzWF7RaACWjZLaCs0odo5z5y/MOUuj3o5HLt586cE0tarpt16SxL52sj97F7jzh
	MDjl1ZF8YLlj9GCreHWBNRdSsHfIJwysmx4Vsn0gHisQ0e/BjNaCn5NMOo0rSZTneRaRn9SfHdC
	yRlIciMbv05H6lyAvQOgPXLh3Zy6JzHRjiAwQdpe400P8pYdytCW6uFfobCM+DAeolFhvPPOA2J
	QJQfJe7taG+MoaT54gjIycKbFjWy+P3txGjweBhyNc2UmVzvc061FIeFWqSEymox6OYNi96mj38
	twtt1gL0JzIgXVVoAuOF3wFixyAJz44Yv/ARacaakcvKtDVGCWvPgkR8IFYs02SDY3hf/ijZjv/
	QfLLWTBwj0=
X-Received: by 2002:a05:6512:15a3:b0:5a8:837b:3d80 with SMTP id 2adb3069b0e04-5a887cde91fmr4509411e87.22.1778243963646;
        Fri, 08 May 2026 05:39:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:23 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
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
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 05/13] pmdomain: core: Move genpd_get_from_provider()
Date: Fri,  8 May 2026 14:38:54 +0200
Message-ID: <20260508123910.114273-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508123910.114273-1-ulf.hansson@linaro.org>
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- No change.

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

