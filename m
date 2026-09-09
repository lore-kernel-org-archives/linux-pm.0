Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743F56853E
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980408; cv=none; b=gwygyCKH1MRax0zY0l+U+VLRUcchUEPG2m9/TDXBT+wZUduXajGJls9djKhKn8+i5mdF1y0eljGaQbfbm5NAXWaD+Q/ZNn35m/fEJCvOpEWYWgTG5DuWc3hQBTW0u/kwlaq8By2IFS06K8U6rVzhaDJvcUycnotIX4JPDicKT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980408; c=relaxed/simple;
	bh=W+Y4C7lHQn13v7O++mmrTUHwaeZ7ipXp12hzVPadans=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr+Tacavg+VOqcc7ZT7Xdl7/LLN4Kn4aWuPTGTp9ZZzrDWg6d2YRIQUBd1oIDccXutd001fogoci3zfJTV991zkQwh3xkaoogIYE34wqxhE44mcF5yFCF2O8fspT3FFaWG768Nh/06TTHLjD7ShYQHyaI4t9WHw26x9bEZL0ZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TIh9tdfg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9bP8HEF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TIh9tdfg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9bP8HEF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689Igo9M1608465
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 19:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=88vmkQNz1OKcT0Fc3h/2B8Pl
	KW5uTuDj9Fb2OV0HY+0=; b=TIh9tdfgYQaKCg37idhlMd4IQXtIOer9SilaggD7
	vZFqsrelQJs4U0bfP0oykbnqysIa5OBHvnSneIgZZ6j8ZpuO0cSYA0rBPniSWTzP
	XcTqkzZ/5n37u6za5sPrmonoLgwIrf7k9WUmIvL88YrgUNQLvf0ZFwO76fjgwRaK
	X/D38tJlxn92tojuQ/bnmkHkFxxRqaw6zWN7X9LrdMmqdXEQB5Ll2aGcGD5ab98v
	IjszW3NLoOfVffhfulYDKZgXVJ7N1+/7tPEcu0rmJmLGMGBPY3eeoHWSeZBJO/iz
	XxV1W4oB1Jv3WJzU3GCoiGH6aTh+44+fze0AcCUANY7cbg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg02sk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 19:00:05 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-78481f4ba52so5550749137.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788980405; x=1789585205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=88vmkQNz1OKcT0Fc3h/2B8PlKW5uTuDj9Fb2OV0HY+0=;
        b=c9bP8HEFL86vzkh1TtDlP6Jo1qyH0jSidrMeuJKMt5KNaPJftqvjOeqXzZSBmCMAYt
         ygj9wPo/A59pIVSV28Dy4fALwcww1BrBaE4cJiF346CuCxjVtLWdWOgdGzC92ngaG6DU
         1lu1gOMsoHYpmXppKk+/HZsa7pvJhq6hvNf8AOpNspFCgdlqFcVJshl/BQTZPGaF+1hO
         Uaj6B1O9zCH8SS8w6V+nY9HVVx+U1YpgWOgCLUpgE9L+ZX/MBkcMTaZgArQvy/L/1Pc8
         +FcXSjGL3bmQqjPdwVWmkjaWAdi8cpxJvRQwl6qByBJ45TM/jGXqvXAmhbS4xTNkxEDV
         QFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980405; x=1789585205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88vmkQNz1OKcT0Fc3h/2B8PlKW5uTuDj9Fb2OV0HY+0=;
        b=Qz1rh1f3mI5LJWK0PrEXCOfQxHFvdJOyE8036OgMLhkdCWvTx8ZklNgfcghXJ23bdL
         xZhLzP376peZynxefk9NI2dhlH8wKbnTNoP1vHPuWPqOW33kNZjjK6v+Z30DnccOoc7T
         Tg6ZJccYzSsQ3YzANmW4zxili/77CP7hX2QMRw7hm+BXoqPEtJAFlUFOZ9SpaAKZ1x8O
         N42HDebxNs820nx5ECJSZRkHVX9SV3n6SjhFTNVJeVrkqy0tW9xoYLv6Uy7SjQ0oHKiT
         H538vgoLoz35NKoSWr56zNKVy2JLFb/ofrxBdzmuQzbfQiGQT2o8C0tlhDagXUJEUYXZ
         Skag==
X-Forwarded-Encrypted: i=1; AKwUvBzp69n4UEOUGseyvYBGI/iQTdmHXXjLKi+Zcww99NLon1AQb1IkMA95aqRxTFSq3lspd+B9SoqTjw==@vger.kernel.org
X-Gm-Message-State: AFuF++lIfsG5cPIE9YLpd12b0tg7p2DHF9EK9HjsrpWcOU76By09gvzj
	qVar2Glsxb7xfBa6eDecE9eAT9jrDbAhy7KGrkhICrH4SKdwLWsyWOEyMsUrrFFvoFD2rHMrvsV
	Hsvna0DmSyqSvcAeDsm+kg2XVU/LUjfeGkT5y9ijaKkMHl5oiF3WXG/XhF0/mzRb1qKMxNw==
X-Gm-Gg: AYBFou3MQTLcekIlZhkHH9bOckryg9hQMnt+QbBgUT9qMPkxSXTGPRS6l3jkkOHMLr7
	oo1vexrqY37ghwzAtT+hDFlFgsKAWUrw1AvYPLvdF7Tk/QIJK/uosnSf19+AJqshgYOOPVbZLdz
	R0gRErSlKGrz1vqV/DH6X7R7KS6IUjeRgu79dkEuDrxincmK222Y4KQRXjMjLD98BUUH4KHJSVA
	iyWJRB9wFOtQPSY8uLiVqB/EUk8MbLjLUkli+d2rSB5Rr0+0UbsKDETrXvFswHZHQYX17JLXGyO
	y8lhrKt8iwMQWTBAdyDpolG5BUT8ANuBYsUY58Foihgav3/VRwJ/UudZkjUgdYtX4D8PiIAqyBb
	DWIx3xTlMDpeUZPSMcY+/PQrS6gDzJCbAO9jVfgRPNSPbFQfuQx2m572COpijywLIaGDE/rKi8X
	o7GCYIJ6+mDhDy
X-Received: by 2002:a05:6102:54a3:b0:778:5bbb:b2d2 with SMTP id ada2fe7eead31-7907882b3b5mr1538086137.11.1788980404723;
        Wed, 09 Sep 2026 12:00:04 -0700 (PDT)
X-Received: by 2002:a05:6102:54a3:b0:778:5bbb:b2d2 with SMTP id ada2fe7eead31-7907882b3b5mr1538055137.11.1788980404290;
        Wed, 09 Sep 2026 12:00:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b899b012a1sm157308e87.53.2026.09.09.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:00:03 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:00:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 6/6] interconnect: qcom: msm8976: Configure auxiliary GPU
 QoS port
Message-ID: <fzowmjp5r4cry3wdlxejdsm24jdh4j4gzbbndbdf7ydqq2vk5p@lx3eb3q7o75c>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-6-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-6-6dc5b5e97626@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bMqDs/+Z c=1 sm=1 tr=0 ts=6aa1acb5
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=FHrIvcMS070A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jW8lGn9s46bW74Nh9CgA:9 a=CjuIK1q_8ugA:10
 a=PkAOt9_mmfBkvtOLxIEI:22 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: TKUzakaSKWAlYIJY_qBmk6Tzj4toUeFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxMiBTYWx0ZWRfX2QzhSVGPbPdj
 2thP0NKSur/kf4xQ3pKyM8u+Un4RjVSWITIj7U0ud9cx9HAj2Nnxpe5eWtgTd2GeL40hjcTnxbj
 ReiCWx5UwvhnueoxNdOEKzlwmdhSTVElG9r90x95kQWqucKJlzA2dqIgMX/z0uAR8iZWhQEduP+
 GENBytIvSJfl3eyQsJ5VgfCUDs3eRXVdVYlwlWBzjC01ax9KJeB2bX5pHDndLiTMlNPz1GV8fgu
 L0Zcd9/0/tmpLnrs/Bz3AH67zdNbXY/Psy3dDDAIQWGDGszn6CYQl+pLmRaF96RHDOnfV5IC1qa
 jsuM5RVg5M5qIv0HQYv4Ad2yvdVLIEwqusxy7EtbabdgLXq4JsjeGmYJiAoIZ3qkWyCJmL3HsOg
 aJnSUxD4SfTsu36RwjD7NH7iMVR1UFZ77CNKluYqPgzswvxIfGxHdoufgBvNdU+AVAxGaJmyQx9
 udlT+n53CFmlPvUI3yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxMiBTYWx0ZWRfX0jl+FSNT5y3O
 Btv6lIIvvQ5kHk7MHbXqkO2FAPbB0WMNy0nCkpBKUDydkAReLdzOnta7xRGR6iorCDeE/FgUjW2
 kfDqhoZE6ZUGJ9aJInPf4a7Wjpanizs=
X-Proofpoint-ORIG-GUID: TKUzakaSKWAlYIJY_qBmk6Tzj4toUeFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090212

On Wed, Sep 09, 2026 at 06:41:59PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Enable the secondary QoS port used by the MSM8976 GPU node.
> 
> Assisted-by: LLM
> Fixes: 6e3ea1f36b10 ("interconnect: qcom: Add MSM8976 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/msm8976.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
