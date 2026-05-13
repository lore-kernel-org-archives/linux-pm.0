Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9CC481664
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692640; cv=none; b=PMLigPvf3T1aOSH/T7EwQaSHnrdF/1wGI/8RCVnhgYt+IYPgQsh6Zaqp9NYjoxqrsHs1JBAZa+FdbG5ar/0Z15bqNTsIf3EzWNT3pPvvkNPNxSb4oo/andgiPQ+pfQTlUCdI+ONAOPcdNyQqIV6BcH9GjOenVv28jrCNTGrTj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692640; c=relaxed/simple;
	bh=Kj3iXhctlrnoi195JSqc+ZVTxrEJIVDVilbcH2wOlpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2g3LdCv5HjChxwZACpRZ12FEQ/nJ8UKx6seLMky1XHd1BlTtVBvObAJKOOO0h0K3SitWA6l4aYdY2/x0lWCwieYx8/4ZO9tedn6FFGJt0WhFN07VpI9GrPH3UBHzdURZJRHwcMhxMOLT7uzivMB+wMoyzJWehCIvPeMH0SKfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kryTxQA6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCjxlbY3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kryTxQA6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCjxlbY3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DEd5MT3474786
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aSNW5jdxcUIAPP3Bs33L7OprcOwqqAXBDPxUoI0e9M0=; b=kryTxQA6RM485eQX
	dx42ibBOB75xs/MJw/7b3DKZEiDJoe6dqOpjyvUAVS/XrFHKfS7lTZhkbJMgzocU
	m8TngOGjPaWwym33crrprlVCa/LhJP7R2/qHPUFnxVCLowrI1BDsElkK7//ZEtWt
	1Oyuw+KaiRd3xVbzKPDHVxIxS9tJga80y+guWSPjrExWnzHAgkPbLmRbKKIODbjf
	harIdC9nNhxRhduZLHu2336MAwCDgWEQkn1tN7iFieVDpCdTzbDg61a91GhkyNjw
	pNQq9AZFNeEJEwZHfZN/qLVPM2HdlXKI711JqpJ6sWkMQki6Uq7Fw0ye6KznP0Ue
	OCw5LA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41a0qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so5515133eec.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778692626; x=1779297426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSNW5jdxcUIAPP3Bs33L7OprcOwqqAXBDPxUoI0e9M0=;
        b=BCjxlbY3jZcFIHe8YTMbEOoh4nr9Rt8veOvWDiLvlnV0U+Kwy8O2zUr1hYIkAuoGPa
         6YJoUPghFitnuGro3hhGppBsX6Vwm2a1OLkij8P1Xpv4iFQvAcUZfJG7TA9dQoqJp07p
         mut20yOvGfXt58G04drxekh9TpVRuY/kHShEWcU0qsPaznaM5TWZoIYSHiZK+Cgx2BZl
         8d3OjUlexApnS0rlojIzwzLy0x1aVCeJ+BZwitNXpFGBcCdUkgwfVz39zf+B3/eX0RqS
         WdGnEDx7fvPRmQKCtV/fIZimjLSGdIDXzF1byI9eZG1+aqSq4DFBj1iBMLk/AP59OJlh
         yEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692626; x=1779297426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aSNW5jdxcUIAPP3Bs33L7OprcOwqqAXBDPxUoI0e9M0=;
        b=lREH7T3oskAVdk7DIRiSlg9hBr5Cto0QhxsGHkTcA4gPFq1MMkF+nyZSdyGex5zZn6
         5QwhPOI32gcR8uQ6MvGuu7Euw4CVMoFZHf+Gd3ucTW/MoZKdmd6YbqoYJB0uvTx+OM42
         F94c60+Y7eyVLWuZ8DvpdX9ssKvhm0yVn5B3XOkO19SgPdxVxgb2huMHFkmdqmctyU4h
         3/L/q2LeUq+z+t4TEknfpO35VZVZlB6mSkYCh3Q5JpAl8WdHYxYXYSVupbkLSdgZ7+qP
         vEjypniuMbFhAMpBUsqcZedlY33cF0jbcZgchCTh0IZoXxc50KTLrkHywXXAW9BDT8xf
         IQng==
X-Forwarded-Encrypted: i=1; AFNElJ87oQ8+kUl87a5F+2ZGOsKqEyhzv3Q9/SeGqBRSndWuF7gX0g5/8tVv+/qLUejuThyM8WiczS7etw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKA/bqTTxPxNItLoRsCZZVc9vnEF2pyyP2jjK0BBUKGSCXtaB
	BeAumK8+t1P6f362FF5RoUyq6Hz4Aft7LuWuqMfcLf3KMUMrUGFqP/I4yUvoJ4YmWfKMJIziS42
	IVsvJFMHOPoZIO4GqBC1gSf9WcH7WTBMK0Npjqe4tMlhEMOQTV8e7dy1yc/FgnQ==
X-Gm-Gg: Acq92OG9mPEm/rhmLsF5ocqwRf3J3F4+Phh4RB3l7gniRq0gOAcv6PtzKfRlK3CcieP
	6hc3MNXNar6UAMwmLKMxfdQUShL0sSGNkuicquyR/tJUBHjO0KxlhIT7Sm14OtB7+sKVasLCmIu
	G9n56eLZdx8pv2ZyMogH57dv/k5I/huO786nyOF+ETx3bT2DI5CMEjkY6IkjzxTuL9bqeUTINsx
	c5Tfw2eB/dQkpPxgA6Jfw8IP7ePNH7UES+Apq7XOPnIk6lRGD+icWE9v053c/aGQUFd2fxg9a6C
	ESdfYNJD6yt73ZLNYbOddQMERgcV8Bd9R7iEOY+2BSOMsn4V63ddSjyqaY/xWb+yy9LXkHUhC/g
	0L4hmK5fmJchOcO+idpOG6b0jd3138U+rB0fGrnfsuj2T2dnv+/yK6dz0Q1w/6rJa+k/GYqQ=
X-Received: by 2002:a05:7300:d505:b0:2f1:1fe8:cf5c with SMTP id 5a478bee46e88-3025fd4ce24mr270855eec.11.1778692625790;
        Wed, 13 May 2026 10:17:05 -0700 (PDT)
X-Received: by 2002:a05:7300:d505:b0:2f1:1fe8:cf5c with SMTP id 5a478bee46e88-3025fd4ce24mr270809eec.11.1778692625112;
        Wed, 13 May 2026 10:17:05 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm23075939eec.25.2026.05.13.10.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:17:04 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:16:58 -0700
Subject: [PATCH v2 5/5] pinctrl: pinctrl-scmi: Log number of pins, groups,
 functions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v2-5-36607e9dd540@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778692619; l=1456;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kj3iXhctlrnoi195JSqc+ZVTxrEJIVDVilbcH2wOlpY=;
 b=8IZtV5wzteupSXqIq+Bsxez1uHO07ft4wROITW/YKp+/ETuq3ZDtrIO4dorhEbPjGInJMDVlv
 mm2SVl1RvGNAtCxpfXCiux0cQSUOEKk7z9zzmj5dpwtHLyyAvkQN8yW
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a04b213 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=HhDMDxCfm6Xc3nGqG0sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX7X80HGrhmbuv
 NoiZllQ4FOdYcdP3z5KvIH6qJSsf9ILOps/3hXzc8mOQUJtxr79pJeV8a3NkPE7wqektS+SC+8i
 OfpvanL/Uc7RFFDndqjYvXSC0QeWaxAiL7iagHMR9/vFEi/KPY9amtUfJ0o76MMjnhkdtr2myfa
 GRy1mA9qUXZ5n4PBl3l8V5Fh6gNzhe2iSeLgWQUSHOsQPOMxKkJIYTnPUTmpCPdRgilYvon1tCt
 l1JMkXgM3S9Z/4FhMrVihG0/rtqWhSrMgTh9vmgQJNcfG8wUxhQboKQScZoRTn+lYqioT1pQa0P
 74dl85H4THyN9y/pWHKgwTkdqxFgEtr4XV6bdysmRbquh8xLqXUZzbxzTXWNzFDGwaHfpfAFGON
 oehgEfV6vgdusgfP4prsb8h5wrujKmck1nA9BOGFtsXf2KU2MqiFhQ4Zob2WWONVRRxWcRL8+cS
 FrVKIVL4IsAe6YrMCtA==
X-Proofpoint-GUID: 8B2mZo0XJBmtjAsX4dR9zFUHVt-It4jh
X-Proofpoint-ORIG-GUID: 8B2mZo0XJBmtjAsX4dR9zFUHVt-It4jh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130174

The SCMI pinctrl driver does not currently log the number of pins,
groups, and functions discovered from firmware. This information is
useful for confirming the firmware exposed pinctrl resources during
debugging.

Log these counts after a successful probe to align with the existing
SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-scmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index f22be6b7b82a..999c2061ddc3 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -40,6 +40,7 @@ struct scmi_pinctrl {
 	struct pinctrl_desc pctl_desc;
 	struct pinfunction *functions;
 	unsigned int nr_functions;
+	unsigned int nr_groups;
 };
 
 static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
@@ -578,7 +579,15 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	if (!pmx->functions)
 		return -ENOMEM;
 
-	return pinctrl_enable(pmx->pctldev);
+	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	ret = pinctrl_enable(pmx->pctldev);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "Initialized %d pins, %d groups, %d functions\n",
+		 pmx->pctl_desc.npins, pmx->nr_groups, pmx->nr_functions);
+	return 0;
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.43.0

