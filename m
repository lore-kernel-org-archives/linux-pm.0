Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A13B83FB
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895604; cv=none; b=Me4Lze+MbGMhEAQ//t2v1DNLlVy3jnQXrMYOKaE+6fSE2Uj4SRVzJZcJKMUJi230+OesLEcYb7ZihJquEZiy1guiHxzYp6ZE4JqOIZdsWupkbUVVPKMjYflOS32rv6rWhuhOFD1uP7x1zB1LH//eFNQsk7nvwAO+sY10ah/N/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895604; c=relaxed/simple;
	bh=GRbWxHCWK5woHSJmqcg4vZ8zKDdAitOAXTLbGcGk20k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwKTrMFvaNB9JLHictsyoFqfgo4tadf2RQxTizMc4G+a2rIv2ku0bew25ynfFsvgiwU79DwkyIvbk2qKDcNugvvXhROYzf74P0l05BDasOetiqJpfdDrayKkrtahfxQ6z6Ho7tOImK18KVhoiBggWokOnhq7wTA+NDfqSDmqDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMC47t7s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EkK3EZbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMC47t7s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EkK3EZbQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618G8Ht410936
	for <linux-pm@vger.kernel.org>; Wed, 1 Jul 2026 08:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kTd/R/2EJF/1DHxNw7D2N/60ZnX+FUJkLfb7saHZSjQ=; b=CMC47t7sQVuxQ6B3
	hC8OA3TwKerLajEDnYVXu4ESqdt7sH6pcKdMySNpfLcH42rMZImeoVkiE/NSZIve
	wSgwpTyq6E6PJhyBBmzPi1HPbkQZELeVYnj+21O+8EtMQVhXoeqEEu5zal2hFt8J
	pkyNJNuQrUyKYRd4jSZMY1WH/pI4kfJugc9400mc075bYgzvuZUYAqAW4Ej0UW6A
	sxgQgmlPda3j03NUK2Pm7ftfPav+kva7BT1zkDikGoCjnpIFiKiVkV1qfrjuSpjP
	Om+2PivcK4Fl1NJmWucqDUxgoe1SqQTSwAkKbXPiPm2Rv+iORJfyrwtMz7t7gAAM
	tPShJQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfybnqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 08:46:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ca81e05bfso694760eec.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782895601; x=1783500401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTd/R/2EJF/1DHxNw7D2N/60ZnX+FUJkLfb7saHZSjQ=;
        b=EkK3EZbQMtG09hwHvn9EDIcaXvg+otFd26XVv9vcpdp3b0o1xDVkPoouN29iuYxShs
         vsXRcXDWDkwaNVa4aB8CVvpgygb8bQVsVTKZPTyqIbkb/g0VIrcDhtRI8Y6N8qs/KcZo
         rjn0qxLd7IUfQWtIjqV3uYDZ+fY5pJsAfDSkllGBVfaDRFjK4qrcjElQeEof9GzXEjAr
         /n3m3RqAonR1OWWU7IT19/4a0aUOi5fKNh+TkAlpLop/P03YwAfp/Oh2KqhxH9dmDoA2
         SBC5w9l85cK0uAYqfJQo4VsMVihLPEmajez6CMzf5OXCy3AOx/BMaJJwrQQqwQM6q0Di
         z63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782895601; x=1783500401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTd/R/2EJF/1DHxNw7D2N/60ZnX+FUJkLfb7saHZSjQ=;
        b=HxtjcxNKaY/cxDdqGKxZXB7zCADxaQLN2GCnq2HXdsuzKaoVMA2nwex67jcBuZ9v5U
         7yRCIUr32c4BMtA1wZ/pu3ds0U/rowmYHw7prX/6rxWL6VZIDT25rBYPhnFSRbhjay1B
         bbQvIbuvdJoPs/ZcUKIHkQsZJs3a2p8roZWPvem61nhJeTbpepo1evT4uUVtU6t5MdC/
         ZBR8OGqA2GtfPZa702BKGuc6tU3hunflePh18aQw49RuyyC50E79Nk4SQO53wVDbvkNx
         ikodCFHKs+o0TxAhZAF4LBQU7V1IGSLPemJ57upb9hbf8q8FqgjubaHgEPpvaotqdesW
         cuSw==
X-Gm-Message-State: AOJu0YwbSKJCXdY4xtghs3oNPMVN5wa67W6mg/rJWQa/R3mOvpi+Z50r
	LlGMkq445HNZiVxDKN7+AiT+eGfO+FmtFg4Ubx+/qtSLPR+ZoVWZCaIkjkAvHp6qTyuvsNSBHMu
	1tW1KcBvAoiB6ghKRqbI2YA+Kg1AnsuYDRWnsifUAmXG096AuMRxgU59YCkm4aA==
X-Gm-Gg: AfdE7ckSZjXOOZ1KU4h88Ht+qxQ5cRlGfEOuqzxk3eifyaEDjFi34ze/iDqJbuxTye5
	M3eO1V0kc4S1nQFewcQ3kA5XAJ2Pe1QV03xkPwhJU+06oE3CAOCu7iQXSmaJKPbQ1lis+wAKj2r
	CixU6DuoYSzofDR8aHTObI4dv804J+7zFkHbe6TEWkbGWJTMth79p0de4hEQnYT+51fP0g9GgJw
	GJyHzT2dHFtKMvQcxM8wYOeJUjRZqjXkONFceqCUDP/lmj/5cX0FHip4Vcg8T6+Jm9GYaNUa6CO
	42yVM9J77HyJ2n2nIZ8JZGK3Ok866D3+315p11uEWOC7qHj46hmLCcj8O/tV7XYijKr7askMYgA
	JPDDy7TAXyQ1NGNqSWwsb99Ed9OLItJwvF5grYIVWD+mQ7pIN8Ng5y0E+YH4wA4ForteC9cvQui
	vkF6850TTf96b5vLZ+AjRO9hW83m3g0oryLK2396GT
X-Received: by 2002:a05:7300:2211:b0:30c:536e:3a8a with SMTP id 5a478bee46e88-30eff0534bbmr843580eec.6.1782895600793;
        Wed, 01 Jul 2026 01:46:40 -0700 (PDT)
X-Received: by 2002:a05:7300:2211:b0:30c:536e:3a8a with SMTP id 5a478bee46e88-30eff0534bbmr843543eec.6.1782895600255;
        Wed, 01 Jul 2026 01:46:40 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30efaadc5bfsm4891524eec.28.2026.07.01.01.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:46:39 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 14:16:25 +0530
Subject: [PATCH 2/2] cpufreq: qcom-nvmem: Add IPQ5210 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-cpufreq-v1-2-98656ad20ff3@oss.qualcomm.com>
References: <20260701-cpufreq-v1-0-98656ad20ff3@oss.qualcomm.com>
In-Reply-To: <20260701-cpufreq-v1-0-98656ad20ff3@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a44d3f1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3tsBT5a87JaRe40zvzIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: ryyddKtBHMvC4fV9uTC5MDfG8sqmbrmL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4OSBTYWx0ZWRfX9mf4yVTNM1xv
 lXRXY5U6z0ED6jc2VKN+nAP1N1W2XnImpGoZM1Kqw4oKuzc4Z6i0kfkRBQrBp8q3EFLEjQHgxKN
 nMqJZpS0+yIJsWW8t3gaPlmHuy5RLZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4OSBTYWx0ZWRfXy6O6ofTM5EdW
 v8bWqBne4ias2GU1Km7QdgHtqjyYO8z1vOHu12QkHhA7hx8jzYUYWmGYN2ZT8gJQyBEeAmvaw5N
 P09O+q0HvAfhtE9b0l7KoEjqkauda4jbLhP48CTc3iZ5f4s8eBL1+Pqz4LA9b1TUjNqWk6F3e1J
 H7VJ7LSaiuUlMZhjR201ju0maZFFVuyBABojcN8yS2C2DEo1g8QTQ6gUAbuLztcUeTikRAgkz6n
 8xXjAKh3N+ZNC3Kyu0wzjABmTg3AKYX5VRiSxJSzqGyXLwqeJm1IZqzvG182CsW6sFtkvw+QeqZ
 shwjuQPT9+jFbXNZ0rKEWYD1+UjW/8f0qdmnJNxpBhj2X8SzGlltTXpHoe1NqSIwZMA+/wNnEeq
 dgMb+fYFU8YhkQFdfHIO8So1jLuVR2DiLrnG+kK0XdrJDCuoex7Nu7WGdc+VrRRh5Uryfj2nAz2
 LXq0EOx/izQ3eWIohHg==
X-Proofpoint-GUID: ryyddKtBHMvC4fV9uTC5MDfG8sqmbrmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010089

IPQ5210 SoCs expose CPU frequency limits through an eFuse speed bin, and
the valid CPU OPPs depend on the SoC variant.

Add IPQ5210 support to the Qualcomm NVMEM cpufreq driver so the supported
OPPs can be selected at runtime using the eFuse value and the opp-
supported-hw OPP property. Also block the generic cpufreq-dt platform
device for IPQ5210 so the NVMEM-based driver is used.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ff1204c666b1..284eece9e230 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -200,6 +200,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62l3", },
 	{ .compatible = "ti,am62p5", },
 
+	{ .compatible = "qcom,ipq5210", },
 	{ .compatible = "qcom,ipq5332", },
 	{ .compatible = "qcom,ipq5424", },
 	{ .compatible = "qcom,ipq6018", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index e6d28d162442..b2aeda7c564a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -200,6 +200,13 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_IPQ9574:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
+	case QCOM_ID_IPQ5200:
+	case QCOM_ID_IPQ5210:
+	case QCOM_ID_QCF2200:
+	case QCOM_ID_QCF3200:
+	case QCOM_ID_QCF3210:
+		drv->versions = (*speedbin != 0xcd) ? BIT(0) : BIT(1);
+		break;
 	case QCOM_ID_IPQ5424:
 	case QCOM_ID_IPQ5404:
 		drv->versions = (*speedbin == 0x3b) ? BIT(1) : BIT(0);
@@ -618,6 +625,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst __maybe_u
 	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
+	{ .compatible = "qcom,ipq5210", .data = &match_data_kryo },
 	{ .compatible = "qcom,ipq5332", .data = &match_data_kryo },
 	{ .compatible = "qcom,ipq5424", .data = &match_data_kryo },
 	{ .compatible = "qcom,ipq6018", .data = &match_data_ipq6018 },

-- 
2.34.1

