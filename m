Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92448379C43
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940779; cv=pass; b=iWJXhUNZPpOsoD1vIX/3Bgv/RLAZvZximkUGzQgQHBX/f5/BhHzMPzVk98QylWuzcNRyRPferVg1ChtdYW9VUl0+jXbljV/bbLFO5yng6NGlxRr1mC3UqfyC0SaEhuOFJM12LdhpDehuUDiuKeMORlEshTuRgg2VY5gd0LMrAms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940779; c=relaxed/simple;
	bh=l4Rk82QS/w6unTr9+wJUtkC3WOPQjL2mhjLMUHY3NWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm3Xe3ek+TDTOKOWzj8Gv4A5SxlSg6wLv4sqeYU0B/T00kLVp5dAmGoC2EzSMihZ8rx5xwrBBjTy3CfMXag5i7dVyctLML6Cjj2pr0MQjdRigW2OATVduZqvLZFLYPpEuttRLEz4WD7vtb/D/91OB1ETuJamOjWHcgKbV13cFxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZuvx5BP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZL+UYfST; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZuvx5BP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZL+UYfST"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D994d3793548
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MQwQS+P0In/tSfCSz/KgwVUgfBQ1+zeASmjyD33V1A4=; b=FZuvx5BP2TEcdOCr
	Q0+YvVkbsf0w394AYZqX+t1q6oZpOxjUTAgoWCfRrY2QzPycABl23Aw+m4A7pzae
	q2PqbXQhLWfu8i/YNzSThqsHLImjVecIz02rP5648jFyYjcmtExOxfVQkq4UUqBF
	vC8FtC+P6z2041LLd3rPjLMM9VyDedVnhJn5u7cedX3uST+cfjzTD3JBLgG/pjBa
	YfVUVfwvzAwSuUqsxC2KPfujESvaJVkcWtmwBfslU/uyOVpXAJIDVzQu3OOvvtYm
	d+unfm0LmPZ9AnLxD9sAA9G8FtJ2dQAkwnB4f8rPDxqvOO5HpDVc/0D/cqVN+KbG
	Ax97Fw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qrcwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eac2620cb0so52460316d6.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940777; cv=none;
        d=google.com; s=arc-20260327;
        b=CoOHSeERVT6TukzCUhLeygcjGNtNNycYlE3S3g3mRfxRTTdHar7yCpJZF4K/1MbZn9
         1D3dx5gSUDcJvoGA0VD+XnpN3D616c+r7cn9lNjTPnNBOKyLtCxtkBqIhm5TU9hsEQB/
         IOD3wmJNTFk4RUeJqXwIgopZ1Q+QUMXSpQV1IA9RdtOYUYKhrZw2P4cn+Yup3391H57E
         Fb+L1OifKxqmkWMfGCGjijg/ksvl4PdtcBdzhc30L1Z4ZTqNUEpTp+6GAXDZKNwseIGw
         oL9ywheFhsjin7amloYVp6utEaZ/Gyslme64xuYgo55bMpHBi1XMnukNef1tH1doNHNV
         LejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MQwQS+P0In/tSfCSz/KgwVUgfBQ1+zeASmjyD33V1A4=;
        fh=88jm8adOeaOldNwFv+3udrCYQRsI470Yo1WyK81xdg0=;
        b=iEni2CxEUQ/Kc/6XqXRAKjBpFbBsW2CnjBw8FmqjVlAymvcetwxvre4bT16+9B9i8o
         lujgvUf5lO6oVgEPLd1vr2rtM+zsmHJg1xNKtZljPwMqoeuPqR7pSoc5jA8gTzKOveu3
         Lyrg7uiCkS0kapEQiC/an4HfyHzWoKiGNj90+ZxX380pDa3FOsDOrfzNhHGxjQSxBsJU
         6j/HkeH75ke9SRUqsXZrRIMew+HZWjEFLWhm6hyEEYckaSu0KRs5X2K/AOvpGrdjp7W1
         aImxHDYCqw6GKy2taTjlYhGHUdS7H8xlcGqxlnN82TAAjHyi1IC9Pz3MHzxUKZtCwqra
         7wbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783940777; x=1784545577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQwQS+P0In/tSfCSz/KgwVUgfBQ1+zeASmjyD33V1A4=;
        b=ZL+UYfST5HcqJNeDLIDlsVe3E3bpMGQgv6vJk5U/jv900RVrE62FFR4sFgF/e+t88P
         bIb2WDXsSJIlx+UTZ2EFNGtVzDFu2R+THUaZM/4thWLpWKwPg2NArjjCkGY4gEkQa/hs
         95QfrclGzHDM6k8bMx9g69OWsbUBoGNJmiwB18FsJ8wKyj74OnMAcyGuZiVApHLxLbFm
         Ylkxm+uIFuL77VRQWDhLkYxrjEzgXtUY2wMEPNRPf0+++zu8TuYcfvJbjFVwCkBERZuM
         5nMQyI9UaVLl2DL/Hts6dwLavmOi5sYQqfdC53FHSzemax0UVKYmihJABV0AXNMHXDCL
         LA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940777; x=1784545577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQwQS+P0In/tSfCSz/KgwVUgfBQ1+zeASmjyD33V1A4=;
        b=Pj9qzypEx5dSf5rz1o1+GEc60VYxBx3Q42OVOAzVjFpvmiLpcvqOlsyInCLXUG0DQW
         jCt4WR+pacZPddwWt8/HF8N3uMrSYRRz76DMgiLpd/8qEjZwl55Q4TrN2owUbGuR+79T
         FUYSqMtB85Cf43i3Q1WJtqZHszhqRTQOpSfZ5+UxuGY/lkg2YKTedA/tfosMG4VehEbX
         9E+yTr/rtO+NEmhIzyYHxV7sXMXKxGxjQ2Rp3v8+A3UK6oOg6s4vkTmi9NoAMSMT0Ywe
         EBnadpR4/MSrsbfQr71Mfpth0kMCfwYL0c4xOBbs3ESXm5cYhUAdqPvlobu5SPvH+2tV
         dTkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpok7CYqZnf5I2iZat5oTUfq4BhxZZTtqcvegXmq7GQos9EU/1c1ADeshoiXmTtXd9dCd+r+g0vPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEprDXLt7tJ55byBKW/6AGMykPy9DLLY6kh+EgYwXayRZRWoX
	ONGk7pExuir4YQ1JCEeTgKEEWdCSTS/To+QuST4Nm1rF9FtJzijKRdHj/uxF2XDR/rqB+RuRz2f
	s9s/N8YluiwbKL2o1yIvRFx8Hvjk/Jib5oYDl5FCpvB0hmKSArfmnS5DRRTawRuPu77W7OYFahu
	Xg8vVXuMGOu+bkgW5XLC8Pj+l3CT8e9R8sSnEF
X-Gm-Gg: AfdE7cleaGyDFjcvPI0qhnaOxXceOeRnkVMDjz7T/MXSIZqIN7ALGip5xMk9LrCw666
	y7S0eSbeOWHmLj5zWcCv2iWriXFd7ih3WWOAXRUjY9pZtBQ623guX3vE6BeOTLTL/vQ9uBnw/sL
	Q7UNvYdL2WwMFoK8Pk3UiD7xHI+D6Vz1q5g0ejm3Vgw9e5BSowF0971PV9zN6d04+oZ254
X-Received: by 2002:a05:6214:55c8:b0:8e9:f62b:8f8d with SMTP id 6a1803df08f44-90402368f16mr93379586d6.51.1783940776870;
        Mon, 13 Jul 2026 04:06:16 -0700 (PDT)
X-Received: by 2002:a05:6214:55c8:b0:8e9:f62b:8f8d with SMTP id
 6a1803df08f44-90402368f16mr93379196d6.51.1783940776521; Mon, 13 Jul 2026
 04:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623135937.60740-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260623135937.60740-1-pengpeng@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:06:05 +0200
X-Gm-Features: AUfX_mzuUAbrt-biys8fUHWI-1r9K_KkXYeMxM3f0b6Z4UYxUfZu83suu6CUjU8
Message-ID: <CAPx+jO-nJ81xs0tWVQB=eMZq5muTFTzLmHS8za8ScrD4B8XYpw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: bcm: bcm2835: handle genpd provider
 registration errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
        Stanimir Varbanov <svarbanov@suse.de>, Eric Anholt <eric@anholt.net>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfXx3Oc/y/pu1kc
 gKMB8Lnu1NnQjv67c1dRiDMQDbhHY11miFU1Y37H+2vJHVgg/CarIO8xXhzGMjGlMiMLfvfDSHG
 DBPXSnsJHgYfUFYn/VZIKMzDf5SdwU6giZNSu/GrMo3U6mHHBx/+RADzK0luia5sUQBqyvz0oWC
 O9N9qSp+Zk9JlVr/SUJyskH7e4AiYbQ6a77HHiUF/lUBgdlc0i7MFS3DRIGWV3YY73uL2IIPA+V
 DtISinuWxIi5jaQg+tlQ/EThfADmqu6E7oT9dBrFahXeR0iwgyuFIr0t5AKfXhE0hv6YbSw5mmf
 ANgcK9/GTO4xE8bvbT7RUYJV5PRtXsP15T3SuEgT311MJA9DKpXTuWkr4P2Ubstd620pYiD9otm
 dodBAfwROkC9r+pj/schmcZEWyvqpqDrHlxwMzTO17YozhwYgu8gETLy0C5cRjakYwpTsB8fJsL
 lnt5cQAiNZRyh4lcDzA==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54c6a9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=vHRj6gOV4FyQf9l2a8gA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: xZ6_ByjQSC8soGalh-02G9zzKElEi6MU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX7LuuLgDdPnH+
 ZX8rWET4qrCkozJOt29O+kajVwfveCvk0DwxAbFG9o7YkzL4u4tDS/nmOQuvttQZXF8Vod7R5rF
 VmXV8sBZwMgqyBtCnws+CI9ijvFSpok=
X-Proofpoint-ORIG-GUID: xZ6_ByjQSC8soGalh-02G9zzKElEi6MU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130115

On Tue, Jun 23, 2026 at 3:59=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> bcm2835_power_probe() initializes all power domains and then registers
> the onecell genpd provider, but ignores of_genpd_add_provider_onecell()
> failures. Probe can therefore return success even though no provider was
> published.
>
> Check the provider registration return value and jump to the existing
> cleanup path on failure.
>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains=
 under a new binding.")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index b76d74e38..68a0a7a8c 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -677,7 +677,12 @@ static int bcm2835_power_probe(struct platform_devic=
e *pdev)
>         if (ret)
>                 goto fail;
>
> -       of_genpd_add_provider_onecell(dev->parent->of_node, &power->pd_xl=
ate);
> +       ret =3D of_genpd_add_provider_onecell(dev->parent->of_node,
> +                                           &power->pd_xlate);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "failed to add genpd provider\n")=
;
> +               goto fail;
> +       }
>
>         dev_info(dev, "Broadcom BCM2835 power domains driver");
>         return 0;
> --
> 2.50.1 (Apple Git-155)
