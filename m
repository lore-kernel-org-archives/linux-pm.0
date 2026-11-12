Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490144;
	b=CgQd7buKjQnig8+di4clayz0RsiMiI3QT/pYi7YYsWuwH7Jl1F3Xgh+/ugiCpiWFfjPs
	 E4cuIsIF0G1ykOXNStXyRBQPgfc+hSatijUQjsjO618rLNJtK1A6yAuFuQIs6dW9iosCp
	 wzAQFpECNUmXcdqX74rbctxHtx+Atj18B/Orr6zz+w0Rb0ndJMiUxUGE4yNY7VA7kBxmE
	 l5DAx+kPe9s8cVKkWvBsorMeBLM+EaL/B6uE/vCWCEdkTX2pRYIBdgprT6FK5UzIZnLAh
	 Hp3dYVH1n/+oKNnb116fCxQgMTqU2snRy8JezAA4y+BzX2vmVueauQKXGTH4TzsuRLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490144;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G3Q7qE6C41WE2EwR7PBZ31iNaUmwvqxyBhTAIBDkPGg=;
	b=LgH1d86qGdclzVz7Qm8PLZtxpPJ5lSDnBYO85i82g3LP0mGHHqWSVSR9AFlxUVhoqzqh
	 OZhtYqt98QMh4MFcK+GQYRDKCaANCjqFdWdHoMNebYgM0qM9+NY9GuBTLTasOWJEwEY/t
	 dc6CHhh7CR4CVEb/PyinJkzkTU/7N8TuqV6olc0yJ6da4XV+AzXfdz+qjX4ptVmi3TqWf
	 57UkGDULURtE/rXxt+pqoqRZRw7CvhT+ekzGUFvjrUAJ7Fkyjsapg2+gvytytxLvCmrRP
	 EatAZwzw5XqO+8rFnrSaVL3MPqUKD4o9YhEvKYPWeS82I1P8vy3mCH2Ch+IHYCFOtEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aHKb5eDi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C0bQsvZc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2A606A336
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21B2A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aHKb5eDi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C0bQsvZc
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBe25O441573
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G3Q7qE6C41WE2EwR7PBZ31iNaUmwvqxyBhTAIBDkPGg=; b=aHKb5eDiJpJBZRFN
	dRbClG27Ae9U79uxSNr929uJvTBsePeZmwMFP3+eDEXVhbw4wfjnyg1JPybA8N3G
	+qmEq+oY953GmpmWM8i/ru2g6aexJeAFwthKXyWr1FNvfS8mD2cM+QSA4YByU9yC
	fAgJHz3YO/43bTF7pM74x9pKJSJGocSqZ+6Grq6M+tO45wV9GAaP6kALoHFrKjGc
	RQRkQAv5mtOJYmxjtaiTu68Jg+5S7rfBPCbK2iPM9I/QzFFkLMqTldmoAfr577yP
	gWO3W/JiqEAGig25TIPQaU9lp6XMR0r0BRmJAd5bh2vlj52oUhR/X/JY1Vw9Dj+5
	0pxj2Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc1md7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:29:03 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ecd4f564d3so1084662e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:29:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490142; cv=none;
        d=google.com; s=arc-20260327;
        b=b7qvxpqbD8b/lm8FaRUKAmL6AuX/AQavcUQCzQ3gcaxFJbYmDARPknMD2m9cMy9Woc
         9R2yvMVh6AzDvOSEJGwOT2Wfm5efCCAHNUSx4Mqqq29ItK6Gv4euVvF2zB6Or0NswneS
         QtUBe/lDzGLb/88k38ebqE/x5u4LLpwaMaFrHeM6KkRJTuLqJNg9eP0GFjRO/VerqWbA
         qcn1Ii33TQshA4M07iJ2mBMHPlS7F2sNNr8897CULOqZuAYWOx27yvmSN+21XWBxTctt
         EQfMgoSU+5Rcfa9JzZVKF5IBq7yDaiBdp4HYRtW3edBBy4S0zoVP/1LaTccl+ehbZY5l
         wvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G3Q7qE6C41WE2EwR7PBZ31iNaUmwvqxyBhTAIBDkPGg=;
        fh=5yXAwo5ESOTm13f5lcVDkWDlGZPLRJpXcHjq2BqhFIo=;
        b=abdPoykAtD/KC+gzsfRp81MjINh4jWUnbofNxketw2Ys/RupzRAvCKYqny9HCx7SF/
         xwQ/QMg64tQWnF0MneO8ozSMqPL8v48EA3Yql68opvtZbaXCzY4gDGrTNN6CsypeECxo
         ffmu9t2gRX5H9H3UGdL5k+YeisTu0Cd+XFqU4fz4L2+gPY3DNGyGNbEtEmjD7KB0nBqJ
         JBWk6cC+OcRolLZysBlNflWmvA1SkA0mLQYSNjOVMqDwc74Cd5PSwL0XR3OAcrDz6mpm
         b//GwlQM7ngz+qrx4nmbLMqO3nyT+V/sULjjeMYQs+2XeX4iCQbFgIxBZeTxKWJYRrbq
         wVnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490142; x=1795094942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G3Q7qE6C41WE2EwR7PBZ31iNaUmwvqxyBhTAIBDkPGg=;
        b=C0bQsvZcLSG3G+FUDQMbBHnANZDfLe6x7EFQosPHhfJoEwGw+dCy0doUj76ujJCuN7
         qFP2YT0rIqESS7uHX4EIvDrKpM38V5KYPalkz3KRxuQ5rpmREUoLO/KxNFyQl4qs5nFp
         FT5XTwxct1D/AyoyVX0Z9Oi8liXbFA7wMQ4CikjphnsJPKgMpwuZ3Zg0Ro+Dw3SiCT0Q
         YHhBZv5mJhu+jmNd/ygNKwNoYmnMm0HiySlbWd4OCeTnzPANdeHhEe9pDqBLfOWAvzCo
         v4R4fyAJAC6ZF2CmL1twKgXoZFgabVtsVRLt3GLd4LFFd2H+78oK8ZXW5jXr1Cst4brA
         ViPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490142; x=1795094942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3Q7qE6C41WE2EwR7PBZ31iNaUmwvqxyBhTAIBDkPGg=;
        b=M6SQDsJ9NCcg2W1/RW20jg8w77VadMPNCwlUs0OuPCJXiD+b5rWfNPU90ZPc3k7dn3
         WmIA4Wmccb+rvx2xxcnKyBJTkNwx65U0/TGNlkyEMehg3R2I6ww4XVL+KB6H2EQW2M7h
         nsKMNVSK+LX/jHVlQX+rz5djMERtPZ2v25yQsnn4qyRWWSKcaljfx2vdJKzY24hM1zpY
         oCi+RcMsVSl3F3MIIdMYbLu+WwQF09Sv06PyL+V5aCVNBggWMLdsNapKhyg03CnVBMg2
         QS9tymt/sakbrDl3id1LZAIN2FyP/PCgvqSbB2zS0+u2u+DH6+TKK0bpOpgPpL0QUxHT
         6V1A==
X-Forwarded-Encrypted: i=1; AL+hErEaPDA3jJfvE6m/v4+AxGuDfoe9lk5wCPhbeERjdOfrNV8t2tIM7DZQEm4AFpiy7uekIboxyVpPmQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Plo33scpBp795sNqL6Mta0OF2LxvMGuJgBR2Bf3/OJ3y4+VH3
	/N6nJWqM1Rt19eFqoWAUveNHukDzMcG1TlvSzZzpjP9YbJYke3sxDzjWjTrC1e2PkBqAlkMmu32
	uPmKMw8nzq/d07hd62h1f+OjXqX9OWjGlvP3OUbmN3gyNlr306KnYtTHKTkgc1qiW0Yt1JChhXk
	8RfEuiHZ7ioLODGEWtzwSsq8vEc+N7YDFUmAbm
X-Gm-Gg: AYBFou332fiw6wrS4rjVAhd9ub7e7xOuWd6KKwIKwU6LFcRa4CGQyBTHx+QOi0ulrB5
	4CUintAuid/YTi403KXcy/dz8S7sZZ7APTz+TwhQ0C3VJlQtXBaR5l1FOjL6nA0ORg3CiiXDpSw
	hLM6CGzXgKaPxyB4gwsXAss9uj4TSP0PUxkE3cHiI83a8XxMjK+JWU5flxKQ==
X-Received: by 2002:a05:6122:e153:b0:5ea:d649:d1bc with SMTP id 71dfb90a1353d-5ee1c4862bemr2162813e0c.18.1794490142316;
        Thu, 12 Nov 2026 05:29:02 -0800 (PST)
X-Received: by 2002:a05:6122:e153:b0:5ea:d649:d1bc with SMTP id
 71dfb90a1353d-5ee1c4862bemr2162804e0c.18.1794490141804; Thu, 12 Nov 2026
 05:29:01 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
 <20261013-genpd-boot-performance-floor-v1-2-a765dc83e6d7@oss.qualcomm.com>
In-Reply-To: <20261013-genpd-boot-performance-floor-v1-2-a765dc83e6d7@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:28:49 +0100
X-Gm-Features: AclHuK_Jzud3kBQ84L6hP3FUx4DNmy2hVYEuv1wt_UfgwdBavzJj52wOLQfTyB0
Message-ID: <CAPx+jO8krEjuMvgCP5Hy1V=oV+13dRj0WQkGCjUpN1cQn5XwNw@mail.gmail.com>
Subject: Re: [PATCH 2/4] pmdomain: core: Prepare boot performance floors
 before system suspend
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Eoaoylm-0qQO8d9gGcPHYrSEOPEnro1C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX9t1Z8Oas9myV
 og3vDn6hGePoFtJOwMlZO38TK5fmpt5Hu+P2PB/qkzdMt6u970onREowFzD6FA/aNomYVrcPGRi
 L6E4T7X1P3cmYYYK4nMmMuybH94UX7c=
X-Proofpoint-GUID: Eoaoylm-0qQO8d9gGcPHYrSEOPEnro1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX8M5P6svkAJWG
 721U6+8eqebdd0ym+E4a78kIJopUOxXHYbv2rXnmsblEu8isRqlStz0H9Fso1aFak09lrDi37S6
 kpjSCEzPqca8mPua3hBz8h6kzpn3xotpugnS7InC3Jo1DoNF2tEaWKT3H5ENIpnaQEELn6guYVD
 zTQhjhQTQVBOZ0hpUL/020Cg2TnO1ahHIgreA1TYH7UzcMKDze9o6TLGIL9MgKtzb69ohQ2tYRp
 yXi0JUTCnB/6EWX6vLI91Dwkxpbc1II6S+eUiL34R4clfp6YV8k9GtkEEKmk8oEuWAwi0lEyNDb
 k7Tv5ml0D/+Ci2HNCB/M36Q4LBZ9kI0ShbT8xp+qaSq8B7R0qBRfJ1HZQf7pIFMz6jih4h08BRq
 JBSJYwJBVHQ4zPOFrzmnnpBdPBdCgOkb/ShoYqqBUwZ8uL3xGp2k83hD5iVwYnoqafngl+FhFGh
 f5SdCP6RCFa8voQINLQ==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af5bf1f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=CEUtmdPz_awSc1UMDkkA:9
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120053

On Tue, Oct 13, 2026 at 2:49=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> A system suspend can occur before a provider has received sync_state().
> If a domain has not been used through runtime PM, its boot performance
> floor may not have been applied when genpd_sync_power_on() enables it
> during resume-noirq.

Would you mind elaborating a bit more why this is a problem for the
platforms in question?

>
> Prepare boot performance floors from genpd_prepare(), where performance
> callbacks may sleep. Walk the parent hierarchy even when the device's
> own domain has no boot floor: a parent without direct consumers would
> otherwise miss preparation entirely. Take parent locks in the existing
> child-to-parent order and propagate preparation failures to the PM core.

Question, if doing this in genpd_prepare() how would that protect us
from changes happening later on during system suspend, when a consumer
driver decides to update the performance state vote for its device?

In regards to system suspend, even if the sync state has not happened
yet, we are doing a power off of the genpd. I assume this is okay,
while still keeping the current genpd->performance_state or maybe it
isn't?

If there is no problem with that above, maybe it's easier to continue
to let the genpd provider (through its ->power_on() callback) manage
the restoring of the genpd->performance_state itself? In that case, we
don't need to care about the genpd->boot_performance_state, as it
should be indirectly applied anyway, right?

>
> Also retain boot power protection in genpd_sync_power_off() for domains
> with a boot performance floor. This prevents the system-sleep path from
> withdrawing their power vote while boot protection remains active.

I don't get this, sorry. What is "boot power protection"?

>
> Keep performance programming out of resume-noirq. Domains with their
> floor already satisfied do not need another performance update, and
> no floor is imposed after sync_state() releases boot protection.

Please rephrase this. I don't understand what "releases boot protection" me=
ans.

>
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Kind regards
Uffe

> ---
>  drivers/pmdomain/core.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 6f2b406ce049..4ff55175d899 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1538,7 +1538,9 @@ static void genpd_sync_power_off(struct generic_pm_=
domain *genpd, bool use_lock,
>  {
>         struct gpd_link *link;
>
> -       if (!genpd_status_on_unlocked(genpd) || genpd_is_always_on(genpd)=
)
> +       if (!genpd_status_on_unlocked(genpd) || genpd_is_always_on(genpd)=
 ||
> +           (genpd_is_power_unknown(genpd) && genpd->stay_on &&
> +            genpd->boot_performance_state))
>                 return;
>
>         if (genpd->suspended_count !=3D genpd->device_count
> @@ -1623,6 +1625,31 @@ static void genpd_sync_power_on(struct generic_pm_=
domain *genpd, bool use_lock,
>         genpd->status =3D GENPD_STATE_ON;
>  }
>
> +/* Called with the domain lock held, before entering noirq. */
> +static int genpd_prepare_boot_performance(struct generic_pm_domain *genp=
d,
> +                                        unsigned int depth)
> +{
> +       struct gpd_link *link;
> +       int ret;
> +
> +       /* Parents may need a boot floor even when this domain does not. =
*/
> +       list_for_each_entry(link, &genpd->child_links, child_node) {
> +               struct generic_pm_domain *parent =3D link->parent;
> +
> +               genpd_lock_nested(parent, depth + 1);
> +               ret =3D genpd_prepare_boot_performance(parent, depth + 1)=
;
> +               genpd_unlock(parent);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (genpd_needs_boot_performance_state(genpd))
> +               return _genpd_set_performance_state(genpd,
> +                                                  genpd->performance_sta=
te, depth);
> +
> +       return 0;
> +}
> +
>  /**
>   * genpd_prepare - Start power transition of a device in a PM domain.
>   * @dev: Device to start the transition of.
> @@ -1644,6 +1671,12 @@ static int genpd_prepare(struct device *dev)
>                 return -EINVAL;
>
>         genpd_lock(genpd);
> +       /* Performance callbacks may sleep; prepare the hierarchy before =
noirq. */
> +       ret =3D genpd_prepare_boot_performance(genpd, 0);
> +       if (ret) {
> +               genpd_unlock(genpd);
> +               return ret;
> +       }
>         genpd->prepared_count++;
>         genpd_unlock(genpd);
>
>
> --
> 2.54.0
>
