Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AF3AEF54
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827073; cv=none; b=DAJoBsgyzQFKt2wA2dwtR6KejUDJLvFgoW3FlTomEMZXs6AuPTz+uf2WKvFtXcL2hkF+3rvVxNRxHFTrupbgR5Gesql7Y1oK+vrM0SUnpoq7pPWVyyfPuzKxDJbMOqTFh+67240isR3EbkzDFbzUY8XRzPSIiuzhLVUjAJd3ARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827073; c=relaxed/simple;
	bh=CyknBeKqTlZejnF0RJD/chApW8SipJUFEYisqUHgDg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTdtmACMNsTDkked9zZzMQcg4I4KLS3EEYZSO4EVJ8LO+O+/jNxe0iTN0pK9bv6zzva0yKgQk+brVR1iopeOVdbs8RlPHI0F5BYZop7XDnNIbiwufzsYWHxuIu7MnaGGT1QXLs2oB51BBu0LZgzeKE25ejQ+d3rNhuLMguaBdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBXk/WqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dx00fedR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBXk/WqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dx00fedR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I90l1n2241177
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 09:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbVv45hd0DVIDJ3yn4OOBGlpupNQcPbuN1Rkfy5xXk0=; b=ZBXk/WqLt1W5mOdR
	kQxtKfosS5MtZsYHisf7tt2yxln/jJ99GTu0Ley3zRAn92JZcYmLTuR92xjBqriw
	yrT3pPYBDA9nBBBMuJKiMtIs2Z4U0R5GGS7if8mcWYjMnTh2P6IgB/bOxQlZkbhg
	np/bkznETNUASky+b7s0pJy5ZvJrx3kmFVYxu0ALHA6OukJGSK+RANLk8yK6+LFf
	fPFUyDwlq1HMFRCR/5zUWPUmQp2GIURJR7M/ckZDgWY+oVnqmtfNp35EktjeEhra
	wYS7uJS/PTIsWyUCZfhgYlS7JdN8C1XfB91CXdYmHanoHZGOpG7mYkc6lNDtdEG+
	hH2QRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyak3un07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 09:44:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50923dc39f4so47533841cf.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773827064; x=1774431864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbVv45hd0DVIDJ3yn4OOBGlpupNQcPbuN1Rkfy5xXk0=;
        b=Dx00fedRCzvEUzcATTusKbVqTyaMPpZYkkkoLtnKEySlWcWZBnL6EC5rjpOCaBoqcq
         cd2LUnfDt8lJ/7cZuD8DgrcuW/gEq6qd/aJMAYs1Utj/VyCq02SG2ZfggH0qJmrXLiix
         bNnZ312fGSYgy/vDeZPizqLI3TcLyXurFlqR7FCxtCfI5ssOlU/kaOB915qq4Z4v16Sn
         Zjo911ssIjXoVVY2HkTL5mcvFOn9Ss4gRL/gyBmyuld2Ar4DtSvQ+7XPAu4FP6c2I1jS
         2m6A87FOp/F9VtzWAOgBwPcp88NfKfCMzLQLNMxMER+UJsGd13+z5g0SV+02LfqxK12t
         l42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773827064; x=1774431864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbVv45hd0DVIDJ3yn4OOBGlpupNQcPbuN1Rkfy5xXk0=;
        b=ex7f7htldg9EkThwrUDs0pol23bMBTbto4Rzjw0JpqgVZpvvSR/9BJCpQ/YFCcAD9L
         pLW/2RYl0Y49TL2XmuXMDA7brkR9MXHetOqClVsJDDWe1E2zdQncAyZyevJHBVhZxxHz
         ZLVtGYFd7ugsjjHDZ0yRcNwqrkz2zcCdTRyMUvZ5q1bsiJZXSOkUhlxU6mP0BQuuJ6B/
         KImqNH+Dq/Si6W/pY9lUUZ2pt5X6ivjd0grYNqMsCbcM2obEl1/j2W8td/LoUM5+Do80
         LRv6te+KClI9YNCF+t/LKO4cxzjW9n/roMxbGvknuJN1SblkuxgCSzeDwg8r2Vf2kxGq
         mKDQ==
X-Gm-Message-State: AOJu0YxwjctzrxUiY8OU/3PqHGsyY7BdoIUMdvOfA4A0B/HLBTb2WlvI
	YzBXoOgeNq2HE9Ae/xR54VC7vzQJ8nzcbZfkJfxrpMSPMr6zvTWcUcq0WKbTh74F6NLKpU7gayx
	ZQp1LEHE+O3NadQejLJGM/uWEI5C8bOrPLxx4J8pYtxlx7jAo/RMii3zW4XjCtA==
X-Gm-Gg: ATEYQzwqBVKR/yPzqJ3pItdVPjJ+6ybZRIvBOwS8h7W1daUiyTOXtGMqR7WyTt+P0Lt
	ZxLpgJBTV7y2AwNwQmqbDKw7Tjv/x6B5LiczKVGeHcajlQMcqq9+XPxuSBayQPsu7ooO65zrCax
	TyWuRp4YmusIaJN8QdZBSEv7sYve2P/1e5jVZs1Iyumjjmja0+yKC/U1zcowX/NAVI8FeQqSDoJ
	Y7hXfUWTwV97JNrHYMONM08Yjjd3iIBvG+neeWbCGxUwAzUfWrca8xpA2e5kUvECYz0d4Stu7ZJ
	1QeZhR56Np/pPXXZEhvjQ/4FRtkuCfGen+TFeFIS6MT/gxtdyibhEsqAJXfxmRqQZpdwAteMzvU
	MSiyfsx1kf7e0xNNqvzV78U/Kp7Rd4sHxrmmx0PpWn1JL2+VgI/2rp0NG1GArVHMNIsKmeNWWEq
	0YBNw=
X-Received: by 2002:ac8:5f4e:0:b0:501:4767:a6f with SMTP id d75a77b69052e-50b1478e819mr26241011cf.3.1773827063814;
        Wed, 18 Mar 2026 02:44:23 -0700 (PDT)
X-Received: by 2002:ac8:5f4e:0:b0:501:4767:a6f with SMTP id d75a77b69052e-50b1478e819mr26240751cf.3.1773827063330;
        Wed, 18 Mar 2026 02:44:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667b0eb9c02sm1264923a12.19.2026.03.18.02.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 02:44:22 -0700 (PDT)
Message-ID: <c4376a88-a490-4b58-bff3-b0f4d2f731b7@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 10:44:18 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313-sm8750_tsens-v1-2-250fcc3794a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=A7Zh/qWG c=1 sm=1 tr=0 ts=69ba73f8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7yBUspA8RIIxP2VSvn8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mnKU4XnpyPfFqHfa31cs7i7nkIhOdiSD
X-Proofpoint-ORIG-GUID: mnKU4XnpyPfFqHfa31cs7i7nkIhOdiSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA4MCBTYWx0ZWRfX0HpAfQsd4iWO
 qlOrlPCZVMXdIaFGqvH4mmbJ7Hv1chIPvTrpLxuA4K5MxAcQoOQvLg45PyWAxJM2pityDhgwuRl
 HDoq6Y8v8ja0WNNT5VUxDF9KM5ELzQJCMbFkmh754JoI5xVqJ9Waz40vCyf8z7jKmOPg5fPiwVS
 oRfajfFijMR3B4d8x5o3bnnnD72RXXPcMnSSy9q8m7kxqBkiMtbhqptEyLkka0FQy/AKt4/n3sW
 +cGEirN6wD5PP8jM9sXpMS3BykGQWv3BKp2aAgSq6WpayMaf9cTrWpvGHboHfgqp9Owe/YqhNR/
 3r9N7u4XosnRV4aF1hrTbX5t2i0N5plBlYkmN7c+d7Q7NOHO4ug/JRVd05tXzQo8uJPjp/NyyYk
 Tx9ooTkyQgGdRQhdnB6lxtdKJRUmpgZL2rq+nsc1xTxZziNiXhbtDrEe+KiT6tK5T0vHpTA9sTo
 MB3tVWWpnDG2zfkfgVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180080

On 3/13/26 11:34 AM, Gaurav Kohli wrote:
> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> 
> The sm8750 includes four TSENS instances, with a total of 47 thermal
> sensors distributed across various locations on the SoC.
> 
> The TSENS max/reset threshold is configured to 130°C in the hardware.
> Enable all TSENS instances, and define the thermal zones with a hot trip
> at 120°C and critical trip at 125°C.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

[...]

> +		cpu-0-0-0-thermal {
> +			thermal-sensors = <&tsens0 1>;
> +
> +			trips {
> +				trip-point0 {
> +					temperature = <120000>;
> +					hysteresis = <5000>;
> +					type = "hot";
> +				};

Are we going to use these trip points for the CPUs? If not, let's only
keep the critical ones (again, for CPUs specifically since they get
externally throttled)

Konrad
