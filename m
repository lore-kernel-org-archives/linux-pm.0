Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67D282F39
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675669; cv=none; b=fdHPWm4WR/bU5zWHD62DMSFMQI5V/XGKeYu+QsoRbCZKAEYs6baUyhYVW2BgmZTjb+vqYY5pgrFmHZdl0CspaG5X1VE8R+zJYiXJY4CIyOQHNdVStH/GN1OtRyOudM87UdULByW6pwcl9Fttz4AF9LuNH1P40uc2xielZvXIYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675669; c=relaxed/simple;
	bh=O8yto55xNnTzWDdCC2lltVd8Df/jo2x+gU+MW9wd6zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZubF6BUvwcPVYAgBir6QoOlRKR/grc2ps/FwsA1FWGSLZ4TIPNMnHUPSK0YzPBF38rSLzetRfUY6ypvia5wtKvk0hBNomiJxrJUrHwFLMrRuZl2988BvfY34iLaHiDH+E0TE2OwTJ2Mv4x9Bb0cKqRNJEflY7q4OYA7kzLR6t/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdjPBEfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VE/QSGo8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdjPBEfe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VE/QSGo8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GA46ci3124546
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tocmhRpILSKZ2dIX4AfeiN4F
	0iPi2NKdx1DQyp8RAsg=; b=gdjPBEfeIETpGxhWDO6z1HZzwTrOyj0YHHLATaUg
	tLnaMzU/SlgewhMOphJ1Xr4BM+NViX+XeCQwdIR4Rgn5juduwTnexQXIUDZVz7le
	LypVXRVt8ROonl/xp0MlUnZVuVj9QYzHnzltPR8e13GCu4/SiaBi7T5aA4GuoBI9
	KqfWhx05NxT0BQIq42/evjO15ZSBcoGgrn75M77izOWZhIBm7XG8KA8VxK9J7jQx
	6ppcKsgClmEbVZWQrsSAoRMIx7ooR1MN/4YwEAPc2Hw1CLRbW2Ah/fUggSTq/JZi
	gsGH9fle8/QxtlIyjRWfjGlrz5IlBWwpDKLAUjYxJJQeGQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxfsmh7fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:41:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4b96c259so67767865ad.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773675667; x=1774280467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tocmhRpILSKZ2dIX4AfeiN4F0iPi2NKdx1DQyp8RAsg=;
        b=VE/QSGo8AIu05esqyRuVFdnegOv1YYt7JCVv2NJ/mmN6Ds69za+SNyosHJvwDaWTXQ
         e7jCvhfI1hSdFqUMv5ObBQRTHqhfQFCzbJKuUmGVGU6PLGemVOvtO+k2XI/42URn8luh
         uTLOWMppNd4kd0IdlO3G9njvAPdX+HMxuEMBwuZCEFIAezj4BLeuALx6Z2xat+GwMmzV
         ZXTgSnW3zWjlk0UTT322fWtwlsW9p5esi2+Vh/KK73PlhB6KZQuPqaFQuSGcmMyUUmuO
         Q8FRiypLfpOz5/mbiJoAszt8DVe3SIX2lzRzYE+Niln0/BRnVhQAn3HM6pcGhk9IFGKp
         qJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675667; x=1774280467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tocmhRpILSKZ2dIX4AfeiN4F0iPi2NKdx1DQyp8RAsg=;
        b=YMB0QOA0lYK3Vsj1LTCo0T5/IanWshln2czcfnvP1gawK3NhYAVcfGFuQO6nHmYEs0
         jWOfMrSgjDMzShnfmuWtXb/Pbk8wpcqFPSk4cULTCwQLKkedd6v0+ElSjkqClMeqBlvx
         K+Iw8E/+DkkUTY4leFSAAODfWZ2+e+ceIrlvUrm/dh76XuQaasVaPTDp2cXT0Q5/fQNh
         YPpw9QfMYB6wjU8UySeeoKE5eAKEtY6P12PZXVDvtoF/g2MqRuZa9aciDf8Zu8/fbLTd
         Kch+ttawW+jjc1Rm0A8NtEwFwoFJMX0YZkoMGdcsTtO57AKdwRoAf/UdzKMzFfmi7B8I
         OJbg==
X-Forwarded-Encrypted: i=1; AJvYcCVK3Fblr6+y9OT87+SO96zZjSvZJTbuWEpXQYEjV8kD/lJAIxCwqYI+WO0HXL9fManVnU7fBb7QWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3myV2JZs2VnfdhwZhj/UGzb6O6hWGv4qKQl0N4avz+S5CcLxJ
	2cZHqSkhALXd4GzutwhTBQOL0fDXEFxX3MiVwCraucNBrLylOb3mP9TiITM5q2814mu+E1e6iqK
	3/mJBbHp1AbWNP0eOPeZhXdTITz2ytoFEGlUeRFuGBP+najk+rIOiPXsoWtxqVQ==
X-Gm-Gg: ATEYQzwo82V2Yv20CW58XgrCV0rz5XdPpL9LiebjCjlrEbkv3X1RuEQcu8iN4dXLP8E
	0R3gF3JyJ8Fs9fKBYA0mjEsIGyqLIo06w78kKvG8tcif96Wxf4lDVdtjLgRn28q0Q/CGaOknMuZ
	sKCi0wB3bIYnEuZWD1d/dm5y6tZ64thBWMAezNQWjUDSZ/P9dKS8q8soFTQQOmazI8g4IqWuS7L
	B08UEQL6hIrZIQWtJCJLxwRCeIAl0xbc2OInlqScY0L9XSHozp+yvZ13INx6TWCXvi/tvW/VkmX
	+emRxk+VxPMn+Tp/NUXYAnNkOKK3kj/MayTUfrm9QxaTLJC7WQftrGRVcsLIsaOJm5oCCBAOdKn
	kkU2+hGWJ92/ECPkAja5Z2Cxy92+si2M/5+GudyJhtsJluLHr
X-Received: by 2002:a17:902:dacf:b0:2b0:5629:37fa with SMTP id d9443c01a7336-2b056293a66mr46675995ad.24.1773675666420;
        Mon, 16 Mar 2026 08:41:06 -0700 (PDT)
X-Received: by 2002:a17:902:dacf:b0:2b0:5629:37fa with SMTP id d9443c01a7336-2b056293a66mr46675695ad.24.1773675665785;
        Mon, 16 Mar 2026 08:41:05 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed6cfsm143464045ad.59.2026.03.16.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:41:05 -0700 (PDT)
Date: Mon, 16 Mar 2026 21:11:00 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, umang.chheda@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist
Message-ID: <20260316154100.5pt2nyli5nabvrm5@hu-mojha-hyd.qualcomm.com>
References: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExOSBTYWx0ZWRfX8tvncTSNXOWL
 uOtkmyDyN42tnIUxQBhRFoDUWHq0MMYAutp9lZHISrkLkwPrpfw0bHI6gbkWV7eg4ZDP+hg9MqW
 6Tm+KF1CY5LHlea84JhHIL7o+uLirNGJIdH2Oq1xn5VgxzGRnAB+pcMnEMDicViz5WQYRGUUERF
 jnXFE11vaQShJwJLOcKtrjnSWH/Q30j277VW6MtrpB4m3yEAjvwRzQfBpqCM7kKcrK5+obFhATH
 gCsT5vCYmsbrKPJLq+pNKncQho+6GtosVf7Ei7ow1ruzzIyDEvhE+4NW2vn94HJOBj4nxsRDfn0
 PJeLmf6CFoNAv62K0sv5pbr+yjmHJAl/MgBN8jrcbhm2iqRZX7SlHjdybqJsH/WTYLku3Dm0bJX
 ikC6ZXSZdV/E74+NdEx3h34NxWpjDpe5bdpws8Fr+ABZAHBDVDiksKn+tdy0JvTdxjT1k4gQiEA
 4ol8rpiwjoKD+QVJTpA==
X-Proofpoint-GUID: nlq0XUgoQs27fZS2einga0FuGgDM9XsB
X-Authority-Analysis: v=2.4 cv=V/hwEOni c=1 sm=1 tr=0 ts=69b82493 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=lkrs67fAIAsnqgaE10IA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: nlq0XUgoQs27fZS2einga0FuGgDM9XsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160119

On Mon, Mar 16, 2026 at 04:07:52PM +0530, Faruque Ansari wrote:
> The Qualcomm QCS8300 platform uses the qcom-cpufreq-hw
> driver, so add it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 25fd3b191b7e..ff1204c666b1 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -159,6 +159,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,qcm2290", },
>  	{ .compatible = "qcom,qcm6490", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,qcs8300", },

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

>  	{ .compatible = "qcom,qdu1000", },
>  	{ .compatible = "qcom,sa8155p" },
>  	{ .compatible = "qcom,sa8540p" },
> --
> 2.34.1
> 

-- 
-Mukesh Ojha
