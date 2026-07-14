Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10339445AF1
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032314; cv=pass; b=aYqf+/L5h+HKxKtOucoio8BtBM8wf6BfRkpHxKNUZ8R/Krwdw6wnjlrlH8LDOhP9BXfa5KoWhob/esn/UgwiYY1n5UPkc9yOpTBMRM63BHerIYN4jW8hL6PDxLn/vhJuS5wOlvXiYuSbvCdvo9HFjPxFgRTXiOH74uPzKqC6/6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032314; c=relaxed/simple;
	bh=ji3uIpmyKNhCWk9sN5ktVEemOSik2hw33b5vEOk3sQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIDDQUS6DYxQg+AXSdhXm/I4nAJiur3YNImn1UZ7OKCTLH3g7zJK7Aq6iwAciUC6yLYmPvwie2HiI7IrVJl1aXFDf/dTQIAJybpjjm44Uj9e0Ot1fv6YxqKKVFKx3dYWc0bxiuMaawG7WIxhojiwa1ZL8D4quGUo3+/Y3nKI2aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pc0ZlMeE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CIb2hTp9; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pc0ZlMeE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIb2hTp9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBO8Q5448133
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Aolgj7ExGp7W3yDVV9JBeGUKfuVnW2a9wH6o4+naGQ=; b=Pc0ZlMeE/Tc18FPN
	qe3RnE7NymV3SObOIc4FWc/ZMmsgt36U1cCl8yZUhYe7hZglmy8uhaTuB/s83WLL
	Kq/EvZEn+mmdnNSoFutGXKKBkqoB3Uv/jXvuBI0/yfLbHb66Ig9BvOd7EICXkRyr
	Db7oeuQkryAz6x4aGnDLAZXZrPJ7nPmQKWDcxLvuPyjFkVKK3SjAfC+hV1G9mVbd
	oOv/HjEKt4KPkVMfGzAH1ex/t//dsLNli7HfurHC+BUpDUS33YPd1js6RPv9rpwc
	+yhvdNhoIErbIlzzMeQJRzgNAcVWj9actgAwf0vlMRtNwA8AShY4G5sDGs95XVkg
	Hu2hEQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44juq31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90410c668adso66768266d6.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 05:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784032302; cv=none;
        d=google.com; s=arc-20260327;
        b=agWggqifxk7tmMdjHRA0kYBYg15J1i07lvsP5BVKFb6Neb1lWsItXYCa7ecFc3QV6N
         N0je2ivSLE6fprNYRi/Kx3w3qYLlsgVXw/ux5M6XvvMgllgNOzTqeKcEZLgXXjOtImah
         RkN/a9FmXoEvjO7kvd9sounJ6bYLBMKGWq9hx4seGAhpU/S6LYjbVkP5FCl8UZO5YkYJ
         B2nf2ZH6uhk8pIJgGUhTfh2lLk7w/qIIk9k043D+QajUzY9CHQg85qDS6v8ZiPqmqJAN
         bIcj5nATxl/T75+JUPg/JRZvSXYDgb8YxbAudLQB5NtxUZakV0wHYeteqW0jqAnNjgoK
         lzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Aolgj7ExGp7W3yDVV9JBeGUKfuVnW2a9wH6o4+naGQ=;
        fh=eNj3W9bGmoMLvMDUaIL33S4PL0bwKrv4ZqHbEzZyu54=;
        b=ZOZDukAudmEz6Owm1YhdC/0KWPkEBxMraJ5Nkn9SvVHubbCsp/9YgEtRexIYuQU9au
         4rbr8hhcMCfOoN9vt/9xYtHGbG+uhSsDpsSCXMYZLzRuDZMvetyEr5Eh1X/nqmdGRHbP
         5zlhHQUTlauYYH8sFSo/9WMPRgGcHO73INSIzdWstoJGiKADs8rHLuvMnZb8773289Ca
         LIK/EsWWCkEVxKVZb0iQdFMJQtDkJ7Lm1hbLK2WJUsw2Fhw32bO4cJraZzZxxEG4Sfg1
         xPKl2oQW21zFIUSNCRDaZ0BYO8iJ1cSJg7W3dU2w/zZWjuSo90CgBNyaaiUk1ZYsuibK
         zWvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784032302; x=1784637102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Aolgj7ExGp7W3yDVV9JBeGUKfuVnW2a9wH6o4+naGQ=;
        b=CIb2hTp9sJ9LNPmkTS8PthiNnwWChroVR6yZEn7mgAn3TMVA1bNWGjhDx69l9L41Km
         GIBgFwiMvxh0oi1LmrU727+Y6mS8BPmVhdogTOBKwHxywhWbWWeD0u2sGfydrpw5Ltqg
         XnuPhL0CqSMKSdtYyFMJIxCBxJ/TuQPNKskm3lpn4fzWKLYpw4+UsWfTVA1HVIz5dDNo
         EUTgv4StgM/GC5AP0dk9F9++hqgAdCUWLYD0cCaxGRj955KvTZb9WqBgp2IVC3hwKrqM
         +Mj78sEcOWFPOxLJk/KMpJ1q8h7iSVgT6V/NeSmhfcM7eaRriVLa8YUQbbww1hMIsO3p
         V0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032302; x=1784637102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Aolgj7ExGp7W3yDVV9JBeGUKfuVnW2a9wH6o4+naGQ=;
        b=QdeA5Qzfcq/+9PgwsxvtdwIEu2FrMFBQ4g4mgvAvlvxSQQPc7JT5pd4F/oyPUzv86W
         J7iMaJ+uw3da7W4HSIpDGxPbQnbdV+tuHFO5r/ViuH2wgILJ3CZclYxtd83YwVMyoxEb
         eQFzs57uuBc4LWMDiRhe0eeDJ8vPcRhxzINMCCZ5SS73KWcx+0ASkj3rg/i7ad0EBqY2
         U94sG3/ccgDbVP9WJg4wdNoQEzyli6ysFRg0FKYzYdx2jTPF5HVDVbtHG/Y0mPvgBLXt
         rvcqtmDcqcicg1q9LHeagnTuDtn1GpbaEPxledJOZpT08qxHIiN1IBwTB3uToiBdU+Xq
         1fvw==
X-Forwarded-Encrypted: i=1; AHgh+RqwXDc9c0k+zzn8Y2ZvkGnfKtIjEVS7fAABa3L+rHTghnOi1qLuXdcarusN4XTfFshT/c1M/2QHYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWv0v1mxaw/b+0g3Fi6qpOqhQGeuXZ2x8ZacGywdW/wdOySAcf
	/G/eBhbaBWc+oL2nqCHGefs2/HOz3H+FfH96gkMGkp8U8U3qW8AZ1hdCnWpDZUhoKQBX25PJlE9
	k5rBuom5PQGL3Gf5rc1gqzuKBrkWUpfUe7T8u3OdiFMDS0fHZ3ENf/N+FwlUWUAEniQTfZAGbJK
	CP3u3PeXV/rrfvhXGTw+z4l/rrg82CoyJZAflc
X-Gm-Gg: AfdE7cm+6lIYuaB9lqjAZq/hcJ01wMFDF/g3Aj1hyga2h5j3kiinVNQ+oMifOTEcfg3
	ua7F7akVaJzx+B4shKHFr2RBofdWtHkpCDXLtX+CVm8Rc6aqHooRpCKhHcPJzOfYpFDeGHh4nQI
	P7Ybs+HTE2mual1b70Er1AcDfsgim9tEj9b+2uvAYbBtWqe/NSyr7WvvUTbZusVIZ2g255
X-Received: by 2002:a05:6214:3385:b0:8fd:6e12:9710 with SMTP id 6a1803df08f44-90747d1cbf4mr35409116d6.62.1784032302396;
        Tue, 14 Jul 2026 05:31:42 -0700 (PDT)
X-Received: by 2002:a05:6214:3385:b0:8fd:6e12:9710 with SMTP id
 6a1803df08f44-90747d1cbf4mr35408856d6.62.1784032302033; Tue, 14 Jul 2026
 05:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <fce1aa52b181082f260a824fe38baf033ba8f56e.1783505329.git.geert+renesas@glider.be>
In-Reply-To: <fce1aa52b181082f260a824fe38baf033ba8f56e.1783505329.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 14:31:30 +0200
X-Gm-Features: AUfX_mw1w9aani-kekqL_J3mlM9LGY41ZFq3mfPK3ex6sNHNGM7Yu8pRBTDGFLI
Message-ID: <CAPx+jO8W3MdqnJ-4EgbmFvODuX9BGcyww=YRn=_CknohfSWOjw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] pmdomain: Make genpd_get_from_provider() public
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: zLkxpp__mv8EWzr-VIfvzrMEtqgyHnHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMCBTYWx0ZWRfXw88VKr9AfUNz
 n5qq2dcVWx/uc/MAyU13jivT3JavaWzR/34NhqO98Tg+y9zmc6Dxrfpa+R4nIRECzJ2BQsSgKEu
 z+bRDsPutpq+xZow/XZAIpG5LCI9bipSvZvfhgr49cJFuu+FtbiRj00PDjYRt4Vs2ZAzvTHyqjm
 97b1swTEl3m+YgAwAKiiZ7F+YKQcykNw6U98nKlj0hyrkSN8sAlkVidQX3BMRYfq2tnsCGe+ZvI
 rLX0IitxDxMzHoE8rzBVSaHclsfUlVlOsuGjWFrzLPf0fN2EBtDxtBGyAZ8MKWcD7P16zRhwBW1
 Z6Lv0qrU549zF7TX1QCFLA/cz0Xktk7na+z0MRprjwlmt8yNBdGHUAjLK8e3YJhvgacGXHz03jP
 qGcxofvKRV+2GL9GhA94uGE61Hd+LMwmjYgYg/RjvLthLA4OnWkbseye2p2glnFvWTElqD+AXo3
 K9S6G+5kXMz2QSyG0dg==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a562c2e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=BvHvEDz1nzgFWKTw3gwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: zLkxpp__mv8EWzr-VIfvzrMEtqgyHnHK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMCBTYWx0ZWRfXz3AoGyJfJbzJ
 chGMHUQQWdmJqCFfl5nktIbd4Gkm6nQXTcjng3p4aLfPzCqPpDsXEjX90Mkx8sgaZNX12+n09kW
 kQiVZagfdEtnjpY5zbRgGZFczSPMrkE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140130

On Wed, Jul 8, 2026 at 12:17=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Unlike the corresponding function in the clock subsystem
> (of_clk_get_from_provider()), genpd_get_from_provider() is private, and
> thus cannot be used by PM Domain drivers.
>
> Make it public, so it be used by the R-Car X5H Module Controller driver.

I am a bit reluctant to make it public, because of potential abuse.
Moreover, there is no protection or reference counting of the genpd
that is returned, hence the caller needs to be careful.

That said, if there is a strong argument that it's really needed, I am
fine with it.

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - No changes.
> ---
>  drivers/pmdomain/core.c   | 4 ++--
>  include/linux/pm_domain.h | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290677c..7de3c693ddd9a2c8 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2900,8 +2900,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>   * Returns a valid pointer to struct generic_pm_domain on success or ERR=
_PTR()
>   * on failure.
>   */
> -static struct generic_pm_domain *genpd_get_from_provider(
> -                                       const struct of_phandle_args *gen=
pdspec)
> +struct generic_pm_domain *genpd_get_from_provider(const struct of_phandl=
e_args *genpdspec)

If we are going to do this, please add "of_" as prefix for the
function to have consistent names of public genpd functions.

>  {
>         struct generic_pm_domain *genpd =3D ERR_PTR(-ENOENT);
>         struct of_genpd_provider *provider;
> @@ -2923,6 +2922,7 @@ static struct generic_pm_domain *genpd_get_from_pro=
vider(
>
>         return genpd;
>  }
> +EXPORT_SYMBOL_GPL(genpd_get_from_provider);
>
>  /**
>   * of_genpd_add_child_ids() - Parse power-domains-child-ids property
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f925614aebdbc914..95fd7e63e87e2095 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -458,6 +458,7 @@ int of_genpd_add_provider_simple(struct device_node *=
np,
>  int of_genpd_add_provider_onecell(struct device_node *np,
>                                   struct genpd_onecell_data *data);
>  void of_genpd_del_provider(struct device_node *np);
> +struct generic_pm_domain *genpd_get_from_provider(const struct of_phandl=
e_args *genpdspec);
>  int of_genpd_add_device(const struct of_phandle_args *args, struct devic=
e *dev);
>  int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
>                            const struct of_phandle_args *subdomain_spec);
> @@ -492,6 +493,12 @@ static inline int of_genpd_add_provider_onecell(stru=
ct device_node *np,
>
>  static inline void of_genpd_del_provider(struct device_node *np) {}
>
> +static inline struct generic_pm_domain *genpd_get_from_provider(
> +                               const struct of_phandle_args *genpdspec)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline int of_genpd_add_device(const struct of_phandle_args *args=
,
>                                       struct device *dev)
>  {
> --
> 2.43.0
>

Kind regards
Uffe
