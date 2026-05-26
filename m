Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861083FCB05
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804533; cv=none; b=rUu6sxu8Vbj5ijJc33tDUwBlHpJSk/JQS/CrtiBpVKmCE6xGzSQra22+sSnOnDSORQDCk26VXNWzv+ZOMyPEaO+7UqPhvN08gafa2idxEmz0EVoLlt/ydkRux1zNaGSVvu2wncM2yMPGal/TILRU4OSTuJBLLkeI5W/+ZVEvjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804533; c=relaxed/simple;
	bh=7dX7hdhE7h1bitnmsToIwIHIsKJlo/hPnNjvKONOWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6oob239DsJD0dtMTKtiVNjhKmz1etUrjN0AnsaWRSdBAGZi0vX1IgMpdF2QJkEVgNtc1S1gL5+bdb3ER6M2vjuEedCX+Na8yIldfP+XAg0ouevkFuG3T/jNTdp12noerTFlP3SUfzyrz8ORfZiqOA0feA3mVofo6wml4uP+44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a3iHGobo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h/m5gPIX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a3iHGobo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/m5gPIX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsP6L2697728
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ir9oiuM7tR5
	wYmgTBAGQuTYLqmp/Ld1gghBN/IRuvnM=; b=a3iHGoboCkCeekCBAEavrL2ZzC2
	l46K7qGDx3LX5Y/BPKltUvW5hIfxVxdmGfRCE5w97STWiW3+WNduPXVORMyBqJCk
	yp66JQqmgPoCmBLBjS06BJdw4aytkTVOqNu0TJx7rmm+6eKLRsYwEoBm+H4JBbYD
	gMl0GSboLPNNLj8CLWFUcB2A47tTJBPuAny1EELx+ZRu5jjDdBM3+MY3wGEzmkkp
	A5FnTLgNIMzk2lnmJ4rwfqAVXrJIoRp4G8oK4eJdxuRqw8s58YHzJEpmMYfuAitX
	v4NY0OeFUBcjIsPqDvF7jCuXUu1PlKxYGmWN+Bq69kSIvbTHyfRq+7mVjCA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm046gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:49 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95ce07ddc14so13611674241.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804529; x=1780409329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir9oiuM7tR5wYmgTBAGQuTYLqmp/Ld1gghBN/IRuvnM=;
        b=h/m5gPIXOMqpXbtdB60jnNSe2Zb/lJyE3k5wre5u8TJhbHyCgLd6KUadZlJC7il0eq
         qpynlAKOboegNCmbqL6nCXbL9DxPMhtHktDpo7WG8didkIX6PpXxIdKg4E4vOA2FTRNb
         sVgizYDl+jYXoKkow6n4U/EP8hIcse1IV2sJsK/JyPnCNgQqQ39UlkNeO1/+Q1337y3E
         RiCy3sjo0EGvOROL+czIv6v++g1yX8HwFJUQD0SWZj3+mBxpdeRFKXnj6ZhnnlvsX/Nk
         nMsXr/HoDnIGSAh+JKf6ccqNkkEwupEbfzzTvQoNcxZKPKgc4XneIMJzgF8K8ny6cCaS
         C1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804529; x=1780409329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ir9oiuM7tR5wYmgTBAGQuTYLqmp/Ld1gghBN/IRuvnM=;
        b=SWZjXiC9uh8lEUBtpojgy4Wo6+0bebqRsgFWN+c+JkdRurs8hfZMPJl5sbn2Lou47+
         lV3QecWo4KQIkquN3KrsVIzPW6O60jQJ71P+5a94CqrkZ0jZa7iMRfUla7N2wJeg/qcY
         DYGrl+QB59VeT7mF1eMMEXXkNPN1Vzx/LpYdnJoLHiqyLk18JzklssTVOhzvErcZyIyi
         tN4gUgOtV8PFOfM0IAJAnfMcvF5nvA8gprV5SVmcflBhGvDgAAOrtiMZQF/btLEGy0tF
         8forRXqcYaePvN+YeUIkTgiQ4lNz8CHOuF3hdcWoAD09HmXFnsuRVTgRu8FRXLAIVo9f
         FqGg==
X-Forwarded-Encrypted: i=1; AFNElJ/P0VWjMFX3uWDI9o3sQh2/+n1VNFEtxTuvdn3NcY/43o5N0I2Bw8jL2FXVPonAqUoc/OlXXaokdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUkHjUhFYNAOKBNtDvqwXML3gA0NbDgB4pawMiJRLToRA9f4j
	bRq3DuGlHdcFORgLdmSZOZmX3UJ7qloqLpp91/C3pfKfDedkSCYoaUflvBUiwoMgWqDzxJv1kvA
	Bv6Or60AKQsbT28vKrwb6NCYDBUTM7haZ8YBCLOL2xhhGyhs4jUM/muQrvqZSPA==
X-Gm-Gg: Acq92OHcygUFvU4whvONUaTuKEZF6NxsxyQCse91gUdI1ED1wc0K9l/eCJ/sD4sWsSo
	0j+CJHuMupCmSgHy/BEcg64jBB+x1N14qIC07DxOd9xxIjjrRJRTtw4TGZ66/eCUxvgABn+5lAI
	1ARwlsjNLGjphCtD14m1GHIQUt6SMLSYBEHzFJtGrvXtt94cgUnt7TRpSHTlnZyUBFItnVl3A7m
	+a7KP4ArQ1pCtp6R20Fvy1wbrr1PbYnwOFzayBFn8FXoKhTlER9+eW4F3gh2mHEtUcVHXxR6h+G
	EH0JcVlmIUqMm5abTNZ5RTKoHbwHJyrzk6ZWk348OoGyCp7vlX7GItvghI7XudD+HBf9lpQmMEg
	Eo/hIJDlSaOD1Pf3j4WhdpeDD9B6L9Mx2srlROcoKjD81g1IZ
X-Received: by 2002:a05:6102:e12:b0:660:e00e:720a with SMTP id ada2fe7eead31-67c7ca04ebbmr9234461137.8.1779804528574;
        Tue, 26 May 2026 07:08:48 -0700 (PDT)
X-Received: by 2002:a05:6102:e12:b0:660:e00e:720a with SMTP id ada2fe7eead31-67c7ca04ebbmr9234388137.8.1779804528132;
        Tue, 26 May 2026 07:08:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:47 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 04/10] thermal/core: Make cooling device OF node conditional on CONFIG_THERMAL_OF
Date: Tue, 26 May 2026 16:08:05 +0200
Message-ID: <20260526140802.1059293-16-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=7dX7hdhE7h1bitnmsToIwIHIsKJlo/hPnNjvKONOWIA=; b=owGbwMvMwMG4wki5S8v/hT/jabUkhizRlZ7rIhRLvkTLRK57vLTM4Xx6uNYztQrRjrnC+nyBd n3//5h1MhqzMDByMMiKKbJI1Z592Fp8MTn0RLUKzCBWJpApDFycAjARx/kcDFN87/1lEXaq5Xws JPZe/rNW7b4c6V8V1tz//z9W0mCojOcz3NoT8Nw4e4/21VcXtlj7mtZ9f/Fv6iuhqo+OV9krV5w wPm2YoqT4zTEjf3deRoTqz+DHFSUpd+y+hZgzHrj+vdXO492crAfVf2uKJod2J6vpMlxl2PBm+x ZxkVNLWHaKrJR+JMmZMTnnyCsll9KwbAcP6YJSzzbJyPdKLtl9nFtVT/U+z885NuF+vrl3Zo6ol H5FacBkUSX9yxbhxxK19vy7pz93ok2IPMf8cvG4dBf2+84fzHc+fnbtkJ7FoqVPNNSE3624150Y E6XuI+vwSfHhnx2//gYf3yFfss7hDI+ZTKyAkNnytxoA
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a15a971 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=To0RRxBnqBRB03TEE7sA:9
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: dYO7aRn9WIo_yhkYBBk4NtHS4NbrFfdt
X-Proofpoint-ORIG-GUID: dYO7aRn9WIo_yhkYBBk4NtHS4NbrFfdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX8DXNQ1Jbc3P8
 sAxC1lzPAPBBUiuwAvVwbuf1SDwQNI1B/AGvyJRXheYIHWFEaVESE0EbBepUCGAM+fu1XBLQNdP
 ZaA2+U/lK2Kt1z8QJuNjQ6nj5YTIG1pGbY1xktgjfXoyzTR8GgSN+F1AmnIEZOIiO+JR8FcQH+y
 tY5gmLOulANLmAme26nQ1yvPTj8jBZV5RM8qs4w49FJHURyPm89Y4IQPLSBkAFKX3e06PspKipc
 iy+PvFdL/qXvt6YrbZxw/VQJjBvEmbVnto5t8jeB3hqqNxpo2pYRe2AFHMZCiytSHn3pPHgds84
 DIkrRtpXvLCSlpTboHjluenzX4TRPqLi8dCxJwBBZH6FZbz2I3gWqEeZotZ37ITb7oW5eph5i/L
 qmyEiotLqOjmNb9z3D5vmnR6gcpblGIXWB9Zg19GE1/yqfzHm3vshjV+kHx0FmB9RWGWkB/F77V
 FWmSfn901I2H8Pgrdjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260121

The device node pointer stored in struct thermal_cooling_device is
only used by the OF-specific thermal code to associate cooling devices
with thermal zones defined in device tree.

Now that OF and non-OF registration paths are separated and non-OF
users no longer rely on devm_thermal_of_cooling_device_register() with
a NULL device node, the np field is no longer required for non-OF
configurations.

Make this field conditional on CONFIG_THERMAL_OF to reduce memory
footprint and better reflect its usage.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 include/linux/thermal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc3f4a098370..60e596e7d7ae 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,7 +125,6 @@ struct thermal_cooling_device {
 	const char *type;
 	unsigned long max_state;
 	struct device device;
-	struct device_node *np;
 	void *devdata;
 	void *stats;
 	const struct thermal_cooling_device_ops *ops;
@@ -133,6 +132,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_OF
+	struct device_node *np;
+#endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
-- 
2.43.0

