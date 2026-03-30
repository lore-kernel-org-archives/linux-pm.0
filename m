Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF53002DF
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896290; cv=none; b=WfiduiUA0Fjl2gKTImBDHIydaPIaMyCJgkRPbefag+tZrGdesiuttX8CdXly5nQOMaTtBG8kz0U5U+F4yqXG+IcIcTgw9873OeODbPBH6/E+irfHe0SL5kK4krwKVFhPgmTjXlROdIMEQDjM+20s9xd8su1rvl4XjYrhDyRVUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896290; c=relaxed/simple;
	bh=gXLvk9dwABkJboVSApMGx/J/bEviA8VAdA2daXR4ogI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3noB/pZ4Gz5kk5eGSprdZ/4/pcPXkBe9oOJbCaBSsAvKfnxCnrHeZkEdcrFJ68SJbuRH1HU08R0V0wxMd5CD+0uUAZIXhfKByHQzs8daVwFI3Ltnv/X19t05+nYRrwjd58aRmb1K1rfE8rWFHGKjGc4gPHktAK+Kv/+T+MO0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ksY/POPN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGba8TzC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ksY/POPN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGba8TzC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UG3W5k3173906
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 18:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=U3BypvaiCzdl51LZPnxaZahf
	WScLov+LNP9bnfOVtuA=; b=ksY/POPNE/1HtSSApgA6Wqp2dVJZtz+Do/AeK7Fa
	NEedQBsGiSj667F1q2lo28YmuenIN74OjV8v2+g0vHsOK2331050pcSBZ2PrXR1x
	mMSkEthlO+7IzurTyYjPNywl/EG67aUUfrCTDZzqbSKdnsPMhbGJnyRpAWCXmf82
	TBEvtj3ox+/sLYozrTkimfpSB4krxO5f3diROLCGKm8rAv1awr3M4lAub7DgQYd/
	IwgJpvV25+RKEfvu3zbYLUggDVfvOJvRZOVbvTf+DB5oJAjG11JrH42P8gdYWPfN
	7PREuajkpCwEGVIpajTybd0JiUUn8GT14VbsNdaF4CErzQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h2043-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 18:44:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50911c94db1so117913401cf.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774896287; x=1775501087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3BypvaiCzdl51LZPnxaZahfWScLov+LNP9bnfOVtuA=;
        b=XGba8TzC5PBPOZMs3Ux8RdpvgZ6xPz/JC5abxnGRMD47Bp1uDFHmmrghD/2+giw6QU
         Z3yoio06JwvVqRGdWYkwSsVYtjvGBKkYLD4pTjPtmvWdQz6zHIP8ALkhpNdmIQKHcNEm
         SUIHRLZnsTmk2+H1vjMMb42JSM76hVmil9/cUChh1GHUdnbqFExXrdX512v51XCqDwAN
         4+wcd+dT3HExjAScwZQkQndLcIT+lNhnfdIUpVnbsYWjq7iR+7FrgdpVftbHzdmoae5T
         7xlszuw6aCuoIPm1Jd14LiWygYNohJF+0ghsHTw8TpvNLtgK1qegZIsN1xyr4NyJiH/8
         tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896287; x=1775501087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3BypvaiCzdl51LZPnxaZahfWScLov+LNP9bnfOVtuA=;
        b=gdF1qVK0nP0GalJsjIkayWXduT59MylmRXVRKAnE9HZ/cpeppeBj83OJ+KHqUKPRnq
         DNUl3jzZtWYltJpXAm0hNOhUCKo1ed4THGAbw6amxOcWCpZeLL9FYZyA1uRd7KZ3k6xz
         BtPPZzOZavuGkwDTlJK7tZbZn19V6y2n2z6cV0iHeDQIF7HyvKr5hVsJ9CoQFvr7Xvh9
         T7z6+oDUE9qkz7P4PbjZEBAGDnRS/S1J9BU+mdiy1AvRSvx1btqtK0VkftUrf6vls6Px
         y1VGyYzF7DzJBsoW9gZnjBEhjz+GWfPuwbQSF5UgvZ+cQZ01qisuiMHYyIkHiUT0YUZt
         HPKw==
X-Forwarded-Encrypted: i=1; AJvYcCVarl7MPV5Hn0x0Q0Bb1vpUePQg/iikD7eoXJ4+EmF+Ui73IzpkUYcw2WbYmbk/1/lz6ERvT+cmnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPK6JdGX5N7rmpg5dhE3+P+GyFHBtBOFG0TtbLzK/KzsT4wPQ
	lUs2FQnQbxYzttZG913pG20sE5BeLsfHq2SteBV/yo9H3vmEikRjUfHtdVxTechjn99fnA1V0wB
	/N6CX/9YPIIKJjwGywY3Zh5egxLz8zs5PLno/0PvZY/P/GdRtXRjCU1TMv16dLA==
X-Gm-Gg: ATEYQzz3MjxM2oNSRCBelevS+pPEJnnaG289zR1MMZjn3nYZITKLqzuJi2n+JP+9b9/
	cZZhVAUy96U3zv0yGFnVQkL4sjIDSryQdqX6N/3XCRn0Lh8BIhTDdnnoBRWJ7p+D44YeD903zWT
	lt7vpPPUiD9o6xzHfWfwBoo5YUktTp/hJtqmIl51lAuF9Qz3PDM04sOBoNq8h/YB3SqPaDr9DNu
	+DOhbeOkbZulGCdF/IE50Aq5kzSG9bYbZcFUE0Su+P5iTnIUpFM6kiSRDl82PKbbPb6KxDfvdQX
	cl3g+5zFrw2PrxqjR4TRdmRUJ6rT4aLp2VJWJ6YxBQpu5fNtstH1KX7BB3CDJjB3bVWfr2Jry3R
	Ej3MpMtNufjLS+E12LfRvWA/fBhC9B8AHaeBIlBFnZqVKzCHc3y6YW5Z2ikn5Y1HozPqXDq1tSw
	GF3WGq5EBPVOfdjVURB97Ydlh6GhGIIwEKjAs=
X-Received: by 2002:ac8:6f0c:0:b0:50b:2096:4950 with SMTP id d75a77b69052e-50ba3901112mr190709271cf.44.1774896287393;
        Mon, 30 Mar 2026 11:44:47 -0700 (PDT)
X-Received: by 2002:ac8:6f0c:0:b0:50b:2096:4950 with SMTP id d75a77b69052e-50ba3901112mr190708831cf.44.1774896286906;
        Mon, 30 Mar 2026 11:44:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f4373sm1904509e87.6.2026.03.30.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:44:45 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:44:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sdm670: add thermal zones and
 thermal devices
Message-ID: <eid35hd36p6xnwgztvgdemyc4yzdnk6vdeu6mtd22ap3e4wg7k@l3r35axludhy>
References: <20260330165237.101045-1-mailingradian@gmail.com>
 <20260330165237.101045-3-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330165237.101045-3-mailingradian@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NSBTYWx0ZWRfXzCd2vygt09e4
 SsmJU4fFrt4zieHVXvGKXZMqji4C97kq+r+T8U9VkDI5KV3XyjJcgQijAKhg33NwzQcn2Uyz3pv
 xLCldHPvvbYPVLGzVut/dEj/MfefCGFPvhxKYeelNhv+wjpYlx2NDvio0XGodaYutwsvdPEoNvo
 g+HxkW50F6b0AP3n9Qg3v/QUmOo8eIOLo3wdNfq8nt7IcXehPB0xd8+gLl2G4Z/dKJkN7V8HzVm
 SbUlPXacm10HQOdeC83GWyFTO0nTFt6hmgk0ouTNV7hHjOUE9Cj/D28BQdlXrtUXt8xBK5EgYnr
 z3L9qBxuy+MgvW4wC+SkaW403tKd3zN3tI1WfOSJPq7HVUxbtZ4NZejqbzu3lE/K4MGUry+0Qsn
 HYX0Brm16WepMznP5UmTHWONpTklbra5PXBvr3v/uFjF19gpPMl91gZkmpo5BKIkDGw0+m5apfF
 7Td42BrvGD3NKfXxmDw==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69cac49f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=M8YKDcNaA03c_0jmb2cA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Z_vohYsbYjzFFR1T1opc2LCOPCR7gw4j
X-Proofpoint-ORIG-GUID: Z_vohYsbYjzFFR1T1opc2LCOPCR7gw4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300155

On Mon, Mar 30, 2026 at 12:52:37PM -0400, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures,
> along with the thermal sensors (TSENS) and CPU frequency limits (LMh).
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 400 +++++++++++++++++++++++++++
>  1 file changed, 400 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
