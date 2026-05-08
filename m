Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F93DBD4F
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243975; cv=none; b=pWaCS3ItVckByJ6BHCsfIWpymgITyoCnz9QfsKaExjHvg5rWr75JQ8QbEsuFfGXx8c87SWkVRdGVJBhQ2LH2ylXZmyXsxPp9jp+j8uFFx2X+WqPuJ9VhOUNr1uTb9WnTHl863dp3yySEp1G+O0WAiPxnPMdLAlpGycemFHNTNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243975; c=relaxed/simple;
	bh=sXCjyMUZo4URsDmSQZ9Vo8gr83eBVJtEB1jj+SkQaL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGDwzjAJBy91in96r6Pf18wjUFmwXamocTH/jdH5dxKJ3da6QoyFx+7ayZjy/9uXy3JQkhK7Mmb4yhtwOmi0atBkRKFGW/07sHExnM9JPN848YNs25vBDBi8RMYor4tGwRFgv0Mt3u5XXqebTbJ+DmnjLuedi4PRZCUINdrdcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SIabo4/6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIabo4/6"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so15766451fa.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243965; x=1778848765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rXkI/5pJxJgQUkPnjmS1Ch3OvikdB3cgLvtk24pgs8=;
        b=SIabo4/6WvJ+/TtNXbjxqr8JQW/F1uIIeblZXjvz0iXK0wWFwL/Taxshgrwi4ej9U2
         mYzR1Ax3+iA6qkwM1i/FhpyjLgVqf0BquaUHmt59jYMS/xXzuDo9MrF9l/ZQ+fWr2zHc
         uVsKjyHhdEkWXYFMeNk713k5N827etMTvArx04NRcqfNtTmnbZIzFbFkIktqSiLSFC5n
         lXw422EkEpJxKcrfWmHsABTdEhR6dl9qp6BUdL+ter5NMUlfNbFTwgGYV4TFhoY/DIo2
         VJSm47bavgMka1ik8v+si5WTfB892neIJAmQrXqiMmA9CNsQc420U+5m7W3BmRwus/x2
         A5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243965; x=1778848765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rXkI/5pJxJgQUkPnjmS1Ch3OvikdB3cgLvtk24pgs8=;
        b=DHFQpz2537NJT9f5B5HxmuBbusPYs73egpW3cBlzeUPNQtB5YHYw3NiaVNcfn8RReu
         oLDlnHHn5W6a6xUV/M5o0iryznUbAFcQUYm3ZVZDjnwWA7nJlXzk1mXINTSBiIRtGcyE
         GX9wykU4vbs/3jgvNV+UPPSZUn57JGn9/W8OEL4hLxa4vz4nG8faMFC/zTfsKd0fZpjX
         5YAZg8bgvtrx5s4gjcf/jL23xYoDPkfiEJq/7A3hoLv44haO179ghEmauKHiOSUeRodR
         vFUAf80nor5zOkKKD8pmzfv7LT2ds7VVw9qxY1zJqY8jYwrY26V/YZc6z9avoEP/LJ4E
         MD3A==
X-Forwarded-Encrypted: i=1; AFNElJ8Edyjhv88/3TCnA32ZSqpS4EjfDt9c+paop1GZOBqfzJKLr82FnchK3cpVRppfIMpakYTynn9ayA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwilntC9ahK5Xh1CLI7JkwUFsvO9aQsHssuapQF+AuWhcO120Dv
	23H9cCuM2UHCbrREFBTXFI8FpxB/zq4StOVyg5nXDCYAtyNQyOAEIcgw1xN2fxCH9IU=
X-Gm-Gg: Acq92OHQf7uEsFcYJTE0AtZIzyEV1jXvMn/HN8eCJJTKvkpP1JBCSq6qgC+DY/dMPXu
	QK4iuHnl+rByhBme7LzscQRRn6MfCVc8q8B9nBBCL4N5FqYGFsTOL0mad/yfR/L7n3JMfTC1Z4E
	KfK0UsyNHRhrS3SzZ6kpcaocIkbnWwam2nMcUsgYk75vwck07aO0ES4u51Z/r4J0GsDkAO389x1
	XFdk+qAUWmYQBd1ZuO8qpU0STidN9NrCVj91CHwR6T6a4+Rtcl4/G2fCbLOagUZKB4SNr466oek
	Fv/pxG5yV9Qh+flF+AY98NfLmD8k4Gpk8Ng+L6Lt4PCKl1G1cPkoT0MWmheO5JUE+Gfi16m7aP0
	Qws9+Xq3NTK0CfDUoNt0E1tn+8s4BN+54fjGhtdE8DFzCvLTd4lPgXPctHoJKRQ/jVsH0aKv/0r
	tat4C172z4TYOiy4nZCcAFweyyQKdjd0wyc5YuYuDCXFMS+dTL+2z0FWl5y42xM2aY5AY5Sj+N
X-Received: by 2002:a05:6512:3f1a:b0:5a3:cc81:eff3 with SMTP id 2adb3069b0e04-5a887cdff2emr4839959e87.26.1778243964852;
        Fri, 08 May 2026 05:39:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:24 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] pmdomain: core: Add initial fine grained sync_state support
Date: Fri,  8 May 2026 14:38:55 +0200
Message-ID: <20260508123910.114273-7-ulf.hansson@linaro.org>
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

A onecell (#power-domain-cells = <1 or 2>; in DT) power domain provider
typically provides multiple independent power domains, each with their own
corresponding consumers. In these cases we have to wait for all consumers
for all the provided power domains before the ->sync_state() callback gets
called for the supplier.

In a first step to improve this, let's implement support for fine grained
sync_state support a per genpd basis by using the ->queue_sync_state()
callback. To take step by step, let's initially limit the improvement to
the internal genpd provider driver and to its corresponding genpd devices
for onecell providers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Addressed some cosmetic comments from Geert.

---
 drivers/pmdomain/core.c   | 124 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |   1 +
 2 files changed, 125 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ad57846f02a3..c01a9a96e5c2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2699,6 +2699,119 @@ static struct generic_pm_domain *genpd_get_from_provider(
 	return genpd;
 }
 
+static bool genpd_should_wait_for_consumer(struct device_node *np)
+{
+	struct generic_pm_domain *genpd;
+	bool should_wait = false;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		if (genpd->provider == of_fwnode_handle(np)) {
+			genpd_lock(genpd);
+
+			/* Clear the previous state before reevaluating. */
+			genpd->wait_for_consumer = false;
+
+			/*
+			 * Unless there is at least one genpd for the provider
+			 * that is being kept powered-on, we don't have to care
+			 * about waiting for consumers.
+			 */
+			if (genpd->stay_on)
+				should_wait = true;
+
+			genpd_unlock(genpd);
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return should_wait;
+}
+
+static void genpd_parse_for_consumer(struct device_node *sup,
+				     struct device_node *con)
+{
+	struct generic_pm_domain *genpd;
+
+	for (unsigned int i = 0; ; i++) {
+		struct of_phandle_args pd_args;
+
+		if (of_parse_phandle_with_args(con, "power-domains",
+					       "#power-domain-cells",
+					       i, &pd_args))
+			break;
+
+		/*
+		 * The phandle must correspond to the supplier's genpd provider
+		 * to be relevant else let's move to the next index.
+		 */
+		if (sup != pd_args.np) {
+			of_node_put(pd_args.np);
+			continue;
+		}
+
+		mutex_lock(&gpd_list_lock);
+		genpd = genpd_get_from_provider(&pd_args);
+		if (!IS_ERR(genpd)) {
+			genpd_lock(genpd);
+			genpd->wait_for_consumer = true;
+			genpd_unlock(genpd);
+		}
+		mutex_unlock(&gpd_list_lock);
+
+		of_node_put(pd_args.np);
+	}
+}
+
+static void _genpd_queue_sync_state(struct device_node *np)
+{
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		if (genpd->provider == of_fwnode_handle(np)) {
+			genpd_lock(genpd);
+			if (genpd->stay_on && !genpd->wait_for_consumer) {
+				genpd->stay_on = false;
+				genpd_queue_power_off_work(genpd);
+			}
+			genpd_unlock(genpd);
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+}
+
+static void genpd_queue_sync_state(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_link *link;
+
+	if (!genpd_should_wait_for_consumer(np))
+		return;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		struct device *consumer = link->consumer;
+
+		if (!device_link_test(link, DL_FLAG_MANAGED))
+			continue;
+
+		if (link->status == DL_STATE_ACTIVE)
+			continue;
+
+		if (!consumer->of_node)
+			continue;
+
+		/*
+		 * A consumer device has not been probed yet. Let's parse its
+		 * device node for the power-domains property, to find out the
+		 * genpds it may belong to and then prevent sync state for them.
+		 */
+		genpd_parse_for_consumer(np, consumer->of_node);
+	}
+
+	_genpd_queue_sync_state(np);
+}
+
 static void genpd_sync_state(struct device *dev)
 {
 	return of_genpd_sync_state(dev->of_node);
@@ -3531,6 +3644,16 @@ static int genpd_provider_probe(struct device *dev)
 	return 0;
 }
 
+static void genpd_provider_queue_sync_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = container_of(dev, struct generic_pm_domain, dev);
+
+	if (genpd->sync_state != GENPD_SYNC_STATE_ONECELL)
+		return;
+
+	genpd_queue_sync_state(dev);
+}
+
 static void genpd_provider_sync_state(struct device *dev)
 {
 	struct generic_pm_domain *genpd = container_of(dev, struct generic_pm_domain, dev);
@@ -3559,6 +3682,7 @@ static struct device_driver genpd_provider_drv = {
 	.name = "genpd_provider",
 	.bus = &genpd_provider_bus_type,
 	.probe = genpd_provider_probe,
+	.queue_sync_state = genpd_provider_queue_sync_state,
 	.sync_state = genpd_provider_sync_state,
 	.suppress_bind_attrs = true,
 };
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b299dc0128d6..7aa49721cde5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -215,6 +215,7 @@ struct generic_pm_domain {
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
 	bool stay_on;			/* Stay powered-on during boot. */
+	bool wait_for_consumer;		/* Consumers awaits to be probed. */
 	enum genpd_sync_state sync_state; /* How sync_state is managed. */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
-- 
2.43.0

