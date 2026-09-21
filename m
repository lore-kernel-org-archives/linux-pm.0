Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649F4A0929
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001231; cv=pass; b=JfUZh7D69bIp/wR45rpCv+UedqMSEw3ZU2Y53CwxlFD5oTuLenwTKEW/OANhANT1OvcgZLZHB/loL3iGMlckXM/SmOuLqFmOVMI+EmtyLHAEojjFINJ8LPpLaYDOi2++fAENCMCkXo8/2M+lfHX7pXKMF6GtLpTpwxAtuxVjhZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001231; c=relaxed/simple;
	bh=E7JHempOoUCSYf/9xUmI8va2uJakicZppH2wJWczR3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+qzbt/wJ+HFq9PKw0RB4QiT0C7BKaK/DISCnn2ZG3xlJBF6a66mHP3yPTLDqW4kCY3jR9k1Qx8a7uJDtXR3WlQ+gZPuf3eIH3EpD56t8mJjV1cx2azoqzPczjAo2oGUrQspyHNYKrTDG7hK4mJ/dLZ8oYGrb0p8A/Dxz9kikSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XCHPwwRs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VqiU9WIJ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCHPwwRs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VqiU9WIJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGUiv2404201
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UajCiuu3zKkr8y3fzShjkyeSWKdl9qrmasKBAqFtM/4=; b=XCHPwwRsHvCetjwt
	Mz4BCA0rIHDYQZwOB9/UlCEk4Sb3l5L/PQ5E9rEJWg828oBEKPxaW0C2qb1Z9wNG
	N4lsju8ExbQ7Ju+JUOR/6tI4kWF49ppbJ01slQyTFQyXeoaEkBM+1UCOcqsCO2jo
	PwgWtvlfOv/ABZo4NCl6UTZYTjFBqlniSeBh1vXcuUP7no/1YBDbtyWUAfRuNI2H
	LgpDcfLWPjMonxxsPt2bGQTigWQ/5eEcyr+zsXBV//DluWjLz9sg7I2Ciy4fdUDY
	hVN6K2Feg4XRBRPc8gAWg5U5n7q4sMtFEguWLZb3GV4ZaQ43Z9iipT/ir8Gax4kZ
	iZmnDg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3vav1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088202so2745898a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001229; cv=none;
        d=google.com; s=arc-20260327;
        b=C4KERTJ9Jsq3daDon2R5ALM46UlhMERLiz6Jb/IrD5oZ49j5eUK1l0g9BLq+jtp85a
         wzKW5MCcu66GaCd9gXMBgUU5pJslJkok0rEMTho6x+zk6WcFhO3HutQjEkdnofuiZ2vb
         znheLpUWy6bS9LHzmjfkKW2qtdP6JSsWPIle6+t9YTLrnmvAxSKlcxs9BcQC5N1hIqq2
         hfXS2InockWGHVMmKnXyVNA1+YHNtskQNaBMSrHPelU/Ttaj0VxrcGwYOXY6O/GXC/ow
         +K8qcu0qrTnAcMdLkRj5yiJuyMXktu17SVDfSRBWmbrQEj+8fpuRfbTakcb+KpSTBtz2
         KBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UajCiuu3zKkr8y3fzShjkyeSWKdl9qrmasKBAqFtM/4=;
        fh=GhQeeQc3LXqJhyFDWExIp2dF4nnUvGdRhzP04OHLceM=;
        b=iFx967eKp8WjE+uI4qSdKOBw3/GfzH4Bxnl9AIzL+k/+PuQ5B4fQwiigBshGcGTBkI
         ckGZBFHgQ9bjsUyk1gvfpMn/TT3Yoiy2H6vzLZr2YjiK+HY3nUglhNPjMBp8vCIwc2Qz
         AyTdZa8dXmSU/pVZVkSRgtjXnf8Fa5Ky6y9WGW+/R/OMtSFS5o6+e6joh2YOyBVWWWoL
         qeHY/+K2eVcnKFqVA6GP+SShbiHDqv5cLsIPlb4h/VSta/FB2mx4J41c38JH0VGeOgkr
         P8zg8XISMO/7FuXYh1L5W3K1RUDm69rsCfFb43FctlXDgeDVbXF/WCUPKKqbBdUQlJaI
         uqfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790001228; x=1790606028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UajCiuu3zKkr8y3fzShjkyeSWKdl9qrmasKBAqFtM/4=;
        b=VqiU9WIJixytRF0z3aJOqL8K3yir3mK6O5sMrdskJEksvzP2HQCXKCez2/I4NiLbXS
         ocEzGcM9CDRqO+YjIAH7chRB/6qDa2c4ni/qFa8Ck0ABD4WIowqPoT7S9Mob6WsZa9TM
         1qATafSDeOFMoK/NXOlMfrtyYUj85871KVVM8/6QkwEyB9Pi/MnWXXbLZv1TfK1mwyN3
         4rfmsxtb7KrzFDHQclmbThwZzJdcScSvQDaRhF5y5/YWcfFGVA6gqi1iULtOWXG60A7e
         gLcwkb66tiVwDTB5A6vsSpN9Xtoa4HGYMZjl2s7zFlX2DRxwaEDGrahDDQ0dI5GhHWeZ
         HEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001229; x=1790606029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UajCiuu3zKkr8y3fzShjkyeSWKdl9qrmasKBAqFtM/4=;
        b=LV8dROcP7fzuC03+GjYSaO7lVW7tIBz7vfId5xvBimjxxJP5aoWynGILbmYyNljtg2
         tkhOlX5g/gOo9m0P7r3GIkHr2YA3cKEloeITO3UW6/9GWVvBxQGmY2hZl6zOPN3Hxctw
         kZtw/1/Mz3UuBtEgMjSny5V00i64Tb4GUvSoAMBNsIdQ8HVSmlBqg7VShK4adfkVysLV
         WX1WXZKtefiGHlMiPDvLDZDdxvEWq+KYasR5MqqmXs2su/hZqH0hvlO14CUu++G5+jO/
         mL8McZoc7bpzJWpDOut1btHT0xKKgSXuBpZWgcbXi8JpOguMZsDppg9ejPADboSmpJ/6
         71HQ==
X-Forwarded-Encrypted: i=1; AKwUvBxK/Pn65bg37SXFEnacIXQwfgU4WxzihgyU8FqlzfXByU/C1u2FmcfofKGP1lB3EhPKz2OvoA0EPQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kacqY4bnPA6GE+bhazcNMjSe6EhulZxvk6FK+Z03io5/YeHgOa
	UK3Zh1AtnZzeZW3JT2e4Ptqy4LOxhARWkJdN9EAv8+lIecS+ZoHrXqeEUUF8O1WFV9CFlSXCLTc
	wJ4ytRHIMAQHQkveJTazdBS/uy4G5N+Sbs6kenvCn47EuXVWlm1tu24W/vPGwJbFFC24jRUE2oR
	95EO+VyvrtjIARE5ArS01exa79iADu+VfZYw2M
X-Gm-Gg: AYBFou0WHwBM/J0L/E6Jmvw3Bdbbo/XYbLtkgBNzs6HmBCajlC8HXv/AG5mnv5SiziA
	AvVK8scmLRctTkfeMMiVHySbP3U3hFqq0YlnT0olBLcb5i/EsWVh++wsbnoXiUZT8FlNr8S59yE
	WeV9BO9by4NOV/n4GHI3Gkrf0j08F2hll3Z6efY+WUmP6vLibSjyA56v3NHA==
X-Received: by 2002:a05:6a20:d70f:b0:3dd:85a8:cacc with SMTP id adf61e73a8af0-3dd8c47d05fmr18471295637.35.1790001228374;
        Mon, 21 Sep 2026 07:33:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:d70f:b0:3dd:85a8:cacc with SMTP id
 adf61e73a8af0-3dd8c47d05fmr18470839637.35.1790001223087; Mon, 21 Sep 2026
 07:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
In-Reply-To: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:33:31 +0200
X-Gm-Features: AcwNN1W_UJfHVjVR0oSQdsskNOV92N_jUt6A6zCRPYhZu23fhBxykd6yXGRbgA8
Message-ID: <CAPx+jO9qYJfR+mAN1=5rWMWWrp9STZS4HB3ArGfKadhS0D4V1w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fall back to node name for idle states
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab1404d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=c7lPhTKDuvdyFyChvsEA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: v1FF8LeTI2a5MtPqsOOP-j8lP1zmMoAV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfXwM1eZt1XocG8
 UIzxxyJQ+79X/+jQkRBnZXiLtW3Jly+FyUaSHalen/pIdwv5gIi03TTZTh84oOYC8ooc1h+4TbE
 LjNw7l9iSeugyiADZ2ntmOSu68tsBlI=
X-Proofpoint-GUID: v1FF8LeTI2a5MtPqsOOP-j8lP1zmMoAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfXzROpqrMYiHjz
 zkmVAr1SXLM26hHnQylm2IgF9qUf1ODphqlL7hvNEOVjITwotp+joiqJmrV+7kkCmICRHeE/gbW
 XjTYqsuBcCgY8jHJnCmVCIxvfkPXxn2ufRAX1n7TN3vZjROyuszsEpVRqdPa5knQv9vCON+1mDJ
 QVLMdFVF3ggSXEvQpqp5Y7k8bj2XJr3IlvBXg3hlGXxeqrfbPqeqvsgrXKcuNotX3MGRpdPxf1D
 m2DBIBZlGdfq/UjlrXsAv5OF/cvTwJ3aabWoHONg+pHWW/S4/xOrxnqsOEXk5fgy25bLfVlw3vG
 IX1H1XMeVixQ+tgxPFh3jFnf0gXqcwIV4hqN1r4ROeaBiZcO3nSbH1Obou8nODhawWC0FXWB/3n
 Zb6LtA0ZXoYXxMf+2Cw2RW/AjA5aKVTAyJUwLlQSpcB5gFOI8YZh6Tu27oViwhe2kwAMI/mA9lv
 v/lo/cDekkGoSVmZIFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211

On Mon, Sep 14, 2026 at 8:54=E2=80=AFAM Maulik Shah
<maulik.shah@oss.qualcomm.com> wrote:
>
> The dt_idle_states uses idle-state-name when available and when missing
> falls back to the node name. Do the same for domain-idle-states.
>
> This lets pmdomain idle_states_desc debugfs show a name even when
> idle-state-name is omitted.
>
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  drivers/pmdomain/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 052ec478dfcc..d0bcb4897477 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3583,7 +3583,10 @@ static int genpd_parse_state(struct genpd_power_st=
ate *genpd_state,
>         if (!err)
>                 genpd_state->residency_ns =3D 1000LL * residency;
>
> -       of_property_read_string(state_node, "idle-state-name", &genpd_sta=
te->name);
> +       err =3D of_property_read_string(state_node, "idle-state-name",
> +                                     &genpd_state->name);
> +       if (err)
> +               genpd_state->name =3D state_node->name;
>
>         genpd_state->power_on_latency_ns =3D 1000LL * exit_latency;
>         genpd_state->power_off_latency_ns =3D 1000LL * entry_latency;
> @@ -4006,7 +4009,7 @@ static int idle_states_desc_show(struct seq_file *s=
, void *data)
>                 snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
>                 seq_printf(s, "%-6s %-12llu %-14llu %s\n",
>                            state_name, latency, residency,
> -                          state->name ?: "N/A");
> +                          state->name);

As pointed out by Sashiko, state->name may still be NULL in some
cases, so I decided to keep this as is.

>         }
>
>         genpd_unlock(genpd);
>
> ---
> base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
> change-id: 20260914-pmdomain-idle-state-name-fallback-3bb5db520a30
>
> Best regards,
> --
> Maulik Shah <maulik.shah@oss.qualcomm.com>
>

With the minor amendment above, applied for next, thanks!

Kind regards
Uffe
