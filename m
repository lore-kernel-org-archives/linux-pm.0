Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081668;
	b=IcBTgR/RODyZ2wOofmrKAyBucJYt4JoBl+PkDoGaHG1fDXL3gqq/G8CK/8Ou+6yOfqh0
	 4Z7wMhaium16XD2Rwn99GZfsR7I7qiHOzWAyBh5IANywWsqSvp4xeMMUXO0qBmQTi3lyq
	 5bxFmBH1OluwJwwi3AaowAyJnc9iqU3wWqU6hvVhpSA0CtvXuzyvG6CBPTVjjKk9cKR7E
	 ELgQdlK9ZMuJ6UjxfvIP3wQeTkeb7gjbzogu7DouSqmi4nQlul/SSA6zXAyLX6hv6ODmM
	 nlR1TF+3d36TyVP5a3YJazk3ocu/kw+vPuXTt4ruD+ptdlSxsWFqo9ErskSlJEWrDYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081668;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nDmOaGksnQ0ZaNPhnJ/CN/aXZ7Trn/wxpPpsg320EoE=;
	b=gOKAbsfVqVer5JCtjgwoa3WVZUF86CFUF5ar16qO64pZKRPHnIfHJmq/FS9UiuwBo94/
	 Rlx+NKDJPjfC6sW7ZAMB0zsDIJ0IQOUSps4nrxrFjFm5fZIMmeCC4GVC7L18Sap6aqgpF
	 GDyu1x3ySHL7boP5tFjmiHCwQl766qBum566wcs06bWuLAxAyNHp3QurvWLBOwBRL2IHK
	 x4yz8aPn+zYA0muYl67ghISjcXBmFJb38zmhNxoTnxXS8BvHbR5+B0Y6u7ESffNtRc0ay
	 WxPb/+wbDl4ahVKJnVHzVGVvfxMyFj/1gVObu/hzqmq2zN/gS2v0aZFBg5UwzqGTgKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=grSrW2LC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D8HEA365;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66060A3810
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F66060A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=grSrW2LC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D8HEA365
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6v3w71962317
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nDmOaGksnQ0
	ZaNPhnJ/CN/aXZ7Trn/wxpPpsg320EoE=; b=grSrW2LCeH3tmw9LSckOF8dcZ2I
	akabmrWgyHZSLF4ErBjqq4havvctuRmcuceDZBvvAPT7CS3YEomvPJRrJ04NbKhC
	ZF6Ukv2a0MZq2UWQaLiRgNy2cDKh3f9gLxUPznlqjS6qwtjkpt93YMDZ3F/6ReSQ
	f+awubHpr75Okd68rxH7jHDtaH20QZunPs1xBx1ND7rNDxzEy+oM73DzEMO5M6Wj
	0X4lqW/r/2OM9xEnk1XbVJcpqxvQY9fikPedW0UBvm4MIaf2lJkUy/UYk7jP1sGW
	D5dZznxuJkHHL3oT/WEiFfNZXMrPmCfLvEdgquaCAPuQNwGFaP0A9/MD2kA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcuneb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so143782085a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081667; x=1795686467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDmOaGksnQ0ZaNPhnJ/CN/aXZ7Trn/wxpPpsg320EoE=;
        b=D8HEA365JxjC+VThToO0huizG+Ps9jEaGAXAHCg9XyZoTph6nNhkwW63aMIh9W8SjN
         QY+iCsCxhfi1J7zS0LNEBOYoiaZoLsuRagzPHeMOC+zr/aOIwYKeKsnmapGatGX1LBFR
         LfJqAiKePzaf1RkohVaARzg/jddrT0cfzGExZ8sunkjO9ylqmdaqccX2gLFP0/+ySqad
         Te31BDQWwKcniOht56v1dJyV096wZgvQwh2u88BjbB7CEJhYLcjWm9BNyrw9xuv/IGjx
         yiUfnyhboS7T/j9mqeJlnquZiIwqH9kUdChbgJDefqpZXAPwD32DgPIrrRNbj6yaku+u
         iVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081667; x=1795686467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nDmOaGksnQ0ZaNPhnJ/CN/aXZ7Trn/wxpPpsg320EoE=;
        b=oMHxCF7dNnl5sew6djdk692t2PRU16kWRoGHqml/odDduqujnkeOPRMCQTt+Yv2KnC
         0Fo/3B67v5BuejrUr3IWhr5UlWkjurkZ+W1GZSpdcqnt/lE8xy4lBPJjM4VTWl63QUvl
         fcFMmchTyxgx8ZJc+hHHW/k1Y4Fw79dRjq2tIB/UAvPynguIiJLH1G5KKG77EQPOK4Ht
         TL0KPtLPXeQa4sZXPgN1KU23usBGet8BBgd+hkjBB3SKH+pn4WjcqER4m06aSoTC5hE3
         imQlYgh3dlvTezVB7mmhTFcOkjkaPaqACPOJIJhMBdiOM8q+jWmw/bqJEvvlHNnPlHiG
         8GPQ==
X-Forwarded-Encrypted: i=1; AL+hErEjqnI7LpfR4jVR33t/ARp6RAqY2mwq31nYgkE/Rns/3PP8KG25LTgUt3vNGGBboI+xdBDImJ8RsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+sTKJQ4qe7dY77pmjnOHnUZv9M3/6fyMoVe4MgGgfiDuvygeMc
	aPHFPC58ANT+tPAgQY/3hB3imcK3laHtdoDPDGsk5nx24gaQn3yFYyzN4bCabfKl6qp7fkljEcv
	NVV2yDtB6PqgrZ43u/kdRXCdF7nQ+xVt7FMzk/KAA7lrrXGHLXtp4JCdvOhdo6A==
X-Gm-Gg: AYBFou09Skbpdup0S7QIjv6MzgBFvsWmnwvmAPxKYn0AxaPPnElRTqBGRVVjONIin8D
	l5LY9A63IRRUwi9/HYSxZ9mZo8t8N3ta86ItkAPS/DiNB3+Avmo05ExhMf0aka0xSujgckIJd+L
	0FTq6gFPV7n9h474Oyu7VN4AezXVnHjsigU/sFryf/zylhlukRduaRLlY0PPCXJIVFeDMMJA2As
	zB9kLo4Z31TmRFMkBt8iXXx037f1+MZ1ezynV/aq66dRQs/2B0R6+rujGH8t+/v+sz0idPxdKcC
	a5hKN/MUn0j5qC2C0LWI7DR7/6yZ6eWjKEpD0vxtT3RRhxAkcwNxKb6vRaQzS/HRiMfzCGaIiVe
	XzZZNjboJVEMSvXXtUKT42LKp1E/1Yk8IhoWkb0/MtdSA9oG2o3dgdL7VZzIfpq+n8ThYcECe6m
	Ow
X-Received: by 2002:a05:620a:1d02:b0:949:6614:667c with SMTP id af79cd13be357-949b3572259mr75039785a.11.1795081666721;
        Thu, 19 Nov 2026 01:47:46 -0800 (PST)
X-Received: by 2002:a05:620a:1d02:b0:949:6614:667c with SMTP id af79cd13be357-949b3572259mr75035785a.11.1795081666069;
        Thu, 19 Nov 2026 01:47:46 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:45 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 09/12] thermal: of: Track registered hardware temperature sources
Date: Thu, 19 Nov 2026 10:46:51 +0100
Message-ID: <20261119094706.3439040-10-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afec5c3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=wuaHHyd7DoH6fRT8h70A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: UxKRN4LXkXdgD4Zo1wcSVnTqzP3zURa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfXyQpuvxMu7eGd
 j34HLqt+B+f4MM5G8VYk7xd5Aa2Wd7WCP8GclApjfRAaahs5LptyIeROKyqo42r/akOf17PW7uQ
 vQ9+3J5WSWRSrbRfk6PKJUM8HXQqH8RRrWfQZ7csjd6CNefnxe+g1O+DuBr05baD703grguznKv
 LpvLPX7ymxPSogqKMQTCmu54WmhdFswn058DT+hMNH6INd5UlCT5jZ6G7b+ixLOtJbQSyTjgVta
 jdgyC619jSb5y4nnrVnk56FyqR17ai2p1WV8v+i3NRAq7OMmLsbHiqgOUtijq3ji1EdaMBgCha6
 g7D0zIQ1yC7z8RScq+fPu0BEIUiZ5lk2SzeD3/5vHaDS965UrLCcp8h0gObqSIrZXT5VC1M9Ifs
 jUvCPBGddDAo/jA3ZYR9ISSmUGAAWechBjSewTPvgsmacGX4BTo0Y5nOBrSwJnrYz/wQbbvjVGw
 r+L6Vm9OZDcFhXAsEug==
X-Proofpoint-GUID: UxKRN4LXkXdgD4Zo1wcSVnTqzP3zURa6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX7LFstsCk40xA
 Vj82jUlhsh8ZtLTY0YXys2epRzBVekQPwTRayKzA9VVh3NQpPduyVS7JzI5TnnF4Va6THfRVUGI
 M9DfIep4URLfk5Df0taxuz3W6HLVw5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Record successfully enabled OF source zones by provider node and sensor
specifier ID. Serialize source publication and removal with an OF-private
lifecycle mutex and retain the provider node while its mapping exists.

Reject ambiguous duplicate provider and ID mappings. Remove the mapping
before unregistering the hardware zone, providing an ownership boundary
for subsequent OF aggregate consumers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 79 ++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 710ff25140e7..1fa7e29f5bc8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -18,6 +18,75 @@
 
 #include "thermal_core.h"
 
+#ifdef CONFIG_THERMAL_AGGREGATION
+struct thermal_of_source {
+	struct list_head node;
+	struct device_node *provider;
+	int id;
+	/*
+	 * Borrowed from the OF zone registration. The mapping is removed under
+	 * thermal_of_lock before the zone is unregistered. Aggregate consumers
+	 * acquire their own references while holding the same lock.
+	 */
+	struct thermal_zone_device *tz;
+};
+
+/*
+ * OF lifecycle operations are serialized outside thermal zone locks. Thermal
+ * callbacks must not acquire this mutex. Source removal holds it until all OF
+ * consumers have released their references, before calling core unregister.
+ */
+static DEFINE_MUTEX(thermal_of_lock);
+static LIST_HEAD(thermal_of_sources);
+
+static int thermal_of_source_add(struct device_node *provider, int id,
+				 struct thermal_zone_device *tz)
+{
+	struct thermal_of_source *source, *pos;
+
+	source = kzalloc_obj(*source);
+	if (!source)
+		return -ENOMEM;
+
+	guard(mutex)(&thermal_of_lock);
+	list_for_each_entry(pos, &thermal_of_sources, node) {
+		if (pos->provider == provider && pos->id == id) {
+			kfree(source);
+			return -EEXIST;
+		}
+	}
+	source->provider = of_node_get(provider);
+	source->id = id;
+	source->tz = tz;
+	list_add_tail(&source->node, &thermal_of_sources);
+	return 0;
+}
+
+static void thermal_of_source_remove(struct thermal_zone_device *tz)
+{
+	struct thermal_of_source *source;
+
+	guard(mutex)(&thermal_of_lock);
+	list_for_each_entry(source, &thermal_of_sources, node) {
+		if (source->tz != tz)
+			continue;
+		list_del(&source->node);
+		of_node_put(source->provider);
+		kfree(source);
+		break;
+	}
+}
+
+#else
+static int thermal_of_source_add(struct device_node *provider, int id,
+				 struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static void thermal_of_source_remove(struct thermal_zone_device *tz) {}
+#endif
+
 /***   functions parsing device tree nodes   ***/
 
 /*
@@ -359,6 +428,7 @@ static bool thermal_of_should_bind(struct thermal_zone_device *tz,
  */
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
+	thermal_of_source_remove(tz);
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 }
@@ -446,6 +516,15 @@ thermal_of_zone_register(struct device_node *sensor, int id, void *data,
 	tz = thermal_of_zone_register_node(np, data, ops, &tzp);
 	of_node_put(np);
 
+	if (!IS_ERR(tz)) {
+		int ret = thermal_of_source_add(sensor, id, tz);
+
+		if (ret) {
+			thermal_of_zone_unregister(tz);
+			return ERR_PTR(ret);
+		}
+	}
+
 	return tz;
 }
 
-- 
2.43.0

