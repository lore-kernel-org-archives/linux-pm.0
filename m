Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F944D9910
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690677; cv=none; b=VgoU/Yl+BqdRV0XIbDU9st/U08a4d4LenPwdZG4hBHh0tN7JikniRfINStkkbqyvtt6T1TbZ6j/p908gFlMNXGTCUHtKjZlx6YAqnsg4KCx1byIX+Tv4nx6xTh5gtIC7+OKzu8ETy5jdwAX/aga9otYZL+PX9e1AlUXmouT+5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690677; c=relaxed/simple;
	bh=12DADEarUp3gyIYLo4clpW0RLu3uLhIZfXDpYh9E1eQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfDrmjLfCSHTp2sPOzMDRayQzzmI3+dX5CI+9v/mCpjXqC7tz17/khxxcPIQQfC8mFHUvFrZNko61JOk0zVflStiau48luoKro8F9LvnwxyyDz+u8gAI9TilWCv80qgUwwGjCycrvy9dz6JrV7cPv3158heY6f23rHxCvRUAxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9DJ3/eO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tc7LkZbb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9DJ3/eO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tc7LkZbb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DC4gm23324691
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJPzNroPQWOtDnw6fNmSbwn2Jxwjo9RD6cA8VRV4jDs=; b=k9DJ3/eOBorwwk4+
	zKViZkFVYSkOhuK2Zf/yp9bWAkDC00IepLkab5tzvVD6RJgqHVrkznwqIp00sGwF
	zTMWU9uiNNckpMBuiOm3wt2n/x+dgtJxQXNZnPuj8ptfD8NAf3WakVqSOrYpcol8
	sPMCpU4Rha5ok9LMAB2RyU3mGAdLvkMQuLPqlnQ9cNai0scs0b+qR5zpxIGjpm/C
	mvvdebiTPTG0ZV9XUWWdEbEl4ntx5LpRd5qX89JXWMWdxaPW9eRAJjZJhD3Bmp3H
	hoSag84tFXFccKZENy/C+BGsRT7Eoda2sg7otQNzvB0ccUzNajELJP3hv4TQKQnd
	Sq1mjw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdafy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f525565b33so8273941eec.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690672; x=1779295472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJPzNroPQWOtDnw6fNmSbwn2Jxwjo9RD6cA8VRV4jDs=;
        b=Tc7LkZbb/+C50WMNZdKSS1E2+nTUS9DJkcb6r5g2xbjYDnizxFtS5OLKi8BqdI2doC
         OSzEUS9xa/lj4Ea+akxDGpYHLRgWT+LeqRSem/qfNPcawcRxBkzcdzFF2QAJIki1K9V0
         66+DNurpiuc5VGkeqKWJ05MEOeyvDilol+Hbw0rWjlonhMTcq5HQqyhKGVCpNH5KJHv7
         hBg+LJWGeAcexf0gOmMg+Kgez0ZIZbje6fbo7IP2lVRDwS9N+UmeXAxrVcojpwgHIpvA
         XkiV/fFX8I9p76I++Ya9D02IkaONW+i/eP2U1oAp+1zQDhbfTNGxJQgZPEql9MqRasbt
         xGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690672; x=1779295472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GJPzNroPQWOtDnw6fNmSbwn2Jxwjo9RD6cA8VRV4jDs=;
        b=e/3Ihe8yGy25s5M5+RYaTHHAQEaYP83xCOhy5Si75EvHW6HxFm60+TflvOzUTD617U
         kc81qeknWdyR6R1rBuwDwN5UTMm+rAlfSM79wZVLCTraHopl/8GPo9S0EoOG3JXh7Zxq
         0jKhNUo9OKouc2bl49FP+lSC0E9Z+DZkfdYWKN3xlDzDcPdW5E/tYNti/QrpUNmHmzw4
         8vvgsaiKBp1Y1HyX4h+6QuFlbuDvHmbMRT/rsAlE7TkW4yJYXz47pTFSZIA2rFYy7z7k
         gdExU1PxBdaTt1NEz9Qkf9EdMMbXRFT+PFOV0ulXUgUO16Qe5mduNS8jQKStBgywCwOq
         4XjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eptaOvE7jrVuwLxl4d9PR8LagHX7s7mdWJkka9VErGj7pIiT/SC9g+FRIdIukerEUYiUmxSB0lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AaQv0VDHVFHdh1J6maAGQYh6dMbqo2KNHQvHXVyMUQpWfkKk
	Fccjxr2P98MlB0mIxX3tF3JaAF0KRdkPg+xj1PdagHjLhf8HipxEhbedac86CEgXmwoCpJhBlUN
	cJQ8RsxoEEBXH3XRXa1l1WB666vQxYsLM+nzM46wUvPmndRThAvy3j4Bg74ATiw==
X-Gm-Gg: Acq92OFfuM79/88J5lww2dxx9jiPQuFCToBviQY2ZNp2rUM0+4P9v+pNcAsg/AEejbO
	kIR3OyueeulChLj0laFd4M9OfLl6PJEX32J0ii/behdfF6IDM8yyHX0W4gHPNX0s5AzmpymB3DU
	jiopekviFFwFJSCHd3eyX42lk7KMj99V9VRmk7o0l9Co3Vs2itq20vV9FYVmlWrYXHovIXIsF4w
	QaPL9yAd4pZkaftGxMHDJztu/QGYbOOEshAWmT1kk1mdhcBDxMAogTpned+nXjZcKxW0MbJy1FK
	PwYmLfvlcaxGug/JwLSTyvJJAMoyHIKw5tj0r+A+3PG9eWRB94fJQltu7oSQmRNigPPdofzZMI0
	IzSNNzMxKAaaxzB1y0GG4h6bEudhLtQx4HWRFDI02TYej/cbWtOyGn/bw6NWYjWVy3mzABsU=
X-Received: by 2002:a05:7301:600c:b0:2d8:df01:d9f6 with SMTP id 5a478bee46e88-30156511808mr2025513eec.23.1778690672488;
        Wed, 13 May 2026 09:44:32 -0700 (PDT)
X-Received: by 2002:a05:7301:600c:b0:2d8:df01:d9f6 with SMTP id 5a478bee46e88-30156511808mr2025483eec.23.1778690671931;
        Wed, 13 May 2026 09:44:31 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:31 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:23 -0700
Subject: [PATCH 5/5] pinctrl: pinctrl-scmi: Log number of pins, groups,
 functions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-5-00b47b1be009@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690666; l=1457;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=12DADEarUp3gyIYLo4clpW0RLu3uLhIZfXDpYh9E1eQ=;
 b=f8Z4VKh3kEE91Iigqa0bRxoLVWmVWQbHnG8x2yHuKGTYSe4kcqQ+PrzEu+FAzIg8VOT/Il56e
 tXkqUQ93A4lC6rKJcTD1nMijrqk2HNyOstseNE6TFsoECw1hvHSuoOq
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: Wcwhzv6hNPgN3AYtxOvno_aXZGQMzoKq
X-Proofpoint-ORIG-GUID: Wcwhzv6hNPgN3AYtxOvno_aXZGQMzoKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfXwkYzxa9sk0Sn
 VjQwj3xi0cpZbH2yc9DwEiPI1zCz1648a7+xpJ889BTaei36a4TTB191oH0liPdBmyRbywXTVut
 oJlw2bFHJxEqROTgMsgQIfVbtWEW4TosN4ivaWhk28TNa2TYjh7WDiDsG76XHPcOMi9bTpfZ+fF
 oTUj8Orv2GkjzpwVcWBDFRWeNOGVNHr8jFveROhS8hBxsCH6+YoKr0rMTTysuFAsleuWeTpSEz3
 J5/pPKuJncDjSQrw5+OC1IJA+WmfABvSEYS5PYlQTgxn7ED9NylaE0wWXRHbuj7kR2wG1gZri+e
 +i5s7QSnvycuwT1VFle1kHG4ZyLYr+kbXf67kE90PP8WCvAJtN/Yp2fwBQaazBV1rZFKU7vUlae
 VkF8yPbzp6cFrFEre3JM4EInCuToEFc+3lgEu0xeS6KufTiqA5hb1+44jO2fFzIUEAWvBVKOpPk
 RaxyiWK0SpOl/+OBVKw==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04aa71 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HhDMDxCfm6Xc3nGqG0sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130169

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
index f22be6b7b82a..abc90a3a7eaf 100644
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
+	dev_info(dev, "Initialized %d pins, %d groups, %d functions\n",
+		 pmx->pctl_desc.npins, pmx->nr_groups, pmx->nr_functions);
+	return 0;
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.43.0

