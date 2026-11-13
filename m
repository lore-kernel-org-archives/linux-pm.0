Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794575677;
	b=qJmo/0uEXzSJCEsaOcseDxBzL9DfGjdLFWwc68SxktW2M6/UgLpMmpBz2SuZNQ3nmy0A
	 tlrqHBx5sgwPK9q1uBaKvxAwpgcBBbQMWxMlj3evZwGn1b57OADe/NhzVfUHSJbhbkW1J
	 aLN3DwzkCuk+fc/UM+xe20nRNYN1Y1P9BPyw/Facu4YV5K8GF4znWNl6z+Op+oJMm8X3S
	 7S9B8b+5Y3tjj46YgKhwe5uZVY95ShRV5yT5aMoqumh34SjBP6nTGUQj6OGiV1PuIODUj
	 r5kASniyjRNIzTTPtsKL7qYj3S105PMyTmgt3X9U//0mQ/3LZpIrxpPD9HwFv2A0KOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jyq0CHFpuFmFNoRbVotKqEcNN2VMoPGS7s9L+aqOXM4=;
	b=UamiFJ5U6VJNNVQ3An2s+/y6Y2VIs1tOkBV9C3MuOuXrGzxieofvcqnMAodo5p4LQYJk
	 3YGdml36SHUQcQsAzOeh+gHamURukaSbOgT+TmD59a72qHhkAo77eCAnIBr1Z9w1hbibo
	 N8XHTj1SHXwpGB4BvafJXspj94S2LFuptzfyijGmXrOuNzy1wQHaGmzAnbCFG8IOO3pzC
	 e4FSecM1Ff/hnw4AYJIxfaaZKphEJ3rfrO4shycC3M4m1fKr2bzq0BetAM9j2m/vQK2XO
	 e+mzw28WekgMAYZzMhhjbW/RkZZtT9AntNYAGLLBLjOqRhDbMDUMGWm5UeOOvrjbKrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hXUGRL4y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OUfdZhpZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF2606A32E
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDBF2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hXUGRL4y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OUfdZhpZ
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCKkAB584110
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jyq0CHFpuFmFNoRbVotKqEcNN2VMoPGS7s9L+aqOXM4=; b=hXUGRL4yHi00dJim
	M25dk6Dz2Sx28JEYAIfIC89lLjEMl09eKnBGb3dStt55GUkm6DY/ppMLhXV61X7g
	IbPQoDpwCNdD0Xwq+UPXPFLgt+NQXSg4zeLjPPyhon93RLbLSwGsTDQ5oDUwwwBf
	acYRDQ1x3Ss6ukHMzrWf3csw9HeFECM3u4e8BxcdynnTmCVnpmqbUg5PLK8l1fud
	fkNdr10V/zYZnLIEPQysW+ApCS9J+Ua4/NjMJe73UuGJa4rK4pEXt8ZFX0jShDYk
	J0YrM9zaEEuORdgU9FKOQ8NbfzZHkM4nZx4NQuqs6j2DkhuD++kXM3BwyAzCYX0f
	d+Klxw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0akv39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:14:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so1416152a91.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 05:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794575674; cv=none;
        d=google.com; s=arc-20260327;
        b=YOgMKqw/4CuYEaKVi5DK/BkFgnGq1DxAeqq19hTDIYfmCI0fmKeCWV/ktUmEElIWV3
         57v76WhmwLq54TR0HHNHRCa8oBGJpLtvbICS/nQX1OdBXHr5S1cTq/ns7M37X02f1yRM
         Vm5W2RipS4nUyd9l/Pm9dazAZ/q5YCbw2DXZL8QcHzglS4YAAYkg1Zu/g6xHcTiBxPPJ
         0Q+iYyIISxM24bLw9TscJ/1boyWnQzjshm8q5z7UduFbDOi0cccaJ5xtM7Ix7+T/q0it
         jDJ6/UlIoGKB2lVDs4ARHO7O649bFuM7OFIjkGF+gAkXDIddSoCP206duImHOWGawxuu
         6X0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jyq0CHFpuFmFNoRbVotKqEcNN2VMoPGS7s9L+aqOXM4=;
        fh=xx7QnGALqnZTvDeF9UPql1Xo45qRBOU5PkerNvrEVS4=;
        b=FohBJ/h68vy6FD+8X9ils/Jy9Oc1ao/M5xUAj5kpTDaBTUd0oD+lQHA0yhEce/kq6m
         UV7Qw6XW+/dx2APrDdngSzFjPoJrmanGD64htrNShv/kfnijd/7B9wbbAlMEdrfdF9k3
         xjwW1eUcdsQsdopcpP2TVHPf6C4mshZVz61l1I8efBdrLt6TBR5jP/ibTTgjyfkQ9L4N
         WgEXG/qIcYNDBbbvq12pAAqgDhmKT2NXpOrYehsSdDk+0Hrp+WIY2WtPcQ6gfGuf/zNt
         EO/3IKOUWfOxfO//RpWOI7nFIHBVOHXZY/c5rM1azVaOlHkcVxUlGPgBbkRselRTFeaX
         G4Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794575674; x=1795180474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jyq0CHFpuFmFNoRbVotKqEcNN2VMoPGS7s9L+aqOXM4=;
        b=OUfdZhpZwliFBfR5ez5O5FvpneaurAsXoS0SkZMWHteOMDJ50kdEpX//EJ/hVgPdgY
         9bIbIC6UMCzPjrA7nKDC0kQ2//OKDomwYfVGOdtdaHzP/Pum3u5F8lbx2o8ZfHMN9v4a
         /LG0fizSbxJRCZHLv8a0ZtnCpryVT3gQqge1Ozu0qWhplcg26OvjKjzSSgpkNraOXBgc
         WWXNCJB1QL3M5g/Wra+5XS6Gjf37XIaLxSTpETll+yVay5PoQ+HlZQqFSnR+EDAGIOQE
         VVMI82mgZSkda/XYYcgBanvOJsPL3ZgGFVtvi+ia5rc/i1kXjLLa79c2RinQKE6Y7n5f
         cenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575674; x=1795180474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jyq0CHFpuFmFNoRbVotKqEcNN2VMoPGS7s9L+aqOXM4=;
        b=yaCCBhVvunC5q+GZAMfWF/jR+FpBm5BzPJIpjkaf1VGnyB6NOFgiWZQwY1GNWdEHhm
         J0Bk0e+nhb3d17/8tKfWI2pkbPlPBxFZUu0fLFzVH3eMHBXsKJhg540yKl9b0yvvUjEB
         n3lYBZp7s9SkLOw5A/EqF8enRYxr838Nh7OgnlUFaVikP+QUZgsZED+Sau4g1MYfRFvV
         JPxulZkk4CaIAKPNoo2M5pdt8+ja0zCcd4PiLo63aoOl7wOYpGWdZNdrw0DSEW2/tSgt
         FHfcubWLDcBasR9jbMYG8jv1RW+afkAP31AvThFnofMqXUxwQpzaKJQ9Hm5PbaXRzXYR
         VdQw==
X-Forwarded-Encrypted: i=1; AL+hErFLMbP3CDJddZj22rQXzvXTAU83+ZaQyc1Y0sCodL+PbDu0LA/wvwgduDlblKqtNWwy/2XTCEASyw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+RVpCBVXGXbu/MckCODuSDjZlwoT+5xrY7KJKdpqb+zQQlXy8R
	s8K6qe5GG+vnWOLv3n3Lfq3YfVrAh3FYkp6PO53jntMHH74ShKF9OrE9T/79IAyKYqMJwnnHGSw
	Hm0CvUoGmeRtYXy9AEJXsF+3HED1PErZsov69Pmxdi3GzdThXEQ1V3FVBEaYyCOTNPT5H2o0aQK
	nhNyh0DiR0XexsuX15VrTbWJGGnxu7UzEMqblA
X-Gm-Gg: AYBFou09zuWXrjy5Tk1kpgdj5dod/Hsc1pYzlhBnRjOOyWlD2xXX2ZCXhHJDhYlaxCu
	c7kaGrkEsoGhtWzl8eP1ckm0YJn5BP83qU1HFTlNB8gXW3DJ2dVdfp9IqJ5Lfzm7IAhRFuxqp17
	T5Q2fAFv7+Ehp27I7qd7lkJnF4WGe5GR1gMLXJ3/Rr303y4zHTFPhvzyx7KQ==
X-Received: by 2002:a17:90b:4c8e:b0:3b0:d808:a991 with SMTP id 98e67ed59e1d1-3b1b0d3420fmr2545480a91.55.1794575673653;
        Fri, 13 Nov 2026 05:14:33 -0800 (PST)
X-Received: by 2002:a17:90b:4c8e:b0:3b0:d808:a991 with SMTP id
 98e67ed59e1d1-3b1b0d3420fmr2545420a91.55.1794575673121; Fri, 13 Nov 2026
 05:14:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com> <20261022-psci-fix-v3-2-9ce2133c5659@gmail.com>
In-Reply-To: <20261022-psci-fix-v3-2-9ce2133c5659@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:14:21 +0100
X-Gm-Features: AclHuK_DTsDuBkxo1YAzBq_C8oLcltIpHJD3FMGKMO-2WiG84I3huHHxGsWxuKE
Message-ID: <CAPx+jO-qPAuOGnGfCyGnSYym8PBOaqUJptZh8duYJKZN4HARaw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] cpuidle: psci: Allow skipping the suspend mode switch
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX22cRbD9C/U35
 d6jFe2f5lMPJK81aDUSHs/ZrFpf4sHuG3umdTcRK3jpnQx8LW750mrWDWeSWdUnCG+wmLGKLNXu
 UKb6o1aubIjSX1itWAKEKdpm+DHpHr0=
X-Proofpoint-GUID: hsi92-4pksbfMaofE12rfKQTo3mQT5K4
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af70d3a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=UY4Qpe7uAAAA:8
 a=Bs3vFoulODVTn7UWAnkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=Dz9CbhmWzz49oM4s8yQO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX1UNfVhk3ua02
 aWx2Kkx3HIsF6CYDtRjcE8pp012zxjbvG8L2Hhse1/rSunas4i+jOVPDASYhqVhBzsS8ZCfSQPm
 jTzZlN1Afqt8fk5RMzSLWgIgNMxBta8m8XxHQhSpODg52V/Y4c1lV2EEYS/CvIABlQjODi3hvp7
 oIRyMgzRIcEvOoqMnzxRKYdlU71ZChijD/pHp9Ezd1wwLReFEwXqd7D9eGAq6sWD/ruChig8Ngf
 wkVXDutYs3Nore6yPDf4eAGXsrmz6oSfB+EwMfDP4GGck24EEbMtQBUwp+66Xa5PUyIrqbQ2/PN
 y0VIo5yHXielyn1KJAZMPC3PLhXnd+E3N5glDeCh59F1FQTg8JaepfhnwCNXgw5uzGHcudJWbKM
 0bv14k/aXq+jzlXkU7oLrtMU4c8yWyvCJ+X6WLayPydMiW+OJn3rIHSmgNmsLXFKXsxyX0JCmOT
 W/A2RzD3hAqXd6rKthw==
X-Proofpoint-ORIG-GUID: hsi92-4pksbfMaofE12rfKQTo3mQT5K4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130052

On Thu, Oct 22, 2026 at 11:41=E2=80=AFAM Reza Kurniawan <imkyufie@gmail.com=
> wrote:
>
> From: Alejandro Tafalla <atafalla@dnyon.com>
>
> On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI reports that OSI
> mode is supported but rejects any PSCI_SET_SUSPEND_MODE call with
> NOT_SUPPORTED. psci_set_osi_mode() then fails with -EOPNOTSUPP and the
> probe is aborted:
>
>   psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
>   with error -95
>
> Add support for the "skip-suspend-mode-switch" property. When present,
> do not call psci_set_osi_mode() and continue with the topology that was
> already built.
>
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> [Reza Kurniawan: split out the patch, added log message for skip case, re=
named
>  the property, added property check at PSCI initialization]
> Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 16 ++++++++++------
>  drivers/firmware/psci/psci.c          |  6 ++++--
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpui=
dle-psci-domain.c
> index 5722365b94..cc9f14769b 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -159,13 +159,17 @@ static int psci_cpuidle_domain_probe(struct platfor=
m_device *pdev)
>         if (ret)
>                 goto remove_pd;
>
> -       /* let's try to enable OSI. */
> -       ret =3D psci_set_osi_mode(use_osi);
> -       if (ret)
> -               goto remove_pd;
> +       if (of_property_read_bool(np, "skip-suspend-mode-switch")) {

Rather than reading this property here and in the psci fw driver, I
suggest we just do this in the fw driver.

In other words, let's make psci_set_osi_mode() to succeed when
"skip-suspend-mode-switch" is set.

> +               pr_info("Initialized CPU PM domain topology, keeping firm=
ware-set mode\n");
> +       } else {
> +               ret =3D psci_set_osi_mode(use_osi);
> +               if (ret)
> +                       goto remove_pd;
> +
> +               pr_info("Initialized CPU PM domain topology using %s mode=
\n",
> +                       use_osi ? "OSI" : "PC");
> +       }
>
> -       pr_info("Initialized CPU PM domain topology using %s mode\n",
> -               use_osi ? "OSI" : "PC");
>         return 0;
>
>  remove_pd:
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e73bae6cb2..3226af6d89 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -791,8 +791,10 @@ static int __init psci_1_0_init(const struct device_=
node *np)
>         if (psci_has_osi_support()) {
>                 pr_info("OSI mode supported.\n");
>
> -               /* Default to PC mode. */
> -               psci_set_osi_mode(false);
> +               if (!of_property_read_bool(np, "skip-suspend-mode-switch"=
)) {
> +                       /* Default to PC mode. */
> +                       psci_set_osi_mode(false);
> +               }
>         }
>
>         return 0;
>
> --
> 2.56.0
>

Kind regards
Uffe
