Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FC427F8E
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014141; cv=none; b=CaYxVKvKNYaxmXypL68nF+SwX7R2imaGz+DCAHk/DZ5I6g5S7DMpZZ/3QTqvIc1Lmb2xtA3yDnNdkpUzk7NpLQei1ZpJRiZ78OxALvuPgPquMJm7OzHfPL1uR5dInfPL2CopA7o1DWuHYhnsAfw3YCU50WkZ5hEGnJj2aPwhgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014141; c=relaxed/simple;
	bh=r8Gnr1+T9r7J2+wuhx0yw3OuTJgTw0C5QxW83obdyic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYBYJUCJShXIHV8C4Nqv54ucmErY2ll5zLMG1csPQ5/3Ql2qjdhWMgc4EYjfgMXy8FvV52JY8GjNyyNeeGPMX12NbqbcrYKl0Tv6CDR1HpnXk4h0NWPpYx0kzmURJkVdjjfXvdtgvJ23hX6qBn+3dQtKA8ZFb9ueNNtNWOq8Je8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgJ8mGu3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NdtVcsLd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgJ8mGu3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NdtVcsLd"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nfMG865624
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 11:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JpV5+FuyfSk
	2NiHdf+Bry5eOP6QolE5Yf8x3iNNSqIA=; b=pgJ8mGu35O0r7cDOANuk5PfjhFn
	NWKTqhEoaujEVM0DeVik7Vl9PwVHC9b202I6CSNHDaZbFXtzFD+NkH3mSQRLU/Le
	gGxzFE4Bkh5zQ/SSOURAtazLsma0/h8hptr4JT1kzqTe65zaoJIyx1PNE7Vocj1p
	jejXjT1lW0EJHygY+IWjhD6me+iEZbaYl7xy45mZizKwpONwYFmUXbG6Uvens7s2
	uAemE34PkBu2joz3HlnjVfntfSCZ63K94zYIJZsFDSICuWVrMfltPnJwkMHxkhw6
	a+jG5vcvywbwMtNi+aqjNJ6pjphM75/XmnZBVGNJU7c+Ns9l9XjoL7UPzgA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5btdd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 11:02:18 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-82014436716so56386017b3.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786014138; x=1786618938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JpV5+FuyfSk2NiHdf+Bry5eOP6QolE5Yf8x3iNNSqIA=;
        b=NdtVcsLd783fPlds6GQiMeeli4xRos/ImpVjhFor0a6xzMPmHcQvhxkeQTSsZs61oh
         bj+58ZuGlmXBZIXOS3vSX1LmSUfbZYRWnd7s5FqRtUtszvNzS+E93HjRuBTGnU8K9z+q
         aiV9tHISb9A2mqKTQEuo8dG+lH2WJE1YbZHF1Zf1R7EqbJeE8Ul6NytZQUOaHNBAiOHO
         M/HCO1N2zxRuWQYQn2FahtREAKrARK4iLMXuU94f3QMBCeRZ1hPmeCwbeCpe9eKigPiR
         d/u3BWvkDsLskOUmE5A9kzS+psXiHViNiOmfYTRQ0Uy8mJM7cO1v6ubasJG26wnLIuVl
         4zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014138; x=1786618938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JpV5+FuyfSk2NiHdf+Bry5eOP6QolE5Yf8x3iNNSqIA=;
        b=h400KezzGjregCNZ3If3dfAEL9UuuE6CZ+fvZKsUTugWv0Y1i49BYPXgfjkYXiyLYc
         O26Pwgjt2T9QGhfRqBkl2DF5Ll1iKurpOKaLFr8M6wwqCz4cb0chCn+HEGuOypTxqlIE
         6DLcftC+gL97DRvjPwwCDZt3FPi0wlD+i8FbrEfWLn7y21IIKeVGR3rJ/vnuSofWSRY8
         70jOUVr8Ya4pggk5P4nz7OMdZ4tox6t0fjx2giU6kv5nJRPMwcmnDM2QAQYHKSPlbC+f
         NAbuinxW3TXT8QLItswZ9CAuaXXqJT1SSSuwnKSClPC08xDwXrzQp6bIIA09UKmBEmdw
         4x3w==
X-Gm-Message-State: AOJu0Yw1+5GgVnG424CnWzXyvzi7AzWc+XYtI7MPolGf2bHYen3LZLY8
	rAjtfwhy+LVzqOrmXuTEBTSKRMlxv8AgoXIJP9Dox2pmu+P9ZB9m5CXDB+yEUrdG1OEyQ31a2/J
	xzpKjyEU4v/cOgCGK+bzp8JX5EzFNTtt/vBU7fPG86vB666YN6xCd3LOKBZ0H9g==
X-Gm-Gg: AR+sD10CL4CyLYtO8NHu/wMaCRzDWah+UR5UR97h8rUc9s/wwtjvZUrNcidEbvc4fNC
	9nf+VzQoqCN6ogb4N5Zsi4X1DHtV2TQit7qPf6uDfBxH4LWTvz5sCuOibPUPAxbv5Aee8928NS7
	FS9mI/I7+ZQhsp8DnyDQAHwBK4r3xbuCIZK8YzCC7EUO7KJemwaYc5M97A/wFVZuzFsloiqYGCE
	l40fzBSSTwydP2Pr2UKO6NafHnQG/g6VJH6fbnKPyxn4QvLqfNoa45Brsdgh3FXOOGDHGTkSqRG
	1krMJGf2jCap+NpBWAoVdWW9cfA5K123hwurckIFuho1JBiz1jWxH2Qp5V98Cuh7tc0hyhwlcGF
	CzgdrnquIkwpLjDrO+tc=
X-Received: by 2002:a05:690c:b85:b0:81e:6cd1:5329 with SMTP id 00721157ae682-8202275ac60mr82831087b3.34.1786014137624;
        Thu, 06 Aug 2026 04:02:17 -0700 (PDT)
X-Received: by 2002:a05:690c:b85:b0:81e:6cd1:5329 with SMTP id 00721157ae682-8202275ac60mr82830557b3.34.1786014136982;
        Thu, 06 Aug 2026 04:02:16 -0700 (PDT)
Received: from juillet.lan ([2a01:cde0:108:24ed:1501:7670:a13c:4834])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131db335sm36808917b3.3.2026.08.06.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:02:16 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH 1/2] powercap: Add generic zone hierarchy creation helpers
Date: Thu,  6 Aug 2026 13:01:58 +0200
Message-ID: <20260806110159.69690-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h1lM0hitcGjJHnr48WplqrA6wNg1y56Z
X-Proofpoint-ORIG-GUID: h1lM0hitcGjJHnr48WplqrA6wNg1y56Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NyBTYWx0ZWRfX8/dq502g0Kxz
 /3bah0My7QggVfsXBx+MB7Tck7aYjeuII9N4//65Sftt7w5aUHGscF56rV/MccaagjWOrUWfMaU
 42xdKxE+9u+DBGrng1ZLEvv4P6Ly3GE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NyBTYWx0ZWRfX9yR5uWAo3mG7
 unqy2++ZCyH0poiC7Uc5LiV8tRd4Nj2drr2k4ZZidd5Nn01Vh4RMP0kAzM4AvB/D5KlTdpmnpVR
 boDWvCi4UUKcwSVdagw4bhQzicDt9Ycia8NYp8cgMRgaFVqUaDxC55ax7Wq6yC3f14YXOW96+mY
 7yZ7tKkS4eip1epEerJ/Phk46caWNpEJZwsyT/OcTbk8peuaDhB/aC8WOnS9EtwauFaVNA8nV1x
 CSKpulyHp7TMAspYx2U9OHvG9PrjIjPTzj55ixr0JWFoIpSsmpQMjkDtnLwmqBKyDmDWuGBhA+d
 ZnHHJWch/s7xR2/1wmDP1QHUlwGZLMRp1E+o/+MxDgHJyCjM3hw7a+6Pz0xEYC2o2m9579Lwv8e
 z4zU/8wowZxG7VXyFFuLmu1w3xZi6C25f0BW1vyLMq7lrbrotLinN1ZfZwovtwa7YORidfMlN1A
 x+Dx99O64FNFJC1Iubg==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a7469ba cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=jGdnt-AriNhNVhWiu9AA:9
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060087

Powercap controllers may need to create several powercap zones organized
as a hierarchy. At present, each controller has to open-code the
hierarchy traversal, parent lookup, error rollback and reverse-order
destruction.

Introduce struct powercap_hierarchy to describe a powercap
hierarchy. Each node contains its name, parent, backend-specific data
and the powercap zone created for it.

For example, the following description:

  static struct powercap_node nodes[] = {
          { .name = "package" },
          { .name = "cpu", .parent = &nodes[0] },
          { .name = "gpu", .parent = &nodes[0] },
  };

  static struct powercap_hierarchy hierarchy = {
          .nodes = nodes,
          .nr_nodes = ARRAY_SIZE(nodes),
  };

creates the following hierarchy:

  package
  |-- cpu
  `-- gpu

Add powercap_hierarchy_dup() to create a runtime copy of a hierarchy
description. Rebase the parent pointers so that the copy does not keep
references to the original array, which may be stored in init memory.

Add powercap_hierarchy_create() to walk the description in order
and create each zone through a controller-provided callback. The parent
zone is passed to the callback, keeping the node creation operation
specific to the controller.

The backend is responsible for allocating and registering each powercap
zone from the creation callback. The powercap_zone object is expected to
be embedded in a backend-specific structure, allowing the backend
callbacks to retrieve their private data later using container_of().

For example:

  struct foo_powercap_zone {
          struct powercap_zone zone;
          struct foo_domain *domain;
  };

  foo_zone = kzalloc(sizeof(*foo_zone), GFP_KERNEL);
  if (!foo_zone)
          return ERR_PTR(-ENOMEM);

  foo_zone->domain = domain;

  pcz = powercap_register_zone(&foo_zone->zone, pct, name, parent,
                               &foo_zone_ops, nr_constraints,
                               &foo_constraint_ops);

Its allocation, private state and lifetime remain under the control of
the backend.

The creation callback therefore returns the same powercap_zone pointer
that was passed to powercap_register_zone(). The hierarchy helper stores
this pointer to provide it as the parent of subsequent nodes and to pass
it back to the backend during hierarchy destruction.

Add powercap_hierarchy_destroy() to destroy the hierarchy in
reverse order, ensuring that children are removed before their parents.
Use the same mechanism to roll back previously created zones when the
creation of a subsequent node fails.

Serialize creation and destruction of each hierarchy to prevent
concurrent updates of the powercap zone pointers stored in its runtime
copy.

This provides a common mechanism for creating controller-defined
powercap hierarchies while keeping controller-specific operations
outside the powercap core.

Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/powercap/powercap_sys.c | 148 ++++++++++++++++++++++++++
 include/linux/powercap.h        | 178 ++++++++++++++++++++++++++++++++
 2 files changed, 326 insertions(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 9197fa20d93f..fefb36c5bcd2 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -667,6 +667,154 @@ int powercap_unregister_control_type(struct powercap_control_type *control_type)
 }
 EXPORT_SYMBOL_GPL(powercap_unregister_control_type);
 
+struct powercap_hierarchy *
+powercap_hierarchy_dup(const struct powercap_hierarchy *hierarchy)
+{
+	struct powercap_hierarchy *copy;
+	size_t i;
+
+	if (!hierarchy || !hierarchy->nodes || !hierarchy->nr_nodes)
+		return ERR_PTR(-EINVAL);
+
+	copy = kzalloc_obj(*copy);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * The source node array may live in init memory. A shallow copy would
+	 * leave parent pointers referencing that array after it has been freed.
+	 * Copy the nodes now and rebase their parent pointers below. The name
+	 * and data objects remain owned by the backend and are not duplicated.
+	 */
+	copy->nodes = kmemdup_array(hierarchy->nodes, hierarchy->nr_nodes,
+				    sizeof(*copy->nodes), GFP_KERNEL);
+	if (!copy->nodes) {
+		kfree(copy);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	copy->nr_nodes = hierarchy->nr_nodes;
+	mutex_init(&copy->lock);
+
+	for (i = 0; i < copy->nr_nodes; i++) {
+		const struct powercap_node *parent = hierarchy->nodes[i].parent;
+		ptrdiff_t index;
+
+		copy->nodes[i].pcz = NULL;
+
+		if (!copy->nodes[i].name)
+			goto invalid;
+
+		if (!parent)
+			continue;
+
+		index = parent - hierarchy->nodes;
+		if (index < 0 || index >= i)
+			goto invalid;
+
+		copy->nodes[i].parent = &copy->nodes[index];
+	}
+
+	return copy;
+
+invalid:
+	mutex_destroy(&copy->lock);
+	kfree(copy->nodes);
+	kfree(copy);
+
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(powercap_hierarchy_dup);
+
+void powercap_hierarchy_free(struct powercap_hierarchy *hierarchy)
+{
+	if (!hierarchy)
+		return;
+
+	mutex_destroy(&hierarchy->lock);
+	kfree(hierarchy->nodes);
+	kfree(hierarchy);
+}
+EXPORT_SYMBOL_GPL(powercap_hierarchy_free);
+
+static void __powercap_hierarchy_destroy(struct powercap_control_type *pct,
+					 struct powercap_hierarchy *hierarchy,
+					 powercap_node_destroy_t powercap_node_destroy)
+{
+	size_t i;
+
+	for (i = hierarchy->nr_nodes; i-- > 0;) {
+		if (!hierarchy->nodes[i].pcz)
+			continue;
+
+		powercap_node_destroy(pct, hierarchy->nodes[i].pcz,
+				      hierarchy->nodes[i].data);
+
+		hierarchy->nodes[i].pcz = NULL;
+	}
+}
+
+int powercap_hierarchy_destroy(struct powercap_control_type *pct,
+			       struct powercap_hierarchy *hierarchy,
+			       powercap_node_destroy_t powercap_node_destroy)
+{
+	if (!pct || !hierarchy || !hierarchy->nodes ||
+	    !hierarchy->nr_nodes || !powercap_node_destroy)
+		return -EINVAL;
+
+	guard(mutex)(&hierarchy->lock);
+
+	__powercap_hierarchy_destroy(pct, hierarchy, powercap_node_destroy);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(powercap_hierarchy_destroy);
+
+int powercap_hierarchy_create(struct powercap_control_type *pct,
+			      struct powercap_hierarchy *hierarchy,
+			      powercap_node_create_t powercap_node_create,
+			      powercap_node_destroy_t powercap_node_destroy)
+{
+	struct powercap_zone *pcz;
+	int ret;
+	size_t i;
+
+	if (!pct || !hierarchy || !hierarchy->nodes || !hierarchy->nr_nodes ||
+	    !powercap_node_create || !powercap_node_destroy)
+		return -EINVAL;
+
+	guard(mutex)(&hierarchy->lock);
+
+	for (i = 0; i < hierarchy->nr_nodes; i++) {
+		struct powercap_zone *parent = NULL;
+
+		if (hierarchy->nodes[i].parent) {
+			parent = hierarchy->nodes[i].parent->pcz;
+			if (!parent) {
+				ret = -EINVAL;
+				goto rollback;
+			}
+		}
+
+		pcz = powercap_node_create(pct, hierarchy->nodes[i].name,
+					   hierarchy->nodes[i].data, parent);
+		if (IS_ERR_OR_NULL(pcz)) {
+			ret = pcz ? PTR_ERR(pcz) : -EINVAL;
+			goto rollback;
+		}
+
+		hierarchy->nodes[i].pcz = pcz;
+	}
+
+	return 0;
+
+rollback:
+	__powercap_hierarchy_destroy(pct, hierarchy, powercap_node_destroy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(powercap_hierarchy_create);
+
 static int __init powercap_init(void)
 {
 	int result;
diff --git a/include/linux/powercap.h b/include/linux/powercap.h
index 603419db924c..939cd58dff4f 100644
--- a/include/linux/powercap.h
+++ b/include/linux/powercap.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/mutex.h>
 
 /*
  * A power cap class device can contain multiple powercap control_types.
@@ -309,4 +310,181 @@ struct powercap_zone *powercap_register_zone(
 int powercap_unregister_zone(struct powercap_control_type *control_type,
 				struct powercap_zone *power_zone);
 
+/**
+ * struct powercap_node - Description of a node in a powercap hierarchy
+ * @name: Name of the powercap zone.
+ * @parent: Parent node, or NULL if the node is a hierarchy root.
+ * @pcz: Powercap zone created for this node. This field is managed by the
+ *	 hierarchy creation and destruction helpers.
+ * @data: Private data passed unchanged to the creation and destruction
+ *	  callbacks.
+ *
+ * This structure describes one node of a powercap hierarchy. The backend
+ * supplies an array of nodes through &struct powercap_hierarchy.
+ *
+ * Nodes must be ordered so that a parent appears before all its children.
+ *
+ * The @name and @data objects must remain valid until the duplicated hierarchy
+ * has been freed. The @parent pointer is rebased by powercap_hierarchy_dup(),
+ * allowing the original node array to be released after duplication.
+ *
+ * The @pcz field is runtime state managed by powercap_hierarchy_create() and
+ * powercap_hierarchy_destroy(). It is cleared when a node is destroyed.
+ */
+struct powercap_node {
+	const char *name;
+	struct powercap_node *parent;
+	struct powercap_zone *pcz;
+	void *data;
+};
+
+/**
+ * struct powercap_hierarchy - Powercap zone hierarchy
+ * @nodes: Array describing the hierarchy nodes.
+ * @nr_nodes: Number of entries in @nodes.
+ * @lock: Lock serializing hierarchy creation and destruction.
+ *
+ * A backend may place the initial description in init memory and duplicate it
+ * with powercap_hierarchy_dup() before the init sections are released. The
+ * duplicated hierarchy owns the @nodes array, but not the objects referenced
+ * by &struct powercap_node.name and &struct powercap_node.data.
+ */
+struct powercap_hierarchy {
+	struct powercap_node *nodes;
+	size_t nr_nodes;
+	struct mutex lock;
+};
+
+/**
+ * powercap_hierarchy_dup - Duplicate a powercap hierarchy description
+ * @hierarchy: Hierarchy description to duplicate.
+ *
+ * Allocate a runtime hierarchy and copy the nodes from @hierarchy. Parent
+ * pointers are rebased to the duplicated node array and the runtime pcz fields
+ * are initialized to NULL.
+ *
+ * Every parent must belong to the source node array and precede its children.
+ * The node names and private data are not duplicated and must remain valid
+ * until powercap_hierarchy_free() is called.
+ *
+ * Context: Process context. May sleep.
+ *
+ * Return: A pointer to the duplicated hierarchy on success, or an ERR_PTR()
+ * encoded error otherwise.
+ */
+struct powercap_hierarchy *powercap_hierarchy_dup(const struct powercap_hierarchy *hierarchy);
+
+/**
+ * powercap_hierarchy_free - Free a duplicated powercap hierarchy
+ * @hierarchy: Hierarchy to free, or NULL.
+ *
+ * Free the node array and hierarchy allocated by powercap_hierarchy_dup(). All
+ * registered zones must have been destroyed before calling this function.
+ */
+void powercap_hierarchy_free(struct powercap_hierarchy *hierarchy);
+
+/**
+ * typedef powercap_node_create_t - Create a powercap hierarchy node
+ * @pct: Powercap control type owning the hierarchy.
+ * @name: Name of the powercap zone to create.
+ * @data: Private data associated with the hierarchy node.
+ * @parent: Parent powercap zone, or NULL for a root node.
+ *
+ * Callback invoked by powercap_hierarchy_create() for each node in the
+ * hierarchy. The callback must create and register a powercap zone below
+ * @parent. The backend is expected to embed struct powercap_zone in its own
+ * object, pass the address of that member to powercap_register_zone(), and
+ * return the same address from this callback. This lets the backend recover
+ * its object with container_of() from subsequent powercap callbacks.
+ *
+ * Context: Called with the powercap hierarchy mutex held. The callback may
+ * sleep, but must not call powercap_hierarchy_create() or
+ * powercap_hierarchy_destroy() for the same hierarchy.
+ *
+ * Return: A valid pointer to the created powercap zone on success, or an
+ * ERR_PTR() encoded error on failure.
+ */
+typedef struct powercap_zone *(*powercap_node_create_t)(struct powercap_control_type *pct,
+							const char *name, void *data,
+							struct powercap_zone *parent);
+/**
+ * typedef powercap_node_destroy_t - Destroy a powercap hierarchy node
+ * @pct: Powercap control type owning the hierarchy.
+ * @zone: Powercap zone to destroy.
+ * @data: Private data associated with the hierarchy node.
+ *
+ * Callback invoked when a hierarchy is destroyed or when its creation must
+ * be rolled back. The callback must unregister the powercap zone represented
+ * by @zone. The backend remains responsible for the lifetime of the enclosing
+ * object, including releasing it from the powercap zone release callback when
+ * necessary.
+ *
+ * Nodes are passed to this callback in reverse creation order, ensuring that
+ * all children are destroyed before their parent.
+ *
+ * Context: Called with the powercap hierarchy mutex held. The callback may
+ * sleep, but must not call powercap_hierarchy_create() or
+ * powercap_hierarchy_destroy() for the same hierarchy.
+ */
+typedef void (*powercap_node_destroy_t)(struct powercap_control_type *pct,
+					struct powercap_zone *zone,
+					void *data);
+
+/**
+ * powercap_hierarchy_destroy - Destroy a powercap hierarchy
+ * @pct: Powercap control type owning the hierarchy.
+ * @hierarchy: Hierarchy to destroy.
+ * @powercap_node_destroy: Callback used to destroy each powercap zone.
+ *
+ * Destroy all powercap zones previously created for @hierarchy. Nodes are
+ * destroyed in reverse array order so that children are removed before their
+ * parents.
+ *
+ * Entries whose &struct powercap_node.pcz field is NULL are ignored. After
+ * a zone has been destroyed, its pcz field is cleared.
+ *
+ * The caller must ensure that no users of the hierarchy remain when this
+ * function is called.
+ *
+ * Context: Process context. May sleep.
+ *
+ * Return: 0 on success or -EINVAL if an argument is invalid.
+ */
+int powercap_hierarchy_destroy(struct powercap_control_type *pct,
+			       struct powercap_hierarchy *hierarchy,
+			       powercap_node_destroy_t powercap_node_destroy);
+
+/**
+ * powercap_hierarchy_create - Create a powercap hierarchy
+ * @pct: Powercap control type that will own the hierarchy.
+ * @hierarchy: Hierarchy to create.
+ * @powercap_node_create: Callback used to create each powercap zone.
+ * @powercap_node_destroy: Callback used to roll back an incomplete hierarchy.
+ *
+ * Create the powercap zones described by @hierarchy in array order. For each
+ * entry, @powercap_node_create is called with the powercap zone stored in its
+ * parent entry. Root nodes are created with a NULL parent.
+ *
+ * Each parent entry must precede all its children in the node array. All pcz
+ * fields must be NULL when this function is called.
+ *
+ * If a node cannot be created, all zones created by this invocation are
+ * destroyed in reverse order by calling @powercap_node_destroy. Therefore,
+ * @powercap_node_destroy must be provided even when the caller does not
+ * expect to destroy the hierarchy explicitly.
+ *
+ * The hierarchy and the objects referenced by its name and data fields must
+ * remain valid until powercap_hierarchy_destroy() has completed.
+ *
+ * Context: Process context. May sleep.
+ *
+ * Return: 0 on success, -EINVAL if an argument or hierarchy entry is invalid,
+ * -EBUSY if the hierarchy already contains a created zone, or the error
+ * returned by @powercap_node_create.
+ */
+int powercap_hierarchy_create(struct powercap_control_type *pct,
+			      struct powercap_hierarchy *hierarchy,
+			      powercap_node_create_t powercap_node_create,
+			      powercap_node_destroy_t powercap_node_destroy);
+
 #endif
-- 
2.53.0

