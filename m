Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCB3EDE5F
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895600; cv=none; b=PiRAO1GeHnHyS6UVpHiFNdZpLyiAOsYR/i0aQA45sqFAT/8fLsOHTIOcwFLVyTN+cjAgIPXF1s6LXDV9s9Gr4ql8LsyhjtB4I7fxfb3LuHM88UoTNi6j6lCibvy0yWqiyTrfU0bDv7s0l7RTgVRE4RrIFF0zJkDJl6H8e00UB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895600; c=relaxed/simple;
	bh=VWNZfdQqzG7zO8m/ujQ06elAt3AMY83F5V5dnMeOC00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opmVOrV46onscmZwFGQPdYLBUQZ+lGwcyZkEAmTLWeUcnFEBgqQEtxl7jlJ+WDXmAW/BJB4FCz5rdoNELZvPiaszl+4csxT3lldcKLhyRH+8H0KwXP5zUf5cfNujd3OEWHtNSahCBa8iR0pcAec5DvTyxwHSqW/A26KILGRK1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqpZ5A0w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YPQLuYBi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqpZ5A0w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YPQLuYBi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618G2xJ456073
	for <linux-pm@vger.kernel.org>; Wed, 1 Jul 2026 08:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sXpwPOVHRUSUaS2v1xJ/wsTIPsSlu7sdW6vk2hWUeC0=; b=MqpZ5A0wilrNi3SS
	oT0BSRXaX1ByrSjMB5BwWRkeccmsQ15DXp3UhKJCpg2j2Zo97up0NPdWfWoTvTsX
	C6pBHmqfv6unyQQGxgbgBXni5UDm+oXmTBAdLfiYa3hLVMH9+DVtB1HSMX9y5S+e
	p6ei8K9pwZcObn4eL5zeS3BsD3+vmQLXCMz4ewgra2hxi5s81ohYqdUfZAK+Txoy
	BA6teyYZenhEfEYHlXnph0TCU+VcnqpfJbESprPXfL8L5penPu5vA7MsGJhS7MoQ
	JyfwMH9MOCakzZae/kpN/vaZpEoWH41nu2ZECXThFjtHv1ZlvTskXAHj5PUxOMg0
	PLjhGw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwb3vn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 08:46:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ed53abff8so680675eec.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782895597; x=1783500397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXpwPOVHRUSUaS2v1xJ/wsTIPsSlu7sdW6vk2hWUeC0=;
        b=YPQLuYBiJN17WwzFD4mFlLlvzuEBgLtGWlrpLWclxxUu0wTu/9s2R9bC7xjUq74wXS
         zxl9cACK1kfj9lS8GqEXe7lhp5djaN+jRd1XeRaFb3vr0cnPd0eQ3MjCzMzd6DQHZjza
         xUP7l4Qrzq5II3QSC2dD+N/ATuV0MtHa+zDBLIIu6HOlOix+S1vtNzDzhTdzruPZPlcn
         Q8wuSufkJm9Bxj4/NYHAqVP2g+w11+gGUrsCiYnYZz5uIbvlI9AcbPGTqoRy8NtmJDJA
         UiV+qf32u3bp9UbgRnL1WvhGf0cXrZVAjhqsYDpiNbCrVvjqCCx36HTh7rvV8HreQZPa
         SUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782895597; x=1783500397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXpwPOVHRUSUaS2v1xJ/wsTIPsSlu7sdW6vk2hWUeC0=;
        b=KBDCMyPzXItAyjr0rGAFqn/sAQGx2PUxtYt5q0MIqHEboVsthYwe4PQCKtlFrV5ZyI
         zvRS9DLy79o3/ANA6FKweQOCIfadmAoGrA6jDAPDt6N5iyPvIHxHH/Uct9qlJggV0+JX
         SpGymxH7Zs+H1gE2J9MmezEngj9YYGEYk5yN9SQavKNqYxw6BSozDEVi4azFrmL7RKAU
         rjFB92jy1Jvqdo+6TB3+3h1KjT0eITOFss3vILFG4p/2sxO0V9xLSThIfA7MoYZ8oFxJ
         6jMcskH3e9kxOwcg11KeDv8SwhWmJ8gfnwF9aGAZxSnQ9Vaqo5dfZiC6Ybmzb90vgObU
         NiLQ==
X-Gm-Message-State: AOJu0YxO9dw+JZ6f5qUXfiG971+jsSB1GeZhzDfMgfkWCed3HUIA3Mle
	OrQ0F3oYkcyw5xx9GUdeWCk/+It65CoU2v0rN3SSNEJM3YVXsXScZoIT6bmKv1Bmv2DdVyolCVe
	wzVtr9BPLouIMwvI4LsmDukjwjq/PsbU73/n5u6eYYC4BHAWaRvHs/atJB2LKAg==
X-Gm-Gg: AfdE7cndZ1VuHXtwu08aa30nbYJY4R3JnuBVoLAofWOiA65PbB9z4XFAMOtGrVwN3TJ
	T79aQkgYIHx9j5UjliBQKZUEkhaNDmeNbywikWPwiUbjROyYhqDftTdG1EIsQgRaGABu1eXB9Oj
	DjmVta4v8LjSNNaCrM2z/gfveHjYeXIjQVUzj2NDE7rDadgptbCBQExv4VsXunf+Ea+ToQ/pRy5
	VLb/PbAq0OcQzFn4Z8nTINIkM8zXBIqqiSwBM6ra2pOPGkKrm+sxYRwNXXtemt9fgZIuB0uiat7
	90gwo7xqUXRa5/oErZIvaS6gjWudLHhTtkOyuskiqIfMEdaY9dNSOKtUCu6DFeOOYGdMMWh0bD8
	bYioQs4Fpr1LTImBkDPtwYosJ+i1a3mgo+6cHY8qSETzGpuMhxTWZ5Oe9W3RZpvwHJeq9zMZDrV
	wRbMpfEes6tr9OoCbBmZszbl4Ily0fFWeyp/uLdsV9
X-Received: by 2002:a05:7300:ed10:b0:30c:ab4d:3829 with SMTP id 5a478bee46e88-30eff398cf1mr907857eec.43.1782895596706;
        Wed, 01 Jul 2026 01:46:36 -0700 (PDT)
X-Received: by 2002:a05:7300:ed10:b0:30c:ab4d:3829 with SMTP id 5a478bee46e88-30eff398cf1mr907818eec.43.1782895596178;
        Wed, 01 Jul 2026 01:46:36 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30efaadc5bfsm4891524eec.28.2026.07.01.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:46:35 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 14:16:24 +0530
Subject: [PATCH 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document
 IPQ5210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-cpufreq-v1-1-98656ad20ff3@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: piKU-coCkO5S73UygbjhBpPG_QCyS3Qv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4OSBTYWx0ZWRfX9d8na3qdMMvS
 gPDhTKjKvVQmHeYvosiFYzUWZ8gmERJvFmdBAm+O86uUkdAQMx7UDRB/tibbLM22o9Ec1hY/oub
 0sQdV+YTA1I2dth5np2RPoRF8PTtE3E=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a44d3ed cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zeNabaxW62Sqe8R-FXUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: piKU-coCkO5S73UygbjhBpPG_QCyS3Qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4OSBTYWx0ZWRfX4Oebo7hyO9cC
 W1+2yghxWSE+SEs+oninGqgyVM2S2lgqFkSoZizXTcfj7WIgUDLb4gvXZb/9xZVCZrqze+tBfgs
 W+22GEgkjBNkOvMcuy6E332g0no5pe2rOoHxhnikKfdPQWXYZHz9alosmFYz5D2GUyuyu0oqx41
 tWToglrj8L3fNk3rySXZBv16Sukuv87AUq3phOD9cfXCIrk5pe8iRxbHKLNvHM4LawsmCBnCSZN
 w+uXoM829l6Drj9Y+pOR40XxP51/rasABGxs3MDjk4iN7AwVXj6utKOaQJKVqP62gizv1xG7Nu1
 i/V7TTUEW+J55wrUUGqp8V2rP7xW01ZPvSBp5TBSPiwrwAihWIiNPBGcEPnj2m3bi32bcaajdUi
 tZ7eyyap0FT1mgPsvukri92JJwftlWcdV8gaGLAko+FiwZu7d5Gf2geGWiBZrZQM+954KapF1sh
 /1wv5rAnZebxhlPmIQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010089

Document IPQ5210 compatible for Qcom NVMEM CPUFreq driver.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 547265b8b118..2f5dbb59034c 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -27,6 +27,7 @@ select:
         enum:
           - qcom,apq8064
           - qcom,apq8096
+          - qcom,ipq5210
           - qcom,ipq5332
           - qcom,ipq6018
           - qcom,ipq8064

-- 
2.34.1

