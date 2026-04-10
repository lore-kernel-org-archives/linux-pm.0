Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69F38D011
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817680; cv=none; b=SKJGXnkbKqFnV6LW8yLs61SCeEs18pcrD+9iEoq4Je6dlp0Ym3k3fcgeZ1GHLm69FEuJRJH2CgoXJlG+SvE+Su2wUbeBS+tvWVKkWYnZ4LD5FHn+rM3Mme2DrdVRVcnkZaB1pCco5pp1LvVqPZr7lbe1ETJ0Tde2Cb3F/+2GAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817680; c=relaxed/simple;
	bh=IB3CeM4ZCjOqujI0alIpIPr9P7diFeoJW2cvKyVGP1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCCL0tnDijPtSR+sQ+CaNKfnblNMsH8XEjrRqjH1ioeUIzQbH4uNKFgGU4GUaLa2ChQdRgU8gavgpaNPVSa3nWL03xkxecv0fdQTvpJ4S8ICIbBafotQnkCB2hnCpnO3/xeoxOJcWLkhdeqdc+oOe2q3/XL/8cBVw2aDXoVOTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RJ7b0nve; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ7b0nve"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38c620f1699so20625781fa.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817675; x=1776422475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UhYTbrB1qQtFiMVvjgMKHcw9lJtRkAWHlKZwVPZOCw=;
        b=RJ7b0nvecvxopfqx1RovIMsEYAruco5fEhfCRG58ZYLfj+HnJkOj6w1hOXMHPIi3vj
         uq0NjXmGlnwGKqvmHzfCGl5HFHoTLQop9mJxqaiKi8qvIrotQDEwPcnxV6i227u1Dc2I
         9YWGJX9evI/xQBrEnSnGFxBTSyEJ+kWndTJ7k0dgY9KfJ+c6YlA5z//KtYtjIJVW4NhY
         m1KcHGUwPkp1XS/k5pepwJ2N6ann4OxtEEkaoCo5ZK7CkVT7k+D7onXZnXcnOUdUggDU
         rtsNVgprx+FgoHTkgC3SStRS9kMMWiUDP7l9ldvPoaeMz2i4oFsWPQhPrj+NV0C1N4bX
         +G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817675; x=1776422475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UhYTbrB1qQtFiMVvjgMKHcw9lJtRkAWHlKZwVPZOCw=;
        b=RUgzb7wfNRb7kbBTWTVuNmym/5lrd/C3Zg/HmYVT4GaHwUIrV9Bf4TfNZd4aUN+toG
         bE+QMxECXfkp41APMUe0OrvNoUDgTrJMMaCKFH23v5Jr5NRVMK7S6L/txhA5olow49e9
         t7MaiyrMaHmAvfQWPaRtjVcTyqsi64XIOZZRCRyKh2hgKllqstcRqDYsTMMB+N2+DByt
         Yzj3pv2GDWtj5GqLfS7K7yTfLU29MzlZzNszXB3QvYfBvFXU+Yqw8dG1ymlN2SHdi+eC
         yDq9gO0fmC+zRVE/jyzOyPOovv0H4a7E5R8PNNd0ikzvpRD60ygUCtVVkjg+EqNCd/tZ
         IsgA==
X-Forwarded-Encrypted: i=1; AJvYcCWXX3gSWgNQxUdNRQ//BYVIrJLRQJy3sEvhGQawx+3WSdhYXQF9sU1cpBqIramXAEl3YTLehugvXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqP/0goOA6f+Y7pLQRYkLiztYf/8FLbdGy4LXnBvR8wmVZSDy
	GWIkpb7AmtFYw31NvIgYz3GrA5RfonfzJw1SL5mdnZhR3s8PwRnmQZ+I4rmX4rt9WuU=
X-Gm-Gg: AeBDievYKwf9qWUWchhrmJ3lsDtPkQQZlwdCjqeQfpywbSaxH5k5VIwwJCTX0/80lyT
	KpxJT+UN9XecOeCAiR9Wf9a8d7TV3o+hA9x2kn25SZiF0sMHq2xeBk0oHIzcR+RlwgzflWQl2Jn
	THreVcjWSHuDAsl4Ny2uV7SBq7ombUb18xdS9CAFvl0a/HndmQNRKgytExDhQqV337IobBJey99
	UmTKd3yN8LJ5ezfIWePBVTAZJ/30dkN5s+OJB61OGxfz51ZnAm+K4uvO2Gg9rkDKff05q+3oEGJ
	BF+NhcAy1rVl20jptE7zBspKLf9gh+dMFJq6mceYbPEKuUTG4mQZYdCZSr1iVgKpZEDx/JNEsUF
	Tlzk4e1trnj+1z3X2wW+p8cxPeFNUDYRds0q8d6L7n/Q3K8wWOluAK8ygtZAYTKsNwYcDHPwYst
	VtUV7wEPc1PGvGqmUhzGzXZieektazznD2kn1/MghWAFodJIiMuIxV7foww/1JMMrbtxLYY1zb
X-Received: by 2002:a05:651c:4390:10b0:38b:d004:3f27 with SMTP id 38308e7fff4ca-38e4bf6e48dmr6460551fa.21.1775817674483;
        Fri, 10 Apr 2026 03:41:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:14 -0700 (PDT)
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
Subject: [PATCH v2 6/9] pmdomain: core: Export a common function for ->queue_sync_state()
Date: Fri, 10 Apr 2026 12:40:49 +0200
Message-ID: <20260410104058.83748-7-ulf.hansson@linaro.org>
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

Along with of_genpd_sync_state() that genpd provider drivers may use to
manage sync_state, let's add and export of_genpd_queue_sync_state() for
those that may need it. It's expected that the genpd provider driver
assigns it's own ->queue_sync_state() callback and invoke the new helper
from there.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 14 +++++++++-----
 include/linux/pm_domain.h |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index f11dc2110737..49e60cb67b3e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2764,7 +2764,7 @@ static void genpd_parse_for_consumer(struct device_node *sup,
 	}
 }
 
-static void _genpd_queue_sync_state(struct device_node *np)
+static void genpd_queue_sync_state(struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
 
@@ -2782,11 +2782,14 @@ static void _genpd_queue_sync_state(struct device_node *np)
 	mutex_unlock(&gpd_list_lock);
 }
 
-static void genpd_queue_sync_state(struct device *dev)
+void of_genpd_queue_sync_state(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct device_link *link;
 
+	if (!np)
+		return;
+
 	if (!genpd_should_wait_for_consumer(np))
 		return;
 
@@ -2810,8 +2813,9 @@ static void genpd_queue_sync_state(struct device *dev)
 		genpd_parse_for_consumer(np, consumer->of_node);
 	}
 
-	_genpd_queue_sync_state(np);
+	genpd_queue_sync_state(np);
 }
+EXPORT_SYMBOL_GPL(of_genpd_queue_sync_state);
 
 static void genpd_sync_state(struct device *dev)
 {
@@ -2922,7 +2926,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		sync_state = true;
 	} else if (!dev_has_sync_state(dev)) {
 		dev_set_drv_sync_state(dev, genpd_sync_state);
-		dev_set_drv_queue_sync_state(dev, genpd_queue_sync_state);
+		dev_set_drv_queue_sync_state(dev, of_genpd_queue_sync_state);
 	}
 
 	put_device(dev);
@@ -3654,7 +3658,7 @@ static void genpd_provider_queue_sync_state(struct device *dev)
 	if (genpd->sync_state != GENPD_SYNC_STATE_ONECELL)
 		return;
 
-	genpd_queue_sync_state(dev);
+	of_genpd_queue_sync_state(dev);
 }
 
 static void genpd_provider_sync_state(struct device *dev)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7aa49721cde5..d428dd805c46 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -467,6 +467,7 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+void of_genpd_queue_sync_state(struct device *dev);
 void of_genpd_sync_state(struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
@@ -513,6 +514,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline void of_genpd_queue_sync_state(struct device *dev) {}
 static inline void of_genpd_sync_state(struct device_node *np) {}
 
 static inline int genpd_dev_pm_attach(struct device *dev)
-- 
2.43.0

