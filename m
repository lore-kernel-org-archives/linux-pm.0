Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A7449990
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457386; cv=none; b=M1UpmMs4EZo5wKy244UAcKX+uxXU309OIK0EdtkcsdBSFL0zy5c39pabo5K4O5QDuvQjC6rCDvHfAfbcJjsCN3ywAZgECRaCyPZGIlvw/JU/Ghal/p/ojwKc6mcgjZJ7xsWMHg+poOwRQZ1l17N3bFqJM/Da0/U5O2m/PObdOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457386; c=relaxed/simple;
	bh=fPNu+E6yUnEgXieWMqsixjaS20gWVDpNfd4ZMZkRq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+KDDrAYuGzy9yEeTLUYPbgbJRD/drcMcNu0K6xgW7lr8+NKS4cKjF07I7WB1jduyvLwCD4duGeIhLyPLc+83IsBuxb7vA8AlEAQmFt/Tu0twaNWlwVkEC8mS2DuOW1X071rx/KW9z1DntbBHpeU1jR7GHXHoVdNxDX5UMBROqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRCMO5EX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=er2RvO2I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRCMO5EX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="er2RvO2I"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXKNg1091751
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PBqYbjhKCK4GIgjl9hdsBv5N
	7fb3V40anIzv18fXWJA=; b=WRCMO5EXN46sYDyiRP/sxseWkP43KIDweQBYnX62
	r8CYPK8CFn/KuP4atfyanAKHJQRRsO0NofJdmZ4xMMXwsBZxdcqKmLD4AOwRywIf
	xAqWEtxSfo/d70DdA202V2MaAlj5b4rMU7ckrxgF264w/G1ykr1JUERXo+GMOPoy
	fzD1JrbJc6csJwtZxVumchlxGQZ5ZV22etkS4JtijRHugi3fGY6f/3lIyyVOebbD
	bkHbvLZcYwhpveyfSSqUWgE7vXyaKTBv08H4MQ4FDat3Vzsz/AOD3/buHhdDwePF
	ZColdP1wqrJnXDpyfoDzgv6jOFQKR2gm8sol4yV++71Few==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049eradg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:09:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfe3fa93bso9634371cf.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786457383; x=1787062183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PBqYbjhKCK4GIgjl9hdsBv5N7fb3V40anIzv18fXWJA=;
        b=er2RvO2ICQxBpY0ANfS/XmckDrZX7pGQFqMb9ckWttHAwyOI29UOPQ1rVgvJtNqPzP
         IEV8/ipYGm6Y837Su1G6J3TZckVLP4zaf802Qj/o1HZO+WmjbaHjaUrrb0UCVYoaApF/
         WSXKhQ5D1sbH1JE0DSfN5z24/d8CCofcxv0s1cCMFxAcmS3eIUl9wkUg6O/TtuzPqoQh
         3YPJBsIe+WK+LL1CBAlmdRVStGM7oiFaQLfIkB1LWEe2NpStORMs3ADt6kqUIHuwKvTv
         BtF4k+ECEZKIkvfjz7Z9NWfTZ27k2sOtpP9zR2SPYoY58wGlFX/odZkuagz4DCzEwKE1
         /6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457383; x=1787062183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBqYbjhKCK4GIgjl9hdsBv5N7fb3V40anIzv18fXWJA=;
        b=KKsTRKoxbJTzttdnxfTesC4Bea1FnECceKuzjQJTotXLMbE+mcqv7KdZR9G4xAp1L6
         HB+ZUsQjWc1dN5eA1AuLpCeZHdTqCe/8UZiQsRTURS8NTlkj4j1JrtyiR9NZbznlbuL1
         kAdK2afTBq7Ugwc+fwvZbtU58dFu11Jm8dzrTY64ySUFXSxuCcNSDv1atv1vfXSNGpQp
         AUSEyWyqWloD/sDK1uRec9og7NpX8IBzUCjpxLnw5nPVipAjfpXBOAu7ud1nWzxQZ5Vg
         NWHPx/jV+fcY7rwCUJ9BZk4ed/0Hg5jcsPz4X/LwTxkjwF9dl1T+JcoxGwvzQsSzw1cf
         k2Mw==
X-Forwarded-Encrypted: i=1; AHgh+RrNYLKVpWhdABzfdL/cNaaupq//XiHr3RJ3Vl/0gIpdQn5IAZcxDWFgQdr/dNz3cLzHfOpzld31Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMycDnJH0G2Hkb61mppCxCjoIy7AwhNK2j2BzKwKaBAlO//FP
	cOLyn+EYCKXqQFdL/NpXVmpSs0buLi98p/0cYbe8ql7TiEPe424d3ozqRfjvBkfNVHkKLPOYP+K
	2bIQREu9IxDdVmdKcrswpfbgKOGf2if+OJsduR4TIj5poGUjHERpHLj5vKBj6mQ==
X-Gm-Gg: AR+sD11Cm/t8s1TSWwUnoQKZ6uqDsp2j+3awjTgFJSIlVnK5MiPlwWqUII5GlgT+U3q
	lHtopKbDS7ACBAgJQe9DVjTf6nkIKf2r7rcXHRLBf7RgTlnI7c4ab+SjWEbIbolZtVdAqVw7/ju
	aqV1+ejbOMi/4VVms6VVGbx/xAlFG2SmnywhGl2P7Trw0MbMsELzMbPt0S+Ofk8XacLzBdSd8/b
	ZelHcK+WC0I4uZxa6w2NcN+PslbpH2K/tS9I+lKE0QPryIoLiKxNXu84EKVby8Cy2Yjlm7rKxRV
	VEGhYsaf/XyLJqlLl/oWQBKaicGAyWl2K45V8pyWUwKihGeDFP70QWOz9HX3xVLeyWiBXsXTIT8
	qsTq2Zc2jLkuzDfHZF5QiVux15LiUw9m7eBYddhgMm7YoGwWC1LXHnkEKAfPA9LfnuegZQCE+wd
	NpKDNxxk8YQMCspA==
X-Received: by 2002:a05:622a:2d0:b0:519:e020:6087 with SMTP id d75a77b69052e-52d600db4efmr5352491cf.11.1786457382727;
        Tue, 11 Aug 2026 07:09:42 -0700 (PDT)
X-Received: by 2002:a05:622a:2d0:b0:519:e020:6087 with SMTP id d75a77b69052e-52d600db4efmr5351211cf.11.1786457382199;
        Tue, 11 Aug 2026 07:09:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4486c0505sm316739e87.6.2026.08.11.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:09:39 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:09:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, quic_skakitap@quicinc.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel test robot <lkp@intel.com>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open list:QUALCOMM TSENS THERMAL DRIVER" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/qcom/spm mbg tm: Fix missing bitfield
 header
Message-ID: <kjsn3qdfvvwuwv7sqqbczrtfc32d5ycdygams3ajpzyqxlbqgg@awsxd4tluphm>
References: <20260811094935.2941313-1-daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811094935.2941313-1-daniel.lezcano@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfXyxG947MSTprN
 oAnwtD76GM662poGezW+Ye3yoNgWCY54s1mKXsoq8WITvpaLMSk3iUH2DhGAo+rQbnH1GOzN4mf
 F2T5GQhkJTe/xP6vfPkK6m0QGNJqELM=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7b2d27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=WGM30ylFM8xG4-sDf0MA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: nvfxbNsJy9V5scfOGOzdA0v7RY3cbZN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfX28duyF2OumaG
 Yux0sw6DIORoTbXjajx78TvCJdKwLTw40cZM9Z7xRIQWZR/YnTRqBVJoN4nXJOCNZrHpZ+TMWYi
 6fnhSVm8D+QYethkmHt7/9HfWVHM4GZYX4z6bAbiLTrSBaaaeAUJzovbP2eXzctB9KN7/kQ2YEm
 mhPdGRxHxTvlAkVpCafJBv7UVIcZEHwsmwNI2HPv2VvCFXo5bcyQceT462uRLLFzLMnRs68qheT
 hsbnKnwsu94m7DlpzLG+/Se+a8/ACjiei+hhWeKH5LXi/snt5PkJl3bHJdfdH+5lzRFHZbu+WEN
 iuL20t4vQ2KqodGWFnda01rF/LNsSvWf6LqmiT1MjnrTx/lfSP9vd4ivdr9vqPATSOuSNGVpJVr
 0HUXfudTNZUpf1y5wrirUxKEj+wNc9M713r6vNDam3TGlM3EP0RQQXaH+iVpSLw7bSptdiGqWdY
 CR8ltKBt76ciIf3wP9w==
X-Proofpoint-GUID: nvfxbNsJy9V5scfOGOzdA0v7RY3cbZN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110118

On Tue, Aug 11, 2026 at 11:49:35AM +0200, Daniel Lezcano wrote:
> From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Add missing bitfield header leading to the error:
> 
> >> drivers/thermal/qcom/qcom-spmi-mbg-tm.c:184:21: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
>      184 |                 if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR)
>          |                     ^~~~~~~~~
> 
> Fixes: c3dce117333c ( "thermal/drivers/qcom: Add support for Qualcomm MBG thermal monitoring")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608080800.RfxKb9uR-lkp@intel.com/
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
