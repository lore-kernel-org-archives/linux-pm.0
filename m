Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362C37700F
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748350; cv=none; b=V0iy1ZDbwZ6Dvf+HzNSCoPe8oMkSzH167BnCGYRJ3glWN8IjhfBUV2HrAXUX2HhYzOEiUguyMJILG7hVRBS1IUaM99WRiUC2SFGDPobj9eGoIr0yLm0NizKJXQpuXsIfmCErAWgDiZ+I6Ob1qtk32xW4Z7FKuWDIyBHV75spSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748350; c=relaxed/simple;
	bh=eAHQloBTSSj1F6feGo0j5LkDWh18lo9fPIzeWrdxtnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U73aB7Wf6Z7zarihyM0ycEFlQWsI2baCe0IUeFNXHwXyv0mX3d8g6sgXhMG1BH14Adaq4S+RwLciTOVVsLiTSznEL9YCGRw0BHkaUPCS4ga9Y9xpe1cTv7LJd2M4O8jld+jjr6QJGp4DMLAY+yvdJFH9j7gtTaU+VC8FKEoGKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBaf7bq4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j/4YcaGt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBaf7bq4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/4YcaGt"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7dV561639514
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eosohSFi3Dz1sqfuINtAzY5KQfNJfuUSLh38zg2d91w=; b=ZBaf7bq4g7UqvYM/
	eJqtwzJnKWJkUHCscoaX3NkVvhISC62QtK1229JvWzK2tmIurr7hXWJwJZs5nFwB
	v/E2h7dLstxcDCRznp5alGGbd8AWeELeZgq2QDkBkM849bqxlw7hJigL/aboWcp4
	z0Ql/LE3Zqq4aXH9SKHxRxTlR3da/uFBBBjkuF8TZNOr4ZsHubE/NgXJ73wqJ1iY
	vZ81MV4DvqEStQ1KIz9XrcoLRjM7df/OGZZCSkX0DScZeLcJBDA7YZTLdxL8Tro9
	Yt+ofkyjt0Y8ktEoEL63J+pint8mzQLnmB3Uh7LNJbKfxzNs1kQQegYseC7EtSM6
	EDyZDg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke0c316-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:52:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7a2c535eso305935485a.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773748347; x=1774353147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eosohSFi3Dz1sqfuINtAzY5KQfNJfuUSLh38zg2d91w=;
        b=j/4YcaGtWkDbIMWvFG32g0VaSwoZMl+SsztKPM6gopFltegRGUg1a/Dyve+/kxNFgm
         /LiYDZJcENE+itevcMNBO9Lgq6rwvdh9ppTEzLqlD2IreokL0UYPesVypYLVL/6Oy50b
         YumOB0yWf/xgSffaPK4rMe4ezFb2JjNC+URnnCkwVriFewXwoaRv8+I65QwCyQWP5uWq
         z3MjdpEz4bHkLAc+cKDKm1ykqwIV0NzQo0dOBhuOpCW/WGcPi7MdBv1eNQUIO0szepgb
         JBEp6Ey8mgbh8tNbvjVNAwEtohsqCdeIPzUBg/DDC5aGu7SW3zg7T37EnIYBDYbqMb9I
         pVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773748347; x=1774353147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eosohSFi3Dz1sqfuINtAzY5KQfNJfuUSLh38zg2d91w=;
        b=Xr9OKB8Gb8kY03/efVP9qr1whUFxl7H+xHnFOGdS1pVTGDvRSBVMRkrrIzoDa+ubQ+
         fomX5h3ki+kFmELhLWuPk2P0C2TFb4KwimxhCbT/HvERTQgA4dJ1dMEPFniCiHEpRGt+
         Q2RkQOSs1dUWVPaz89U0ZL4wes4PU0WIDB+SRHnfjWrUojEZiOrOA8IYhJ5B+sU5Ea0L
         LgO1vNSwqwvYCXNBJLxIb2qVCRJvVY4cVzTn0GS60fHCLhz9PkhchryPQGXTsGEmWIMl
         Pfr5LldRYFiWeBtbpTbRYCkJKrxk0H8risryMkdIrwaD0hS74PPJjsbil94GnN3ea0MQ
         0maA==
X-Forwarded-Encrypted: i=1; AJvYcCWHqehC0rZDN+PJv58Dgkl+xYDVokOMn1EocskMzHCq4cfv2WV0XB/QGAlOO6VJkVKPZsg1Orphdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGCgELKAeXpcTrYgIgpBkKbV8l8XGGHTFlime5QlL1Y3OfyEQ
	vJx1zfbrFCpUgyro5PD42z98iJgRouskknA4iI7Stxfvk4G7MpB5ZzjzCFwXzKjF6a5KPGwCwZS
	QQQ+tW/sGOc45t8g862/auPxbjyQZHdaGAy1UnkOGkc2NIMc1xKpexOJKv+AFOQ==
X-Gm-Gg: ATEYQzwMVnpQPiMkI8rrRMDtNcnrkW4K12tKCQxl1BsgUlKAGE7+Hr7KBlENaZ0w1zo
	RPB3LikDQXV9VhPXeDO1Ye8ber3yDRr3KPK3Nx/BoiMosjWl8+SrtU72Qg7n938Damp+PJSWzkR
	+9yaPQfA9DVz2GZEZ9wgFKxHmT3Vyw2V5H+70FAn/ZMqdtKp6Udrx6j01kpiDxHygfyTNEdDhKt
	Ja+1UbygSgz/2cd8FBxdfaWH4km93OZpSNaySHFEMPSDkpdgcvKBh+d2DPTiWo2qrRj61HzU86a
	648YUknPQZ2+dFjsZnB1ik75QRlsKm4rowA3sXCy1uNfgf+kP139i/eDpT+Fok7rbPmFoDstvmB
	AqPtin29NjqTgrhCUGkp/HiIqUrLzo8vsGkMRgNmzcp4ThlaMnRCUGBLBQMguBEJRnPy2IKakyS
	TFhsY=
X-Received: by 2002:a05:620a:3193:b0:8cd:923a:87a8 with SMTP id af79cd13be357-8cdb5a2d141mr1692387685a.1.1773748347254;
        Tue, 17 Mar 2026 04:52:27 -0700 (PDT)
X-Received: by 2002:a05:620a:3193:b0:8cd:923a:87a8 with SMTP id af79cd13be357-8cdb5a2d141mr1692384885a.1.1773748346837;
        Tue, 17 Mar 2026 04:52:26 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97a387694fsm479916766b.49.2026.03.17.04.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 04:52:25 -0700 (PDT)
Message-ID: <ba005fee-7cba-4eb2-a2ed-93383d097ad9@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 12:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: cpr: simplify main allocation
To: Rosen Penev <rosenp@gmail.com>, linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        "open list:QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER"
 <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260315214153.3682-1-rosenp@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260315214153.3682-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zW_hRCY_E2hjuSM_pKOzz_Z2sLTkN_CV
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b9407c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1vmHEZbavBHxmJfcV7sA:9 a=QEXdDO2ut3YA:10
 a=ENiidslfg_8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwNSBTYWx0ZWRfXyzR3U360YC5T
 np5FGCwerq+3UbEML3vUI4fRuJc3sv5zcGL3G+IEhAdd/NgMEh6x7+porw7Fwffxn5mMfeTPwu5
 jDEPam6m/DJgm8vmRthndsDpQuIjFzMtY8uSkGCATAkmD2IfBqHPqhR92v3z3qTm4+bYHd5jrcP
 G1Zqe/WpVe9ug0xohf1tzXIwgdDJzCy2LNd3yKDFAn2G8bdYLcv09PsQrujYJ1Y9iM0QJr4CZZi
 En3Sb8ImJ0Odc3KAZ52LH5lcu3wLbrtt9upRJydH0tmLRTpJxE76fJ5W48lgNMEUu6BtbMnz7SE
 ctMIycINKRkGaiRLa8ZwRfCbqFOHTT54P7y/8OqAgpICSSZRtyMoIBBu3Xe8MHr002TcyhsX2ot
 vgasRtkEpBkMEzsjERmmlJTAIBk0ceVjy+fbCjBSoQn7c1goOrUbNmE4BMh5Ec11rjHJf7qXuC3
 NZv3bQuJeug1x/DNWMw==
X-Proofpoint-GUID: zW_hRCY_E2hjuSM_pKOzz_Z2sLTkN_CV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170105

On 3/15/26 10:41 PM, Rosen Penev wrote:
> Remove kcalloc by using a flexible array member to combine allocations.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
