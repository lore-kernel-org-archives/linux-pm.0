Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697E40D568
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186864; cv=pass; b=ZrdkLl3K9k22P00OJ7KsMzchRD2keITLHHJmV4nKVeKsrQgMg385VllxJYi6pN6QaBIPtL5HOrWG+0we1KpuF1Aho1T7MjCcCG87BsH8oHaSdbe7VqQFL92E4zC4QBMnOExC8wT5kx1Xr+dTtdHZqEzWMbyn8UM31q3ozqb+GQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186864; c=relaxed/simple;
	bh=tf6N+YFGI2t1NgmDwm/+qg827DwB0lvZG+rSjvq+UmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujBqa6t+JtQYEwbL3RXICy0CNdV6U3W+gDgXoBwHHxsEfKP6tqigIgv4kaLCoH7yZXqRkfwfb8/bB4+OeSKlaLzz580c+NzjeWNUusdJGsgMDcUhzv1AO32NKQwTY4Ne+bADQDiba1bzdGNJi5sounQfEoAgwwhHQqIpBhvRbTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WUwbD/y/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhvhoAB6; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUwbD/y/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhvhoAB6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCSlJ7617030
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 14:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qxGYRYamjLz+QHgkgiHarN2TURElbcvw19bMpdqeIss=; b=WUwbD/y/a4X+KCMx
	vj+VNVdUIt4R94WWerVrKQOBx3pSMk7GA0FsFwEQ3JbmkIoO0ttvtdE8lonX4qud
	1EqIxZaV3cGLijZx9IWwgvYpEFiZ/keDKITndubGWmG5gYJetABts/1m06PYGIvA
	YAb7fnEtG/LFi5M5eub7yBB8A/jXCFhuFanKAsTqAz0g3sYUdBchNdq9Hb3IZkW/
	i+oJBVn4C5ZIr3BjxKi1H9nk9TA0dGiRWgTHUS4DiTxR94aIfQCqFZQWE0OjSz2E
	4OMG2x0C4HrYzchqVcXtpIqk79g4Fs5Wmejc1GPS+/yW6PCVFrHmhVg8imwFAsGF
	U+88yg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tkthh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 14:07:43 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69e96638382so4100473eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 07:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781186862; cv=none;
        d=google.com; s=arc-20240605;
        b=Dl62CEooqtePcNeAhsRPV/f8eSn4eanXmYCGSFAGDVlIC7HkKReCTS8SI3wM2khSXp
         bRk7saas3aWL1rJFJwwc4bewVa4qGyhc+/os+wD4/R+rYlnHlO8US+RyZdxjKheBcc9a
         JqBMpztIWleSwr5EUzSqQjagfwH1y3JM+Bqhqbf+jwBMRlgQhypvENtlauw5pfXz9LAZ
         YDXKk9dMnTamDagp5J4akpgYChAMSdH3ikNvy65Sl1smhFhGgPqY7JmcZXAWmXZKYcVu
         9TWOZQXba0Gej5l8eAI1w9mG9C+hUuEiSAhuRjb8tVHGhaDHd2uxrMDd1g+Km4Oa3+VN
         2SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qxGYRYamjLz+QHgkgiHarN2TURElbcvw19bMpdqeIss=;
        fh=/32neIaeg/BpBbhn9aIKIPBTMghMXHTrz4eQqKX5XTA=;
        b=WJkM/PwgGreNPQPxiYqlzeuPcMpRC/KmDlB0a7anWXHhSsj7geitMECKz0yZkiPibp
         36Z5sIbotrzChxkEg+6XVG3PLJ4VPs3ooS5x9w5UlheC0Xek9TENI1TjGWhYVj9UHALE
         V+T2BmKt2/Isgc2ArCrMwBw4dRU7Rr9nhrIuQmGUw58yEBrjQcBCwlCsNOSp9w6gg4YK
         jbU8ickNVMFj8ISwI7/Xbn5TK2vplcOyu7vZ1bDA3jgTumyPUs/YR78cB7YCjrO+Q5Ec
         Qj2BkEq/D6ob97hwUCQcXLUNfD1hA7Jc9c2ORjE490eAnyZA63D7W7XdDxcWigIHOErR
         fHTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781186862; x=1781791662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxGYRYamjLz+QHgkgiHarN2TURElbcvw19bMpdqeIss=;
        b=FhvhoAB6hUTLpcPMwEfsGsVsG5LeKdAYbLk4mfwMUkNpEcMmvGYFJQakjUxxLkXjBM
         y1+em7ge7nspRASWe3UFN8nwSRkhxeH0nG9pJe0BvqQrLRf5PNFAqlpoe1ECr0SMCnr7
         Bx4Fh3KyH434R2UMKLv2QIXdQvwaZKRm60O7JbJaXCEaNjE4LsfSeZ27+bPgQagdJh0g
         afo7j5G1ESwpCETtUtp+T/bO9EGrVLKtlMloDOZZiArpqHQV0gOodvf+sBxGfBOV0Vqa
         seu1WspM5ZESXu25tYnb4rfAy36N14YqCv4FCSkmQPfai5TW7fZUuonEZHGSXTNLtXKN
         BAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781186862; x=1781791662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qxGYRYamjLz+QHgkgiHarN2TURElbcvw19bMpdqeIss=;
        b=Wx6ezWF2icPh5KqgfxUK+oESkqccSICGPzrd7dM1HwPf04kTyCMFrbgthqmtEMv2xw
         Bdzo71t2V8r1zUSPPz7dr51YdWSJFCbX9GETMFnRU64ncDzEgdsjCYEJLAZibaNW6Nfe
         ZjC5S0k1K/CbqmOW56LqU+AMbEKKgw6wm6DqdAoQcyIfOBGpgK+dV0k5yp0F04+YzcO1
         w3nB61pCjZincM3VeLuGsZnCzgaOKhsc1ICQOSX4RQrVa6fSqqpn8FUbE4RNzZA75vqg
         nTDvF+0d4j3Av7gjcseJ1UQplTocO9SxdrQuL+2pSovdJbvEBMc3fcPbktfP1dareOzu
         RKVw==
X-Forwarded-Encrypted: i=1; AFNElJ/WE8q8SuK6ECBB6u9QmCFanOlxpYwWllfHXamAdxII9k6bNw1Y5XRjCSqEowgVECCEuEuh/zvaHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYveX6XswO7285Hk4LvO/ynKh6JjCJs3xpl40zCi0m8RAALFDl
	FdsXbcwc4v/pz0clmW0XPgGje1/aeVyqhSXp29I98h5VWfNEYE9dDA4D2mLFlenSoBpQGNDiiUH
	0T7In4rR1GlnySKhtWe8PNmnXfegWe6EAj+m/iLespEMB063FRwFowz/0Jqg5RG8FqpqFk3dKom
	8jEY+s02z2zP4DjBTioP0ZORqHqhz3WFjGOH+o
X-Gm-Gg: Acq92OEx7XJuhW2x55fZkPV8wJsnhHcaAL6EWEycFUcXwFecn8u41kuVC0niuddeVSA
	T45K0dlmyFK+l939MZZFoLFl3/TldoxqbNafsIXtP0Hs5eT2f4c60U63x2mE83R2tvDEmpf3j2S
	jAkxDhmcquzg4OXlrNkvyOiewO949P3o6Hzkfq+SFEHot8iG9HKlIvferFKApW0Rwu27S5UHAtF
	3p+2lZNjXbKMwR41A==
X-Received: by 2002:a05:6820:80e:b0:69e:8698:3cb9 with SMTP id 006d021491bc7-69ecadda53dmr2032370eaf.6.1781186862314;
        Thu, 11 Jun 2026 07:07:42 -0700 (PDT)
X-Received: by 2002:a05:6820:80e:b0:69e:8698:3cb9 with SMTP id
 006d021491bc7-69ecadda53dmr2032323eaf.6.1781186861896; Thu, 11 Jun 2026
 07:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611120345.484283-1-johan@kernel.org>
In-Reply-To: <20260611120345.484283-1-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 16:07:29 +0200
X-Gm-Features: AVVi8CeSVg5hk4TnnlX6Hs6e-u70oKAggBJHUm4jaTPSbzJVAi9Jt4WmBnQ2ka0
Message-ID: <CAPx+jO_8hAv+DR-=Nk9_DD_9kSQFVKfHwf9bZABvooVFuQN2_A@mail.gmail.com>
Subject: Re: [PATCH] pmdomains: fix unused variable warning with !PM_GENERIC_DOMAINS_OF
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MSBTYWx0ZWRfX6KVujtXKGH9U
 cOCpJzmpurdv4EUoLxdt63BKVZoxWpxWnjuEVaHhJLXZSKByUFZaBVGCPawncFIPPhQU8C6KJgz
 Y9F72y+GxPnYMTr9uFuhBjym4CSWfKVY4d4HJ07Hisb0JglS6o4ybXKVLP+1jznl/OR9ZBtfmyH
 JE0NImGZq9LDE0In1JN/TEj/b/ayjYo7sbzTqlq6GaIgY0YXFKSUf7FyGvgXrnRajCDN6MXbsBz
 GmVROh0TnekyUdvFEzGqdhjccRyL21eoI4M17BY9VgRgMc91bU1stMlYmpxbbHNoKLg/I9pke0K
 7kIrxiy4uGjzcdRakGoVnqpaB4w3b95H2EwQgcNLvmFbemkYawgX8uj9MBAwPnKptbDqQwmd5HP
 h3080b66BwLwPlXyBOCoTE6IQfwmOlzoDxaKr5X9Y+l3I+AB/X5y121JUfvx6yHtvzsq8pXIgzw
 93pNNBny4NxUst1wLTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MSBTYWx0ZWRfX45UAa72BDbqe
 g/Ce7IF3B/jdwaUVNvOm1dwEoWoYemUk4C5iETyfOZlZv3kZ4Z8JMMiVhdKS4wzeysdKMmYPNcu
 E4kwHpiU6Qp5gHFl8YVhhtBXNNNzxns=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2ac12f cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=Z2IhxlMJ4wUvDYWZFgwA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: lZWrPqNnyVrucFrRUD1aSTdYyejiUQSY
X-Proofpoint-GUID: lZWrPqNnyVrucFrRUD1aSTdYyejiUQSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110141

On Thu, Jun 11, 2026 at 2:04=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> The genpd provider bus is really only used when
> CONFIG_PM_GENERIC_DOMAINS_OF is enabled, and since the recent deferred
> initialisation of domain parent devices, the root device pointer is
> otherwise unused.
>
> Fix the unused variable warning by moving the definition of the root
> device pointer inside the corresponding ifdef.
>
> Fixes: ea1ca7623281 ("pmdomain: fix early domain registration")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606111746.kAxaAbwg-lkp@i=
ntel.com/
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 19eaee1819c8..f60eac6aa2ca 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -32,9 +32,6 @@ static const struct bus_type genpd_provider_bus_type =
=3D {
>         .name           =3D "genpd_provider",
>  };
>
> -/* The parent for genpd_provider devices. */
> -static struct device *genpd_provider_bus;
> -
>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
> @@ -2566,6 +2563,10 @@ struct of_genpd_provider {
>  static LIST_HEAD(of_genpd_providers);
>  /* Mutex to protect the list above. */
>  static DEFINE_MUTEX(of_genpd_mutex);
> +
> +/* The parent for genpd_provider devices. */
> +static struct device *genpd_provider_bus;
> +
>  /* Used to prevent registering devices before the bus. */
>  static bool genpd_bus_registered;
>
> --
> 2.53.0
>
