Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620264;
	b=erkP/ZAvVUXtKKxQkBZtSHNUt+r1kSsWXXQeLT7mfe9xYxPGX3TxI43xF0K4eFKbunCA
	 MdSGKTeetqQ0VCkVuO5+HYsM+Lel6xwLDzaCimgWC52rDVbMEm/a3x5AVwHeKbsoGUSU7
	 hup+mPncFhG1ChDv4NXZ19ZWz5RbfeXrpR7p5kTaJ0a4NOxRGB3JYtWmjt+tbIZP4lXy+
	 pwx5EK8g6gKzrAkU/5JcY4YkA9GkpqOsPy6gcd4T1GPD05UirK1ij9DKLVTDbV+6GCDOl
	 88qMa5gS3Dd9/0WAcVO26poHkRApDMhMQUPUt3qHUM8h6LotT1hipx4bA/U/VAdHgJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620264;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cAOpd8pWTb9jYj9oRh4JEDwRl6xgzzqz7YACPIDpZgU=;
	b=ve7rRC1rVofM4OyZFAAVysKj2FE72zFds99svBwm+Wdthi/rWbiwh04fM0LhTycioso0
	 6e1Mfv78IF5WLHCpogV8/AJjeYokLr7c1CWnKNbkkxbnoVEKOL38LImRGT5B/fGHHMT9u
	 odC6IUH0DMhPoB4DERMN+nxelB8U+Z9X2f36KsU4ZlUYmZwT0EV8Rjfp0egFapsh2cf8C
	 gULGPzDQbip9iiV4SGpaTLeNZ1rd0xiDMI0FDJA6pDhMXPv5imzQ8/O9ZjRdT19MnknvY
	 pvJxhVUZ55ZlgCTsdfSuayRWTJnGoh/d5G6gKrBE9XUQjq5uUYxq63uIAT0XViNqACA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jpbdRQEC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JOUmSRAJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43807606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43807606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jpbdRQEC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JOUmSRAJ
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM4Iu539739
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cAOpd8pWTb9jYj9oRh4JEDwRl6xgzzqz7YACPIDpZgU=; b=jpbdRQECJn9dd0rd
	YCzlMvxKh1E2FuxDCRdZgzLYxR58MASQ/lLJbK7mQZPHj1Gv6CsJ0tKvAJ6xMV/M
	gffkkQJSBTkiChotyI1wk1WWAybtK54prCKnQMFZH+eQ8C9VeCjTQScGYlMh0AON
	GmPvD0irgjac0Z0b+QcJN15xfbB9OBHRPmqm+yD2YYvref173bokKukzcTD7iYIr
	nKr2JqhbWduQYUrgWQQgIHZOcB9rEEmQ24/8vdV4MJ/APNNo2e6fRI6+Iz+0oc8I
	MH4oUuVBaeTRylx1QzrZUteb5v4YJcTw2b8S7RnbKVSkU322pPGVZo5XnxMUZQEc
	e0rN5g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhshkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so5828545a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:24:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620261; cv=none;
        d=google.com; s=arc-20260327;
        b=lqLXwEabY52RtKZP1/OfqBEWKGDmt8K8mvcvoijnK2CgBy8BNoww/j9LCGZp6bo/XB
         zBiqwtEooe7QLqQQfsL4vq+rqMj+I6d9m0kO/ffsPKEPtrlGVm7tYHKhLyCM3Ypd6e1O
         6xEo6ArbnBCviuCrS+c6Ul3tPcFfSP+6f7VxY9dhJIxMAOigxh1IOSeLktm6epNz7WtB
         2RjiYq6Eq09aUd/+aKTUMf1XHicEGSz0Mdfj+b3uasNGdWHJC26j2k6QG6e8Ch05Dj0u
         08QyPWlkE5jEhwzP936uTWBVnnyEzD2z+y4/NKs93s2X8Lb3xWDYie+E7gih3dFxxxOG
         g//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cAOpd8pWTb9jYj9oRh4JEDwRl6xgzzqz7YACPIDpZgU=;
        fh=WFW2ru0xf18EM7x3TZ5G1Smw3zuuKPfkAvDSNU/xOHQ=;
        b=YwnISM61nQ5yw2VAB9ElBCCs3LLIxMFcRLjcQigtqbErHD/uKnm2WTuvGTKfJvpd97
         MZvmEiiLU31dT+Pd8CVHTiPJjP9wXaKm2ED0ZArJrpDOLPBjFxKSSemGp7boQ2spCpPD
         20SsiOVddc1/5eaVIa3E5otlUQdpSVrbd4q/groAfwSfc9Sjk2dqSc5T3Hg1OMGUYR0/
         XP9uFoMvvmqUaIBBWJjm8BJwsDEWcU8Ieq2LmGLibrDbDVSj2sgfNdWhBseZUK59cN2X
         hfz+66Y2xgynWDBYVWWppVK0w7WSjLBZDSk2/qp8oU7tMZfeAn05itAABcjfdqjosRRO
         Lttg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620261; x=1796225061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cAOpd8pWTb9jYj9oRh4JEDwRl6xgzzqz7YACPIDpZgU=;
        b=JOUmSRAJMjCviWfrKPzXLdwZgpvlk6WlhGFfT2z/yHl8Ch3saIBnQJiB2SEPcrTvWw
         dR1l1L8pRR+VfSzGt/GizrZxD5DipQDmF9wkPuhlDPAcb3OZBtCcyd5PZE22o6Yvl5rh
         m48o9IR/ddRF+LFx8PQ+tnr92Sb0q6sY20K0nQzVUPz8Dr8XzuLUFP2Q+HltPpoZzekb
         CT44bBAyzjWyhKvoeNgpg6DRqFJOmbPGY3acT+c1AMZ6Tbs5GchHCQiNqn3y5AFmwTK7
         dk+gJfO4Fam2LVYsWc1R+d4o4Rgf5em9/fKI3iCotf3rYydXPz95cUZaLsl7xAsW7Ltv
         CkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620261; x=1796225061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAOpd8pWTb9jYj9oRh4JEDwRl6xgzzqz7YACPIDpZgU=;
        b=fR6JtgQufPQVcajS2GOfOvUaLK4whe95vaHwORM6meC+hUXp3eZQHsHKUTHY+xB1WR
         wcc0GaIFEok5nNSvdSqreErYlXSguPHUgPdPlXyIgD0ZiZj38Z2n3AqUFe5zVKEKzQ3J
         BOKe4L7eeiFf2xG34OytyB2kqDZjP/pSBWIHtZK7qsZQQGFRiwCb/rJmniXwHQfEvYi8
         oy0kSaNCZTqNU/eh2+7CKA8kjzhibyk/YobpLnwMH6SaWFAvTIEvfKHgf+W07QQMe6Td
         BJ25c2sxrwv3zCU9tZA9X04hiXM3nFPY4zTIf2HzUA9GYSdKQCkcrE3IDmBqDqcnBmqf
         G7MA==
X-Forwarded-Encrypted: i=1; AL+hErH2rdswxdquPBJEqP9dnxr26N5RJH2oMac72Yx8qO1hTxl7KHXOQ4zDi0b3tAjG3UpUZW62722hjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9AIl07lovtvwL8Y5BUXwCMva9iwkgjKj3kgHF0nMMZuOxDgZT
	dug4F+bC2BjOgVNEbsD6+IJYv6lbpLWxnKI4GTu22ruVRBO/vYYjzt/DksLakR5sOQVnkGMoNYn
	LjDmRz00cQ9EWPo63n2ia6UXToKYmuB47YZmj7Q+BRqF+jX96u7df8v6zqc/1dZS/hXyR6CYy38
	LZw9nriC1Ci1KmiMDPphX2+dxTZmNX5lCykNAU
X-Gm-Gg: AZFdTZc1rpCqW6zVj8DNQdyP3lODm1wi8qLdzNXFujrRRVsraw5t36WgrKk/VUBv6NQ
	7Du1Dr6ZjQ7QrzOg6yhb5kSoIn14wL/VsZczOhBTCslGSrO3qMaAH1x6Nh3MUm97eLZY+0TAngf
	iUMRCHgYLVj2y06o3BdyAu/mQ/dSmVXbb0ltmW8tic2Ij3kDqwQtqGjrhJQA==
X-Received: by 2002:a05:6a20:ef1a:b0:3fa:d354:9708 with SMTP id adf61e73a8af0-4014d35e690mr16693125637.47.1795620260996;
        Wed, 25 Nov 2026 07:24:20 -0800 (PST)
X-Received: by 2002:a05:6a20:ef1a:b0:3fa:d354:9708 with SMTP id
 adf61e73a8af0-4014d35e690mr16693057637.47.1795620260386; Wed, 25 Nov 2026
 07:24:20 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795029012.git.geert+renesas@glider.be> <37ddba45a281d2957effe5773c59022835b6144c.1795029012.git.geert+renesas@glider.be>
In-Reply-To: <37ddba45a281d2957effe5773c59022835b6144c.1795029012.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:24:09 +0100
X-Gm-Features: Aa3M54rJMX4qh8HyzUvWFdsjdwQqxq_0OhXrr7tr5X8J3Des22u394yZEZEfoS8
Message-ID: <CAPx+jO9Ao4mR5wq_GTQOegLyYfgf6xpq+zz1tTwU_U7BULeb7A@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] pmdomain: Make genpd_get_from_provider() always
 return on first match
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Paul Elder <paul.elder+renesas@ideasonboard.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06fda6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8
 a=iT_-64JVffYfEt0vB_EA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: ATe5Kr7TIurvgB4oMyVOi-c4Bs7uZQkt
X-Proofpoint-ORIG-GUID: ATe5Kr7TIurvgB4oMyVOi-c4Bs7uZQkt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX2bnt4Ch62N2q
 XyQyVmPAoc8w2G08dk5ghkzKgddeGWPPU1Z4ywa//uhbypWhwb8v666hSPl8VEguu0RRjfueAk2
 BarM7uaNScmeohMUCOdNuxk6RxDYkQY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX9EU+GU7U8xMm
 CV5kMTb4IvPoIaqjekc49MEPONkTteEQUKwDjQz1KTx+yrzSguciMA0+im7wshqecklg8jx9k5E
 Rl3YxRUryUdV1eRnW+6+rQmMCknpC9JmFECDV31zjksh/qLUD0Whi84S6ltqNntq9A0/1qmwUiR
 upnyn1FMnYk2hfAWsfRvmyqoD89wBz4XlU+rjDi2BrccST5MHPD6ktEwlDiHyQVCvSAaMYjhju2
 27LBf7eXYJFiSdbqNoQW6AOr0uoLyoJAa0hRZNRF+rZLuKHLm8vO59YHDQjgUfbNuP97XvNIiDO
 pHs42/NfVKriCUX4ApNQdOqu/xz9ORB+rNR/IhR1X5vMrNSrCA7Lxz0QtXQIrc6fDe4uLXRLlTi
 t9/NudAc3L7Mvo4rNaCISS6LSQeWfoetfF/2jJB5orc3BuQj7RPDjYteDsIbLapyE1lHc09EkoQ
 6bzCOKd1QZC7NX5AO5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Wed, Nov 18, 2026 at 8:46=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The for-loop in genpd_get_from_provider() seems to imply that one can
> have multiple providers for the same node: in case a provider's callback
> fails to map a specifier to a PM domain, the loop continues looking for
> another matching provider.
>
> While technically one can register multiple providers for the same
> device node, one can never safely remove one of them:
> of_genpd_del_provider() just considers the device node, and removes the
> first matching provider.
>
> Use the same logic in genpd_get_from_provider() to avoid confusion.
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://lore.kernel.org/20261019160545.GC3705@killaraus.ideasonboar=
d.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v5:
>   - New.
> ---
>  drivers/pmdomain/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 964e44c2f78f1d55..ee8075e90852e738 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3031,10 +3031,10 @@ static struct generic_pm_domain *genpd_get_from_p=
rovider(
>
>         /* Check if we have such a provider in our array */
>         list_for_each_entry(provider, &of_genpd_providers, link) {
> -               if (provider->node =3D=3D genpdspec->np)
> +               if (provider->node =3D=3D genpdspec->np) {
>                         genpd =3D provider->xlate(genpdspec, provider->da=
ta);
> -               if (!IS_ERR(genpd))
>                         break;
> +               }
>         }
>
>         mutex_unlock(&of_genpd_mutex);
> --
> 2.43.0
>
