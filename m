Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A63B3BE5
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749875; cv=none; b=il3RZWHoKyWZaIu1IFwJoefHqoiKVb1gR4vbMDvjKeBy3J0wxoO6Q7c3zgF7lSA2jYsoKpjXKJlv8N6XQ3AExgfznM6KdN18KHhl3GEJcAHDs+Yb541r+0Si5QO3dsAQ4w6ydrH2umE9hZBkfPrvJUu0qoA0OT/h3FpbFWjaa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749875; c=relaxed/simple;
	bh=daa+1XvYSzE8eOwfhbectImkCDlzbI1HYNTaBEaId50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4p0IO3tm7bCo7FPcUiE11we9yB2s7JyeSQ4FHXPRhT0ud9NX1JlZn0KiUh5dg8+QNOU2x/qXoA3iDk6LdYsD8l4O1Zzk/P9lp4DEGKoMDM6HaPzH49A/UCcjJElCQ1mgTMUcmZEPMEmfwizC4cYCx9c7ZpiYfXWgHRCmOqSwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cS/TiBom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DibwPNbn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cS/TiBom";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DibwPNbn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E5S9h92003864
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0sOG4Pf5i797Nk7IZxKARPdtVNQssiq4kiFqW2LPT+A=; b=cS/TiBomZ8UTWeIv
	WqqhxZuIzZOCw4IjcpYdPZJnjv1rTZ9EaUkZuqOLl0o23iNNEYWw4HpI0A7NKpn5
	c2F7zHvOunZ6yST7ZgjNSOMBkwqx6Sa4KZ64g30+zbcugo3YrhuS6D3cKETBmD6t
	MV7yE+UJ+fkPMli6Woi8n93IWA14kvXSKKAIfJu3DQer3XxlCjChTsYdvmdSEhd+
	aOIuBhhhqUa2ZJeoM+eZMdDMuPdMOZdeHOLoOaEdMKcmmwquHocJ58RSDQTzO0Eg
	KOyO39X+zsAabXf2G4TbekvWGm30Z3Pqd/NdK8RYUUnmZ3W+swzgYFs9rk0zRaKZ
	9JdlTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5899rs1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:11:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e5c781193so14574181cf.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778749872; x=1779354672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sOG4Pf5i797Nk7IZxKARPdtVNQssiq4kiFqW2LPT+A=;
        b=DibwPNbnupuUJqkyGyVND5RfQ91rLmU5joU+MP2hbwcts9i15lEhvmKOJPgkWELRTU
         Hnv9+nHCFrjXsY2VHCcfrS3Q2VYPu3wYdGeo0CVYruUg9zmjWYlbk2mHOx79Dh6gYTsI
         2lh+a3RuWsxeBkC8hf04rxgQ0zN+GyuKuABfzjTd5KFziooVNFoJAWR0blZmsFDJn/bb
         5JLXBerOe32RJHFhwdP7mESsekfTIvJgK59rUht+UUtW2pFG3D/8aDpHMScI1qzVb8Ct
         vmj9KBeFsFACimem5ev4dJG8J+wbbpVV/x+9jG8ClLr3S8SXCr76io88mW90C+fjJqjL
         yKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749872; x=1779354672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sOG4Pf5i797Nk7IZxKARPdtVNQssiq4kiFqW2LPT+A=;
        b=SyLggSkOAZbE0GdbjJX0G16Mp343Uut32WjFMSM8VWw8Tiw1G1/7Py16snmpNd0W6X
         rohvkBor568aZ7lmUvlvHSS6gk8dDSWALA+YTi7EK4/RWiBaTt2jpTMSukXjB9b/gVdY
         DQcyHsZ91eHawbZeeCt0c0l9mqykUwXtgWOF+yjo+xAnN83hsZaSvwuIm0ls2h3Y2RQH
         VrqLyB7JJVUyNguqufF15kL9sv8SOl+me8gQBvDpZezr0PK0A5lWBFSxRUo3sAC5AU96
         bdwAzDNOEtplZigBz/tcdnlYP7fSs/IFi2mLO38RmoYwl124Bm1gCTbzhYnlgh4MMd28
         4tgA==
X-Forwarded-Encrypted: i=1; AFNElJ/3opRHO3ik2+D9P4fuAFua+pWQ6gOngEAgp+iFuJ5UmQukCuY0vgpYzzkzU0hmrMZgFXJ6z+Fifw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7+7CmIyTYNr5PIlpOoA2EkcYKyooPcy+v/kiaN80+jrtMgQI
	9R53VbmjWe3Y3F4AmuIDoTRuLbXXGwV9RjB11uUAiJSSn5BxsUYdn/gIJcplhTE4eoVBScTftc8
	wumjoKwUViNaqnHF15nzk0M5rm82V348m6NKUL1WzJNt0SeBjC+xL6VPsSQZ/QQ==
X-Gm-Gg: Acq92OExCoDWoGuwjH2Bqgk1XDWnbMGx/ExDZwpVeip2hh2YbDSoVwovfwScvs8qig3
	gMq95ZRNUJ9TGEQ4CY72ItmoXtgBvmgJAog2o8MK91jizcCtQH8G+FKv2DcOyhLltDEjp490opV
	xjphiSik92fZdHuc4msnUNOYHoqz2lEq4i7nZVciC0d44yb7yqmzFHO3OoFvq2Cmmsw16VE4BYg
	txEJcmXoFyPloPSZ+eu0PSQPrzhVsx7oAcQH+WaQ2TvZy5oMVc7L8j1VTZQYgrDYieAlAtdrjO7
	M+yD/Z6gCUXYrkIVH6dkH6UkkwrFBTPrsClGB6cnwsG3tP9KcRLWPxAXKyxBukrkk6I9mSlXSaN
	oK53pqBkisvtOmyVvjG/R63cMe+hVQ4iQg/R4FpsgCK4tOUqjJNEa06QukFKnG5kOiMMya78FFK
	JhA1kPcZlXjVuyVQ==
X-Received: by 2002:a05:622a:5818:b0:50e:5e6a:c7d5 with SMTP id d75a77b69052e-5162f447e81mr62623651cf.1.1778749872290;
        Thu, 14 May 2026 02:11:12 -0700 (PDT)
X-Received: by 2002:a05:622a:5818:b0:50e:5e6a:c7d5 with SMTP id d75a77b69052e-5162f447e81mr62623481cf.1.1778749871750;
        Thu, 14 May 2026 02:11:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187ecf7sm494479a12.30.2026.05.14.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:11:10 -0700 (PDT)
Message-ID: <048b1110-2de6-485e-995d-e328df69dcb2@oss.qualcomm.com>
Date: Thu, 14 May 2026 11:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: rpmpd: Add Shikra RPM Power Domains
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
 <20260429-add_rpmpd_shikra-v1-2-fdba28564380@oss.qualcomm.com>
 <e032c072-57b3-44b4-84a7-5aff062b9c00@oss.qualcomm.com>
 <20260514084512.q5pzh226zdkuw53f@hu-kotarake-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260514084512.q5pzh226zdkuw53f@hu-kotarake-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MSBTYWx0ZWRfX3VNpY7WFiOV6
 ZEOLSMBOE/spa9bTjJFYBvvgsT1sND2bZ0XiTpmDujfg5hgr64oaCF6eWwM83KgpL+/adXJVwUp
 ZyBAhRu+d6O2wquMZ8GC8dwWqm/FWeLFwarvF1XE9wN4rhs1rruhRpiGj8TrTSrT0SnqbCKk/bG
 FWPcQxeWf8roRrN4CUVtLUmtrJcaINtmop9ZZSFRpnk7vtZl/dB605VO6YJ9SQcrOvULzYKCQUe
 VtrHyNgw9UqcwWUDYy8RmT0+89bl0qbldc3CAAZ/nr4nboReZx9dAA1fbdu54Uh3TqqaYD6B/Uy
 TUsmcEZjRYDAmhKdsSlrYzYLEY4NP1+wvrmx7zsORn8CC1Mme2DSOLJOejEYJ0/O+My1pXB3qhG
 NmmgG5dzzHIyXARk1rivUX+C83COxITRSECY0/iBKKNaw705xtXIOMlsa+h9SAVQPb3+/vtowU0
 gbciJLklfDmceWuAbRg==
X-Proofpoint-ORIG-GUID: Nf6PYKUOihEdxeE00dr5QoXklomDauXd
X-Authority-Analysis: v=2.4 cv=N6AZ0W9B c=1 sm=1 tr=0 ts=6a0591b0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=psDV2xRu-4Ixecqm65UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Nf6PYKUOihEdxeE00dr5QoXklomDauXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140091

On 5/14/26 10:45 AM, Rakesh Kota wrote:
> On Tue, May 12, 2026 at 02:16:07PM +0200, Konrad Dybcio wrote:
>> On 4/29/26 4:09 PM, Rakesh Kota wrote:
>>> Add RPM Power Domains support for the Shikra platform.
>>>
>>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>>> ---
>>>  drivers/pmdomain/qcom/rpmpd.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
>>> index 15a11ff282c3f86b1e86c6604d165e297620f6cf..6f751ee5a7833912d54d2bcfd5d85837ab7a97d3 100644
>>> --- a/drivers/pmdomain/qcom/rpmpd.c
>>> +++ b/drivers/pmdomain/qcom/rpmpd.c
>>> @@ -863,6 +863,21 @@ static const struct rpmpd_desc sdm660_desc = {
>>>  	.max_state = RPM_SMD_LEVEL_TURBO,
>>>  };
>>>  
>>> +static struct rpmpd *shikra_rpmpds[] = {
>>> +	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
>>> +	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
>>> +	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
>>> +	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
>>> +	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
>>> +	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
>>> +};
>>
>> This is identical to sm6125_rpmpds. If you're sure the list is correct
>> and complete (no LPI domains etc.), you can drop this patch, and proceed
>> with just this change:
>>
> There is one difference — the max_state for Shikra is
> RPM_SMD_LEVEL_TURBO_NO_CPR, whereas sm6125 uses RPM_SMD_LEVEL_BINNING. 

You're right

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
