Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A23D9542
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219963; cv=pass; b=DHKjo6pFgFOX2cICysDPdKEcIkhme6Pe57nilgfa7wOBU69o+bpiJLXsiW4Gmr0Rfse/y8IhGrLEhv7W9dJstyQB8sxVVtg8Vt1Ae0AexXuMNmNCM4jnNCKjSPhMq3+jld2ZnSj/kfhPMmWgiU38SHV1LUFm+jiPV/KvoxU2ufA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219963; c=relaxed/simple;
	bh=g0Dfr5yjAvvMsR9i3jq7ArVp+HPH0ubwB4S/4hyAi/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juEb7gemTZEbkkwl/tn6hTZs/DNIKKDRBYQMuDKVWAN7XOW7vwOAQqAFqg04YXnnPgySIxr0QyRQoOfk8wR5t9fdAo22aE4T6ULFUJN4l1ZW7HaeMXAXXNWPdUHFSR8ZaxQkclwXqLjRyhe/SIxeDOUQ3ZP3qRIKzFzSy89IOeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oMV5pBw4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xk9DHHD2; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oMV5pBw4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xk9DHHD2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PCvI2465321
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FSaHqHnxNvb6CqEiudUKpmDqvVSufUKJTbfzCQiY/CA=; b=oMV5pBw4lu6V8ORR
	bJYBOvrsKSfU43iCzMy3TRRyFYcZAy2hF9weTkyAlPI8H2CbuJCKZzn6lK3E0jUN
	llsfY3U/CmsdJ64rYcs9YZjZetvDmpdsRnTK20ddqUvoO3wbgzAm0XGYxeiNIOVq
	Onz/wKqMMCQ5mzMM+b/aNhYFrixDDEIBUA/1EYEZ4S4xZj7ZpErCdDSvPrMIP0Wh
	G4XSCrV2rofXwVHIuLQgUe+zj5GrlBXmwNXYCGmv2hLwm4Qwy7Awwpj9T4KQhVPW
	KWkwmACYYdjSUW8y6KmjqlXfVKNb61DTjx3WfkMmOMovJ3e1c2Yq0ZCHW2rdUCED
	sygK3Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29gbhv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:59:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so27489855ad.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 02:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787219960; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0Sc0QhBVRnsjHkVsBBn0WnaeklS+UfdcBAMEgyfnxSfkRqcC8QSLHfWiaNMa/SmRV
         d3t9DnoNnm700wAI21xVMDLI7CMM1rEL0IEr8VXPMuS7BkCQ8BYRXkhoeK/RQ3553IZv
         e3p98/uVSDLlBaWKN/u39kdq2LWvEPl2BLsoxQ9oqyFIDNX21rvmucD+M6EwqZiQ7i4n
         T5boSwDUH6OGl+brTWIZOv3mEphvlWIK9oA9psZpfAkJGgdo1henq1nyw40GwS4DNbta
         iNikgiS8fyQmfzq3/eGt9eJ+prGd2HJ9r8M+OW0WFOqqU0dr7RRb07JQEWm+7mdSVRWq
         YWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FSaHqHnxNvb6CqEiudUKpmDqvVSufUKJTbfzCQiY/CA=;
        fh=ZvBnknbwTCls/LHyeI0RxLkyTYqxE+nFLY4yKzvFDEA=;
        b=fLQbynTPPQtvQjWEE4QI/sMpIf3yWSAjKJfH87gAiQgQ5hMalCy9FMeHOWUgBeLVDT
         n7Uws547HyWax21PGHj5iLmaj4eCMcYviAutQDAXReCsli8fDNoCM1KzSshmRd2Bh1cD
         ptahhb8ljD+wI2wz0IdqJGvjC06qhUI7OzqPnn+5ZIB2dHq/M7zvlLMNRcyyNkpvqNCT
         2NSXAX+KoT+B4LfTCP1pmPUNnr2D9t8bicMnblwvAlOjj50v8rB3czHYuYthEL83ux0d
         tDARGnd1MB2VlOXi5duEBF4rpO26WLrA9yOgoq5NB8aeYGtePCTgu57oyyej+i2iUqIl
         deGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787219960; x=1787824760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FSaHqHnxNvb6CqEiudUKpmDqvVSufUKJTbfzCQiY/CA=;
        b=Xk9DHHD2Cv9kSrG9VZ9GGXMOe54HWBN59Z+H9zNA9V3YcvfOdTqwHcxd+BSRU+bzT1
         T/7he4qxN59zC9AujuR8trMOH+sdm9urBs1AfRHIByIx4kJZJrUA0kieJfEmQn8+shet
         5hgfnY5nvOaafi/69DemYQB5aUB22tvKHEOGHf9hQxb4Gud7k5XLM9rrloBcRVZ2q74V
         kRWbcZmCfXADWpQM/qTv3ZHqB9+OUqYbIql5FCscs7fKou6X2jmbEqXAk80s9A2nqR0K
         XrZ0zcYyTBbALLCSCQpuAwudaYr5OhbZGjh7x80n1U8E3H3o82sqdPXvBo9JcNhiXjUi
         talA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219960; x=1787824760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSaHqHnxNvb6CqEiudUKpmDqvVSufUKJTbfzCQiY/CA=;
        b=IMBM36hLvvxkTgrqn50hRPiztTiUvHHI+Mwx8HZBh8rjPXf3e5LbylE9KqTZxJyCV9
         0gQnLFHYzyBLs0l1SQOZ6ASQNyjedNXu3o0MCLHcWilPW+St9+rDYsN3oZgBY9iGLqaK
         VeH77uyYE10NIqOiNWK7tacGlAtC0VMz5sQwh/QnNNsD/ZhWWAzkV1xHBV/y6Jwop2fu
         pX99dRF3hnrUe5RSGMxPbuayI8odhKH/ag48ueh2Y4sZGlTrLDUj94vsWdeluzPlWASn
         sIbkRSk0Ab1H8uZWaGXZWdTZhqKwp6tGNEhzefPBzf5g7y9t2w/ZIru3p7/qa5lcPQ3P
         sgtw==
X-Forwarded-Encrypted: i=1; AHgh+Rrjm9Keo5r+ngbibAP8e2ZY0LpeBitk8NjDH+ErwwajNVySpOGVlDqMi556FlKNgsRWP+Fc1LHW2w==@vger.kernel.org
X-Gm-Message-State: AFuF++nOsWO69pIbcwYFK6ZWkph3sQ8HhvWAsV+sVwG019Sf6r55jHYQ
	lnJMXGQQoXGMJa5cjy564N7BSK+cDJ4fw//115bTY1MEOgLO0RX76QwmnikU9SxwGCLcz7pRD8l
	rLXnZAVCNkgxqrbOHufrQXnn8bO0a02CwvQ+3vkJx6fCI80QmyYfsafSTnUtIaXFhpEZ2vA2Rzb
	GkCkrxtx+mYMfbI7MlSDTWMVrn/3ytFR/jZhL9
X-Gm-Gg: AR+sD11GvN9To2ZlPb4xpXdQd+YrbU+7ZJpaVV4yaJVVOl+SrvpUdZY/OKb1qm7CsGu
	quJMSEe1LzGMKVDqqLGEJ3eEZrfN2BlD/GPYqjKUpN1E6znfHV/jpFGQ/jdL9bM3PPiIp1akSn/
	cPacA/VOK0gihNNoQwaoe/RE2AFHDHdZdsdi5OLeMNjH2hFsk2lld6n5PWLA==
X-Received: by 2002:a17:902:f551:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d5fd6ad63cmr190936755ad.11.1787219959896;
        Thu, 20 Aug 2026 02:59:19 -0700 (PDT)
X-Received: by 2002:a17:902:f551:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2d5fd6ad63cmr190935515ad.11.1787219959289; Thu, 20 Aug 2026
 02:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
 <20260819151457.256959-2-ulf.hansson@oss.qualcomm.com> <gkeug6e7thc4j4drwjreirzgtdq747vj3u7jsulslbhru6qjjb@s6ypnqwi3szh>
In-Reply-To: <gkeug6e7thc4j4drwjreirzgtdq747vj3u7jsulslbhru6qjjb@s6ypnqwi3szh>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:59:08 +0200
X-Gm-Features: AcwNN1XK7dEs62eUen9n-mxcBc7VkbIvkm68wapHAppB932T_5EJAsmItCtZvUE
Message-ID: <CAPx+jO-a-YOD+YG9zuzvTBY+gob0hj9gXGKoADJGPj2to7527g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] pmdomain: core: Allow a non-CPU device in a CPU
 PM domain to do power on
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ip1bvgcolBF4CfEGpW35ScRil-vRyS0z
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86cff9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=u8BtVuMVLpZXKRMe:21 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Fytdzj91sHjwM7AYtdcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX3VTReq8C2NeU
 6MRmDIFQ0drfLguk6WTe8iaajRHZMk/5h5ws0vvz1zqpzMEZ751DO5+ZaRhP1SVWE+GNuYHtzbZ
 s8Yf/AxNHWsrUCdSHHWRdiz4CVnuE2eS1XyZjFB2145Q0+WONSSyZDg3s2Vm65RXfjmJTnkA3jS
 efjdVsMPB4ZYMFM3J9Ee3hpI0qLlfBnjnVhqt7XuLO3yeKPCXwNvJzkJRYACZK37ve3JX9JzW8o
 Ruj2VrS+wyOiI2M0F0jB38sRakmaSaBGB1mZCEmM7gVz94GPVI/DLbHCBz0dlxlGKJl38k3yzL0
 yQxDtiHKQWYmedq/JcXdHVm9xRXQZt8WIStsUc3CZjHwl/WGzrnUK3xPD14+YGdwM5ET9G0VoQ7
 y/nBnXxFSSNq2NRc9FfjnD48gBfQh+Y3UdZdLHlGsEQamSfGh5DI7PY4vH6U4dFQX7F7wXQ0AAp
 Q+lc5JvYX2qqhP2ckJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX0grLraFAGUsY
 1MbbCuEy0/RbFAwQbnNC4sUe+CF+QSTu8vVDorEmB00YfC5QBhkkx9EFyk0gEw+Rotc9c5/qA95
 bDOw8WIHrTWKOxvfD0v4gFKpygI59gQ=
X-Proofpoint-GUID: ip1bvgcolBF4CfEGpW35ScRil-vRyS0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200073

On Wed, Aug 19, 2026 at 7:52=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> On 26-08-19 17:14:51, Ulf Hansson wrote:
> > From: Ulf Hansson <ulfh@kernel.org>
> >
> > A driver for a non-CPU device that is attached to a CPU PM domain (the
> > genpd has the GENPD_FLAG_CPU_DOMAIN configuration set), is currently no=
t
> > able to power on the PM domain. More precisely, to power on a CPU PM do=
main
> > one of its corresponding CPUs needs to be woken up if they are idle.
> >
> > The current support for a non-CPU device is that its driver can only
> > prevent an already powered on CPU PM domain from being powered off. Thi=
s
> > leads to problems for a driver while probing its device or when it need=
s to
> > call pm_runtime_get_sync() to turn on the power for it. From the driver
> > point of view it looks like it all works fine, but when accessing the
> > device it may end up with various errors as the device may not be fully
> > powered on.
> >
> > To fix the behavior for these types of devices, let's adjust the behavi=
our
> > in genpd_power_on() to wake up an idle CPU that belongs to it, in cases
> > when it's needed.
> >
> > Link: https://lore.kernel.org/all/CAPx+jO-sCierYj8jnoKQHckJG16dOBxnNrsZ=
VYO=3D38R2cLV8nw@mail.gmail.com/
> > Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> > ---
> >  drivers/pmdomain/core.c | 80 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 75 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 842c4169e290..7345c06f1d55 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/kernel.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/pm_runtime.h>
> > @@ -19,11 +20,14 @@
> >  #include <linux/slab.h>
> >  #include <linux/err.h>
> >  #include <linux/sched.h>
> > +#include <linux/smp.h>
> >  #include <linux/suspend.h>
> >  #include <linux/export.h>
> >  #include <linux/cpu.h>
> >  #include <linux/debugfs.h>
> >
> > +#include <trace/events/ipi.h>
> > +
> >  /* Provides a unique ID for each genpd device */
> >  static DEFINE_IDA(genpd_ida);
> >
> > @@ -32,7 +36,9 @@ static const struct bus_type genpd_provider_bus_type =
=3D {
> >       .name           =3D "genpd_provider",
> >  };
> >
> > -#define GENPD_RETRY_MAX_MS   250             /* Approximate */
> > +#define GENPD_RETRY_MAX_MS           250             /* Approximate */
> > +#define GENPD_CPU_ON_POLL_PERIOD_US  100             /* 100us */
> > +#define GENPD_CPU_ON_TIMEOUT_US              5000000         /* 5s */
> >
> >  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)               \
> >  ({                                                           \
> > @@ -1027,15 +1033,75 @@ static void genpd_power_off(struct generic_pm_d=
omain *genpd, bool one_dev_on,
> >       }
> >  }
> >
> > +static bool genpd_check_status_on(struct generic_pm_domain *genpd)
> > +{
> > +     bool is_on;
> > +
> > +     genpd_lock(genpd);
> > +     is_on =3D genpd_status_on(genpd);
> > +     genpd_unlock(genpd);
> > +
> > +     return is_on;
> > +}
>
> I'd change the genpd_status_on() to genpd_is_on_unlocked().
>
> And then this one would be just genpd_is_on().

Yep, that sounds like an improvement, thanks for the suggestion!

>
> The rest looks good, so:
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Thanks!

Kind regards
Uffe
