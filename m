Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA52FD1B5
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524258; cv=pass; b=WkDWHXfo+WcR4BFq/hT2WssFy0vBDBSjwpIEU+HjnIEjvS4V+S8itb4KJM+3ECQBk2tQPaDYdhEnIYeCIDd5GtJnuIYzWNvfa5pNbmjT1NgUkKsBVUxvE+oVRAzHQjW3Na19lixw7eER5VT5pJ3c6wRpwIhSbXNuSBGiyttbujg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524258; c=relaxed/simple;
	bh=fTRf+CpDlg8oC/q1+pBZdLSPb9okL8GDVBLZGR4FfHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxvIbK/9tM7neLLfSzFw0I6ddWkGhjUivjhyTW/9BZIduWOrzGp+0BB8LZxB9AKxuz3z35lCu5BGx2IHAhHnMDJOQ/Bxc3mtiOI55AQQ8FB79VcNgsuzoU7AEDQRgGWUXW1b9ZMY7U4+kzTdB/33pHpOR2osTu4wGj0p8OUppKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNCMzsev; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nf6uq5E+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNCMzsev";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nf6uq5E+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C43nU2752166
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=; b=KNCMzsevlh2tuc5/
	1WnIHZZhAhaywF9mfturWOYGVfOtDmek/uPAQGzO8pf5SVlIUqrprfq9VMbsxYYJ
	In4RT4IQuLvwHdCHl2uDDy4uroXw2M6EurBD8eSU3xR6PTtrM8Dmh59iWn6ws4dC
	92CbytmCMmFTb6lNx5rnJolDTaY4yGqklGGr7xsWt1VlIFJER6Uybv8uaGV5g0Ps
	rr0TV2ROBhLa1I2l3JKNmDMytA1jSAa1NTLNCifcU+9Wn7GCxMZBY2vQc0S+n/f/
	EYdNB5Cdm1Zocr9tW97T0cxeQ0WEWUd8uVX4VjqI0hpNRSjBJRCtoKTB03j6Z/Ki
	naEIwg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssu51d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 15:24:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f08560ea44so11935856d6.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 08:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524255; cv=none;
        d=google.com; s=arc-20260327;
        b=TU2GrUJbr72dZhHsEK9lhlaopo4CjIxOOENLqsjce5bEL9Hvx2tJXBsdUyW0ZdWQlG
         IOfjhOjsejrbP6ZEQViugikGVo6Oydr2t1ncvqJstgNq6OeNxxF8g+6uqmQpNSgf6Mhj
         Mrqx6rlXm4irX4D+q53nBdQPP1Bh2JLxYjfZYiMxiy3uRnNmpoEXOFAJy3JFF8kIyqZ8
         /nE4hw8kJqghRWDaxr6qJrsGgKcK2wTIsR8vBPr3DCNExucmbY4NCMTkR4ZgGeWN/ALS
         BwIW1RxkwoL/9dPedhZzJJOJKyE1ac5CaUEom3wBd0BWAn3dWDKrFpBq1CTwhAMaN36f
         VkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
        fh=uSqHChQlFckypPU2Mxk0JEIapYVB39dSGd0pf8DmHQA=;
        b=fslp9QXQrg3goXTPVgwK/mDCgsNiBl8T43jiJqfvIHXRvvcd1fEAYyxKJEsYbkczGg
         x3n97wZ0R1tW34JueazeoopA/FO5ANIoK/aCJlTckZ75TKbMlAoFYZaFs8NZu5lqeZzs
         Z4gV6z1/LwwuLaWVIO1r8NzO7TpZzCZZBnI6EpexvOn8ETX3LAmpVK5Z1pOS3vWMMW5n
         S0YXJEOcHr9xlt/Zas3cQK9ASHoAmaMwCsSExx2YdAlpZQ8EH1lcGjZwAuo5mZzo6dvN
         s0ChEsfh975gCUx9k8e6zzApXc9i2UstwAnJpJOMdEgjRP86EBoEWoVUobq/oZijv/wM
         cGTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783524255; x=1784129055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
        b=Nf6uq5E+Sb3LTeyJ86OWoOF5vgyLRqH7heBzNDDCwnmpBS/iV1isV7Qq6CNPCMsFBS
         QjQFLFfNrA1qYYHeX3v12+SLSNjcp3rmQOSmjNpyDaiqHqSObSY6X9Q70TcQM6tHNFgX
         7JmSjVheJM6IWYCkEU/Nsf2PhecyMQUeH8582Yu6+lZv4qGbAb3tDGn6V/NS/Ugr8y3g
         D9dXuPsq2++MA++4rYoOQSxQ/jN5EBDMfZy4zhNevquUoxgc362QfmBw7PtPYiV9PO0r
         afCvvMmBkQKoQEUWHpSXdT1GrQNFH2ag4xYTE32JO++5fvERGzVRUTuO4MIxGiOa4Guq
         yIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524255; x=1784129055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
        b=N80pi1JvEmuye48OIhKZ+iBp/O7iviImNJ+59f5s/Zd1GwPTYOyGT5h7NttdESf+d1
         q2v/eEGX9NW/4vUeY69OXxwCAbZE1spRrliYJ6O2ucjqw74gacVBKpi/UVf5UWx7Lmqc
         cr3IBookfBniVJ8uTDimTjzqjVzLwMCftl5Sfk0gF9ozRcE55cXZQA+IkHJXe0oOaWXR
         d2aB8DcMpdU9zUhIhdBznxLkWCXwD1jd/bZkTRKX196QUzOKLL9DS68uFj1tXgDZpajl
         t/MjL+IDM7W8oX6rWZDIwnCmC++dEtB9/eiL/9FHw8jQq6vXSVKjIQ47UPVNBcypz8qC
         W42A==
X-Forwarded-Encrypted: i=1; AHgh+RopRv29WY5IJG8QFCju1lNFbPuOqj91mFActnq2Z8N3iNEnjpOyNKh2bTl1X1MyDRyz/nR9H05spA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2Dx8REdKN1xZSwG1yfk1WpuOU1mchl5MsPnRBOl2VTW49SwP
	gXfZpSurSQfnPWkkcqR0210OpABCzEvzrOKpCWio5habcfUg4qlL3JCQRzkGe/Hz0jNSwkOMA4R
	bRDxLsO94TOTDjY38rIw04eJJylVAn8oQ6NZmA+/4IdDxL4bEU/agSn2awG7mJOoRvoGZx4WoRq
	Q2JeQAx96arvMkEhZ48ocfM3p4v6wEmZwOeDotbNQqeb9C
X-Gm-Gg: AfdE7cl3qtoyWfdXzPRSayBLXM6K7g/jLIWV/5ij9awHQA8uI4Y1qnSyXMonGLXHfLa
	YcQwifkMzv3vUIdfE68wx8h8OijXO2441yMqX3p9hA3k9Bw2HGU1MBASm4t/qdmJfhhW2bRnpYK
	coWgffJQSqY/F3NDXrENegoEAP5hpOlGehfhyygE+3hKJUtYAqxjPxLkd5GJV1SmWT2d+T
X-Received: by 2002:a05:6214:5504:b0:8fd:6df3:b377 with SMTP id 6a1803df08f44-8fec323e5b7mr31147476d6.59.1783524255415;
        Wed, 08 Jul 2026 08:24:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5504:b0:8fd:6df3:b377 with SMTP id
 6a1803df08f44-8fec323e5b7mr31146966d6.59.1783524254959; Wed, 08 Jul 2026
 08:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613070116.438906-1-midgy971@gmail.com> <20260613070116.438906-10-midgy971@gmail.com>
In-Reply-To: <20260613070116.438906-10-midgy971@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:24:04 +0200
X-Gm-Features: AVVi8Cct2pvQNJ49kCocOmZ_g-M7AfBNrJ0WxbavryIJprjGJGNLahRi4HQp2RE
Message-ID: <CAPx+jO_2=SYo0smYzwd8T+TUtHZtgXU0dSWQgZGZ_haV3aOU_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] pmdomain: rockchip: Add a regulator to the
 RK3568 NPU power domain
To: MidG971 <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        xxm@rock-chips.com, chaoyi.chen@rock-chips.com,
        finley.xiao@rock-chips.com, diederik@cknow-tech.com, jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e6ba0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=s8YR1HE3AAAA:8
 a=bcpWyJPC7eKr9KdVfhAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfX4T/mzfbC9lTG
 lsBQHwKnRlju5PVhBedlXXgM4qk51LLSDG04l9DCQweonZMhezA57pU6p2BSfmSBiK8JqO3gI9M
 1WPa88m2D7r6Ug3rj5fyByzxLByfI0bENBTTXaneUAohgAX4ZUPtyQW/7Sm2xxtJrnCEmiwt6Ed
 k/UqN4zk30qhySYi5O1GmfQuqHU3ShcGCNj65hWqQp/9tlfNzSduG/kz3PtUo3Y+/Vb9NE50Adk
 YR/t/a0SvvY0SbHbzNTUHtsyrR+Sug8yidw41SZJTKjUZsJAUBQt0Hs3essFQ/Wza83eNaow53G
 VWoX7G1GiHoGsnp2S164EtUuaRQGRevPjBS2iTv0614AhfZM9VCtGs5VgRv3/1WQgt1oe0xpDsa
 w7+qpf47txF+pRoYCrtNQNJBK3A09/TjbPY3Nt0G5dYQMh4mvpdOIiUTjtpn+aoPTf2jcGIc1Z7
 sAuq4B4XUHnW7clhKpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfX/f65R5P6+1ZJ
 /Za8tg3tv/HklYyLvCs8+SKn1I771owR2zhSbaCjqfaaQors5EkSILPqVu0IdOI5LC3Lro1OEV5
 4k1ys++8xF87SovnZww6hPG2FnJj3Ks=
X-Proofpoint-GUID: vrz4L4Hi7VgNo7FaKVkaMBkcfW481qzT
X-Proofpoint-ORIG-GUID: vrz4L4Hi7VgNo7FaKVkaMBkcfW481qzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080151

On Sat, Jun 13, 2026 at 9:01=E2=80=AFAM MidG971 <midgy971@gmail.com> wrote:
>
> From: Midgy BALON <midgy971@gmail.com>
>
> The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
> powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
> regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
> can set need_regulator, letting genpd manage the rail wired up as the
> domain's domain-supply instead of marking it always-on in DT.
>
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>

This looks good to me. I assume this can be picked up independently of
the other patches, whenever you decide to move forward from the RFC.
If not, please let me know.

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..19db307e3811d 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -138,6 +138,20 @@ struct rockchip_pmu {
>         .active_wakeup =3D wakeup,                        \
>  }
>
> +#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
> +{                                                      \
> +       .name =3D _name,                          \
> +       .pwr_w_mask =3D (pwr) << 16,                      \
> +       .pwr_mask =3D (pwr),                              \
> +       .status_mask =3D (status),                        \
> +       .req_w_mask =3D (req) << 16,                      \
> +       .req_mask =3D (req),                              \
> +       .idle_mask =3D (idle),                            \
> +       .ack_mask =3D (ack),                              \
> +       .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
> +}
> +
>  #define DOMAIN_M_G(_name, pwr, status, req, idle, ack, g_mask, wakeup, k=
eepon) \
>  {                                                      \
>         .name =3D _name,                                  \
> @@ -241,8 +255,8 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
>         DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup,=
 false)
>
> -#define DOMAIN_RK3568(name, pwr, req, wakeup)          \
> -       DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
> +#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
> +       DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
>         DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> @@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_p=
m_domains[] =3D {
>  };
>
>  static const struct rockchip_domain_info rk3568_pm_domains[] =3D {
> -       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false),
> -       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false),
> -       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false),
> -       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false),
> -       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false),
> -       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false),
> -       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false),
> -       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false),
> -       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false),
> +       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false, true),
> +       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false, false),
> +       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false, false),
> +       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false, false),
> +       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false, false),
> +       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false, false),
> +       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false, false),
> +       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false, false),
> +       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false, false),
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> --
> 2.39.5
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
