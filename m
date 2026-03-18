Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3D3B8BAA
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827093; cv=none; b=nQTcHP/jwYajYZQpev2snN/BdUwbJtnUCtzt77HM4v2gymeI+d4FNXBisGINKLK4cGsCDV0Pr7ig4R+Rw2Mds8P/EjzuLQOooNakM1e55Ro/3iZ/O2y2JXzPCjxgna05TvjNJkuSayhCVrxegP/YfysCPF3LCKK5/P5MQsIuyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827093; c=relaxed/simple;
	bh=mIywxV+98elXwDiIMtGd5IEKkhRCt5Arbn2dohoh/1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW+LbvYNJaT7/LlvpoTsscAfMAYZKlobGeTqEPoH4vwu8pN1HBdeuyaeO5loku5iDqrbclL5Qe97aP7TPreW8C4QvJoWFr9oL/4aD3WQLyw4mv0MdCofTo3+3qLBTmoPZEoEcDJj9THe4uHVs/OxUpDrT81odgL4sQ7jBz9Q+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqKOsjZ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZLdXVj2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LqKOsjZ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLdXVj2g"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I8m45H2296910
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 09:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4iYQQUUil/57LBAD3eiyFUNUgqmJlQBgw87fPx+tjj4=; b=LqKOsjZ4yUtfuBPr
	zZuGQ70GagYg5pXHip6JqM5qQncLb4k68YKS1XO0l4eD9cs+/8e0/XuxbT6ik3co
	EtuYk2u77HLbvJv96Z2YMxyfDcIKDjZjqhvkqbm3tmIe8Oh8dAMP1kHlPjEoyzBU
	vAA8XfwkiL9Sm2RIeH7rRNx8Nd+FezU0I2NLLIX8CboKo3TGE6nWZTbvQVW2OOV6
	4yaVwbK2QhklZ7PpUCIgZu7FvPBoGQLkExRGfQeg9wNdhqu8QKuGOK0nA+yZOIkI
	HZR/pvnrYDD5UimVkqwtu0roE4u10oGhGX+xNt6xnLDbVyPA4MJSMnlyQZUSnuwb
	y3TUdw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya83urr5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 09:44:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5091eadc373so48816101cf.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773827085; x=1774431885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iYQQUUil/57LBAD3eiyFUNUgqmJlQBgw87fPx+tjj4=;
        b=ZLdXVj2gPodbJIZoEdPiidUe4T0s4gHk+y+hdt8zBoNXzhQ6e9Z/ZPZJwNo4qXKuX0
         /jaDawN8b7k+0nSWK7B+tc11mKVEyi947CkuIyqR9+mudqqsBPH7NmiqrkKihFba79Or
         +KR66eIGNuZn9knDkZZSBTko+h7wyNZCge8735r1vKmQeowLWehQKUzy7VmkZxAxHpwI
         PeXyH1Yb9YzO3dm7Yk/VxA1vb/k3gAlrA4Dlo0EY9cd79b3cvTRTLBGB+pJFuBQvIU2X
         D2fMIYA0bzGaNapVfWw+Fgjaqmwws5YSI60QqKt+0h6gyAMjGFSW9z78HbbBWqWSNlAV
         g2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773827085; x=1774431885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iYQQUUil/57LBAD3eiyFUNUgqmJlQBgw87fPx+tjj4=;
        b=kt4/skzb29BsLAGppZDW98CJE80dIZSiZXI0ICYFwkY5m1NQ+n09lnv/BH4TDTEBa3
         iXtaL5M5jPnJO9TCWwdl42F9+6kKezcuDzTR7PwJLs8lJ4GjFSdehfKWUIjBlXudz6X5
         Xb+VmGdvBqGFw4XVp0m3IIci8aptd7jC+VIh+ns/fmjAieDKAKxVIhn14Egn9aFPSMBT
         bku12iqebszvWEUtHC2WUCtGHX0kCjuyg6HPkKZGXyi0P7mN80iPoX47UqJxIYLvqxPp
         12xHoxVZptgi3ed+fNPcqrLZBj3H0ooJ7S/bGG1dTP6ZOD9QPQv54x2E2iTGHmckoiuC
         D9zw==
X-Gm-Message-State: AOJu0YzkGgtzzV6a2csEd2ywJjA5dnaeAH7g6tqJRiRP8NztPk/SIUBh
	1LUnNSLZR2DizRTTRmRX/RGciTDgzgCY7DrSKZgdRm6+wq4fw0mra6zOmG0yAz9axt2wHY22lBQ
	ai6ErqvT2KNP/FGd0l2D/O3Q2seCP6hKlaiCxMcF8EENQog1n7ucmqqB13qrCsw==
X-Gm-Gg: ATEYQzz+FNY8FcVJ2R0yPGt0xo7GWaFYWCEoVzJYZHjwtyCyqzso7553EAKJ0t736ry
	l3VKkFq9Wmdn8i5aekPwfEy2ik2z7z/tBn2HimBj8ilO2hLfibX5sh5bI9vTiOfYEIDaO1B5VX4
	BvwJdMkL6Aq66jEUXYjHh9kcqUf0NlGg3e5ffqD34a0lUSDr58Bhq/rQoArJ1bFOWMedTJLguIF
	clpkwDkJPWiX5i2wP4cqXprgK1ctRWyNXrudiy2ZzrOBKeX/9QGMzEAPOeBIx51OxIXgF1krYer
	G9FAg+9QPT52t/HHH7ZL+oBnd3pfMHfO0PKxBs7lQvTMEAbiPdUksLWIoZ3FdDb7jSYdkotNmfU
	iqPDmgWe3D4kB/OIvFgUa65XsgZ5zBtufDOr77020RAI8QnVTFib6qxsVBJeNBCy1MPBk4DeX6Z
	K4Zu4=
X-Received: by 2002:a05:622a:1899:b0:509:2a92:809f with SMTP id d75a77b69052e-50b1474847emr24335231cf.1.1773827085619;
        Wed, 18 Mar 2026 02:44:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1899:b0:509:2a92:809f with SMTP id d75a77b69052e-50b1474847emr24334991cf.1.1773827085200;
        Wed, 18 Mar 2026 02:44:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142cb46sm167704366b.21.2026.03.18.02.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 02:44:44 -0700 (PDT)
Message-ID: <37ba895f-95ac-44f5-ad54-20b04a079250@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 10:44:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Enable TSENS and thermal
 zones
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aastha.pandey@oss.qualcomm.com, dipa.mantre@oss.qualcomm.com,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
 <20260313-sm8750_tsens-v1-2-250fcc3794a2@oss.qualcomm.com>
 <c4376a88-a490-4b58-bff3-b0f4d2f731b7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c4376a88-a490-4b58-bff3-b0f4d2f731b7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lddyitJ6kMJC9RdP_U2sRohjMwgTreUb
X-Proofpoint-GUID: lddyitJ6kMJC9RdP_U2sRohjMwgTreUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA4MCBTYWx0ZWRfX+3wWdJ5r3RRB
 EXQ8bnrOl4i9qq7tudKlMolr07I1C0bNF+OJ92v/c+fgBTu/64nAakBc0Tf6Ru0oMJG7MQjybz4
 4PxKbkXoY/dHfkfxogpoQtREr29t10ol4hZm48I7lbhrHtn90HneiHEgIOI63q/dTRpFVN0gQ7Y
 iSS4tQJMaS1uRSUKcf58DmhJxlpzulDUWbGkZoh76srMLlEI0JaEIq3fRJL2VDRdyvqpvntHNVf
 cNqvk/5URs1gaLsa4oZS60tya9OIVDuhqbsIyz6QbYcDndUMFRWs+dXxdfPLg3/JkbfpWJ8RAJg
 wAPmrZ2DfSQywJDGE9lJoO6hB/ylUDt8RTcQP9ODBOjgUHH40OKDzpSuxxoL/KSCgbvO9aEKnr1
 Zd81iNEd4rCHR3Xrv6kRZVcOeuadAOf/wbdjYWY6XYWxAvOBEVqNLTuqMn5fcecOm3t9xvrY99c
 77HxKgrisFWSsYkXgMQ==
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=69ba740e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RYkhNht3YKPCQp1dbvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180080

On 3/18/26 10:44 AM, Konrad Dybcio wrote:
> On 3/13/26 11:34 AM, Gaurav Kohli wrote:
>> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>>
>> The sm8750 includes four TSENS instances, with a total of 47 thermal
>> sensors distributed across various locations on the SoC.
>>
>> The TSENS max/reset threshold is configured to 130°C in the hardware.
>> Enable all TSENS instances, and define the thermal zones with a hot trip
>> at 120°C and critical trip at 125°C.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		cpu-0-0-0-thermal {
>> +			thermal-sensors = <&tsens0 1>;
>> +
>> +			trips {
>> +				trip-point0 {
>> +					temperature = <120000>;
>> +					hysteresis = <5000>;
>> +					type = "hot";
>> +				};
> 
> Are we going to use these trip points for the CPUs? If not, let's only
> keep the critical ones (again, for CPUs specifically since they get
> externally throttled)

Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
