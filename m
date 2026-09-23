Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE82535FBE
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174074; cv=none; b=WsgzX/KYQnATrF956CpXI/qjQBOeHfzqKRy8dfm3/jpaO8FotGAAd9vvWTmTX6Du3cP8a3fCGYvdif5wbRUo/xrd5m6PQTW1oNjhgaR7XoFDtEsLmf2a6PqKYtr1BPvlPZeZeSrfQ/WuS1Y3fJ0ht38GGAF3xvUCMzUPXKWg/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174074; c=relaxed/simple;
	bh=d4z/t7Syx8TEgyQCSRPsF3wN17m41lysMVALd8mRK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeNNFkENckWI5g4/6h6+WwyF2h+ZZ9IUxslt5QDU88Yb6EQfbI97jXfPHh/6W9tZxZUHmt2sljm3FXLc6ztwEwK8dJDVAfHSEpmIXtEGg8OgsDEevnuy2LCi2dpt/cFubann2XgQXtK8W00A3QtAqWB/FfwzBPJ2TW8jgH+jBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8c0Jpgh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NIO3OAT+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8c0Jpgh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NIO3OAT+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDLqWo3842692
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OMTyHQQCfMh
	7kqySui+IAhPuachiF8Vbnkdm627Ftss=; b=k8c0JpghjMx4/y1uG5rHjtmUfLP
	ZwudtG5TuhG36Rfuu6zSvrtDhkbEz+gCVZsf1qs+n0eGC8zLdRNOZTCuJywFVGmo
	MaHNXX4NM6lsCWQC8LmYJVA7w3YapbMy0UGQ+Maqy5mrFi+h+IxfS4nHN/UxwaOx
	tMSAJQNqe9ThDGfoymm8j7+Bu7WNUhIUEO8cqQYl+BCdcUXOsJpFy9aoBc7wgF7v
	OyhiugKghG6CACFw3TRjCzli0yFi/PMqK5qdPjWemUt1aVaDA04z+aD3QEbmGn/3
	baOEUPzASDYPCtMhhO+M/OfLZdqtjgQzM+2x0+T6H+sedVuGavuWfgaLzMw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfkbgaa6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:31 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78a6d5cc851so285407137.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174071; x=1790778871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMTyHQQCfMh7kqySui+IAhPuachiF8Vbnkdm627Ftss=;
        b=NIO3OAT+23lFEA4CyzWJikXA2pTeeoLco+aSxW28S4P9QqEWxQFcAQugeihDr5PXDd
         zpfE2eYDPrQa1VbiObkwuMsajDS/bZIcQjJ68uQ3gD+xC0f3fJUmwXA2nkW0fZszF+3I
         Ym1fVRjzypI4yOFAiZGs7eEGLkfLwRJkRsGrFLL38WbUKSDWcWbMFMfWgoyYuTMXe4hW
         e8E95F4J8r6DvKwEQf51BPLJKppGwPWdveLbBkLetDxevMODh0m4tV+I7M4vf/i5dPWz
         5lQkauaTDe1+axRphUhj7iFIUyDxwMig40AIMScdmgbZebNaleLBF5m9G1r6OnstfFgm
         F6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174071; x=1790778871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMTyHQQCfMh7kqySui+IAhPuachiF8Vbnkdm627Ftss=;
        b=lbzminul40dkc3AFH3Jy+36iSijbtmztXGpyvOfv1MMBKuGJi06UeiViO18IXfBhUa
         iJDrDHJ492acfM+vw6Zuw03VlIv1rzs3CWcG8IwH+CAK+QtKKTbqdN8zJn02Z2cVYkYl
         DWZ3KnDyA/B2jsYzsFD9SyRVP9yM1wJGmxgj5UdXxuHclubxaZi5K/pnaQjxebW88mwn
         jtVJMJidCCzxnevgFS5KrWRQtRF5tQhA6TjCUPrvH45wfZxXwUOOV15tlrMtQQlf1ibz
         kw50K4HZ7X5fzcGQfFNTBT9TxGfssGRTMdVF1cJfDbJOjmeVMi588UKEFe4PPCkQwoev
         wXoQ==
X-Gm-Message-State: AFuF++mMg6ug/FG5c6EGPYrd27Z4hj6ztt/NH2nknXlfa5/r+qvsY637
	vcHdUvG9vYqIgQf+ddvG0zhDlavLG0xfLflNISEjlRd7+3NxTmBXouNgZiyriIlDVbVeRCIJaIp
	IBvbvlym5+le3kb/HKw8O+b3vHjC/MiS3b2cyzcE1l+D6G8OGhunpZemLx4SpZawMa9R7Vg==
X-Gm-Gg: AYBFou2GHRxCaPA6nQJEMiJ/IAj1A9gFGx2NGeJ2mJPNMKPj+ObZJsvnls8Qgj3sP+8
	KoU8pwakJO+PG2lGaizxJOTXCnKtcHDxA3fi8mfym6iZ/uLXGASa7o8d0Wzdafud15Q3EB70dc1
	jRcxH51IVFlAdDSru0dyB+zOiaRegLzRYf4rFyqFuem69RS4b7sD9yJa6NxijZLxmqvi/Mdr426
	n7zQmhVHZd4npL9CPx0kiKg1/PtpgBSKjThHkf4Me5TRkc63QwOR/yImWiVMgOLAMbFCc8OlJlt
	nu5i3zBbzH5+whJ9ODuPShKl3LyFF1VW47Ov3NWSmbj5MPkQYdjXxDt7nGcJlLEQJtrsQMwhRrS
	6kMR/OOJG5y4WM6GMRULnIMRSb5A=
X-Received: by 2002:a05:6102:5607:b0:7a6:f970:27d6 with SMTP id ada2fe7eead31-7ac1d2db5dfmr2185109137.20.1790174070662;
        Wed, 23 Sep 2026 07:34:30 -0700 (PDT)
X-Received: by 2002:a05:6102:5607:b0:7a6:f970:27d6 with SMTP id ada2fe7eead31-7ac1d2db5dfmr2185087137.20.1790174070085;
        Wed, 23 Sep 2026 07:34:30 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm58213905e9.0.2026.09.23.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:34:29 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 4/6] powercap: dtpm: Use generic powercap hierarchy helpers
Date: Wed, 23 Sep 2026 16:34:14 +0200
Message-ID: <20260923143416.3713485-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX7JXn/XdSL0SI
 Hi4gwLAz6g1QSB3GsksGQxZrQXHMbnep8UbZw2U4HVW+FHA9WyS+vkIB+FqeY9YdS47BCj6q5WJ
 9oszloRY02eNXDatZy42cgkaIwZK9tU=
X-Proofpoint-GUID: OvFEoKDbb4HR-W3xX6b21jxc2nPgihQv
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ab3e377 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=j7aLo_kv3ohkNa-rISMA:9
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX16ymGa6SWEz2
 CQzlEv48n6MG4iflqbyNO9ijk/yZIvvfgHt+Uuz/RF+CIs6m/2DcuIo3kvfl2AeJQHqL+twvKz9
 QabmtSGJKWQlfKOFCoLfQyxwVLr3BCkxNT1QGns+3hTZd6e9GQ+L9SR4GI098bnNB9n6TQLRBe1
 V6oP+xczWtrfpWEWjfJic+GyCW3Wh04MgRHCJ2s07VQKpB6mGbIIVDfH/S5NBk1fWRS4arQAKFu
 3D9RAxRjU27kyP+NAg2xhuSkSFhiIabpSjjMjaMKXWj3YtZAgOUqKtaFTpRc27CAgcA8hiuf43v
 oZa1QL9SqBLdrv/89pGpBqZpIiKyHqR22ysWs3Dgrc4mKSpQUTSgAf38hNOR3tGfIOFy2RDNP7k
 o/EtnERrwwSxJ9mIdEF3Feq0nVnZgZysc8GLNu4LpDrkIPFvyWE61Nf1icvmQGj6MNORYjjLnsp
 4mggfQKdqYre766CnbQ==
X-Proofpoint-ORIG-GUID: OvFEoKDbb4HR-W3xX6b21jxc2nPgihQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

DTPM implements its own hierarchy creation and destruction logic while
the powercap core now provides generic helpers for this purpose.

Convert DTPM to use the generic powercap hierarchy infrastructure.
Duplicate the platform hierarchy before creating it, and use
powercap_hierarchy_create() and powercap_hierarchy_destroy() to manage
the DTPM zones.

Add DTPM callbacks to create and destroy the zones associated with each
powercap hierarchy node. Adapt the CPU and devfreq backends to return
the created DTPM instance and use the node name provided by the
hierarchy.

Convert the Rockchip RK3399 description to struct powercap_hierarchy
and keep the device tree path as DTPM-specific node data.

This removes the DTPM-specific hierarchy traversal and destruction code
and leaves the hierarchy management to the powercap core.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/powercap/dtpm.c         | 165 ++++++++++++++------------------
 drivers/powercap/dtpm_cpu.c     |  22 ++---
 drivers/powercap/dtpm_devfreq.c |  22 +++--
 drivers/soc/rockchip/dtpm.c     |  67 +++++++++----
 include/linux/dtpm.h            |   5 +-
 5 files changed, 147 insertions(+), 134 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b7a65e543f19..d719f9595ec5 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -35,6 +35,7 @@ static const char *constraint_name[] = {
 
 static DEFINE_MUTEX(dtpm_lock);
 static struct powercap_control_type *pct;
+static struct powercap_hierarchy *dtpm_hierarchy;
 static struct dtpm *root;
 
 static int get_time_window_us(struct powercap_zone *pcz, int cid, u64 *window)
@@ -412,8 +413,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
-				       struct dtpm *parent)
+static struct dtpm *dtpm_setup_virtual(const char *name, struct dtpm *parent)
 {
 	struct dtpm *dtpm;
 	int ret;
@@ -423,10 +423,9 @@ static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
 		return ERR_PTR(-ENOMEM);
 	dtpm_init(dtpm, NULL);
 
-	ret = dtpm_register(hierarchy->name, dtpm, parent);
+	ret = dtpm_register(name, dtpm, parent);
 	if (ret) {
-		pr_err("Failed to register dtpm node '%s': %d\n",
-		       hierarchy->name, ret);
+		pr_err("Failed to register dtpm node '%s': %d\n", name, ret);
 		kfree(dtpm);
 		return ERR_PTR(ret);
 	}
@@ -434,90 +433,84 @@ static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
 	return dtpm;
 }
 
-static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
+static struct dtpm *dtpm_setup_dt(const char *name, const char *path,
 				  struct dtpm *parent)
 {
 	struct device_node *np;
-	int i, ret;
+	struct dtpm *dtpm = NULL;
+	int i;
 
-	np = of_find_node_by_path(hierarchy->name);
+	np = of_find_node_by_path(path);
 	if (!np) {
-		pr_err("Failed to find '%s'\n", hierarchy->name);
+		pr_err("Failed to find '%s'\n", path);
 		return ERR_PTR(-ENXIO);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
+		struct dtpm *tmp;
 
 		if (!dtpm_subsys[i]->setup)
 			continue;
 
-		ret = dtpm_subsys[i]->setup(parent, np);
-		if (ret) {
-			pr_err("Failed to setup '%s': %d\n", dtpm_subsys[i]->name, ret);
-			of_node_put(np);
-			return ERR_PTR(ret);
+		tmp = dtpm_subsys[i]->setup(parent, np, name);
+		if (IS_ERR(tmp)) {
+			pr_err("Failed to setup '%s': %ld\n",
+			       dtpm_subsys[i]->name, PTR_ERR(tmp));
+			dtpm = tmp;
+			break;
+		}
+
+		if (tmp) {
+			dtpm = tmp;
+			break;
 		}
 	}
 
 	of_node_put(np);
 
-	/*
-	 * By returning a NULL pointer, we let know the caller there
-	 * is no child for us as we are a leaf of the tree
-	 */
-	return NULL;
+	return dtpm;
 }
 
-typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
-
-static dtpm_node_callback_t dtpm_node_callback[] = {
-	[DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
-	[DTPM_NODE_DT] = dtpm_setup_dt,
-};
-
-static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
-			       const struct dtpm_node *it, struct dtpm *parent)
+static struct powercap_zone *
+dtpm_node_create(struct powercap_control_type *pct, const char *name,
+		 void *data, struct powercap_zone *parent)
 {
+	struct dtpm_node *node = data;
+	struct dtpm *dtpm_parent = parent ? to_dtpm(parent) : NULL;
 	struct dtpm *dtpm;
-	int i, ret;
 
-	for (i = 0; hierarchy[i].name; i++) {
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
+	switch (node->type) {
+	case DTPM_NODE_VIRTUAL:
+		dtpm = dtpm_setup_virtual(name, dtpm_parent);
+		break;
+	case DTPM_NODE_DT:
+		dtpm = dtpm_setup_dt(name, node->path, dtpm_parent);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
 
-		if (hierarchy[i].parent != it)
-			continue;
+	if (IS_ERR(dtpm))
+		return ERR_CAST(dtpm);
 
-		dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
+	if (!dtpm)
+		return ERR_PTR(-ENODEV);
 
-		/*
-		 * A NULL pointer means there is no children, hence we
-		 * continue without going deeper in the recursivity.
-		 */
-		if (!dtpm)
-			continue;
+	return &dtpm->zone;
+}
 
-		/*
-		 * There are multiple reasons why the callback could
-		 * fail. The generic glue is abstracting the backend
-		 * and therefore it is not possible to report back or
-		 * take a decision based on the error.  In any case,
-		 * if this call fails, it is not critical in the
-		 * hierarchy creation, we can assume the underlying
-		 * service is not found, so we continue without this
-		 * branch in the tree but with a warning to log the
-		 * information the node was not created.
-		 */
-		if (IS_ERR(dtpm)) {
-			pr_warn("Failed to create '%s' in the hierarchy\n",
-				hierarchy[i].name);
-			continue;
-		}
+static void dtpm_node_destroy(struct powercap_control_type *pct,
+			      struct powercap_zone *zone, void *data)
+{
+	struct dtpm *dtpm = to_dtpm(zone);
 
-		ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
-		if (ret)
-			return ret;
-	}
+	if (dtpm == root)
+		root = NULL;
 
-	return 0;
+	dtpm_unregister(dtpm);
 }
 
 /**
@@ -528,27 +521,16 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
  * description of the different node in the hierarchy. It creates the
  * tree in the sysfs filesystem under the powercap dtpm entry.
  *
- * The expected tree has the format:
- *
- * struct dtpm_node hierarchy[] = {
- *	[0] { .name = "topmost", type =  DTPM_NODE_VIRTUAL },
- *	[1] { .name = "package", .type = DTPM_NODE_VIRTUAL, .parent = &hierarchy[0] },
- *	[2] { .name = "/cpus/cpu0", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
- *	[3] { .name = "/cpus/cpu1", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
- *	[4] { .name = "/cpus/cpu2", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
- *	[5] { .name = "/cpus/cpu3", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
- *	[6] { }
- * };
- *
- * The last element is always an empty one and marks the end of the
- * array.
+ * The platform description is a struct powercap_hierarchy. The private
+ * data associated with each powercap node describes how DTPM creates the
+ * corresponding zone.
  *
  * Return: zero on success, a negative value in case of error. Errors
  * are reported back from the underlying functions.
  */
 int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 {
-	const struct dtpm_node *hierarchy;
+	const struct powercap_hierarchy *hierarchy;
 	int i, ret;
 
 	mutex_lock(&dtpm_lock);
@@ -571,9 +553,17 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 		goto out_err;
 	}
 
-	ret = dtpm_for_each_child(hierarchy, NULL, NULL);
-	if (ret)
+	dtpm_hierarchy = powercap_hierarchy_dup(hierarchy);
+	if (IS_ERR(dtpm_hierarchy)) {
+		ret = PTR_ERR(dtpm_hierarchy);
+		dtpm_hierarchy = NULL;
 		goto out_err;
+	}
+
+	ret = powercap_hierarchy_create(pct, dtpm_hierarchy,
+				dtpm_node_create, dtpm_node_destroy);
+	if (ret)
+		goto out_free_hierarchy;
 	
 	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
 
@@ -590,6 +580,9 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 
 	return 0;
 
+out_free_hierarchy:
+	powercap_hierarchy_free(dtpm_hierarchy);
+	dtpm_hierarchy = NULL;
 out_err:
 	powercap_unregister_control_type(pct);
 out_pct:
@@ -601,20 +594,6 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 }
 EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
 
-static void __dtpm_destroy_hierarchy(struct dtpm *dtpm)
-{
-	struct dtpm *child, *aux;
-
-	list_for_each_entry_safe(child, aux, &dtpm->children, sibling)
-		__dtpm_destroy_hierarchy(child);
-
-	/*
-	 * At this point, we know all children were removed from the
-	 * recursive call before
-	 */
-	dtpm_unregister(dtpm);
-}
-
 void dtpm_destroy_hierarchy(void)
 {
 	int i;
@@ -624,7 +603,7 @@ void dtpm_destroy_hierarchy(void)
 	if (!pct)
 		goto out_unlock;
 
-	__dtpm_destroy_hierarchy(root);
+	powercap_hierarchy_destroy(pct, dtpm_hierarchy, dtpm_node_destroy);
 	
 
 	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
@@ -635,8 +614,10 @@ void dtpm_destroy_hierarchy(void)
 		dtpm_subsys[i]->exit();
 	}
 
+	powercap_hierarchy_free(dtpm_hierarchy);
 	powercap_unregister_control_type(pct);
 
+	dtpm_hierarchy = NULL;
 	pct = NULL;
 
 	root = NULL;
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 21355db6419d..c8e02eda701c 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -189,22 +189,21 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
+static struct dtpm *__dtpm_cpu_setup(int cpu, struct dtpm *parent, const char *name)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
 	struct em_perf_state *table;
 	struct em_perf_domain *pd;
-	char name[CPUFREQ_NAME_LEN];
-	int ret = -ENOMEM;
+	int ret;
 
 	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
 	if (dtpm_cpu)
-		return 0;
+		return NULL;
 
 	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
-		return 0;
+		return NULL;
 
 	pd = em_cpu_get(cpu);
 	if (!pd || em_is_artificial(pd)) {
@@ -224,8 +223,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = dtpm_cpu;
 
-	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
-
 	ret = dtpm_register(name, &dtpm_cpu->dtpm, parent);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
@@ -240,7 +237,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		goto out_dtpm_unregister;
 
 	cpufreq_cpu_put(policy);
-	return 0;
+	return &dtpm_cpu->dtpm;
 
 out_dtpm_unregister:
 	dtpm_unregister(&dtpm_cpu->dtpm);
@@ -253,18 +250,19 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 
 release_policy:
 	cpufreq_cpu_put(policy);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static int dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
+static struct dtpm *dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np,
+				   const char *name)
 {
 	int cpu;
 
 	cpu = of_cpu_node_to_id(np);
 	if (cpu < 0)
-		return 0;
+		return NULL;
 
-	return __dtpm_cpu_setup(cpu, dtpm);
+	return __dtpm_cpu_setup(cpu, dtpm, name);
 }
 
 static int dtpm_cpu_init(void)
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index fa71285dee60..a783601fe74e 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -144,7 +144,8 @@ static struct dtpm_ops dtpm_ops = {
 	.release = pd_release,
 };
 
-static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
+static struct dtpm *__dtpm_devfreq_setup(struct devfreq *devfreq,
+					 struct dtpm *parent, const char *name)
 {
 	struct device *dev = devfreq->dev.parent;
 	struct dtpm_devfreq *dtpm_devfreq;
@@ -156,23 +157,23 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
 		ret = dev_pm_opp_of_register_em(dev, NULL);
 		if (ret) {
 			pr_err("No energy model available for '%s'\n", dev_name(dev));
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
 	dtpm_devfreq = kzalloc_obj(*dtpm_devfreq);
 	if (!dtpm_devfreq)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dtpm_init(&dtpm_devfreq->dtpm, &dtpm_ops);
 
 	dtpm_devfreq->devfreq = devfreq;
 
-	ret = dtpm_register(dev_name(dev), &dtpm_devfreq->dtpm, parent);
+	ret = dtpm_register(name, &dtpm_devfreq->dtpm, parent);
 	if (ret) {
 		pr_err("Failed to register '%s': %d\n", dev_name(dev), ret);
 		kfree(dtpm_devfreq);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
@@ -185,23 +186,24 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
 
 	dtpm_update_power(&dtpm_devfreq->dtpm);
 
-	return 0;
+	return &dtpm_devfreq->dtpm;
 
 out_dtpm_unregister:
 	dtpm_unregister(&dtpm_devfreq->dtpm);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static int dtpm_devfreq_setup(struct dtpm *dtpm, struct device_node *np)
+static struct dtpm *dtpm_devfreq_setup(struct dtpm *dtpm, struct device_node *np,
+				       const char *name)
 {
 	struct devfreq *devfreq;
 
 	devfreq = devfreq_get_devfreq_by_node(np);
 	if (IS_ERR(devfreq))
-		return 0;
+		return NULL;
 
-	return __dtpm_devfreq_setup(devfreq, dtpm);
+	return __dtpm_devfreq_setup(devfreq, dtpm, name);
 }
 
 struct dtpm_subsys_ops dtpm_devfreq_ops = {
diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index e6a0c607334b..451417ae5715 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -11,26 +11,59 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static struct dtpm_node __initdata rk3399_hierarchy[] = {
-	[0] = { .name = "rk3399",
-		.type = DTPM_NODE_VIRTUAL },
-	[1] = { .name = "package",
-		.type = DTPM_NODE_VIRTUAL,
-		.parent = &rk3399_hierarchy[0] },
-	[2] = { .name = "/cpus/cpu@0",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[3] = { .name = "/cpus/cpu@100",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[4] = { .name = "/gpu@ff9a0000",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[5] = { /* sentinel */ }
+static struct dtpm_node rk3399_virtual = {
+	.type = DTPM_NODE_VIRTUAL,
+};
+
+static struct dtpm_node rk3399_cpu0 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@0",
+};
+
+static struct dtpm_node rk3399_cpu4 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@100",
+};
+
+static struct dtpm_node rk3399_gpu = {
+	.type = DTPM_NODE_DT,
+	.path = "/gpu@ff9a0000",
+};
+
+static struct powercap_node __initdata rk3399_nodes[] = {
+	[0] = {
+		.name = "rk3399",
+		.data = &rk3399_virtual,
+	},
+	[1] = {
+		.name = "package",
+		.parent = &rk3399_nodes[0],
+		.data = &rk3399_virtual,
+	},
+	[2] = {
+		.name = "cpu0-cpufreq",
+		.parent = &rk3399_nodes[1],
+		.data = &rk3399_cpu0,
+	},
+	[3] = {
+		.name = "cpu4-cpufreq",
+		.parent = &rk3399_nodes[1],
+		.data = &rk3399_cpu4,
+	},
+	[4] = {
+		.name = "ff9a0000.gpu",
+		.parent = &rk3399_nodes[1],
+		.data = &rk3399_gpu,
+	},
+};
+
+static struct powercap_hierarchy __initdata rk3399_hierarchy = {
+	.nodes = rk3399_nodes,
+	.nr_nodes = ARRAY_SIZE(rk3399_nodes),
 };
 
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
-        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
+        { .compatible = "rockchip,rk3399", .data = &rk3399_hierarchy },
         {},
 };
 
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index a4a13514b730..c0ece6a4d1fe 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -38,7 +38,7 @@ struct dtpm_subsys_ops {
 	const char *name;
 	int (*init)(void);
 	void (*exit)(void);
-	int (*setup)(struct dtpm *, struct device_node *);
+	struct dtpm *(*setup)(struct dtpm *, struct device_node *, const char *);
 };
 
 enum DTPM_NODE_TYPE {
@@ -48,8 +48,7 @@ enum DTPM_NODE_TYPE {
 
 struct dtpm_node {
 	enum DTPM_NODE_TYPE type;
-	const char *name;
-	struct dtpm_node *parent;
+	const char *path;
 };
 
 static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
-- 
2.43.0

