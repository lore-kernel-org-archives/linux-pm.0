Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789654;
	b=4TV8lNaHV6Tv0UhH/wcpubxLeQUWsestu+WzBO/TBMYu/3cEysIvaNhz83guc2OBYmos
	 71445GXwVs0YbFqAskWLO4oQSQHz9nxwh9r5zZYrYxAILxFEzTntbTYEY/7TDFH5h3xBT
	 UN7oM65jr63v8I/XNqq46NyWRC96wVfxpWE96O4GHDyqHPsLlau1BclcY8Wxr0qd1OWZi
	 j5bicnYFgtcadOCt4eVTNmejVpVZZba0Bpl1Y6ZFYNZPsaSys5K3ektY4qPnipjAfiLmo
	 w3v8OQdmXbMtt3H4NJOixSgu0xU/UI1hOLXpooS9GlFoFk/CM0VtYDhiIndY/DBvFmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789654;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/SfJcCGNKkT/E4Ek6XA5d83FNM9Un0MoHBNaGgIbofY=;
	b=tWfx+ruqcqFetg4MXzXmO3BmvO++dVn1uHlt0TC81FRJIVODNZaZuJvoITCGTd2pO6iV
	 RRzbYhJgfgJ3zrl5RjIeeed7bCIdtTqAoKABQ8oYhDi80oqpgBXKzzj4WOaHExop0pNfo
	 g9sRqSuDHKA3DAJrmQvZXeW4WBRFiDAzeDg3fTSmqD+N7ID870sNhtx0+DM76YRTPBrKg
	 p3n+eXbA8cmvXOqHZqxSLiY/sMDD42UMLzIbnFI+hu5L6hRs8GHFOEaNLsaWBWhEAsany
	 bGRSHrvQQ/nx5o5LVAwvUzEqNtBO2OObfNTEWrQ146ms0bQJkmAFB4+lnmkgcvVeHNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oA7dDZMt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2vnXEiX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD915606B1A3
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD915606B1A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oA7dDZMt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2vnXEiX
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Sj02472017
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/SfJcCGNKkT/E4Ek6XA5d83FNM9Un0MoHBNaGgIbofY=; b=oA7dDZMtFkhAIQog
	L4dwxKeDAQVPqJHnslKN5lu5c1RjzkxxXModsJndPbbGWxSoecLOO8uoitfyJuKk
	exFUldarK0VwpxGCwGzYERRa19GfDPwOd792erbdEWmpvIn3EJpgFPo9hBwBwIHi
	J3BblOED7NlF307nU+x2nXr79jXLA1+8EhAjR0XlXYXRkE9lV8lOcd5Y44bWgIG9
	YLyri8+9zZ6T55oZDJM79cEsulvCwQ+T6RESIoZIq9Nfu2+vJp04Iy/oA5WBbkkY
	vy7jUAxtXwPMnKs/d5ul3DVxEBpJlsdLkiGcUbafSAasxU3xHw8dH3hkEPW7ZaU2
	2Q1lxQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gasu7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f0467a525eso61250905ad.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789652; x=1796394452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SfJcCGNKkT/E4Ek6XA5d83FNM9Un0MoHBNaGgIbofY=;
        b=X2vnXEiXnarjYRhfhwJnH89UqsIox4fhMSouyw46LexbTz46w8PXOTOvbiPdzDyhx6
         XcmwAM7y+85jA+dnN3q9KFgzneUV4fSnlrBWtQGYTXR4kbNJbdpuJ4vXgqSLbijUTsIQ
         8a7HtrbBQCOEDkFzGd/qyT+I7flDqfBorR6L7ZvMzSt915iab6oHX79oMNTA+4GmG4HX
         8HjesmHhQmGOqo9FJdLECY/fW0oFRFl/lplYegXLmxiWt892RDdZt8t1P6NqTpl4+c41
         po69X4kCDooapl+9+/xgrxuwdvFIgf8zFC3fbbGZge+4fdr7Q5Pqq9Mkjxt0P7oBXJuL
         ahHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789652; x=1796394452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SfJcCGNKkT/E4Ek6XA5d83FNM9Un0MoHBNaGgIbofY=;
        b=R0hUfDHMKzP1oexHXBbFH50aCd1aMKw6NYUeJbfOVqNcKqhzbAiDHy42qVlYqJaskK
         2yN1BZBGt+LmuE/X+yg66ZPVxyQT+9iiUvQwHeb9VuPWcgSfPJX7+MWNQn++EY4xi/3H
         UfhJweZFD6RhDNZRSNi+tRNumNaZcjwBmraIgFozZWRY5FdYSMJvCaJfQi+dbgBFKb5M
         M4SkjlyEHlKjffP1E1Nig3/2cScdCuaFxAjkE/IUmUGdS3BCHssnD41LHpt778cCm0hm
         IqzkoCBcP6QlcgFUjag054KrOP63DCF8/oHm+R+cs96asnJPy05i3rX+//KAwWymtHft
         7sAg==
X-Forwarded-Encrypted: i=1; AL+hErH9O9i3UvccKl7pq6X8RDnCC8NHbyiClEDMpGUrxFSw/6BywY2RAub0nikU6Eh/zmOj2kSu3tfk+A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+KS1+t5dLLbRwEZi/VDD8xJgzwP+98n9777Me3ZHoNVp/HqtOX
	Cv7RdlzR72zgjmZGNldZqJEem+gRtFGkox5Wku+CkM2L4CavdlCjx69RmT6rQQ5wSsHQ150BqTq
	CYZToq/gn4EAq+I3ekYPw/g3cbsYl/alBirttC8KKibYduLJKSShoFGlyGxl9uA==
X-Gm-Gg: AZFdTZd9OfRdeQ0Le55ffKpUNS5OorOInHB2f35nzDBLXEPKD5aMN1zJVxAe1kNKUxB
	uPDBIiYzr0ICsKEC/U0IstrRI1CRNTOU6k5YeDLTofQGeFZV2WvVm6ZnZqf0nZPeL0CbdygPDri
	Erdp0aF34l9Hz6jIsyoCrj7TPTDyNhwBySbLRh70yAbQhf79U3RnpKkEQ09S8gTUssiY1aeiwnT
	ctoxkNOMGC8ipV23kN8xLcgNWjP04KZ7kRO9p2tXGPNPSVKVOaCiH8yAiW5r8EqK8I03hy6hYiH
	RAe/er4rPOdkeGe2AgKSPeC9TtJ0t6RyQ/BNlEjVX6A6v3gJhM45k6V2p+6vw7+QZqeSO9CslAD
	H1sd4KcBRPY0jRWJoyRlBnCnCNaIuKXJN7ViZ8BjL1HDC1XSkBvhKiRsiDC+Jm4GSUgI5OBgpBs
	98ZdprVyHzRw==
X-Received: by 2002:a17:902:e845:b0:2e9:5714:6087 with SMTP id d9443c01a7336-2f03ef58f10mr266738555ad.5.1795789651503;
        Fri, 27 Nov 2026 06:27:31 -0800 (PST)
X-Received: by 2002:a17:902:e845:b0:2e9:5714:6087 with SMTP id d9443c01a7336-2f03ef58f10mr266738115ad.5.1795789651015;
        Fri, 27 Nov 2026 06:27:31 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:27:30 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:56:55 +0530
Subject: [PATCH v28 02/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-2-da05a33b08d8@oss.qualcomm.com>
References: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
In-Reply-To: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=12560;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ilvNmoFw4/09/JwDUUvn0nqKtP/xLfFcsRs3p57CAdA=;
 b=IxUYTbXprOtwN4Yp8yukHWLchcgp5azJ2zCbZFBA6/4nsTB2pkxNItmzq7lCjzDXiRNUK8a6R
 +B/wGSBsshZCxLZMBwb2DcCDn6I3BykRCgIZaINyYjzP8y+eCX7jOPG
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-ORIG-GUID: _GYfIUuHlPr9oWB2fYtnaqZI8NErYwRM
X-Proofpoint-GUID: _GYfIUuHlPr9oWB2fYtnaqZI8NErYwRM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX4So2/EE4gzX4
 EnNIBMAfT+KNDsn6jw6ptjx+HiTrl/64pfhTSe1nIVMmoQwahGiPE9ekj3U8xG7zhO+BrEk2Nlo
 NzHXwJRLOGF5oR5NCcYY1GEnYk2Hi5l221uw5rZZdguvuiZZxxWctl8qpASgAVvnYoXVj9ubzTt
 OMchScrhWHbbC8URd4o54yh94WqfcGcEANUoqiGX+zy4CdBdnEBbs7rUqDzweSkwfVEyCbozC5V
 8aG7xagd1YrCQiG5zAAcdT8ABd8PBK4i2K4qnd9jILxaiBwdk+JDl1cqNkIt3/T+/dlSzmEPByo
 qJ60MWaAYohfnfqYeC/OqDvdcLSVqWytKweRWXgfAtMFq2v2QABWWPuIx1PcNCxYr7aQjY1bOsX
 nLYFqE0jttTJZS+2BYjz5hwCSyjbZozB1g0FMVLV5eQyOfyiSanzszhR+XAjQj7iIxARNjblBM4
 q59CsgW7bu7I4Djk6zQ==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b099354 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=S_7UqdFmbgqGN4e7PDYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfXxhA7T9yA+jAZ
 gBbpfTIFBwl1TSHNXf4foNLOA4vD2RA+/sn2k1lwd8qTYQoYtx6v6PLBiAUHSBV9D0+1qXhzo0M
 xbUAQR5SW4MUGbwDI0mJirJH1Rg3R4M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

reboot-mode based drivers can define a reboot-mode by adding it under
the reboot-mode node in device tree. This limits such drivers, to define
any predefined reboot-modes statically within the driver and creates a
dependency on device-tree.

Extend the reboot-mode framework to support driver-defined predefined
reboot modes. Add a centralized initcall to initialize driver state
along with predefined modes.

Acked-by: Sebastian Reichel <sebastian@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  |   7 +-
 drivers/power/reset/qcom-pon.c           |   7 +-
 drivers/power/reset/reboot-mode.c        | 192 ++++++++++++++++++++++---------
 drivers/power/reset/syscon-reboot-mode.c |   7 +-
 include/linux/reboot-mode.h              |  26 ++++-
 5 files changed, 175 insertions(+), 64 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 19d12a59383fd..c25f0371aacf2 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -51,8 +51,11 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
 	if (!nvmem_rbm)
 		return -ENOMEM;
 
-	nvmem_rbm->reboot.dev = &pdev->dev;
-	nvmem_rbm->reboot.write = nvmem_reboot_mode_write;
+	ret = reboot_mode_driver_init(&nvmem_rbm->reboot, &pdev->dev,
+				      nvmem_reboot_mode_write, NULL,
+				      NULL, 0);
+	if (ret)
+		return ret;
 
 	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
 	if (IS_ERR(nvmem_rbm->cell)) {
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 112d1bcefedf5..5a44b16469f7f 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -84,9 +84,12 @@ static int qcom_pon_probe(struct platform_device *pdev)
 	reason_shift = (long)of_device_get_match_data(&pdev->dev);
 
 	if (reason_shift != NO_REASON_SHIFT) {
-		pon->reboot_mode.dev = &pdev->dev;
+		error = reboot_mode_driver_init(&pon->reboot_mode, &pdev->dev,
+						qcom_pon_reboot_mode_write, NULL,
+						NULL, 0);
+		if (error)
+			return error;
 		pon->reason_shift = reason_shift;
-		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
 		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
 		if (error) {
 			dev_err(&pdev->dev, "can't register reboot mode\n");
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 328fa37598df3..2345ebd2c1ef7 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -30,12 +30,12 @@ struct reboot_mode_sysfs_data {
 	struct list_head head;
 };
 
-static inline void reboot_mode_release_list(struct reboot_mode_sysfs_data *priv)
+static void reboot_mode_release_list(struct list_head *head)
 {
 	struct mode_info *info;
 	struct mode_info *next;
 
-	list_for_each_entry_safe(info, next, &priv->head, list) {
+	list_for_each_entry_safe(info, next, head, list) {
 		list_del(&info->list);
 		kfree_const(info->mode);
 		kfree(info);
@@ -119,6 +119,80 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+/**
+ * reboot_mode_driver_init - Initialize reboot-mode state
+ * @reboot: reboot mode driver object to initialize
+ * @dev: backing device
+ * @write: write callback to program a single magic value
+ * @write_array: write callback to program multiple magic values
+ * @predefined_modes: optional predefined reboot-mode table
+ * @predefined_mode_count: number of entries in @predefined_modes
+ *
+ * Exactly one write callback must be provided by the driver.
+ *
+ * This function must be called with a valid @dev before calling
+ * reboot_mode_register().
+ *
+ * Returns: 0 on success or -EINVAL if callback/predefined mode configuration
+ * is invalid.
+ */
+int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
+			    struct device *dev,
+			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magic),
+			    int (*write_array)(struct reboot_mode_driver *reboot,
+					       const u32 *magic, u32 count),
+			    const struct reboot_mode_entry *predefined_modes,
+			    size_t predefined_mode_count)
+{
+	if (!reboot || !dev)
+		return -EINVAL;
+
+	if (!write == !write_array)
+		return -EINVAL;
+
+	memset(reboot, 0, sizeof(*reboot));
+	reboot->dev = dev;
+	reboot->write = write;
+	reboot->write_array = write_array;
+	reboot->predefined_modes = predefined_modes;
+	reboot->predefined_mode_count = predefined_mode_count;
+	INIT_LIST_HEAD(&reboot->head);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reboot_mode_driver_init);
+
+static struct mode_info *reboot_mode_create_info(struct device *dev, const char *mode,
+						 const u32 *magic, int count)
+{
+	struct mode_info *info;
+
+	if (!mode || mode[0] == '\0') {
+		dev_err(dev, "invalid mode name\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	info = kzalloc_obj(*info);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->mode = kstrdup_const(mode, GFP_KERNEL);
+	if (!info->mode) {
+		kfree(info);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (!memchr_inv(magic, 0, count * sizeof(u32))) {
+		dev_dbg(dev, "reboot mode %s with zero magic values\n", mode);
+		info->count = 0;
+	} else {
+		memcpy(info->magic, magic, count * sizeof(u32));
+		info->count = count;
+	}
+
+	return info;
+}
+
 static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
 {
 	struct reboot_mode_sysfs_data *priv;
@@ -160,11 +234,38 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	reboot_mode_release_list(priv);
+	reboot_mode_release_list(&priv->head);
 	kfree(priv);
 	return ret;
 }
 
+static int reboot_mode_add_predefined_modes(struct reboot_mode_driver *reboot)
+{
+	const struct reboot_mode_entry *modes = reboot->predefined_modes;
+	struct mode_info *info;
+	size_t i;
+
+	if (!modes)
+		return 0;
+
+	for (i = 0; i < reboot->predefined_mode_count; i++) {
+		if (modes[i].name && strpbrk(modes[i].name, "\n ,/"))
+			return -EINVAL;
+
+		if (!modes[i].count || modes[i].count > ARRAY_SIZE(modes[i].magic))
+			return -EINVAL;
+
+		info = reboot_mode_create_info(reboot->dev, modes[i].name,
+					       modes[i].magic, modes[i].count);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
+
+		list_add_tail(&info->list, &reboot->head);
+	}
+
+	return 0;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -173,7 +274,7 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
  */
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info = NULL;
+	struct mode_info *info;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
@@ -183,52 +284,36 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
-	for_each_property_of_node(np, prop) {
-		memset(magic, 0, sizeof(magic));
-
-		if (strncmp(prop->name, PREFIX, len))
-			continue;
-
-		count = device_property_count_u32(reboot->dev, prop->name);
-
-		if (count <= 0 || count > ARRAY_SIZE(magic) ||
-		    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
-			dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
-				prop->name);
-			continue;
-		}
-
-		info = kzalloc_obj(*info);
-		if (!info) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
-			dev_dbg(reboot->dev, "reboot mode %s with zero magic values\n",
-				prop->name);
-			info->count = 0;
-		} else {
-			memcpy(info->magic, magic, count * sizeof(u32));
-			info->count = count;
-		}
-
-		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
-		if (!info->mode) {
-			ret = -ENOMEM;
-			goto error;
-		} else if (info->mode[0] == '\0') {
-			kfree_const(info->mode);
-			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
-			goto error;
+	if (np) {
+		for_each_property_of_node(np, prop) {
+			memset(magic, 0, sizeof(magic));
+			if (strncmp(prop->name, PREFIX, len))
+				continue;
+
+			count = device_property_count_u32(reboot->dev, prop->name);
+
+			if (count <= 0 || count > ARRAY_SIZE(magic) ||
+			    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
+				dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
+					prop->name);
+				continue;
+			}
+
+			info = reboot_mode_create_info(reboot->dev, prop->name + len,
+						       magic, count);
+			if (IS_ERR(info)) {
+				ret = PTR_ERR(info);
+				goto error;
+			}
+
+			list_add_tail(&info->list, &reboot->head);
 		}
-
-		list_add_tail(&info->list, &reboot->head);
-		info = NULL;
 	}
 
+	ret = reboot_mode_add_predefined_modes(reboot);
+	if (ret)
+		goto error;
+
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
@@ -239,7 +324,6 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	kfree(info);
 	reboot_mode_unregister(reboot);
 	return ret;
 }
@@ -272,7 +356,7 @@ static inline void reboot_mode_unregister_device(struct reboot_mode_driver *rebo
 	if (!priv)
 		return;
 
-	reboot_mode_release_list(priv);
+	reboot_mode_release_list(&priv->head);
 	kfree(priv);
 }
 
@@ -282,17 +366,11 @@ static inline void reboot_mode_unregister_device(struct reboot_mode_driver *rebo
  */
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
-	struct mode_info *next;
-
 	unregister_reboot_notifier(&reboot->reboot_notifier);
+	reboot->reboot_notifier.notifier_call = NULL;
 	reboot_mode_unregister_device(reboot);
 
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		list_del(&info->list);
-		kfree_const(info->mode);
-		kfree(info);
-	}
+	reboot_mode_release_list(&reboot->head);
 
 	return 0;
 }
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index 946b6774d5e58..be4864e18bde5 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -45,8 +45,11 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 	if (!syscon_rbm)
 		return -ENOMEM;
 
-	syscon_rbm->reboot.dev = &pdev->dev;
-	syscon_rbm->reboot.write = syscon_reboot_mode_write;
+	ret = reboot_mode_driver_init(&syscon_rbm->reboot, &pdev->dev,
+				      syscon_reboot_mode_write, NULL,
+				      NULL, 0);
+	if (ret)
+		return ret;
 	syscon_rbm->mask = 0xffffffff;
 
 	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 29ae39935d690..560d8b4d67acf 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -4,14 +4,38 @@
 
 #include <linux/types.h>
 
+struct reboot_mode_entry {
+	const char *name;
+	u32 magic[3];
+	u32 count;
+};
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	/*
+	 * Optional predefined reboot-mode table.
+	 *
+	 * Must be initialized before reboot_mode_register() and remain valid
+	 * until reboot_mode_unregister().
+	 *
+	 * If a predefined mode name duplicates a DT-defined mode name,
+	 * the DT-defined mode takes precedence.
+	 */
+	const struct reboot_mode_entry *predefined_modes;
+	size_t predefined_mode_count;
+	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic, u32 count);
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
-	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic, int count);
 	struct notifier_block reboot_notifier;
 };
 
+int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
+			    struct device *dev,
+			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magic),
+			    int (*write_array)(struct reboot_mode_driver *reboot,
+					       const u32 *magic, u32 count),
+			    const struct reboot_mode_entry *predefined_modes,
+			    size_t predefined_mode_count);
 int reboot_mode_register(struct reboot_mode_driver *reboot);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,

-- 
2.34.1

