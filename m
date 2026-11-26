Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699955;
	b=3wChsGn+RdfiS3GTeAgNJWX+ub3HWZQN+InW4zEIFc45CwMqtQJYbUirzZ3vuCDLLxnz
	 GX+fYkS4bb/E94lWTkv9nzaXFm6esXSYgNgdY9tIwdmp6ZhaOtNWH4K6Qgmw6VGiqddZD
	 3jxGQtX2nfNbGvse0d2UDnyDlBvJGISrJRQ47YgaQ4qnDsWXrDNo0abxyfef7yhAPbv5q
	 P2IPjzuas5KNzZrkcjYZqyAoNokS9oRi3D0Has8cEq6FBBLtgQxDilPGc/B3VkKtvN8n4
	 6gXv+8JqzQx0MdOjMxtngwUq4Egq6/cTkk/pBZ/rd8Ixi4whKmwMth8rN8bHMLMk+vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4yhN6/Aft4n7LT6aQzqG5kX6MMiq2h0tM47m4gebWsQ=;
	b=D7J0vECk/+z5nfR9/IkUbcOvQg4Yo9rxyQHfLnwGsJO1q9ORqDdiukhEJ4SE1MpkWFRz
	 Y0mroXDB/mNn0LHUbbeQ7OWpyDVNi/XFhhYTPGk3TKpqi6Lld7EBhQ6TrHvzZh70go+K/
	 zpi2/VothSzZE9vl0QXTa7NnYfZXesiZ4eovqnN8elJMdLlcslqoZXUqS2P2ioI4KAdAH
	 Z4B3EnaeXgmNUAbL0qQBYJcEx0IioUqOQ2GrB4kYIK/fmOg2Do03RarwxAuACcVZU97fP
	 +9EYjAmt4h1XyBv1VOTIIU9+8mZYPpaXy4sXdGoJvP7EXILFD3KaU/1qRi9sTRG6xcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PoPo7sJe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bn9NFgRB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E904606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E904606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PoPo7sJe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bn9NFgRB
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVpB1633250
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4yhN6/Aft4n7LT6aQzqG5kX6MMiq2h0tM47m4gebWsQ=; b=PoPo7sJeg+xtsXCK
	fu/4K/5jjRDVGzOFe1N/PocF2ucAdYwy+P/4K0O6OHFTo7jMYNoy5+WcCMRHfrSB
	GXVhj9pxbdKvvtTxFZfb6cGptg4VNZZA4KjdhPMVh8pjxBeNQIWta57Jdt2PiQlb
	6T1doTNGpPG6VqSY6o8JRYtFOcHhPghAG/trL/oAkmXB9GBYWP9Nsf36VCIT8eOS
	iIKfwj/TigRSmQ+BiHJUoZbvEFLS6AnULQw0xa1/TB5+vwvH0HGRf1uLVcQdD0QQ
	+TaOCz0Bgoy9Gdo2hPcOGNfiu3EYnl4adIRh4+jIDwWeTaB7zC95usDjj/ywD68c
	4M943Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne17nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0592d4539so7742662b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:32:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699952; cv=none;
        d=google.com; s=arc-20260327;
        b=obsr0TIZgO3OWg+jkUO6apx/uanG/8Onp69F6L16l523lwuPI/CweRL+oGp9bbvAZV
         y62MUpkg7V2zKpAsUK8AwwmFfodJMaS6ocXgExRiZo9LVVJi0VxN/5+v1IutljBcWh+N
         CP/Ar4PAwVZpuA6v6C8kkr//8PUh3hHuCXxeO81eirklj8GM86/GP2h4Wp60aIT1S+ue
         S16a7Qa5S3FQeeXt5XiTzgk4rpXBsw/rgrbcRXynapuxxuGpjTs8pVM3cA5/5tn/o60L
         yPzm/x3Ql8mO8jlVGeaoVQhQ3304q2pr0RDuxw5NhdTyCzkcFbqSpZzBIx4VK+0uAx5g
         CjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yhN6/Aft4n7LT6aQzqG5kX6MMiq2h0tM47m4gebWsQ=;
        fh=5py17VwORHczzRO/kp0ymRh7q4oyt228b2I/Wiu2ASA=;
        b=rLmQ664GfXDep0jx/H9nGtnH/fR8t74R7U5uf3bKRW0Ud6OQQLMkHEsJSqFqOvoI9n
         ZXISj7hJZSYpmEsG2nO8SwE8OLKnHeeOk7JTVUDCvjze6Lluw8d7c82EiX2uZmT+E8Am
         Gk6d6bu+fJP+O/fnQ2ODxusN8Gn6gh8EaaRYSpdGtFLppckmvgkMs3CteXNoYJ3nfvQC
         BX4I3zM8XOMXnSpjDjnxvUZrFARhDs9eiulVB6ZHQUwdP2Hq6Kq809EAmjcWdzqtcO9e
         N56GKCabXxuInYWq7DUVxwCf96sR739auOsNMFvIA/sSbK/RAKNkQDj2ouJvj5HutDs+
         9Ryw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699952; x=1796304752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yhN6/Aft4n7LT6aQzqG5kX6MMiq2h0tM47m4gebWsQ=;
        b=Bn9NFgRBU2XDrVmNMtEQIgtqmptwfMr9fHCDkhI/OlF/a+z4boNAAoFApnWYV1/U1U
         fOB0EreIMmS+KHsrNRv7NDSczM0fBmnqp03Mp3oVk0/FgVu3ns5IG2/Mj4/L5ER/xoNS
         rpgoEQZwfy0FRqDQG9OgDivqGeo2aPOBNtFijduSJee/bQ2k6M0C3sDGITcytaVgcMER
         gfHRujP6pdW3X/cazbh7DTVW8NUdL22TvWr1jjStGZYUMgraqApow6wUV7SplbYifVIA
         MDJNMCMa8wyqNza8YddvD03lN6Ww97vMTGi42P/d97I+uCpSjAXWSE3UVEL6D8nmT19G
         Qkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699952; x=1796304752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yhN6/Aft4n7LT6aQzqG5kX6MMiq2h0tM47m4gebWsQ=;
        b=o5RxQjD53lG2myXI3ypQevyyKc84e2eX3lzw3biQtu4kheT9IpL2IsG1WienX6NHR7
         EN2yhomFZCBvcbY1/bx7nDVi8i/+QTzIoAXRDEnh1/eYee7Mdd0QxsJbkO2+zffHoL2/
         BkuYShW52PYm+vtfDVnPuDmKjQkcb0y1mCIAtlXImqF1HII5qj74zCHdRQ0H4tBy2QjA
         czhGxh5EYU1AUM4kBGYxvfWM4C20TW5rkHeCWugmK00o8ja1xsRUiEjq1jfoNRM0wtxz
         CkpgIV+u2DWosKDPtsq/0vLQE4op6O0GvbbXA6v3azv6Yc4KmB+jV9EkidyQJpTuVerR
         BzUQ==
X-Forwarded-Encrypted: i=1; AL+hErG3srUxcPfLF27Gk7ZKkSIJNT8zofw2xQsKaO0wQbh2wY4D16LLQKKt6KgExyxjeVKmt0jEBn3MrA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+3h8FIJOHDLUGytdJL+kkAu7piLvCqaXJejXmbGEu814yXh93z
	0Ua6BwASa4c5KIjT6qtXsU7vz2yAU4tNL232KA+FvB+jL0/N0UnvSvrKJF/RKURZU7/G1R+3Rj/
	DuMeGbdUVN50EBP2t5r+Z5a1W5B22m48Oo4fpyftcpNSFHA2HTRwriuU6EXxqZ8HA42pcFy5hJm
	DFZda4goMs2anXQf7kxyjgYDX2RWt6xBgO1/Og
X-Gm-Gg: AZFdTZfvSaEJJKYZiPJcmbBoWJTeuH0J9/Q4IDJ2J54MeWBdcpbPQP67GdyCsTZQGK/
	KTQ4BSYUrCeDdmjTdCWS+31TKFC6kCzbiwGux5yT9GgVrTgK53pbvZ6I5wTXtNEIll/tSaEul19
	Qb3bMzKsi9B+iPtSvXqGtOgMTrd10im4smv0tt7ANzKCA7GfPhaajwz8XIAA==
X-Received: by 2002:a05:6a00:3998:b0:8a0:5da1:2264 with SMTP id d2e1a72fcca58-8c87d2289f9mr17554757b3a.47.1795699952408;
        Thu, 26 Nov 2026 05:32:32 -0800 (PST)
X-Received: by 2002:a05:6a00:3998:b0:8a0:5da1:2264 with SMTP id
 d2e1a72fcca58-8c87d2289f9mr17554733b3a.47.1795699951925; Thu, 26 Nov 2026
 05:32:31 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_3D56658FAE8FA8158A1175935B194992D907@qq.com>
In-Reply-To: <tencent_3D56658FAE8FA8158A1175935B194992D907@qq.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:32:20 +0100
X-Gm-Features: Aa3M54qXSJDQK9M8_TJey7rIFwFmkk5uLORdWM7iQeDYcpEdTPrd_CxmSK3nm9E
Message-ID: <CAPx+jO-JsScaTCX4_OTxGf21b-yTGxqGcLRVGitHrK0rKU-yKQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: samsung: fix device node leak in exynos_pd_probe()
To: Yuwei Chen <2522445001@qq.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b0834f1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=dZbOZ2KzAAAA:8 a=VwQbUJbxAAAA:8
 a=mD-zHhwtQrdt06HBgxkA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX/5HgK4l6otrB
 uc6iEeS3Z64aWg0NGxzHmiV+PPHPEtatNvcgbKaymV32/BGWFPmC0/m1s44dR5XDav78xFboo81
 aVld+2AYHSFaUqfFJannw0bhZob4bQUiSSwzR7eCrKt/Osh5GUx3ewA3mPwppBX5IdoS6j1QFka
 ZwlXV+gnqhN6rE+TZXHbVjnD5NCNOwK65/0MbrK+KijkiJcMNUnx+Vpse9p69rkTcqyTRNl/3Mv
 v6tFf29hT/6/UDJ4TcGh2Q4s04HUpMFYZr/25DtsoV1wvs0y7Y+EHAZMFr4H8nLp6rOkmbs8Atx
 8hNlx472j/D6gE4HoE4CV4sqKtnZQiSB/m9QMLhN+iyXczOdlrx3LM3f4gbdubpIYrfaieHS/Wj
 v4wLqftRZ/SAnzCU90dGLru29Y0G14KHztBnXaaoCIQ1jnOsvTKC7nT8A78qjExR5zLziEdd1oD
 LpakOLD1mgmB9MllrcQ==
X-Proofpoint-GUID: 5b0m9XH_seTmZm7OiM1rTzP8MkzEFkjS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX9k6jumRV19r9
 twF6NnqmMdFOIlBuR6Z1MgE4yJyj2bldXi8T/Dsw2ECUxSvBV892OWd15ULT/j8wa830bVqYbtU
 LXAIVddrsCzh6Oc3LIjosZhC9Ro5t7w=
X-Proofpoint-ORIG-GUID: 5b0m9XH_seTmZm7OiM1rTzP8MkzEFkjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Thu, Nov 26, 2026 at 5:26=E2=80=AFAM Yuwei Chen <2522445001@qq.com> wrot=
e:
>
> exynos_pd_probe() looks up the parent power domain with
> of_parse_phandle_with_args(). The caller must of_node_put() the node
> returned in parent.np. of_genpd_add_subdomain() only compares that
> pointer, and probe never drops it, so each domain with a parent leaks
> one reference. child.np is assigned from dev->of_node and already
> belongs to the device.
>
> The lookup runs from core_initcall. The extra reference pins that
> static parent node for the rest of the boot.
>
> Drop parent.np after the subdomain is registered and after the
> messages that print the node.
>
> Earlier trees keep this driver at drivers/soc/samsung/pm_domains.c, so
> this diff does not apply there.
>
> Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platfo=
rm driver")
> Cc: stable@vger.kernel.org # v6.6+
> Signed-off-by: Yuwei Chen <2522445001@qq.com>

Applied for fixes and by slimming down the commit message a bit, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index c8c2ea06e990..01017c406fe6 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -153,6 +153,7 @@ static int exynos_pd_probe(struct platform_device *pd=
ev)
>                 else
>                         pr_info("%pOF has as child subdomain: %pOF.\n",
>                                 parent.np, child.np);
> +               of_node_put(parent.np);
>         }
>
>         pm_runtime_enable(dev);
>
> base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
> --
> 2.53.0.windows.2
>
