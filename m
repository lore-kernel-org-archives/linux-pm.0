Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A73F8717
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204910; cv=pass; b=CP0P8CWkCiOT9JWg0IL/Q88HxyiDFtfxqtEh1TinQRCIsbn0oIJI5HPuCIpw6diRdBwj0CHw4MNt2yCIf+rzBJNTQf4F1Fj2ydyI0goptulpM/Oe9nFBlA0Xd8BriEGFjTXVuD66tDNQLtOTrH+HDmjaixYakB5b/R4mpFwXoG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204910; c=relaxed/simple;
	bh=X72llEmYFZFJsWlY/4NulzKTllajnUnvxlFtgtWKz/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=io11ntYKH3ZIVpyZBP7A0IbqBQ6mg3+haR75rgDO2ifiL/MyV2I4UMOVx30SWwxBk7fXJ2hUQZbbpGnRdZJkSOkd6M6XECu0sWEBKUKH6kfsPQKcqGr0fpQBvZZNMwZCkH+gEPOACpbyRaQ10H7LjmrdjOrXDWv8crl6siF2vCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAFI5Gny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8s5pfF4; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAFI5Gny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8s5pfF4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBioHM2355516
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zw03qpSA/Jfcy1c52xfOXzDroG6bM4Pn/3P/eMeeGu0=; b=NAFI5GnysCRzYjpU
	Bz+EeYTG8ZydNVKZsAmK/0k36tCekALutDa+vAOwpTiJ8Yxbf5ebj+N3wubi4NHh
	q05tY4kASLNRgFCjj2AHbu3zDh4mLVrExrhR4PjjDbeevh4ziLOkrWGaWfGBPXK3
	GuMKjyjxPdNdqH2QuK/pi+YS5D7019295TRDNnPpJlIPh4sE+NrBp2Bmdzjm7pX4
	ooYLNwJgaZpkJE2o0KLLO7Z5UgokXGYXjTJDX9ehCzdBzngNdn3xlJUl06cNoJLU
	JsnvVfoW4GlwTP66cQkQKDlO/KBN1b2DNqL2Fedkxres8oUoDgAK/aGgtBETciW9
	SS0osQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed064bac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:28:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f08560ea44so62087556d6.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204907; cv=none;
        d=google.com; s=arc-20260327;
        b=cQ3K2Y6aqyPVWdbtarbtPYuZE87j5JK1NPXKpzTcgqRv3118tbA1Jh8ODTlXumNhg/
         nlRbfGOOK/OjPWUb/4QLlno5eerDCV/pExvbW1XCzrh9JOYsop2OW/Ei+5CItQW3vrvD
         unVzU7BicNeuo4A/4GQSJzNkFMlONYi0j/15SciOWgyXp5vsr6EpGSRJF+cr54EtKK4r
         MRboil6EekQCMXWbv7bP9WZXqesGra+IVWRvWpFtOYh8sJgZpA6WPW+i4afcQ75y7Ysu
         sIlZpzx86lIFjFoLi2o/uDhkobgb0/N9vQfnZBg5acr1dWLlXsD5bMYO0IqBlE1JGMsa
         vdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zw03qpSA/Jfcy1c52xfOXzDroG6bM4Pn/3P/eMeeGu0=;
        fh=5YG7E7YQAD2gOxQjrvrFtI32YytSsuZlYZDI/JnPCfY=;
        b=HJD6PvtPvwQzUUyR1NlpyxOu0WM2QZVQcZWyFJKajws5NG2tdQ+0HTp5S3g8KnrfGk
         OwcPNFyXDcvhFEf7M3Wu1PkVkQckILJvoX6bDKFC5oHrbQREnS4LADkEIssnII8PFwUv
         dss7SZjw8hE0D/Oxt4gxqA1r8mYdJh292mJEa1hvFAlpeopAz6c9WaZsNd3SogVwlXyd
         9qroY/pdgfXPJcdgbaks0fOr+0LHe4u5CHwthGFfwLGshVmCnyXHuJmUgLdNOmjqDKIp
         Cf42cJGWNnsZtHxK7cUnlL3UQUGZOdl0QQByK54brHnH80Zlz1v9eayH08d4AvcmclTo
         mzIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784204907; x=1784809707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zw03qpSA/Jfcy1c52xfOXzDroG6bM4Pn/3P/eMeeGu0=;
        b=G8s5pfF4INlf3CZDfbJRa/IYmWTCDcTXjg+dZg8N4JYgEj3J0dVJWpJM8lKn848a0T
         46V1rflC4zk49mQs3Asmo+8NeeOdjUgtNgrnjPlb8v8ADnJukTOlePDJJnI9nRTDfweP
         hSNFByj1bwHBvNan2jw/YY7z82oLI57NtETEYOJg5uGNinUhvNXC9ENx4P1CldAtujIy
         R2GMGZFcMq/BiP1xlDYlRvLVMliHmDCfPxbK7SUngwXgOjeWZybv6Ygzpo2qE6SNCUS1
         TJ+OVDPN56ZKcFPI55J4bsXQqbzLVFPyGslbCHF4pSoEuPBnzZ9+qBuhe/CdFMWGpx24
         68yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204907; x=1784809707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zw03qpSA/Jfcy1c52xfOXzDroG6bM4Pn/3P/eMeeGu0=;
        b=YHJfbrQ8Z5vN75pYvRKhUre+IkLX7j5J0mmHxLUPNQKS4/EMkeL8i1vllkaASd3I4o
         /tQ9ybRQxCGiE82yPDfFbCiaPiCODMY4XE7WkgN1NtQfw9VGyWfS9lpFpcu1BdieszZ2
         s3YNs5R6h4ywfrb2G6zn9lUuSoTc5HdCxAfZZsAAw8UQcQJRZEAlzWThpk5cPeniGrme
         MuvaoB/6i96G8kH47eQi3ZXP1qukBxlsPfvW54IHzhdwVBxJWb/Qsjo3G4lMWsRio7Er
         9TRx8Tf/7c7XMR7NzphrJU9Wr/q+HOPwNRyvQvQJrMDQqrLVKgclFx1H/p8PGY1ohVVs
         XZ8g==
X-Forwarded-Encrypted: i=1; AHgh+Ro9nGC+2Ojghqpg1tmegenY5Iv3vUAj4omo2Hlt9UuYh8GuUiKq65O1SZVoQYOf2E8Zt+4u/AE7eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gpS7vTSVnT8KyBi8nuMJ/F+EGe0RduYpbhCEQ+4z3dDmAsC+
	nIQh+7LabqvdJFaon8onEo3+FlA9s5ji8sKpLW6Tsh8T9SClKwE6/yadniF771VUTvH4DzA9rmj
	KhknVPz5BJpfXbBXf+dJz68XRtc7HcdUI+ViiynBdJLYay3AEYKphA4kfb+hFXKqlFMKL2OeRqy
	38vjdJSLTeQSkQ0lcZyIl4makfnFfPB+bNcEVH
X-Gm-Gg: AfdE7cnWvF/g1dTowdRc2Fl39C0eqc2kkw61itMuSEvj2+95svzrRXbX04fqNXj2koD
	e0EvnEHi0NRw3rDxLxIR73ZdeYIsqbGQ9eqxbmQEWF8yL794e03jFCsgDCWMMyydTDMTAclRp1p
	5T+/dPHRbOtjc8fEjyPil+WUaWhZTsmZDg9yMvTxcz9E3z0PpXf63y4oeBFw==
X-Received: by 2002:a05:6214:3212:b0:8fd:d5a7:f970 with SMTP id 6a1803df08f44-903ff7625e9mr263482186d6.11.1784204907081;
        Thu, 16 Jul 2026 05:28:27 -0700 (PDT)
X-Received: by 2002:a05:6214:3212:b0:8fd:d5a7:f970 with SMTP id
 6a1803df08f44-903ff7625e9mr263481916d6.11.1784204906676; Thu, 16 Jul 2026
 05:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-rpi-pm-remove-v1-1-e4eed226e08a@linutronix.de>
In-Reply-To: <20260715-rpi-pm-remove-v1-1-e4eed226e08a@linutronix.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:28:15 +0200
X-Gm-Features: AUfX_myr8HhSmFfAg2iBLZxbDJBG1dywFK58stWc9YDsp2w2MDb2aj6qKlaRYNc
Message-ID: <CAPx+jO8EPX2br9vsuFXBDPoQTF+Ks09MFcFQzchZxZVaj7y=-w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: raspberrypi-power: add remove function
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX6MWZfdSVaLyc
 UcjHtbvZSLIWJ64hXro1tM0U4SJ4InbTHpKAWWrbXAxntkzZA4NJwFMCdjaH3IlKYhFRk+b4KIR
 h38f1EcevZanPYhHVkZefOJV+/qmf+A=
X-Proofpoint-GUID: YeaBI5osrqVmVhe1ngGzmE1qXzcimN31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX+jb1l3XdNTcJ
 AhuvNEigFP1m2B8MNptfyfKbvr2rp/mEGO2XO8aAvIp1+YT/Sr0f6t+mKYYG1xOxJ99Tyl/E71W
 uz13K3kGZ5SuQ+72F5PcSSTtVMe4DdLCo0LZVkYIo5S5WoyrCMULNqNk5iXw4Gmo7WmtwZLgDTg
 vrhN9U0vaWdVyN28mlOB+ip3j0ud4YiGjLy7USl9GWfjZZyl7FST6/J9SnVNRcD5fEK65qDFv7P
 eqymFI/ZSADOu4q+y7Z93mqSxzeT0Uahd+0VIYE7gmmYU1Z2jpHO0hG5zXjHT4xw18zUPQQU6bt
 Nt9DKJeI/InbT9LYMY4dsMv1C+iyx1dKL/6DF4rgYSyDZcXZmCiHUZ2UthAaUiFUpx+Bcv+mX3i
 AM27uKO36fXIgHidUtp0gL5JC74VDDUq4j08J0Od2ROO2lOOt6COD7pAoAKPeUQmpCD8uETSFk9
 717jIttl8nIm2yw/yBQ==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a58ce6c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=H0uma_0KToxzU7pGOuQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: YeaBI5osrqVmVhe1ngGzmE1qXzcimN31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129

On Wed, Jul 15, 2026 at 10:16=E2=80=AFAM Gregor Herburger
<gregor.herburger@linutronix.de> wrote:
>
> The raspberrypi-power driver registers resources with
> of_genpd_add_provider_onecell and pm_genpd_init but never removes them.
> When the driver gets unbound and bound again this causes error. Add a
> remove function to cleanup all registered resources.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
>  drivers/pmdomain/bcm/raspberrypi-power.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/=
bcm/raspberrypi-power.c
> index b87ea7adb7bea..2c2135c17afb0 100644
> --- a/drivers/pmdomain/bcm/raspberrypi-power.c
> +++ b/drivers/pmdomain/bcm/raspberrypi-power.c
> @@ -232,6 +232,17 @@ static int rpi_power_probe(struct platform_device *p=
dev)
>         return 0;
>  }
>
> +static void rpi_power_remove(struct platform_device *pdev)
> +{
> +       struct rpi_power_domains *rpi_domains =3D platform_get_drvdata(pd=
ev);
> +       int nr_domains =3D RPI_POWER_DOMAIN_COUNT - 1;
> +
> +       of_genpd_del_provider(pdev->dev.of_node);
> +
> +       for (int i =3D nr_domains; i >=3D 0; i--)
> +               pm_genpd_remove(&rpi_domains->domains[i].base);
> +}
> +
>  static const struct of_device_id rpi_power_of_match[] =3D {
>         { .compatible =3D "raspberrypi,bcm2835-power", },
>         {},
> @@ -244,6 +255,7 @@ static struct platform_driver rpi_power_driver =3D {
>                 .of_match_table =3D rpi_power_of_match,
>         },
>         .probe          =3D rpi_power_probe,
> +       .remove         =3D rpi_power_remove,

In general it's not a good idea to allow unbinding power domain
drivers, as it will probably break consumers and their drivers.
Although, I don't know whether it makes sense in this particular case.

Another option is to prevent user-space from unbinding by adding the below =
here:
".suppress_bind_attrs =3D true,"

>  };
>  builtin_platform_driver(rpi_power_driver);
>

Kind regards
Uffe
