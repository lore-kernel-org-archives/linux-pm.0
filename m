Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655044D01C
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481683; cv=pass; b=EpqmHmqFJKHK+YTGmfa1KFGlrSQ0+V3iNFKWI6IpykOVL/uDuxRR3thW2HINW2G8f147m0UnGISwqXkQZXMp+/nSuP3KbiilTicXNKZjhNaLPJOqxYBeXGptNP8ux9npoAXOzTZTFoORTRkCUTnVn9qp2FdsLFP7xjsz9qNmYXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481683; c=relaxed/simple;
	bh=7mSOyubAEmATAHX9khkgpW7a81VF6T4K4OFWgRVL8hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLrNE4esYAWqvP2WWaZTkHflyxJHcFq3akC0V10j1VLarNKO65aWOduTmAEUCpxD3abMxkECTWKuS21AMUvP2opBziyiXTjz7nNXUekgefiPxw3KzvzJr/L/zbB6NjFd/Wh/xCXKi5E4OHjWPzzo51bxEP26JkcJsvK0g12A1yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCCPUUdl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PVrY/Yd5; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCCPUUdl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PVrY/Yd5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RHFe1200009
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWzE3uzYfJEdDiRtRA7r1NzpfxqpiD0FVv8Od4wZwCo=; b=BCCPUUdlHy1kKmGQ
	6Xmkr0Y50M4gMEX/5K4YW4jJNePYb7VSGMAH+Jqh68e7kuiqvi2b3i/zyJ/agERj
	l0+LrP7KNSqZQ5GwJIH8devGvNxq235N0n764YGJ6AjtJ5CWlJ7uj/Y1mr+jE3e1
	/BNiHjh8G2uDWPGgNOiOWyTFoaqgANEHDXI+2+XfeyXiwaZbZIF6YNUgP+xeD3Jv
	CYkDWGFVdEN8d4yLKWeFNJmCV0n/IAZzuJ5ByQfcPHCx/R6NjFhUm6PaV2RVczgf
	h/ZwLRkxjzzXI/oiuGkf0YBoosX5sPiO61XCnmbTI+btf6bUYZR/kbV86OUjXOoM
	av1kYw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejckw1gky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:14:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cec4d27d33so40055826d6.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481679; cv=none;
        d=google.com; s=arc-20240605;
        b=aUEuEv+tVv3cZzYefaGj/prINSCkdXs0PNt15MW2uNmpBcUPr7m+4ZnA36ZJy5jYJO
         ngHFtVp/Rz/JGYnsVPn4QH9LjyIJXpc1xU0E2ltoWGRbeK6Sn5XK47ikQk8uEBF+kAwG
         JW+Q3vAvBmqT4ixCxz+2RcMIALEvt/+Bzw2IffUNMvHQNJ2PuT/3huaZrB6yR8Eb+fpN
         Cl73/AbZBj3pc2pFOyYSGdoQVFrzJFA15qkVINGfAjy1jV9g3YdWGoWctGzxuG33NThn
         +OLeFyFecsC1nKnFVSnbOgVSfqeFn9Opmbt8YgoFdUbfHwvBKHbXNm3DaAPt20hAitDo
         lIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWzE3uzYfJEdDiRtRA7r1NzpfxqpiD0FVv8Od4wZwCo=;
        fh=30azauJ2uMfAW0qALuD5lJkQ/V/Kfp/tljXWYYi3E4M=;
        b=ZgTXxgk8xCCNTU8hxD2ODmFiPPoXSKcdU0BNEWtUryTZKaG2gMrHk3o1kiA6siNASe
         KQ49BOzgzqnXvwpae9KBCssvoo0QJLfrKBGiHBBlRDJx4S7QFAmaxkG6RnOK1b50BAYg
         8nsGY1tXWdIvzJme+rfWS3hFXWpJmCVJJM7QAsPXWrBsXzpyT+sGrwmwW9f/lg+fjHBp
         Wk7xDGqyu9arPmnh4JwnHDKHvHWseVT/Lwps1Y+C95Tw/MYRRu+wzj1u9SqLz2y2W3Gu
         maBUHP0hK3f8+lq75Lc1PUPy1QN5+scZ5wYi+oN5J7BZ0TqHzEqwcY+D8ZuFs9S8G6I2
         pPwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481679; x=1781086479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWzE3uzYfJEdDiRtRA7r1NzpfxqpiD0FVv8Od4wZwCo=;
        b=PVrY/Yd5ZkBy70qN8Qy0eOGnuHXhYSF3Pj9IOAqIgZ59seFlGkf7KmH++3acD8JEvA
         xxBKrTxfXmg6chJsmg8lnP5MMSbQlkBEC9wwzHTqYCGYt5yGBaWEnG5bbwqHeKTfWCCs
         PFA47jp5K8GPycrAA/3P2dSr+fWQhEtCLWEMve/7UniNFH4dr4WvTSlbRIwyDlr3vRzT
         T44nn9YnZMwCij/dF4IaCJrEw9An+LgNHwGmcOZOt20qQ/1/rBb3wsNeunJY6eeZuPLC
         ZnEDBCFnMMNGCFaBmVfPzd1tPqqfRNpIT6YkMYw1/TkMJX2jfiglRqIHgxWzqNmcigDr
         sskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481679; x=1781086479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWzE3uzYfJEdDiRtRA7r1NzpfxqpiD0FVv8Od4wZwCo=;
        b=rAHpeD9ZlgwXgOjXW4ITJ6FmcFpMhl6XGr9Y8NSVG8oOP52QnpL7yOsxpFpbl/HiBk
         TwwlbtSomV2dgfnmEPujR3AbVlulBqV464nTe8aHWd6B92AJ9dA5MX9YkZWXxgIYI+/W
         ZkN9uQe1uVr9QGwiz3WtKbyxIpJz/tfoFdcWR2ll5p3b1Agq8fClzh54sAk2hLe+496P
         Cjq7ZdA7a8satFPESzJQefA+qWDGvnGmw/ZSCN5pLFDxI/k4o5Z+1HTebLwmrMSoOFNq
         n6fF+XltieNzYCRqdMFlpAbrog5OHc+IIb029YNiSkP6e+MVi39QjeXaUKX8bdunzy1J
         fVyg==
X-Forwarded-Encrypted: i=1; AFNElJ8InbesstUybbr5CmOVgyerkKnLzVgOBQ6hygZl7Mi22rMWWa8CgOYoEc9wekV+Tw6xccC31c09zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzghSfJntHTfiPkgTBPJWqxlmMJKGt22oXL5SUCnn45EnU3uyVR
	ABA3mM7shNkRNstmj8FclTjji8qkMM2mNUiiszGsUBEJ2M524SRB6mAqCbsO1SaJHbsZTplPlXT
	hq87DotjwdxAl4RMhVJxHHHWYsQxSPIIcaUB+0Lqo6qi2loKEl0aMxV0LrKMANXm+r6/9fgl5Ei
	cK7fXLOpvavmL90uZ16NZUvsNFE3wERjDVctSq
X-Gm-Gg: Acq92OHGGvJjZkAA+YB6lzgKtMI2NLJKHplGivHsJfyFCwi7j/h6m8FbcwRb7LOLbTT
	vXWDU171JCoJv5BSjLIRB2mLvuaqATTqktOePsiae40G7i+uzY3UshO4/sfPMSY8xzB+VMrFc+c
	mHKfOAeVJw1mj0nskpW1FaYs4Ds7HAdhnQmmgN1jTUgY1sSw3gUOCixqdjwE50lrJd27BzRilmx
	IpNJOFdNCLnL/X3
X-Received: by 2002:a05:6214:21e2:b0:8cc:ce03:c01d with SMTP id 6a1803df08f44-8cecdc9edeemr38075396d6.21.1780481678977;
        Wed, 03 Jun 2026 03:14:38 -0700 (PDT)
X-Received: by 2002:a05:6214:21e2:b0:8cc:ce03:c01d with SMTP id
 6a1803df08f44-8cecdc9edeemr38075056d6.21.1780481678595; Wed, 03 Jun 2026
 03:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424104050.2617041-1-johan@kernel.org>
In-Reply-To: <20260424104050.2617041-1-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:14:27 +0200
X-Gm-Features: AVHnY4IA3pmwMGuRcuOImo8n7p9XKq4G50BGUIQRaN2XFKwgo8XC5nXwSTtL0hc
Message-ID: <CAPx+jO9ycNK4Q2a9gSyp4O=s6kKyriHH=PFzNTLyhYyd0FZMqQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: switch to dynamic root device
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: GEmo0fCputu5Ezy1WRV-BkQBKUwLeBn9
X-Authority-Analysis: v=2.4 cv=edUNubEH c=1 sm=1 tr=0 ts=6a1ffe8f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=92VtXzfeC0ZghAygWvsA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfXz/i6LQpvKZKf
 bJI8WSofn6AuLi8UiTz9MnDvGXUUzYGOk8AA3HKqK7yPiWFheUC7oaRSIjTitVL1HRVEEE+SLJT
 ExfMcYiLPohdodqAqRNqt4DbvVzdFopxEZ7IBzYB1oN08P6f6//FWSMahxyggYti2gPOznM14SA
 KMZ2Q3Mg7dQPzGNaxfZjU2cUv1vR6FxjBTPgoXboCPqkNZlxdvxEMnns0kGZ95aCd3G+HVhF0Tq
 OO3a6b9T0C8b+HCaQZB+kJSNsgOSTovAlbamFF1hO4xOQR9M70RfAD6ZsxDPMIgcEeKQG38TbSd
 zQArJiFVmtC6McmK5bmt/FQNWwxNXBxcUzh+nlOWohcI6z8AJxkD505TzraF60SF/GVldNESpJu
 A1CAeity3CLZyQxaLO8OTfV2ADkz1Gug+ZR8arp8i2WvoicnFcuvKWTOieZ4AlGSNXMQPLhRxpk
 VZ2oZfYQuj0lDUoAKoA==
X-Proofpoint-GUID: GEmo0fCputu5Ezy1WRV-BkQBKUwLeBn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097

On Fri, Apr 24, 2026 at 12:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly if a device that lacks a release function is
> ever freed.
>
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 4d32fc676aaf..e01884f2d7b7 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -33,9 +33,7 @@ static const struct bus_type genpd_provider_bus_type =
=3D {
>  };
>
>  /* The parent for genpd_provider devices. */
> -static struct device genpd_provider_bus =3D {
> -       .init_name =3D "genpd_provider",
> -};
> +static struct device *genpd_provider_bus;
>
>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>
> @@ -2325,7 +2323,7 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>         device_initialize(&genpd->dev);
>         genpd->dev.release =3D genpd_provider_release;
>         genpd->dev.bus =3D &genpd_provider_bus_type;
> -       genpd->dev.parent =3D &genpd_provider_bus;
> +       genpd->dev.parent =3D genpd_provider_bus;
>
>         if (!genpd_is_dev_name_fw(genpd)) {
>                 dev_set_name(&genpd->dev, "%s", genpd->name);
> @@ -3567,11 +3565,9 @@ static int __init genpd_bus_init(void)
>  {
>         int ret;
>
> -       ret =3D device_register(&genpd_provider_bus);
> -       if (ret) {
> -               put_device(&genpd_provider_bus);
> -               return ret;
> -       }
> +       genpd_provider_bus =3D root_device_register("genpd_provider");
> +       if (IS_ERR(genpd_provider_bus))
> +               return PTR_ERR(genpd_provider_bus);
>
>         ret =3D bus_register(&genpd_provider_bus_type);
>         if (ret)
> @@ -3593,7 +3589,7 @@ static int __init genpd_bus_init(void)
>  err_prov_bus:
>         bus_unregister(&genpd_provider_bus_type);
>  err_dev:
> -       device_unregister(&genpd_provider_bus);
> +       root_device_unregister(genpd_provider_bus);
>         return ret;
>  }
>  core_initcall(genpd_bus_init);
> --
> 2.53.0
