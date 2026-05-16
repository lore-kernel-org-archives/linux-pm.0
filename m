Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7833BBCD
	for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778946000; cv=none; b=L7oCY80PaQdJir3Ys0GKDe2OvY7XNF5AkFEw4Ub+M/1C7A3GfZUZJ0YpRoLTkCRbVuOGP9cTtjec7Y5awOO6jailRuXqOhTmjYGm4+VY5PTsj0hVmoxIY3SXsy5acHouSEfvOm3ZusqO/NksIjDZce8onY0y0oa5D056oJiu7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778946000; c=relaxed/simple;
	bh=gsuc/6rRXcH93VmihWQS8s22CFUo0ceUo3PHNdoRaZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIs7tkWVOm30X9FaKkjJBpni6iAmzQgf5nUP+2e9V3an4W/jtqAKr90DFtQdmAwjjRoo9s6c6fqGsdc1bHfkxFZ/9nx5LICbYGfgCvfbA7LXg/5N2sY/oM3b17cDu3aSTY+3sI7aVZZeyo0aF+BCslQYvoQiDkTLtuGVf0/YwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SC5M2aNT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cROFwx51; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SC5M2aNT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cROFwx51"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G3f3pB778344
	for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 15:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fmhNdNRYPDgmzCrmp6j/LUal
	rEUVxqlvgGWshjsZhC8=; b=SC5M2aNTA9ZssWFVthk3HKO7DRtEJpGnnZQGsLsg
	R5RlJd4i+NqOtu7S585ZrA05BkGxXOGeJmgEJX97BFWbl6xoSzQr7iQj5lEyuiKZ
	qe/+Ag9gQm3g86FM7oRQMJ6Rj8dk0XjPoNoeyexvu/cCKDJClxCZnT8Pfb647oIa
	QFdD+LpB4bBSHrZ7qb7V1jA12XJSVvFPvWH6xHCzM1qGIR5Yl1DBgKOOiguhiBvg
	aj2BQadhXoeuB2JjjqFkDFojlT4FcK3Qa/0inAgGcTISQHsinzWFea2bASMYzQIX
	7j7hZO2Qba50tPg1R6oi8ntISwWm4KN+XEo3Z1fkC9UwEA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvys6h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 15:39:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d9a6a853bso29886641cf.0
        for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778945997; x=1779550797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmhNdNRYPDgmzCrmp6j/LUalrEUVxqlvgGWshjsZhC8=;
        b=cROFwx51bdCBg0TN3cAa8fkDh3OpI/SNgVzJFn7fYXKnfT+oO1oGSMrtx+XhUEYXGI
         mwY6zpyjFhgXgQLRFQqO15O7xP3T/1+VWduxk9wHIgV91cqt1/Ql2m4xm+6SCz+L8wWd
         24xlhsKcOundkHBAob8zVhl5pk5rX8cSfHa/xf7a+Wh4TILRpCvgPYwwHanix5DEs6VJ
         gMxmP6b74BSKO26+xP09+Ez5A0YpgWTB1RNfNDRFqDf9zsV4BxlvjpN71yD/cJGTuAO2
         +po+mOru474vS18j3DK5h/vM3YYJB+Crz5LAtVm3KFQqVeeRUGm5OIga0b0FGZX/AnMK
         C0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945997; x=1779550797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmhNdNRYPDgmzCrmp6j/LUalrEUVxqlvgGWshjsZhC8=;
        b=n5y0K8OlLEUAxaodOrDxdT1nLhgs9tUQ8A445HcXG8LvK3bUaGJFcZit3shg4dG+Or
         FHpHyNzkEY+uEddkuimBT7ZkGrmZvHHNBOde0HebcupWUTpc85S1wZO8Mtce7CAX3gT4
         IvX5aV9flgPL9uSAbTrz+thKYqsyKX30gzpTHbcRkHFIESth1rCc/au21gRdDm/ni1Y7
         RpdoOZiMg39acQMM1gj72ABh1vScbW2RimkmM/De9F475yhDYaJxD27J93Q72jnsn7YU
         sxf0Dy0ja/BDcZx2Ch1FGskYAUgX4/p2vshHMXEMtHtVhrG2AAU3aLante/cnwcszBL1
         wOWA==
X-Forwarded-Encrypted: i=1; AFNElJ88hkpIDh7aHrhyunpKT78pIRsqyYOm7H5BYZefztlqGLyGETGv5bECOjUd7v4NUd6onCxRYZW+Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMf7QMAmT9HkRBaz2NwDtV8l6HxAWS+wHScIpqL3TzO3M7LKoj
	nyv1advW45vTXD7FRkm7L6Vzwl9zj2OMFps3skmSHMZc+LtpTzL0puAWlGCwWRs7Z7xzYP0NWBl
	SL1PpdWTTEuW8QRxKpE60LiT+L9NYMtNJLNqxYlHvgGFoWWa09gD4YY0TewH5TQ==
X-Gm-Gg: Acq92OH+CJWfvJz2jc4QOCVe/Z4LcllrBeapDL360XtN7abYNs6kbIToHyVTYgniLjB
	opF39P9TCJ01Rj4lGYRX5yyMa3wG3rws9ZxkwXAd+jWAnv1MnwlZQHm1WkbehzQ3PKdEjMS8Hn9
	G3g9Ku9TnIqIfzza74PeqoD6+0nMPOLud6omkD0RWx61Q9cZn0+qBpIgiiyzS4RQvk4xWTXnukP
	SeE4Cj9WWf4WDngAuU4b46kEWTnqfaIL24vFEEELBgaWiYkxGDjrX5l5jzSxPBQ1f4eI3zduV/t
	iWYHlW+L0oTSryMsAzGn4YcXQq8dqvgivWTv0InDtGfVWM3OB/JNpHJy0o6PKi2ZpkS1wqgg/kz
	k7UHGdydB8fmVRYJPIHb+2j4M3Lkdfzwq/c1WOYigliyIID3KIN+wBDDLTeygLK2tLP4Y5hxYv1
	uzuT+vHAFconk/3xXI5EIP2P/c2ZOwnqyhYXA=
X-Received: by 2002:a05:622a:8596:b0:50e:c093:9051 with SMTP id d75a77b69052e-5165a1eb8c3mr101645721cf.30.1778945996848;
        Sat, 16 May 2026 08:39:56 -0700 (PDT)
X-Received: by 2002:a05:622a:8596:b0:50e:c093:9051 with SMTP id d75a77b69052e-5165a1eb8c3mr101645461cf.30.1778945996423;
        Sat, 16 May 2026 08:39:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11b487sm2044495e87.23.2026.05.16.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:39:55 -0700 (PDT)
Date: Sat, 16 May 2026 18:39:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drivers: qcom: fix typo in comment
Message-ID: <u2vuydd2ubtlaaj2mgt4nz6gy5nhifh3vcpjhmdtyl5kod7gdg@gnynbkt24rer>
References: <20260516152324.1863-1-always.starving0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516152324.1863-1-always.starving0@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE1NSBTYWx0ZWRfXwkWdtihZs5iV
 Bj3osC4IL5qvTxaX3XOniDJQMjl96ZIUy/t+AKiYsXJIdOtKUtaa1lPct8d8ruxT9/9hiWwWFux
 dTC71xuKpehCR4OpuAunLmBKAUn0wtyjbdXY4OdQO+D8tuzY3YyIP7uvyWrurAjfQFINXaj2mFC
 n94kS254TAJRnJLHVn+ZQ8eh9YZohvnGuQ6g9YUbmoz/fc9/e4jfUMuENotNCqrEcDyejVRj+Fr
 +OxQiPaK25jQWgCo3nE7iRoSlyFauQYvxp27oCyEKKbo+EuL3OHfZOUurIVGLV8mHUzCX0DVt7j
 1JDsK1EmOLTwZoOM3vCKTopSHo5AcCNEEuLoeS5YPc3dOkIoywLD6xeR7qcesuVKX0gFcrtz5aj
 iDOPYORNzs8rLjxXV9xtARRzXNtqNSS+27kO5YH9cUsrvJXSJq4Rmg1lpWIr2SG9/rokIKJLvcB
 1SFDz9YRg0Euio/yOCg==
X-Proofpoint-ORIG-GUID: YAynMhuYgtDM9uONP96TB1V39IKVR5OE
X-Proofpoint-GUID: YAynMhuYgtDM9uONP96TB1V39IKVR5OE
X-Authority-Analysis: v=2.4 cv=X5Ni7mTe c=1 sm=1 tr=0 ts=6a088fcd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=hEL-7WqZ2Qmr7oYnmoIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160155

On Sun, May 17, 2026 at 12:23:16AM +0900, Jinseok Kim wrote:
> Fix a typo in the struct tsens_irq_data comment.
> Replace "uppper" with "upper".
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
