Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6E3368A2
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906761; cv=pass; b=p4q88FuNdyvvodLa8+vOESPsPHF04wNPfdX4i7xoSBOOxUVWXzC+gqDBCeixtwFaslgfp01K0uDktRIf+qh8lCb+dx3mPZ2KKLEYXA8ZV10QuzTrb2lSdjFT+a0z/DrWbkAg+5R7GZHfCABqmWC5xN1cc19SMd45BhSTF65ymZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906761; c=relaxed/simple;
	bh=UwjP0NYSg24zOH8TZtLUTQOgPTNa9L+d73VzBNV/l60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st2ImjjgqtbjzPHJWGkip5LBn4FHD+tDooGDfMJQCYgxgZRryk7VJ0OZShmKrGRfruCiQQckjkYFDmO3urVw9NyYfaoY5ilwCm0+e9WLXt6Zg9lOHc/AlrqjWNohsaJ6xmAe+a4Wzr0rjGLoZkkCFj72bnkiicWyjeRc5KvzJ1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nYWy1J4Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GhZzd7j+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nYWy1J4Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GhZzd7j+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbG2L3178246
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I8P/LRw5Av63ejvXZypK/le3J4llN8sJRzn4b+AZYkg=; b=nYWy1J4YvasGb28T
	P7IuEzgm+jZE9tIL7w9A8gLlWpk4zyR82mseGSDhqeGl4HEaEJYLMWTxPk/RrXKA
	jIom/zLXMzuEfoQ/l/4oCUjQfN1zcI3i+iqxX3eDtx1lqRTYjzdftBKX1wasjo5K
	eZ2sI0PsDcf4NPappk6EErwhbsNVDsbR7zumQfdmdDZiKC8CnUM2AJOb5UNVHTBi
	4xz1saDDYTRniPXaC/2wPn5RuP4Hdz6UsCrB5TzT33r62lQ8HCZyLDwJpvT1ghgH
	7x6BoX1IVouJRZao0qUYSHuCBLKg06q+4VXr1gqjiv9nUxTEFZ2/2tOCLfLObO72
	fE+2ZA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yah5yj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0867a75ecso10970396d6.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906758; cv=none;
        d=google.com; s=arc-20260327;
        b=CT77ZfT4sRqGUFklMaoH/Y2dCFlOvOykK6LWqA3dIGgQ8XD++OptchsmVwSH/Fz/M4
         IzimA7zM6UtITXJZViIkakjSx33c6x/Wl8Z1e5xYKboT2YQKQGjIhklG6775qMrZazIZ
         zfGWJF+Mx1gBYqKFgjS9YynLphJfGtwpAVeLQZ6AoHjEH+Di9K1pyE0XArKFyoauXqGF
         Et6tzvFop/3oOvMSctBWE8YrB+IyYBUj12jUT6Dlc532DDcAlEiBUfRgGggQqBvg3mH/
         DMuXCEJYMMEL03c8s/nrO90XcmrYxAJwWt2kVyOK93+jcPrIKTL5tgIo5Uj/c1YHvAaq
         Fb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I8P/LRw5Av63ejvXZypK/le3J4llN8sJRzn4b+AZYkg=;
        fh=7RdtqGjII9cVV1DAJQPOkGeVYQ8DUOTH2m6Ml1yDzbQ=;
        b=A3STEMythurQHn5N6wxL9HxZWisrVfehkGJ1mULvqKvu2doQzkImttZa9k3E5GYPfi
         uW8EYbQbokiz39GFVS3CUrP9y3GG7xCcPZW7G3U9QmFa4sWUo3igMGPK4iCFGmRGusG9
         ZpksiRK/xAHHCeNJc8qVqa1Q6E0GJVRJbVAsvISKHg4aPMn3b22q9mH5hN3fW4esgegL
         7y3YGELrIYdJi0AZI1wt6y0P8UHpRm46Q8fROHAv+PDUOGG++3GFsL0jM2wgArjnzMeM
         l8HX3eXJuGhKOkzmHWMvWJCPHqhdlqA39njeoQSj5V0DHb9Y4bNrOt426I76wAjBMHfe
         LnLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784906758; x=1785511558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8P/LRw5Av63ejvXZypK/le3J4llN8sJRzn4b+AZYkg=;
        b=GhZzd7j+LR+mQwlzuBiIckYVGcb3qScoCnNh7QRd9ei14OxEqg9DTnz39JrFcGVjGy
         gNM+CSPtTs+vyLdHtC5GBze54ugyQdPk7jgYanXN/Ox5VCDqag9TCbDGkZAmxugVHXpM
         01Fa1j7xWIacAMEdx2yOXwiMld3miDr3nYokMZbwqwwuCHAGPgRdovtfnTTUTDn+SS9/
         D+8o95HxEz+dfwdGhygTDpV8abygCjQVOUaRzEm+k6M5NjYB1VkbE3YcYklZzJfVLbI8
         +RWQNKLbD4MzUHFLZI2H+esADQ6qlaCp1Vs05gIrgBm7tHu0V5bgW2PzHkgVeDmCSZKq
         SSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906758; x=1785511558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8P/LRw5Av63ejvXZypK/le3J4llN8sJRzn4b+AZYkg=;
        b=Mpw7tmMp/GBwj/4WhJlje+m3uJhHcCcaZE/uoYtSEUnYhABT4RXUmeTTyI2u7T6J3Q
         Zqb8GYjOPmlrjoQKF2S8ln73TYHLPvpBh3ETdzLE4L3n4MMLU9sowU6pGJtlwDNKNy3A
         yeY6KcFB48gtfpKfVRWfc1PTco4yQtWWlp1Y2WYfkRCP9pyotmhCgnWLD/6VJZcFQ09B
         MoV+N2zss+bHmM3oPLLGtJhJJkiuNq89BaQaxeJ+eV4rfIhRuSeiiFEhWXWahOO2D3ml
         htQlSQfm5ULvW1I55P6lZcE1HDEtK+cO1dF3hJv3yjdhcICEloNjA9DEjQe0qMrEdhHP
         dgBg==
X-Forwarded-Encrypted: i=1; AHgh+RrGlaRl9Y8UKKIop+6UqPB8FcQf8tidW4FXy8PPj6JIGkcDcCbBtlohEcUVwNnnQiW0S2Zi/HD7aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtLuYSpsa1P9o7kshEhxVkd0NmEVDODijtVw6qh6dFfPyaQhd
	97OYL7XTdxdcrDeaM3Xjt2NsqwixIjKrzixrXXwQ6sPJtRfo9arhJ/aDtf7TiTxwfoTj6ny+mD+
	Ki7c5qXn5ogRdeElUBD8O6e6VMXoBFwIWxxzMvRQO9iCg1OYjMEdNs44KYBgBneqFcP0Zr07zUV
	inSLDR7g3Kmryxihv3Bs4vHhnsTm4BgnSSPqEE
X-Gm-Gg: AR+sD13dTWUdJW5AJcNKTNeKSnQTQ1PkRHR25Yi/IvbZlNxCdLLz1ZaTzDnzIgV7d7i
	4B1KxztJaP/CYhyED+zNKMFvBA8fhomTx1O5/x+07Bp9sQjA6vorw6byxvGbZz+YlJBBxYvFT/j
	dxDSAs6sN9y3Sg2aE38tucQrnZ2eiGvhgdgj854I0krNOeQNmmK80O26Ov0g==
X-Received: by 2002:a05:6214:29ce:b0:8fd:6e22:c7ec with SMTP id 6a1803df08f44-907ca57ac87mr92244496d6.61.1784906758556;
        Fri, 24 Jul 2026 08:25:58 -0700 (PDT)
X-Received: by 2002:a05:6214:29ce:b0:8fd:6e22:c7ec with SMTP id
 6a1803df08f44-907ca57ac87mr92243986d6.61.1784906758119; Fri, 24 Jul 2026
 08:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132603.2327847-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260716132603.2327847-2-u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:25:45 +0200
X-Gm-Features: AUfX_mxxKiB1do-atg-rTre7pVoswHFzTOplPvRF1EBywznaNQKzflz6UIrGwS8
Message-ID: <CAPx+jO_k2fJRvXiNiqztHXDbCvkHrDzbM46egyiF7RQX0rsK0w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx8m{p,}-blk-ctrl: Add MODULE_DESCRIPTION
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
        Xu Yang <xu.yang_2@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX/+kLl20EOHJw
 PjmmpFddC2+J4nBpb26oqAUX/C+TT/PZXlYkAxSEmemJ2a7uKiEHqAGLQMCAxyAkaJSLAJei22z
 YZhMaXY+9NBdqPSg6LpsO6WKc+tpxh4=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a638407 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=IpJZQVW2AAAA:8 a=GSG5rVEFErVBAG7bqOoA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: ORhymSWJrzG0-S_4Gt9CT0CsNoUJosot
X-Proofpoint-ORIG-GUID: ORhymSWJrzG0-S_4Gt9CT0CsNoUJosot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX6YgNEkmx9+lt
 YZ1dQ9w7oIDnm0GGuQqzpAN39nwYvlJx+DBo4NTLIcMhPIqvuzbc2H6sRWQ+PEUsFLG4gHoYkrK
 GVI9rJwYYzM4T2RM1mKWSSEUeMWqk+rYEviAhkyYHsEUsbX5IUQBwOXINP5yxthrS21a0mR0yTs
 OJ7MaazY+gtgS5mlhW0FtU1xhRZ7zCnnhtCgQdnkWEUAZ7c+T1x2AtbIFOihC4qFlCzrgW5l46U
 4tKOkYlQGT5zKvvX0wiw4hXLkO/BMKRDgMOI3EPtEgT8j+hG9jyL/h6+HTaNyPms4W+DyM4OmVC
 8Pgit8GFMulCUnYkSj8Fwh47vJIe+4vFyqtVxrWmVBTqZDFjEt8DmYT+OO333xqAwOpjpVS/hbq
 WStHuWf7lxywP07uHbnYSyVvz/jvPRjJ4jSwvZhswfR6+pgxaOkZHgac8jdMF0rf4MbD/spKh21
 r6vXWG57ztm9ae+5agg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240138

On Thu, Jul 16, 2026 at 3:26=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Without a module description modpost emits a build warning:
>
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomai=
n/imx/imx8m-blk-ctrl.o
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomai=
n/imx/imx8mp-blk-ctrl.o
>
> So add the required string to these two drivers.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 1 +
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index 99d100e1d923..479789009c7f 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -953,4 +953,5 @@ static struct platform_driver imx8m_blk_ctrl_driver =
=3D {
>         },
>  };
>  module_platform_driver(imx8m_blk_ctrl_driver);
> +MODULE_DESCRIPTION("NXP i.MX8M power domain driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/im=
x/imx8mp-blk-ctrl.c
> index 3f5b9499d30a..d255c20f58e2 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -890,4 +890,5 @@ static struct platform_driver imx8mp_blk_ctrl_driver =
=3D {
>         },
>  };
>  module_platform_driver(imx8mp_blk_ctrl_driver);
> +MODULE_DESCRIPTION("NXP i.MX8MP power domain driver");
>  MODULE_LICENSE("GPL");
>
> base-commit: b8809969e1d7a591e0f49dd464a5d04b3cf02ab1
> --
> 2.55.0.11.g153666a7d9bb
>
