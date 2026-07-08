Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958EC44CAD3
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509577; cv=none; b=rFp9w/sV4Mdf4rPLcjQjzeokGr7qDqZjGs6RTIVYnAnks29v4tU+bReoe4/kRrMMyJcibm+ezj3RHsvXKoMmriNpvHILwcVFFz5JdVRtkvvagr7q56Yj5ja/McLCgTISIqC+K7s5Eg4N6BQgZOJoxksTOHItzEN3MVcBsAfceqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509577; c=relaxed/simple;
	bh=1Bu2bsvkEVqEImDM1RKDkfEvjpFS0t65Hu+YiLDoIKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/S6jKBXGuE4ovfmfPPgxrEG17Xt3yoYFe1ybEuze2PAScx9lylBD9wSBNM70hYy9i520bEZ43a9uUfLe5+bGwCKN2aERYjxdDQrBTV1Ygq9Wfvnkss4LWPdI/jGB8g+YkCZ1a+U6VmlCnc4PHHoSiwyrZieeEaIEJrimWGnMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nh3Y8m0q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fP5fPdSR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nh3Y8m0q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fP5fPdSR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66889IdP2186462
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 11:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oTmYSciHNHuBsQCBS4o6R2d1sOrn6HJvwBfNDLCb/z8=; b=Nh3Y8m0qUtuZVVBk
	lQZbqP4LbQC6FDXuTwVmg742dHSix2M5A33Fd6Dja2sCBWaPv7imheQA8oIT5H35
	4yHQ9/fiFv8OQL019Y0puFTAO1PO1Y0dmfIc0qAktC4RdjA6XfE0wfwG4dT35zSl
	c/+UE7xGkxD6V7+vN3mjGp+xw8ZYDWgKxxdGgRFFbAfts9zT92cAOt1eZ53Jc3jI
	P6b3KueZZp5rbvvdBw4mfEbrZsOtQiiFm+HFIsBZV4DpeIkcZsEKY3k7nvHWDc4l
	/0YCqLOBTtk25g8POm0RWH75JiXUaiZ8LKI1sYYCkRwPBl95srqk29NBR5OHB/rl
	x3lkfA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd4623-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 11:19:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so53934885a.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783509573; x=1784114373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTmYSciHNHuBsQCBS4o6R2d1sOrn6HJvwBfNDLCb/z8=;
        b=fP5fPdSRftGPlng/axL97gt8xgsTxaAhacEptviwhe3oE7lUIvIgYJAJwYFbIgmeVi
         ZqO/q4b5AOMvPxrabLtjDYMrByUfGlaNJ7oFnd3IsxEdOcjutxUJYW2Nio5ByRhUEfO6
         TgPwCgq/puJQsr+dZDFLSum9VR3iyk9Te47brB0xiEmaTYEazeyLTz/0rKk0XAsu5Nuw
         quCJpF10BMRZKWftSk33RULG/xiQNGfykbUrTyJCsreDOp7H4wmo8bdaGOQ5u6zsbem7
         UtVGcJWLhRub2ByHJ6Avq7ixDnOReUOwPp38tv2ne+I5ua2MiMP+99HtDi6qjnOUCIlx
         oxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509573; x=1784114373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTmYSciHNHuBsQCBS4o6R2d1sOrn6HJvwBfNDLCb/z8=;
        b=KUPJa8sKIxWDRqaUe3myPEEh1TWPOsOFb6Nqv2RRTnw5dz2gpMnRgw8Si4Cc3HNyfc
         IW9VTFheXEaZuhzu59joP0c/y6Cwm+2d4Uxvu1lL3bAr5/WTQkSZYJkJHcGnLB/q8apB
         yVH5n013N39ybLoQzg5eQ6TrvXwgjYNd88bymvHj5zG46DVHvE4yoGag/oxR7wFD2FCu
         /E28AOyXiuDfOzP2kJKCxKObqsw1nIHMDIZlXdUqqvYqzoc5mMTyyYjvdOkaNITRmtD4
         b+0+aRGcQRHNXIJbo5+Fxi6tepvXeJ4FzVKjut4jhKqU9FFJlQSeuy6xrrSf69JfOgmj
         /u2w==
X-Forwarded-Encrypted: i=1; AHgh+Roi6C5AERT1m3qSKHDSL29zHle4pVcVEHw58Xny7eGNrXEPtGjhAEtXwbvOi19EGjLEUq8YV42j8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6ynn4b8BDIJcmQSTnKI1na/qG6Ghka88HqC79vcte+LquwlM
	bSUdNpxmgvKPJmWRXy2SzAzHL9Zq12p+z8r4n7hhJ7y5to5mp3PMIunFheKHGQyjo1VU5kVI+r9
	feIATmmZFTGicptjcxY0ADDzuW+zWoGRdhg4BqlIvt8l0mGcJ+StoGaJ8JmxeVw==
X-Gm-Gg: AfdE7cmJ2h96iM7gNevdszYiSG2LtK8vpukCVxnD6sO/EsOrFEkGFTi4bugZWn131aQ
	XjtCsjU9K+La8e8GjIb0MYsYN0su2mZWchA+TUGXUX2PFx4QX+vhKK3ICEMMCFPmoXHeTqXeP7w
	nz6/w5WC40uyDlll/y0Bs3vP0bp+AJUX97aW1KGcCXZL90z/eGooZPtWltGs2ztFoaIMfw3jL+k
	g9RSHHbvuPmcqWNvith47h2/XCy2sozS2HtqzGIcUWyszLCmFfVw/GYbr645AfK2W6JB9UBnDtf
	l3/WhQlSFXZPL3gepna39VPO58Wd2maDu2DCHSqUIv2avahRAGvycYfJL8WM0iccpMG7/tjp43p
	xYozolGROTgPgmPoskpf1VuwuhBazXQKy0LofntSqqOAprhNiUGNjMshNJNtROWwyx6nAW6W7iA
	==
X-Received: by 2002:a05:622a:1104:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-51c8b45709bmr20330861cf.37.1783509572934;
        Wed, 08 Jul 2026 04:19:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1104:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-51c8b45709bmr20330641cf.37.1783509572493;
        Wed, 08 Jul 2026 04:19:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9094:f7db:443e:b97f? ([2a05:6e02:1041:c10:9094:f7db:443e:b97f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fbb410sm134729405e9.12.2026.07.08.04.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 04:19:31 -0700 (PDT)
Message-ID: <91e4b9ac-7967-4e8c-af3e-9d29fa813fef@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 13:19:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal/drivers/rcar: fix error checking in probe()
To: Dan Carpenter <error27@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aj5WnseULiwgmlWv@stanley.mountain>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <aj5WnseULiwgmlWv@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX/pe84U7M+jxM
 nQlOv5+fM37Nd4PhE88yA62+KUWxiCcFpsMEpclACsviK5mDMT39Wjqid7aUN7taZp+rjd2p9eX
 xmp9arugpYo3lM6csrwBz/dnkcmTetsJiDMaxSOqTBU/uLn/vMQPKPgeHg3UleLB3O9iDXGhcvM
 HPc/yX5JNcMvhxxOpW0yOJC1ypQADRLLfdtUZncLReE+erQtIKV69tkf9CidhsQ0gPGWn0o1L85
 HIug7sBABs4UALE/vKW/WoNwL4s0aLw61AnN7RFKkozRWxfyy9SLd98p8sfiWzNPUJ9yhaYBxO6
 kkm3fTDPfgQacToTZ6+VSgNQDabQTPZdSUROctx1wWWA3X2YiolhZrUEeHWPR9W59DEIsI91s5d
 ix+c4s3a3SbaeFMFgDa5Ew97oDYP2k8wWR1RDnvtjB871vFDJ2tYCFB3XcegkWyO2hC2ZS81oKu
 C24xC0FEuu0An5QQvnw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4e3245 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=8aaFJO-Im-9i58NN_ysA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: L0uCi_rtn8hog1hNDL0ZPaVChNJgAWxF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX5Nc8MV9P9LTc
 wDlNaCzdPTp/thUwHw4oGrRaOM+KBU4Yjwd2SezamNCckMb6fP35pRcYqk1RIIWEnNegguNzXZj
 uoli849v7+a3rYeyaQ7tz2xNcHyZG5Q=
X-Proofpoint-GUID: L0uCi_rtn8hog1hNDL0ZPaVChNJgAWxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080110

On 6/26/26 12:38, Dan Carpenter wrote:
> This code accidentally calls thermal_zone_device_enable() before checking
> whether thermal_zone_device_register_with_trips() failed.  Move the call
> until later to avoid an error pointer dereference of "priv->zone".
> 
> The driver works differently depending on if we are using OF thermal or
> not.  We use thermal_add_hwmon_sysfs() if we are using OF thermal and
> call thermal_zone_device_enable() if not.  We can share same error check
> for if either of these fail.
> 
> Moving the thermal_zone_device_enable() call is a bit cleaner as well.
> The original code used a three step process to cleanup:
> 1. Call thermal_zone_device_unregister() to cleanup.
> 2. Set priv->zone to an error pointer to preserve the error code.
> 3. Set priv->zone to NULL to avoid a second call to
>     thermal_zone_device_unregister() in the rcar_thermal_remove()
>     function.
> 
> Now we can just do a direct goto error_unregister and rcar_thermal_remove()
> handles the cleanup properly.
> 
> Fixes: bbcf90c0646a ("thermal: Explicitly enable non-changing thermal zone devices")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks
