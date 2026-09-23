Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF4345740
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171225; cv=none; b=vB0kux7PE5tOFeAnNJICITyoIflgiRWrH9zuApbV8VF6eHAB2xJGmhPDm8yfzz/axtuCua71lROVVJeMbc8y0icQAiQPg9zMnCHnbClzQAq0DB/u0nWlatI2QByh0d16wiI8Tiisdi/kUTMHwo12RPF4HLkbryi1qHVwxLordE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171225; c=relaxed/simple;
	bh=r9wwZRXRDoUzEDe2iV2KAxJurfwIq0DoD0JkxEj7dxM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=an7StqoebzxyfNwnW9EMg4m8iAJBG0Qlkeab1VNy7skV0rrTB4mtlnDJYhxW3d6yZkvRZJT/ITHxfZMbSd9BroSTPrFrBxRekyX4Zyg53YvItj+c/FeqCB5LsoWzKuo1orZNOTGdwHKLit1o89/ZoeDtC3fBVT68yQjPGAhvI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hC1fnalI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NftXghvT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hC1fnalI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NftXghvT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDL2sq177191
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 13:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	geGcssYpsGZNMSCzxFuphi8z+WGP8Ft2ZgUpm885Dng=; b=hC1fnalIMy1vVG3p
	oOUAFoNdlRl4ndu9uMbs0/6DUW3ySALDqKDq3OeWRAKhu5I99YbK59fn288mdRTp
	f8gAZrc71pqO6vh2UQH2OYCOA8rC2PizmOykX1pVULnKbwP0WTkjV2mJJeRYNOua
	uqSiS5OqFY+jR+kEdbq2L0av7uJE+QBKMy6FkoLVOA0kzoN9rrTG3ipCW6wsXfFJ
	/dwTmCYm48PDj21QJLXDpM2JG6mve+zLffiIqKORAUWYuVEFoY79/acZc8+ILkP/
	Z2cToeL0cObFC3gX5zHxaClehl0Sv2qxnJY/PkbN5EzzbYBktS+IgDVghCsH4EZ4
	5xvR2A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxr3a0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 13:47:03 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78580a6b2fbso373447137.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790171222; x=1790776022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=geGcssYpsGZNMSCzxFuphi8z+WGP8Ft2ZgUpm885Dng=;
        b=NftXghvTNG/0HlWnIeB35NZ7mGX/WVs2ohbSGSfwm41f5tMfGUKuKBxTlJrY/QnXwy
         KJCmgnDX7qQvw9HKOjFTHgcbi0UspFGQAXB0E1PC7mFQHykwXXC1PbYeJBsstUvHhGBC
         bLK1ZZ1DBCtUvlUhR+/8pJ9Ca8qn622WO8olWMx4dYFTfbVDtsZin0Hw0BuDOzTBZoTs
         Lt7FdJTbBXcJ6Dn+fdbs8zF008lhcv/kJbiSJVEbnpuER2ACDBbNu7QipgCZtN9keKkE
         L94oBu6eY2Axi+M1AWstI5kUtMb9+M5DTs7DibPbwj1liX2biaC8gieJq7wcXiHnPiIz
         +kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171222; x=1790776022;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=geGcssYpsGZNMSCzxFuphi8z+WGP8Ft2ZgUpm885Dng=;
        b=N8MORqzPIhlbOAHwo8+5OSNKFmryYSBWYGRHCvcZaGHrPwZ2FnC+5RmjFi/B3GDJ/3
         uDdI1HK4SZ8ajd/+e7M/jKnnPpHoZonDP+CqOjmggJe6BDoqujMTVbUoBPy5TNlMcIKO
         y2NyAQGvysNl6yqNxUBlosWkQWIyHZEczXEW8/wdwjQ2+iloclNq74diasVk7wWCJKKX
         4itHgAF3yv3PW5mHh36lg8jzc9bragnoi+ewsPEXJ0OrPYRDcE90CjeRP8+iFY+zAfWu
         mUM9IswqoMbYZUWlOXX53dwwbAxap275TzzfCFkdvleq8S0ifj9sUMaVRV/HWnILnFgG
         8OrQ==
X-Gm-Message-State: AFuF++npO0RdFUkSp1/Rkm0WHAi7rS7TRcAw5jzn4OdaU0m40a/iV45Q
	niEFfFPGbq8TVxDMcBWglFFFWxASxbZYnJpJuUgTBr+79IFHaGeoild3pT6z7LliP8x2UlzAxVs
	Ohnb49SoNlIwfROzNQrb0SZAtE98BhjNU55RZIGM1GZkdACNWfowy5OyqU1x6LQ==
X-Gm-Gg: AYBFou1fnQuL+sjKjrSF9qiag+5Y6cr3WPcAv2UfRxPpva7F2yl1MRZdSV2P/CHE8n8
	EQIACsK7Q262M9mwfq9L70+O6P7Bnis1Q7/bSZ+zLHbP8VQ+PcIvHxAmx7vsq2R4mGQHQzrKng+
	mn9rLyPhguVJSD2o/Ed7Dr23U3vKU2aGjrrxzXPfY+Iudamno9tpn9upOugr7DJcbQYZ+spEfEp
	XHT2oOmX6I5fXOO9b0GX3EKu0l1W2wCf6L68Ghw14deIq/D1DunYeC6QVaZ8YC4/Dt0J0wMJdNN
	JvLi2q0OMzQWT00/KGiBj70FDobZPYW0YCEwbKlftLuRpp2RbdmtvH5hE0d0L18GNolSTSjdAXG
	FIiFwReDRLCNlaTLymlz3VbDqdIzHnA/sLbzWYi47uo8lrP/u0WoFHyZd8XQUQqyNkig2WtzF
X-Received: by 2002:a05:6102:578d:b0:7a1:f980:e938 with SMTP id ada2fe7eead31-7ac1cca4150mr2099967137.20.1790171222536;
        Wed, 23 Sep 2026 06:47:02 -0700 (PDT)
X-Received: by 2002:a05:6102:578d:b0:7a1:f980:e938 with SMTP id ada2fe7eead31-7ac1cca4150mr2099948137.20.1790171222130;
        Wed, 23 Sep 2026 06:47:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a913:ba43:96d7:743c? ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c5c41asm48190155e9.4.2026.09.23.06.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 06:47:01 -0700 (PDT)
Message-ID: <f1019e70-f3f7-429d-90e5-c74234dc5cde@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] powercap: Introduce generic hierarchy helpers and
 selftests
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
 <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
 <350caba2-4a95-4945-91dd-0be89b2d3e22@arm.com>
 <71932f61-5721-4363-b163-427432fedab4@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <71932f61-5721-4363-b163-427432fedab4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0XbnpxK8SB8IuO606RJePkvml6fveFqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NCBTYWx0ZWRfX4nf0T56ccVa0
 TCJbGv/z2FZ2onnQO5yWWU1EpM6DVPmNpVH6PR/rAjbGNwdliXzXZlhEJdYyuUzkgpolHFWRo3R
 4n7uKQOLCtIBgUMx0ZHKRkAx9BHQhqKJFijR/RXkdEl9A0Gzr8TqxL5+eCPgQ42zf/aTALMsE0/
 ZdC7dIHtMP0/v0Q+Kv47aIw51OLr+xOBvHoRH2WYgOj4ZSUlkOw7vi7yy/dBwYUYCLWp7L/PxXX
 2P+Xk9MI0p98wct+kQZItooxbDP/OXgydNa4I7lzuHMNgsnLn3M0pzeTY0PqpjupC4VAhP2e+W1
 r2YnpkGmpo8FNdJJkLd/0dKk2apReRPK76fEgabDgDO01EYdQZzbOkaG732JJLnBQG7tZyHBCBs
 3brBZ7pLwaIYy0VURh4ltRwRAswxhXkIeArAHTZpeX8fIxoP4fFkm3BMqVDZVdm2DpVGJaLfKv3
 KPmxXZ/C1o7/nO4Bmyg==
X-Proofpoint-GUID: 0XbnpxK8SB8IuO606RJePkvml6fveFqS
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab3d857 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=-dodW9W5Qp4Lww_EinkA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NCBTYWx0ZWRfX0nDuWMe5jJZT
 Zb/lsK8+vVYW1/ohNBk3WzFybfVwcHumcROXJreJgg8XzSytlLdPbrsMhMBJAMeXCu4QD0TWUJS
 4gUJI69ryccX4mFJvEABg2Q+U7XR8v4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230054


Hi,

On 9/15/26 12:54, Daniel Lezcano wrote:

[ ... ]

>> I can see some potential improvements there.
> This patch is a blocker for more changes: DTPM, powercap cooling device 
> and SPEL drivers from Manaf.
> 
> It has been tested and there is a selftest with. Is it possible to 
> consider these two patches for merging.
> 
> Given it is not a fast path, improvements can be proposed later.


Given that there has been no feedback so far, would it be possible to 
consider merging these two patches? They are currently blocking further 
work.

There is also a selftest covering this functionality, so future changes 
can be made with regression testing in place.
