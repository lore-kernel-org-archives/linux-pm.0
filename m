Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7ED3921FF
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349700; cv=none; b=fVyv+pA8bnMM/2UDv+5auGJmaU4E9dcGgTVC6gcRbhAcZOeYxKii1kFCN76lAYW0hvBBd2j1uORi+ptQH2g05NXVSJBvCjQQKyQ3zmxDrk40cuExrVvKjtPHw0firFPa/Ggq8ELcYONLGrvOZW6xFsfxnZ01tbcvijH8+lCMTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349700; c=relaxed/simple;
	bh=0NnB1MgNMR7uoJP6UWxzFUtlEQ+YNOOro6F0g/G5eqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDkOr5bAiXa389ysqn01qPqNHhVsRrd1A2YKF5jnFiMEwEeY7bXxC8DyCoE9OokUJjMrwJFcSewyUBeo7aW3MJPGgjuLyKyOmtUQQrg9eMX2TjsWcbQvow0GXtGWdSXCAQTk582DMHt21bdc0mBhNV06fLnj9vsI95MRLPHMq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nf+OGYvM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDvshkZM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nf+OGYvM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDvshkZM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9aeaC3903752
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 10:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6dXF0IWEVhz/9ecP7wtx55JEEj+8kMK1bOYfgNiXuyM=; b=Nf+OGYvMIMjfsJaL
	MQAUHpWaesAXfDQqXr4BVEphIJD/PqFR1wn9CwK55Lzl187riePgomaY7+q3rfkm
	EOh/0odQPSwtxL7NS2kPLKQPVJSGXbQJ0DAxOj3WQOhZzm6EVYaHFbwJfV4xX1RS
	Rd+JLzXa2kTicwHMJdQDFDbIYvX0wDKS1NtiI+A9Fgfp9fxroLzpKPabJV1V0xhw
	1YVzfwUyXCIM9bDSlrHQTVt3KUJ0/38LPr0TvCkcMbilS30k6vI64RmP2zgaYvHJ
	55qcd6p+Y6XbBAu9BZKQJrkv3FRnTgzbUPynvRn8pNr9AL2SBfQcQFLadCNO3MrR
	zbcVmg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0hh5n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 10:54:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5073ed1ec6fso50641841cf.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774349698; x=1774954498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dXF0IWEVhz/9ecP7wtx55JEEj+8kMK1bOYfgNiXuyM=;
        b=JDvshkZMeJpVasQbXAh+m5wheY78ZgL8CRzaGcv2MrEp35q6ZkMPd9oBEqFo4ba6L2
         5JnIvzk4M2O1wL2XCnFGtY9Q4NM+5t6OkNU6tV2hFzzD2WLy5/+WG9sWDZoazcYNPE8k
         LxglZ4dc9rBOK0Wu+CpqZ2G+5XwaIYfwxgdBReQ2pm48QXWM4v/vPTnoJzvCg2G13+9U
         kRCXdtQgrlflzX3EGuRH/yr37UsNu/H55i+jLuo6NZtquq4vyjDMVQxLigGgNL8mtCQI
         0AaSqiHn+IWS6ChP1FlVRDPrm74VkgPhS6HJ4GCI+kHcza0Xu/jSijiQcELHgKwpfdyp
         DcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774349698; x=1774954498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dXF0IWEVhz/9ecP7wtx55JEEj+8kMK1bOYfgNiXuyM=;
        b=JAp6xLx4TUwgsadSMABCxS+aJKf31w1mlOOwbl0zimtyj1l7CbT+B0GzxsuTsstHmo
         i29fJEWDGRsuGf/vIHx9cQd4TsatTz0nNjq8WCWvjfI4AJGMEVLQHURmJ+oWU+hd5CL0
         q1e06ldmmm/PqAGiia/PJXx/6zHJpLXTodqyyTZDvNcDA7sVLCleHBim3QniiMP+KIWu
         F0B6IBXIFtqjLwknmYyQL70DUcL36zrYCYhgc2JBMWxsNVf0UtXePJVeK1CK9CVLbiel
         xM57Rs1o56KQDaG4+QBqPG7uzIMPDhFem9IecUYB40k48WYX/D+46fR9pes1uwfkYedh
         tIXA==
X-Forwarded-Encrypted: i=1; AJvYcCXchNDb8IPUdJeSlzCs+yfK7X0cLJqHbx9sBdtpYKlEYXqFduqjZi3Qr5eOVzwVAiazJoh/69FahA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRBO6kHIdD4eoDCtRmxcc8jnFYcce3DgVzjg8OTDeGKx3m/CC
	CdsYaL2WEgpRvUx/EE5i9m4oIan0HxNvpHeBoDd5Pm0WiENmk2aiiJ+5Bn5wz33hrhuR6ocBi+Z
	KmjJ9PH2iiqM6HTYCN5wf8NP+P8Ro7MVk51rJjMIgafDIhB4CUg+XR4BVoMMGow==
X-Gm-Gg: ATEYQzxeZ2Ek6fVbKwJ9J01xOApkQtfm9AUebffsZ3APcBfbAXheuLQq3CV/kWIw6qJ
	DYA1Z3NWV8V4SyvCA4cw9mRgmfTsTaV2eC0ddRz5rOdS2gS4p4QUH1CSnanzRIm6VOeC8au8QCF
	EsbyuJWMsQ+aNBw+c2vKW87gtMpUFLErcydtG6//UyWoMr1NBkRi8rZ5kxngFqXn8sN5QI4gAs5
	4xuNFNNAzb6CqidbXCEtLw/oIROlj4P84btdsyyX8gSaVR6dJs8BNeo5E0JVJftjSv1Ha+LXbu7
	PgtYWCRVdkt66Bkrm+/gvlA4t/yd0slLxTfyeDQiDJEEmsguCXfH/FVAFwTIMQ9yrT+pxgnhdKQ
	eDyHoLp6FRJ3hwuXjnTYroGPGGvGFMDEi2/A54T3YkvRX8WIit1qMxCELGu/LZv7l9/u/oyH0WK
	rWnII=
X-Received: by 2002:ac8:7ed4:0:b0:50b:6890:fca0 with SMTP id d75a77b69052e-50b689100b7mr32954441cf.9.1774349697713;
        Tue, 24 Mar 2026 03:54:57 -0700 (PDT)
X-Received: by 2002:ac8:7ed4:0:b0:50b:6890:fca0 with SMTP id d75a77b69052e-50b689100b7mr32954271cf.9.1774349697244;
        Tue, 24 Mar 2026 03:54:57 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365a166sm628563566b.42.2026.03.24.03.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:54:56 -0700 (PDT)
Message-ID: <f3d76c8b-17c2-4be6-a205-c163816ebfa4@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:54:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] interconnect: qcom: icc-rpm: allow overwriting
 get_bw callback
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
 <20260324-msm8974-icc-v2-4-527280043ad8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-4-527280043ad8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nGDwo6uMD0uNMFYCw2A_LDUhBNU9iRq0
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c26d82 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QE2Rp95VnyMwAnmAKP8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: nGDwo6uMD0uNMFYCw2A_LDUhBNU9iRq0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4NiBTYWx0ZWRfX4HItqnFmABj/
 YnD8E/G16Eve1s46DrxpmzhLrq4Nc8vzqaWY4HJNqT8rABG7ZRgDj1GaaY4Mh2Nlbgi2xJEJgGg
 zgq6pCkQWe5Gc7wCHAJdM4glbe/N2HTfHj9R6N4C+465I8rZ7855ZtY11K9OuENl4KQPPO2Q2RD
 KmohQJdnz/RbT8UbMSHbCF/ZlQPJl0cbJBqMRTpaJ7evn3inHn6ySfhHl1FcOhLqjQC7Gx19Mcu
 lYsZArSFk43VkmN9bUQfgCY+gzS1VyQG2c8/m9uMJBlBRFuUOaTDYXOzLYCoBrCedNv85xRnX/z
 b486mSL0LsRUU/mlNnmSjVLQYs+BJZ0P5neSnRzcN2urWmNz1O6u+14YAlbbs2uzDor7Z2jX9UA
 p/GHU9egWNpReWqLXfaDrGdPECXk99N++asuW1Yi+4AyYPfQJOdGT4EiK+8IOJL8Su7xIM6yjf0
 lwcqyHXVutd05dFPe1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240086

On 3/24/26 1:10 AM, Dmitry Baryshkov wrote:
> MSM8974 requires a separate get_bw callback, since on that platform
> increasing the clock rate for some of the NoCs during boot may lead to
> hangs. For the details see commit 9caf2d956cfa ("interconnect: qcom:
> msm8974: Don't boost the NoC rate during boot").
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
