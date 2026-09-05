Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380834E66A3
	for <linux-pm@vger.kernel.org>; Sat,  5 Sep 2026 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633141; cv=none; b=EiCDdYiMkCpw7wSL1pmvAkWvHVN3bVHLDtFP0p+hTw7Of3wcO59y037MRpx+UucKoxaN38OAJhy64jgAQ6pozMP6gV3HN6MwU3Nz3x+gGa8BnBAbufuMCBV/tcGkYpCiCARAu1tHfO/s4zuHXgLlVeLpUHXD4lMx12bx1D9muGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633141; c=relaxed/simple;
	bh=svLOB8z5R/BwyX89ta2NtbKu793JyHL+NgAfeilHccE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+3kEM8A38e+dkCfFRB2CStpRk8GYMDNLYxVjoNPlvmDj6QQf/H+8tPFp4GkYb5MQsGiPSnqRYd4Zy0e/J1Pcx3eTZN/Stds5gzN68RGu5F4ZmLyCugtbfKA7r2EPsyVSaTjrMSm4ufLZVCfzlrPC+Q0ZTSMAI3NcBYgcsvfies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PPeLs8jC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j3Mttbhd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPeLs8jC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j3Mttbhd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 685HcOgF3521372
	for <linux-pm@vger.kernel.org>; Sat, 5 Sep 2026 18:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mdT82Q2OxcJQKOg747qv3HE+fHx6+rKNd/Kv6KtVxkE=; b=PPeLs8jC4qKtUTmj
	b1S5Mgsi5rwjGyyfBKaL1nbEBRfURolCXjx7wCfu6Cq1lWAhinnfaXNJM+owOgqi
	eBiIuNy8HC0MHr5IjPVHkrFu06MD/8KuRLRDpjovaK6Hq8o4g1IIaOvBCv8YYVJJ
	1cH+gb3pMu6RjF267O/5Z6a+QV79+DTeZn/6ppTSY/3w/vL8Q5/ijy8mDJEXOKtw
	oJSI5ypFfcBuTz4Zqb1lddW/MLuMlVCJFjfDYhFhDCd8gEUiDxSAIMOGffDSRIyP
	s6TJj3gt2YdCQ1QzOex5CTJa4u9kTqfh8JOVjgCxTn2ino1FIuCLRgpyz/+AlKZ/
	anx7eQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany1yfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 18:32:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so2594588a12.1
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788633138; x=1789237938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdT82Q2OxcJQKOg747qv3HE+fHx6+rKNd/Kv6KtVxkE=;
        b=j3MttbhdXyR07esdD1Gijz64KL1K/fZm2YpGLUFLsdI9ceMvv3Dgxm5SW0hEHcw1l1
         tLPRetaB89uc0TYGp6lqDw8+FE5eenauN2JjWDyxbPQFwXv3UVTgi6tHaBE55LttgHH4
         /CL1Yt4avizhBnstsYWzdb5scgFKw10wMw2J898iZROt9K33RgXbcdenmfnbwX3DEJQL
         aB/oUog0pr5CNUJKJ4avP3wsgCcXnV7A2TLoRgZqByGJSX+H9Jf0Nq4Ipr22c99qoamg
         eWG7S6CKoVpq1GMDU7UtLWcAXPCGL5aUymzw95uHpi8tVlMCkYw9Y2dnT6yKYoaGpVjS
         oRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788633138; x=1789237938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdT82Q2OxcJQKOg747qv3HE+fHx6+rKNd/Kv6KtVxkE=;
        b=X57C5Ywd4qxLtXrXOk6qvJd7y4FVT/VIudqw2CxFz7hVoWq3th7VnCdJQ38aRai00n
         otbJT709oju0Ymqinh/+8lucM7GFpJxfF0ZE8yxh7NhpTz+VfZAWPYJFsPYUM1+f+Syn
         fsO/c14+LP6Zb2MsSLqOGdmigmSCGamNLZEq4Di4gurvqdgRULlc8ANi/9kSoaarqSE7
         3M2Bkpckbcd+zseZIiMX6qEuYxCikRj418/71fPRVcHq5GczJCCPKkSc0yjlIg6ikaTT
         5Nv+eZe2SxPQ8ts+lhU1oJ4UHXojOUniZYFM1F4Ah5l1AGvlk8DKIxNK/IO7n/aqmtlr
         4IIQ==
X-Forwarded-Encrypted: i=1; AKwUvByFbcURbQ/rr4X39z9wS4+1qleCVGjwhQaqUn6kgdalYB67XUGJNwrCs1o8nxf0CVjQwwjhJan+JA==@vger.kernel.org
X-Gm-Message-State: AFuF++khExw6OnOBLX/97/usrdFeqPWfrjx/bmm216PMWBe7mhQGjFWy
	4nTwxh0de16zLnMcxmXlGrM3Yv8D00CdszWjcNQXu9hRySouDKcCmEfrEJcBshfqBRcHVCas53M
	MrzeCy9pUpkiXJD6Lh05OQEizG5WW8bB8m02ByWo58YJ7duoFa11nCaKOL6MCsw==
X-Gm-Gg: AYBFou2JWIjeFef4lGPgr+f0Eo2RmCGr1vmRrvM1asHTURx6ahJOwrezqNeAmvG90Gq
	IJ+BlP8FwCsgX/rvytyJ65OSLJOZ1PVCxa6EbDLtpTFmQNZoUuZACM0cCpUU+0p8bMd+++h3j8f
	OR0sFhMdeS5Q2XxiY68F6CqnLLEDoPGimxGY4Wy0i8Db+Xrtp1l/6RgL3YBCSr5W55DSzjz94Sh
	Cmyr9LEbi/sKHpUztHLr1K/OLrWMgzl6u8Ohp6yXAQwP+g+3WpKOmS9vga0c5wVlLKxewE5aF6a
	lZI65SyHmZfuiooHaePH9UQUxv1a7nvp40n7AZfo+jWp+MJvMSwjcSqhP3eVmhe72N9Q3K7+qz8
	kBO1rHHi90wqDWu57r23IyQL8Kq5TNlhxMlhoMpc=
X-Received: by 2002:a05:6a20:5681:b0:3d0:5305:4fb9 with SMTP id adf61e73a8af0-3da39bbfa1bmr22943685637.7.1788633138019;
        Sat, 05 Sep 2026 11:32:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:5681:b0:3d0:5305:4fb9 with SMTP id adf61e73a8af0-3da39bbfa1bmr22943633637.7.1788633137626;
        Sat, 05 Sep 2026 11:32:17 -0700 (PDT)
Received: from [192.168.1.14] ([27.34.253.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm17250412eec.30.2026.09.05.11.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 11:32:17 -0700 (PDT)
Message-ID: <c7282846-cf0b-4a7f-928a-7a0d12e88153@oss.qualcomm.com>
Date: Sun, 6 Sep 2026 00:02:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: use 64-bit SMD RPM bus votes
To: Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov
 <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260904-topic-icc_rpm_64b_req-v1-1-37e24f1991a3@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20260904-topic-icc_rpm_64b_req-v1-1-37e24f1991a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9c6032 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=3XoJp54woHZrTNLqd2i5nQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=zrAAXKNDYC0mzo9CIGYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Xyz_qyyWb3S9YLSTvatwRrsKpV63hORf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwNiBTYWx0ZWRfX20xHcjd+5auK
 8ROac5R2ryRZA8oUiozfoUGr4sBbJGmn2G+t4BiV5LFo8QECw7eGxWu00LhSmAjnFYpVEQvdZsx
 8OIaS33glzlT7ZYN54uWDiCebELCGBwUQl/fesfjPYR42wREBa4iD/Kl4jAKt4IsNhcM7R0+dFu
 MscTpfm6ycX+U7Pc+4kcBmRuSlFlJvDCLAV6bEQ0aZShm/aB9WTMCvH7ZkOrzWUZ9ybyVL6tg4q
 aBnilQihkM6OLH+c5XZbH21MtOb9wgBaEXr2lYYLK+b/J/eqShHVswNji/zzLPUMiUuJZmK6Bbl
 zAJTAxUGerRTi6fXHiKsW2nSb7KvNYgRYjr0j/8EA1YPkFbMw2yvxF5KIk2FFcaeW0JkhzP9x4T
 uIp1msiKtlGzy9RqsxTBgHNB9HAiniz2+pAb7E3z11uxk9YaEUmMAOy2HIDmbQE1qjFagi9kAID
 fKRTaZOmQCNu78fuS9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwNiBTYWx0ZWRfX2tSRL3DYNoRr
 Yy+SKs21UtCcnOLiizd1ZcJDZRtVzrznNa5XlPMXR91RSxVqmI942BfolrE9jrRxKjoV3cZ+7k7
 t+rfbfpNefTn/S7JKvxWzwuheR7JM7w=
X-Proofpoint-GUID: Xyz_qyyWb3S9YLSTvatwRrsKpV63hORf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050206



On 9/4/2026 5:25 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SMD RPM bus bandwidth requests carry a 64-bit bandwidth value.
> The interconnect proxy declared the KVP payload as u32, truncating
> votes above 4 GiB/s and advertising the wrong payload size to RPM.
> 
> Use a little-endian 64-bit payload and accept a u64 value in the proxy
> API. This has always been the right behavior, even on msm-3.10 and
> 32-bit SoCs.
> 
> Fixes: be06f8e7425d ("interconnect: qcom: Add interconnect RPM over SMD driver")
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
