Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA540D580
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126355; cv=pass; b=shCfwi1Ou6qRvtEMGQNRzS4DQPnS0vKDiSCcq3a9c2M6zjlsT2I1iacCDx2TsFNHwicdBdkiQqr0TWTqHsI+kig2ltH6IRbCQEE1ORSGgH7BJLG9+xQnj6Vufwc4N/ObxM2GUvlLspHWURv2IfV/2UiZXyBcZXLTrs0xASit140=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126355; c=relaxed/simple;
	bh=yP/7Z8uhlGur14MsiODOWmZoOOgIez3bqWFTNdQVt5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px+7dAdLZ3yiCus9lMLATpPPHB8klCE/i1AF3CxvA5YzfOfGYZ966soNNAFg/7beuD7awCkVRQrkIIezVj1+Qbue/2gvdauh5WOPjpRXGV4qDCLoRSOWusnEBg+sBFUxONFNytmyn07+JwmEw0mVJCvCNI1HmxEFGXN/UzwdGKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eUTXz/9P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjjA2/wr; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eUTXz/9P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjjA2/wr"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJYUFl2618955
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 21:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6V4y4jrUDwaCAqSrUfft1cggY0gZCCPi3cFlIDDpz7g=; b=eUTXz/9PyeeWGGRQ
	F/xmLrVU0+E7Bsmp9FuUwsS4unYUEKK9J68Bt5wYawjDO+gQfvU3E5DH/ezXSOE9
	yaQqYqmWldYsHKqCOWVMO29yduGC9KWMmTyw0GSTh38AWpTblYVb5qO2HhJwcZx9
	ITZ8zc1Ckk0lclIqvJEsjnxwCu7P5qMlRwSdZBGN66h8dagKnRSwLZ625ikpOydD
	p1fqkbuJSQ7JJwqLtK00XAh1UrWd6EljdzH010+nSPJXhohhBNhIpA2MKrd3o6Mi
	FhmXHR3YUxNzD5cGY1AcRlLskiMD6z0QqUlqpobhaulCBm/vytHWVwLlDsuvcQQ5
	ZAFRAA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sgdw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 21:19:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ccebf7e86aso8118176d6.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 14:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781126352; cv=none;
        d=google.com; s=arc-20240605;
        b=VNp3xocqX/INDtr26omrJl2QLPBccg12ce1uEx1IbAxin60FYTxPUc4b09OkE2jZjU
         470idEzDX+zE8SyNzyIFPM7C5gqbCwdsj7B7r/Or0fyBeH2s+MwUQgeiy4dSvrMTQTIw
         BHLuhk2ksluvHxRHS8yl1LPJ5VH87eJ1DPXJoDo49BAHglnQNnKxAttddR4DkTMvHXCK
         ObHU1duDvhSCfFtZaJK1G27DUGUEpk9jlNO8PUBMn1ze2CdhHv2bRoHBMQkogqkKS/uf
         X21OMyJwwuYakZARI578+FAUPCbSMFel8GNeEbqUEnGoTcuadYmjRma3DMVQr7Y8toVz
         +cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6V4y4jrUDwaCAqSrUfft1cggY0gZCCPi3cFlIDDpz7g=;
        fh=yg4zl5QI9E7N2IRklq757LtGQpN+KNe2QEH0jK3wz6I=;
        b=epyUveG1/5uLUC3sGfW5Q+zlwsGwHX/y/TnUHvf0RE3mVSZvlynrecMVkcd9hRZTfC
         IHorRGqieaWAaP1ICj2c0m7z/amAfeKrtq/sKFUeULuEtI9Nk47Muo1AHcIZ+wlMo4h4
         EQoKy/7veIKhw614hpbVMPf7IMoSml/LcQ2JvaKZv1f/n26VvbYtEuI4U5yIIHkLicQ2
         jOxIgO/RE9XQ/359tw7fr1mjGLLTEjhKo8rblCLQqs+1ENUm+SH6B9C1dEDmZDbB7/0n
         M36vIGJwAf7Q14YDhwMxsE0p7kwtGjPViZvToqiuII1WM/n0IG1gwGUmC8d/aQ8v2Y2e
         VvtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781126352; x=1781731152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V4y4jrUDwaCAqSrUfft1cggY0gZCCPi3cFlIDDpz7g=;
        b=OjjA2/wrasJ8QfUPN2bf1ZBxAYbAd1iZY3OWcgnvJEyZsH5wWBb8dxhlh/Bvu4xmzm
         V+2un+7Rbxn0mLygScrDgRSjkDMK5h766H1QFuzHm5p0xduDWwStrhR+iytmOi6jQHkC
         47GoOR6RH9Sj9QhjxciCRFjma+7fqWWGdnvOM1RTDpqQE+zijtAw5Ri4T2j5ew6kBPcS
         9quIR9yBI+GJ4wFqr5JikfWQz2EpWCXmTeOyx6lP4dwvFHscS6ySxzLhxb0vMowDzwm8
         BdHLb05DC1TGkmaPwF1eLlt9bYUBeJ8L+/Ta53+ZUlbbXT2KuOIkqyHvmiEt5tqllPIm
         YqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781126352; x=1781731152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6V4y4jrUDwaCAqSrUfft1cggY0gZCCPi3cFlIDDpz7g=;
        b=sffvN6eMas7o5Vyt4lNkvSB3VYnFDefALRo1dT6KR5w4KxbDorErCxdOXu0jJd+sFJ
         QVVvXnxOoiIyBV8lVU0d+tVOGlP9MS00LB506wrzQRHwhkJBpUh96yL5D0yHe4fiaRpJ
         yY52RtkR9kVRsnSCb5ubmwThdMh2M5xf9FKu4LPTA8RFcKEk7DvhFDyuHIGBy4fn3JPA
         FGcQfyCukeOWwqtgygxzgPQvchIpt+hI6PLK97m1EFfTTNrV5ISNjo3P3RkI040qD5oV
         GDOq+ryZju5FZ/WcQMr1VYro0dsPxRXa2GBdSyYpGCBUUlVK8DULfaPRSp7FrD8eN4/K
         PBpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HygWEO0zFnnKCWgl+apvoSSGs4dZ7bdQmG48IZs/HrsFo05mqXPUtMyZXTE4d5ymuyYhd7jR4LA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UI6gvBe14u2uLBZVpS6iy+OGPG+mzgFW6b7IZmhoMhHVkpLM
	eHww995XuxadN1Qpc/xesxw+W/YfpwKDk4CYt5a/IWdi2P+U7Ka7590x2aT7CQFuNlHERHnuyr2
	fzUq9YeExMEJO25NkLkQNokJzzGBIVKOgGl1jCV5WtiV1kTu1syUBmXgvUCdS2EEZTOKw80oJe5
	imC+aJudx8Jwx1C02thDabs4zTScCJLOjI6BT6cH1crV+B
X-Gm-Gg: Acq92OFpjaE8sOVzOzxf+yRz7QkJxMolZdSckJ2Hj6/4Fp1p/HlDlhO4QXpcDtQSASV
	D8jXPE5vPbZk760yjEjCTWyRSylcOD4O1s9i6dxmcpoiHmWjSnZU6XoqJUCO5EEerA703Rrx/C2
	XoB/mdEqmPvfyJedhA31TK8gxEF/V+5V4rH2Y+Qixg46cfCSB9aiVobI4VG/aDIG1RHoeLgpQHF
	m+9QsmNcKhPFPxnbQ==
X-Received: by 2002:a05:6214:400c:b0:8ae:6293:78ca with SMTP id 6a1803df08f44-8d1b0d8f6admr6649606d6.18.1781126351992;
        Wed, 10 Jun 2026 14:19:11 -0700 (PDT)
X-Received: by 2002:a05:6214:400c:b0:8ae:6293:78ca with SMTP id
 6a1803df08f44-8d1b0d8f6admr6649316d6.18.1781126351597; Wed, 10 Jun 2026
 14:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160634.246526-1-johan@kernel.org>
In-Reply-To: <20260609160634.246526-1-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 23:18:59 +0200
X-Gm-Features: AVVi8CeOXfi9JqEDnpFPZwBVwat-QjZxOlixTxLyqo7ZoBnvsHhB1ckfIAbny_4
Message-ID: <CAPx+jO9Mm=uVYugv641eiB-m2=jgHx2aGt33XoZC8=18ZNbckw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: fix early domain registration
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: TQOdfp2DuZA9NlSkvKQUjViefFKC18BF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfXxBUDBTKVVSFG
 T3c8JF0yMGkABAqVDY0GXsGdK4Vuw1aqvtGSag28L4otMAZWB+b4KUAy31MWbIyO1XuDU0t1hz9
 kIhxMUIg4ZUBj2K0eo2v/iasgyHbXGU=
X-Proofpoint-ORIG-GUID: TQOdfp2DuZA9NlSkvKQUjViefFKC18BF
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a29d4d0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tBb2bbeoAAAA:8
 a=7R_twnYr9fBWtDXhySAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=Oj-tNtZlA1e06AYgeCfH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX6Iz9QK7VdWFX
 wWK8Tl4ZCn5xVx5z6STt/rTRRgViZyLAI1Q6qUazEvmxOWYXoLLXlJ1vH9CJHRb4l/irmvns6YY
 FTU6neuEw5woli/H08Y4sMPCqQvBerNNKrkhpXe68A+rv+2j5mE+U9JAJj3b+2vsYgeS+4bQGbq
 K8pWY+ssXgTaQNDZvYcxIlTyVwwBXeDKOd6kZv1JAKiPM0ATA73hg1Q58F/mdidR9DwjuwwEyLn
 OLp3LXHPobx+K2xkmCPZPWVQVqP53sCfxh8fq/+XxSztCiyRSeVByH1S3hm5hlH5SAiTewE2AJB
 GftPny94hzFE0nih9ZjyrjM8Jeek1LWC/U3FdPQvG4YyaFV52DNRPQU6L64yjvgwy06xQ6OhL0E
 /1Q0X4g0IaJZ7TLJwL1M7h/FOIZ0nVMQg1vcRyK+d3uR2o+JKEpb1G3xTK+lflu+6RFIrHL+Ien
 rmfaF36KAYnM/KELY9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100204

On Tue, Jun 9, 2026 at 6:07=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> A recent change switching to a dynamically allocated root device broke
> platforms like rcar-sysc that registers PM domains before the PM domain
> bus itself has been registered (cf. commit c5ae5a0c6112 ("pmdomain:
> renesas: rcar-sysc: Add genpd OF provider at postcore_initcall")).
>
> Defer the assignment of the parent root device until the domain is
> registered with driver core to avoid it being left unset.
>
> Fixes: a96e40f4afdc ("pmdomain: core: switch to dynamic root device")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/r/CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2=
wRKNuwZUng@mail.gmail.com
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 3f265b57158a..19eaee1819c8 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2323,7 +2323,6 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>         device_initialize(&genpd->dev);
>         genpd->dev.release =3D genpd_provider_release;
>         genpd->dev.bus =3D &genpd_provider_bus_type;
> -       genpd->dev.parent =3D genpd_provider_bus;
>
>         if (!genpd_is_dev_name_fw(genpd)) {
>                 dev_set_name(&genpd->dev, "%s", genpd->name);
> @@ -2688,6 +2687,7 @@ int of_genpd_add_provider_simple(struct device_node=
 *np,
>         if (!genpd_present(genpd))
>                 return -EINVAL;
>
> +       genpd->dev.parent =3D genpd_provider_bus;
>         genpd->dev.of_node =3D np;
>
>         fwnode =3D of_fwnode_handle(np);
> @@ -2782,6 +2782,7 @@ int of_genpd_add_provider_onecell(struct device_nod=
e *np,
>                 if (!genpd_present(genpd))
>                         goto error;
>
> +               genpd->dev.parent =3D genpd_provider_bus;
>                 genpd->dev.of_node =3D np;
>
>                 if (sync_state && !genpd_is_no_sync_state(genpd)) {
> --
> 2.53.0
>
