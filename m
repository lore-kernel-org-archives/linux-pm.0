Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FA4E80B5
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558507; cv=pass; b=Mw48JUtA9FPzuRl9dbzGbCy7/UiP+SdhW4p3Ri59qWBve9YuE+A+cL5zbRP8srtRqtHthb09QiVQkzJXjLCVMVUqk7hE+hoBdLOZAp2rnjLYAg7Qeg2ak+i5fVdHEiET+U8bR4XI/ZVLaGqKKPhkeY+FF+sGG2Msy0XsrB6Xsok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558507; c=relaxed/simple;
	bh=sOzw2zM+saxLCKn1n8FrkmOltMtz0twy/n/1jq7OZ7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJFgp8dzedlOu7pu2HmLPtkF7TW3Z6JEMRKJQLBtD6a4tUzmtR1Nxf1Uxom9yTJFXDAKWMiq1T8MVQMgvLzDQkmNGSmTd94mKY5onjNvmiwLPhep1o3Kq/Au+R+PiGzkweW4VWLW5wuUjhx5ETxdP8zNYA7poqNDx+1iNkx2/2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLRFMEgP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F0LgVEsh; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLRFMEgP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F0LgVEsh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92uPK1553080
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 11:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00PLRbaZlcE4ViAM9gkHo3TXoe80Nwm/jvHOjI3lpvA=; b=iLRFMEgP2FzH8dN6
	XGP3KUPuGt7FzVUF1xo/bL5z7ZdzCqhLDmhjp5tvqdNbG55603pP4mWiyEVfJjve
	r+N6Prsb9amp6W2bbvnLLBZx1nEz7pAmpfrTrhCNq25gsoJMzfAo5brXR6mI28PL
	uSvuEN08oFnPWlZZAE7JjDxLqFa5sgLXekMyrzaHQb9m/faJOBbfop06b+qUN4IX
	gNiblV/IeU+vuHu8UaIuOyhcZQVaZUnUg8Dz+nluSwp2Y3sbAtpFd07o4kaPKEmc
	nX8lCPg914X2F5Ih2Cv3U1TF35MDClN9OXvfbjMPyx3KnDtNYO/yF+3yxYPj+GN1
	DgtMKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n64cgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 11:34:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc44d708055so9246909a12.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 04:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789558487; cv=none;
        d=google.com; s=arc-20260327;
        b=KNjN+BUG8KsxqWnNeQL5bLAd7Z9So/UV/seE++4p3LGWVAXhg2CaGcVry3gOJ70HB4
         Zb/HJavUZn87oMTzZS0tVfoMzuvRIH9ABwQgyofOX2l7NuNPz7cSPF1imLZDhBWmzPFn
         QHSx/lNyCZRwqi93RPFnoDMz8erAWFZD+pybT45WAaiJt9AGHBvS0L649Pa3xXmA4G+p
         3dw4QIs3QEJcF0XZJ1Z3L6O7wiftS2r95PP8mbmT5h6k7LhFNKZMOeK1BesucI2iGlpI
         SVe0WqEB9g3aUmIvupEEDDJP44EfMgieuVHP2EuoKb0McPZCLy1IEq4v5nB8c5v05A7p
         MCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=00PLRbaZlcE4ViAM9gkHo3TXoe80Nwm/jvHOjI3lpvA=;
        fh=h7jsbJm+evt3pl8QEO4OPNNRNtV6cNctyzveYkIGD08=;
        b=oI63SWeIRxHY12IAKJ6YcKdEr5W9tI5Fy7YudBohDghob+h4u3SfbU/sLZDTlVXm/c
         Dof8ii8fOcvLD4/7T+SXYB0YAw66n6xYhmMYsWFqfXCIDdVgiNIH59Yv2Nyk6Uyuftzf
         gDSH4gt1xyYmGUjHa3JTcNoEsTHwTHLlHRZtzcRUm87JR0mhSk31EaWJIFt11pwf97zw
         WE+/P4ebFTlOcBnI/ejrVTcv/R6IPzOv6KYlT1n8eebyxatThzMYL56CpygxxMI1b7F+
         DXmCYCZjGKU4kJVgjv9qaiTqOYJtjVT5ezK9jAtooe5pIVpDKZcDLod3NNB4NPH3ZJWT
         oeow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789558487; x=1790163287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=00PLRbaZlcE4ViAM9gkHo3TXoe80Nwm/jvHOjI3lpvA=;
        b=F0LgVEshd1kgiFs+wFxIHvHlS46UhhNug+4edoyQWQLK2+9xd34kTWPMMKQSznF1iN
         K9Licm6hkF5abwfjInfAUHhpAKg0A7rK7na5U5mdRHu+EVFpzwJLNpxcCgXKO4FPpcEg
         WXfcFMCMnOfVDpZK60QZC3gRVvwzfDEWa0MnxfyxCKNYhFIwX92zaoAZRw4EJKP3PKLJ
         jJdHbdZwGJ3BH4bNwvlEjwN95ZZzW08P8bprdpQnX8C36ahasPkpuF9DFxFeyk1Zlc+9
         iTqyp6Icjz1HqWCTMrWzUkml7sdvf49ZpzUGBbIMMwGKVqxHS1l1iWt//HLReTZ36mZt
         K/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789558487; x=1790163287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00PLRbaZlcE4ViAM9gkHo3TXoe80Nwm/jvHOjI3lpvA=;
        b=Dipdhg22NNZzO1QzU5ccm9wy/uIitMwOhbh0CFezvOLU4u8+mENHB3fvNrSuU7XGBk
         +H228ILUFZ0xy0Y7BjGG7NwexI/YUJEJQ7VSQHVv4MA0fd7FTokczYaU61bl+ssiWIFN
         R/6qzFGoF3uX+ZcdyEzf43QElCkjfFiQZoUHT5FZ3VEZ8Jxt0l9BuU0pj4CrfFBgEIlg
         Y1Rvz010a0s+ZMkA0VcbkdR5FCutpGZeCvNwZ+7UGbgnomfN5Ax7rVRTp4iUtxltaWur
         yHJgANpVECR2ngFL0GeSHcJopkxch9AeZ59hXsXkFR0EgtkECbUYHYqLtVE8S5DdksLB
         Itaw==
X-Forwarded-Encrypted: i=1; AKwUvByJPAxFJW2dw+qKg5RU3SN9WnBgE8mhpXnVDZ/K1hvkR0aUDNIUsiuVPg5Sq08fva+sFhLsePZTZw==@vger.kernel.org
X-Gm-Message-State: AFuF++lTc43yz8FUg07ls4JiKKpN4Z2ZkE70hHymo7QWPskoggLZH6Za
	vbC27UGcoxTfhqyaGEMVhg3CbwYsIEzTp53j4sQlWnOhsrPtiwTJ+9G42diT2p5/MOshGQ6WrPO
	a2P8Kj/Dnau5Ke7gxnPEFh9FVm/DvOdgpeNdGTAmvMwgT6NUxhRDLs8Qf26uHzOUGrdai14r0WO
	zOKC1ANr8Cth7zUNOenUEGfPACBWSUPj67X3QXVhT+wmIhOVs=
X-Gm-Gg: AYBFou0sq2K9lncuHkWfEIa+esoA/fXLL7b0CwVhm+8PmCKx9xbZu4S6YoPqgM/FJuD
	DRcijY+F7+nxvfPVIAGaduplio+dnF2A7u7QAcGAV9B1PxB77WsD82Mx0dM4SisiBdTXMuVmXbQ
	7sp7FPaWCbi7+0S7QWbKlRHYZGmVrLy+YpsTg3XnrhpWPMbE/i01fQOagbXQ==
X-Received: by 2002:a05:6a21:3a44:b0:3d3:ae50:97cb with SMTP id adf61e73a8af0-3dd5f7adaa6mr5895925637.24.1789558487085;
        Wed, 16 Sep 2026 04:34:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a44:b0:3d3:ae50:97cb with SMTP id
 adf61e73a8af0-3dd5f7adaa6mr5895856637.24.1789558486699; Wed, 16 Sep 2026
 04:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 13:34:34 +0200
X-Gm-Features: AcwNN1WUIqVDgUhzyDXl1QcU9iqF_p0H7ZnHb6m--NRBgYnIObrjnuaLwlOazm8
Message-ID: <CAPx+jO_Wk6ksDLHfxP3oJ0m8qBY2+2qR_rPSH67MFDU6y-ANXw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Honour pd_ignore_unused in the sync_state power-off
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hiago De Franco <hiago.franco@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa7ed7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=Bq6zwJu1AAAA:8 a=p6MmSexonW_CJjBW_Y8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE1NCBTYWx0ZWRfX3Ollqe9ClOmO
 rJKagWnAQSsG8fZ5yywMJGkgToe4WbgbPRBABpV71NEROYKUMxaSP6z94s+WWUpo5ogZNZlQNQ1
 rS14oxWxj3pPsAZQDUbg3CFZKeqPc4EgDw7pzfiD8qn5ENEpGFnIjwM+aufbBqga+VkvnniFTeA
 vsjgMkjWr0cmqPFjuTI93yXLyPdqQIxRpV9CbGbJ2HksnTvHWkmaMiC1d415R5c8T2AwaEV/mJZ
 pDna5Y/xp5mprOLqV4J14HRmX77DFVh1A6PhBfwIRAgoPNYScCm/X1jMImElyJJkuN4/YT03drH
 QzYVd4F21hQfBrTCm5I0zcwXpJbq1Yz9v2uUOn8z12yNpgWkSBPUBLpECSKZi16AgJC7xJdB/0j
 NRM/VlXxdowAUEMOC6SliV2DqYlw8JfJBZZphSU/lPGs/s9hARFWP83n8tCNtvRI9KtJP2C3A3z
 FZ+qGTI8Uew6+GZ9I+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE1NCBTYWx0ZWRfX6oOqIQ6NEuRL
 xWVz/Fna5Tr/z5FwFx1XpdBq9IaIfYUunLJFdtSF7pexNrLdj5QZqt/q9R0JQXp9y531o3gyBX/
 WwqTIKDq1IXMBGlGez3OZNID3ZMaSE4=
X-Proofpoint-GUID: vkS-8bXFtjHIY3PRWSgK2zyBu166ifU8
X-Proofpoint-ORIG-GUID: vkS-8bXFtjHIY3PRWSgK2zyBu166ifU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160154

On Sat, Aug 29, 2026 at 9:51=E2=80=AFPM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> The pd_ignore_unused command line option is documented to "keep all
> power-domains already enabled by bootloader on, even if no driver has
> claimed them". On an OF platform it no longer does.
>
> Powering off unclaimed PM domains used to be the job of
> genpd_power_off_unused(), which bails out on the option.
> Commit 002ebddd695a ("pmdomain: core: Restore behaviour for disabling
> unused PM domains") stopped that late_initcall_sync from clearing
> stay_on, so it can no longer power off a PM domain that was found
> powered-on at initialization. The only remaining path that clears
> stay_on is ->sync_state(), and it never looked at the option, so an
> unclaimed PM domain that the bootloader left on is powered off there
> regardless.
>
> Honour the option in the sync_state paths, for the PM domains that have
> no consumer attached. Those are the ones the option describes, and once
> genpd_power_off_unused() has bailed out they have no other power-off
> trigger, so they stay on as documented.

The problem with this is that we have child domains too. A child
domain may be the only consumer of a parent domain, but not
necessarily having a corresponding device attached to it.

That means that we may leave parent domains powered on, while they
should not. Maybe not the end of the world, but it's not consistent
behaviour.

>
> The stay_on constraint is dropped either way, leaving the lifetime of
> the constraint unchanged. The PM domains that do have a consumer
> attached therefore stay under the control of runtime PM, which the
> option has never covered, and a PM domain that gains a consumer after
> ->sync_state() is not left pinned.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

If this is solely about bring up, I wonder if an option could be to
add a device node in DT that acts as a consumer of the power-domain(s)
in question.

In this way, as there is no corresponding driver being probed for the
consumer, the ->sync_state() callback for the corresponding genpds
will not be invoked. Then, step-by-step one can then remove consumers
of the power-domain(s).

Kind regards
Uffe

> ---
>  drivers/pmdomain/core.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..c49d13b3068d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3673,6 +3673,29 @@ int of_genpd_parse_idle_states(struct device_node =
*dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +/*
> + * Drop the stay-on constraint that kept a genpd, found powered-on at
> + * initialization, from being powered-off during boot, then try a power-=
off.
> + *
> + * The pd_ignore_unused command line option asks for PM domains that no =
driver
> + * has claimed to be left on, so skip the power-off for those. Such a PM=
 domain
> + * has no other power-off trigger either, as genpd_power_off_unused() ba=
ils out
> + * on the same option.
> + *
> + * The constraint itself is always dropped, so that the PM domains that =
do have
> + * a consumer attached stay under the control of runtime PM - the option=
 has
> + * never covered those - and so that a PM domain gaining a consumer afte=
r this
> + * point is not left pinned.
> + */
> +static void genpd_sync_state_power_off(struct generic_pm_domain *genpd)
> +{
> +       genpd_lock(genpd);
> +       genpd->stay_on =3D false;
> +       if (!pd_ignore_unused || genpd->device_count)
> +               genpd_power_off(genpd, false, 0);
> +       genpd_unlock(genpd);
> +}
> +
>  /**
>   * of_genpd_sync_state() - A common sync_state function for genpd provid=
ers
>   * @np: The device node the genpd provider is associated with.
> @@ -3690,12 +3713,8 @@ void of_genpd_sync_state(struct device_node *np)
>
>         mutex_lock(&gpd_list_lock);
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> -               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> -                       genpd_lock(genpd);
> -                       genpd->stay_on =3D false;
> -                       genpd_power_off(genpd, false, 0);
> -                       genpd_unlock(genpd);
> -               }
> +               if (genpd->provider =3D=3D of_fwnode_handle(np))
> +                       genpd_sync_state_power_off(genpd);
>         }
>         mutex_unlock(&gpd_list_lock);
>  }
> @@ -3719,10 +3738,7 @@ static void genpd_provider_sync_state(struct devic=
e *dev)
>                 break;
>
>         case GENPD_SYNC_STATE_SIMPLE:
> -               genpd_lock(genpd);
> -               genpd->stay_on =3D false;
> -               genpd_power_off(genpd, false, 0);
> -               genpd_unlock(genpd);
> +               genpd_sync_state_power_off(genpd);
>                 break;
>
>         default:
> --
> 2.43.0
>
