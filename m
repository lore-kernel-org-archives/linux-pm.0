Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5940DB25
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527239; cv=pass; b=dGTag2+nSxwSDJaWHL3Oexj268jI7XZlKcB9sXx14JaFOhmr5wFKLaHa86JN80WdOM5KWdkqMiLLO/lEMM31wsNCMQ4qmYp4xh+dMuhNMWYLeLSRdy4Mr7W3eHlru4cqTtiue0I2IMBIM43upI2lOsc5bqE4aZFfchhWDZXhAE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527239; c=relaxed/simple;
	bh=vmzyDh+wY4RI+VDwpzAkIKa5bTxBYc+DCmkQVlORqHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9uPBfGkhNEDqfcWKZsikl3VsPNmg5QjMHEYb6TN6SactW46jza6Awagy0ayIHuabyh2+DnSj5GV/ej1oEWvpTrfFawPZEviBWqYhNVyeqdNmJgrOEjAuuN2MC5Rg3YdhMsdOPOrl6CbTY4socmKX3HDxFxuibtI4SvApJCiQZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFsEgs9K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HnLHwCu8; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFsEgs9K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HnLHwCu8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YpT73847920
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zEx69xiRSRAe0xJc/Z4e3vk2TczdhrCLmrje/dy0AFE=; b=iFsEgs9Kn2SP+ADc
	UyW9spWpFNQctEnMMn4PpsmqXVyKZCc3OUPe02eFhUrZaAL6rZRURmXDYHiC3c2i
	0O8aKFIu3NlWffaJwDuUyg2rHFs8yHv9pei7b0mctZc7TOb1HwgsU3QacztK/Ltq
	FhnJl70ArFP8R1P0h7/RLq1sqVWEA6tZnxwpgjo1dKEltg3so41URrgoW8W0c6rb
	Mf2KItT8MGASwIdzJGARc94prVxEHQPPBwvyrSaVY5zcsN2X1vXOsrqNL7TJ/Jrg
	kuEQw2ckiY1vbTsQmPP/dDvrxxqAl1ps28/Or0ySMtc643+u6XuWTkxF92ppayqE
	CQng+w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k5qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:33:56 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-73850dfc198so125311137.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786527235; cv=none;
        d=google.com; s=arc-20260327;
        b=aw5Rgs0ZThb/7sVmwO2jJNMBOUsJmoi8ljPA3GDudYE3iXXHBYODLH7tniEE9/8y1D
         75hNCG/jVa5Ax2w34txcfLCkUTUO796opN01g+i/kU39tyE90AdsndA1H7qoPtxHowfK
         au5sDQv9FvJAoYgYUm5A+qEstyfEqd0Hhvi5/6vKo1LdPP5uf1vvw4C+dqEj/OR10YTt
         fsitFKLR8hwfmwCtSsHk2O0kbnJ0zrZa5GBV+Q7KMFVT+zN8oG2GbqWzK2YG1nqG3Lx5
         Zr9Z43i3hjgQhwrzpSinmycSZnirKxYWr90rYlA5Q4prvor7V87uM2oocQnXKHZ5ym65
         CXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zEx69xiRSRAe0xJc/Z4e3vk2TczdhrCLmrje/dy0AFE=;
        fh=JdK6DOnD7GiHUKv5t3JBKk9qQ/I7+LwW07oczuthWfM=;
        b=GC0hZ9i+OIXI914GWm9dzIZ52M/3QdFObYzlKFOGPo3lU+SEGW7UNXhX4Goqq57Ghx
         XYx/qvvLp3uFLT4NGt/X8azyj0dtbJkobOcScDff8056t8BLV4Zu2E2F0XRSC4q78Qop
         TRdCWA7csz2sMJDwqzU5h3wto3LYNpl3pzGuyDrCCTvg7tl/dVxqKigtJLHb7DOrXnAM
         8QA8MfIC0x/ICJ8RkavlCTVTbcY4Jcnp1sQzajZsAQjGsfoMTxIKZW0ZiWKq7tOobeat
         3VuM2r4Adg7uAF8nxSzoM1nyyxu9P1kIBNCNyTvg8xv2PlFLlFvLgk6xqbiisBqM2OXR
         i++w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786527235; x=1787132035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEx69xiRSRAe0xJc/Z4e3vk2TczdhrCLmrje/dy0AFE=;
        b=HnLHwCu8j+Sz6YA/SQigG4JRtxlcllErbUJBTKhhQTSAG3I7TdP123U3V0rJh5MlwC
         K/gBg2F+aKPcA+Fa/uiu+qECeK+KAo+MrHCu6tRRQxdD/KfG+u3/SN8YUYWxL48rraGu
         VriX5xq8qjA9CjSKW1hrGACZIa3dBrc8PPAa5SPnje06G1QiAg4voE0zn7UfwFrRuVQr
         aIqBkjRwVfytJQ0RLCQMnb8R9fLbeOfa615s6AjHEHXeqrb6fM3PMMBJALNxTHlj4MQw
         x76aAZ5OI8AF+wiGd4fXyhwrLrqaM0y1DUzXAd+1m93CaXVUMt90a5G47oA7cofkzgL4
         iTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527235; x=1787132035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEx69xiRSRAe0xJc/Z4e3vk2TczdhrCLmrje/dy0AFE=;
        b=J48NHahI/pimW+NTR0oID3RZGF3M+PhjhmthqJvwzDBEdHGXkQRdjuf/IHU/NHeBeR
         Tn7EhcX1LWBe2Ihl0Li8nrcKCcC+WAxYOV4ZRsOg8JEpGu4XqeL5Dg9kouTBffuAhyxy
         dOgzVX8JVdD+OSg5+kT2jJA8avvDS3xw9hlFn/tavBZ52h9/QEzM1O76AZTxX2uUbti2
         wzAlbMy8Tv4mFDosVVev+mCVgApZUzLsrROT7RrL52Ju+O6xgFtWU1oPzkbZOqXMwzR9
         GyUS/6573u18wUc0bals4ntSuiw4UDUhxn1VnrJpCQA0xGcHMLi0spWqMD4i3v4dHPZY
         FHrg==
X-Forwarded-Encrypted: i=1; AHgh+RrOCphcAh1lF9lOmPvg7wZXddbg3BCytSxD+N+5CWEIRYhy9N8ojpxz9seX4AIaj8iUmaSvVmfAnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmG+tupeTAQjI2SAsuPMips5x82BotDRzrwahENclAS85/dFMJ
	QXMJdAKdB6G6WFJCjHtdaWq1T/pL+nqpWC6rEgkMWtlEFWG/1eSCzXZG6f6UMOD1g7FmLJwfLPv
	nBszpRWxQEAyeNi5pd2B/ykemUh3XeIYnP+3BNYQDEi9Mfnk/cczldC2Zq6FA1u/zWX5wl0ht/C
	MiGL3rh8BIIzML66UAOh/DGJovVRJC60BS95Yo
X-Gm-Gg: AR+sD12psagRYyldAxC2H8aFzU5Wi9U8nOplJorPt0DETqPlVs5H6zXxKdlxLR6qdWr
	TPIsAthAxRm7X6GlYXvZCIJA2a639PJarwqnGaZ/OqsUo44LTBC1D5uyN2eJLM3m0mxJMY38pvX
	bSF/4khQY0uPSa9rOjDoPRDG7vTbLfrXaOjFLI+ikR79ODBNear3p8X5D4dF3CskIobpgkRLc/t
	sZRZ4qYfRjwgLuM
X-Received: by 2002:a05:6102:94d:b0:74a:be82:73a6 with SMTP id ada2fe7eead31-76c88b5d4f3mr653457137.8.1786527235657;
        Wed, 12 Aug 2026 02:33:55 -0700 (PDT)
X-Received: by 2002:a05:6102:94d:b0:74a:be82:73a6 with SMTP id
 ada2fe7eead31-76c88b5d4f3mr653449137.8.1786527235189; Wed, 12 Aug 2026
 02:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com> <20260811-domain_off_ss3-v1-2-6a0a0fc023f5@oss.qualcomm.com>
In-Reply-To: <20260811-domain_off_ss3-v1-2-6a0a0fc023f5@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 11:33:42 +0200
X-Gm-Features: AUfX_myst2nAw5V_YUmuhaFbQdg1Mey-MuLYa2PToXnP1p5QWau0DOIrAmPhVs0
Message-ID: <CAPx+jO-FAL1asnPRwhdH3R8QZvdTnCiRG-uJh7sT7p55nqBw-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: core: Initialize state_idx to deepest state
 for OFF domains
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfXwnmWKpYEXuZz
 EQj4XQgYkjBBE1ir5YNABnNZ/vk2GuzRT4hDResvPIhE9pmekJEocYg6gS3D4wsjTtPdtvQt+qe
 nJQNB0yJFrR+z3GeKbvg+SGpeCjI06w=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c3e04 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=P2j-IMcOwh7rrdvbTMwA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: D2EQS9HQePTom9XIixQwqgQFvOZgNkon
X-Proofpoint-ORIG-GUID: D2EQS9HQePTom9XIixQwqgQFvOZgNkon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfXzOuSrbDEJwjH
 +CQ7/FQBi88jlKErmfZP9NnXwAZgcUa+5yp3wr6rMYKVRNk2IpkL0ne3O93MDJ3CsRAexLjxcA/
 iLfiezYy1H3DxCn8jTnox8rBDQ4cwV87tifUeNIefEPuPs8z69YSleaSPgJsSmlqVw1UTU5zohX
 /x6F/QoRNEmtKIQcb3UD5+x4Ri+nBhecqCafqqbXKb+tnselTmK74+WYkIsysiJ1CMcnC3dvovI
 VI4VZq86YByUuIKNt9+8c7dp2nGPkMhFiGzsWBUsHvOXUJgKm699m/Hh5uNMC7ATX9hrBLDXL3f
 qodJYIn4+7oBJ4i8xkYNwh+njQTGqDutwF+OiuL+OHg1tpeLbdhstku2xPpmOL0oTt9we0k501A
 RAJLRi6K6uSRKnSNwpWEvyrRtmRK1MwPvg0Hse0R1hn4Bf+ga7+SFIkcrrh/miog/GZbfn8hvP+
 ZSG/QqVOQt+heppjEnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120076

On Tue, Aug 11, 2026 at 7:50=E2=80=AFAM Maulik Shah
<maulik.shah@oss.qualcomm.com> wrote:
>
> pm_genpd_init() sets genpd->status from is_off but never touches state_id=
x,
> which stays at its kzalloc'd value of 0 (dt_idle_pd_alloc()) regardless o=
f
> is_off. A domain that starts OFF without ever having gone through an actu=
al
> power-off sequence is therefore left looking like it's parked at its
> shallowest idle state (state_idx=3D0) instead of its deepest one, even th=
ough
> it is fully powered down.
>
> This is visible on hamoa, where cluster0/1/2 each expose two idle states,
> CL4 (state_idx=3D0) and CL5 (state_idx=3D1, the deepest). When CPU-cluste=
r
> genpds are initialised directly into GENPD_STATE_OFF under OSI mode
> ("cpuidle: psci: Start CPU-cluster pmdomain OFF when OSI is used"),
> clusters whose CPUs are excluded at boot (e.g. maxcpus=3D4, leaving clust=
ers
> 1 and 2 untouched) never go through a power-off path, so their state_idx
> remains 0 instead of the deepest 1. debugfs reports this as "off-0",
> meaning the domain is off but parked at idle-state 0 (CL4) rather than
> "off-1", idle-state 1 (CL5):
>
> genpd_power_off() and genpd_sync_power_off() both gate parent power-off o=
n
> every child being at its deepest state index:
>
>   if (child->state_idx < child->state_count - 1)
>       return;
>
> so the parent's check treats these fully-off children as "not yet at
> deepest state" and refuses to power off, blocking the deepest system-leve=
l
> low-power mode (SS3) from ever being entered.
>
> Without this change:
>
>   $ cat .../power-domain-cpu-cluster1/current_state
>   off-0
>
>   $ cat /sys/kernel/debug/qcom_stats/apss
>   Count: 0
>   Last Entered At: 0
>   Last Exited At: 0
>   Accumulated Duration: 0
>
> Fix this at the source: when a domain is initialised OFF, set its state_i=
dx
> to its deepest state (state_count - 1) instead of leaving it at 0. This
> makes genpd's reported state consistent with reality for every is_off=3Dt=
rue
> caller of pm_genpd_init(), not just the PSCI CPU-cluster case, and requir=
es
> no special-casing in the parent power-off checks.
>
> With this change, the domain correctly reports its deepest state and SS3
> is entered normally:
>
>   $ cat .../power-domain-cpu-cluster1/current_state
>   off-1
>
>   $ cat /sys/kernel/debug/qcom_stats/apss
>   Count: 218
>   Last Entered At: 726792712
>   Last Exited At: 726950687
>   Accumulated Duration: 199888773
>
> Fixes: e7d90cfac551 ("PM: domains: Prevent power off for parent unless ch=
ild is in deepest state")
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  drivers/pmdomain/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..5d96d9eabc1f 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2409,6 +2409,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>         atomic_set(&genpd->sd_count, 0);
>         genpd->status =3D is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> +       if (is_off && genpd->state_count)
> +               genpd->state_idx =3D genpd->state_count - 1;

Even if this is probably the most sane default value, I would prefer
to keep the flexibility.

That said, please make this change on the genpd provider driver
instead of in the core.

>         genpd_set_stay_on(genpd, is_off);
>         genpd->sync_state =3D GENPD_SYNC_STATE_OFF;
>         genpd->device_count =3D 0;
>
> --
> 2.43.0
>

Kind regards
Uffe
