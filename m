Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AC2D5408;
	Wed, 14 Oct 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980479; cv=none; b=tbczHHOHWATzOIigokW4s3OgBGdv05GDuHxUqkAAFDSMxnI1LC+PBxdl6/AXqb80ozNoCo712Y5N+m0IzQGVFjYrBt96UUkxFkJIVQQitPdiq0oznuYM105OUFlAD5hLWCy3Vbcb/3+l+htpJ9P7bUFI8qzKR9tdzUOZp0ivCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980479; c=relaxed/simple;
	bh=DM5MYBNl3JGDhDQ9QhF3Zj7v13P6GaMIqUHlP/frmlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYtukfwPFgxqjN3UvsQae+2qHIlUkc9+1qLg1WDt/Yy1S2qa5XBmoAoVAssB2kJoMqn8E29ztJvuIZr8HVMVqagqWyJZk3pWKjnqEIN9D1/Kewd/JyWtgdSzYqZ+y68+l6QlpcwpZyH8r0X9O83////C3GctGVciWkOYMy9PdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr70URGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr70URGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9931F00893;
	Wed, 14 Oct 2026 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980478;
	bh=nh5alTK4xrJTENPjV1WZHzTMgyOk1csc/UDMlXRrT0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vr70URGBCJrK+JiWzeizOjNHGwVJ3eAfUqPdbWnAH8/di4fI6C+StITkek2U8jS5I
	 rPUMqf34NFdpBtOAjP4JQaGcEUMaiQGv3mwa81qS0zD1MCYthXC52y7R2/ypkvfMyP
	 LJIEjajpddMdyLPI05VRLTwTpIA9BwC0iRKJ/jPFBijyg0FD0Hnaqdcas6tTEoFmlc
	 SDbeD/vUM9K9J0F4A3LzoBuQFf2GUnTBkkMHwRGTaENtAKWd+YWuTLIRWbq5fY9VE3
	 6chSIcXgLp8c3cePr/A1U0kilcP4QMqrne5c2GPRMtya0OAjv7kODJgXDFSj6i49yH
	 SU59bXJLJH76g==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:05 +0200
Subject: [PATCH RFC 05/16] pmdomain: core: Support subdomains without
 pstate propagation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-5-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=5574;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=3MgVPdpSwtTbln/x2FF2QgeE6U02v2wn9JHrhohqpn8=;
 b=+4SiRyE+EY15kiFNd2AUP7GVXbDYQwYD0rNdCIxPb9ytTO5U6p0UTpA2JeAfz5+UaergjVKRk
 XMxIrxCEe5/A6vw16lR8swqkmg/aM2m8+DAkU5i9xzNs7a6c0U0rpB3
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A subdomain may need its parent to be powered on without requiring its
performance state to follow the child's. GenPD currently couples these
requirements, so increasing the child's performance state can also
raise the parent even when it only needs to remain on.

Allow subdomain links to opt out of performance-state propagation while
preserving power ordering and active-child accounting.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pmdomain/core.c   | 32 ++++++++++++++++++++++++++++----
 include/linux/pm_domain.h | 14 ++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 76ff0d9a229c..80ea70930cc6 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -463,6 +463,9 @@ static void _genpd_rollback_parent_state(struct gpd_link *link, int depth)
 	struct generic_pm_domain *parent = link->parent;
 	int parent_state;
 
+	if (link->flags & GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION)
+		return;
+
 	genpd_lock_nested(parent, depth + 1);
 
 	parent_state = link->prev_performance_state;
@@ -484,6 +487,9 @@ static int _genpd_set_parent_state(struct generic_pm_domain *genpd,
 	struct generic_pm_domain *parent = link->parent;
 	int parent_state, ret;
 
+	if (link->flags & GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION)
+		return 0;
+
 	/* Find parent's performance state */
 	ret = genpd_xlate_performance_state(genpd, parent, state);
 	if (unlikely(ret < 0))
@@ -2257,7 +2263,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_genpd_remove_notifier);
 
 static int genpd_add_subdomain(struct generic_pm_domain *genpd,
-			       struct generic_pm_domain *subdomain)
+			       struct generic_pm_domain *subdomain,
+			       unsigned int flags)
 {
 	struct gpd_link *link, *itr;
 	int ret = 0;
@@ -2265,6 +2272,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
 	    || genpd == subdomain)
 		return -EINVAL;
+	if (flags & ~GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION)
+		return -EINVAL;
 
 	/*
 	 * If the domain can be powered on/off in an IRQ safe
@@ -2298,6 +2307,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	}
 
 	link->parent = genpd;
+	link->flags = flags;
 	list_add_tail(&link->parent_node, &genpd->parent_links);
 	link->child = subdomain;
 	list_add_tail(&link->child_node, &subdomain->child_links);
@@ -2319,16 +2329,30 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
  */
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *subdomain)
+{
+	return pm_genpd_add_subdomain_with_flags(genpd, subdomain, 0);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
+
+/**
+ * pm_genpd_add_subdomain_with_flags - Add a configured subdomain relationship.
+ * @genpd: Leader PM domain to add the subdomain to.
+ * @subdomain: Subdomain to be added.
+ * @flags: Subdomain-link configuration flags.
+ */
+int pm_genpd_add_subdomain_with_flags(struct generic_pm_domain *genpd,
+				      struct generic_pm_domain *subdomain,
+				      unsigned int flags)
 {
 	int ret;
 
 	mutex_lock(&gpd_list_lock);
-	ret = genpd_add_subdomain(genpd, subdomain);
+	ret = genpd_add_subdomain(genpd, subdomain, flags);
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
+EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain_with_flags);
 
 /**
  * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
@@ -3271,7 +3295,7 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 		goto out;
 	}
 
-	ret = genpd_add_subdomain(parent, subdomain);
+	ret = genpd_add_subdomain(parent, subdomain, 0);
 
 out:
 	mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 98aca4a4aede..322453da7fae 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -277,8 +277,12 @@ struct gpd_link {
 	/* Sub-domain's per-master domain performance state */
 	unsigned int performance_state;
 	unsigned int prev_performance_state;
+	unsigned int flags;
 };
 
+/* Preserve power ordering and accounting, but do not forward performance states. */
+#define GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION	BIT(0)
+
 struct gpd_timing_data {
 	s64 suspend_latency_ns;
 	s64 resume_latency_ns;
@@ -323,6 +327,9 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
 int pm_genpd_remove_device(struct device *dev);
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *subdomain);
+int pm_genpd_add_subdomain_with_flags(struct generic_pm_domain *genpd,
+				      struct generic_pm_domain *subdomain,
+				      unsigned int flags);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 			      struct generic_pm_domain *subdomain);
 int pm_genpd_init(struct generic_pm_domain *genpd,
@@ -367,6 +374,13 @@ static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_add_subdomain_with_flags(
+					struct generic_pm_domain *genpd,
+					struct generic_pm_domain *subdomain,
+					unsigned int flags)
+{
+	return -ENOSYS;
+}
 static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 					    struct generic_pm_domain *subdomain)
 {

-- 
2.56.0

