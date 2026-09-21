Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40ED497390
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994615; cv=pass; b=OLkxtktX195WUWgZmMnMWyrr3Oxhl/5BdDaLPRXVB12Y0rg8IMul4B8SgKwSn1O7CHIt24zky3swWYUgCPfGOpf1lZBxU2mTK/y6eRe2dDf6zN0idWocG8gv/M60W7RT/AHt0j503JPLJyeSqUIzQjrINzdEPFcOzu8s6uGjhu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994615; c=relaxed/simple;
	bh=Ot1FxL5JjYevslt62pC/ZLUd4qxLHu56oryKSsjlHBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzMPi4iGG5QZ4JOev1s2vR3MpHG242TlID1wDdEGlvMqUP7hyIPPTibEaUWLhhGNos4g1CfrGTSTP4lPZiH4GxII1uzfN8eG6ZHr+D0FD8qwDLkddIAIaNYbrxCgMaKOpGcZ2olrHLMtcbHbm1BV+73KyA+p78qmrEr/Arqn3JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjNhQMW0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GFoN/tl4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjNhQMW0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFoN/tl4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdxk0934211
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=; b=RjNhQMW0qXvCl9e7
	TSqSjkDCMfDvn3tLw3Cir5ZYA42nfF6E17HauGaX61Fj0ylBQweO2l6cu7Ja1ckf
	bTkYPxta1GMCaU3pKkI2VxKH3oak+zv+0Td9/U1IMNUWo9PGFgsaXdK0JbDAjy8E
	9WUe4FSN44FrQeReNOrusu4zefIi2DGS7SlM93UNUJZ92ubgeva2ZyevUEOjxHgm
	1KotCQAkWGKs8y5QQHk3iqcJBOR/BwzySMjwYrff7wXQWAIWtINpjTKMkhDJSjpT
	vrUr230c/RwSaC9P6ePBdhDIZFQVeApKVBjMFEfHcYYTAeFF6AZOdcpBgQs4XRUb
	HmK6/g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8ban5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:43:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so41507135ad.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994611; cv=none;
        d=google.com; s=arc-20260327;
        b=e9GOgRxU5+mzPZ84PvfMzW9dcAvmMJVvh9b5BCEMnD2Pqi/8WJ3JU30bgN3/hliPM5
         WEjM7tH5e5DHu2F67GZHFO2TlHjNnk05LT9clTIPfAXPMPePuNo282/Jaa6o1QEK9Gp/
         wFVSPpWD02tAk+RqcDxhPdj+FXAaf80V2myOULiA3HlcV/g7unVZgj9HZ6z4yjqNzruS
         PKDNyZbclgfZ39c80Mrekd3CZlnsivSahXObo9kOme6OXrATaO69LuEQGoAC1BDEUl34
         fD9Wm2iYLIMBK4oqtjS8xIBDuIevj0Cr7MS83HtK2nsyQNvQ3zutQI/2Jr/vSbfC7n5z
         OpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
        fh=bjVSEIeLbnRATNdD7CSWQjfGFUWOLVGjzDf0Sllv1/U=;
        b=Q1Z3gauN7U0C2WUfV1hZ+amdwIJzLYS98/OIxbU4LUlJyBS6Zd6VuQxbFgNrAYlIT+
         so5wNvi4iKchKDhe9GwLHaRhJEqZtgdSmYPDKTuIH6NsZb4fz/IRafpW5krDW6S9achu
         +N5Kudl6Z1xdPp/bSril8qzIjKcIVx1DnpIC04is3s/k1GHvdgb/3BaXwPVBr8ymShuv
         FoK1Gkfb2O/ExaFSncyXT7RkLXsUSfVlL/wHxsgGxtRogq/Jje4MidKqm6O1XcA/TebO
         xSUQlylN3mnxPJem4nIQ6SVQcNLi6T59SfzJIwuVtQD1fpEhUzI1jqqirvnH6aPO6Q3r
         Q7Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789994611; x=1790599411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
        b=GFoN/tl4LE47wCdhmAqxjoxKPnjZMLZUlxPAxboqKnHHSmNCgrdfrNDlIZ0zzLKF1X
         cpH1bLmH0h1xxoc4rOj2YsWUgSJwR67rlUb0yXssrsKqnzKHq6a9ELQOM2zzKoakonP0
         dNG0afSHD/hi4R0W1iFNVmux6py9oGBNAckR6tbhCkkRM0cvJfmxJ9REfkwZoz2C9MIh
         gA/+6HpQ7ZbtXVqGF7XJrc2yhGWDS7I8P0sCBKEjWuFSm2vSkTJEmqj4F1E7aM7HvX8h
         tAB/qy/stMd5eXb1nlGhXATLCrY9mYncToMJfHoLYYocEKWwYhm0Z4OD7PEp7b6ny+Xe
         sjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994611; x=1790599411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
        b=SG8qh8z6LfdJdPiPzRwE4B1r4HY3JqWqi3aaZsXvvdSmFTDfJeVt36HINiRaj+ov/v
         Ofh8Kxpna5HfKyV7UUswIy6xBQ6iZrZehrgtWFYdPH/8b2hYvElbxJ6tVpCiu7xXZrWr
         zvsLL7SEyOH3a3tDJWqbPhx6NzQ8nQhrFnYzKXZcSst/2nkMVBavJKutH2AQV/z57MVi
         KjPSB6C8ZvHxDqaN5/0YIUIsMAXQJI5sjpEFl4HYgzPvpqHFZ2Ke4u5jNoIqNT/Ps+W3
         EIZGRwBIFHH8R0B5JYX1rViB2euqSEPespx5iTxH6N8DYtRC1WXqPr59uDM+8MCmzx7z
         TMiA==
X-Forwarded-Encrypted: i=1; AKwUvByJFpbuQbOL5yrDuFVQu/RRBBtjbomD90spvHNJOIWghAPKY+CTALDpGdFsUDC76ab+aEHXBV/ngw==@vger.kernel.org
X-Gm-Message-State: AFuF++lgM2wGYTv5ABiaQYh1Z721JvNmzoWDBBEurQAS9ICbKRTd0JNc
	3MFDdXYW4e4WPKIvzUA5TU+Fj5EBNWMi5CmEca78AxPNF9ZUiwYReHR8j/OIckRiakkh07Tj2e6
	ssPY72KsTQXzs97y6u9yYiDjTZUblrOrSlD2Nc+Sodjwe4lAIWFkUSBN8NRCup8fVO4Dfpq+qAs
	c41/FTxsVLlrnYzi/jPnyR/xtGZVSm2iaalNlS
X-Gm-Gg: AYBFou0W3b1gFB9u+KNArscYVY7GH4PbsTrlHBNCnP+62k7TlL9LH5bJkEeBcIJ+10H
	vN9iEZJq2qwqaR9vIqTU7SMIW1//sJNsBA6y0oG9PU57l2Z049rfVHCDzZYdyofhPJe8Rau/aaG
	d32aGaLnOMK/62Pi30WU5ubivXtZQHe7Hzp4K55GMbrymXSYQO6aQJoKEVTw==
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id d9443c01a7336-2ddc10044e2mr89288655ad.50.1789994611229;
        Mon, 21 Sep 2026 05:43:31 -0700 (PDT)
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id
 d9443c01a7336-2ddc10044e2mr89288245ad.50.1789994610661; Mon, 21 Sep 2026
 05:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com> <20260915104328.45901-11-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-11-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:43:19 +0200
X-Gm-Features: AcwNN1XRM4Zpoe9SV6Ox1cb4qr0Qhj7z7Tg6kKrM_v7MoPDIacNjWOamn5qOldA
Message-ID: <CAPx+jO_MFkUrzRDnuoqn_yKntRc_NqPs=0nda6wC_xgb+Fy7bw@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] pmdomain: rockchip: cycle optional power-domain
 resets on power-on
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
        sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
        u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
        diederik@cknow-tech.com, alchark@flipper.net,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX/vHwVMoiSADq
 Eg+73EuqCk83R/BP3KuzWHJT6au7Vj58d7oRTGV6fJVR/lke4GJ65dCVltMj0UlvBzmHghXGQ4c
 0LuS8cRz7zKzUHyP+MJ6WfC3Skmqz8FJhpP26rvZy1H1Z3PRANgxcm72BQ2rG6dMzKm/POi9S9Q
 X0626FAcffwV3OtoK15WLbts4ke0k2y8VOFC9iR19226su3Om9byenjObf1kJcBG9xlUkP7B3If
 pQvahFuKNcZiEEq8dOD+b+ER5XhMjHm3fnxzPh2XDvSoGrvI9VtZpa4mZ2iWqRsgdZbP7//TO+s
 hMy3LnYiZ5x0p2IwS83klvQBOrOPrVpq2McA/7n/fXr9uNkRZKa1o0sioeVqVW5p9EdwE1HqkIw
 tGFePcWDV9/tCnkaIn/e0vB+YC6keDhe9SBdaGw6FQvtRJq2eDitP9B+gcUS/dBLlG3V98/sY/L
 p+Gt5wZk3Q/wl/y4H0g==
X-Proofpoint-GUID: mAiFgKjFS2QonUQkf8_zy68itazoBWxb
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab12674 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8
 a=xnVI1lRHtBAIIYlgu6QA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-ORIG-GUID: mAiFgKjFS2QonUQkf8_zy68itazoBWxb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX071pKpHQGzni
 2OFqItJVKp+Kz0wTd3draVHM6k+7ne2fZQGkn18INEq/HbWKuBFhfSfhwsbM13woLisOQAWypor
 EREJdRLuUl4ShAHjIYL59dZk0FiZVG4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210182

On Tue, Sep 15, 2026 at 12:45=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> Some Rockchip domains come out of power-on with their bus interface in an
> undefined state. On the RK3576 NPU this shows up as a hang on the first
> register access after the domain is switched on, and pulsing the domain's
> resets at this point clears it.
>
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains tha=
t
> do not list any are unaffected.

Please drop the below from the commit message, the above is clear
enough I think!

>
> The cycle goes before the settle delay 9/14 adds, not after it. A domain
> that asks for both is asking to settle before the QoS registers answer, a=
nd
> a reset deasserted after the delay would leave nothing between the deasse=
rt
> and rockchip_pmu_restore_qos(). On RK3576 PD_NPU0 and PD_NPU1 ask for bot=
h,
> and the reset they cycle is SRST_A_RKNN0/1_BIU, the bus interface those Q=
oS
> writes go through.
>
> It only runs when the domain actually changes state: rockchip_pd_power()
> returns early when the hardware already reads the state being asked for. =
A
> bootloader that leaves the NPU powered would therefore skip both this and
> the delay, which is why 9/14 gives RK3576_PD_NPU need_regulator and force=
s
> the domain off at probe.
>
> No in-tree DTS puts resets in a power-domain node today, so every other
> Rockchip SoC takes the optional get's NULL and is unchanged.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 39988efd8..6cc8d6efd 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/reset.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
> @@ -103,6 +104,7 @@ struct rockchip_pm_domain {
>         struct clk_bulk_data *clks;
>         struct device_node *node;
>         struct regulator *supply;
> +       struct reset_control *resets;
>  };
>
>  struct rockchip_pmu {
> @@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>                 if (ret < 0)
>                         goto out;
>
> +               /*
> +                * Optional: some domains need their resets cycled once p=
ower
> +                * is on. This goes BEFORE the settle delay, not after: a
> +                * domain that asks for both is asking to settle before t=
he
> +                * QoS registers answer, and a reset deasserted after the
> +                * delay would leave nothing between it and the QoS write=
s.
> +                * On RK3576 the reset being cycled is the NPU core's bus
> +                * interface, which is what those writes go through.
> +                */
> +               if (pd->resets) {
> +                       reset_control_assert(pd->resets);
> +                       usleep_range(10, 20);
> +                       reset_control_deassert(pd->resets);
> +               }
> +
>                 /* Some domains need to settle before the QoS registers a=
nswer. */
>                 if (pd->info->delay_us)
>                         udelay(pd->info->delay_us);
> @@ -861,6 +878,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>         if (error)
>                 goto err_put_clocks;
>
> +       pd->resets =3D of_reset_control_array_get_optional_exclusive(node=
);
> +       if (IS_ERR(pd->resets)) {
> +               error =3D dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
> +                                     "%pOFn: failed to get resets\n", no=
de);
> +               pd->resets =3D NULL;
> +               goto err_unprepare_clocks;
> +       }
> +
>         pd->num_qos =3D of_count_phandle_with_args(node, "pm_qos",
>                                                  NULL);
>
> @@ -931,6 +956,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>         clk_bulk_unprepare(pd->num_clks, pd->clks);
>  err_put_clocks:
>         clk_bulk_put(pd->num_clks, pd->clks);
> +       reset_control_put(pd->resets);
>         return error;
>  }
>
> @@ -949,6 +975,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
>
>         clk_bulk_unprepare(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_clks, pd->clks);
> +       reset_control_put(pd->resets);
>
>         /* protect the zeroing of pm->num_clks */
>         mutex_lock(&pd->pmu->mutex);
> --
> 2.43.0
>
