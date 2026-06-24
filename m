Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BC3DB30A
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316579; cv=none; b=CAguNcy8+1q1YaV4Bjy0jeYuEV8qcLqPOSE9FiMUKDtufVUQXff/M4Muw/EYUtRT3qlSJhpWlYo/YZF0wPZ9PgD0kGXm9x9mkD9sttYZvmEYUk+mZFWzccXWZ8iPAvh+a3yduxvLN8eTOp3deXyUPUL/h/QmWPATfwCsMLF0veU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316579; c=relaxed/simple;
	bh=OIfIzrv8cXjwoKNsROTB/WmCpERrX7Jeow982/fvBB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8+vzLVb2LsFAGKX4otGuS4Bmo9aMSVkvwo0wYZ6hFchCj/DTXlgDiw/GV9wiyD9GVUxPWc3oykuqZ/NaeKGnmE9I4xnelEByXNUry0ST7ifOBnLQDmmuzJv7mQ6Z1UixH6dyqo4JR9hZPaYosIHMxTq6QxhuwsCZGHYkp4xEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lz9bvbjO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P9rGj5Ss; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lz9bvbjO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P9rGj5Ss"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OFfIhi3877545
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 15:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9bR2ocqQMdp4hN0L3M5pIvBrJtLBQ9RYBOAWa7t2h1g=; b=lz9bvbjOkMHK0fQH
	Xei8RRt14kG6/Iv720DXi/HJzzyo37lfYpLVZZxEtcy6WQH91J/jdMXqWEC6fzgo
	JFIFU2IaCvSIHzIUdphe+qIO0273F56Ram0LvWOzV5XsUpRnglT6KQkWB318PydR
	tWwKuoPJQ237N3ZyTXLZTV8w9WHkaAK9UwkxppH6boguf6GcYDFCHL8f4ifZZMYx
	dQfb1Jn53l6J9GlMUyQarr7WCHkdvJ379xPFv6JHdYesQF26YQYzs83fDozL1k6q
	q/qXUifddppRT2zEUGZP5j87/Me+lkVN2na35gUdMKllpA8IQjYjPYUHYC2Mibzp
	7JgIIQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0996jcsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 15:56:16 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-966c4d26a1aso432584241.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782316576; x=1782921376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bR2ocqQMdp4hN0L3M5pIvBrJtLBQ9RYBOAWa7t2h1g=;
        b=P9rGj5SsZH4CL831fL8NWsTJwelZ/g3SDDx6bfdbtSAsvxnNxKqJREkQM9PRGaqvrp
         4da7oKsZPyLnpHmf3kOnDCUoFOO9F8n8aThqb7Rudt7hHu4Sqih5GdivZgVZpGXEmahm
         VSUw6k7yiWwk0+RqUczugjCk7lKTODB0slKHNPPF0O6rdCKQYhR2ScIEbaC4Lj2A/o/8
         BqvyPRZ4EfDzYYD3MsD55HfuLDno/yE6wAE5VOAQXH8a3ZWVSOh/8m4g2kPjKMyVq938
         sY6K1fFh8Te+rahQPQWS5kYxoO4SqDCMTbbGdDDsMY9B1osQPBKK+JiXPzyfbl7zUexl
         PNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316576; x=1782921376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bR2ocqQMdp4hN0L3M5pIvBrJtLBQ9RYBOAWa7t2h1g=;
        b=pYDkFLAUNaMr4MSBlk3zN8YrzM3ucAKdCXI9kYSifTP4Rby+2d8tFHOH/KBJI5bq5g
         BLjy2rHn28ADZ77F8jhRQnBZ2/fzhf0Yfn1Dy3H5uCpbLjSjkGmcBKBA6hrWnEYH9ziO
         faA1+K1PRrDArjlmStpLUM4bTA9gt4IjI55uN4Eq25BE6KGnsFePmXhjBz/QG6epOoZn
         Na3MSJNB/yH5vW+shR5FNLFODIIbtgIOsbUnoBQQCyIKtFQfZDmvXGQRsfpz900rZmu5
         ih/kxsumUabuuSJAEhJtaj1v2QMFaJgMTbg0cVu9an4WNxhPdAPGF5QLSqG1bEtIq34K
         QHwg==
X-Forwarded-Encrypted: i=1; AHgh+RqnziZ3UBW/IB4LP4PAKS7+IiXOoXPhbn7uB7oUzKnJPgQaC10z1BatVVVbdqzlmy9idh4b7W5SYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypvbDneEp8eIX/VYaM4RYz96yrj8WS45r9Nu4fe8WGp+BIULMH
	nByRZAWEjrTtbHaDq4HS8TTS7V/ZqlgYrx9XT83KyJp8NrwNFE3Dw9CFt0f92aMpZ3JGCbz+EMd
	uAay0jd1Nx7/5O3tWLBAy7bn5BIRjPvQBHvfuf/GJJTS9lYWDlvdcq7PbYjJQbA==
X-Gm-Gg: AfdE7cmhkzo2kIq/Xmxwt6sjkt9KtByE4EcMEL5svK9AOIUcpaDbO0KnXlzWhjJL+oA
	3v61rThM0ulZ1Ztqa1JD0Wh5yV+2ZZhVEO4gxXenlv6RE5xF5b3C9ZByikOt2ubbD5QFn6jDAlE
	iMW4dfuiuXIx+gf/UEqCgsQZZ+CgNQ1hEF3jV+uIdkkuNGC+bkMNOBVaiUHiPvnWLct3jZkJ9C5
	7k9MjMx+EMh0xULcGwi5ckuICMC1t6gsw56iDFiBEwn+9WfKxl+1UN/l6Ic+KnotkIycJIdzjsX
	8/l4YPjaJ/krn82rL3IcSGvAAp9QHVneWO9Uiwxy08XuhFLDf42UJDSvRwTHQx52fVWLprzhIVg
	8gITlMR3MbBOYv6NnRh/Uz6Y7RPJui5uURcrEdMnU+FGkPMl5jdYXzLBpsceN+UOVZedPswA=
X-Received: by 2002:a05:6102:292b:b0:631:af51:7d8e with SMTP id ada2fe7eead31-731162122femr2076163137.17.1782316575672;
        Wed, 24 Jun 2026 08:56:15 -0700 (PDT)
X-Received: by 2002:a05:6102:292b:b0:631:af51:7d8e with SMTP id ada2fe7eead31-731162122femr2076134137.17.1782316575223;
        Wed, 24 Jun 2026 08:56:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:fce5:aedd:3ea4:36f? ([2a05:6e02:1041:c10:fce5:aedd:3ea4:36f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840f80sm8495036f8f.6.2026.06.24.08.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 08:56:14 -0700 (PDT)
Message-ID: <ae0ec05e-607b-4022-a006-2eb1a283144d@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 17:56:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
 <61765401-3397-497d-a0ca-e9bf9d76cc6a@oss.qualcomm.com>
 <5b0f1f39-ddaa-4a2e-ab29-34aacc9ff672@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <5b0f1f39-ddaa-4a2e-ab29-34aacc9ff672@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YZs1LN-u8rfBUxPxxyIdH_3xXzOigwA3
X-Proofpoint-ORIG-GUID: YZs1LN-u8rfBUxPxxyIdH_3xXzOigwA3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzNCBTYWx0ZWRfXxw3lFjikot+9
 tjgE6CpheK6fGsJQAXkp4nKiqgLDXsDABGavWPuvMR25GdwY3RIbpDKMjMNeM+JzGHB+9fbmegZ
 auI2DNNIzV11mhMGXwt2ch+u/I7oxu0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzNCBTYWx0ZWRfX8MAb1/vamK8V
 4ntuWjWV3heXDLGiwx2fhkip0NYioDMezHN3PvCFAIlRqnBBbtIiWoFEPI/aBDmrI53lC1f2ezp
 GaiotNPUvKFNRvNnlubYgjWFghyCZL9G1dW9ZMgTVRnJ4NZcdJ7ycHCh2iaezAKCKSO0LQDriE/
 DvHkL2vtWSK7FhPhBDdsUv0EIi1qNeTGgjrelg466b+Q0c0rg9SlUbZjx1xiJEMelJgiR5gRzk0
 aozqiULMdw8bdrLVzlR3VlKnIv5/ho+5K7lAkVAszuoHvG0KG4q7/6tu0LaA/l5Ms/Un7HhEBYq
 2aH+OK4VApFpGAzvoTDOmRtv3tbeJ5s2gc4IntlcWuwCXozaOVgZYBFsEJHuZ5f+0hEcNvGvxNA
 y6VsCKZl/KZZGeeiz9DODwznsWh0fQqBsAyncXzAXcAlLkz3Pym0NuMu+nVWxJ0g2+OEMtaJtyp
 g0PA+0Sawb+lt5lVsFQ==
X-Authority-Analysis: v=2.4 cv=Tv/WQjXh c=1 sm=1 tr=0 ts=6a3bfe20 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=Zihj0RZBmKQ52BXb7y4A:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240134

On 6/24/26 12:42, Krzysztof Kozlowski wrote:

[ ... ]

> Therefore I still do not see the need of tmd-names. You know the name of
> cooling device, because you have strict one-to-one mapping.


There is one remote proc with one or multiple cooling devices attached.

We describe those in the remoteproc node with the tmd-names.

Anyway, we should be able to list the tmd names in the driver itself if 
we ensure a consistency with the index by defining them in a shared 
header eg. include/dt-bindings/firmware/qcom,cdsp.h

#define HAMOA_TMD_CDSP_SW 0
#define HAMOA_TMD_CDSP_HW 1
#define HAMOA_TMD_CP0UV_RESTRICTION_COLD 2

In the driver:

struct tmd_name {
	const char *name;
	int id;
	bool disabled;
};

static struct tmd_name tmd_names[] = {
	{ .name = "cdsp_sw", HAMOA_TMD_CDSP_SW },
	{ .name = "cdsp_hw", HAMOA_TMD_CDSP_HW, .disabled = true },
	{ .name = "cpuv_restriction_cold", HAMOA_TMD_CP0UV_RESTRICTION_COLD, 
.disabled = true },
};

...
	for (int i = 0; i < ARRAY_SIZE(tmd_names); i++) {

		if (tmd_names[i].disabled)
			continue;
		devm_cooling_of_device_register(rprocdev,
			tmd_names[i].name, tmd_names[i].id, ...);
	}


In the device tree:

	cooling-maps = <&rproc HAMOA_TMD_CDSP_SW min max>;

I think that is somehow what Konrad and Dmitry were suggesting

Does it sound better ?
