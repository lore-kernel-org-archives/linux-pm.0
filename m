Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA151D63F3
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275915; cv=none; b=OKxOvfBANN676sbyKo5zTN6n9LbUFrcZiyB7s8rvf38mDIEMBoIpZdzs1spNOFC8dlMlQkAiurqtAC4evJulh1gBP58Ia90uEKQZBZBsyahC3tbCh4bYiQQOGwWKzFF1cf0SGqjWGHEZuf+drnKxLmhzfIPeqV0E5+llJarpMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275915; c=relaxed/simple;
	bh=A4S0Obn50bo8Fl9QUE4Gbh7lE5KgYdMRk3kjmHc2cK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/Ogl9PYnQw6zmCZb5lobYBsbW8wU7komvmQKbsryvBkW+lOAPy+vyrzW0Qb5j7bBW+OBzZSqlHHP+hlL2Z5Rh60tAZ70CphErrkyN7jyprmuvcCc3JK/zamK0UfhsWBBs9VT1E99OW60U7HDfi48ENv3D02ur2axr4UgrI2rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cFtVLiHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2iRQz2C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cFtVLiHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2iRQz2C"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBM2OB2758870
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 14:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HDPM+iygguEo6RsgHUPPflP1DE/XL/8HGaRlTwa3/d4=; b=cFtVLiHJ404HcVG5
	6NWuRBP8NMHwrTu1X426qgKFOB6/OYBqugspSSaWeK9vaNavhkTHvj+vghMapQbO
	d0nKtC/TDJhxvsLVTRcFjJfKG5JMk7Nj+h255tU+k8e1C+iOIrPwrrzecDX/uh3p
	oKEBkDJgkLUh4BSOcl7fpie1p1D0c+4UqsoLSPBX3oVlkCDLWWcANEF3NCBo0ChT
	AS/ANV9ZvPU3q5X+2wG1sTr/qRi8pNU7gytneNgnsgGvdCRp95YZQ22WaaqPlCdR
	LSY7km0ajzXBL90CfVuT2heJBd2HuVW8WHgzvcsDoVFopp/Jkp70xiAaeXq++Ope
	x6CPVg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4gncy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 14:25:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b05370ec01so286982515ad.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774275913; x=1774880713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDPM+iygguEo6RsgHUPPflP1DE/XL/8HGaRlTwa3/d4=;
        b=X2iRQz2CF9Ie1LIq3ECasRYcsuCx0RY5pr126VSwQzrVCkWR9RSE8RTEIQ8mbyR/Qa
         Ht+hatDwBnw6SOe4vmL3yxZc4h6MdrvgVnE/WEiv+GU7bVS3PD0Ho4RLePkh2mvyx9cg
         FnPxBgdmnpsrxOqdY8le9V6/WB0NFt3EhRVkFUxKDdFcJ5FhOMa81njMiRb/6yC6AGlE
         7df2sRvhxIETNdI6Il+pqXUyT2ocRMnZy/1rT6mGn/62zM7yPftcH6p23odpe91jGcks
         whRdrxFyXTpniU3iQSvEy+dwQosgRb+XHaMgQxrJ4YYkRKu9Rmg5cVi6S9vSP9u7oryp
         DtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275913; x=1774880713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDPM+iygguEo6RsgHUPPflP1DE/XL/8HGaRlTwa3/d4=;
        b=UZDioJkqUOVe9xhq3JkpstXLxkgFrCDl/UN7SX7cUw1Sv9ks6RUVcZ0vIkODalUyKJ
         nhupfdGbP256xpiY5F/FU90JEDqFjW3h+BaUWNos9b/2vIq+50fpNe/rMUu9QPNHFVyN
         J1ZX0W4i2GVhSjG3Uv2jOo9rHtf4h1ghMRXG/mOvFX2AiWcsuUpJHdN8IZVwEU9CtiTK
         KmALVXPzwu0RKRwBEZYxtSZLPL6nJj+fua96g4iOd17PwudwWpZuKfP8MF+QRvSEEnZK
         WhQwsnfXXvTxYiLiXeL3H6eqsQI82swNoKL8KHPEw6poLzUBkzLN2xoB1pim2yT61p01
         1FPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Clw0jpO+gxX2sWKLjlEiGC35YShsoLzatmoYSvXwow9Z2VNwAQ9VXR4ITU1fLvWEQ8L39+2M3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJn/g/n3erVh1CDHER2vyVnED6/BbLBjJWiPmOjGVEUXcRRRSb
	p4T3z+y1ye8Hwv2yNsciS1TDCYBmdS/YzKRzahbyz3k3BoJz9lTd0AgrFwakP2lR2WUXaoH7FMT
	5qu6UNyGbdWcOpKgo/6hovSeKoAykMp7YiyVJ1uo+GDfJXD6VcT3KwYfo5rioyg==
X-Gm-Gg: ATEYQzyFrp4Fop+X/7MZaIno5pqCfwYmeV2q21Ks1xMZaOZ5HlAQNkZhgN+aFsgi4rp
	u9pTnFvQqQHqyQLtQn7oXh17pT9SVxyn16k4jg4uHLzlsgYne1LV7jibSHKHDLWKP2qJ/50c/ke
	Jw/cX/x37VTo5InW7SIU/gVT553RT4zHzWmKgmtWXe0o+hrC6y53T3riGtHeCa6Z61lZhvczbXm
	Nnpz3h+nGs+OtmyU9eqz7oGG6ob8wOVBLh6IZ5OqUW8CFOQ0mqqtIY5Iza2w5EAKXuIzuRj9fAS
	0Xt/T7H2hPorg+jCrjfL/n1q+2rDXM/sPUzXSopXZxGG3WTuT/j7l/fYn0v17mnstDfdjMownTC
	4ifkeDs2fzgFw+T8RY97DfoSJX7G68GolnaM1+LvxpP9ksCgIfQa2
X-Received: by 2002:a17:902:ce81:b0:2b0:6999:ee5d with SMTP id d9443c01a7336-2b0827d19bemr121141095ad.42.1774275912846;
        Mon, 23 Mar 2026 07:25:12 -0700 (PDT)
X-Received: by 2002:a17:902:ce81:b0:2b0:6999:ee5d with SMTP id d9443c01a7336-2b0827d19bemr121140615ad.42.1774275912312;
        Mon, 23 Mar 2026 07:25:12 -0700 (PDT)
Received: from [192.168.1.19] ([106.222.229.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836a3370sm112429015ad.78.2026.03.23.07.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:25:11 -0700 (PDT)
Message-ID: <c6c716f7-fa49-4eac-b177-b88ac07c83a5@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 19:55:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-whispering-caracal-of-respect-a26638@quoll>
 <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
 <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
 <17474333-bb82-49d7-bc04-45ab21095c38@oss.qualcomm.com>
 <ae4c1f7e-8f4c-4ce0-a6b8-bab29984e693@kernel.org>
 <c6136314-5bdf-466b-b19e-43062fb11150@oss.qualcomm.com>
 <e6679f94-2648-4d35-80cf-d3f823f9dad3@kernel.org>
 <4f815a0f-a815-4b77-a4cf-a4b18e776eab@oss.qualcomm.com>
 <95142608-b5b1-43a4-b8b6-38e658275f30@kernel.org>
 <abhgxF1RcAJD-cK9@mai.linaro.org>
 <3922012f-25e6-4b75-9183-f9277ef5d040@oss.qualcomm.com>
 <74f59ef0-ead7-483f-a80e-a3da2f6ebcdb@oss.qualcomm.com>
 <909009ab-53fe-4b20-ad2c-bc8eac9e8bc1@oss.qualcomm.com>
 <7e50100a-514f-4f73-a976-9858ce5cc0e1@oss.qualcomm.com>
 <2d1d6fd3-b34b-4eea-a4b7-0085a6a7342e@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <2d1d6fd3-b34b-4eea-a4b7-0085a6a7342e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Vf9dN1NA47XDFPCSRt48hFjzSC47p8nA
X-Proofpoint-ORIG-GUID: Vf9dN1NA47XDFPCSRt48hFjzSC47p8nA
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c14d49 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=EBd7WcfsMYPMwvoCMWz0vA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=PqOKcQRRktM5gqkVpSwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExMSBTYWx0ZWRfX/f/P5SOH6y82
 9sWjxyStqcBAY5ZL1ivqcBxyUQlOL1vrYEfnVRpqse03s2fqgurbpQKdgPcyFq1rn+P6OkHyCqn
 xbwnqCKsX/7bQa9WkSUasKVmbC0ukyeLWxPwvJE9WEUJXfjNxJsTvXEP36XP3F5BFszuijvkmTL
 1P2nwMNWrYXBgUw7SZ1eXmV65jtalVanOqWw5aYZ4a8DLmAumitRuzK5EKiknaEFuwxIlSpcwUa
 QG9a3laOjGWAiUSxRKm+Ghgid9ZKCqg18DiRTWfSra523/aZhlqXRsnjjnmUKg9fSptA4oGU+KD
 lS6UwMw/6H3+DWqTyZ00pgSRCiCAAuXHJ3Jecd+PfTqwKoAsJ/+C/RYqN2fCLnskzYvvKNRfG7M
 zHDLa04r72lqjwwTf8sWUaFmYOVvSDcA8QJeHawC304pAYyRzZok7KDIdgN6G9mh8LkZ1PyMlDm
 NbsnOZhwqIPuwSRM2Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230111



On 3/23/2026 7:49 PM, Daniel Lezcano wrote:
> On 3/23/26 13:29, Konrad Dybcio wrote:
>> On 3/21/26 10:00 AM, Daniel Lezcano wrote:
>>>
>>> Hi Konrad,
> 
> [ ... ]
> 
>> My specific suggestion is to _not_ spawn an additional node, since
>> all of this logic relates to the behavior of the (e.g.) CDSP, which
>> already has its own node
> 
> Got it thanks !
> 
> +1

thanks for the review & guidance for the design.
working on it, will come back with a new version.
