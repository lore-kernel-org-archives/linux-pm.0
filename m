Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505854;
	b=r2qQgcwa/0KzgmdEujch+rV/iAmBit9q1XUjBVwclncu75vu+/Olb/tvLdZJQl/tkImq
	 KOa4JA5CwNxwDICp9DFx2tvLqjWV5bMxBIqH49Noo3aVN4D6sd4hBRBG8Aj6RmSMaprHg
	 fL9nHny7SDQ34/JoOQbFT6ALIxh+ox2Di7QZ4UyyWsKdxDHSORviBMzC5mlOnSGLs2GNa
	 vEhcV4fGA/PgsVAGhCIgbGNSNLVtKLPAfjRoraJso4S5kt8d/qp+KE+v8AadpXEX3O/xT
	 XRbXQiRudAy1Odz4T+IjhUqeeu5Dc/LoR4p1XXEBiJwjm7l230coW4we3h3PVH0fgkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505854;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vHiKqaX2ykSxhEvcPI8IFCKicVnRO5vR4jCtHfyJV+c=;
	b=PSc9BbjCJAZXCz+9ryE/nBgtIV9jA3myI9H30vJr3+RqG5VST33lmcIpaB4+qye2vOcb
	 0+fs9EyVSUNkyp/gs41s1NEk9oMctz4CwNiNSjxQ+0vTUAPtcZGZ3Ekhyyi2Eftzd8+Uv
	 ugkRTl34HFBIjgadS9+s3tj4Oy1ZCkGCEbAB47b6LiCBI+8ZdySw5vVYl3sIfRrljepp7
	 7Wqc+daPYNanv7bltYjd6bEZIlEUXBO4DlwLYBXGYNOKBoEPuur+mN7DsVnbb5q/2BKtR
	 iSGDIGzj+aKcQ3pVfv/N+8+ssKebLaPYdLIdbYu6+xCKSObu0JoXp6tzGg64z1lHtuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y4+Y+y6H;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHZ3qSly;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE060A4AD0
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEE060A4AD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y4+Y+y6H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHZ3qSly
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KD9sSA2809535
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vHiKqaX2ykS
	xhEvcPI8IFCKicVnRO5vR4jCtHfyJV+c=; b=Y4+Y+y6H7tECiSJqGZ2u6LdQepJ
	VqE510v08UIIAB/cXaRUz7ehsUOj9m6KzLN9wWt1xi63aPp8i5wzwhTVzF2riCye
	BEhtvBj8t3miQ4DUuq8NWZTV6J3zd38zTSgw5vZN+bb1pLSioN4Iyfj4YSzGf7qU
	Z6YX7skYf3GtIun6+392oQjTWwv+BLdB+D0ohAwFhgz4A5H/hhLyFQi6+TKkA4j7
	Qu6EJ3528M9ipzM4Pwiu3X29iPVNfAF74H7cGC9tycL4LXYFxAJyElH1kkvGIUP5
	3ruijhWwK9BLlVojz5bhmtdzjbqkQNh/Fs8sVyumwc7jz9Xe23Hr3rn+zGQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p2v67-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so14542185a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792505852; x=1793110652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHiKqaX2ykSxhEvcPI8IFCKicVnRO5vR4jCtHfyJV+c=;
        b=bHZ3qSlyUgeeSFqDpyz5WDjfM6l7XL9FL+jQRzKU3NOX2Htfo22eKPoSIvNmb3qTPQ
         WliOQcqJyKAoE08VFwGkaFMmxp6dPSWlhSIjkT50gZC/Kzux01dK057w7A7k3mNqjyI5
         JqjHNTg1F0q1ynnRxoUr84QfROkqTZm4pzZjlrkZ6eNxFBf+DH+Txpp2Q40uigEEexSL
         Ki80jow4v41o6JJpGS2Se/EEFO5+yjlsgimnCVvSL/nWdPOSB+Sm029zOEJljikvCwmv
         cQRu/A8IMtbPMApoZtO0BupKd3QH1P02iJFVQnpmA1GxO3vjHlSpVxLuNumwJ+23jXbr
         aG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505852; x=1793110652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vHiKqaX2ykSxhEvcPI8IFCKicVnRO5vR4jCtHfyJV+c=;
        b=i90E6hW2r9TOKG0BFQJ7yWe2dBKmkDuaQ2lp5B0e5eVy0aHEUiqYxCClVAi1Slv2Gy
         ty9NFop0CmeFGlW4SrVof80QVCV9T8YiXHkwwDFU8HsFa1ujOEoHPlSsYX3RxqkvB3Gd
         FY/xwPHlQxbyPeyWudIu3g1kX/ldz09tNGMJkNfDhDcxboNxjKOOwtGpAtZsmvV5s3tz
         7kc0G1Abb7z+lSNIW/zlW5gyF5IB6ym6txQzudG37ERz+lOAwbcdccy7274BnwF3O1gC
         vcGGyJ9hMDG09hclCQXxjCkgBVt5SKmvv1aSh6LnGhvM+ToLPwp8i27PJs5AqaD4FUyB
         zxOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHBJPEpNQH4EcHeQRieMcZ+nlou0l2roAtqdHgnEYVPC/fGIq34Nz9tSBEB0j3J106gV9hkGV7Sg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+Ki93zTNLMJbJm9ITLglmjnIvV8J6VXQvVzBi8DhPK2yqF6O+
	hDmgODkzu3iKhFG/C3MMS9zKI9ylzQE+ThdTtfJnIqCFyXP+FmngBEXrelvlAtLxuQDvEoQBgXY
	wA+X8xPtvNCm0SJIK5vpVdTc+/EovHthiwUw06rrvUROcIpZ7I/g95f8WtFXiww==
X-Gm-Gg: AYBFou2CwsfAHbwMlIOm6Dm7VDoitNpQsn5na0UcVEWRxODHDpTb6253MOfM/mairAx
	6vtIoX4AW9ggJE1WhN2/Gd5GL1BLI4RHq9JIyi1dNZba3I9onQkj61E20dczAKpVzxNrRFq7YFO
	RsA8J2hPMxcWApb6s70b+VGaktVergeDth/aelkJwhuU5XGDAzvYBCNSOMVEEpxQ1srz6wGU7Fr
	GqE2ipZplsaduQb0SNO/S52VRcrfde8cTDSYkxk6AUX4YuzjynxEG38HfC3MOYR4a8hDKaRYzLz
	AVe6b67eU6x9zZanbx7sB4+jkIDtUFPv0++jMkLDWiEJt7rjxs8+X4nqSKMuwvyYOqw1Z8SrDlW
	0P28lrFKq7Ifzfi8leKAKtq1ahXk=
X-Received: by 2002:a05:620a:3942:b0:93f:2236:a61 with SMTP id af79cd13be357-93f29d841c6mr1881351785a.61.1792505851666;
        Tue, 20 Oct 2026 07:17:31 -0700 (PDT)
X-Received: by 2002:a05:620a:3942:b0:93f:2236:a61 with SMTP id af79cd13be357-93f29d841c6mr1881342785a.61.1792505850954;
        Tue, 20 Oct 2026 07:17:30 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm6642276f8f.16.2026.10.20.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:17:30 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/6] powercap: Add generic zone hierarchy creation helpers
Date: Tue, 20 Oct 2026 16:16:51 +0200
Message-ID: <865bd0a9eb7cbd5af87f0dc60bd436613200fd07.1792504834.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: KgS_oTfRbUBdtl-z6JT1ps81cuAhQcHo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXxADdbPfSAcZX
 q6k0hB0iwh9+k2ns9kz9mpiAj4SxACFvQzDdQiYXVkSaNkNmSx9vMHXX9BW1aZ5hdZaVU5vCpdi
 smK50K9sG1ejH650/wjjVlPQEpYRavo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXx0wFElqcHC0S
 OAnMdWkiV2t8Zg37qz4qJkEuhIEGH8Ohipb5ZTNV2yCSE+170Ry1wWnet1V61JLiy9MeuzmcWuU
 JL8KRMSdWjhOGuFFeBpgCSRufcWbaGZYv/etN+M8IhYfJgNu6+3yeSYP5IXUJu6tAEDqFo66iwA
 zhlCcUsRE+15lZcD+yN73/C4iR7ZuD8zCc378w2eonZMTCwNGXB14mDu4WtXYIXPpaJPy8SmKrK
 5NcZc44eyMVD52vjJKkQ3Pb4nzEViLkRzmxGmUTilcSzKFz5QgY0RGLvEDgfIUWlXMiAZ8zcxAY
 BQnaF7Ai+HIEZAsdBSafed6h8FWAeW7a5BxXwzmSs6UWuO+ssHNeHvzlqZ50P+sV1aTR5rrMB0f
 aEKWYuFngx7oyttwmpOxkZDvwQhTTA5jWGIy8Wi3iEr6E9SJYBQ6wleHAFj8w6MriM6cMlQlKs3
 OeSUI8vZpg/AmuPEQGA==
X-Proofpoint-GUID: KgS_oTfRbUBdtl-z6JT1ps81cuAhQcHo
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad777fd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=ePbI5pmQYSbfls1t7MoA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200056

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

  static struct powercap_hierarchy hierarchy =
          POWERCAP_HIERARCHY_INIT(hierarchy, nodes, ARRAY_SIZE(nodes));

creates the following hierarchy:

  package
  |-- cpu
  `-- gpu

Drivers supporting multiple platforms may provide a separate static
hierarchy description for each platform. These descriptions and their
node arrays can reside in initdata: only the hierarchy selected for the
running platform needs to remain available after initialization.

Add powercap_hierarchy_dup() to turn the selected description into a
working runtime hierarchy. Copy its node array and rebase parent pointers
to the copy, allowing all original descriptions, including the unselected
ones, to be reclaimed automatically with init memory. The names and
backend-private data are not duplicated and must remain valid for the
lifetime of the working hierarchy.

Add powercap_hierarchy_create() to walk the description in order. The
hierarchy describes the topology, but only the controller knows how to
initialize a zone for its underlying hardware and which powercap
operations and constraints to register.

The controller therefore supplies a function of type powercap_node_create_t
as the third argument to powercap_hierarchy_create().
For each node, the helper calls this function with the control type, node
name, node-private data and the already-created parent zone, or NULL for
a root. The function uses these arguments to initialize its backend state
and call powercap_register_zone(), then returns the registered zone.

The controller also supplies a powercap_node_destroy_t function as the
fourth argument. The helper calls it to unregister zones during rollback
or destruction, passing the control type, zone and node-private data.
These functions adapt the generic traversal to controller-specific zone
creation and cleanup; they are separate from the powercap zone operations
used for subsequent power readings and limit updates.

The creation function may let powercap allocate the zone or embed it in a
backend-specific structure to retrieve private data later using
container_of(). For example, an embedded zone can be allocated and
registered inside this function as follows:

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

For an embedded zone, its allocation, private state and lifetime remain
under the control of the backend.

The creation callback returns the registered powercap_zone pointer. The
hierarchy helper stores this pointer to provide it as the parent of
subsequent nodes and to pass it back during hierarchy destruction.

Validate node names and require every parent to be an earlier entry in
the same array before creating zones. Reject an already populated
hierarchy with -EBUSY without modifying its existing zones. Provide
POWERCAP_HIERARCHY_INIT() for static instances used directly by the
creation and destruction helpers; duplication initializes its own lock.

A callback may return NULL to skip a node and its descendants while
continuing independent branches. Error pointers abort creation and
trigger rollback.

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
Link: https://patch.msgid.link/20260806110159.69690-2-daniel.lezcano@oss.qualcomm.com
Assisted-by: LLM
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Add a static initializer and clarify hierarchy ownership and locking.
- Check for existing zones and validate names and parent ordering before
  creation; use zone for the runtime pointer member.
- Allow NULL callback results to skip branches; keep errors fatal.
- Use explicit locking and a signed reverse-loop index.
- Explain the controller callbacks, their arguments and their relationship
  to zone operations; update the description and add Assisted-by attribution.

 drivers/powercap/powercap_sys.c | 204 +++++++++++++++++++++++++++++++
 include/linux/powercap.h        | 205 ++++++++++++++++++++++++++++++++
 2 files changed, 409 insertions(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 9197fa20d93f..a637929eefe3 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -667,6 +667,210 @@ int powercap_unregister_control_type(struct powercap_control_type *control_type)
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
+		copy->nodes[i].zone = NULL;
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
+	ssize_t i = (typeof(i))hierarchy->nr_nodes - 1;
+
+	/* Creation validates that parents precede their children. */
+	for (; i >= 0; i--) {
+		if (!hierarchy->nodes[i].zone)
+			continue;
+
+		powercap_node_destroy(pct, hierarchy->nodes[i].zone,
+				      hierarchy->nodes[i].data);
+
+		hierarchy->nodes[i].zone = NULL;
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
+	mutex_lock(&hierarchy->lock);
+
+	__powercap_hierarchy_destroy(pct, hierarchy, powercap_node_destroy);
+
+	mutex_unlock(&hierarchy->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(powercap_hierarchy_destroy);
+
+/*
+ * Validate the hierarchy description before creating any zones. The caller
+ * must supply a non-empty node array and hold the hierarchy mutex.
+ *
+ * Every node must have a non-NULL name. A NULL parent identifies a root;
+ * otherwise, the parent must be an earlier entry in the same array. This
+ * excludes self-parenting, cycles and references outside the array, ensures
+ * parents are processed before children, and makes reverse-order destruction
+ * safe. Multiple roots are allowed; sibling ordering and unique names are not
+ * required.
+ *
+ * Return 0 for a valid description, or -EINVAL if any node violates these
+ * requirements. Runtime zone state is checked separately by the caller.
+ */
+static int powercap_hierarchy_validate(const struct powercap_hierarchy *hierarchy)
+{
+	size_t i;
+
+	for (i = 0; i < hierarchy->nr_nodes; i++) {
+		const struct powercap_node *parent = hierarchy->nodes[i].parent;
+		size_t j;
+
+		if (!hierarchy->nodes[i].name)
+			return -EINVAL;
+
+		if (!parent)
+			continue;
+
+		for (j = 0; j < i; j++) {
+			if (parent == &hierarchy->nodes[j])
+				break;
+		}
+
+		if (j == i)
+			return -EINVAL;
+	}
+
+	return 0;
+}
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
+	mutex_lock(&hierarchy->lock);
+
+	for (i = 0; i < hierarchy->nr_nodes; i++) {
+		if (hierarchy->nodes[i].zone) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+	}
+
+	ret = powercap_hierarchy_validate(hierarchy);
+	if (ret)
+		goto out_unlock;
+
+	for (i = 0; i < hierarchy->nr_nodes; i++) {
+		struct powercap_zone *parent = NULL;
+
+		if (hierarchy->nodes[i].parent) {
+			parent = hierarchy->nodes[i].parent->zone;
+			if (!parent)
+				continue;
+		}
+
+		pcz = powercap_node_create(pct, hierarchy->nodes[i].name,
+					   hierarchy->nodes[i].data, parent);
+		if (IS_ERR(pcz)) {
+			ret = PTR_ERR(pcz);
+			goto rollback;
+		}
+
+		hierarchy->nodes[i].zone = pcz;
+	}
+
+	ret = 0;
+	goto out_unlock;
+
+rollback:
+	__powercap_hierarchy_destroy(pct, hierarchy, powercap_node_destroy);
+
+out_unlock:
+	mutex_unlock(&hierarchy->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(powercap_hierarchy_create);
+
 static int __init powercap_init(void)
 {
 	int result;
diff --git a/include/linux/powercap.h b/include/linux/powercap.h
index 603419db924c..1115108dcf5b 100644
--- a/include/linux/powercap.h
+++ b/include/linux/powercap.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/mutex.h>
 
 /*
  * A power cap class device can contain multiple powercap control_types.
@@ -309,4 +310,208 @@ struct powercap_zone *powercap_register_zone(
 int powercap_unregister_zone(struct powercap_control_type *control_type,
 				struct powercap_zone *power_zone);
 
+/**
+ * struct powercap_node - Description of a node in a powercap hierarchy
+ * @name: Name of the powercap zone.
+ * @parent: Parent node, or NULL if the node is a hierarchy root.
+ * @zone: Powercap zone created for this node. This field is managed by the
+ *	 hierarchy creation and destruction helpers.
+ * @data: Private data passed unchanged to the creation and destruction
+ *	  callbacks.
+ *
+ * This structure describes one node of a powercap hierarchy. The backend
+ * supplies an array of nodes through &struct powercap_hierarchy.
+ *
+ * Nodes must be ordered so that a parent appears before all its children.
+ * Duplication and creation validate this ordering. Reverse array order then
+ * guarantees that destruction removes children before their parents.
+ *
+ * The @name and @data objects must remain valid until the duplicated hierarchy
+ * has been freed. The @parent pointer is rebased by powercap_hierarchy_dup(),
+ * allowing the original node array to be released after duplication.
+ *
+ * The @zone field is runtime state managed by powercap_hierarchy_create() and
+ * powercap_hierarchy_destroy(). It is cleared when a node is destroyed.
+ */
+struct powercap_node {
+	const char *name;
+	struct powercap_node *parent;
+	struct powercap_zone *zone;
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
+ *
+ * A hierarchy passed directly to powercap_hierarchy_create() or
+ * powercap_hierarchy_destroy() must have an initialized lock. Use
+ * POWERCAP_HIERARCHY_INIT() for a static instance. A description used only as
+ * input to powercap_hierarchy_dup() does not need an initialized lock.
+ */
+struct powercap_hierarchy {
+	struct powercap_node *nodes;
+	size_t nr_nodes;
+	struct mutex lock;
+};
+
+/**
+ * POWERCAP_HIERARCHY_INIT - Initialize a static powercap hierarchy
+ * @name: Name of the hierarchy variable.
+ * @node_array: Array describing the hierarchy nodes.
+ * @count: Number of entries in the node array.
+ *
+ * The hierarchy and its node array must remain valid until destruction has
+ * completed. Only duplicated hierarchies may be passed to
+ * powercap_hierarchy_free().
+ */
+#define POWERCAP_HIERARCHY_INIT(name, node_array, count) { \
+	.nodes = (node_array), \
+	.nr_nodes = (count), \
+	.lock = __MUTEX_INITIALIZER(name.lock), \
+}
+
+/**
+ * powercap_hierarchy_dup - Duplicate a powercap hierarchy description
+ * @hierarchy: Hierarchy description to duplicate.
+ *
+ * Allocate a runtime hierarchy and copy the nodes from @hierarchy. Parent
+ * pointers are rebased to the duplicated node array and the runtime zone fields
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
+ * Return: A valid pointer to the created powercap zone on success, NULL to
+ * skip this node and its descendants, or an ERR_PTR() encoded error to abort
+ * creation and roll back all zones created by this invocation.
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
+ * Entries whose &struct powercap_node.zone field is NULL are ignored. After
+ * a zone has been destroyed, its zone field is cleared.
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
+ * Each parent entry must precede all its children in the node array. All zone
+ * fields must be NULL when this function is called.
+ *
+ * If a callback returns NULL, its node and all descendants are skipped.
+ * Their zone fields remain NULL, and independent branches are still created.
+ *
+ * If a callback returns an error pointer, all zones created by this invocation
+ * are destroyed in reverse order by calling @powercap_node_destroy. Therefore,
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
2.43.0

