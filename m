Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A23264FF
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457432; cv=none; b=ub+VO5ZWQP5cSGlnI33JCSOzk9VIsG0jjvVq+jfY4a/y+WgrvmQJa4+M6FO+1TV4TmLG/ob/f/a8ssqBcl9yr4H5HAI3UiUF48bioqyt9i8hTyfn3PBonvotvqe/7VZABgaCTn8D3TAMUJo/JVhyIbRjRz66jLbFJvPk6rR0qxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457432; c=relaxed/simple;
	bh=c0GpIF58VPRCye9Oan2goH8X0n1TBH6l8lxPQPxAeHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC+zHYpVFF3VPDSKyJ3K+iS5gorkOD/zAE05IQIFZdvPJiDJqiFRCvqHTeqwc3WN3LcF+8aybDYY8pwqldiraE85t+Kjgh2WEWV9oZHzm+Pc4hKbGQsHZQIWD/Mw6xQy697pOURu604oSLt9PjHJsXfualN9aM4E0hu5s+PGzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HyaVOOsd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQx97qOn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HyaVOOsd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQx97qOn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWbT6453548
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C4MTfVrRtBC21wV1FG71Ff0/
	JPpkql4Nf/R0afJ7Onk=; b=HyaVOOsdt1KnAz58X7oF5a9LnfhEvWaGFdGNuOSl
	xxmeWA7H0pu1rsvLQfV6NCNp3aTygreZfpzmCDdDRMCYS+QUmuoNQTmv9w8VnX4U
	LrJcukpKLZ2t7VMCmp+fpzGxByex3U1eCOzSVoAuULIiM7d7xXCKa/UFISEZM4H8
	HiBWOALRVLCJ/nmBH3TRH6d6JQN7VJ2lpYtmfeLSrSj3SPEgDu2qvFnb4DUJLEQW
	w+w3lwybS0uasoK/xeocxk3ZLAQIAG9Bcq71X0y9JruoJX0vkTHtFsRIMsy7wwyf
	ypqzFLcvzHtQih87s+6RP3wGp2l5lU3e2nS8flIJZn2ACg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kgaea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:10:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51ebdfceddcso37974021cf.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786457429; x=1787062229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4MTfVrRtBC21wV1FG71Ff0/JPpkql4Nf/R0afJ7Onk=;
        b=KQx97qOno6CTAHTZ9KoYIz7PwIE8gBvHUjmMWIx2XxvKgkmnWpn45PtNk5Gj0zsEas
         MC5nAqwVJRMn8wY9PfOfzvde5duFXW4WyrODtGDxG7lGdvWvDEV0xn75c+PHy8xevPrF
         TfMWe1sQMlPESSNcVh/1TLHSexX68EGvsB27SL8MVu7Xon7FwgM+TKyFmHKn4O/2h4o5
         G/Zo46v0T9PqPqaDhurmb1OURq978pJyw5M6bz2bbqhA6/KZutAi4TlDwxzOhJ7gGfMi
         S1Gz3+tHZtXIog9UDZQwESTLJoHRb2atQpf+hqNl7sNReTqWNXX4wD0qMQMVwNvMV0g8
         kDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457429; x=1787062229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4MTfVrRtBC21wV1FG71Ff0/JPpkql4Nf/R0afJ7Onk=;
        b=H5+GSGpcrD0arivmUpL8iLvQB6B6/xR6MfZeqQUzeWfE63z4a1DZ1/TPZ5t5i4Crlz
         mcJzSw9qlN/HL88P0fOpFxYLTi8qWs2G9KkKKoGXI1Pz23Q+KIcJpUIhroEtfULy3hg/
         Z74MVMz13+8FwsqjCc9c6C5izWVDr0MNKKKVnQN71UGdPJf29ooRoj2W03ODr8daRDxz
         Y57HYJMnwy0fxPQ66KGsU0cA6V9bQaqAo4Uc3JD0vssp/IHFUsbadbSUNpR2YyORTzkD
         nvsW2nhqQZgFNYuoOCNES6UGDVWWJeWcpbkQBhvL8MRyKktW6mIl2O/EsYKs0S46sdFU
         iccA==
X-Forwarded-Encrypted: i=1; AHgh+RpoALjB6SvaF7npGY2B2K3dm5FMUcCISqVKB4EnI2O+OeneNt+JfHxnVy/Mut//17qnD16061OFyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6z9GDQ5BZ6uq4jcHQkSTq6QpXChpqyQRL78WwDNteS+KgmRri
	ciR3BaJJZSWw0sDg2hpiZxbEQSQgvWD5d+Iuelsynuc8CsVUkK6cbLWz2Jc3i1OK0kfgWY+1jF8
	jHeZ8PAB+ZlZoDXIXZSEzTxRIFasfl8gzWxprychvCOWkU6l4U8Yh+/giyuwVaA==
X-Gm-Gg: AR+sD11qKpGI8+CPVJ+Xbb1GPUbjo4JKQZf7Ja/wPPJyHsxno5NcYxai88jCm1duPr7
	FNDWSP/hwCglhiicKevgwC3HvNsAVlaYrBeT1ZTLqSX/ECWQzec0uSDOgn86+LMfE9LWtwrbi6Y
	97T+KnblFGLSgepeKduO0RFl+Cju855BnDW1Yzppm5QVtiqeajUtLsmqm3Gm04yrvNJKLfTUsSE
	H5qVaXvDZ9gOuudclSRP+9/HYbeWId3g2pKjrqCXc82aa3+RHDXXrcrtinwtevN8BoNkjVmsu1C
	SplOuD58sdQ47QYz9p2qM3Bl6FLf3D8NUYyRes7+Z/+3XoNvWECIjz0y0p63opgE7vsjGBSl9Ua
	HtD7xDSh7zHOPpt3exnAt/7ybygCeeLUtWRbhh6v0Obx4hhks1urTpBRZaa/cD8c52+R1Zu2Dan
	2E5Iq/NtLGhSOgow==
X-Received: by 2002:a05:622a:2510:b0:51c:1241:3b09 with SMTP id d75a77b69052e-52d5868a30amr30207621cf.39.1786457428773;
        Tue, 11 Aug 2026 07:10:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2510:b0:51c:1241:3b09 with SMTP id d75a77b69052e-52d5868a30amr30206991cf.39.1786457428388;
        Tue, 11 Aug 2026 07:10:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4486c0b96sm326174e87.17.2026.08.11.07.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:10:25 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:10:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, broonie@kernel.org,
        jishnu.prakash@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file
Message-ID: <sf725msufnhfdecl3ovz2grdg4k3xfudbzcjqzrw355utpq2cw@mcuxwm7k2y3r>
References: <20260811094544.2939556-1-daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811094544.2939556-1-daniel.lezcano@kernel.org>
X-Proofpoint-ORIG-GUID: tB_Z4Hpm8BCaV-gMmib0BTNZxHtSMVC2
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7b2d55 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=QWH7kgmwNTCCleJi9_AA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfX2CvIU78AyGRp
 n9SME+y5kb+FQ68QnCgIpPZjescLVq49ayGhN3m2z5O11sdc6WSsX7b8krjPL/aO0Fu4dgxmrHq
 bbWGVWJrHJr6IfHp2YUpLrEYJDnMGRfEGx45PKu99cbotGx6p3T7jxFLEJoGEaZOtc1YVXS5zF6
 YnME9PNSIRfD26czrPWNb6ghE9bvtUxUPmqnwV+e5c47CO2pU+y3S4P7Zzl8G5fYpHggq3v1nJA
 qOn4jMWiGH27JgWabQYB+kpNfqvHaRt7mkH6y+nI4zQz+L9kosM8PbUQeOzwvNPMBGFHZlMw+w5
 b2oDkonkNOwdcbR/KdasSL3BpFfagspJzqE/nKfuhR4+1d//Mbd8qo36K5Dy76nXex/IqJaP1Q1
 NB39gLws44huFpyfQMDWBVo8JW4Trx5HD/g6pGvs5fFJxMHXhAsShwKljRH82faHLHtf0c9Mk5r
 3uSgWVlVYf2mZ92NDCw==
X-Proofpoint-GUID: tB_Z4Hpm8BCaV-gMmib0BTNZxHtSMVC2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfX7a9Tl1u/T6RS
 pknGsmdGEUZaSkVE0FH4x1KN3Ye4HQTKf6Zibyktb0cgSDwmBgEe+RZiDPxjLXO24RLmC6ik1VE
 x04rmT10qN65c7BOcCdlpFdBj4HKuv4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110118

On Tue, Aug 11, 2026 at 11:45:43AM +0200, Daniel Lezcano wrote:
> From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Add missing file resulting from a manual application of the change
> below after fixing a conflict in the Makefile.
> 
> Fixes: 948ee3a74f35 ("add support for PMIC5 Gen3 ADC thermal monitoring")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Don't you need at least the SoB of the original author?

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 ++++++++++++++++++
>  1 file changed, 434 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 


-- 
With best wishes
Dmitry
