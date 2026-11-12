Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471795;
	b=xYYyFQpVyNTZjEvgA7r8d9W4UslS1VaHBDaTPlf03cuLhi0VuLJZuC2hOjKc0e7GOWGE
	 3NjdhL3EjotWO7NdGcb1IpCx+JM5LrpdZF4zBH2tOUrhGC8WQSxF9i1AluCD3jrUb10+C
	 PqXZI7JI4ROiPnUtHi4kdko+3zE4H3ALZzypIbrJyQ8CtYaejZ1ZiDaEmAxZY7Hny7AOf
	 xiY/aXFTG4fWKMoTItte+XsbPKI2Sd1N+V+LMnBfp4X38wHkralB9dl1GnIVkfz7DvvZM
	 o7GiTfAMGL010Z8HCDgVFAc1x8aotzGEqQlL6X4/NmSgF25gN+nhJg0CpYr4gUpicLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=08cEaQh1yyLsKkm7fAFIcqkmwiaYr3emRrdLH1THyPs=;
	b=CRR/IvMBIytSFhfv1H/xtrmVnSfxVK3xAV8NxiFNGj46/sKjIXIFelhN5ZULn4xrQq/4
	 l1TAyBwXuuPIrThMdKTdZ5faiZFvZ2Aoijqa3Tf1NmNymJDQlX3y/+itdxwtm2ZnJNdiv
	 IIB+pyy5neKu4RLktEPp9CAI0of+MROddHlZF0CYTSUFMJnvg+mdp8qwDlYXJziV8dmt4
	 ea99yejPCTyY359+QKiZs6wFsTz1JKW1OwHU0G3k4Fb2zeZjBgsq8JKti7tCqFvLzlHKV
	 bljF/1v7aPLWxYvAxRnW6WRtM0Wew/FfQSghwhrJGwQapqvHenQjLsqYFkql6UVR+VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHzFKtbM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MqbJugZm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43716606A88C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43716606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHzFKtbM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MqbJugZm
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7jFRv126967
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	08cEaQh1yyLsKkm7fAFIcqkmwiaYr3emRrdLH1THyPs=; b=jHzFKtbMwpCy1Da7
	/prLV5AfMnIY39wIw5nH5xtdfd+kAKw5CxvWGVuSrryNdVeLUoC8GBnlG4UT5kXc
	DQ5KunDrMLJyc2xY06+KjdsKhi89YI4WXkkN4olzW8P2ZJI1/sJhZw6dWL+VPBmE
	8zS9pcDDzZpy7JMZJLgDJ8IswLGkb1P+VJa2X5TRG4uxSb6s2av0A2R4ypBbmPEi
	S4l+6nuvYjCOtRfTxWlq1eNK+Sn0tzHBzIZ8bp+qD3KSvF9BuvssEn98BxCGnEiV
	FzEiuNwWM6UVIA/ay9NDuXZE5Sug2kttrn3e3o89ZVeudFIfPcgkyJkp3sng8ymM
	S+C/Gg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a08552-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:23:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-944101e6367so121511685a.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 00:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794471793; cv=none;
        d=google.com; s=arc-20260327;
        b=c1KDegcSjIHN4ytUyFlho8y9f1BGGJQGmbtES9ZynKzumZf6qPeAnUJUYf02dHH4CR
         66sWO1E7FRDV5koZmurcdqAX+0OGY0O0pWidMsL9DEWIByKgrL6C8vGF6Dr5pVhbkUW4
         zbqWVsveiiOQk4aaD7LOPmvH39Xg69cmQQi+AJon3KEFgObEIbtJqzNYpJM4hdvDHH/D
         UIrl45odu+vBerTVzCwQkARFtKy6zhRby6GH0B5HSlB9BHwZJ19n9HEnKhhvklYCSqmu
         rzlAKKXg+wFGRXq8vCAZserXNzg33RfiEoDqJFh7sw6cieIzfvpnUFuKewK6+8C80tV6
         wCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08cEaQh1yyLsKkm7fAFIcqkmwiaYr3emRrdLH1THyPs=;
        fh=f8VuG+4CQEuYeZKUqgyA5pMSyb+4d8B85jymtAq6rqE=;
        b=k1WGnlsSrgx9iEdt4SlXPfWtyRG+X3te3eZkHGuO36WQk1EQnt/eA/xlVnRWoO/gM9
         GfQTCtyh7OFNDiTYb9bi3W/mTv1aj03wUiBFjoALAZRK3Fcp9tKnHzOLAEsfgkXZYTzu
         4BzjqfT7uW0uMexPR4sp0bYEDU556ogPc47nr5la3vqDi+qFvixvwSAcqPbnQbhVF6Gq
         Gt5zcP07K7t7yuDfhojOeqXI5G3ISby9c5Tc7ir+3ylQ+BxH2Sia5qrhNlYZeZ/a6+Ek
         LYNrncx/TnScopn7nV+MknLeymUzzg5UNoLR0vpLjKvXeLG0+bYhAFha9N9PuyVJbKpf
         Y/iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794471793; x=1795076593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08cEaQh1yyLsKkm7fAFIcqkmwiaYr3emRrdLH1THyPs=;
        b=MqbJugZm4CdFJZBaPEq3mZGVrQrAByMAoeo/qIAK8sZG+q+UVOaPcp9whXgGBG5htM
         IpPYlarJTMdRaCdoXhbCRKIxxZvgkj2PQqiRvJtIDqSVIqhAmyBU4VPWyzz9Vrc/ON5U
         hsQ4jfttgIJdjRhvxWz1Sw5x3tOObvC399sDE9NX/A6Ry8ZjrJDR01mAPh7JOJZvIv4B
         wfxcNS9Y8fwIy0iY5wggTqsvE1MTqEj+vS8PhSKllhCEs/4GCVru9opZzRzbQSGfbLJk
         m3kABOdhj7CVmBGs0id4NEG4K8vlRwLcc7j7BMX2wlewraaFa5QmO80xWWnOmSIPcVkz
         LVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471793; x=1795076593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08cEaQh1yyLsKkm7fAFIcqkmwiaYr3emRrdLH1THyPs=;
        b=06L9U0DXiEOvTkblKXJDyKwHlCmdqxik/P1LZMUG+UcyBH0BGfR5SyITYaufcf/v9b
         axYH4pitB+jZlpgSTzcaNpODihIHvreJ0fF5M3ddHt7RA1SKHG1NegIUptFoMAr4XsW/
         MEJaVtndAG75LpCO133x2ljzxPNi4ise49hkdRcUTnmb1hx47zTr1oedSQU6E52iTTPM
         4tT78K3jOwXEQIIBPG2eCpThQlcDuT08OxVTIzx1NhKsBWssoLWgqJy/9nGTBYcEUwom
         pZGPFaeRAYLfmbKmp0bRkxpnA70oUiFkVM6ubBbA0pi8n3PCou5mi6sqLwxERANVeE9d
         biwA==
X-Forwarded-Encrypted: i=1; AL+hErF57XxraB6FuxRXkHO8QcRY9MHdfI+EEoUznJVPFhMZmjJqCJRIqda19b1ibeZmxx69In6AJQ1muA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tqdGRPhhNxy4krd8yJOERVJGNCh9vnlXve9/eRgurpPWaWIke
	NwnFGGbh716ZouY/nKDUoO1rqy/dmy4zG4bWt/+I4PVlelkmBlYqs7X7Wcjm+bgn9q4+pXIueU4
	PbEWpgc1nKBXTIuBScQ/6qsIe9A9kxf9sa+0c5bLEBzj5ddKaZJITz15b3ht02wzdI3FeY5rSEV
	JFgBwAevYNa2jJiQ5xdyKCqZUy0SvcGlUGufkm
X-Gm-Gg: AYBFou0x3yVwMKiW46uUNQG2thjhkM0A97BCZS/SHQ9KCf+cxQR0VS0SrzaMARMjx3W
	7rR3wiTUtkAp3sekFglyA/zMDey+V86RTpH1E1uS4lxCBd+Qqb2lD4Og3d51L3yXPkxSqvpZUCK
	EMMN4Fch/4nLkCFWy0CP9Es6RM8CPqYgRb1GS+aZmf7wkhYxVFgxiNIsHA7ESBfZWLwmgYcLCtv
	Yfhec9pYqfnvCG7KxuZ86lNl0jbTSP7yXgozAKhYAYv5Jer3xPR9ygZV4Q6Kk+nWL6ZpZ8W4BE=
X-Received: by 2002:a05:620a:4107:b0:93c:891b:90f1 with SMTP id af79cd13be357-949330d463amr311772385a.26.1794471793456;
        Thu, 12 Nov 2026 00:23:13 -0800 (PST)
X-Received: by 2002:a05:620a:4107:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-949330d463amr311770185a.26.1794471792988; Thu, 12 Nov 2026
 00:23:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b47282f1514a9012ac51d0915afb83782c3c0050.1794417398.git.len.brown@intel.com>
In-Reply-To: <b47282f1514a9012ac51d0915afb83782c3c0050.1794417398.git.len.brown@intel.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 09:22:59 +0100
X-Gm-Features: AclHuK9mf73E_udLBsal6MmjRAHMEHwg4PirGobwKujBcW0eeFtgBfzQgE6Dh_U
Message-ID: <CAFEp6-0yj-+7uYnj5PCvaP39ruQ=xduBbQgJc7MyakuPLJhmvw@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci_generic: Fix erroneous system suspend abort
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WGDehPBUf8DV9Gvh_R0SoCGy3HGWzK2I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX79MZsCh9QDiO
 nEKiGuGy6nsGUWjjO2xXxb42iLXOfn2qq60bgeMjYzqXP5+L6eKMC13qli3UUH+C/zr9DyR+QSY
 R1O6ryX37ywrIJha1IY4GXEfqxg2zEixsoJ/veCAwRbqpvwYtpef+kDpjzgqlCsivHAqUEAgNZk
 JwQscIB/p9zkv+vE+mVG9rR9wyh2BN0BAdcnUdU9pVWpoUNqew2PiwrA1lhc8Lo68B/N0c6JqTU
 wC71c6JIzE4vkSuQAwM//8mNkCCYf/poKHc/uar5hUWtunhAksEM4Ly6tgQZm43YBzUhj82TMG+
 Q/5U4Z7tUG2aC4aLXvKKF/3OHefimTtGpzV4NkcwAcf7j1GLlhHhluPK/6Evn9iH8hsfedqwLXl
 Uwln9lnGvrDVw66nCqXWqWx5RQOLX3fP9jZAEIMnQBT2Ypx6IzwigXzmNYwO6SNpMMjMPzTxODG
 kLM3FVHDoQBo0QpVNqw==
X-Proofpoint-ORIG-GUID: WGDehPBUf8DV9Gvh_R0SoCGy3HGWzK2I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfXxsXsxN60TZ9H
 za3Zl8vPOl+j2bEozOsOwkIwfg2sPperkegsY/ypMl8+JI7GEUubHGPJs3qdWeo99b2HZ7gfMi3
 +SZgnNYVQTTeZENQyLGHDAJEyDYuBrw=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af57772 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=RwBrVW2nJu9fPh6-OooA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120033

Hi Len,

On Wed, Nov 11, 2026 at 6:23=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> mhi sometimes aborts system suspend on the thinkpad T16 gen3:
>
> mhi-pci-generic 0000:08:00.0: failed to suspend device: -16
> mhi-pci-generic 0000:08:00.0: PM: pci_pm_suspend(): mhi_pci_suspend [mhi_=
pci_generic] returns -16
> mhi-pci-generic 0000:08:00.0: PM: dpm_run_callback(): pci_pm_suspend retu=
rns -16
> mhi-pci-generic 0000:08:00.0: PM: pci_pm_suspend returned -16 after 15145=
 usecs
> mhi-pci-generic 0000:08:00.0: PM: failed to suspend async: error -16
>
> When a driver returns -EBUSY for its runtime suspend method,
> that means "try again later".
>
> But when a driver returns anything but 0 from its system-suspend
> method, that means "abort system suspend".
>
> Always return 0 from mhi_pci_suspend().

Two things:
- I think we should simply use pm_runtime_force_suspend() /
pm_runtime_force_resume() for the system sleep callbacks instead of
implementing separate suspend/resume handling.
- Rather than silently ignoring the error, I think it would be worth
looking at the mhi_pm_suspend() implementation to understand what can
be returned here and under which conditions the MHI device fails to
suspend.

Regards,
Loic

>
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index 7193a384cca4..b036fa6e06c4 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1727,7 +1727,8 @@ static int __maybe_unused mhi_pci_runtime_resume(st=
ruct device *dev)
>  static int  __maybe_unused mhi_pci_suspend(struct device *dev)
>  {
>         pm_runtime_disable(dev);
> -       return mhi_pci_runtime_suspend(dev);
> +       mhi_pci_runtime_suspend(dev);
> +       return 0;
>  }
>
>  static int __maybe_unused mhi_pci_resume(struct device *dev)
> --
> 2.45.2
>
