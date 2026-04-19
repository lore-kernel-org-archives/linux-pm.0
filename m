Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983212F5A12
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622982; cv=none; b=UECY25YATMHoUNUDtQij+sAcUmBd0KS4db1z6HDnt+VQzfJULfKGGXRRh5+ZhBk96SziJ0l0RcZFRpY3PgzFGxzogKha4wH4N7YGoMMa8U1RuYrjwN1+63TVTr3gmdsObOpgOzVL7HDKqNFvvjoMKE8xetF47DkC6+79UEz+Aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622982; c=relaxed/simple;
	bh=6SNqA+4nv4xjK696sb7FWsbUSU8CWbNmGGK/ldEvX/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgNQesnJZ9Nkj04lpalJwfGehUS7LraT5QNlHShqZKAZVpkfTWAdj0JhEzCGfYEFzZG+dzsiGyHYLXxJK2OOTFmzhfntnOIv+YSi5FEWYCzGqxJI6AxXeeDPpgLpPOPjwcF0o1vIJrSEWLsiSd2djezb0N64bERo0LOFkvGWUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lPMUfnKy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJw0LU4D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lPMUfnKy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJw0LU4D"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J1xNIS404245
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZF7ss7dJWTH
	LLa9FNsnYJO3c6WZwqwMms+ionVBB/Og=; b=lPMUfnKyI4Rmj7JW2Kfyzqa0RoR
	aR4llScmm5hr4aGW8Mi9risNnK/doXnZ3P4gprZ7Rx9GWfjwaF77oNiSO9Fu3xYh
	wKkf2O1Qv61mbWgN2Ve15zIoFbf8GirZS8R28YESGRguoPYD67jeypknJhhAlIT4
	q4OCXlBTNzP97pejWBC7DzbBbbxonDDNP8uymKyiHyewruuDvc6ipku/DMZrLhBi
	+/eEdP8S9D7s5UpUk4lT3bNmLlpCaKlbY/GR6F2RTISI4mFur6kycIeKv1qFRhRR
	WXEcqjUEknRLeWhgKqQyhlhnHvdgbbi020+Wu66AxWuSfBy4gTILh7DCsvg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y6351g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d58bed44aso18284211cf.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622978; x=1777227778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF7ss7dJWTHLLa9FNsnYJO3c6WZwqwMms+ionVBB/Og=;
        b=AJw0LU4D0ehK9ZQoqTuvii1Ph9kTREIrcPw3Dd3w07225WclCzsnetAuGRnB2VSoxg
         OTYCg3wPC6gK4883KOQboprZ590KTZvJTyehNA0JaRnTo9H/twJ9/Tr7tx+nJAysV7v/
         ++zf5thj7LFi7zapNn99HpcwgrQ4sScQhvcNgWk2LV8nAwex8YX3TjSnu6X+6ibLgDI8
         7SsN1/86ol0NfHbsqNopZhGxnIna18pon6PHXllLRPc/kBW9Rq3ECCOwZSWIRe0Z/uzG
         x3kU9r/9OIWepkNqXHV9UxleLtvcrtIw2PfFxG7zC6UvLaX6mNKOntfEwP+kVcXMcztU
         gtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622978; x=1777227778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZF7ss7dJWTHLLa9FNsnYJO3c6WZwqwMms+ionVBB/Og=;
        b=WFlQbaB3SbuJtGu7+Mk7A68+ZCQGjHTtkOT0SIEJ1uEqLG3RL7eQpU4rPQsDQTbubz
         Xzqw3LSXvKTfGfeSVDCCp5hDBI2hA0obaDeOZLvBKRuBPmJ+LbDivGP61fQhth9e9pEN
         f/PzIsiUgtJsqgTBpusRExZ2B9zAgSdel6LHTsLqvItuXE82RAgfbMv5hzHoDuZUWINs
         tvaMSKu/KZl1nmIwLeecB5WrUfJU5XFwI82yjyn8gB/HWLAW68nyaNLV/JIQN4qhJQz7
         S+hseKd9nt2QqYsxtWg10hwz06RyoIj//NnmBP1qhFUR0X0tJ+wfzAGkJaO5J7alK3Tn
         FdCw==
X-Forwarded-Encrypted: i=1; AFNElJ9OXmADESA14PJegnLohMGTLdpG871W137sW7/2jew0R/s77m3llZ6f2tMmjz/q+Bl+5NwTiBVw0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3VkNuFe3vyh4+hRqtb0NnwVTTPbBh0K3SeXEH+e6DXZCso/w
	4ObLBc0rJwcifVN80cXqYO/CqV4FWBfMUJaRLlCefXGs/H1aCuUUka/rmv1MmGOTxPgP6IBjWH2
	jv6tlHZFXwShD64gYr1Fcs4IWHUG3znJRDRrWCE2autbGMXo1E2n+NkXC6UVIRg==
X-Gm-Gg: AeBDietV8mHRdfUNXec5zmVtZ2w1wapkEVrS0Ka6WeLTPFG6Dtk3c4LmYaTVRIL5Vq7
	50snLig2M2b4PlAQw4YU4rrwEklZBCGPUahd4+75DQyAGEDXsfpqdjZ8A4ps3HlB1hw503CHzDm
	jvDZpsN/6T2bkqtiPc8mur0lqaBdXygm5tRcX6ZNgXieJe7m6FWhHg/zOJHPTw4fMLPgtlMHVCw
	wey32CaE8c7utgbbnuVFoEQLoF0tv06NR2MFaOpSs/RPIMQTmsr07rDMUIgSvsexN9+WWBaNRTA
	2ClDWKt4FD/STXehWJoyHQvLCto6rmeOyIWaArqb89pkGei+SiTka5no9U9pMImbF/71rlMcQb4
	l4RFtWGBxIEHVchtbnEao6NnrbbSJ8VMsS/rVc69xHBjj4Y+ktj9L1PfG4J7w
X-Received: by 2002:ac8:7fd2:0:b0:50d:66b6:1564 with SMTP id d75a77b69052e-50e36943bf8mr171663951cf.14.1776622978569;
        Sun, 19 Apr 2026 11:22:58 -0700 (PDT)
X-Received: by 2002:ac8:7fd2:0:b0:50d:66b6:1564 with SMTP id d75a77b69052e-50e36943bf8mr171663341cf.14.1776622978074;
        Sun, 19 Apr 2026 11:22:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:57 -0700 (PDT)
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
Subject: [PATCH v1 13/14] thermal/of: Process cooling device index in cooling-spec
Date: Sun, 19 Apr 2026 20:21:57 +0200
Message-ID: <20260419182203.4083985-14-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: aPPVGBlOMJX7rysjKjeNu8dj57CuVSGM
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e51d83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=S3gQTLpqa8hfpVGigeQA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: aPPVGBlOMJX7rysjKjeNu8dj57CuVSGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfXxFqd1w0Fe+b9
 9xgbXBGiSDvc8V35G77dsERuW/jm7gAatj6rAQRtSvR4HAoami7m9OSy1ibbzRTxeFSb3lLa97R
 rHVf/4n3pl0T0el1fzcnxKWg4LoM47MuYToMYJtmn9sIUkC1cLgT65yVqxHE/X5lT4jO2ebBrmH
 rthg3RaTXg1SJwCDJn4qTA+Oj4rRBG1AguT/dxCyYiclz+bhbGujYEeNCSS4RX6w6d9TsroNjMi
 9EvNIXdsBlS7qdebngU+xz45T7wuOQrPMBKhx0yTbFBuaYTnZWBoUo7+Ae853ylx5t3IRAj1EXy
 hjn9AhoMoQp0kH5lOWmCOzThSYliFz8o5BbaeO/YBquu/0w+2fnD3shNAlqlZFyM6zmQoZzJiJs
 PN8cDyChfk0McrAFjrEyI4qViF1Y3kCDJz2A6+38QRh6MUSnP5RuIQ/QoVKCPs2/4AYhf2sAysJ
 /IAGE5OONo3M8BLnOjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

The new DT bindings format describes a cooling device spec with the
cooling device node, the id and the mitigation limits.

Depending on the version of the DT bindings, in order to bind, check
with the device node pointer only or, in addition, the cooling device
id.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d9bd7dc01e19..e9b39d625b0c 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -264,11 +264,29 @@ static bool thermal_of_get_cooling_spec(struct device_node *map_np, int index,
 		return false;
 	}
 
+	/*
+	 * There are two formats:
+	 * - Legacy format :	<&cdev lower upper>
+	 * - New format    :	<&cdev of_index lower upper>
+	 *
+	 * With the new format, along with the device node pointer,
+	 * the of_index must match with the cooling device of_index in
+	 * order to bind
+	 */
+	if (cooling_spec.args_count == 3 &&
+	    cooling_spec.args[0] != cdev->of_index)
+		return false;
+
 	if (cooling_spec.np != cdev->np)
 		return false;
 
-	c->lower = cooling_spec.args[0];
-	c->upper = cooling_spec.args[1];
+	if (cooling_spec.args_count != 3) {
+		c->lower = cooling_spec.args[0];
+		c->upper = cooling_spec.args[1];
+	} else {
+		c->lower = cooling_spec.args[1];
+		c->upper = cooling_spec.args[2];
+	}
 	c->weight = weight;
 
 	return true;
-- 
2.43.0

