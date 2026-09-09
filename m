Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72317396D1C
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979777; cv=none; b=kzKDE62xsYW2USUAt21EDo88V/9ogDJy6GV2fyM+UgOidWziLVbeN5goDN8nTfXWOAfwWzKdky+z50JN04a1XucnGJIcXCx243VDKcnWxf7+bBqgluEhNv/mF5+cu1t/3Oo4/k6Rwa6qls3kfySHuPo8i5LNloPzjn+mOyeA5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979777; c=relaxed/simple;
	bh=nHVj6C7ObfXBJe+eF/4Jw1LC2YX6A5nzTMPulUhK9dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjMSwVevYzofaFruMmmlHNHKh+P7SyLqF8W07I88wxgaDGW75aMqSJSx+gPbTgMGEz/4WeyaYBiMBMIfva0+DexTGLBb2B/eya7V6T1siqvsHFDPtixQaFjV8HBlnpDY8zugES4EQDH9j5BJcJK+dgSdxNIkdt8jZe7ToPuA4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZompsQY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+W8SbuE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZompsQY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+W8SbuE"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689IhShM2689088
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 18:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=349eBNq8SzB5dySvqp4+a/Lr
	FlWacg3L3HHPu3sbxTo=; b=IZompsQYvPCrZss0gRV5Dwhbu6U6CXX8p9NOTFFI
	lZkThIm8pinUC/2ObU7kN7Yot8zRAm5jhTpu3dVipun3zIsoUaexzIPjAjnJZjlo
	VhaLILFdz7QxKXD3N2gA/svRldNHSBs6yZYNYldB9gLupv+aWHBxbYKVw4JH5Crn
	JVeI+Ln6TOWcF/SX1+FRmpzg8RnONkihdoz0n/c6bEhfohaH8HbZ890tXENc5p5Q
	eondRcOjST69ZzArM4IbSG3wX/I+WJwQwhEGhBeEdF7STAQldS/KES8I5PicZcPC
	C2mb6irotp7BISZBNaxoqquMI9hlGepOcwl02A8dT+uyyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfr19a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 18:49:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52fb6c7b680so80737381cf.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788979775; x=1789584575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=349eBNq8SzB5dySvqp4+a/LrFlWacg3L3HHPu3sbxTo=;
        b=W+W8SbuEX5oVcx0gmjw+HzoFUXqT8wOXWlbIUR3A/p+p50EHF9nGUBZ4AlFXvGWdYi
         nDCMTMyJ30/0mT/n4YT53pC7pFn+eu2psa2tRykRI/APcWA2a6UE1BSFzTfCRrY1WEji
         cJ2v11aYOfoBdgI0YjjlfT3Wffmxo0yrLi8kBWHpyaC7IKEYPhLFg9ass501jHDRLHMd
         aooMAbDmQ+AaAM192iZVvNtvM9wEDjBjA1Jc9VM6MNKOWvqhz+Kezd9h0WuDa4tZwuwW
         NHH+v9mt9+1rxF91cLUjlFTplAaf7R+1XgXrzKCy8ab+EiBSmS2XU5XsSDuQAE9GKfAO
         txHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979775; x=1789584575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=349eBNq8SzB5dySvqp4+a/LrFlWacg3L3HHPu3sbxTo=;
        b=Z9zZGkdsJdwesfTVEXlrRv5VOFSvx9aXZUrg3ZorBLs28TPUfJW8qep2efBLXcc05g
         0aS/xwOZZBNawyG2TYbx+U4f5/KEwO6shQHARrZyVWAffXuM6zBNHg4PaqtYvTiMNKp0
         urjdEJSjrGEwy5BeaKRnggaSjy5ZZKEGGMr3QWYU58oIcScln7W7h3/UafUDiLf75sLJ
         B7XB0WOhOZFtol/iiXaWa6g5XuzmNY9bpjwNMRrlcXnt8ukYW+KE5BTPif1goPPVdD2S
         J6S3CJCRsc6d/yklMcJwW0071QHjot3w9TiHqS9vSRYeKwlib9Qi/80ikLexfZdFYo03
         1d5A==
X-Forwarded-Encrypted: i=1; AKwUvBxWY73PynkVE0ki5kOH3iCotFW44tRb6pRBa9y3kwPZg33NuZGDZpjXLVzCYs0p36hsR2bePb6Pxg==@vger.kernel.org
X-Gm-Message-State: AFuF++lqKZ/koR3jKTiVR+HtMACpOF2m68Oxeo2a9mhWJzb2J0Q5P6Sr
	WtmhBumazpLP7ZzVdqVqRkhV85gbuyoKXn71hhth1EYAur4TkVbW9h16eUGWc9sN7M5lO4PFB3v
	pvSQs/PZXN5G1mcnp0/xkP7o7F5xLcDhwBdk6fvDWUIiXDaEQoXiwVxqTRhH7ww==
X-Gm-Gg: AYBFou26AXQzyEruE4I1qcntv/vDPvKIrEpGJ/7sGTdNRQ6pXmButDuoKU0Y/7hmgaX
	CJRZj2QrqrZscKf7j79P9FvO9CJljxonIeKnENDN0wh0jUFVLI4AydoM7pNk9y8rUjdingX/u5Y
	Q10mWp8IJmD4HpFTvCqDkVqly1E/Kyyf1GexKoC/H3B/rsQwYkSO7Hx3M80OG9ZNVpKkkZHUkI8
	do27YqKTLpDrpVGhsmnUKyx9J+8CCtjXW9/+oR0AMS2q8T4saz6+EDpjAfVlSfTGe942EIpAl9V
	2ydwEdT4j0eQxfakpmGw7RYLCCQXK9g0MiukLMqfB5fvns1gOXwV7G+KO4QEgndw5Iwy7T33FSE
	+I7WKoMlrHCFE5Q9fMMYFo0hpJ7nDsv9h5f7K8h7DhP69DJxZNjNE44H6TQXAnOWArzsOiS3PgH
	5lJ5Ow0MxW0g0H
X-Received: by 2002:a05:6102:54a6:b0:785:e069:6c5 with SMTP id ada2fe7eead31-790776ffba8mr1802157137.8.1788979287030;
        Wed, 09 Sep 2026 11:41:27 -0700 (PDT)
X-Received: by 2002:a05:6102:54a6:b0:785:e069:6c5 with SMTP id ada2fe7eead31-790776ffba8mr1802145137.8.1788979286652;
        Wed, 09 Sep 2026 11:41:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a372e9efadsm42002251fa.39.2026.09.09.11.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:41:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:41:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] interconnect: qcom: icc-rpm: Program SMD RPM
 auxiliary QoS ports
Message-ID: <opmidp5oqmpamjp2hucf6nkn2o6qpjtvgvreoyjbspyu3aa4de@wul3j6n52uju>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-4-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-4-6dc5b5e97626@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxMCBTYWx0ZWRfX8Stp3tgBSDCm
 CpecmtzaDTyNFeyCiAkagw3njBd9MYd7lXaNtngA3xgNQFJAJp0xG1qs2au1B9k7QgHfX13zl9i
 rUuY1gMU58zOpTrrPBnj6pUBTlSgzsVKiYl09ryQkqZcUyZF7EOzXw1p3EqThHq3zbOJXtKqvOR
 CxPCBjej9zUPIXfAgxz5tyhz8Zob5oIueDnxq5Z05OeRybbMu5rTdot1ZNfXtxo6oKwCYTe92zT
 gCS/23fUbcjiDoDuYHSq038aXrDx6rPEidxjGHlPeON2A+i18MKAMTabiA4ljC5z8slg4SZg0yd
 3kqB5/GttenFfzpSNreHFV3cnc6E540mIGUNdWNp8GOF8AuZODJsLmB4a1AXdOIrIo4xy2ef3RU
 jhgzZko4GVfCrwrAMSm1vP/aTvoSvg==
X-Proofpoint-GUID: TO6GDPSXUYPCTd0LKwjWqb-lTI2GchB9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxMCBTYWx0ZWRfX9C0NnQkYhG8+
 FgFix0QfpmYJpQ/YU3lt3onsf15inmUXY1kF9CdssUif3Q1LkaAzZQlXBNCS6QYc6+YczTEWXAg
 POv+N6bCwjED+Ol5BqFq0ffAOdrWK5o=
X-Authority-Analysis: v=2.4 cv=GNqdgeNK c=1 sm=1 tr=0 ts=6aa1aa3f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=WdMRlMAzhO2SUoSbdeQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: TO6GDPSXUYPCTd0LKwjWqb-lTI2GchB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609090210

On Wed, Sep 09, 2026 at 06:41:57PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Some SMD RPM interconnect nodes own two QoS ports. Currently, the code
> only takes care of one, leaving some endpoints partially unconfigured.
> 
> Keep qos_port as the primary port and describe the optional second port
> with aux_qos_port.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 82 ++++++++++++++++++++++++++++++++-----
>  drivers/interconnect/qcom/icc-rpm.h |  2 +
>  2 files changed, 73 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
