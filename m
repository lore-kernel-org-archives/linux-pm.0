Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E061314D2D
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188392; cv=none; b=Icc85N4scNPG1n52hMD5BdfWo47YSifOI2AbxxYNMLeKQ2TvujHIdrXiSR36r4IEsYYrcKdV9jFpCxOwj4hCLl15Y4YgS29h7k4mvjwhs8xijSBrCacBPHN5OcLEBMVtXd3Ep88XZ77X2o0x9Mnga2i3ICArF7bMtabCAxiaad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188392; c=relaxed/simple;
	bh=4oxBL1nK08FLRbDWU9wkPzZS7L2lwxUdKpRD7zqmMz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpPKQu1ppUV2bTAFpMUI75gscUZzvuw5IGMIRVVT8RXx3a2erQgT4mEZJHSwqa9c4grVMXA/iM5NT5YzALwO7gp+g1NAZKEdrCZcp2RiusgdFyYpczuv8YjUcja/O3ktC+95Uk2Nuvqum5uR/9iLLv1jMutVWYfO3q/MB+4C1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dOL4rnkl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dOL4rnkl"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8299c75f730so229453b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188390; x=1773793190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5wwOswllCgTCDAs+LOmWhWVxDwPfzx7ibhefMJUOMU=;
        b=dOL4rnkl6NmtWAD6thVIaUNnv6TlhKIORo6vMKokB6m2tyujFypiteS901BdhPORo8
         IQQFK1r7r18mfSBJHsgJ7DVfbd/xwFam/iP4QtD2g75Oa9osF63KP74KJdkdkEJzR865
         uBWiUIlGq2c1NbLN9ZUbuNqkXfS4lXv3sGIdpuIWeTd4X8WPoJoEWVHBkmM/KHCTfQ0E
         05haAO1lS1onodDAGp/1LGVlvxJ9KYDiJUESIrhHtt88ia9wUB4ZqxMVPWKNmTXffO5g
         CrBGDrVOn+vn0wRVu4lkl0ehg7oTqrwf0DwBX78vEG8QN2kCx4ftzAcvP7iul6seJd87
         IYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188390; x=1773793190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h5wwOswllCgTCDAs+LOmWhWVxDwPfzx7ibhefMJUOMU=;
        b=rhkPzD9QCFzaAxW67k/5GBd0MSQXxdBCaJaKOwOZ7g0AmZsjlDFpOohUHWCDMchdqq
         PwwlUbhssfcYK1WqrDpDrJu7ksiqzKmCrWEnc9Y1858wXLyBOoPwd3pSxukJwIOBAqhA
         POsms/9fIawHOzQpWWwqzU+NatjUlllaF4d6ZAvBEmvQpiM0rwKi5hDtEwHcaisr9Oz2
         FHiAWj7Q0c8skB38sSFi149JXR0gICcJMsA9cr1wDIJo2vOzrwwIyQDEKXmesKbgfoT7
         CNAgu5JwN6E7MduLIBuHyn9QweNnUR0ZhVCy0HqWPTZf6KzMLuPpIrj/PfAUkPQK224I
         m8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/YQehZhmdo67b46OcZzhQVbPU4eRxTz64m/pGC45k8/ioEXI7Y5FfwpRPXESkc6W8EaNzpMPsQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxClcDRv+PqydkQaZ3Asfk0XPTPKzwaRSuVoQJbKaFAgQc6b/ZJ
	7f8img3dYSAm4KOqG2LSyrevi5ZEq+/m+cm9Vi/jMimbm+KkXC35vZo4PKagk5YJnuw=
X-Gm-Gg: ATEYQzy54qv/G6plzjwZa8FBxgJW+PpVsGT2aNiXu4fceun5LS1YDydjU/zLWiSizCc
	8xWRNaxY3hhdNHrzRpCHwxQ+e5kEqpTn+X6FtHSTstnshj7F5MjoEDGCPgT38jROMM3H91DI1cn
	GudIBu3fXjSXXhWUcSF+PtI7eawHo7zjsNir9nX1s2kCE203LzVwm4ZZ7BBaIl7WlF7p4d12cXw
	j9uqn2nN6jvgKd6/NVupGl+NF3HCKYnZEziald/h1f4lpT1t4lSaKG7Q/hsPv8sWfZhCylHBEAg
	8euDEbw3dP/iGMvPcyr68S6SdZLQr1ueG+TGBoib2VFPnJakWopx9CGYw/1FQMfqSlnj2d/wZjt
	P9ob93zF5zebt0s8eLynP8k4TMrNwJDVpDBPUfRvi0Pd6RlrZUTC5C2VLqZVwK1cOAjKLB4QKf4
	JH6veVR2sHYQt2L3y8Q9yu
X-Received: by 2002:a05:6a00:178e:b0:827:2d7b:5038 with SMTP id d2e1a72fcca58-829e3ef8fafmr4682544b3a.5.1773188389865;
        Tue, 10 Mar 2026 17:19:49 -0700 (PDT)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2b34sm453256b3a.3.2026.03.10.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:19:49 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Tue, 10 Mar 2026 17:19:24 -0700
Subject: [PATCH 2/3] pmdomain: core: add support for
 power-domains-child-ids
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev-53144
X-Developer-Signature: v=1; a=openpgp-sha256; l=8594; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=4oxBL1nK08FLRbDWU9wkPzZS7L2lwxUdKpRD7zqmMz8=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpsLUikF1gdU810zlXWY9fnICiVhRRew4IHekny
 2mQCGxcelOJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCabC1IgAKCRBZNxia0/vG
 ZZsGD/98WdtRS+muBkrIKU7WHUSnXWWHnZeDc3sa3d/QxmaOm/ov9aV2HTC1k/92hxjDTzBIu9O
 PYNpPjFQqxreSDudc/LBVRq7AwGDtwSWvAzY2xujxXwm+KZOCcanpZL5JAIbVE0HFQmDVjKh4xC
 1WXSneL6l1z+nvlJqu20HjRRMgp6TOrYH5cZkPujJnJ/EIXqqt6OIGeZrgZvFCoiVoYTVksv5Gy
 qfNURfnvExrScPbg9NnFYPW37IDCcs/Kwy/k/9vaUkRZKMk9wZSR02mI5DXEX4V+nxQ9S4Id5sm
 XICVhlHhzwvyJ3zUqHtfqsPOTewIoMH6EGgTK97SVVu4AL3wEolO25He1ZlIv4tkiJpB84nfFmf
 rA7gJUXddX4APrOzZcUk9o7zFjk3URR7nvnu0l/MgcqhGkdKjGitG5/6hvSZ/2OvDoZjuSZts48
 06FyydDM5bSyuFEFhob+tC6toxLJVccN27xtwb+JwcIXXJkk1H7+cewpMomtztWjwGfimaEnLp0
 1Ay3HYpla6FTUctSTMmnKsVc6D4vBkPpI3JklZKTWu4RdHKAUoo+QMCe7eGUqEpkQRSzXTnW/0H
 DxP6Uk2bYi8fk0rmRVIFQudPXMbDq32zYA5liIglgZ6TDJ87QZqB92C2pDeSiyqg6bG4voLTu6M
 U5oe+I0yp4rrJbA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add support for oncell providers as well by adding a new property
`power-domains-child-ids` to describe the parent/child relationship.

For example, an SCMI PM domain provider has multiple domains, each of
which might be a child of diffeent parent domains. In this example,
the parent domains are MAIN_PD and WKUP_PD:

    scmi_pds: protocol@11 {
        reg = <0x11>;
        #power-domain-cells = <1>;
        power-domains = <&MAIN_PD>, <&WKUP_PD>;
        power-domains-child-ids = <15>, <19>;
    };

With this example using the new property, SCMI PM domain 15 becomes a
child domain of MAIN_PD, and SCMI domain 19 becomes a child domain of
WKUP_PD.

To support this feature, add two new core functions

- of_genpd_add_child_ids()
- of_genpd_remove_child_ids()

which can be called by pmdomain providers to add/remove child domains
if they support the new property power-domains-child-ids.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/core.c   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  16 ++++++++++++++++
 2 files changed, 185 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce3..acb45dd540b7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2909,6 +2909,175 @@ static struct generic_pm_domain *genpd_get_from_provider(
 	return genpd;
 }
 
+/**
+ * of_genpd_add_child_ids() - Parse power-domains-child-ids property
+ * @np: Device node pointer associated with the PM domain provider.
+ * @data: Pointer to the onecell data associated with the PM domain provider.
+ *
+ * Parse the power-domains and power-domains-child-ids properties to establish
+ * parent-child relationships for PM domains. The power-domains property lists
+ * parent domains, and power-domains-child-ids lists which child domain IDs
+ * should be associated with each parent.
+ *
+ * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
+ */
+int of_genpd_add_child_ids(struct device_node *np,
+			   struct genpd_onecell_data *data)
+{
+	struct of_phandle_args parent_args;
+	struct generic_pm_domain *parent_genpd, *child_genpd;
+	struct of_phandle_iterator it;
+	const struct property *prop;
+	const __be32 *item;
+	u32 child_id;
+	int ret;
+
+	/* Check if both properties exist */
+	if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
+		return -ENOENT;
+
+	prop = of_find_property(np, "power-domains-child-ids", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	item = of_prop_next_u32(prop, NULL, &child_id);
+
+	/* Iterate over power-domains phandles and power-domains-child-ids in lockstep */
+	of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
+		if (!item) {
+			pr_err("power-domains-child-ids shorter than power-domains for %pOF\n", np);
+			ret = -EINVAL;
+			goto err_put_node;
+		}
+
+		/*
+		 * Fill parent_args from the iterator. it.node is released by
+		 * the next of_phandle_iterator_next() call at the top of the
+		 * loop, or by the of_node_put() on the error path below.
+		 */
+		parent_args.np = it.node;
+		parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
+								  MAX_PHANDLE_ARGS);
+
+		/* Get the parent domain */
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		if (IS_ERR(parent_genpd)) {
+			pr_err("Failed to get parent domain for %pOF: %ld\n",
+			       np, PTR_ERR(parent_genpd));
+			ret = PTR_ERR(parent_genpd);
+			goto err_put_node;
+		}
+
+		/* Validate child ID is within bounds */
+		if (child_id >= data->num_domains) {
+			pr_err("Child ID %u out of bounds (max %u) for %pOF\n",
+			       child_id, data->num_domains - 1, np);
+			ret = -EINVAL;
+			goto err_put_node;
+		}
+
+		/* Get the child domain */
+		child_genpd = data->domains[child_id];
+		if (!child_genpd) {
+			pr_err("Child domain %u is NULL for %pOF\n", child_id, np);
+			ret = -EINVAL;
+			goto err_put_node;
+		}
+
+		/* Establish parent-child relationship */
+		ret = genpd_add_subdomain(parent_genpd, child_genpd);
+		if (ret) {
+			pr_err("Failed to add child domain %u to parent in %pOF: %d\n",
+			       child_id, np, ret);
+			goto err_put_node;
+		}
+
+		pr_debug("Added child domain %u (%s) to parent %s for %pOF\n",
+			 child_id, child_genpd->name, parent_genpd->name, np);
+
+		item = of_prop_next_u32(prop, item, &child_id);
+	}
+
+	/* of_for_each_phandle returns -ENOENT at natural end-of-list */
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	/* All power-domains phandles were consumed; check for trailing child IDs */
+	if (item) {
+		pr_err("power-domains-child-ids longer than power-domains for %pOF\n", np);
+		return -EINVAL;
+	}
+
+	return 0;
+
+err_put_node:
+	of_node_put(it.node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_child_ids);
+
+/**
+ * of_genpd_remove_child_ids() - Remove parent-child PM domain relationships
+ * @np: Device node pointer associated with the PM domain provider.
+ * @data: Pointer to the onecell data associated with the PM domain provider.
+ *
+ * Reverses the effect of of_genpd_add_child_ids() by parsing the same
+ * power-domains and power-domains-child-ids properties and calling
+ * pm_genpd_remove_subdomain() for each established relationship.
+ *
+ * Returns 0 on success, -ENOENT if properties don't exist, or negative error
+ * code on failure.
+ */
+int of_genpd_remove_child_ids(struct device_node *np,
+			   struct genpd_onecell_data *data)
+{
+	struct of_phandle_args parent_args;
+	struct generic_pm_domain *parent_genpd, *child_genpd;
+	struct of_phandle_iterator it;
+	const struct property *prop;
+	const __be32 *item;
+	u32 child_id;
+	int ret;
+
+	/* Check if both properties exist */
+	if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
+		return -ENOENT;
+
+	prop = of_find_property(np, "power-domains-child-ids", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	item = of_prop_next_u32(prop, NULL, &child_id);
+
+	of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
+		if (!item)
+			break;
+
+		parent_args.np = it.node;
+		parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
+								  MAX_PHANDLE_ARGS);
+
+		if (child_id >= data->num_domains || !data->domains[child_id]) {
+			item = of_prop_next_u32(prop, item, &child_id);
+			continue;
+		}
+
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		if (IS_ERR(parent_genpd)) {
+			item = of_prop_next_u32(prop, item, &child_id);
+			continue;
+		}
+
+		child_genpd = data->domains[child_id];
+		pm_genpd_remove_subdomain(parent_genpd, child_genpd);
+
+		item = of_prop_next_u32(prop, item, &child_id);
+	}
+
+	return (ret == -ENOENT) ? 0 : ret;
+}
+EXPORT_SYMBOL_GPL(of_genpd_remove_child_ids);
+
 /**
  * of_genpd_add_device() - Add a device to an I/O PM domain
  * @genpdspec: OF phandle args to use for look-up PM domain
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f67a2cb7d781..b44615d79af6 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -465,6 +465,10 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 void of_genpd_sync_state(struct device_node *np);
+int of_genpd_add_child_ids(struct device_node *np,
+			   struct genpd_onecell_data *data);
+int of_genpd_remove_child_ids(struct device_node *np,
+			      struct genpd_onecell_data *data);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -534,6 +538,18 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline int of_genpd_add_child_ids(struct device_node *np,
+					 struct genpd_onecell_data *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int of_genpd_remove_child_ids(struct device_node *np,
+					    struct genpd_onecell_data *data)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM

-- 
2.51.0

