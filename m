Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805EA436358
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690672; cv=none; b=X17Pj/b87i16EbjWDmf+Mv45wTVmv/ylc/Up4F4F+Z9CLKsA8v56yAvsTkTSbZqXHbkHVnrwtDmOCPgqjoMv7mfqv8MEKNqd8sINi0HvIPlZYcAPDfwM0rLme6bRh2YVSNMVOJsCIHRNkrKlxSJ+Yxh2TXpdcajAZ20FDr7Vm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690672; c=relaxed/simple;
	bh=b1XEOyYfA71ulQFPRY4KVUwTd8I87LzQvOwhzVXsPXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGhIQFYppe2r8BhE2jVjDFLEHEv3mjgii+pb9t3RGeMCPYXqH3i2egy+ui/Vxm8uHc3XIL8+wZdsttYR+dpYqXVs7n/xPrkD/aOza4Pa0zI5uTipvNa8j4RbvOZXP1WMWtldu+wssIuAaJCAA97ptq6ruFdjxjRjhf8PfpII1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8KHt1JE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HeBTh80I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8KHt1JE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HeBTh80I"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DF2oIq3474770
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NqpHbTw5SrTogkQ6SExJKQySRSNYlZPHGNncVU5RI/Y=; b=C8KHt1JE0kglxy4D
	vqNfiYBPgRn5k5qtEg7Xr6aFGruSU4sdGDOCBqf4i78qfDWAA0bNToyL18FGM7ky
	FEPa20P7r2uCs7vhZJAaF6al91MtG0Oc2IdOah2c86KlWHKFAHOaitfQiOk69anJ
	be43IJEtSroB048evvO37sKIa7ZHNTskDrWESICr1MsaoaCE3Dj0IHflfiyMkJL2
	cOvKqPy6eSAOGrSfu2pj51F29MQvE4AOeR/I8+ZCMW5EAgLpqjCyvHdvweGr04tY
	yZxR7Lqbm35Y/M8Y2JGepKDU7/zl0/eevgeZNNtIFhS9qazYy7Uf4oCevSXZojeT
	hwrjQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p419vdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ef62078ee7so9261955eec.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690669; x=1779295469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqpHbTw5SrTogkQ6SExJKQySRSNYlZPHGNncVU5RI/Y=;
        b=HeBTh80I3nhN3y31XaaZzvyPWOJEhp4zRggAmnVb59MqIvZrb4gjrOQdz3lp16h89c
         JyGumgAUzLyYbDlNMhVIdoE5RUikVawkxATPkLV/GIz1ZzmFPUrWlGI1uN5d87u3247K
         ozNv7RZuikPbruzmZBTEV/CD0MCqNjniDwMempsptBzcfWb9LM5zGefHjs+DmWHGDKLB
         w8qwKAxWkJAXrtSKwW61ygdhtdvaiI0bhZUu6RkrJuD/5vyJLny3utJfbI8Nmb+l2+Aj
         ddSHD67yHb+3bQ8PSSzz1vtI10LZiTPu+dk+9E70phBW54D6K5N+ca6rmv7D+Gjfi4Wq
         OpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690669; x=1779295469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NqpHbTw5SrTogkQ6SExJKQySRSNYlZPHGNncVU5RI/Y=;
        b=XqI81JMoDaHRemXDvYHNlLOemJRlBm7l951p9obdQM9pb40uIZHgzd/b2iituO37vC
         w+Y3s+qiWRUxq2rxizzYR89FCqL2xvQ378XA0GqV2wm0FUTQ/4KTXml5G69bUgYWUlkd
         w9C0VbOnKJYpwtR5kpCxPiEY5dcKnwL3rrHDgWUBQstRbb3Gh4FjNwFj5XoApciVzMma
         4S1ks8T12l47lwqK0i7fbVGHAasBZJciLjqRtmf9HcQ1fAhk15f4KPubiLnJRhU5w//y
         QKcDQ2rlM78WwFU3EIHQFOz7t2aonvMuJvHZ6Qpc+qpCoxXBQD2NyUvDks3Vp6cbwqR8
         DL0g==
X-Forwarded-Encrypted: i=1; AFNElJ+XjqQ1WkKkDFYtTr35pJ6KoOrKx3w4xEoBYNO6ANGE1oZRUM2N+BEVdz/A/4t9I8q5FQNYJSmBDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytVjoxWBFbr4EDrGIqdlC9iihG4FcYO9klqmm3jsDz7Q3ObUsa
	GO1iX8uIxVSl0HCO2/AGsWRTAnBZ54DPzaBlQwemfH+bp+1bU0bN8ktBiYAtrTgZsOYCc3x67Yk
	/bsyhYZo0oRGKwI/I7Lnhs/a7z988IkDEELwmvEdOFvLDHuESMzM7ximNuvxtPw==
X-Gm-Gg: Acq92OEx2Shvbo+MpE8eOxdVUdTWOOtPBtvK4Q3JDvhxY5Z5tlZKjWCv1rRmmD3gfae
	WWMYywf8RffuqNJMf/mXlBEbBkEa9VrzjQKvaWLyDbyjwRhZzDmpZ0DzNFobK58piOiaivhkxSs
	7bTDrC01rcOzDMR3usWu9GkIbRYbSprOWEHecg/TI8UxfNcUNdaHU9kBDqLt7zlxIen28Inc+tT
	rtnQtvrSo1uw3QO4W0cTbEBMn8vCfPzjE4sIztRQDWFkL0GBqf9ioDQ61//cCcjjMkIp84jsNsU
	FUN3IzFUFYKupjAqPNJ3DYXd9DJrUwZtGEwd0xPg27gyc04I162GWpJxn6R9YoLeb9EB9ZSKeVp
	vWdGd0t8Dab4ztDTAj3Ux3U281zlO+voh2ha8DBf8whu4JhXWkMjtkCNYxxssVei1T42VgWY=
X-Received: by 2002:a05:7300:a50b:b0:2ee:f85:ec3c with SMTP id 5a478bee46e88-3011a369c25mr2262175eec.30.1778690668578;
        Wed, 13 May 2026 09:44:28 -0700 (PDT)
X-Received: by 2002:a05:7300:a50b:b0:2ee:f85:ec3c with SMTP id 5a478bee46e88-3011a369c25mr2262156eec.30.1778690668042;
        Wed, 13 May 2026 09:44:28 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:27 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:19 -0700
Subject: [PATCH 1/5] powercap: arm_scmi_powercap: Log number of powercap
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-1-00b47b1be009@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690665; l=942;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=b1XEOyYfA71ulQFPRY4KVUwTd8I87LzQvOwhzVXsPXc=;
 b=My5DR7z1/2KIWwHKe0cIBTddjrYizysbTmiPqsKJxVjsb26CE5501wqsIcvFi+92wv43QWc7p
 CdUopfQLwVqBg3dE2T/aTJ84vQpNT7/PK79MNjb/MZXiXtast982sre
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a04aa6d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Bjf1dfg4zo7KOAcPRCoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfX4mpZHtw/Cz4V
 bJsVIUf9CFqMFMw3wTBlFS5AvvlmM2yUEXVxI9HG7MmPTOHS2MUd3c8Yijqm7DFQuIzE5XD4DvS
 4ll6TwouSgPyfdD2bQZTwadTLu74+vSP6QSLkLCaQpHeDS21pGQRfgQVrNy3qq4zbfVTq2UDZCl
 V8yyNP5G4UnFb9UeiP8mb/4o7zgy2x8G60pBAglTyJzU/zimDaapdbTxZpx0TMLzylqhm+vsJyQ
 5v1LORthv4nX3r5WoW5Tw1Dw19vnwbwIOdMFzczZ9B6Mtr9PE7FDh9UXv8egyTSTz8TCEQsedYh
 0XPdmu2qHGLpy36Sku6dVKECWZeq8uNqrxHIQ1f8MzWBUxOaMegEDf2iq5vYb+FTChtEFzjWyVe
 u7CZ4sBZKfs9tY/VFj0OypyJQ7plUhRbd4pDal/BGD8HyOvRbaBbdpWkmyAB5pnPQllsySAvle5
 0FY96KpcBrQYlmsFHKA==
X-Proofpoint-GUID: jt4UcYXFwuv-eV3KckudxMxGsRS-e3h5
X-Proofpoint-ORIG-GUID: jt4UcYXFwuv-eV3KckudxMxGsRS-e3h5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130169

The SCMI powercap driver does not currently report how many powercap
domains were discovered from firmware during probe. This makes it harder
to confirm the firmware exposed powercap resources during debugging.

Log the powercap domain count after a successful probe, aligning the
driver with the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..48d721385f94 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -496,6 +496,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		return ret;
 
 	dev_set_drvdata(dev, pr);
+	dev_info(dev, "Initialized %d powercap domains\n", pr->num_zones);
 
 	return ret;
 }

-- 
2.43.0

