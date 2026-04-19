Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498322EA75E
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622959; cv=none; b=uZHVSVD5kGv6gemP+r1TGyBCTP0ozneUitfViU+/P4eWaZu7CFt9Eo84S3qDsXVuM66MXpqjs/elVWq2+3WgQ8Byim8KpuWZQ7J+CV0byU0ZBCdFdDlAlfLFrurIYQKaRzC/ZCXEpRrBCFwJiCoZDlhyqn1xXrecLKxjXeKZ7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622959; c=relaxed/simple;
	bh=zQ2ofjxFIwHsuU2VATPBF3BRMsEnwHwCQHXoZhFa900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUag/TGf9/FWiGklD2BGRcZc8BIlJrkjJY/TZ2SFQVB5ohO7veHfgq0IrER4ncvvkcANuwYvEP6wFro3Yf5DeTkZ/apGYirHDvejPCeXG5TKby8kQTjWGq8dJErKdjqFXMuwV0yppim5cpgUkR3bdQSsaTAG0ioLPlGvfHsSHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVz081no; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GG31VXF7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVz081no";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GG31VXF7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JFkNur3562740
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4+JHC4i+rBj
	/UbYPMg6c3yvjyW0+p6HwFWy5SgpbUGE=; b=kVz081nouZ/JfyllbxjSJxb4QdX
	cewdwEC02fEp1GmXHQq7tOxv4jY02J7kV/lr65ohyvhcejmLY3j+57xjBLxlmhpB
	aXBqjiMp3hxiHOzu25KiKhUYZW6vqcTbd81ZJt0I9UB0wth4yAb2fP5wWKuV2gG9
	11hYoYpJU/Z5J+qMrmYeblw8Je7bfdkjbGpCe2Ov1LMt+5+anEiSwPB/qSDWpE05
	KAN0hkgHIDV5bP0pgtZvuU5aJqTAiPFsjBjlOJtfRSe1gtrMjfEdnXMo5zULRsQA
	APVJfxRuRwfm5ZPuxc1YvOb3TBnQAihpeTIpSdQQFF5iC6Iy0bieQ2ub6Zg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyank9b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d826ed6f9so78237371cf.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622957; x=1777227757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+JHC4i+rBj/UbYPMg6c3yvjyW0+p6HwFWy5SgpbUGE=;
        b=GG31VXF7uwCGPVQ3eNqG1hLm25DqTCSm+MAJtsh33b7jCJEbzxfSj59LViGw0AOfcu
         Y/HHmQceZCmxzcnuxNk4HdzRhTLzaLQiZyFAgKyEOWZQb9IkKFNgu0jUxbRfTEcuOlaH
         i7dSpMXywlRSjPmFaddu0St4AEREXgChV6Xc8xgcfpr3X0xmI0NFv+81r5AutraaeQcY
         FjZ4snXybsfQZoIDCkXh+x0f1JKqu9A8Xu2dWR9hW2mxDtYUElYG7vYWKUh/0Mljvp3O
         knPYrF2luOXkfCPh8GTDVvYXUPCUNP1h6ly5j7H9FZm12txCAT7XkS78IFjXvVmUVxFu
         TaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622957; x=1777227757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+JHC4i+rBj/UbYPMg6c3yvjyW0+p6HwFWy5SgpbUGE=;
        b=gSgwttopkTBo0YgFhFpjGcCy5u3t5GFM9istQbFoI+3ZyyP2T4C7ZqYu8RcaPG6GyV
         pMguMx0OJQOjlP0Z568epoxFNn+CfyearS9qShws4BVYYpQi0wRvN4FIrOPg4U9ubQlv
         IYenzeyn54Cub8puVHRRD88DblWIF6k7Eo7SLK6Tm3elDZRC/QTbNLm1xFRH/GToC6pR
         zugSvQtlNqUl6oR4CS/2QQ54/d+YzMUkK1agNQ+1IpDPNsAyjftOn6xjS4S+XfkXqvEA
         klwriavINkRnVkCY1juhgpKdBork/gwCPJCPCDsJ5g0YlQ62BmIAGmF/AFf9vPaZIhSC
         Ph8g==
X-Forwarded-Encrypted: i=1; AFNElJ/9nAJPBz7VpHt57VED4nbzqCF7zzu/Vk2y6oed3SVBpO7bcU4oV4GcmcoscToE5nzVQINRKZvOpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJ6BArLlMlAUUYuDC3SETSK33y7Hky3QzEqrS3oaKf5GMFaI6
	mX0wVrYw1vPfKrRuoH8s6Bjli4ypKPPynEMTwt9KqKHo6ECuneI9hm86qLnJ1iqlJhzAGyhKWOc
	KhnE1l67wpWHMkkEB68XRlBHMTzqfHREK2MKYYmOMTooSF/kNDp6JEP0I0FZ++A==
X-Gm-Gg: AeBDietVuJvMF+US1WwidIZ5VWfUkk6HLTdYYyNESiVCT/01v9cI+5+jedRTgxl5C2W
	i/rlJM9BgZ4WnX2xIJLKQnNtA1bhxUvfngIYZIpkBtKgj0l25WkhiOwR4u3rBm/xp16v/Mrm7qq
	q7A91uSjMZHNKwExmD0ELCjw1ZuVAwlh1D6b+HUuT49Co1nA9G6e6dyTw2Em2yAQlqdedTA+Gir
	t0IJtlB7ArsiukqA3fl+g4jKnRW8KQix2WuW+VWe62tW4RFZVJ1h/5DtvXCGKGrAiaWmNMtYZKh
	yjTTZedXNP7sioM96lU7etOXnU5/J9WggksvBU0DBcMwIyeQN6+m1uOw8dTdUWQ+pSLrwebPJsS
	9I3PEaxtOz/c8krntr6KAgG8BkTxN6RZy7q0Q1kNTerC6v5eolzpqkTleT42D
X-Received: by 2002:a05:622a:112:b0:50b:328b:cd41 with SMTP id d75a77b69052e-50e36737912mr124060341cf.20.1776622956728;
        Sun, 19 Apr 2026 11:22:36 -0700 (PDT)
X-Received: by 2002:a05:622a:112:b0:50b:328b:cd41 with SMTP id d75a77b69052e-50e36737912mr124060011cf.20.1776622956225;
        Sun, 19 Apr 2026 11:22:36 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:35 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
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
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v1 03/14] thermal/core: Make thermal_cooling_device_init_complete() non static
Date: Sun, 19 Apr 2026 20:21:47 +0200
Message-ID: <20260419182203.4083985-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cn0pFWFULc8R9C5YT0444a7Vh5fp2w4n
X-Proofpoint-ORIG-GUID: cn0pFWFULc8R9C5YT0444a7Vh5fp2w4n
X-Authority-Analysis: v=2.4 cv=SNFykuvH c=1 sm=1 tr=0 ts=69e51d6d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=XCaTwWLIzJkqVeeR-uYA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX2Gl/vNO9zIV1
 dAeIH8tWzJo7b5OuetAII/4p16wVz8C24jJwKpoERUoo2AtpII7wIaH6/lXA0eJwdaFttHSIM8s
 hfzzUKdGr2++MmaXxHb7w6FEGAvM7H/0Oe+Aiy5LPsT8OzmzCOQbP0jF5lMBtoYUk8hJ3iHSFii
 Jplzti2wYUsg70LdrzvckNaaQhrxJnPqjyscxcKKYz8OAWHE+GSevgagm0R47rUl6xOIJFtCHaS
 WtnZt42x02EO9PLECzkw2uBvZvBh5MWySq/3mpLRr7dI6V5Sol8byw5R8UmPIVacVWmXJMzmdHE
 jMWfHb0RC/cM3OJgT1NPxMaWkpUm1JzgBYukkEhKSFRVUKzbtGx0YJnsrheErS1g7CD/TgcRNkX
 VaX891L3kjIkxISQtIviJ8MV0EtcKu1VRMIU123HdPJnIWL8kcvJMm42nkyakOb/cgAwxMpM4c8
 Ehp38TjdAZbMmicPYPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

In the process of separating clearly the OF code and the thermal core
code, let's split and export the
thermal_cooling_device_init_complete() function so it can be used by
an implementation inside the thermal OF code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 12 ++++++++----
 drivers/thermal/thermal_core.h |  2 ++
 drivers/thermal/thermal_of.c   | 10 +++++++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8a70768b46dd..35cf170f3fa1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1028,7 +1028,7 @@ static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
-static void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev)
+void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev)
 {
 	struct thermal_zone_device *tz;
 
@@ -1127,8 +1127,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (current_state <= cdev->max_state)
 		thermal_debug_cdev_add(cdev, current_state);
 
-	thermal_cooling_device_init_complete(cdev);
-
 	return cdev;
 
 out_cooling_dev:
@@ -1159,7 +1157,13 @@ struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(NULL, type, devdata, ops);
+	struct thermal_cooling_device *cdev;
+
+	cdev = __thermal_cooling_device_register(NULL, type, devdata, ops);
+	if (!IS_ERR(cdev))
+		thermal_cooling_device_init_complete(cdev);
+
+	return cdev;
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index bdd59947b24f..6e44bcf37b00 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -269,6 +269,8 @@ void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
+void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev);
+
 struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
 				  const char *type, void *devdata,
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 398157e740fc..35d542aac7f8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -531,7 +531,15 @@ thermal_of_cooling_device_register(struct device_node *np,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(np, type, devdata, ops);
+	struct thermal_cooling_device *cdev;
+
+	cdev = __thermal_cooling_device_register(np, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	thermal_cooling_device_init_complete(cdev);
+
+	return cdev;
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
-- 
2.43.0

