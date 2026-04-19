Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275BF2F0C7E
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622971; cv=none; b=gDLY+z+7ynYq5BRpLkh4XIwbVyLaLTShKcsSao2a5cONP/VhhlFlfEjjzR3YVP5nNj2BeR/50UCcLL9k6gxF7dU63RG3lgmn+GfqiEELgE9SqHqYPlycuJ0RbUErBNjVU1o6pFqsbsvP+o1YpQ+e+oaYLDSZdvf9BRus0GV8eDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622971; c=relaxed/simple;
	bh=1EZJ/sEXs43bbTva6IXmLEChVaaD4wyyFswaWaokE1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIKc1/4PhSrJKQ69ci6I/EPi6ciEooYzl1LZgIQ1jv/+BK36BrVXKQAiYOYGfYyGbmj1/qVhRM+Rx4LitXHjYv7pKfsxPHLcNCR7iwJFAkrmHVdsw8O7qm22iSYxC/qUE6xHAM40wFcnm1PueO/PdPln4so9FuOgOKvhg5O9PH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZlX9K/RV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AwsOi66O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZlX9K/RV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AwsOi66O"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J5oh2e127979
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5+FaPlCHs97
	hjeDgtr8xUv7bicqdWzWnDvhYFxD5bkY=; b=ZlX9K/RV4K7ZZOXAZiRJu0f4RC6
	8M1fINuzlF7+36gLDxgd40+YCs50AnOhem8rY+nPcwr3ZyTJsp7nspp5hUlibtF8
	JlAlvUA7Tie3jX0gYd2SfHHytIgU1ZCy7OdJSEr5DzsbNoVQIH0yDEIn6CaYsk6+
	ZnDCDBSpk7tVwp+dYqA5eXX1v8bZ7cuZzXGBiPWjCY0eYSKFJNIn7ksk/hXA+rV1
	N6joJD/ZM6Q2dX05OkwE2NFH8d1ytcynP/BspS3iHSstOcKDcCT9OGKKuaJxqQ1M
	IN3E02DKfvLFTdTPgeYsYMxfMWgXEjCsYsZ89UCL/ojMV7M3pdqfmZj1Vfg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm19fu318-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4031b86dso49127511cf.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622967; x=1777227767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+FaPlCHs97hjeDgtr8xUv7bicqdWzWnDvhYFxD5bkY=;
        b=AwsOi66O981F/StI/ueQEd6oewfOBelQDBSTtStxF+mGquLFa8pCieSorYBCnYg7w7
         x8DFCLUT8E5fi/VX/kskD+VclHR898xdXA0zaTlaw0/nObI//vmj8eGvXV2HdRe88E2u
         D/H86WZo7Th1oyjSWpC8u1ns1pDHe4jn0LFhYOjtTuWtq8jBaMeK8edAd9/oBobq1CUS
         OIjWQJo0k/FT6fIchjnCWRr88Obe00pK0wnZRrUUmtoUXr/yIxUc+C4zkBRRgbFLRCfG
         W0VBAZg9xkmgL3Pfo2gTbkTovSXIOrYp3WB4J1x0Z2pz/iD2Z98ICTSR+qC8AsAbiQ4v
         WSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622967; x=1777227767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+FaPlCHs97hjeDgtr8xUv7bicqdWzWnDvhYFxD5bkY=;
        b=KTX9ALuv0CaBkGu73zof71XkgTVrwSTYOSGUQHRt3HBHNZH5C88wPceNVqzN8JGdJ9
         o89lgpa5lnlYGNReMg5IEqfnnWd0zD3GSc0DdkWddGzhs07JBqU/Um94nAxoCP+5Mbij
         ATkKhihB+ClJf9iEyasWA+mMtGslqcK389gsGa5RDKRcnHKYpHd5ocNDMFbEVuoyNhmF
         6kqC34j+von8OPuRLugvfGivbr/3HZLwDl7gn6HIhKtzYhHa6AL/sLIz2KxYfvWfxorU
         UxIxpUEAcwXiCNB8yjsYhNZbDmcahpF40VykfUy5YLqo/p6PC4Y65tJZwwEaGayr1zDt
         OnLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OmS295MeXG90IwJ7lqByRm9SOCPMP6tA4PCT98XsjOkOG9cVPkKL7LFWVgKLEwmU4TI0yQqJWAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxglE099Xo8E5hi8f7iP/4x9jLvuvqytjP2P3F1SwatV28jcaf5
	4J9bouLNyYB+qVXOa1IH8SUl+QEoMM+51XVywE10NKN7/OWIkhWAXxAil5t7uU9W6JT8qwZ37Kj
	H93piiXdBoz7KrgzBYaK75eo38GjGXJP5YThjPbMUAmLKTt7dNB2yvTzGO9E20g==
X-Gm-Gg: AeBDievrH1nGDwBVsRpVXvOsibEcy5IoomLwqmiVUxb5yqP0rlqASaBN+86XH/91y+B
	3+9eu7IbpLOTW+SyXG7l5VIfapwM2+wbl04YvUjpLJywFDMl/SncIGQ+eKPPrMVQetacMJowpCv
	yIXv1VVift7P+M+RmCQIYKdFHsnBDzL21+kSkANDKaT9GkqZ/cnPpuBRN5LxE1mBbgSkhjyZIgu
	rFhH2QyoD3T91MPJ46Z1Bb1LYOOhFUzf2dZWt8yLEI/VRYEHhNzx4dbDq+GouAh8KY/TvtaoZzO
	+1ZAFuYNCvf1pRSjHIQdX7Z2MOEvzrCc5kRsxCOwMfNrGtl50VNqihWZVIlroLblIoWmsBwVZQ+
	giRvErATIoaZjM3+h28MoxVHW1GRU9ylR3gvzzgcxBXt66wMuLQ1O2XpuiLtk
X-Received: by 2002:ac8:5953:0:b0:50b:3831:417f with SMTP id d75a77b69052e-50e36c773b3mr168851511cf.45.1776622966667;
        Sun, 19 Apr 2026 11:22:46 -0700 (PDT)
X-Received: by 2002:ac8:5953:0:b0:50b:3831:417f with SMTP id d75a77b69052e-50e36c773b3mr168851021cf.45.1776622966149;
        Sun, 19 Apr 2026 11:22:46 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:45 -0700 (PDT)
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
Subject: [PATCH v1 08/14] thermal/core: Move OF functions def in the CONFIG_OF section in thermal.h
Date: Sun, 19 Apr 2026 20:21:52 +0200
Message-ID: <20260419182203.4083985-9-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX9tqPNuCgKaay
 1oIc9cWDiOSaE+RRQR4BAJMQfN7RpuAktWSJWpJqGRlFa9NWTqTdrLmpiaIcma1eQ0jM+rGv5fR
 zJbE1GuJo8yD0DZcfosOOZtDG3m8CjBd9KDf02/mv4xzWWS1v8JDEGsBIFlD2n6FFTUfcSEomG/
 NLg24hhynGYVM0voP/Fn8tQQKqiR72CbZvktKL3UF40dmv6pzPEXgQh5e3fAgsX/YfzTapRKlDu
 RJp/KJxy/ghzzh9IyqA4iD0kek+xeujQh8h5mK80FCnqHTvsD/s2xxqyEqyav3ySR6fsS0pL7rR
 oD+0V7WABTKuw0K7hY74tS0ATa2jEvUV3rQDPDhvniYflZBzjzblvklgDzdA6ge8QjHWOd2CjI5
 pkolbg5sbEhx151/LA8MGlGCupuJtVejVoJGE81WqK5k+72lL9o7biNDFXxi2Xf0FcA8vVBxSvq
 dOeV2M9tm2vlzU1056w==
X-Proofpoint-ORIG-GUID: qmpN3tSK_4wceYuJFRnnrEntF2XB_af_
X-Proofpoint-GUID: qmpN3tSK_4wceYuJFRnnrEntF2XB_af_
X-Authority-Analysis: v=2.4 cv=FMorAeos c=1 sm=1 tr=0 ts=69e51d77 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=1wpLYamVcWg7q6lobrwA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190197

Now that OF functions are used only by OF drivers, let's move and
group the functions definitions under the CONFIG_OF block. There is no
need to keep them out because of non-OF drivers using them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 include/linux/thermal.h | 48 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d9332b037188..f7b8651c1ed0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -198,6 +198,16 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   const char *type, void *data,
+				   const struct thermal_cooling_device_ops *ops);
+
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops);
 #else
 
 static inline
@@ -211,6 +221,23 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
 }
+
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,
@@ -252,14 +279,6 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
-				   const struct thermal_cooling_device_ops *);
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
 devm_thermal_cooling_device_register(struct device *dev, const char *type,
@@ -309,19 +328,6 @@ static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
-static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-	const char *type, void *devdata,
-	const struct thermal_cooling_device_ops *ops)
-{ return ERR_PTR(-ENODEV); }
-static inline struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
-{
-	return ERR_PTR(-ENODEV);
-}
 
 struct thermal_cooling_device *
 devm_thermal_cooling_device_register(struct device *dev, const char *type,
-- 
2.43.0

