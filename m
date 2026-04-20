Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C137D135
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729088; cv=none; b=QY7LajrSY+DEomPsEKvEMZ4Dk/7xpRy6lME9yAynRMhugd+K6aKCgfkXD1BAmgAbxFuO1rPCR0DXwo4OKYQJbDq+LmqphvK2QTF/Q0uKu2z91NJPYgmV9jIS8ttHLW0ad/7m0HRuBjBlhlMe5oxmjo+vnwA6pRhNgW+oO/ShkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729088; c=relaxed/simple;
	bh=AJAxCQJaWoA/4dBEUCt/1XgQiiTMcAO9mItznU/aNFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+9WonYzgA1OMGf7Dn/aR4o/40d/4ntu0HQwx/BVXRIyRvakW0qDC/CYgsbTWw8YZxjT4spcW51YRaS0YfZ0ZdJ70MPS/MRByYXAYBQODcgNFCYlNd9JsuQJt7ueho/aSEEKd09LSGjXHS5v0oqW7iByJA1x4pvRNQH1joP72Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=O2S0d5QX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="O2S0d5QX"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so1403795a12.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776729085; x=1777333885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMwNLBTWs20Z4a1mhT5Vdgx1QV1o4tHwHoJ1DhdYYC0=;
        b=O2S0d5QXR4f0ph6bivk11ifji9VOW3YsYz8rOWSIsOUtClGC5lW5UOoxxqtDB0tY76
         JCf02Oum/PWaDdQwk/eD0I+TKl6b6rEd7PpezUzvpimqnwhzGLflkfOGJXmQMh2+bvaO
         btkikm8lJzyMBNvamgAwKnL866ssl5wEA+DhfRoZJ0CNZSEu/9UNDQB0wOhP+6GE+uJe
         4nVvNMuts9EZDlAN6jJIQO0bgnQg1osR8KcfTJouo1SuZWpDj2WYGF3chJVc8WE/abJk
         AnOsaX7eAM7hoar7aofi41Kx4HKcx47d3QIehdjLFA4jRjg5MjOdiJPsndRMnehPhgpC
         gsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729085; x=1777333885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XMwNLBTWs20Z4a1mhT5Vdgx1QV1o4tHwHoJ1DhdYYC0=;
        b=CGrcEHxu6gH4yyLgZm0ZjDs9tEWhn3JhQcnvnDW4c40gvr0HZcsES5ggAAMBwR+KKx
         iuaN5fNu5h4izasLfphM2FntwpKQ797inXS1OSlcrKm8/TTJTjkPQ3HS5MejW62x0g+j
         gYi1ro8FAwVqZ7mcOg6qdkJi54UZhqpAwv0kPHZApcZ3W7kOOrrGFbTFLmjo8JXhjRE3
         zkeg2lqoDMyiYdY2ddnu0yM3k1N5Os+f2kMfwK7TdIG3D9euKAHq/W/5l6olah65HHOi
         ufVf5jZfgbQ3YqdiEG/U77Z6z6g4EBD6n99SwR+MSefHmvISkjP2LiFz245CGo5nC3Mc
         AbFw==
X-Forwarded-Encrypted: i=1; AFNElJ99Q9MaJOam2UrpKP7VolWaP7Sbw86f+bc/ZOyfpoj5QPzBCMjj+3VbY2FTz8iLIa4D1RhzyhXMkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjGnV+BkEq0vMEMHsDNtY5CfoFv8jO4G3xNHZVHZA9xKthZrG
	2leA+3oLc1WO/ht4X/sxtXw+rmaYJjGr3xKHTZqRJEMY8Opm4kGXMBU7NGFCOnIhcts=
X-Gm-Gg: AeBDietVHa3UK+JOX91TRCyZJLwCH6JP8OYbET0ZeRzuczhIWRJYFq2n3QtUVeL4NuZ
	2ekSFVAjqrEzz2H9nRJioAAulICl3G+v9oJDSFWW5D/L9JF+69CM3fZgJ1+CtsIHEDdZi/HCfEw
	zL12rY5ryb2Eprn9oMHYZZ5MzbOG5UrkQF1ThXuinb/CLzSvToCZ/CkHWylzTIQaP8vfMIecTXr
	BgLCwCjJhLXFiwoYvnoN8vGy88p+souLDVs0wdLBD4FO2yl7tMhn79CksAR8wM/r0udyNRj0G8j
	dahXyhRtfreW8IyqtnKalz720OVOpM2ru20hYxpj4fZwDJ8/eQmuXjkz+Ucfj8pv9vJYcUA1F0K
	kr4OGQd9zpuMdXQkZ0TYS3uk9IL0HD5HLaJTurjO/R2Dapi6Pd2AgS9u2ZSrSJW7l/qXTGzUhlr
	pm/MZL1gO2Ik0rdqAOWVrA2VYez5COGA==
X-Received: by 2002:a05:6a20:4324:b0:398:c351:aa0e with SMTP id adf61e73a8af0-3a08d7aaef5mr16353897637.25.1776729085329;
        Mon, 20 Apr 2026 16:51:25 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8fcbdsm8701643a12.6.2026.04.20.16.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:51:24 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Mon, 20 Apr 2026 16:51:18 -0700
Subject: [PATCH v3 2/3] pmdomain: core: add support for
 power-domains-child-ids
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-topic-lpm-pmdomain-child-ids-v3-2-c2c40bef238c@baylibre.com>
References: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
In-Reply-To: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8659; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=AJAxCQJaWoA/4dBEUCt/1XgQiiTMcAO9mItznU/aNFk=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBp5rv6vpqm0H64AdXGyGr6LuEuvzEUtEWUspmmt
 x7x7wBcYdyJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaea7+gAKCRBZNxia0/vG
 ZaxVD/0bUSM94rccXv8PpC+2wx3taiizU8xLxUqSv0zq+L5JxFKRxGolyFoYnm6mH88UVGkJVAC
 fthcHrH3KOuNSjjzaIAjVsHMLrSWP5oxdmDw88EejlrkqcgIu1QG5eXHN5OzH71m79XT3Gmfa9E
 QwsMsty5CXxzFUo7VqnHTpMWdbhxapy4dOdM0uCFp9a6/q74lMMcH2v5YSeqGWpYgRTyTTlDIzR
 DYTfXnszo4pQPa1Z72QHLAsj+/gClNfCqsEjvNhv7A2SxboLVl5U89baEk7NuAnQ9IeHjeKnBJq
 s5HQ2Dgc1uK/pKAsOya9DShUfxTxsJwbO1VGF4rFmJegsoM8TbFMAYw6rZL6+O7MVRM3JPxEKwE
 wU70Lp52lb7CdDzrHb6Z2xMI01lLJXJKtdn9pDpxG/R4ks8OkkUu5UBaFRWKP0wdEdK83hRRu77
 dVxy1T5XwcHEV0bV/nW9l2V+97LdrTf87n193jrkKDr9vT4MhEwbbJKjqK5LPyos5FsI4ch3Dmr
 fF3VUVHc+cYzpjHLrnw0DjanUGPMwlMS7NvsoYcq6O/+6eX61rsIuB6mRHt0vKIdBvNpLGDy3eY
 4AL3Fe9ysLBRpPjahNqEgLM445u0SLBWOZQRJWMUZKHI5eOAtrnGH4hmNRBusS5AXDx0wUPbl8D
 6/1Ve4kEobjKy+A==
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

The add function is "all or nothing".  If it cannot add all of the
child domains in the list, it will unwind any additions already made
and report a failure.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/core.c   | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  16 ++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce3..97498a37336d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2909,6 +2909,173 @@ static struct generic_pm_domain *genpd_get_from_provider(
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
+ * Uses "all or nothing" semantics: either all relationships are established
+ * successfully, or none are (any partially-added relationships are unwound
+ * on error).
+ *
+ * Returns the number of parent-child relationships established on success,
+ * 0 if the properties don't exist, or a negative error code on failure.
+ */
+int of_genpd_add_child_ids(struct device_node *np,
+			   struct genpd_onecell_data *data)
+{
+	struct of_phandle_args parent_args;
+	struct generic_pm_domain *parent_genpd, *child_genpd;
+	struct generic_pm_domain **pairs; /* pairs[2*i]=parent, pairs[2*i+1]=child */
+	u32 child_id;
+	int i, ret, count, child_count, added = 0;
+
+	/* Check if both properties exist */
+	count = of_count_phandle_with_args(np, "power-domains", "#power-domain-cells");
+	if (count <= 0)
+		return 0;
+
+	child_count = of_property_count_u32_elems(np, "power-domains-child-ids");
+	if (child_count < 0)
+		return 0;
+	if (child_count != count)
+		return -EINVAL;
+
+	/* Allocate tracking array for error unwind (parent/child pairs) */
+	pairs = kmalloc_array(count * 2, sizeof(*pairs), GFP_KERNEL);
+	if (!pairs)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		ret = of_property_read_u32_index(np, "power-domains-child-ids",
+						 i, &child_id);
+		if (ret)
+			goto err_unwind;
+
+		/* Validate child ID is within bounds */
+		if (child_id >= data->num_domains) {
+			pr_err("Child ID %u out of bounds (max %u) for %pOF\n",
+			       child_id, data->num_domains - 1, np);
+			ret = -EINVAL;
+			goto err_unwind;
+		}
+
+		/* Get the child domain */
+		child_genpd = data->domains[child_id];
+		if (!child_genpd) {
+			pr_err("Child domain %u is NULL for %pOF\n", child_id, np);
+			ret = -EINVAL;
+			goto err_unwind;
+		}
+
+		ret = of_parse_phandle_with_args(np, "power-domains",
+						 "#power-domain-cells", i,
+						 &parent_args);
+		if (ret)
+			goto err_unwind;
+
+		/* Get the parent domain */
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		of_node_put(parent_args.np);
+		if (IS_ERR(parent_genpd)) {
+			pr_err("Failed to get parent domain for %pOF: %ld\n",
+			       np, PTR_ERR(parent_genpd));
+			ret = PTR_ERR(parent_genpd);
+			goto err_unwind;
+		}
+
+		/* Establish parent-child relationship */
+		ret = pm_genpd_add_subdomain(parent_genpd, child_genpd);
+		if (ret) {
+			pr_err("Failed to add child domain %u to parent in %pOF: %d\n",
+			       child_id, np, ret);
+			goto err_unwind;
+		}
+
+		/* Track for potential unwind */
+		pairs[2 * added] = parent_genpd;
+		pairs[2 * added + 1] = child_genpd;
+		added++;
+
+		pr_debug("Added child domain %u (%s) to parent %s for %pOF\n",
+			 child_id, child_genpd->name, parent_genpd->name, np);
+	}
+
+	kfree(pairs);
+	return count;
+
+err_unwind:
+	/* Reverse all previously established relationships */
+	while (added-- > 0)
+		pm_genpd_remove_subdomain(pairs[2 * added], pairs[2 * added + 1]);
+	kfree(pairs);
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
+	u32 child_id;
+	int i, ret, count, child_count;
+
+	/* Check if both properties exist */
+	count = of_count_phandle_with_args(np, "power-domains", "#power-domain-cells");
+	if (count <= 0)
+		return -ENOENT;
+
+	child_count = of_property_count_u32_elems(np, "power-domains-child-ids");
+	if (child_count < 0)
+		return -ENOENT;
+	if (child_count != count)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		if (of_property_read_u32_index(np, "power-domains-child-ids",
+					       i, &child_id))
+			continue;
+
+		if (child_id >= data->num_domains || !data->domains[child_id])
+			continue;
+
+		ret = of_parse_phandle_with_args(np, "power-domains",
+						 "#power-domain-cells", i,
+						 &parent_args);
+		if (ret)
+			continue;
+
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		of_node_put(parent_args.np);
+		if (IS_ERR(parent_genpd))
+			continue;
+
+		child_genpd = data->domains[child_id];
+		pm_genpd_remove_subdomain(parent_genpd, child_genpd);
+	}
+
+	return 0;
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

