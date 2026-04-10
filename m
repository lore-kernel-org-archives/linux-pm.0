Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CB38E10F
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817674; cv=none; b=jqqNqtg0OBTM1KStUXL9cZElwzZdGViIY8uD4Xhy8eO7RyjPHQqy9jdrBixSyDB7NEIsBEfCHTHqDE35j4+aO6S/CGXprgYBC8NC6NkK8q8pB+zUjEsAhmlxzXsLOwvFa8sJvtqT8iVKp27LjX8MDGcsA987rklw5ju5bhWduZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817674; c=relaxed/simple;
	bh=KuIvrgkQZXsNbe1PGIJcqjwmYA54iDgNFmQrWWfasDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1UP79HLQdPZGeJnHFNkZYush8iFUs26JDFIbLf8Egfq/CnMsqfCJrbSqhVBIBSLlBHxwWaYANKYgEE9I6bysqJsCYtW2T5720kz7hQi0zhNsDQQjK/TQP9pCWIZWfpWkkca1pGh1ZasHsMftl4eYqZaP1oAvfRwzGS41NsOv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iheW4gve; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iheW4gve"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38cc0b91b01so15331381fa.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817671; x=1776422471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm+wP/DxtqDeb0bHdnh1xnktH2NnKja4jlZQ2gGkpXg=;
        b=iheW4gveNO1P5MdzhcI5pW08CIkJX50XnXm+kh2VdrDMpztw3TRSKCUkRvL5Z9QGfD
         E0ApDXNwF/RCbgn6VT6ehaYf5yCVi12y37unmp+vfBwSseqW/JXBPCTNrTLeHeJUMwje
         vyVRrtoqDuIXn5d+s3E41RyxZczKrp6EFTNcm8OpcesAqkGg2Z/Ohmr2+wCn70eVgwvE
         AwFXcQLz1uO8hJ7GD8WZg64UPk5BAg8GVDQlbuDeNvugIFjh2/iL0yCt/bXGHpOpUoDb
         SLODi85JF6bpqbORVRznpC3rn5PBESdEHimJR/7zrysJzVcc4ufteroXaqnRkDFPWWNJ
         Gmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817671; x=1776422471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nm+wP/DxtqDeb0bHdnh1xnktH2NnKja4jlZQ2gGkpXg=;
        b=rG11lZbcTibPFnYlPA6uNkQAgJR0/Ui7UgK0hkcqFOJ+yAC7t3LWhBmHYUSNe5Ba+W
         1rOsuL2p2wdW9JNmRow2hYmskfBqYo45S8A2T8V8JTKMpRnHOs1XIvYBnxQR++pRj5WI
         dGDEHAqihFcG5j9bmRjA79iv17fvHe2qEmcjnNLU3LNJO1/d5an+oWXpjjmS80EEzQEN
         dl7nncW+hsxj7fhyPn+Z/V0acXDhQynnF+221CngdwyDK559ObrOQXWvh2KzJTV3g928
         IfviTNqj4GKMF6yGj6Aj6zjuj0nE+R6/6raFxk0PodWO3XQT1P2ASHiUtO6k9DCEvTLL
         yJtw==
X-Forwarded-Encrypted: i=1; AJvYcCVILOM88kBXELb0TKwJn4KVFC53EW9Rpqz1dw+yh3Dmmo/B9tsquluAQ3iCTbcfSuiTfX8vDpNvPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKVGjv1fJH6kemE9R2zFX+XnJmRLoggLGZpv/lL5ljgk8x9JH
	SIBSHBG69XlXBPYsFzcCJA2KGLxxclNC1Epd+Dr6kAgtlLJZXr4yGQdp6MvLJmh7LJLBgkw2F2O
	Bm4+l
X-Gm-Gg: AeBDieu+JN9eIQ6FYx+hhTqLKcSioxq59wO0Oww+Ip/WxwIkaIUuwyUbrsVIeeC0Ndd
	6AOiD8awjqRzAyxwf0bm0fxLWj+dnN17UnJoV10RlSLiIRx3kMzOymSqH5g+w/WytYwOPmHahUe
	DmVRUIBjxtlKt0JsNMeXGIt6X+f7vJ1Xzezo2cMDGed6BhONiOj2Fu/4DSzyLrR1c/4c5EtwCTg
	uCAWu+hwlJLq+TMfBFUK7nryqr6jU1cyOutIoaEraBUmH0HKcYlaTDJoaBALq3mobVNopIB0SWA
	QJNcQ1MkIggb6l4reSEJagce7KBYZjL/uh7axklHLb06iiFKwH89ovUCuNWNghCv4ns6R6OzexV
	9IJyb8XZfLHSYgqBs46KpY4zMrMqWAcTFWDdGwa4yJILfRVN61xgJZ1vgdSWKwY/6kwxqyf0anM
	W02IwU+LN6xB7nXoS12A9qRvHpCH6Adbn2Tk8wjwsdC5GL8GZHlp6zQRdYSMWE19ImeIrRAuR9
X-Received: by 2002:a05:651c:b21:b0:38e:2445:fca2 with SMTP id 38308e7fff4ca-38e4c052e2bmr7575221fa.31.1775817670439;
        Fri, 10 Apr 2026 03:41:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:10 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v2 3/9] pmdomain: core: Move genpd_get_from_provider()
Date: Fri, 10 Apr 2026 12:40:46 +0200
Message-ID: <20260410104058.83748-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410104058.83748-1-ulf.hansson@linaro.org>
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
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
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

