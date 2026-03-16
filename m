Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452E394789
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663906; cv=none; b=B0rrQgFu63IcZd0nePil/C69mFFlamTSSA1gnj0tUDoNI2z3cILpqdVAx9bJMg9HGXmcgLu2JggDL2DTvu/61JKYKvJ9DOlMh2WmJPMZ4zU7RcIW0/+b7p5DXaB9C8fHFm5BuCOqsAY2y6PU/rF1XJOGsefmM3U5VHSbvLQPJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663906; c=relaxed/simple;
	bh=lSpmCKs6zodXDxPnxmd3wmA75ZCOnRCx/fW5bn6fVoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApSZjuRDnJSzj4Qo/QuI/vKuEnwQrPXz6RGcXwvbFFrQJ9eehpsVsAvUnKCE4z+Ml0DUAxQf1fuw3Ya62ZDw2SvboeZeIBRTzhn13AQnvZknMM4kEK1ai8qYWLx2p0Qdjbflqthpp314XuVCBM27PRo49mbIBLwgrvq+bhzQ1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i8uOeQax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PylL+186; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8uOeQax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PylL+186"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBkces323597
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 12:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jBNTEclNCL5IXfgD0gIYhKI6BwkPYlaHIemf1BqvQFM=; b=i8uOeQax3pDrC929
	hH+M2GDUKV3PWUsI7ZhqS5SfPdX6ArQ3+yOJvtcftzCbUxFi/KCIvJYu8lK53MAL
	OOBiWbpXPnmBXmCvRu/KbKfgPM8yTth49ZPDaYKyaxw92kS4XUxXdemLhAF9LdXi
	UMw/AeygYpECPcj4T683oIGVaHQY1QD9m6gdra+e85H4cgrEX9KTJGBNwxultpSy
	/toE0dp8ewwmiMdGvL86kb5+G1bWMnynq03EEblbD+wB+3aQcX6r5MFDXcMK3uej
	bbxikGO4+vs5u95iEmiIT1vMijNKg1H7IMVPnTyqfS4qw8XgjJDeoxQw1ZtNSjc7
	pm8sGg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qnu06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 12:25:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89c4f6c45a7so6421226d6.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773663903; x=1774268703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBNTEclNCL5IXfgD0gIYhKI6BwkPYlaHIemf1BqvQFM=;
        b=PylL+186KCiO7JMPY83/EmJlF4qWDAFp/3/Q/avZc1zMPgy+lm3kV5g1sqgaBqMrqa
         EMQ19aPGO43PFgfLgVz7s4a5sHKoR3M7O0OTDnfKWUjfNUosgWzFHyOedbIiPl3fWSNq
         JUNrMCxnkseMM94cVyLMut3lfAC5lYNVdMHl/xkmUeat4CNftAyuKwfGVP1gFBhxKh3j
         PBSEi/bl7KPDGJPbYAXTNh6xcEiHy1bj7RsE4u0qGy79VyYEzpa6hbVlYE/mJHXZGodE
         cy7wbBYez7cM3gat4KlPgpgI/TvoWzcHeP0iwni/H3OqfRQf/pehtaUV/+qZetXMvGj3
         GGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773663903; x=1774268703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBNTEclNCL5IXfgD0gIYhKI6BwkPYlaHIemf1BqvQFM=;
        b=s46QM53owrT+anf+Qw2USBSej75epiZkPfa2JmXY+TuIPMUDfxwP/rJcQMxq79nWTZ
         iL6eQzUbNiknDpuhrSid2ySSLBrlg0yT/FUXmzbfVFn2ZFUdRCVFRo90aXMxOrZnuwjT
         Ls4uavIp8H1jRW5nzZ0ImfhxiqdsYvD3xa08Xu9RLjDMRTwyWES5rcDpnQKDjJBmIMdU
         /vNM/j1BA1ei3PEHLTXzE0A459ljKmHFZAnGFm19Pbzdj+PDTx03L5JKlS7gn+UqRjfZ
         g9mQCAlcN3Nsfa8SomlQgT+X1WZWweLNcb/xFoStw1iUpFzlbX9hw6qdEceaCdEIHSe8
         2BMw==
X-Forwarded-Encrypted: i=1; AJvYcCVaXgxC19RjTXw5NtOf93oaPQAZ+p8sGj0lrtLK1PVAVgixDKzQsWMfpGTto+W93ZuCK3RlOGrS9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1FMQx9zgYtPE6HZTeE9vSMOcitp7P+8wiTuoKGVfnKQYulNU
	hvnw4hM5tCQP1bGNa8SroEHxepNxZXwkMk64sKaEeyK4exX4lugctDqv5wkmY8s7iunpWU95Rnd
	FDaBx/ho5/3l/aIoBNJbBHs0zHJha/WCbDBD7yL+lOcWHjlu6xMIpnIf0YTTWTA==
X-Gm-Gg: ATEYQzybQj72e3nCRU/1CrEKmwWQHEc4+twnIAsHQdxx6qBOyy48M5fn+Kq62lpVZfr
	4wEkOob+Tc5UkdcfV3ueEYSCX9qV0urwbafXmVigG1P+94adRVp8wXOjr4EGnIAoH4p3doxv1oS
	c70sk+cKDpEJA5wVY2NQBcWlCXQj4S0MuPpj9/twN45+oUtRuV3LR3aKyhEtXivre/ifKdioPQJ
	W83/K/aZnNmA39e7tacftuo3WT03+I/HNjGaAPxWX9dFvVOxYBy6hz9Gy5kyp/nD+JyhWDLjJyy
	W9cVOaGlWWrbf62APd6oAVR4R98PrnLK7DWpPCDwiZUcBWIIWHIhdh6T76BYUM2Rh/ie5GtcdTi
	d0N8vKjw6ejZfKM83QQcvZuM2Zpkeqb7+LdFM5nEx/1aaTQo45Xe29C7XlBxGVSr/J17/qv6soR
	BjM3Q=
X-Received: by 2002:a05:6214:4784:b0:89a:4741:2147 with SMTP id 6a1803df08f44-89a820eb598mr121528386d6.8.1773663903055;
        Mon, 16 Mar 2026 05:25:03 -0700 (PDT)
X-Received: by 2002:a05:6214:4784:b0:89a:4741:2147 with SMTP id 6a1803df08f44-89a820eb598mr121528016d6.8.1773663902666;
        Mon, 16 Mar 2026 05:25:02 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97a63bcc74sm299802266b.15.2026.03.16.05.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 05:25:01 -0700 (PDT)
Message-ID: <46a7e40d-dc74-46b6-89bc-514b3a09f21b@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 13:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] interconnect: qcom: qcs615: enable QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
 <20260311103548.1823044-3-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260311103548.1823044-3-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6GadAeLXdOuCP9bSWzAAMNlA23_Bxemf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NCBTYWx0ZWRfX8ASTvamccLBP
 xfSH3Sjkgx6zIJehLpLW/me70VHv2bXsGelQLqyRrHkz3OH+zV2UOnSpkbXf5eu+F6j/jA5oNBE
 F7E/YkrmqC3uWHsJyb80fzBhjyNR6mgHi4mfniLbTWl/FDCt9SOyV7Mn/Iv15vCZ8d72DioBhF5
 qVg8IdenURmupSd+H+dkRTQ4TUlEA84BxStyCwgZGUznSp2RiLMGv3yssK3q0cZdt7lJ1r0a0ZG
 0xednhbf/2Ji7N+STmIsRyFNpv3PEcJDNY7byPZdVE3z1tfBqLKOO3NzwSix+znmc7oOyC2e3bw
 N1ULFGTQTVCrAJlD0XuPlhNO8i4k2Ri7lPqglKkHM3Cj++cJ9d4GhFunvfLSzoWi2TybJXvvxqN
 FTHJs0WoxcQG9zBLQam7+nHEQt60zK7oXRRW8a4lSvR+qLqq39nAVBLCRUEvddxTtPe8s1N64l4
 R0kRMdTfqYvyHRi6ehQ==
X-Proofpoint-ORIG-GUID: 6GadAeLXdOuCP9bSWzAAMNlA23_Bxemf
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7f69f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EMGZ7LyCd8X73lh2icUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160094

On 3/11/26 11:35 AM, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
