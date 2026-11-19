Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081661;
	b=UywcSF6z92q8ynIl7aHsu6ejSkmrRBxgYhdoLGkew6/sobG9qpmrK/zPJRgm0Xwm3ZRn
	 QHn8nhJ8BjhqIIJ2l7PbFGIf7ed+nDARpfK5BxVX6Bsag2lz81vsaayd2pzkMnkZIEJp5
	 NqBf1/brK49v/ELjGYy5xz+XSq0EyUgPueKxZfUjDGWWyOitpKEE3TvHdcBgLHQ/uzg+k
	 wzb5t6bnu9IYCZG4foff59F6ZQbYM5aA152n+EnOnXIh2k2GvlFJNcE3ImYkDJCD+tLo7
	 QJh7BNkri9c70ycs2zl0hL+ztnevfv1vCbJv+piSxc7g0f2uYPqozwPaJ2tNvBcR5Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081661;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kQ09RfFpt/7TSUf6vYtxBT4XsWexinP0sVkBp8S2BrM=;
	b=iAeHs7wVQo+sNTphcDW86+yGfSe5Cm6s23CHnERWtQcujYAc6ASsUi9wdjiYaE4OrORm
	 OurXguy8eMvAgOm9w5fY6tjIXtNpU5bXeP5+Uzip0fEa4fMxnysex+88CZMpCw5d+hR5x
	 BWEW2eka8Vmoti8C7BeOm2atcAGRyWzD7SDzHU3ep30FADQJeSJcfPdHjsmULGvlSH0dP
	 G6DDNeL3jBLS6p+3/1AD6NqM8sut//kLlPM/ZndbqL+j2XdgESe4yZAznWsAQpRr9+g+X
	 z2UkH9/N139EtrnCmQVdzngM1tLFcKTi7H2x12Ycd3nYh8oeC6zUgNXJUWNcGk1L61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MIYEVFEl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ewvDjLK5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A5606A33A
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 839A5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MIYEVFEl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ewvDjLK5
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ7Zh7i3717944
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kQ09RfFpt/7
	TSUf6vYtxBT4XsWexinP0sVkBp8S2BrM=; b=MIYEVFEltmEqfyiITMokusBn6Ip
	UTovlinGpiD4kRfXbJQ21cj2s0bp4BYqHVtTOhrmxzw4UI1d6PPQ4Vke8oeAgrYz
	v4EawULtn8GLL3BWndy51LzRJFu8zt2GxdI6Ya8FzIQSiEQ4QcX/hOECUT1cacOQ
	TyHZYpiF0AJSYF78WBTcAt47ZbyPTc7WBJZcHK6k6qwCVvKQuR3x0XnpBoQeAFqr
	rdYoPvAKFw/pgjWZB1TsMzshGITQ394JgPYNbBUr823G21M1RxIN0y+M6ROZfGMH
	pye5HnDlc7XC103vOVPzC18NhLIur0bLq/9+UGvNuKeWyo/max5CgG8VhhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1vv2rknk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so242623685a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081658; x=1795686458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQ09RfFpt/7TSUf6vYtxBT4XsWexinP0sVkBp8S2BrM=;
        b=ewvDjLK5MkqMVAFDDrRrMvp8+SM3PpooHiYK3TwP4cPozjhmRTliT4WXfXWReMU9y9
         jivoplJCcvQh+BTNVS1oQ3irDySEvmgRSk5vMLvoP0x3Yq2ARA5g782n9xV20Znt+c1Y
         FCSqSRvMfjMLEMwZnuIY5ricPsEoDtfHx7/7/y6+tJTCGr+kl1JEzMCLh3961sdStwgI
         Aac2/SnEf66/ldbpI7U9qUWi08K2Uef08On7AqypsHR01CNZIfNrBtrz9mGUadEyDyIS
         kxwbFpg2A869WrzGiz9mvg5Nw9hyhaDs7BXmhRFZfjfPrwyuFrhTi6d5JY+clFgI4SZS
         Ni6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081658; x=1795686458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kQ09RfFpt/7TSUf6vYtxBT4XsWexinP0sVkBp8S2BrM=;
        b=TtY6BiPXa038LwIH1a22HyelKmB5bneKuynWYK1aATJ0JHY/uYrTc2LNB9RTyME6yX
         JeZ8fjUXDkcuQ6PngtjXd0ECNmq3+GOhF8kuzZ2wuv3kf7p3KXB4ysKhvO8Qs2E+zTh/
         5uI4mMuBYH1OASEsPPM4DgTmv5bOxP1WMBroNocmbGnE7NEb2dWzP/LhaJR+er7/XLOY
         8GfeBOgKMyMHkRh9svLLLqd3SkkzcY88kkTjHrJKEc8TlrQ7lZPriJwOCCgc5s3GnqNa
         GjDLeThu2XSiFJFQM7w8uz4Yl8idD+G1D3rgjFyvf9OQjBQxId9W6t1Zny9MyE9L7Q1X
         7MjA==
X-Forwarded-Encrypted: i=1; AL+hErFt02xdL/4/+021i7BuK5UoKO8jdmYVVkJURIaaWy2QglWalPRrGCdgCuZD5FPgfhF+h/BxvvkUBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9KKRkOvBzHg3WZKgUa4SU5onrnIUjGT0Hrrij5n/GmfauRBkmY
	dKaCAAdFa3kdcetlC24sPEmi2Ra6l+frZyYJERr/KOL6TOn0tXtBm1s3uNylpT3hU8Sh6wWTtMu
	Ot1IQdsvOyMXys9jtMaUrjcqul44uAhefxq4a24qEnDGzAaKBszkWqihm+kdYSA==
X-Gm-Gg: AYBFou2gweIWhmEq9EGRgU7VeAoBFCE7MoJPh1VmV3HksM0omB3gLWFiXf4Ik9Bo8NB
	c4MI2veohiUlNhdqb1Imn2aOQbROLYQQloFDAm/sx2pV0zS7x2XxmuuUFH0cKMiS+d9TDHhhQSM
	+og5YeM3lVNXEhA/dIwVtBTgBLClLaAPrBgKKR8U2+SXT8rty6+pfRf9PJD1pZKuBi0ChXDCVc6
	TFokLjkgVfiodaIOyPn18rFW3occOXPLav/dn5dElw/DSXG6FdwECShlKtnt5iggvWuAWTj+Rbt
	dnObi4xHgTZ+cvqSJzNKo2lOUKCO6aZz+eceJDt/dbjsxXnHMkwzhK33fbS6UHOJ9rfA3MUUUX1
	KdD9giRPIefT0IEU0ftbEWkFjyOuJeVoFNns2MC1D/SfBbCjXZWzQfoKG4XCuPlQxdfHZtGlDpS
	+G
X-Received: by 2002:a05:620a:2b4d:b0:949:33a9:8eea with SMTP id af79cd13be357-94999357739mr868563985a.0.1795081658278;
        Thu, 19 Nov 2026 01:47:38 -0800 (PST)
X-Received: by 2002:a05:620a:2b4d:b0:949:33a9:8eea with SMTP id af79cd13be357-94999357739mr868561285a.0.1795081657561;
        Thu, 19 Nov 2026 01:47:37 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:36 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 03/12] thermal: core: Validate thermal zone aggregation descriptions
Date: Thu, 19 Nov 2026 10:46:45 +0100
Message-ID: <20261119094706.3439040-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
References: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: ZwE-NkeamHlOgnXzUOsaMF9ozzCFJJGj
X-Proofpoint-ORIG-GUID: ZwE-NkeamHlOgnXzUOsaMF9ozzCFJJGj
X-Authority-Analysis: v=2.4 cv=ZZWIpcVA c=1 sm=1 tr=0 ts=6afec5bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=X8vhqgn2fEPoIbAfx2EA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX89zzd/YsdXgY
 LnhUWakHw3ljo3uqaPwQbCob9RWV21c6/7t//of5nG1mUNOgJJUqxXfiuOY00o5yuMixbk8CrA+
 1vgnAd0uzqmio0PK59OifTKL5/awbPo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX8wWOYgZwbdBU
 +Ljg0za/idNM5HyJvC0owJrsXY+EXrTnX9VcMJUOMbpsTNgRREgkkgPAa9t5OyOuJStObtgYTnH
 lnh5LB6PRYX54R8MG5/bftzujaWZWYzHqOF05xOHsQxC0KbHFKrxtPhwnun2oYHmCzJpyXJ57nj
 iSrpVDGvE6ntZw/R4Y8OybCxx61qp2qWOE4cxVva/9f9km8ykiALbEL6ViqlqBPQDpUFC3d/uZx
 Va+s/K38ySZOvA68+lNVI0cGTwUXv0ysP65affkdhnidkb6WixLbKB6JMwuFt1dvmyHPkyJQPra
 i9GkGzHs048Jp7NQMso5pBZOiP9ICW95JOl2/z43Ua8ay0XPFNVw47eZVrLNMcDiTfqGUQpTLLQ
 2c70Yn0ZAfxH4uzHSZAvc/InA9F3JuoLfUHi8bvwDgmfgQpmmBPTCVwh2yfpIS1lY0ksh0PAQ7f
 7yMVXSROiT3B8P/3rzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190038

Add a private helper to validate aggregation descriptions before
coefficient initialization and publication. Introduce thermal_aggregation.c
and build it as part of thermal_sys when CONFIG_THERMAL_AGGREGATION
is enabled. Keep aggregation optional and independent of OF support. Check for nonempty entries, valid
source zones, and sources that have not started exiting. Registered
non-aggregated sources already have a temperature callback, so there
is no need to check it again.

Accept the destination operations and reject set_trips because an
aggregate temperature window cannot directly program hardware
thresholds on its individual sources.

Before initialization, use zero to identify unspecified coefficients.
Accept either a complete nonzero coefficient set or an all-zero set
requesting averaging defaults, and reject partial specification. Keep
this check in the validator. Do not apply the presence check after
initialization, where zero is valid for temperature calculation.

Reject aggregated sources because aggregations of aggregated zones are
not supported yet. Inspect each source under its zone lock and document
that callers must hold valid source references and preserve the validated
configuration. Validation does not acquire references or prevent removal.

Leave invocation to the subsequent aggregation initialization changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/Kconfig               |  8 +++
 drivers/thermal/Makefile              |  1 +
 drivers/thermal/thermal_aggregation.c | 76 +++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 drivers/thermal/thermal_aggregation.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 810eeccedfba..b5185084eac1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -17,6 +17,14 @@ menuconfig THERMAL
 
 if THERMAL
 
+config THERMAL_AGGREGATION
+	bool "Thermal zone aggregation"
+	help
+	  Allow thermal zones to calculate their temperature from multiple
+	  existing thermal zones using signed coefficients and an offset.
+	  This also enables discovery of multi-source zones in Device Tree.
+	  If unsure, say N.
+
 config THERMAL_NETLINK
 	bool "Thermal netlink management"
 	depends on NET
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 3b249195c088..d059ca528908 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o
 thermal_sys-y			+= thermal_trip.o thermal_helpers.o
 thermal_sys-y			+= thermal_thresholds.o
+thermal_sys-$(CONFIG_THERMAL_AGGREGATION) += thermal_aggregation.o
 
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
diff --git a/drivers/thermal/thermal_aggregation.c b/drivers/thermal/thermal_aggregation.c
new file mode 100644
index 000000000000..f85f5a487d60
--- /dev/null
+++ b/drivers/thermal/thermal_aggregation.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/errno.h>
+
+#include "thermal_core.h"
+
+/**
+ * thermal_zone_aggregate_validate() - check an aggregation before initialization
+ * @aggregate: aggregation description to validate before coefficient initialization
+ * @ops: operations of the destination thermal zone
+ *
+ * The caller must hold valid references to the source zones and keep the entries
+ * stable. Take each source lock separately to inspect its parameters and state;
+ * the caller must not hold a thermal zone lock.
+ *
+ * Aggregations of aggregated zones are not supported yet: every source must be
+ * a registered, non-aggregated thermal zone. This also rejects
+ * a source whose parameters already reference this aggregation description.
+ * Source membership and non-aggregation must remain unchanged after validation.
+ * Validation does not acquire references or prevent subsequent source removal.
+ *
+ * Before initialization, zero denotes an unspecified coefficient. Either all
+ * coefficients must be supplied or all must be zero to request averaging
+ * defaults. This presence check must not be applied after initialization:
+ * zero is valid in the temperature calculation.
+ *
+ * Return: 0 on success, -EINVAL for an invalid description, partial coefficient
+ * specification, aggregated sources or destination set_trips,
+ * or -ENODEV for missing or exiting sources.
+ */
+static int __maybe_unused
+thermal_zone_aggregate_validate(struct thermal_zone_aggregate *aggregate,
+				const struct thermal_zone_device_ops *ops)
+{
+	unsigned int initialized = 0;
+	unsigned int i;
+
+	/* An aggregation needs a description and at least one source entry. */
+	if (!aggregate || !aggregate->entries || !aggregate->num_entries)
+		return -EINVAL;
+
+	/*
+	 * Destination operations must exist, but cannot program hardware windows:
+	 * aggregate temperature boundaries do not directly map to source thresholds.
+	 */
+	if (!ops || ops->set_trips)
+		return -EINVAL;
+
+	for (i = 0; i < aggregate->num_entries; i++) {
+		const struct thermal_zone_aggregate_entry *entry = &aggregate->entries[i];
+		struct thermal_zone_device *source = entry->tz;
+
+		/* Reject unresolved sources before inspecting their zone state. */
+		if (IS_ERR_OR_NULL(source))
+			return -ENODEV;
+		/* Before initialization, zero requests a default contribution. */
+		initialized += entry->coefficient != 0;
+
+		guard(thermal_zone)(source);
+		/* A reference protects lifetime, but does not prevent source exit. */
+		if (source->state & TZ_STATE_FLAG_EXIT)
+			return -ENODEV;
+		/* Nested aggregation, including a direct self-dependency, is unsupported. */
+		if (source->tzp && source->tzp->aggregate)
+			return -EINVAL;
+	}
+
+	/*
+	 * Require either a complete explicit combination or all-zero coefficients
+	 * for averaging defaults; there is no defined default for a partial set.
+	 */
+	if (initialized && initialized != aggregate->num_entries)
+		return -EINVAL;
+
+	return 0;
+}
-- 
2.43.0

