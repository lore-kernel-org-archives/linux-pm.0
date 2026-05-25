Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD4383989
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713711; cv=none; b=rjlYlMbm9IOHrBc3Y6ZKbPK8Tdj6Zu78mHYqNn8Cvc2hwJBotK2ZLPxxBbqadHregoPQbKJd7Ey3EZVm4Jnd9dt15kL5XxIzH4NpipRr3MAFZgJ5N04rOJGbHTnrQPz//d7M/4qnKKmwWnWqf/crTjf9mlzhhzZGukTVIqOh6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713711; c=relaxed/simple;
	bh=jrPHDUm/+lT1kV/7BLXHI5qniXBpJQbPWvYor1QGy8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8CVxDMgX/wWbysE3lzwx1k+zx8CNCpgfasoRzqRYea6iEAsSViv0kKotF3oI4kPCFrMVwqN2tkK7Yzu4nk4SFYy7naZT4cmGOIFxjG+8qkf8eAbuz/vYI0MT4sN7M7ixvnrT034aW6fUa/FidnumqETMSlOIfibkD64gPKqrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c4WijiTT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvXxRQpr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c4WijiTT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvXxRQpr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PBAL2U767582
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V8RZuW+ZV8JwXDg+pkBPy+nHPlIxyE92twuTWRnC91s=; b=c4WijiTTAlmEp0+w
	/W9j6w2M5I4CbSLHhOQhb+GKTEYs6b/OyTaOphOP74L6RDMMf3sEf4JnH6f1Lb4D
	Gbad1SpCEyDbZNfP/3IEQKmwxEziephhfeC6gGKPOxzb3Ix4mIXvPXJV662XC/1p
	gnf9FCQfPD8KVVAauCuWkLJKmnR4m3jA11oKs9BYn2Xca7R+8vo+f77CfwNKuq+l
	BvHCltqO7wwY/JKd3jpNZgfBKOhYoyuxZ/oc9AGEyXVDa4/Ds3/meBl29qAIaeS9
	ohsd4NVxhiPI3Vdeu+MvPhm8l6uqv50zNVH7lXYN5l6Wj3aLA1xl62uM32hC74Pv
	onstzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0wv6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-914cffbffc6so15489885a.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779713708; x=1780318508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8RZuW+ZV8JwXDg+pkBPy+nHPlIxyE92twuTWRnC91s=;
        b=kvXxRQprFh21m87JzIZHdzrslb1EVeRg+FDQLLY1UZs14BhoBo6JfmtcijT0HoifMu
         woJmWQk47P2iWqace2TfImQ9kopGb4FUyo+FQJTUEGZxnt5EfciCKvd3YyK8JYj/zu0C
         kbUKbaOgRMqZraNvm9t6rlIlNjCFixfNKwaA/bNqZbQ1vlZmC2kZoAueTE3+D8EVMCEt
         PGXmR9yukg1jzeMerTaHL5TPj6mdjRaB2KWZv8b+sgyU8MiAiRzXXoev+l1uxzLJsKtW
         EDECNp5Cd8Jg5ADfBT7JZv4J2OxW+JOOuKIBer64+4lmuq54pLBqSWLu3f8DvRAK6ADS
         wNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713708; x=1780318508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8RZuW+ZV8JwXDg+pkBPy+nHPlIxyE92twuTWRnC91s=;
        b=MEAovP3jduEmTD8pvWjyg/S16ceuX5wrkiXSa2uxFvgMujDsHWT+UonA/TgkFp/UnQ
         M0/t9lD4vsoFp6e+SDfoJXfSoItDjHXP6liD3NJ5SlXdDIPOAJHv1PB5ZYl5lSyPBtIl
         zZbsOm53Sl0qvUtQYeChJIwo6O1JGuOh22X5GcsLxGKpngM6FuW99KXMi8gVE24NHFgr
         dsadogUzKBLLtXhH+8p2sS+GkkJZnKG9Qx9mDF/tDKC/fzvE2s7GbL9M6JohZDwKzY+Q
         paXVztjnoqWQHFWtnEfcLUIv/WiBwB/0W+YqGIsalxUwc6DoA8U8dmJyNiMxuyTCPHR3
         o9QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XkBHQ31e2sCTZCTvfkNX8qPH8WBWnRa8IHsU/mvQcNwcAySHy4EdNAcZOmFmxF/pyVbpAHNa4jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZGZMrjNOOkyCzoipH19F6Kj8zIWZhcdvc/OI1fOPSbE0ysR2
	ODG4GW1+9vIYCFVo5Oxj3yMd2qQBLVDgagwErFZq1q1g/h1J9hYgWpZWmLNyCSZJ1yrmBsuzpiI
	TppyOa1QoJxAIeFMUPHb0+y58f/sMAE6jPWsU3KKHSKW1fXBgePMewZIxNmsApg==
X-Gm-Gg: Acq92OHE2Wi40C1F3zmRMkF6EuI7F874DX4PebhjtPRWM3wcHjanA7k1WUtn0f+BlQp
	+SRQ/PbSGoXTNh2pG7vTWmjoQRGyNfMjDwiXNMKLPPLzPMy01KZsfjQjoAu2k6b7nM0sK0PUiCL
	djfrWbgA8N9mpdezyrSjVuSY6RN4M7+D5uhgNf9zHYJhw+B/ZEPK/DiEn7fXhZ8hftYW0dhtokL
	9XRd4py2PzrVT35i4lpFxT0/n/nuDsxojpr4OVJeTMdgyMZZkuKot6si87IN7u2gHGuLkmulGhq
	+GD4jr0eUYXkrvQWpaMy4SVLwbcT0VhUR6ch3+hvoDnOkEtrt+/nx3XBFS1Dp5ljGnfOLEElIoa
	CUb860pFf/6uE27Xv3IVC7M0mMzz2oyEONUh1tDnP3FJNew==
X-Received: by 2002:a05:620a:6230:b0:914:c589:7945 with SMTP id af79cd13be357-914c58983dcmr702815485a.2.1779713708472;
        Mon, 25 May 2026 05:55:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6230:b0:914:c589:7945 with SMTP id af79cd13be357-914c58983dcmr702812185a.2.1779713708003;
        Mon, 25 May 2026 05:55:08 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264feb2sm397057366b.10.2026.05.25.05.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 05:55:07 -0700 (PDT)
Message-ID: <78ce80bb-e8f6-427c-9620-53ae1edcb3e8@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:55:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] arm64: dts: qcom: shikra: Add cpufreq scaling node
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yEpSLBq7Q95AAdd8zHToBWB23JYK8h6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMiBTYWx0ZWRfX/Roj0t1yI29y
 Dn8cKD4EcXLUbg7i6q66ZvhiSoCfsVVX2QcCdfnrJMFMxqaH27S1OEPfCq4EkHQjcaIzkdOUmP7
 7m161UI5jjxVom9HJfIrGxTq1LhGrIjQYkFZyqSYX0qaVCHXiYvJSuu6HzeGC5w7WpH8Z8X3LBI
 l6odrt8qpZlOKlJl0pbGchCjZ+3rRbFTlZv70Nf8TPg1QC4BdgUoW3fb6CYVWzeDtVoRGnTqXmx
 sg8KGdTrbvOBSUN3uq5KFRrMTJVjGu91qKvV4CBiTE07Z3fGIn2WvHa7FEltd6Q2cQ0z2IsSkrZ
 5cPiYfUVDVjwSfXnlPlWWwF8fxURlzby16hkqOq2dXMpsV4dakosUAb8sTIxeQNIer83LeceVwU
 uLpKFxXgkDG2lF44PqHBzCYmBuRO5XgMt4K9+2OTA7VHGJd8zGaKLQHEkA12zI9DLpm71F/i+EI
 6SuHtg+QBQh/4p7ec3Q==
X-Proofpoint-GUID: yEpSLBq7Q95AAdd8zHToBWB23JYK8h6n
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a1446ad cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=gR7PYC-x2pxtVi67x8UA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250132

On 5/24/26 9:49 PM, Komal Bajaj wrote:
> From: Imran Shaik <imran.shaik@oss.qualcomm.com>
> 
> Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.
> 
> Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
