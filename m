Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5B38944D
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775864696; cv=none; b=VvAcHjvFg57PqfxYeK3QNa3VBOzhDeJIiaWLPjyfIRctSGTquQoDxoSPoTN+2lxUOGEU0d84j0H1nvqXeV/x2puoQMcJ9uPeotAHPmRhpuHb4ek5G4y4U161Q3XVuF56wSrjLxkK8h4jCJxIlNDhXuowYG7AV3mBlk6yaMwxmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775864696; c=relaxed/simple;
	bh=mBjWuQi/HGwha5ym3E4fgVBst1esK2Mr/oGnli4oYYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjYSgisJaLQXPXy3Rn05Hu03q83yE2bjiJDDIrNmZyk6hzG83/btjE2ZZruz2IIyTfNOIWUY//pMM24jIJxgIGNUv3ICFnAYU7VrwRQ9O8h4xn2Zcc3cWSQhsQ4L2nX/I3O44MXAPZegoBNE8zD0iNVxrrDyG6vgWtufOcfV6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=YEYRercQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="YEYRercQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2495997a91.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775864694; x=1776469494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fL3GNwfZ1nsisPUDCuJfqwmmtNAVNx2CIYyMLfPb2w=;
        b=YEYRercQhT39fTi1QOwcrn9GQupLUkcew70TfOLVF+nCxX+kaYPxdFATD/Dbqu3aZJ
         a9v8YsXLszzs75qL4AE2n2JHGr421rxKN2jSsuiyHcMa+N3Pe3GvZyOktKfNZ0+L2cKy
         Obi/YFxiIhMX2rBBYQvIU3A+1UF9KSdnVFufSPEM4EwYpnJUNZKRoEyEoTDAZAMxqbHn
         Zj8pDX5jmDN5JCLcSP8QXV+iIiNcAaKMXXzXkY+SSvrOp8+fn+WD8LCn7p0Z/3j3IYF7
         zqZynrCmGc/IxEQ5DAB78TYjHU6yKbgsG1Nz4jpFR1Qvab59pjmdYF4i81JuHdttpKdV
         rJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775864694; x=1776469494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fL3GNwfZ1nsisPUDCuJfqwmmtNAVNx2CIYyMLfPb2w=;
        b=qAixUkqAl/Bvr/mzBiiFNr/ehuuG/Wr7AU7sEZk/yMwVU5TUUuseLCJl4wZpR/te0R
         nhkDtGPFhrh535aY68L7BqEEydo/7oiSADsBwxj8txoSHSoJJSjxe+ZLDt92m2s4kGmG
         OFIt3OomJzSuPMB42R9/EcUdJpFpWC32yixx9CSyLZcTTzp3wOb6Mdg/cisF1cxLXDMy
         WmMNwjJY5rsj6KpIdSMFsz4tuM5fdSGxVnEYZS1k72e6pwKGndzvLP5AJcoItmVHMQMN
         VkNYmWHE/6C4Nj6eDhNrZ/4LIq/4LF/43H6lEyj5E3Q1CEhKhUctxNDj7OP+n2Ma35gV
         gTMA==
X-Forwarded-Encrypted: i=1; AJvYcCX1XwFA6DFHUyzeYGNW10FIpp1318kqKM+jsB9cZz0cCA8T7CDd6aat9ioxO/yhy10Zzb6JZPgMJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJP0WEMD5grUYxpxgy0kVPEC5VAbfzc7zpiX8Z6H3PAGs8Bm+
	5BbhV3ShDdKfzFprbpT8RREErJvQ4JnIbM6jBE+X2ItIQQYH6H+hOLhIWCReu/TPXAc=
X-Gm-Gg: AeBDieuuvc1jlyVgV/M8ixJwGnSMqto5Zllyapfl8Wlz858ceSGX4OM1wp/FUC9R/BK
	CtBa83+93XL5korXqMzlFCmOKFdCJGFeDhiQMX7IMQTLLdMI5SBliORjCfj5RIdy/6xyE0MT3db
	SUWPcGQ7kx4HGuIOwa+GW7ng5+BS5EjUuJD8k3DhIPIpx7CK9rc2UJudgvYentqlZStjogwnwxe
	ZDDvVhdATnQzjt40Sc4UbhBAmfad8izUeGbffOZfCyOE84ExCkrUFTwTWcC9fHuuVaZhINZLKxW
	tVrL52gP46dxaTaD6SoL2mXF6c9X1DCn/hk13uXSBn08PTRL1JOHRUyw19UoFbZdG8Fx7BU9AM9
	Ap2fCq6yJ4R6sjKVMYnc64Vqv4BYVyx/2Qdnu3w4rdXVGjqwBSn9KQu+1AkKKSYKV9HcOEa3ebg
	GbAAzIboIei+jXWgpNiWbzi6Eqn56N7g==
X-Received: by 2002:a17:90b:3ccd:b0:35b:9ab6:1d4b with SMTP id 98e67ed59e1d1-35e42846246mr5553462a91.20.1775864694213;
        Fri, 10 Apr 2026 16:44:54 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42db1b51sm1766213a91.3.2026.04.10.16.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:44:53 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Fri, 10 Apr 2026 16:44:37 -0700
Subject: [PATCH v2 2/3] pmdomain: core: add support for
 power-domains-child-ids
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-lpm-pmdomain-child-ids-v2-2-83396e4b5f8b@baylibre.com>
References: <20260410-topic-lpm-pmdomain-child-ids-v2-0-83396e4b5f8b@baylibre.com>
In-Reply-To: <20260410-topic-lpm-pmdomain-child-ids-v2-0-83396e4b5f8b@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8599; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=mBjWuQi/HGwha5ym3E4fgVBst1esK2Mr/oGnli4oYYk=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBp2YtyQkv9A8zRsOwGZF+JZjPXQaBYJzu6eUYGq
 rH+XEE2lX2JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCadmLcgAKCRBZNxia0/vG
 ZbZ9D/9QG6dV9icaKXFsVCK8sPfQLATnm6mg1puEFW+8wV9eXzTFJ3TFjHdCvkC+ZCLVI51S6qo
 pQnENkg/SxGUVGrFXWUtAreTjBzUgpIKmHEgTsjRw/15fNtz3rW5qRDAM+qvG33QCxBTxDLWp7a
 FLDfj2NFDoqNyXSjUA0op74x9XDuAkKq0HllBxwWxWFzosNooe+0728Uezd0KQmd97sYFKhS7we
 XsIiV6mop+XMczwGXw+IzmY6pTVXx9GJoGj8S8Br88PDZ2JFNhqMoxuqBXZVs70cOGMD1cTV5dT
 80GIUo1BQZSSjPFBz0OCjpyEq8zjhfjZl5jFLBDaY5b5G8YeAFBl82XeDWzx424vZqZIw+Sr9un
 zwN14y4Hfd+3v6YOLRjkwtfzyeJT7vcS3cFIWGCML13YKNxaG5oZLH8SgWyjSwD8412mm+eiJUV
 pVGa4yTJOI+R2noGqdyn+KZfTzR3Cxrj1/MQ8TI2Xl3dCu9RooHmpwygpy/Ufsg776l4+7eSoY2
 mXVRYE+GJk0308bxjUhjEUbXLOijCYzH6OMvQYQp/8bmJ93tET6Gn4C2hmGGXcPfzi2VVMQGjFI
 pB/i7USbCoxR34jnJEMnmU51yAA+NoXUeM8wuPOZM6SZeX0AtLPS5OZgcxDl0gdj7IYmCnspBqo
 eiOAP6LhVm+7f2g==
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
 drivers/pmdomain/core.c   | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  16 ++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce3..f978477dd546 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2909,6 +2909,172 @@ static struct generic_pm_domain *genpd_get_from_provider(
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
+ * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
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
+		return -ENOENT;
+
+	child_count = of_property_count_u32_elems(np, "power-domains-child-ids");
+	if (child_count < 0)
+		return -ENOENT;
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
+	return 0;
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

