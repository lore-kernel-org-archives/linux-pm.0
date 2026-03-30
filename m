Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808D3BE630
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866757; cv=none; b=L+Xc71lKLWMXnc6535eXT+4EKgOj9hMLOL0gDKGZJteTkqlRSuoIdK/T+eppojKpCqyEMvmQUb+omcdORQJCWPBul4uz4inTI0D0zy5SdcJI7bPWuW1oOOInrpB5POzwao5dg0wKnenYTWiKAaY8JJp6rEj7xhtAWcjH3gV/Jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866757; c=relaxed/simple;
	bh=DjsOy1VmOhbcgAyoqkHX6VPjOIR3E5Foub9AQbjDqF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuyKVp54JZWqaQ+OztQ+RE+0oBpLRJbl4DC4IysgKQQycYkJM0OHUXmvjg1XYHODyqgomtXM9SIzJzzi+LRATV0AmIOdMipGerlzG21lRV541uqJQ441N8nmiEHcBS9CtywrSztSoRs4BVm+U9T9VmS50qm10OpsUVYHiDF8lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dk3BDlXP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YyRiao/7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dk3BDlXP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YyRiao/7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U8PwgX2458298
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+4sqL6RDED1B1qr1xOMY94kj4P/JEsATC5CmPtHtVg=; b=Dk3BDlXPMAvEXBwP
	Zj5tpnhw5d0MXo1FpD2t5gMM/Q8NqGP3Dlv1dGCFyyptsvA/C/zD84RrSinyJEBl
	wrVwlPjr0VTcgMvnzgqwMsKiiLgSWMY4Xahhht+0sORH6QKjgQ06kD9Hgzu5P93C
	RUBU66bVzwTzwrAcxP8pSIg29VDLIBcMYTWkAPiUC8G3CrjhzitffKqaxwdVFtCk
	S4cIggqEZyAIBnJ2BlzhwC8ro7FKsDxqhN0uwS3gtXXFKDH6+VP9X0TT7zTRMoiv
	ZWQSq+nkT5qGWv1TE9Q4LIs6dr9CUXUnA6/Tt7EjdqlqXe0zcM8Y3CqkOthQ+Asf
	JEVdPw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmrh2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:32:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a016b99579so4935036d6.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774866754; x=1775471554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+4sqL6RDED1B1qr1xOMY94kj4P/JEsATC5CmPtHtVg=;
        b=YyRiao/7yaJOny2pnMS+SOR1tood0j9aGbrKGS5NLsXXeY0ugk5EXcFWEK3EqhTE40
         x2paqpanr06ZNHhEWo6QxNCCCZX2tU6USdsqY1bkJ9HeLnNd7Mj3dvr2AgxK4Ctwsx4q
         q8un0OP8d3+A7mqpVDynImQzdqTC5AISozi7eSOa4TLzOW+Yz3iFYgPDogCOULCClF8G
         zlWICO86f1ny0PpAW1IAUonByDb8/mP0bu+HJ5r5xxC07O+nKTQ8RN4UD4U+uBWItKZ9
         UlLNEiHmdwFJ7PycufaZIfNvGrRa/d0Ht3jIo3/N9tnWCHZzbfvWYspakaXYWBWlk/Fg
         MVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774866754; x=1775471554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+4sqL6RDED1B1qr1xOMY94kj4P/JEsATC5CmPtHtVg=;
        b=mbxtEw9xMS6UI6Oc4SFBhHo2czN/p1p2P57JIgsW8DmrLcnyeaFpk28rMJVkLGUsMG
         5OK5WA6Ev9q33RQ3noeOwfEvGHZV0dM1C0OkeR1pyfKjv20paqPtto/z7YPAGhcwrJIM
         p0lffVn9iVTTN7L7sh1eSh3o8Muig9UsPD4oivBC5FMyvs0Jcq3Po1MYmULlLOgIt6Yg
         zVRHo7u56g8stX5qaijzjp4oXbOkrLwGSAv7SZbvA7HFWnQitKaeryFgaKTcaxilCcJn
         CK0bMdoD39QEqrXmvvXETLImgE9/5gdtiK9dgvNAKnSulapMhKYmxsjv7OJWt0IsO+DE
         gaNg==
X-Forwarded-Encrypted: i=1; AJvYcCVt8tHL++OxsDD0e3ey8FvveRIp30OwCCdRwAlquu72UKQmtz9H/uSUX7WEmtOT8McBuUrX4SURhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvoUHOCHxJBPd/hvPvpMxDpczWyWsrx1NdAELWroUjJOXQcKAJ
	AEA9VpYlhodOS9ifeeAGkqoNE0hJx7CQDlEsR/eVh9TmlipEKDckpLT63t13CHqVSu4cuc0mQAM
	ZmvQRPj8B+Hx6cy+5yVrNhOzpn2wGvPyABlOJeMobhjysbRgA0uVrS555iUYGfw==
X-Gm-Gg: ATEYQzyFSF91HFeoP4JNNm72Hn4CUrbdfRLv6xz3JTn1zrm+vJ97n4A7UAkQScQtUlF
	q1HHJWwpCSIno+ACa1HlaHIRqwLsUJLezSzIS775z9RidGjHDgxI8qrvG5rWaM6ayJ81/yRmX/X
	+SkS4uBujmkl9ralReKClk0wt99c1K5N3DZKi1R/qHgVyie8JSZ3v6h7WIL5OLmAV4CsP3wCAQF
	XPWrsFRyI65Kels10xwPyPds/dIs2Q/nRkSY5zBOvvMqU9OAO0ETtVbAZ/mVmb0A8kSyqKWftqR
	4gxUin1gSOEmiByjwbrU0uzbsXwDGP1Egf2t4nFPTb7ta9WyGxQkA5NLLLsrO/Ic935pk3CqPSF
	SLJa8YPVTEx9VcttbMm/1+LNEJn94PGxbn2DTa53zkIJ3DUsGPv+C01srGyNKqWd4POa+kNHeU5
	Mnl2w=
X-Received: by 2002:a05:6214:21ed:b0:89c:5285:200e with SMTP id 6a1803df08f44-89ce8dd5ad5mr134355066d6.4.1774866754038;
        Mon, 30 Mar 2026 03:32:34 -0700 (PDT)
X-Received: by 2002:a05:6214:21ed:b0:89c:5285:200e with SMTP id 6a1803df08f44-89ce8dd5ad5mr134354686d6.4.1774866753567;
        Mon, 30 Mar 2026 03:32:33 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae520c2sm273801766b.21.2026.03.30.03.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 03:32:32 -0700 (PDT)
Message-ID: <91af3fa3-85ba-44b8-8725-032f77c846de@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 12:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Acayan <mailingradian@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-4-mailingradian@gmail.com>
 <a3rrkgvkc4zxcq5oqvws23lyjy6dinlmfgp34wzguvdxdxig5f@25atyxc7zabm>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a3rrkgvkc4zxcq5oqvws23lyjy6dinlmfgp34wzguvdxdxig5f@25atyxc7zabm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MiBTYWx0ZWRfX2Z8iEaNGsYYa
 8Go4ovjsK0MMDCM02xrWKNf28sLjTwraPzB+AkHa/4kh9cw+AEv4TTXPD3li8ar7KubYBElY/Uu
 DVd8qOw+nQ0QUxP2uEOLqgy3Tk8Q2woXbOegmNjE7N/CN+eK2k59EDtIGXthN6NKpoXGRSulLDY
 3Qwp3B3NvB1ztNPEtXf+uY4m+35rvstu+PBLNRduKMBT2WXMLIYxmH5puMvWefgfqiYBneGYXp+
 LbPZMbA3HKQl+zzGBiMEjvG4SjzbjFW/J1LnrgJkQGZMrlS3z8MAVBS3Y3pPmkpTe6K+FJpC+bZ
 a9Hac4y/1X9MFKqHurxmNk/5rDQI3csKlOcY9CCs1rZQKCBw6F5qTMI6sbIPFQbu64GvFluErx/
 uwjFC/0Hy/XCxX0tZrMyUKSMeahJUmRla7LKo4tZc8NItIyV0edK1wXMMgcT/CGHM/Rl/p/0hNo
 sG4VIxqbfkWjdbJAYzw==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69ca5143 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=fM1jUFrDNVvKu5cEwoEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 65727xerc2GQUr9hnQOJO185hwGPTBBq
X-Proofpoint-ORIG-GUID: 65727xerc2GQUr9hnQOJO185hwGPTBBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300082

On 3/29/26 12:44 PM, Dmitry Baryshkov wrote:
> On Fri, Mar 27, 2026 at 09:40:40PM -0400, Richard Acayan wrote:
>> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
>> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
>> the first 6 CPUs are in the little cluster and the next 2 are in the big
>> cluster. Define the clusters in the match data and define the different
>> cluster configuration for SDM670.
>>
>> Currently, this only supports 8 CPUs and tolerates linking to any CPU in
>> the cluster.
>>
>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>> ---
>>  drivers/thermal/qcom/lmh.c | 69 +++++++++++++++++++++++++++++++-------
>>  1 file changed, 56 insertions(+), 13 deletions(-)
>>
>> +static const struct lmh_soc_data sdm670_lmh_data = {
>> +	.enable_algos = true,
>> +	.node_ids = {
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +	},
>> +};
>> +
>> +static const struct lmh_soc_data sdm845_lmh_data = {
>> +	.enable_algos = true,
>> +	.node_ids = {
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +	},
>> +};
> 
> These tables made me wonder, can we determine this information from the
> DT? For example, by reading the qcom,freq-domain property. But...
> 
>> +
>> +static const struct lmh_soc_data sm8150_lmh_data = {
>> +	.enable_algos = false,
>> +	.node_ids = {
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER0_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +		LMH_CLUSTER1_NODE_ID,
>> +	},
>> +};
> 
> ... this might be problematic, unless this entry is broken. On SM8150 we
> have three freq domains, but up to now we were programming two clustern
> nodes. Of course it is possible to define that node_id is 0 for freq
> domain 0 and 1 for domains 1 and 2.

The third cluster situation on 8150 is not super good - we e.g. only have
a single LMH irq that's shared between the big and prime cores. That
was fixed with later SoCs (which is why it's not wired up in the DT today)

Funnily enough the bigger 8180 didn't have that problem because it only had
2 freq domains

Konrad
