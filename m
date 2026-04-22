Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C63D1706
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859068; cv=none; b=UrooM5pUVkLZtcq84LQG+q+/O/k4Y69myGhMZeVbdkJkqkDr8VYu37nGIlgK8nU3XAJ6XsThPRTFBym4BjGBfnRkUcJsJL9EJRhKGbitZDCVtL5s2coqQlYfhLudOC8+/vNayJG4kCnnwn6Fk46Q/fkMp0CDnjks7dCAOfy3C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859068; c=relaxed/simple;
	bh=WZcQ8IgTTdxHEZHy1H9LTjWO/tGD8l+pU04Q2AgAltQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHoIXLrEqxFyOzYfTVXaJYN3+tPkYu2N+1xcqhwfyIXiBpr5RI9ehW6U31SvpQuDPnlow7HTvRiTqUkV1OnLkvSfNedMIk+2pFF+wstSCjpkUZ4YMLi2dvYfHqVDEOmI079yajSCQ289+3kknA8duqAhR1hUZhVU4V18/TdCN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PU2hWyNy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XnPLJRk5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PU2hWyNy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XnPLJRk5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M96E6U664114
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PC10pDiG1jjcR+0K11CaN8ksV7qOmFzw+8AOZycWy5Q=; b=PU2hWyNymFdimF+n
	dpLanGER9FI6kB6O7SXldCo29r3O0JZYCRDWVquVcE04dq263BIHoSjkCPd2SQH8
	/ViuIbUoH50JPwL2ogQTQm+Quzgmm0bOYFWov2o9GVv2r3omD3Xncq75vBqjtpPM
	a2yRaQcQ9PmQtgNZAWawiRU/WNlEr4yQIi0qiIEolt2ACbmWNzWlnXSuEsZp9qp1
	b6R63JIjk4Dv7oyZ9yOlBPZ2+S6byirv7bl37mRjiy1KTYKjA9PCg3oGMsT7/qF1
	1F66oJigp6pz6Os3E4xXq8VNisFTuegX7SmTwWSotb4wu2o8MUi20J/qrmmMS2+s
	YgGA9g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgrkbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:57:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fad7b0ae2so8603351cf.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776859066; x=1777463866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PC10pDiG1jjcR+0K11CaN8ksV7qOmFzw+8AOZycWy5Q=;
        b=XnPLJRk5B0iBA8iaAfQSeZ6zT/BUy8seuzbRM5sZQ7jnaqq4V5GwHP32KAlRHPdnZY
         vtAu4p249mQPUi0j24LycuPnORnOjzGv8sA+/icFiZdMNufC89uAi+rX4l5jwdcq53Z1
         7X97yQrS5DuPwJ30hB3+TzpFTDK4DG7kdvR8moFpwsn4N/QFoFATVjq1BvGISKrnXyVi
         Cg1Nxl/6wdiAFStouQfCrwxVrMFOaORsMXIiCysgMDkoKes527tfE6eeaNU56Wk9RLn2
         Acj3xexFugHYWK25yePl6cA8tfJwJzLvlfvBWFnGImBxfZ8Pqu7yC4khaS95Sjp/BFke
         Wgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859066; x=1777463866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PC10pDiG1jjcR+0K11CaN8ksV7qOmFzw+8AOZycWy5Q=;
        b=Jood9uhZKR9L/wURL2nYObjdhXdQq/hQX4+pNdfqm0O65Yke425Co7GT+Okj0nKP36
         o9wvfLPAIsr67JOW+0xESBlRqMbpAu+5TieP7ruVqFf6mRMllf2Fep2POEya503mRIEu
         0m4DgfsZ010zeZVvM0wpCcYcoLGC2rt2PZywRc7YM9Lo5j7RdlNFvhoS9hpcgRxtv3t7
         //KtVo4pbCNX40DztgRSKCrv3FxuX8UJZX4B6Tt5dYv1tmMIYlgNcyK2kXe3PGP8fiDV
         4CvA8fZq67yZk3IRucRuUa4mQHhnHi6BukR+oGia+wpuOmDanSZ615mgIYFHOCXOrTVa
         5b5g==
X-Forwarded-Encrypted: i=1; AFNElJ8rnwDHu5almF/fDmWU8PLH3wpEx/OU8x5+Hk1dfMhpWfiYp2tWQZ4uuMytZIY1oqf9e5uiDT9Tmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1nuT4h1D7Dcl/SNjvi3QgwWekHJGH1KSjpiO/DQ4zvYOU1Jf
	wgL927X5tfmV4wh7yqn92lI57nf6M/S8Y6V7NACVE4aikkgnovhRX4Oc5FJX2j+7poPAzA7dFAo
	j89qX6MlBXN5nPUlAtyUWdy48i4lDELZkKPKie6GPuyAzw0KC/AsHLYLAwCMCog==
X-Gm-Gg: AeBDies/Jjk+6aPmpGV1s2fWAwFvMZUTTvViCtElRL+m8F+BMZ/tLyFYOXmxunf5+iR
	T18WQYg4n3ycwWwa+MNDqz71MTPDZDo/mo8XQO0nBw6P7CBPPb9Cvl4tcocRU/TpEwVf1xlaezG
	pdxHmyIDEv7mFMRzUOXB2ex0KgKX3jJimV7GVS2i7RuMDj3r4pVmxZ2tTDnbAcna1YAh8b6ZnmH
	R9/EMZZT7SmimjmdboSgjHR7Zuany0/dCEaG88qRPgKjfH7QpcEzia6ZqMfNE2016gLyXidcj6V
	UcyKoiXRYAlqYz4erf2fz2bIpfpcaspFp+R9tY1aZ9zX+bqCg3KPM/5y1VELtTjLQoFETrwlVmj
	UlUfeOhF6hbAdHR1ZrxzD7kIlMfX7FFdIXMbKN4lTeqV6Y+u0HDYbYApGNsGQxfsSVULBJnuBKs
	cPvZj7AbC6g6oQlQ==
X-Received: by 2002:a05:622a:38e:b0:50d:714d:e966 with SMTP id d75a77b69052e-50e3669e233mr222103351cf.0.1776859065793;
        Wed, 22 Apr 2026 04:57:45 -0700 (PDT)
X-Received: by 2002:a05:622a:38e:b0:50d:714d:e966 with SMTP id d75a77b69052e-50e3669e233mr222103061cf.0.1776859065311;
        Wed, 22 Apr 2026 04:57:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45121109csm546618566b.6.2026.04.22.04.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 04:57:44 -0700 (PDT)
Message-ID: <f578fb1a-5087-442a-845c-db07ce3a9931@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 13:57:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add interconnect provider driver
 for Nord SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021351.1239355-1-shengchao.guo@oss.qualcomm.com>
 <20260420021351.1239355-3-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260420021351.1239355-3-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CKpIQetwwRcq6ESFvQgNz4hSo4OOnuFW
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e8b7ba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=miiGjHqzieJubTSf79EA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: CKpIQetwwRcq6ESFvQgNz4hSo4OOnuFW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExNSBTYWx0ZWRfX8K/Kw/Afo/GZ
 gK0wwsO25LCXFAn5Xq4c19zVgN9ahNT0K6QtGX516BoLLavskm8RkupD6Ro0HiLL6Ydaty6jo9B
 SxVFAcpWN2FK82mtytQ6fc0XzKztRtyQvy+hlIVjcI4IX9Iet5TylePtUFeKJGNhdNfl3fBWuAK
 N1cOZC11kFmPaEggjnI7eW9lU4crN5M4+wFbG+XdzQK5bj9+ZTJW6hezgfC8K4qEXAMG9GLJJW+
 mA8VGRvCRdHt6B19qi2mh+Q7ZqudmNGeZYuClP3rCEArF6nSnSKltzmSxkl9KGApx6DZ1LJLQFo
 yCjnhbz6JnjTpjOb5ahgjLkLrJkyinnrvaEiV0D0GwoGcnEw8HD9QI83HAYt+co7cxKYo/+6gTu
 iYffVs5dUE+nhjgFGhE62yf5TaxMmmRTS4u0Yr1MM01twN9R++zzsROcqYOekNSLOWJ9Orhr7t9
 fBu8k+sfAuSaqmyVz4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220115

On 4/20/26 4:13 AM, Shawn Guo wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found on Nord SoC.
> The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pair.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
