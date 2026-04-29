Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63943FE67D
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479304; cv=none; b=WWqbXAGws9VYXDd+itUGPkVpHlfUtqOjoWKuVATv6xxUCP/6QzBBTTTF4tUkzjHc2pYhySZCsKONB2PGr7vz1ew7sJi8TmSj+O+By+h0g9tMG4tevb6O07GQY2owq281asNFZafOVvDhcRgTZd3yMytJ4P+mSbSjd0+dpTK6b7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479304; c=relaxed/simple;
	bh=fySGrZIShH9MyeZKFigUBZwml8ANCT0VYoS7eOl4p3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEALJL6ViscL/W8AgSHmamQJL4FUE5UFtB7Mhl0ng8oPWmydnpgh3UQ8a+Fkj2ZaoWKH88qJu3U4LZK+bJjpdck7z65qOcEvngcAjFym4NGyFN9R4HYp5LoeferXwgRpyitT/MIVzQoxs+02/lTnPdnee14n+W4ttEoB5fSk0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4flvHQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zm60xz2b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4flvHQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zm60xz2b"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF2Whs3752640
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AE7tUJMeByc
	QH5jUTrg9HLnidqspvmybbPI9mAEDiXI=; b=B4flvHQZoUOhFVlQ81KmQ4CNeHL
	wuoEDAXUbPhqEizeraB/WXQOXq6vScfVTBKLqKh0zt6VAJOrN0pfgcJuVJsL9aqh
	H9Xk/MuSCXWo5IxNmKqioqfNXqRrCagawE4Pc1EVc3BhHFXuzITNvXTudCbSK0xW
	9BW2QeYc0ltLq4gFefJthGFIuQFi4K1ogE0cHkpSMVWDEbDreQLbEXYl2ihh8r+4
	MuGHcJTm2queiSy8cYUW1s6HF5ejup41AfjqtTgzbxx0it4iHgHiher+NmEYxjGS
	t9ci6bhbZIxMOXpcXTJl8xxEHFdfbFOFqIE5XxVaEoBxDUXOOLykQu9mDog==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1jds0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:15:00 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5675cb317e3so9969410e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479299; x=1778084099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE7tUJMeBycQH5jUTrg9HLnidqspvmybbPI9mAEDiXI=;
        b=Zm60xz2bA02EXB9H2Zh0Z9gdx2gDgM/wa6wT/jw3kkxKlugSHXKs2TpBrEWR/nZekH
         rH9M1NT0NYbCC70UKLBRBosHnuERwM7/WPTu6CWXZfDbe6qprD8VHGdiUYOjK+VrFU0c
         SEbCPO7vGO2O18272HojM/Al9kcql7fOt/9i+SB7GFRfEeLLIbRO1hNGEKFM884+4BDW
         7b4DCp9+LLQ9huC4gc7wmey+WfuS1TCmDEvCeq/08bVaxc+j9aANM7UgRRlYF06Sdpel
         Cl/h1GZ8rnLIQJ4o5kCoe4rTg0uX9UWAQdZpIU1+cPfB30Tc7EkVIyh8pdJ5hJc8WkTP
         t6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479299; x=1778084099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE7tUJMeBycQH5jUTrg9HLnidqspvmybbPI9mAEDiXI=;
        b=tVUciRMYbVwTc0nEacse1AWdQbFw0ja9a+4gh31tIwyBd0Y7QrUn+PKUOjI+0I7TVr
         kZmMNLgRGmelxpFWdqhVlmjuYI+3kJFRz0UyGSsckGdh9+aFSi4OH2pDluMtmYsxRRAh
         RBlfUZwYNiFmjk0TpA8gBz10/Phok6/YCc+qb6nFj+y4LQtbWnqqSaEDvB6sXSBrDOEx
         5bab5xrKanXfskIYxbS2/73nBrtFOLpZZ471sTsLO3XPovzCQ1gSLGcomBqEDxT37b1d
         5fU/sWF0nmiFe6eCdcHko3fFbbgFdVx5HUSrqVbPsb9Lhd1VsVnIDNeFlpJEvUOk0uL2
         1JLw==
X-Forwarded-Encrypted: i=1; AFNElJ/wm+OXjQqeCpZYMrooJz7W6wb7W9gQDzqCp73pw1fr0toPe+M8CPYnOK/PY9qf5tPLjUGQhBRvrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRgkz0IrzV8Wtpj/320+7q1TWhe6g86CKy9UpazAALeasL7Wt
	wKq0NRExQ+kWGQISYQnks2TqvWZpbEc++uEgS4lrI7DeNe2AMFlm7mikJvG9BW63yhKRihMMjzz
	KTFnF0msaxaMDzz0DHSa3uZ6qzMBnGwyvdI5w21/JOIX9ViWbyJrs4jtWaYoE1Q==
X-Gm-Gg: AeBDieuVdv4YGAYJ8WoGDe2ab++jsNzNqZSkxiUqcQWkJOjsMXwz8wbAQ/FLlhgO184
	DyND59UPRzL9yD3ZSSiIZzQG9pCVxuilY2OSulVchqkyoRmfXYBTKwrXWJCGifkJMIcpOAz0sGY
	WQnAn4Z/dXwLn4dJAnaOdnpcgTWXtTltL8tajaiZ8in/gueOrzPJPbKRHrCkQyNUKIBNOm/QQ7O
	Gghr1vW2Qp9c9I1x58DwREAkK9DCc+hbsY//kCOeO+BEYwU0RBVmmhfF0u27rPSqOEjrVdcMdCS
	PDncO+aWGvdYYCOSWSdLfzTblfK6kbSNQRn1pKLiPflapWgdlCQPlGUufKt+NJUkxa3G+UKf/nE
	VeLFflIs087JWCIRNQU3GF5rpUeG61Cyd03HdElD5vlT4Eu+cKjOhpyWqOTYs
X-Received: by 2002:a05:6122:8b11:b0:56f:a3e2:66a4 with SMTP id 71dfb90a1353d-573a554f7d3mr5292062e0c.1.1777479299477;
        Wed, 29 Apr 2026 09:14:59 -0700 (PDT)
X-Received: by 2002:a05:6122:8b11:b0:56f:a3e2:66a4 with SMTP id 71dfb90a1353d-573a554f7d3mr5291995e0c.1.1777479299064;
        Wed, 29 Apr 2026 09:14:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:58 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
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
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 10/11] thermal/of: Process cooling device index in cooling-spec
Date: Wed, 29 Apr 2026 18:14:23 +0200
Message-ID: <20260429161430.3802970-11-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f22e84 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=s4Kp2nOrnj-iCWvMcIQA:9
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX53p/zhgLWYhk
 99PyTpfisoFLUjn5/YWBZWzlNHUt+qriG7pOmiuY1lUZqB5g/2hhyq0DgO+CzDHX5KQZNdyjyo4
 hX4S/tAE6nO9SKGOogPgOQi+Tkl5LXtzGpIHyCfYch7iGmSJllUVR92Bw9lmV60KwahTPHgz5Xy
 RMxbXtUU2pS1f/dmbeqITgjJDvPn/oWsPraXMHBkz6elUOBwVX3jJ6+7d6Ie5XAUQ7uM+QZfnua
 n+staN91u1IK7zMwZnUQH5BFcfoPLuaDxN1Of7vcCVmqlF6G+oyFRD6mOka4tH/C7o5sqd5Vq8p
 nJWYj+RmZLY8upRg2cYHdqw48Ns21YQREgbs19bpbp1skZgxQVE/6mcQClop8EYeKP5rNvdiu6Z
 U0KmZWfEzLGSV4RGLBdNLgYuTDbiraxjFzbEWZI81S86/hoPtCM1PgbDk9SKmkse3VduvWCyECc
 maKH9hTjMl+A9+dAo3g==
X-Proofpoint-GUID: BE9VUsy2vgrVQ1TptHvoObs4dZNsl2P5
X-Proofpoint-ORIG-GUID: BE9VUsy2vgrVQ1TptHvoObs4dZNsl2P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290162

The new DT bindings format describes a cooling device spec with the
cooling device node, the id and the mitigation limits.

Depending on the version of the DT bindings, in order to bind, check
with the device node pointer only or, in addition, the cooling device
id.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index c9190a03993f..1c944daebec3 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -259,16 +259,34 @@ static bool thermal_of_get_cooling_spec(struct device_node *map_np, int index,
 
 	of_node_put(cooling_spec.np);
 
-	if (cooling_spec.args_count < 2) {
-		pr_err("wrong reference to cooling device, missing limits\n");
+	/*
+	 * There are two formats:
+	 * - Legacy format :	<&cdev lower upper>
+	 * - New format    :	<&cdev of_index lower upper>
+	 *
+	 * With the new format, along with the device node pointer,
+	 * the of_index must match with the cooling device of_index in
+	 * order to bind
+	 */
+	if (cooling_spec.args_count < 2 || cooling_spec.args_count > 3) {
+		pr_err("Invalid number of cooling device parameters\n");
 		return false;
 	}
 
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

