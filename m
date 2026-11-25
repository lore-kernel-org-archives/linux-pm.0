Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620521;
	b=4L4kqx9bGv70zOLAcoFLwzkb2l53czUe+7Tn/nRIdYD2jP+M5hU+2VEd83tbbOq0DXY7
	 c8AL3mgPgUnS1CZxUsAzFRnO6jOisWNek5Sp9/nHngwmhy+Hlx3y+GDwmPgL8SJMCPcjM
	 /9ru/k7ECh7jIj1FTNYJZ1jrfKEQCrpmwp1L26VEwZooFXCTAvF7uylQjTN6gs73TaFpo
	 SVNjRzwDQdOZucf9Nd85607p1+ULn97OMwNOPQ8fegxzDAJW24S4ew834/811bjSxpDwa
	 +Upyc9WuWd8Zlv9Can2RfzsHkhucdUQvpLxkFGG4R/AYZCIetZqz0jNJc5gETKVYXFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620521;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sQHzM2rknVr9bM5wgvQqIqYNbsW1RfLPVnXbYTp6XB0=;
	b=IMdPLu15cTHwfsTMmIpfZNgq7yY+okeDb8t1VUrqPFfLQ6UV9VhD/xHk6qdDCMFfwyyw
	 4v1NYtoPIUu7XdBn2oPx7ry2WTrlhtJ76JdnecPdap8Ujo4R3OCFCKY7EqHJlnuBV6T3P
	 4oF/7QwEvIDTIl0QWNdFb/8kieFP74irTlcn8vtCIpckSx8if3LAjnoO3NtZifGj0HwPB
	 fbVUQVOnCFpXpTlrRw6tSIYZ6SnJq1wqasa2SpWf1c+EiebFpYTJK/fSl6WHRA04vYBlH
	 k+tRm1w6OW6kYCYul8+NmoVbwB0kVHV7/qdsFr3Hn6kNgyXJjB5pAh+THlBCfwB8qKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dcJeNz7j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O+jskw1v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC2606A335
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AAC2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dcJeNz7j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O+jskw1v
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM40R539822
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sQHzM2rknVr9bM5wgvQqIqYNbsW1RfLPVnXbYTp6XB0=; b=dcJeNz7jBO53pM9b
	BWVrwtK7J9Fh2vzyGuYd2ROc95rQjRVUnpMNAi24cw4DUxj/qKO0bf7p5K5v+ppC
	WoLmdJU4QuDKlddsZsQaMlvb/xAfL9b8l1OwK3z99yl6iu8po4fNwM7HT01XnGiP
	uTsd53Uxewrpk74/Q0ugLMkY/MNDJrwmodDT5pCBAGsArM45yCsJEKBmE01NDSdQ
	H4Uu5WBscdP+W8zhFQt7BjyuS6UtxJ17JY55ZzWTChDwajmNvxhxkL8ZZhlyyjmR
	nxAfSF/aGTdDGjrFJe/RiqrxaC7jxsracyRrOMB8E2xc4brdgOAOsk2ZQdDgIRPI
	owy1tQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhsj8u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:28:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b41b099809so5155833a91.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:28:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620519; cv=none;
        d=google.com; s=arc-20260327;
        b=a/d4mFCnXFi9FPCLXrvQiSFXUAWXKghco8sfxl/FYgzs9wVvbn5nCuatik7dZJTIqs
         51g7pX+y6YbyXEOuylJ7FnwxYhJjN4mQucufXStOSKZD1QN7OHFPNHJEOeR9kIDLYUGS
         hZyout/nBUzHa23nGtgmjCAgf5QUv6tfzkCtNPcNzh0ac1dKNupGjeRX33CO0geGTYUC
         PDHpNYIYXmhyVrbL0LfX5sbJg8MYKuxb2gsuBJ9sVo28e12sT09GDQk7KpP4LQdIdz8M
         aq6ZaFnZHh3OafKSy1t/UYtR6Y99aUua+jDhzlOmInvfLa/ILbIMa56VkrdwikmebknE
         nOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sQHzM2rknVr9bM5wgvQqIqYNbsW1RfLPVnXbYTp6XB0=;
        fh=6rVIYPZbXiMpzAEhNo70SqJuoGUv501BxK7Nhqb7aGk=;
        b=KSvh8Fkz6BXf/se8neNOObjo+r3EdCKLEtM6y+SwzoX9ocLgcjPkHwlgQ913XfqC6S
         9m0AQiJpK7GosVLK0V9/Eb8tDIPAilCphY56hDSQQuBpVdmlQkLK1kNzH9xLBO6ap4YT
         i7QWDDi2LXv88ELi9NPZAJBbsW0O6Rst5sIpsW5eUIQsqfu9FvLR9YChPqpHKUhrrKKY
         MTdbaqCP1neTsy1cgGiOKWkycR9c8THyN541nvz83Yyf27pZpfA0btjpKJGNvSqLWKMu
         JPLa8P+X720khENcNNwD9i8Vfwe8+jM/dNZGwr4GDhv1Qk5iZuoGl9s0IV5xx13AiG4J
         d/lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620519; x=1796225319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sQHzM2rknVr9bM5wgvQqIqYNbsW1RfLPVnXbYTp6XB0=;
        b=O+jskw1vuDcDijdNVhIFZdNonxaJ4JTuRnRckQWib8OCuNFiJuAejNb+jUyFj0Z41G
         GmkHW7tJH8ggP+toSv/w6eyD+cvAO4MUzuL28aKRCGWs/Q7tYt/5ejyjVWE5T2ci6cF+
         /BXPyl3zCGDYGPiP5+NclLmlUgO59DCJQHqJ8KaPIymhEswY1lPrx9Iivkm5vAH7Dh18
         lk7OwSxWYg7sT36GA28oCu8rQYPU7UL7UKXsTwHlBJ5uSajCOEg0lPT4Q2TimxLmV54/
         pPJI9t6SqJvZ0D+T0DLhq9aH/LZ5d3Vo7eXNfVJFw3/4end9duN1cKYNhmFzEi1hGExg
         KtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620519; x=1796225319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQHzM2rknVr9bM5wgvQqIqYNbsW1RfLPVnXbYTp6XB0=;
        b=QX9HPq1CgsUw5J9VGv1tXrO9Hl0QjDdaRymXlBDKzyjMPjgJVUFeGUcbjQUQo/q8kP
         vMOheehd+0t7cy9fV3PdpnO6/EFzb1OnyYxYnbfJ+HUV8R0/3EFklbRjKCf6K5tHPJGb
         l6453tRjLai4XOY/BNMLgM0H2FUe0T2GoeJZE4Y/Gv1olZWVmKB3F92qtUO0nHV4EbVT
         /K3mAEUMd3KuyrG3bn1TYmJVCVhVCYc6CbgXgm/lYRbY1/a5VoeXkvNjt1GJX+OBM1hU
         y20T4mhTyiAp579CPdAGauKLBCxkNpVZlD0hNQPRnUwJqXCh303gL9cd9GpoAtU1DlsB
         k1iQ==
X-Forwarded-Encrypted: i=1; AL+hErFRc+trkCNRO7MhPYm1eyaD7vic2adm7QJ081Hx7LjHniTpFKpiyglEFRcksQd8tBoxr4NtC6mwaw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8jJs0CpL1mkbFu+YeiDTm51ISUk1g7Jh4b74y/+mv/dDeCDz5j
	MpTwjJ8Vf4hHgEwd60YbeJDAHDQh3p6fon0LU43TY0wWwOOpEgzqZ8edOXj10BuQXy2WWK+0fEd
	CywZu/nD2hVADR+ipC288QNnJC0osvyCtJ6tFJu8apHh2VtTioIvKCmOaqYRbOmFa3kC64sNybT
	nbY43cpINFC9OI74b2QFT/Sqv0yE1RBam6DqA4
X-Gm-Gg: AZFdTZfx+HVaOI8L1jW+7EK60oXkCh5OBC6x4RWDasP+Fttf/1zeOp2mnyqDgHftAdO
	RX65/9yVJBoyc6CxTmtCps1sGZ4Pwm6cthQk9iemzVk0wrms3eJXeBuJJrDNOdBLAfBSvhWiLZf
	49EtbDGJOKSXyCSkDcyVYgiLXNbsav4c8pa7NMOteNoMsQs7QeO8eScerxmA==
X-Received: by 2002:a17:90b:4a48:b0:3b1:2d60:66cc with SMTP id 98e67ed59e1d1-3b41c7b56bemr16095967a91.8.1795620518972;
        Wed, 25 Nov 2026 07:28:38 -0800 (PST)
X-Received: by 2002:a17:90b:4a48:b0:3b1:2d60:66cc with SMTP id
 98e67ed59e1d1-3b41c7b56bemr16095933a91.8.1795620518406; Wed, 25 Nov 2026
 07:28:38 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123084218.673382-1-b-padhi@ti.com> <20261123084218.673382-3-b-padhi@ti.com>
In-Reply-To: <20261123084218.673382-3-b-padhi@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:28:27 +0100
X-Gm-Features: Aa3M54orfvOVvXWigsGrBuGRN--3G2MONDmqMcP_qizMGu0HQcaQbj1P0UCc2ug
Message-ID: <CAPx+jO9LhihGLHYSFR4Wd8GhOu_AC7tE49OJxrVEVAJyEDHhiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: platform: Allow drivers to skip PM
 domain power-on at probe
To: Beleswar Padhi <b-padhi@ti.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, pavel@kernel.org, lenb@kernel.org, ulfh@kernel.org,
        sid9.karanam@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
        u-kumar1@ti.com, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06fea8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=7sSX37EjNprRciGDyAYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: aua5EubBf1BjltAQZSvHp1wK2GkLPgX1
X-Proofpoint-ORIG-GUID: aua5EubBf1BjltAQZSvHp1wK2GkLPgX1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfXylR06vDtMkVf
 ohtfvxsIuGMcDisR9KwyvkQdy6SX1UxwA+Z3JAsp6eOHwL5HeFCTb75lYgjSHLvvTdYuO2QKXrg
 XsM0CeTOdESTm/4aOx5KiUO4GAQ29Ew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX0c3yAhxistzj
 8Uu9woIPY32TwY0JhrCOSF0iqN8bU3NMaVuCdzGXR8cjOD9hOPoVi9v5ygSGWSnNlbelVAQu0Pc
 ko0RG7o8ac/H/KnS8PV3qZfE0tasNo2u2848qhpGMz501I47n4jhme9CONVOD2/6FP7R+fT2X3j
 ixkTTuJhFEfjuodubMzrJz5C8VHtwNwQHJgsWViY9Kk6ZeGOxm5LRKwMZCM/NutwwmOVVAKcjsC
 990kpSix7q3rh0A+s2BPSABUPZIRVyVNhDVnANb98rhj5+wlwK+rFDEytZJA6dgpLiEEvtnitnI
 AwuQB8De715aJZ7/mPNOG9IfqqzAqbANdFccg0uMOYO2oXlOHNh6YR0abYs4ZPPIMMb7gbECXNQ
 UlUK6QH2LfbNusjngMwfMPcIqCp2Ol7EtrW6E+pXv8ZyI9p5GiFoaouLEEy8HjRkC4ewgA6f0jX
 jI9YSE5/2a2n9muM70w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Mon, Nov 23, 2026 at 9:43=E2=80=AFAM Beleswar Padhi <b-padhi@ti.com> wro=
te:
>
> Currently, platform_probe() attaches the PM domain to the device and
> powers the domain on before calling the driver's probe. This works for
> most cases, but would be erroneous for devices that must be configured
> before they can be powered on.
>
> One example is the C66x/C7x remote processors on TI K3 SoCs like AM62A.
> Such a remote core's local reset must be asserted before the device is
> powered on, otherwise the core can start running bogus instructions
> whatever happens to be in its memories at that point.
>
> dev_pm_domain_attach() lets its caller skip the power-on by not passing
> PD_FLAG_ATTACH_POWER_ON. So, add a pm_domain_no_power_on flag to struct
> platform_driver by which platform drivers can opt out of the power-on
> at attach. Drivers that set it must power on the PM domain themselves.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> No changes since RFC.
>
> Link to RFC:
> https://lore.kernel.org/all/20261027140751.2465743-3-b-padhi@ti.com/
>
>  drivers/base/platform.c         | 7 +++++--
>  include/linux/platform_device.h | 8 ++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 979593e5cca15..6e7b803a50ab2 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1482,6 +1482,7 @@ static int platform_probe(struct device *_dev)
>  {
>         struct platform_driver *drv =3D to_platform_driver(_dev->driver);
>         struct platform_device *dev =3D to_platform_device(_dev);
> +       u32 pd_flags =3D PD_FLAG_DETACH_POWER_OFF;
>         int ret;
>
>         /*
> @@ -1498,8 +1499,10 @@ static int platform_probe(struct device *_dev)
>         if (ret < 0)
>                 return ret;
>
> -       ret =3D dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
> -                                        PD_FLAG_DETACH_POWER_OFF);
> +       if (!drv->pm_domain_no_power_on)
> +               pd_flags |=3D PD_FLAG_ATTACH_POWER_ON;
> +
> +       ret =3D dev_pm_domain_attach(_dev, pd_flags);
>         if (ret)
>                 goto out;
>
> diff --git a/include/linux/platform_device.h b/include/linux/platform_dev=
ice.h
> index 3bd0f1f0d8704..4d1679c4ea78e 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -292,6 +292,14 @@ struct platform_driver {
>          * to setup and manage their own I/O address space.
>          */
>         bool driver_managed_dma;
> +       /*
> +        * By default the PM domain of a platform device is powered on be=
fore
> +        * the driver's probe is invoked. Drivers that need to configure =
the
> +        * device (e.g. hold it in reset) before its PM domain can be pow=
ered
> +        * on must set this flag, and are then responsible for powering o=
n the
> +        * PM domain themselves.
> +        */

I would appreciate it if we could be more to the point. We should not
need an entire book to explain what one variable is for. :-)

> +       bool pm_domain_no_power_on;
>  };
>
>  #define to_platform_driver(drv)        (container_of((drv), struct platf=
orm_driver, \
> --
> 2.34.1
>

Kind regards
Uffe
