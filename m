Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308102;
	b=MKToe39xfChy6etd1S6ob3c9MdIi8qYpBuxvigmAtXanNY7ygCZsnspXK9o6svGtEo55
	 dqgf3/tngOIboVSTHCmaeWgb8i0OAOQREL11GStTq1t22Wv7bhE0+BZtORErFIiSODpBa
	 j8exrPiQ1ytOtelqwrr+eVIECFkKeFYTe37ZuW+sD0/CoMHUdayL1ZKz/Tmtdaq5eUk4N
	 TWCgScVJj+s8AmD6BWsjSYJG1xVJpDi8RwTYldepYE8fQKm9KNxM2KN6Uo4Rv0L9ELeyG
	 RZxBZjf+Qnt7giaPlO7VJiqK2dVY1XAXcplo++XujNBajquDmjqMOV5IqgLGmy8kzlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308102;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
	b=Yxc0cPMl2Yaj2X5cElz26+jfiOJBO5adhWO1arEi7TGgIt7tZOXv78AV9d0yRRdB3Bvs
	 FV6XZP1mQGnv1dvg+Ub4mJ8908XwQKm2UZc/dSNvdP4N2Q3xV8UXJDQFR2FXH2K10UPKW
	 ML6H0huxyjXwVP9aItAqUU50yPXbLwduuycv3uTnK9VTpe8XEH1HKbnLh2SEVdniANeVL
	 0FnVOCNukjXIrFNmBmpu81573MZc2bpe6k0v3YINS1/L1nR5UwnRC3Nqvao3WL51oPhji
	 zKacagkEee+u9qHEO64cYhVn+BSdoIY8WRLRxdoq4HEggGX06spHVF6CoG+A5Lt941A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1ksWaxW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sz1BlcZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7E606A325
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C7E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1ksWaxW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sz1BlcZU
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7klai2779825
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=; b=f1ksWaxWVw8Rz8ld
	MqqA6xAmL1eaI6KdF6ngVxTNfe1rtXeAfa8cXSgx6t1OROxJRizyCT5xXOijzAo+
	t1vFUcTmIUNcDluxD58KWpiMHoHx/ae6W5Ifo1i1L0DXFil5/mwaBy2xBvMQcbh8
	ds+/A7dr60U4fxFL8T+0SgPIj7G2qGMqT8DYQiYO7VvVN/7apninibA6e0dBArk5
	pjbgEMufR8WBkr9hfxmbnqxaYq08dZKJ4bA+PsAQFBomORtfEyNf68lKGIByyrHl
	yNmv2RqOp/XTP9UBHJTFcwse3MP/WEC1d3ThUO6vipuukBkY8buc3KA20SJySRwA
	27wEXQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8psn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a065e2933fso2443942b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308101; cv=none;
        d=google.com; s=arc-20260327;
        b=hFdjljNBfdX2QrvrElgA+EaQEof2okWQRxCOTyZ9foPiRQxZKp06EU00+eF8GniUFi
         El2zPItCy3NVvMTK7L4Z9ctNkpR4B6e0OM7datLBG3zA/DNSsGNQfar6rgY1moFSvQy4
         crEkJNaSudAqYYTVKHflELOOhTjcHVyuWW6AOkrGqbhqaE9yF8gRkl2tA95nrtuxulbB
         +COX1iTAf+TNKe2u+9grqDZxY1sZM3L/xCAgInVv1dzvZwJUhRHsFo8smFX3Y0tAC6nr
         r8Xktq91vPheFioDUzA0SvWJivlTpuCBFh7zJ3jSoaAK105aq6BQ77vOz6j0Y/J7DKln
         svcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
        fh=CsTEnY1uU2KhMQUzUImqz3i3tpqS3IDASYQIp5u/PaA=;
        b=OtTVLpBqSO8cWQ5FqjO5zRxQwGM1WQSi1tFumvNdt/tRPr0RmB0rtA41a3Fq+Ah1mo
         6itpDQdL4JfNX1L/sQVWkBobbVgQV8wXeEABdQPLeg+lcWsoHRV8k0fdrRvNTjadt+gn
         I92nvoHRPs2hq8GPGJtizNooatO1GCV5bqOHMcrlZjuvp+dhfr/eu5zifq1Dc4d42g3O
         JPQTkYLS96hTIcDxVJu55GTBWKILrh6+xLWXI64+kzgwqJPilrGst/EKBASUBG/lC7gI
         ndS8nPW9Hjc4B1OgdNVgztxXkyDZ+23rkQHwBfRG8W0T7xZAkT/wgCPaByeeW8ehLLe9
         HPsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308101; x=1794912901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
        b=Sz1BlcZUowedlQQ6wH2xi7CfP8kiMQSqZXVo2jjcPzN60T0rUUyA05TFnEfl18woRZ
         Da6jCCli86Ja5RA/B/DqVT3hTSByV7isarvMqNUwPtYcKADODiHilnA+9rrpnlLDTWAJ
         3+ESG+SQhR2W5fr5iaAbp6Jv/hcZGEsR0+4TO+GX60Zd3fvMGRl/V0209k4GCqMlmMmT
         Go9H2j8dRWJEPbpEZeFx9ll2LjPv73vE1F8+XKEoogXkmBzx1663xxVINtrzoCKmvVI/
         7Todg8xbPUUKr5frHf27gRrrf+Ugh7cXMjGHYl5IXNs5xsxK+gDBMlynF3MdTEG1T2sP
         mErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308101; x=1794912901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJtLwXE4YbMiscRwIQ+gtJkXK50TzVBvgMUWwQOLd0k=;
        b=cbc7sop9PHbLd5qTgwesQJMfZIsKtRZK6LVPLavtPhywdqnXCdOoSZxWKUqaAXrtLB
         Y081G3Pr75KhTrAYvRJDfftOUqOQWez6b2O1DsFTGvQxrsEXMSm+xDcZKwvfiL5HZYuW
         uGkmYoiBDHleUxjxsFEdArz7VHclRrJE8Ir/FNnW1tkB4pxW5ptswFeSjyJG7TlTErxW
         xMGUrMS+9YpFBLr1rDsXL7oHgcmKJu0OYiXNnZAWClZ5cGwH6/Cw9txrbbAw3ddDlrLB
         od8X+rdCAn+nvm2Gt86aGSF6Qt2pFW9gyDZprm3AE8UsJPw5CzdUUhZM0clDKTEMo3bn
         VSMg==
X-Forwarded-Encrypted: i=1; AL+hErG/wURuzpGjvxfegjCiJTw4+Xn7DAuqDbZKKuPundPEh/maPtGQQTe+V6sWreRAvq1JicVbJAc0Dg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8iShhPt7pFcPZoqsGY8renFYalrm6Xo6NXzZcFMIITdXij42gy
	BDjPCffj5TCfPYxHQXZPbre5d5aCth93GLEvg2Yd4L7Gx+3aFgJKIMMOXdWycaUtKfSzM7iVZPn
	0lATDxUuPuss4hboAafi3cxRAwfd8bveI4lRbiTmwQKsJs5WGGUVmUwhNLtDJxTlkA/zZPo7du2
	EL3P7nI7reG7fd1y57V8w6z1z3M042L2KtpaES
X-Gm-Gg: AYBFou2KRZTZXvfH1myv1/XI57OJZ0urXRl+09u7FyFJsm8c8ETauYnWcD4gqwYYvRo
	cFci/e5Yk3SAFV5dNu6eOOhdYSkps4kY/4LKoAufNVsWWt1iNkPo8rxHheSfZUvXf1ddAZ/qiD3
	MqPZMHt3HdFtQkC1vYZIi17wLW7yoLI3t3WeJeSAccuJW+Eu4oZyyNSTfgIA==
X-Received: by 2002:a05:6a00:13a1:b0:8a0:1435:fda0 with SMTP id d2e1a72fcca58-8ba8aeaabd9mr2606960b3a.51.1794308101022;
        Tue, 10 Nov 2026 02:55:01 -0800 (PST)
X-Received: by 2002:a05:6a00:13a1:b0:8a0:1435:fda0 with SMTP id
 d2e1a72fcca58-8ba8aeaabd9mr2606940b3a.51.1794308100616; Tue, 10 Nov 2026
 02:55:00 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924142520.1594149-1-lgs201920130244@gmail.com>
In-Reply-To: <20260924142520.1594149-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:49 +0100
X-Gm-Features: AclHuK8rWqeadVtw_i39_uuIhclFTsB4ghO-HIhVp563_1PxcLFRfqznhN0nh6k
Message-ID: <CAPx+jO_EVCeOtSKSekve_w11a=nnpyq2qWAa-R__T-URjNXwbg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: imx: gpc: remove all initialized power domains
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>, Wentao Liang <vulab@iscas.ac.cn>,
        Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LJ0mEttrSvXixlopOz3_xUEFIbTfLxvN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX2ZWYk/P3zgbJ
 2ao9KyY5jtyxdy0C98VYtiKOqTpRjMgvVTvUqi4YHD9mcBHzAP5zds16A5qTpxL7sSkf+Rm90Df
 CRRbwqwDzB0t6O0ESVzrJ6dx5HE//ng=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2f805 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Dljt1d-j0Gip_uCM0CgA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: LJ0mEttrSvXixlopOz3_xUEFIbTfLxvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX1+BRrRsuA0DH
 TMxhfoUdBQDGJCpDZvWQydfduY2ogkEyvsM0yOycH3q/RhY7ek7WtuZ0KEomldrndmuW65Xh0Dj
 Ni/BYmg42vV6Cz/jaonIhzSMAUZMlRz9p6i76Xfa2lQXwCiBMsIBbDMKyfFpBnnp3s5KUsx9672
 w3O4UiJhUb3j3rNetQAOueze3YTbAypLgFhyJOPYkE25aR1MIrFVjfihVouIFQoAl5f+MBaWjel
 agAt8ubOUGCtX28bZ8OaGORHoyOyQxFiZD0qTYjstIDQhFO75sY3kcsY8jeGLgAl0w7P9nkKVkx
 Ot7qc1boL4qv/MRkmy9Cq2YjVU8LLONc1cqVkJ9WxPtI9KyQGyLm3B7WkA2pVPEVrDb1FHaYGPw
 f/Ut3ra7bzxctCqwIQjCmyTfQ0hbjFWqPctH/ljX3RDJstvF02o0SHiee2RYCwe05a0Plvq0cFm
 YI/atR5AxwwKnlSMP9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043

On Thu, Sep 24, 2026 at 4:25=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> imx_gpc_old_dt_init() initializes all power domains described by
> of_id_data->num_domains, while imx_gpc_remove() only removes the PU and
> ARM domains.
>
> Use the match data to remove all initialized power domains in reverse
> order. Release the PU clocks after the PU domain is removed.
>
> This issue was found by manual code inspection.
>
> Fixes: 5a42d1198901 ("soc: imx: gpc: fix imx6sl gpc power domain regressi=
on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
>   - Check the result of device_get_match_data() before using it.
>   - Use an unsigned num_domains variable and a decrementing while loop,
>     as suggested by Andy Shevchenko.
>
>  drivers/pmdomain/imx/gpc.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a22..d83fb37e2297 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -502,7 +502,9 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>
>  static void imx_gpc_remove(struct platform_device *pdev)
>  {
> +       const struct imx_gpc_dt_data *of_id_data;
>         struct device_node *pgc_node;
> +       unsigned int num_domains;
>         int ret;
>
>         pgc_node =3D of_get_child_by_name(pdev->dev.of_node, "pgc");
> @@ -519,20 +521,23 @@ static void imx_gpc_remove(struct platform_device *=
pdev)
>         if (!pgc_node) {
>                 of_genpd_del_provider(pdev->dev.of_node);
>
> -               ret =3D pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_P=
U].base);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Failed to remove PU power do=
main (%pe)\n",
> -                               ERR_PTR(ret));
> +               of_id_data =3D device_get_match_data(&pdev->dev);
> +               if (!of_id_data)
>                         return;
> -               }
> -               imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
>
> -               ret =3D pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_A=
RM].base);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Failed to remove ARM power d=
omain (%pe)\n",
> -                               ERR_PTR(ret));
> -                       return;
> -               }
> +               num_domains =3D of_id_data->num_domains;
> +               while (num_domains--) {
> +                       ret =3D pm_genpd_remove(&imx_gpc_domains[num_doma=
ins].base);
> +                       if (ret) {
> +                               dev_err(&pdev->dev,
> +                                       "Failed to remove %s power domain=
 (%pe)\n",
> +                                       imx_gpc_domains[num_domains].base=
.name,
> +                                       ERR_PTR(ret));
> +                               return;
> +                       }
> +
> +               if (num_domains =3D=3D GPC_PGC_DOMAIN_PU)
> +                       imx_pgc_put_clocks(&imx_gpc_domains[num_domains])=
;
>         }
>
>         of_node_put(pgc_node);
> --
> 2.43.0
>
