Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F5222597
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030021; cv=none; b=h/JJUSUE4zYtW9rbK1rnywAykWJZCeNVZp1uLy96XOuws5cMIMk6HoE8dB3Rjdk48NagGybifAXomLS/MBad7H5gmi+tLNzDoxXmVjRh6YkYCHuuj/ICrGjORg6n28O4ZfBJBuRIs2DadNpI6mH8OpVFMbzKdnRZpV9XL9RcA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030021; c=relaxed/simple;
	bh=8vjcL8OdQ5tgtJDoUFXe1PLh6azSB7d62dFmx2Xf4E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tO/9d7IJhlbco80zfVhiSYsL9qhQZkIi4oHbCH8T/At973ugh2cX5gcjtPjMrZ/jGCWkdQNd3/lY4JGw96aHL5qqLMQyb8RTD+5nGqOaAkL3Nvtudy/LFXFsgnK3D8eHZ65ezvfKabZtCEjdObaExVtUx/I3CKGUvTCE42AV7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ue91FZub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMtiz+2v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ue91FZub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMtiz+2v"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GLuE1q1779072
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o2fZr1KKIxC9P7aZKgWLBg6WfF9TW7hamnvrwR9wTjI=; b=Ue91FZubwWaq7lvP
	BCgmsycPl2No1NZY5uN3ghSvoPK1en2WqpUE1/Rm2CpJqbelOpOpOuZhmm3GeQmP
	hzsu+zMij4FnCpwbnImsG2kcaGfgHJOXphKtjztJWnR42K17VmrWJOZ1hbOG2h8t
	C7OKSUjFL4z/DcLteovBuQiIKlmUAQcQa+5+OFDePcki6+D06SJN21tyMfX5WIcp
	3zGnBwdT6ume9CxK5knmyMD1NL34zZEw3rLJ86bpleFuCo8FKX8LKQr3eoe51Ka/
	GCm+CyKf6ho5kSf/jfjzIffrERm+T2saY0XGKOU66GZkPoX+zADVVb93lqppCMtZ
	WU8TQw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gyw31j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:00:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e423a05c8so59302251cf.0
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779030019; x=1779634819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2fZr1KKIxC9P7aZKgWLBg6WfF9TW7hamnvrwR9wTjI=;
        b=iMtiz+2vneqUzVyrm2p/TrJcDbTfQ641fhbAvWk0SOdicPTK/zNMs8GKJCKjaE/g4x
         pKRI4WxFuhsmrEXAajJiG/IhWBaAQcc3MYi812sSujGqqb5IKGP3JCgDzpB2Uv9VxW8y
         npQAP4zcYbf4fezS7ShR8IvUpw9xk+Hv4gKNvDsERvifbhbjHtfwvPp3WjuKCVyGyK3Z
         gDBqo4ve9nYVuhmEWFN+szTExB2Pvlipf+6J+iT2XRx30fRi6Ei/a8LKJRIwzaq9Jd1K
         3YP0KhQ8RaEN7qx5NjDshlMDb3jGvLBud2eHJ6xam56/TwdUM4qGMPowLsgljuFpdCVw
         5F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779030019; x=1779634819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2fZr1KKIxC9P7aZKgWLBg6WfF9TW7hamnvrwR9wTjI=;
        b=XIqLr8MN/Xt9INa3HiWQE8NuTdCzvrRcFxgThD6WIzyJC6SvKSgzg28HMDppW+zPzL
         v19Hhl8MqVqeQvgtCVtlsVG/giIIx/uvvAJvjRscvbgSqHtFFpAlTlUojWHUaMucSAH9
         JfZF3e0PwiQ9Oz8jKGphlAcv7qnZ0mROWy4eQPO/RpvY1i2GJLD6773FGlnijED5fLv1
         7ykjXx8D9FIaMVgjAoD3I3+bDqx43MqxQ5/vW6MUYiAusbQcltdqi+DPM10p4oyiUx6G
         65wNS1R2TWCfddfq6lDGV9j93wZYfzT02+IVZ+BOkafD/C3cImpRLfyQJhsPN0K7FCst
         K3gA==
X-Forwarded-Encrypted: i=1; AFNElJ8M/uTixcUwDZ1D9+E6FTGBfnr93FJPkynUCzoE8hou0UD9k/xdiNMxT6LUaOXCJdpi1wh9x3CzDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfDuU+T/KfDJkkTAltjWqerDRxZsjykEZm/Q08SvP+NzAawKK
	1MR1Y1KAHrMIeSYQuREJAA1LnP0qsfRoMb4SwryjIQbmUGE+t02/3+bFWIIj/HncxbaheabIj83
	qxHKwXDu6RUXwmdLD9pLWQ+1Tkjv/ybgmY+Xe89QSx6898EImzX/FfjBs7tBbSg==
X-Gm-Gg: Acq92OEeBC3YsX1l4pbDbORjamwYCFCvqAn/OsRPk3D6xEfeMfxFl4lrDt1AF+fiYNt
	bJd52DC1DWlkY/4sq29S5QauOOLWDPSUcoPoPvmpyqDRrXfP0WaBccyP/o90Dy3/Y/k66QMINUO
	uINXPUFMYklt65UaLoJvR0yOqM8ebjLJf6gw+jypU3DpQkRlOzuicjeecTmvvu3rzA+r7iUW87H
	YFTt72Pt+Ka9KLrpK6oNSS9QpjlR2BZSWDP+10A6PI79BnaCk5QxjyCKHNKexvnefacveQ3/LcN
	5tSRh1ifVmqoOueH5HoLUR51v9RjcBuPR9LS5ylPnQa2wk9iit2s6K9nG5W1yDV1egmwDOLDCWl
	c2pn/c99f1dswj+cen0RHLuDgXAeLtVF3q54M2rEX9EC+Ch614CNDNrntVeXTPXcHqrUKoh1d3x
	xDiwyHFW4b
X-Received: by 2002:a05:622a:859c:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-516415a0ad1mr143174141cf.14.1779030018761;
        Sun, 17 May 2026 08:00:18 -0700 (PDT)
X-Received: by 2002:a05:622a:859c:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-516415a0ad1mr143173351cf.14.1779030018171;
        Sun, 17 May 2026 08:00:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3e20:6c07:e6b8:6153? ([2a05:6e02:1041:c10:3e20:6c07:e6b8:6153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm193354695e9.14.2026.05.17.08.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 08:00:17 -0700 (PDT)
Message-ID: <938b5e46-fc82-4d6c-8207-6ec2b2495a26@oss.qualcomm.com>
Date: Sun, 17 May 2026 17:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: qcom: fix typo in comment
To: Jinseok Kim <always.starving0@gmail.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, skhan@linuxfoundation.org,
        me@brighamcampbell.com, jkoolstra@xs4all.nl,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260516152324.1863-1-always.starving0@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260516152324.1863-1-always.starving0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE2MSBTYWx0ZWRfXyefPmDbaeSBV
 PJNLCAEh/2xiwu8AGNON/Oogab7VRAh8hUGgfTRhBDS4FT1gfxm6a2Y1A7kx7P3uUsfhKW9BENd
 y32UoPjfIBhJ+s3Pp/f8BP5PHZGXPrWCeA3pgHwpZqMvib2WOZuyy3ueJvrcoTHZnnXECtUoW3H
 oPkkaCzjk9hLYX9dOKCKoz+Q1zzm3XMk/nV1boQfgcwZtcmTSPIyJ4GUyQKd232sBwg/abn1bzx
 KQ3NCqJt88n7FRW6Z8dym0a7X4ZdyLP0Xka+++IX+20k+lexygkMUcBy050nY/MI8HypLfu0DzR
 Bida8ic9uv64v1ox4heqsLqP4mkCsfSM8/LtK92xrdH2Fu7D/KgNByrSmKdYZoqYrMzXfjuXt56
 MypL9080bkqFxYlHQXcUIh2D2Ez3KVL7wUeRuq8xr1/htHcDwdOvFR2biZiCfJcHK2DNbeHc4u1
 3dceJqGp4HPDqotdQkg==
X-Proofpoint-GUID: TEDa8sVM960xOT8wvNZm6LRy2zyQWYDu
X-Proofpoint-ORIG-GUID: TEDa8sVM960xOT8wvNZm6LRy2zyQWYDu
X-Authority-Analysis: v=2.4 cv=E5v9Y6dl c=1 sm=1 tr=0 ts=6a09d803 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=hEL-7WqZ2Qmr7oYnmoIA:9 a=QEXdDO2ut3YA:10 a=lbjUW56U394A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170161

On 5/16/26 17:23, Jinseok Kim wrote:
> Fix a typo in the struct tsens_irq_data comment.
> Replace "uppper" with "upper".
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---

Applied, thanks
