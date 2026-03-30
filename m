Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81D3DEAD6
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896242; cv=none; b=rjYrr2V76ZE5GN1k7Su9oVs9w/9EcF9BEuQWf7fRcS0RpOdUStYp8mOn/oTLhin4bHA6jl0enLAIde3Zzu+cMD8qDPjTn9jnt+7xWWSS59d78s3YDIhxRKJo4DXw76jHPekEgpk43D7JaIrTExbAC6BmJ8L1+MUIo4jd0QYpg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896242; c=relaxed/simple;
	bh=7S74te/iaHvs9X36jFLbxBSxTSMIKGssJ56y7866vC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKIREAcMDRDKVec2e5ve4A0XE4jqtTR002YuZVSZPmDRYJCegholtAQq+feF18sXpskOSzRo2kitwehc9qS4fNPIRioA5GJFNTwoM/qeEjOB6gWYHOZAi1bJcEEOA+o4RTb/qomAlLQskXtHchJSD+M4tsq+g7uj0HtngGTMuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBU/Enpx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z4pm9gfG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBU/Enpx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z4pm9gfG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UH17E34014022
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 18:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0/gLIt6Ee4AwsPWRgQM3o8gl
	QvL8D3oR5sRGXMhyo3U=; b=pBU/EnpxrbO1qAYrTV6alchWS6IZvUXDAdTWhucT
	EOgq3gPtzBW6x3pG6Yi6qlO0nXkcnNwo0yOT5uaYUOYuPSfxHVrlt4Wa9lG6Fbn3
	hmUpVdGXwitG0s4gOPr4hDEDzTmQXwVveuWqO/zrd+oE+4YBtuuGywLh/Ma2WfQw
	+qanVdZoa+5ImKEt3trvLXJ3sGpWdZwGEvcw4RmVN2U8HRkW29T25gJI0vNks/US
	W3iScwxsfQagjtuwhltkhEuQ1V35pkE4VObKuX0kPacVIJl+7b+/GCwy1a+A6w4a
	71HhP3JaYyTbHMu+k/Hf1bmIE/lNk0VSqm5vNR3zoi4Xhg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regsr6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 18:44:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5093787e2fdso239918961cf.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774896239; x=1775501039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/gLIt6Ee4AwsPWRgQM3o8glQvL8D3oR5sRGXMhyo3U=;
        b=Z4pm9gfGFCCrqC8GnA/PVtd64Emw63wLvOS/+O6MVY3HN2luD088QjrWV66IxpL9r2
         iUakiRhf6QFSQt4AhMI0YJZyLti6OMnjcHKuSNcDcgpfkLPEeHS0NXrz3eaopTWJEiVF
         9/hSz6bmOxMgoC2vZQBipm5DuvtXnFlyaaf+rgH6SQ7BQq0aoBvq50ZgCyBKuIS+F9+E
         XY8MIugg6/ZaY1Ujwh04w35PXlsh8tBOmr3BwIZsF43Zor176/CejUoYO8UF1jV8g70g
         nqYCThjliqjj4ScSsVd4t4XqBjBJgu5Nj7IMPKNqUze8e7S2rn/EBR4RuaEa7YUyVqZ4
         53sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896239; x=1775501039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/gLIt6Ee4AwsPWRgQM3o8glQvL8D3oR5sRGXMhyo3U=;
        b=Ek4wbSyzSQ0jsPO8qhGHEVkxqbDuUJc9M1HrfDKkMsptWB43V7aNN3oZwdX56Sz949
         6PHLDiWAETauiF+QwyaqxXHPnFd+aNVzTRyHwXflfbRBTnvQ3Rx88qsheeoSbEf2ZE7u
         e20ONPX1K+JtEYEulUfQ4JUypqrSm1RZIntxeks9ZjDHYTD/bFE8qi508ft2ez7DlrGG
         jMUtphfTQFmIalJjbOFK4BWEoh+k4C/nIAiJxU5U4G+nDE4iZkxy2FfKpy9avqvZaAgF
         h5+s8AjI3Bv6H89lCjyNihQOhT9L1HMif8f76qA3WS6f+1XzX138kzHJX8FN0zm5kYIj
         XfsA==
X-Forwarded-Encrypted: i=1; AJvYcCVXT+zj+f0eCNxZ3GGIIOli3OVJI61S/hudClTA2VxDnb0qxAUqpKsRHBeDUy/YXOXv7BwOn+RbBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWIZfJF+8GMuxNM0OvpHzgSKhH74xVJtDPjQgEX1etkZheTl9
	V1qzTzffWU8+mPBzreutGrmDAMpnfdxBKv2bBuIoWjv+MZdmlGx4kueV+EFLZdXnDoGyxyJM9Jm
	rcMQ9WhenlmUhr2uDC9qDPuUgZI/FZQ1l/TvL2LOl4nstBBbNiQwKtmfA6NvcXw==
X-Gm-Gg: ATEYQzwMowHh0gJGeW9v02uZvFNymDZ5HruiVoOGADcG0NiS4uMJ4JhfdmlfQmBIODh
	X3kjXwGDlQwudMA/wda1A9NmF3habfHwXNdyakuHHOJEiU8skv1idrXIn6eTiOfdQA9vy8c3nGu
	tcMtUqtm4WSxlhbWJBXLsk7p34ywG2iGhNlYsR1NpoT6dOn0nPfH874D10C4R7HGi+peXCRLdg3
	U3BHj9rgYDm/f37XToFqLmoaNJgXTu2J+qMU6slVPjMAZp+Ps7cncSn/rZie7LJoq+pz1VlDbPY
	kL1Nqof4cpTLxSpicW2B3+HmlfxmMKGT8vj1KxrOUeb0qvYgDlfSurTyKOIHkwTLszcAlqJZ+j4
	lodFNseZ1vdQozGgOeVY61if0jx+Ljs+WpqaJik695AyPvx9I/e6S2f7L8WY2Mlo/gpwSNtTc40
	o5YDWiMi7vC5ZpwzH2tCZos0AGADWcSyeRySk=
X-Received: by 2002:a05:622a:4cb:b0:509:456e:a179 with SMTP id d75a77b69052e-50ba39524f7mr170166111cf.64.1774896239428;
        Mon, 30 Mar 2026 11:43:59 -0700 (PDT)
X-Received: by 2002:a05:622a:4cb:b0:509:456e:a179 with SMTP id d75a77b69052e-50ba39524f7mr170165781cf.64.1774896238931;
        Mon, 30 Mar 2026 11:43:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f4312sm1808455e87.16.2026.03.30.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:43:57 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:43:56 +0300
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
Subject: Re: [PATCH v5 1/2] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
Message-ID: <gelqawu7bhlhx5n6bc4oy4b3xxaqjehmove77dah5rnwrnfdlh@vz3e2vgvj4c6>
References: <20260330165237.101045-1-mailingradian@gmail.com>
 <20260330165237.101045-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330165237.101045-2-mailingradian@gmail.com>
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69cac470 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=P_9oW8mKO7fl2W-26g4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NCBTYWx0ZWRfX+js7lrScGa9b
 hfPMy6K3iLP/4SiGoojtOjAh2CEMwurZJ+xGfLOp33AeLLGpVIkk7DtCkQ1r+jt5YzEUrRCo1Hr
 9Ry0S6eg8CmS1NnAXH/oKGaWCYHO4cnS3zHCCGwY3MYCLWxYknJGHoaeikpt06v6Gf5f7pEm2pW
 4YlM4R1cHCA2mQERca358FM8A1Nyf9UbLYscgGtAtzXQxXUKKKWIvwxDe+oAt2RQ+/zzsegVhzQ
 mYjJ7431wODnWAZAN3KB8ZB3VPYSo2TjT9arN9xUcd2OqV3/tYAXKJ16VoWqgI1n5rDB9SHFqow
 DZABgnVU6iYSgXHOmXF/RP4KZiqFUOZLxwSeay8G+tbihj96nHLO483qIQRuUW9FuEenwMjOkY8
 6AY5R6yQ39aURKo3hyCWHv5EvfULcONQTpk/OC+0JuP72MkWx6yQQDozBT+4uKByTK1YNHSLLpm
 R4mwWVdU7vpsAVjTsdg==
X-Proofpoint-ORIG-GUID: t_YQ-4CYcIHZfJLDrOED94Qswsq1iGVf
X-Proofpoint-GUID: t_YQ-4CYcIHZfJLDrOED94Qswsq1iGVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300154

On Mon, Mar 30, 2026 at 12:52:36PM -0400, Richard Acayan wrote:
> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> the first 6 CPUs are in the little cluster and the next 2 are in the big
> cluster. Define the clusters in the match data and define the different
> cluster configuration for SDM670.
> 
> Currently, this tolerates linking to any CPU in a given cluster.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/thermal/qcom/lmh.c | 54 ++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
