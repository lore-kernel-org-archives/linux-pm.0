Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591E3890ED
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261613; cv=none; b=fsf2UUCKgyy2fdj2zTRyVSvEtX9qdTiJXCDpoJLt7PNQCFHCT05sKBqy2yX96CZdG3G1uvOq+J9eZ4Y27vqJz+h3T0cwgjl1Q/+TcnHk5i9LVe4S5wZT0uobfCACoeYXaiCvoCYTtWtlgQAg5OLiHNmlSZ22b/ICBjrxOnqOoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261613; c=relaxed/simple;
	bh=AhgCJKNKN2SuSP8pwgCoCXs1i0KPrcbie5088lH6RpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp84L+pJ7UCRoYmzK6BxFkovqFEskhPfPM0tMDfnW+3SyZ8loFmzDwffyFZd/YyzSxOR5PfJQHZGtN4v+zLxJ1J/8QFCcuCvosplut7RKTSwNRo8fRSK9V5GZgJHkRcj+MlZBfT3oBO2WZ7aa57/eHn2+h9SEsHZulXZMNVC5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=diytOx1S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hyFeLaRY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="diytOx1S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hyFeLaRY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N749153393285
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H5VbwRrC9FShcy8KwaAgA4sWuLUfupsur8ObOZmxynw=; b=diytOx1Sdh3WsFHi
	Cd7Lc6Jg/HWQZthIEO/UAtGuATSFQankHaEpNVlBF9vV+zfEW53La4NNp6+Xqatm
	v2FHXaLNvf8VzuJ6PgoSkoJD95nmO79eUDNRluI1bMXOYejWQDl5rdtHXsEImJ+S
	ZB/cMvu889L1xtlEsoc+DnZrgXWtPSymeLX77JpmLfuNDC0nUDBQZCpSK2RihOHq
	zyHIcKQg8wIwhyLQD+ZaD1wtsKCJuQIN9Ur7/m77MZ/TOgDrra9PnH0qALvnDS6i
	/6TaB1f8OL6OnwkYuuedqGRrRu55OGOqjEYwFQKLS6u/qo6qy08ILsGgOAYRYqNZ
	fv5Y9w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d2ca8jv2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:26:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5073ed1ec6fso40590891cf.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774261611; x=1774866411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5VbwRrC9FShcy8KwaAgA4sWuLUfupsur8ObOZmxynw=;
        b=hyFeLaRYYcRje62+hQUQslfjhxyUgBht02Rg3O43TnMm5w+V3nwRg1JGSPL2iLX3gw
         s0Cq2SHN2Bu0oRkOFVm1zBOnFwr+DK8obGAkVUChLmxoKj0/QWB/Vk/IoljTRX7w7StV
         qLiKgIayNlomzktKFK/lgcMTRH1aJZspDBCC47gJWaeVPKDGmzzITBQj2djauMPY3kgY
         ZXVJmBJnU6Gz5z6q72ODDYlAJ9Ozo5d087JRJSFMVTOfrO36QbIERNSEZqImaO6au/Nf
         9pcUgZbmQTmI+ozXNAnhL0iyejJQnuo/sflppR1vJJRcAfcDuMtIE5rL2rKBeB3q4ys2
         i2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261611; x=1774866411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5VbwRrC9FShcy8KwaAgA4sWuLUfupsur8ObOZmxynw=;
        b=WtBZKsPz0Tvo34h+K9QYG91FY3F2le3dONvWAedYNizyfSU/8nuQvFhXDsYdk2AYlX
         cbXJufF6My9T83h28TAlCzUgIWbqArbELKZ/9mvQwePPUjiowxU2SuLsU972jCfzEHM/
         3PbBEMU3+APxLYpGj2FrcvuNIv2F3QTiyUfr+OBpi0Y6vVR9PMmPOCY/lJIpYSHkK018
         yMXxv0YX1hO6QPM9x9mFfu4+a+uEndzDt662YCHVWyZZFnzBUKG1iWcL7vdEGuCm9F5j
         ned+5UuAAZet7fqUQCt//c5USp4Evg6nIDnGOvG9+AfA7y+mRzBNAF5s5O3ckRbUvnZO
         gqfg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+Yd/kOTKl5TRNj2biK2o6ZtCn50/S+I/QeUGac5svHT08NM71MAF7qakaELwZD0FwpOB7fRbgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDspmfL0502X2szsS3jcfIFQB8Tt2tu3ebPlEAHcz38n3EkIG
	krzegOpKpCwy4xb5tJhg2vuDhPWUMOpYhxLIHiyD81bO3RA+SVysyEgn46/GqVbjMJQ6QL5g02T
	2ks0p2C7DvAvqKZMxHP7H/tjA5AM3nyDNru/Xe/aselpabU+eVtp6mWdhCJS/gA==
X-Gm-Gg: ATEYQzweYExHABtCm13JZV1/IEFQekGVNj/pjw3AtaITp+KjLVEZ9OMdCHWMAIjcmxh
	0lL9rgl7ydzlUJeR1g3K9li1/bBIVqQ7ey+Vzgpar0geKYGDsNvhVDy/RFE18GtQKY7jE+Devzk
	FFm2MrHM9JHHA6f+kajc2UesuaVSHNfUM+SIN0IQipbKhme9F8j+SRJX/LYScs9vFgKuj5Wm+V+
	EA6249cMTiKYKOrhXLDhq0L4luNyEEhFeE7fPqb8+wP5EzFq3o5SgpCfNmAbqA+tATd35JR5Wa5
	z/dPdxyuJy+Dixw0tyfWqHmK6S0tEuQDjQ5lTO8yLLmT6pFJ/M9/fBkTbdj6OmjsDpSr7iYtfhx
	cS8b6EO+dtZ3zwYu2gGBjC58DvnHa0OhA6jFs3H4pNEePWiVdcqa3PX/+iXo353cLG/cRfRBfp4
	VN8pY=
X-Received: by 2002:ac8:7ed4:0:b0:50b:6890:fca0 with SMTP id d75a77b69052e-50b689100b7mr4089361cf.9.1774261610860;
        Mon, 23 Mar 2026 03:26:50 -0700 (PDT)
X-Received: by 2002:ac8:7ed4:0:b0:50b:6890:fca0 with SMTP id d75a77b69052e-50b689100b7mr4089151cf.9.1774261610373;
        Mon, 23 Mar 2026 03:26:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43b5csm474908966b.1.2026.03.23.03.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:26:49 -0700 (PDT)
Message-ID: <3d75f9fa-f744-4437-8c68-16ca751193ae@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] interconnect: qcom: drop unused is_on flag
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
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-3-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-3-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MSBTYWx0ZWRfX1Zv9C1tpU3qR
 ynsUmAevm6WmOqctrKsAUXuyEncQLL2XupEKUfeCUVySa6BmFOVCx21Kckh9XgEgrBJqaFH1jLA
 AVvHWMD3OnPt+wmL1bRodV2vZg4Hq9ApHRIB905dt6yO8Z4ZXBY2jQ3AUTeFkN0anrQ8DB66qSj
 MGxQ3OisXnOMSIxH1vOGv0t3A+aQqnzZ8c3FHETWe02RZqKYjmbMlfXrCGbyd4rRZMP7qcRpbQe
 Qzvh7ZNOdIKtjx63Uv5WoLZf/gO4afjTCr+2GnWslNQeRYwR0W7x/+NsxPkWqg3PW5BD3G3xwQ5
 0nh+PAJyqfs6b6Ek1TbJt4KJHqFDIcULnlmHKgYqTagxpUoxvNqdCaEPOYdXp3QvQK1T0pICJOI
 Yu1USezXzJ8rXETjsBTEzR2KvyG+RfOtK4H5SPH+jRcS+/Gz2030Lhm9fdKfeP+BGQv7rwYk+C1
 zUDbm0QaccGJLK53c8w==
X-Authority-Analysis: v=2.4 cv=cf3fb3DM c=1 sm=1 tr=0 ts=69c1156b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=E8RJyoIzjAt95Q53sUsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: vDofjy9bZfXKhDvV7U1nGaB31ave6cz0
X-Proofpoint-GUID: vDofjy9bZfXKhDvV7U1nGaB31ave6cz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230081

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> The commit 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface
> clocks") has added the is_on flag to the qcom_icc_provider, but failed
> to actually utilize it. Drop the flag.
> 
> Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/icc-rpm.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index f4883d43eae4..3366531f66fc 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -51,7 +51,6 @@ struct rpm_clk_resource {
>   * @bus_clk: a pointer to a HLOS-owned bus clock
>   * @intf_clks: a clk_bulk_data array of interface clocks
>   * @keep_alive: whether to always keep a minimum vote on the bus clocks
> - * @is_on: whether the bus is powered on
>   */
>  struct qcom_icc_provider {
>  	struct icc_provider provider;
> @@ -66,7 +65,6 @@ struct qcom_icc_provider {
>  	struct clk *bus_clk;
>  	struct clk_bulk_data *intf_clks;
>  	bool keep_alive;
> -	bool is_on;

Hm, looks like the clock vote is kept all the way from .probe()
to .remove(). I wonder if that's really what should happen..

That's what drivers/interconnect/qcom/holi.c does on msm-5.10

Maybe "iface clocks" are only needed to execute a ->set() on a node?

Konrad
