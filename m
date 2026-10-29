Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293061;
	b=1zq3eG6AFJ1Y2C6Dt0Zfk9y07sKiBtudbHboHu4yVunwHvB78kD+50QnN7ksHlUIsx8/
	 6jQ2W/QLqpkxbujCbeDT93lm/51buuEJVxbXOuM2qPiPF81oEPLbeqfxAhm38IHBu7dLY
	 bRmi/NZldFN2MPZbea+KwJcfabOjgbzODuMpDdFgMb0O1mDc1W2BKTxHjgDRS+W5IDilq
	 Otw6wV39TpsfPe/iFikvEW7PvJsRuY618HgZ7rrlECcGqqTu+hCOZ78XwDSPlSwxgqKaJ
	 b1YA5y4We/TSQCSNqDYihCiVigwvHZdH6dmsyA8Q/uNamN/SgnHE1G9fkm2n0Yqb8ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293061;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=O3GMAYfHUSmwxgmj+JvTBhDTCTV9/RDBGWMYy+RzK6c=;
	b=GkSab6LNduKE4YfoHh4LN1y2MdtZYDcWtznAS5FQdigAxixcgEAQYNIMlVHO1qBP7lRG
	 a1T5NuTMpNcHXdqzJ/UpI5gzSdqJ7kzlw9vKT0zM1ywQ2DdI3WIbCxGgf6+wgLuINoXkr
	 K3PaAEWV45EI7I8mii+ypS8yBH46kSeCrx6o0gaE6T1OpBpBHzAdq518EKoL0TI3pJcQd
	 EJgIUsm7yBlmsEIejHY994uFUDBt10juAEO5KNz3d3cmZFvwXkpUu4ka8FGrXaTKpNosz
	 QBomP/TT0gkqZCMKANnf2ZKEW2wxBYfSzezSCQEPUABpFEGnEGOlJ+J+qyMf/clTkcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K9fxzteN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oe01RjZl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177A60A260F
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1177A60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K9fxzteN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oe01RjZl
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGD3Un535339
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=O3GMAYfHUSm
	wxgmj+JvTBhDTCTV9/RDBGWMYy+RzK6c=; b=K9fxzteN5QFJfGrTHy2iUCD6f62
	SCX/zoRY71i1jR07z3Vmc1dQBCO16btBZJIjlzdnWTwHeeoZPxNGYyE1U3zZiqUK
	UY5uVdTGnSf7NrpvlR109isWBMO1psBqSHajlDsl7MIT+tWI+j3XC/qloZ6RILOX
	gJm1+fcACYUo48lF2L2Bgekc3QYY1iY45a9/+S38gJQW45e9VNdl8NH9IqY3chfM
	+RENBlODguQO56H14Ld1poC1obrElUYSSP7rLzl5U1Poq/ydmNZaEWMUI97g6mmv
	0h6DSi41QZhKBea3oB5kaCnob9S3HPcR0FHZuNOArKuUjwo8DGdQ2LFHeMg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4gnnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc099197b9so1746748137.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793293059; x=1793897859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3GMAYfHUSmwxgmj+JvTBhDTCTV9/RDBGWMYy+RzK6c=;
        b=Oe01RjZljQftAzkrLsWsRh4QPjuVnxwxPAgq2uLBlV7MQQ5tBFyZZlqPPr6K7ZuyCV
         lBXbXByQEhGVHfzO7NxKmXLSI6IoyI9GkY0FZGDkf/TfscKG6u111qgmvnnaRj7TlEut
         C6b3d0yKJZiyXaAgKDukQ7WaKhiqidukZiLi8d7QNumYw9qROcpRm5ZKcSBL0iv/xh6S
         W3U6H+GHBhZhdoj7cp1gQ2kiYQRF1G+CCwUatAlfd86kRnGQA1pC+C06Uaz+CVFn4Uig
         lP0dghWRYKNb1f2oOabhbOP8g3DQl3F0SvOBMv3By/u2QYovwGgLDv6QEk1bYI3A0HwF
         j8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293059; x=1793897859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3GMAYfHUSmwxgmj+JvTBhDTCTV9/RDBGWMYy+RzK6c=;
        b=oJLBzhbyloE9fCBCY7m4ME04s9cvpE29kR6ZTe9jBo7wtZiBjPLH/ff0Y/59UyMCKv
         aio/nYZGUdNJfObLldlooptPqj484QbPzYcwR/h+9b5lUAwOz/I8g+JbM+F00wiDuo8d
         AcwapSn3Nt814ANBH/LHOWSYgU/ZxNaV5csYNGUS7zLJK/yNJzi6ALP4LxifDYXfsoN2
         4BSBixOAjv3m2GZnoBnT/gJVVbskAxOHTZubvrIjI4+USKGcY/Nt3UUPiaafkNEzM+jG
         9E6nM9uny72m9mQPHI8xKl4xockeJLK19wMxqGzFsLdGVxSXuQQzldNFe0N271H/IZyH
         0CDw==
X-Forwarded-Encrypted: i=1; AKwUvByhijjrdJzikySKgmqGawbS0JZmMPgyyWA3fIi4tGEH7BAOLaFLjvd2ovt/MdkhA/MUfGsCwY0fpg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKTh/Cu7BcKVL8ewFwNCcvxW0dKVTsPyZopZx7FazPN+JPmpqda
	PwUi7qvVBRjFGuyf7yKv0sUMxkv78uWvpOpxDu/NqDaL1UErLoBiiycVdM4lkoMyfsAqbA5Kl8e
	/TkvCwg1g2ngb0apbn9flwXqKLN4b7cGX/+P/DC0lTfzx1jItNLaKoReuzrCYMg==
X-Gm-Gg: AYBFou3z1XdIOIWaEuZTuJO0xhuUXqA+OBBM5oEaFlM+IdoPJTxDq6bKts5UZatXbHG
	MEpiyLrpfVnnrT5Y+58jvl8R8ttcM/W0G1dosMdlFzo0VjDLeUrhjoIXgpdrj41UGdcQk+7Rp39
	YnX9y0gRrIsuzs2j/mffzj51CYHC/DA78H6NKC6HuvxqHUraNAbig1NnGXfhPXmxhZEqxPZrjE+
	7x3zDecXdDv2G10xSnDpkBW1l7HAvTeybApwfJRR6iLTnfW6m6GQ7kpR2F+Ll7dJ75fQRtmg64a
	IOD432ungOyDDXj0rgYOUaNeA26iKlzSSobzYANThPpRarUKCH+69E9iyiXy3/Ea8i6z50sChPU
	x6w54+4SMolOGnsmcYMegknINIpgamSQ3WknpK3l33A+lM67maOSLc4FAjuXZvqwUr72RCg4Hcx
	xa
X-Received: by 2002:a05:6102:4b03:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7d03a1ed917mr3164901137.4.1793293059265;
        Thu, 29 Oct 2026 09:57:39 -0700 (PDT)
X-Received: by 2002:a05:6102:4b03:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7d03a1ed917mr3164876137.4.1793293058630;
        Thu, 29 Oct 2026 09:57:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df961dasm325669f8f.23.2026.10.29.09.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:37 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 4/6] powercap: dtpm: Use generic powercap hierarchy helpers
Date: Thu, 29 Oct 2026 17:56:48 +0100
Message-ID: <f34635d2ce1d5c741968708e6349f7f059b03173.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX7XJTfR5KmWmt
 d+xFRtCTPk6fjcksn1p/VhcPNIvsbKZWLOj/zit2BR8XvxZwVEnBHjvCyhBF8e33WdMGsQJjS2C
 uML4zqJhJhaNl1X8MTxHyVmnCBVJ90RhOvJYaAxE/vauZoxPEkKniRGkjqHXo7wKVnjyIRkhIED
 OtaMo0pJeE4NIpI51fq3KGEWU7LFbUNE7Ap2LkoIZi0GqZfgPEsUZOTXLmlt0NGBR7mlScJ3YaV
 UEF90W8/LZ4KqFJZfDUBoWbMwLhV4IygkEFYLf/HBz13uCuUcGWxiy0pR67udj5EJ6ATPY/vXXl
 VxY4Q9wjUoMR0sYtppDI1Ge6QkxsPE60hqSmBpUefDaxUQKX5mSh7oYxEvnhiQBbY/msDcLwBhU
 YFmpolgxq8sYGqDUVHnp5VlnCTRCtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX025Ded0GdFAx
 ovS9CzcefyJPGCx0ijv/PbnMER0OkLjPCEMAr9lKnuB3kYquUfbpjdB8ouzOGmKSNO1gsO6vPaj
 bqS519pvTj9zO8t47cF6OO8To4Qekgw=
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae37b04 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=PNS_9xEdTJF3v_BdtpwA:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: GNSsaSMSOw48pUCa7jFxY4TAmgCcGGWh
X-Proofpoint-ORIG-GUID: GNSsaSMSOw48pUCa7jFxY4TAmgCcGGWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290066

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

Preserve best-effort creation: an unavailable backend returns NULL to
skip its branch, and setup failures are warned about and skipped rather
than rolling back independent zones. Invalid node descriptors remain
fatal.

When the representative CPU is offline, find an active policy through an
online sibling whose related_cpus mask contains it. Hold the CPU hotplug
read lock during selection and setup, and initialize the zone through the
policy's active CPU while keeping the hierarchy-provided name. An entirely
offline policy still has no active CPU to initialize through.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Preserve best-effort branch creation using the generic NULL result.
- Find an online policy sibling for offline CPU representatives and
  protect policy selection and setup against CPU hotplug.
- Keep generic API behavior and documentation in patch 1.
- Fix __initdata placement; match-table indentation is handled in patch 3.
- Name setup callback arguments and remove whitespace-only lines.
- Update the description.

 drivers/powercap/dtpm.c         | 177 +++++++++++++++-----------------
 drivers/powercap/dtpm_cpu.c     |  62 ++++++++---
 drivers/powercap/dtpm_devfreq.c |  22 ++--
 drivers/soc/rockchip/dtpm.c     |  67 +++++++++---
 include/linux/dtpm.h            |   6 +-
 5 files changed, 195 insertions(+), 139 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b7a65e543f19..09197fb4f740 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -35,6 +35,7 @@ static const char *constraint_name[] = {
 
 static DEFINE_MUTEX(dtpm_lock);
 static struct powercap_control_type *pct;
+static struct powercap_hierarchy *dtpm_hierarchy;
 static struct dtpm *root;
 
 static int get_time_window_us(struct powercap_zone *pcz, int cid, u64 *window)
@@ -191,7 +192,7 @@ static int get_power_limit_uw(struct powercap_zone *pcz,
 			      int cid, u64 *power_limit)
 {
 	*power_limit = to_dtpm(pcz)->power_limit;
-	
+
 	return 0;
 }
 
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
@@ -434,90 +433,88 @@ static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
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
+	/* An unavailable backend must not prevent independent branches. */
+	if (IS_ERR(dtpm)) {
+		pr_warn("Failed to create '%s' in the hierarchy: %ld\n",
+			name, PTR_ERR(dtpm));
+		return NULL;
+	}
 
-		dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
+	if (!dtpm)
+		return NULL;
 
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
@@ -528,27 +525,16 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
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
@@ -571,10 +557,18 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 		goto out_err;
 	}
 
-	ret = dtpm_for_each_child(hierarchy, NULL, NULL);
-	if (ret)
+	dtpm_hierarchy = powercap_hierarchy_dup(hierarchy);
+	if (IS_ERR(dtpm_hierarchy)) {
+		ret = PTR_ERR(dtpm_hierarchy);
+		dtpm_hierarchy = NULL;
 		goto out_err;
-	
+	}
+
+	ret = powercap_hierarchy_create(pct, dtpm_hierarchy,
+				dtpm_node_create, dtpm_node_destroy);
+	if (ret)
+		goto out_free_hierarchy;
+
 	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
 
 		if (!dtpm_subsys[i]->init)
@@ -590,31 +584,20 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 
 	return 0;
 
+out_free_hierarchy:
+	powercap_hierarchy_free(dtpm_hierarchy);
+	dtpm_hierarchy = NULL;
 out_err:
 	powercap_unregister_control_type(pct);
 out_pct:
 	pct = NULL;
 out_unlock:
 	mutex_unlock(&dtpm_lock);
-	
+
 	return ret;
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
@@ -624,8 +607,8 @@ void dtpm_destroy_hierarchy(void)
 	if (!pct)
 		goto out_unlock;
 
-	__dtpm_destroy_hierarchy(root);
-	
+	powercap_hierarchy_destroy(pct, dtpm_hierarchy, dtpm_node_destroy);
+
 
 	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
 
@@ -635,8 +618,10 @@ void dtpm_destroy_hierarchy(void)
 		dtpm_subsys[i]->exit();
 	}
 
+	powercap_hierarchy_free(dtpm_hierarchy);
 	powercap_unregister_control_type(pct);
 
+	dtpm_hierarchy = NULL;
 	pct = NULL;
 
 	root = NULL;
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 21355db6419d..ccfc97e96e66 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -16,6 +16,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuhotplug.h>
@@ -189,22 +190,53 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
+/*
+ * A hierarchy node identifies a policy through one of its related CPUs,
+ * which need not be online. Find an active policy through an online sibling
+ * when necessary. The caller must hold cpus_read_lock() and release the
+ * returned policy with cpufreq_cpu_put().
+ */
+static struct cpufreq_policy *dtpm_cpu_get_policy(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	unsigned int sibling;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (policy)
+		return policy;
+
+	/* The hierarchy's representative CPU may be offline. */
+	for_each_online_cpu(sibling) {
+		policy = cpufreq_cpu_get(sibling);
+		if (!policy)
+			continue;
+
+		if (cpumask_test_cpu(cpu, policy->related_cpus))
+			return policy;
+
+		cpufreq_cpu_put(policy);
+	}
+
+	return NULL;
+}
+
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
 
-	policy = cpufreq_cpu_get(cpu);
+	policy = dtpm_cpu_get_policy(cpu);
 	if (!policy)
-		return 0;
+		return NULL;
+
+	cpu = policy->cpu;
 
 	pd = em_cpu_get(cpu);
 	if (!pd || em_is_artificial(pd)) {
@@ -224,8 +256,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = dtpm_cpu;
 
-	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
-
 	ret = dtpm_register(name, &dtpm_cpu->dtpm, parent);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
@@ -240,7 +270,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		goto out_dtpm_unregister;
 
 	cpufreq_cpu_put(policy);
-	return 0;
+	return &dtpm_cpu->dtpm;
 
 out_dtpm_unregister:
 	dtpm_unregister(&dtpm_cpu->dtpm);
@@ -253,18 +283,24 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 
 release_policy:
 	cpufreq_cpu_put(policy);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static int dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
+static struct dtpm *dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np,
+				   const char *name)
 {
+	struct dtpm *node;
 	int cpu;
 
 	cpu = of_cpu_node_to_id(np);
 	if (cpu < 0)
-		return 0;
+		return NULL;
+
+	cpus_read_lock();
+	node = __dtpm_cpu_setup(cpu, dtpm, name);
+	cpus_read_unlock();
 
-	return __dtpm_cpu_setup(cpu, dtpm);
+	return node;
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
index e71f315fbb6b..222d9098cc98 100644
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
+static struct powercap_node rk3399_nodes[] __initdata = {
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
+static struct powercap_hierarchy rk3399_hierarchy __initdata = {
+	.nodes = rk3399_nodes,
+	.nr_nodes = ARRAY_SIZE(rk3399_nodes),
 };
 
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
-	{ .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
+	{ .compatible = "rockchip,rk3399", .data = &rk3399_hierarchy },
 	{},
 };
 
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index a4a13514b730..79a34d5923f4 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -38,7 +38,8 @@ struct dtpm_subsys_ops {
 	const char *name;
 	int (*init)(void);
 	void (*exit)(void);
-	int (*setup)(struct dtpm *, struct device_node *);
+	struct dtpm *(*setup)(struct dtpm *parent, struct device_node *np,
+			      const char *name);
 };
 
 enum DTPM_NODE_TYPE {
@@ -48,8 +49,7 @@ enum DTPM_NODE_TYPE {
 
 struct dtpm_node {
 	enum DTPM_NODE_TYPE type;
-	const char *name;
-	struct dtpm_node *parent;
+	const char *path;
 };
 
 static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
-- 
2.43.0

