Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31314746C8
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548870; cv=pass; b=JaVmvoygrkNGU8vofVeC12jjIZEAYa2//YoStfrgbSmndz5n6ljlPmMXD5Im9OUhUAepH9tT82dbhdG9EK7/o9UAbHYxePtu4o7ksPcZWlk/N4DPfLnIat9l+t2FYd30P2unxes2okw1ka3QVC3N4RzJ3ihuBOCwE83Vvh4P6IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548870; c=relaxed/simple;
	bh=AHnyE/VGGU+pB0Te00S4wwqczmz7s/0F+49HO35slqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1LgZUPyZkGBJi0bEPpgYDmhl7QdhrYk+s75BVK3rIz1VTD0U32JOjernEJvqctfcndGJVP3A3NJl0c5Qr1MiEKd87kuYwGy2wSEE+d5+H+O85Aq5EXtRd+AtsR+7DjEkOWYim0LHl1feMNXvT+omBjuhYwswVSXsT9JHsjnrnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jangk5cS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WEgL++Oa; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jangk5cS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEgL++Oa"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbTpi899527
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UX/M98g6kcstxhb0l+BO6UEsPV+vxSMCH0MKryTplFI=; b=jangk5cS9zu/cD7m
	+j8n6wlVBBPd55ggNuStVgGcN5H6+La3N96Wq+k5/c4IfcXx7/+6n8PMugoo6F25
	rrnN7adv+gWMsaqjaSfN2VVR0z6L6aDxAgnDjfDiLjHKj743h2yhRr20cexZmkQH
	1H3yipWwBHwHCfKgC3Axd5qgIkEPo+3xDku5UkCw1bWCpJMLuILQYbVi1enadwEu
	y4GSF6VBnv/eNntq0L9o8ld+NoV2AGXNZVmagYGJGf4FVzrRxwqNAKzomKbNyjXs
	1XgWIkjwEKUbp/SbfXzqWthWNo79sbVck3rtoJEveDzA4WbowgXMWqslst0fXqjb
	isycRw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut9nbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:34:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb6823efcso10196765ad.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786548859; cv=none;
        d=google.com; s=arc-20260327;
        b=RFrkaIOG19m9yefTVrIAF+Szo0/Ftxuc0Gtozr9ialftxeUVi2ks35VS+SQuz/o0N5
         MK8SdKoS6FFDap8iYIwfSDvjMOBn47wKE4xXmKyaxsf5GtBRpTESIAi3eRyZJfCdikR8
         9cY7IRYveXGUDoQqgJ7pYvpchkRmnFfbT2eDb59Wc5dOekohfdxxvyaPbUVOdc+HXsMA
         ALpcAn4uFhppW7xnm27FfohDDe4Xx3lXp2dz0i0cKN0zf3LZl4ZpTnpduXni38RBYGAA
         CSnQ11+nzj+XAbj6NI6YctvrqCsbz+o6RJKtLnwYGjnN8p+OCisiS9wi12Y9Y74YVXt/
         xvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UX/M98g6kcstxhb0l+BO6UEsPV+vxSMCH0MKryTplFI=;
        fh=kQAFJu8H7GxOAECjl4Slo3eFmUesHg9Mvy3gLCVM/uI=;
        b=RNQrdsbmwlJ/1lrR9hgeFR0g49ML3vLLuZyWi6vSlPWOKT/qGzalWrELD6XpyhPa4Q
         ZeAiWTNNZKO8mucDCLwvn0+BIFdhSb8zzR5Ep3D2nugMIsa7Gb9yvy3mqYTte9jl8ZLl
         DaHxcLCvfpehY2UkwA/MdfEfbMBMyz0NU9Ro1iQfIRM8PBOsGUvzoDDCQ1xUxBWrVxPl
         eEmXCmNeT9WtM0lcq4PDkeacPJgsx5yHCcIMW2xr6C9X5SD41Dqt8QUUO88Iee6aeKeh
         QpRbRbzobpbWIs6FHFYbDXCtEHUtPGt75FWgEDKZBfU+0L1B4PSfScaee22pjweSN+8x
         glew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786548859; x=1787153659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UX/M98g6kcstxhb0l+BO6UEsPV+vxSMCH0MKryTplFI=;
        b=WEgL++OaOWLOVlOQuUHRN8UqvTlJMRvQ5S66NXHDmD2nGDsF0rYBD5I/ZVLqKYjplP
         gLlkmHGFdP8eB2XtNg3HYb47vq9gXQ5vqtlXJIv3vfglpDeZLXKapz9p/XKmflx4U86h
         pbDVms6eImU83jNbh40kAmy+H2EqHFvTlpVEDb43nqiZB4FyeJq1gc8G/vN9XlTurA/t
         v7FuMLEOfQN0G8swBEx3fXwzKSdur4pvskx73qT5nUuAWLf+x8XaCE1FAHVggflyoJcq
         WNVlK/ouFeEnuO0wwpNI9Md3ptyEflTmKwdGVZPuDQzkJhunwx7SQltRySiGAncjyEgL
         QVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548859; x=1787153659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX/M98g6kcstxhb0l+BO6UEsPV+vxSMCH0MKryTplFI=;
        b=cPHeZVHq0uhqYYendnnY4fVPDdAI6VRaIrOtAxTv6vWqY1q43t1qFsnbKMKF8/Jo4S
         LOj5PqviX3pm69xCZsw1iSptv2+riE4P+U4hNDrmbf75Uzu5ua6MeV3paAUNpPbHNz63
         kufzkcQ6cgeQJgh0nV+y3/eEVGczgOXayGjChk1VUj+9/1dz85u50odRjV2ytZxxla4y
         tTRoixwsZ7+Dxzyunk2OBRFdJQ6rY7F7c/KI4ZKEpOh8ThKErGED45gW7b8mXkAeKvuw
         so6MgObX4Xf74majmd0sWxq9hVm7AFwAeC4pkNxab+qv6MhgKGNnMTE9FKF364j9aa+r
         lmpg==
X-Forwarded-Encrypted: i=1; AHgh+RpULq5TpDj8w2YUosVW+W/FtHuiZfmaXTwz1I+tBoz5DuuDN+aenFJLQBCR0NKDfoiZ4QJee3l/dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywuYKoeDrYmHQlh/6ELnZRSBF60Y1v/MGt4yOhpr+Ie8wLZHld
	MZ0+joMy5RG1+RZzgdTthMJWVfa8VU2ydsXVpsf4nDQ/tWsSV4OzpmD9/nL/g5OliNnssNroWQO
	Hyxiv6YN/O8sdjh9VMEUzeZW4H4Az53+aC6v7qaiz93+xEkd64i6WBNVNC7AVjo0E/3R2M9rXRM
	4fYRr/GN7ELTAjr49+Xa0fACV5EKT9Ah6SDO0x
X-Gm-Gg: AR+sD10iIFLeb7zl4OdN6YXy4RyjcpNls2o7si5PLWoB8iUuGT2nvHVK20nSLxhi4mw
	+yt5cb/Dl17rphWt8Y2P1EPFjxqs99qx9IAS/dcYPONEnT4NTr0lgExKDd4lVJZr0gaRH3IEfY9
	K9TS7Jk/qppYzOQzcsAr/D5dyQbNX7dfnqOlRZFkijxT2PtutDQaP44KbFaA==
X-Received: by 2002:a17:902:da84:b0:2ca:6c8:abde with SMTP id d9443c01a7336-2d3455dc469mr66327015ad.18.1786548858602;
        Wed, 12 Aug 2026 08:34:18 -0700 (PDT)
X-Received: by 2002:a17:902:da84:b0:2ca:6c8:abde with SMTP id
 d9443c01a7336-2d3455dc469mr66326205ad.18.1786548858148; Wed, 12 Aug 2026
 08:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com> <20260811-domain_off_ss3-v1-1-6a0a0fc023f5@oss.qualcomm.com>
In-Reply-To: <20260811-domain_off_ss3-v1-1-6a0a0fc023f5@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 17:34:06 +0200
X-Gm-Features: AUfX_myi2ZUJDsHfRryrtjfBgvDNohz0v5dvMDAblTITfqOs1ilaSpnA82VV-8A
Message-ID: <CAPx+jO_Z6woSz_ywFjNLhvEgYyBQR89+trK+6kL6Q1aPxsWtwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: psci: Start CPU-cluster pmdomain OFF when
 OSI is used
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX+xHnR8MxQsj3
 itVdxVtGrAaBPdzUwu9fmLrI1cL1FbfVZk/pVEMEkqVzt5Ci6HHA4CLyKndFtF28QEeA/kryvtg
 OUVrlsXIX7vUahNLl9rLJtM80pecYjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1CZPCcrxNN/o
 SBMlnrLXWvWSxZobgrUUtTEZYKXq42FNfJs3QyXxGS946o9SrS61+a5MWufW1hbbJf2RJmDL/29
 l84J5lLMVfXAsuqalkWt48eom/Z4/Cd9piXT3n+2Chlha6Y1XpwC4nG35qAqPDePQkhY22I6HoU
 04QYwNnTL3pBNDsfW2UEYApz/ztXse15x56GtLDx/d9E1KafuHJWqcNKdYryx7yvHxIj7R8mZ1/
 pByFi9ITEergQ5aOiOjJjCGRpddh32qzBtvhAKtbl7OJeblRtDFSaooIA+50d4xIKhFT1na2FaM
 lxHH/n/s3jrvRNV9cPlYe+BviwcL/Xs2cWigNMcqcjEphuk5o2wV3y5egfHBwFknB9N4eh77aEM
 tAMJ+DdHzlgDTGBMj7NCa2xOwFJnL3Yealge7wpp3bUjkQzVVm0ldZxKa+QNdCcpl6rMy7Om1L7
 NNhVi668EHAHq29J8ig==
X-Proofpoint-ORIG-GUID: iwXOmGUHx-pCGdPJOQ4NnTF-ar5rZuPR
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c927b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=rNF3hdfX8ybiPTv_IDwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: iwXOmGUHx-pCGdPJOQ4NnTF-ar5rZuPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

On Tue, Aug 11, 2026 at 7:50=E2=80=AFAM Maulik Shah
<maulik.shah@oss.qualcomm.com> wrote:
>
> psci_pd_init() always calls pm_genpd_init() with is_off=3Dfalse, so a
> CPU-cluster pmdomain is marked ON at creation regardless of whether any
> CPU has actually powered it on yet. The pmdomain's own status tracking
> (and the power-on notifier chain fired from _genpd_power_on()) is
> therefore wrong from the outset for OSI mode.
>
> A concrete example: hamoa has 3 CPU clusters, each with 4 CPUs, under a
> single parent system-level pmdomain. Passing "maxcpus=3D4" on the kernel
> command line limits boot to the first 4 CPUs, so only cluster0 is ever
> actually powered on. Without this fix, cluster1 and cluster2 are still
> marked ON at creation regardless, since is_off is always false. Because
> none of their CPUs ever come online, neither dt_idle_attach_cpu() nor
> psci_idle_cpuhp_up() ever fires for them, so nothing subsequently

Why isn't dt_idle_attach_cpu() called for them?

If we pass "maxcpus=3D4" on the kernel command line, the
cpu_present_mask should still contain all CPUs which cpuidle-psci uses
when attaching CPU devices to their respective CPU PM domain. Or maybe
I am wrong here?

> drives those two domains to OFF - they stay marked ON for as long as
> the system runs. When cluster0's CPUs go idle and its pmdomain is
> powered off, the parent system-level pmdomain still sees cluster1 and
> cluster2 as ON and therefore never selects a system-level idle state,
> even though no CPU in those two clusters ever executed.

Doesn't genpd_provider_sync_state() get called for these domains,
allowing them to be turned off?

>
> Starting the domain OFF is safe under OSI:
>
>  - For CPUs already online by the time this driver probes,
>    dt_idle_attach_cpu() explicitly checks cpu_online() and calls
>    pm_runtime_get_sync() on the CPU's attach device, which resolves to
>    this same pmdomain and drives a real power-on immediately. This runs
>    from psci_cpuidle_probe(), a device_initcall, strictly after
>    psci_idle_init_domains()'s core_initcall has already created and
>    marked off every pmdomain, so there is no window where an online
>    CPU's domain is left off with nothing left to turn it on.
>
>  - For CPUs that come online later, psci_idle_cpuhp_up() (registered
>    via cpuhp_setup_state_nocalls(), which never invokes the callback
>    for already-online CPUs at registration time) powers the domain on
>    through the normal cpuhp AP_ONLINE path.
>
> Gate this on use_osi rather than applying it unconditionally: in
> non-OSI mode psci_pd_init() sets GENPD_FLAG_ALWAYS_ON, which
> independently blocks genpd_power_off() regardless of is_off, so the
> domain can never really be off there and marking it is_off=3Dtrue would
> be misleading noise with no effect.
>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using =
genpd")
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpui=
dle-psci-domain.c
> index b9e4ad7d43a3..fab9de648b17 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -78,7 +78,19 @@ static int psci_pd_init(struct device_node *np, bool u=
se_osi)
>         /* Use governor for CPU PM domains if it has some states to manag=
e. */
>         pd_gov =3D pd->states ? &pm_domain_cpu_gov : NULL;
>
> -       ret =3D pm_genpd_init(pd, pd_gov, false);
> +       /*
> +        * Start the domain in the OFF state when OSI is in use, so that
> +        * genpd's own status tracking (and its power-on notifier chain)
> +        * reflects reality from the outset instead of reporting ON befor=
e
> +        * any CPU in the domain has actually requested it. This is safe:
> +        * dt_idle_attach_cpu() runtime-resumes the domain for every CPU
> +        * that is already online by the time this driver probes, and the
> +        * PSCI cpuidle cpuhp callbacks power it on/off for CPUs that com=
e
> +        * online/offline afterwards. When OSI isn't in use, GENPD_FLAG_A=
LWAYS_ON
> +        * above keeps the domain powered regardless of is_off, so this h=
as
> +        * no effect there.
> +        */
> +       ret =3D pm_genpd_init(pd, pd_gov, use_osi);
>         if (ret)
>                 goto free_pd_prov;
>
>
> --
> 2.43.0
>
