Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32144CF44
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556017; cv=pass; b=N3xyCisc3MOUixZvDKfo3HPS5nmRhyRMU6P5BvtYL9GqqjWq3HI5Wxpfn8kyYH4skZdcjbwUCUWKR57OlJeqb6SRU8zPHYSDVuBjAd1fo1eRCAo+3GgVkfGvBl6U247gPJBBU9SjTs6NBSToiJpvD3TUk7nacQN8MJRgDwMtXiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556017; c=relaxed/simple;
	bh=hjigRTpAheShvm4CUT48bphb627DqEDqb9jtmCAaHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em3gPwnFW/S3D9sCjfNkv6ttfQ8J7b0ljPsacUpCTQOOopHUZJsJg1K9Kh5H5nn0hzArg4+1vzCcnQKK3bxdf/n6MmApnhySMvpp+wl64JosNgDmiOE6WCMBdELQK6orlygaIZ3qCplU2RHLzIyf1ZxgufJQra9r0tpTincEdVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVytQEUj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JsLuZIfC; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVytQEUj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JsLuZIfC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DK4ld1908357
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 14:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yn5+ecY3l/7Ibm3VZ5iLKxtcMms0hMKLnboQJLRWmU4=; b=KVytQEUjtqCMeEs+
	IlaupvZ6HdAWnkXDlu8DGKXcQmaWAhzC0hIo4Kuw+rT2SBbUn608lxqOTXIFx76T
	24L1342L5BBnS/nn70pm7616hPPD6f+ub6C4saRgX6+Oh5yryqCVFUtGYKaOhS5c
	zgLsWmqEj7ZaZEp7S/eO0Y/80s9DthnY4YhFmWXCUUjG7ul5bG/KUKBoWQNbcyK3
	SQomoBHOudb/+o7riht2a3wZk6GBA4h3jy4kmfuoh5pbe4K3LKlS+uf88C5flLl/
	Ktj+xd+ptKntIzvpPsUgq9MqW0h+HO0ZSIZQ1DpnZt13t7Hv9dAIdLS7e3cjOm9O
	ia+Nsg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6yk7gk8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 14:26:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-892ccb01fbfso2107320b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556015; cv=none;
        d=google.com; s=arc-20260327;
        b=LwwYB/vNrVK2Dd6stabr1WQFRjRJtRb9PxCmUSSgmXeoUr8T0qjkaBP7HLDiVL9klg
         p92t2/MKqSRBaNbBgoxf7oIjJJUsFCKx7+UgPRRdeC87W50ooQOLUCWvM8IhBbTnDMXO
         KjeWPCBDwF4DoBKRgFrnu+BWblkcxVfA8PGvoHUeSeJAbNrHvOUXR+XM3rhoT3x7hxMc
         odV7r2DBexhoXPbECTZzvNQIVWKi4pd0AT8wnYtGlIGxCfka5eNB8YhAP5FBbcl7CiFv
         yh81WSxBgMEn7M4Dftn4/T0yVOORFn7d0ESwV2Qg6FCjGroUXG1JB7ALOJ0qDEErTIQq
         GHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yn5+ecY3l/7Ibm3VZ5iLKxtcMms0hMKLnboQJLRWmU4=;
        fh=EB6vxjWFVLRAmBpjDiIE8rUzcs6Q+ERX9wwjq+N7kfU=;
        b=YlIxElNH1cQiEWtdJ/zaFAt6Wf0F83C6fu8D/lGPHcYbPoXY+mJcVFLoKQBXSVxOsa
         yocbKD6cyVG4zevYcVwQ+bc6rWhzATRLYy5RoOE380TMYrX6Mb2NxIcy/a1aqBBfb+zG
         mO0s+c8k2sPHgiAsVlKvoH4cajMiXk9utPIAeiXDQr3TUsA5VUvl2WhDvJgxQuve+jEr
         uL95hStTOVlJD4dF2VbZx/K0DcsLPxfNn03d5r7bZjSo0moDrHv7tGo4u4s6AdDYE/Rz
         xUeU/05R3dnc6468ia4EgQ+JQ5jD6g8E2O6GJfBG7nTtAgrKsgKVKjoEXHiU2HMphoXT
         27XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791556015; x=1792160815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yn5+ecY3l/7Ibm3VZ5iLKxtcMms0hMKLnboQJLRWmU4=;
        b=JsLuZIfC5BqvWQG8Lc3WgF39aqJJoKsW90tCSxOfRJqf4BAJ+bwJLgfn4vSUtLdtgu
         7xjOHxN94tWIH1HYRD8bpw6BC2AQjeATE8tMFMWhUDVfrtNPGzhwgTzUjPrTxtP51f/o
         ZmZKgiNCKgORBYpwbeFyY0NQWKuVyGlwL39WwH5gN4Xx0EnRKEy8/QrWK0sJYpBiJKm2
         zEOWfrgcJVoOGzeWIYOLLYCo6Z5q4EXcHIJEE/5gYtKKMus8l0igMjoFOeZJPFVwtdJz
         hNJj9vA+3lwDTHPGstjSFOBF4RShX1s/7DdkGtv3e+H6YnrYwWV4bmYgqHU9od761ec1
         6g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556015; x=1792160815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yn5+ecY3l/7Ibm3VZ5iLKxtcMms0hMKLnboQJLRWmU4=;
        b=IY5ReHesfIRz9khrkuZVCr4Vj0pnx4JzoT1ZtpDgHFc90MfK8ZcJNmhNAVyvLSe5DO
         ZFbeYo01XLi4ZQt7HekvC00LLLYQF6PwfDGegXZTW4tj14R2BjkjagPki8SZO6VfZisi
         7YB3ziquUoW3furJRhrt4lvpvYiXfTevashsBspYginr48nps+2fnr/UG+AqRDyNiBKR
         wKL4beo1IvgO8MrrERpAxT8PqXoBpym8XBsfOgTfWMhaw/uZyCVLSUHZQehgfSUiRibC
         psWocdkYuDp32Dpoc3CcCSBg8i+YFBjcihJYsrmtBOjKW8C3uJXM3xB5aXcSiOxKQatO
         WyzA==
X-Forwarded-Encrypted: i=1; AKwUvBzwhxrxsp1xEE8j0nAfBbAx55JETS9jCctJCGeYvhRonmP+Q8lzik40+BxPkXhmd+Namqyc9IzlJA==@vger.kernel.org
X-Gm-Message-State: AFuF++ltZ4aG442Z9iotESAbHbX+g00DFf4/rpFbYHJF6qNMQ15qpejq
	yR2VPaItmfCC4q06qxmM9NzgnibFE+qvaJSk+2zxXgaG/OCjLYdwtxbIINPGOsdbKolFbPKrlz/
	1FsPTaWuptNZx/J/3KIS0hJZQ3yCYiPzNgNK6P3chunJcHxiElny04lQGMLi9pLSR86B22ZiNQI
	ZrBkaKNFT3MjOV2bWOl0J7GPXGLNJkLy392F6G
X-Gm-Gg: AYBFou3QxfOJ9I+3m15y7JV+dL/3FDRF1ytaJ2jg2fSEa08ltLzl1KFT4jrj9VCwX1b
	JBUdZif+l293aIro9kl+9KPpdIm9kmZkwIcmlVnYM8Vn3ClK6MhuC7F5Nts4zphsdtmLS6zv0YX
	fqons1fSPpilSTTevrQpJbmqF2/xa0jOWF5jJWXA2xQ6uRrFitT7XirLyvIg==
X-Received: by 2002:a05:6a20:c79a:b0:3e0:b71b:a8f2 with SMTP id adf61e73a8af0-3e16c010522mr1735826637.40.1791556014672;
        Fri, 09 Oct 2026 07:26:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79a:b0:3e0:b71b:a8f2 with SMTP id
 adf61e73a8af0-3e16c010522mr1735661637.40.1791556009444; Fri, 09 Oct 2026
 07:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla> <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
 <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
In-Reply-To: <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:26:38 +0200
X-Gm-Features: AclHuK_Vubf4k8TpvsD1c7GgWbgnBlZu6M1U_szLd1fRdLCNfDEiyzf-bluvzDo
Message-ID: <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: Add support for system-suspend-only states
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=D63SufRj c=1 sm=1 tr=0 ts=6ac8f9af cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=xZBbqvtqD373e08s9rwA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: -apSuOcpTcpjhaxPo2NBh85HJo423CWN
X-Proofpoint-ORIG-GUID: -apSuOcpTcpjhaxPo2NBh85HJo423CWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NyBTYWx0ZWRfXyJgj9xCCCFgj
 VT9+XG1w8OWMgJVN7y3uoTSyXHNZ97FScW6WvS7SV3/wdl//hzWz01nhzf4UN2UY3lwSBdxbxSm
 rzT3aPXWRzDNuqnkRWcRn00EAzeTIO3Rj/B/na1uHoacrqPP49SkYuiAkotszxApJCskoq3Y7Uf
 H7HF1Uwq/V+XjoG0qZ1JrlvXNtS73hIJ59hpm8EkQi+D1xUyxP9q5yzl/ZN890OClubXD6A9y9a
 Z/3HPK/lLGYZoFa3tHMTfZ1tIXPjigvvGKzfKBBOXkbvfB0aSFah3iviYy8iqfqeeT84ElEc1XP
 rLsmsbJRBV0Xi9pxeIYWSLqmZTpnQtV4SHMGR0QqNlM2DmPXEAWNael784w7wkaSLbzJjB0lUsO
 YNsSK0h6P2oqQD/MMGiFHedOF10b5WBjIb851jeFJCgUzV9IhXJyAQHFNniiqTtH7bHRB4JaRla
 6O+HkYS+mjapZ5dJQJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NyBTYWx0ZWRfX9Wt1CjVuVPfa
 NjwtNVSsv6eJEX8Spf3bIHy31rIN4Sw6EYv90zEav2wNRpiIsoOa3QKcjpZEuWRLa/d6IDLI925
 NaevSn3b+46blimPvCE0z5PHC/rbLsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090057

On Fri, Oct 9, 2026 at 2:21=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.or=
g> wrote:
>
> On Thu, Oct 08, 2026 at 02:21:49PM +0200, Ulf Hansson wrote:
> > On Tue, Oct 6, 2026 at 11:15=E2=80=AFAM Sudeep Holla <sudeep.holla@kern=
el.org> wrote:
> > >
> > > On Mon, Oct 05, 2026 at 08:59:43PM +0530, Maulik Shah wrote:
> > > > Some domain idle states require system-wide coordination and should=
 not be
> > > > selected during regular CPU idle. However those states remain valid=
 for
> > > > system-wide suspend like s2idle.
> > > >
> > > > Add a per-state system_state boolean and populate it from the syste=
m-state
> > > > property. Make the genpd governor skip these states during CPU idle=
. Leave
> > > > the system wide suspend path unchanged so s2idle can select them.
> > > >
> > >
> > > Instead of this I am thinking if we can QoS cpu latency setting and b=
lock
> > > system level states normally. Since s2idle is user driven, it should =
be
> > > controllable via user-space and we don't have to define bindings agai=
n
> > > if systems that use platform-coordinated needs this too. They may not
> > > use domain-idle-states.
> >
> > Even if we likely could make that work, it's seems not correct to rely
> > on userspace to make the kernel to pick the correct idle state, while
> > the decision should be based on the characteristics of the HW.
> >
> > In regards to PSCI PC mode, I believe we should consider adding the
> > similar DT property for the arm,idle-state binding and make a
> > corresponding change for the regular CPUIdle path/governors. Although,
> > it doesn't necessarily need to be part of the $subject series. I would
> >  be fine if that is handled later on too.
> >
>
> While I agree with this line of argument, I am bit worried that there is
> more deviation from ACPI _LPI binding(equivalent to these in DT). If othe=
r
> OS has manged to run the same firmware without adding such information
> to the firmware(ACPI in this case), why do we need that in DT. Is that
> information encoded elsewhere in a different form in ACPI and is this the
> right place(the idle state binding for DT) is what I am trying to underst=
and
> here.

I don't have the information about ACPI at hand, so I will leave that
to Maulik to be answered. Or perhaps, someone else already has this
information and can share that with us?

In any case, I don't see any other reasonable way to describe this in
DT at this point.

>
> Also taking the example of screen on, won't that be prevented as the
> system domain is shared by the system level idle-states we are talking
> and the screen/display device. So it never votes to power down that
> and the PSCI OSI domain idle driver must not be able to choose the system
> level state.
>
> In general, there is some device that doesn't vote to power down the doma=
in
> and hence we can't enter the state. So my question is, will there be some
> device that doesn't explicitly register vote and hence we need an alterna=
te
> mechanism like the one proposed in this set ? If so, what are those and
> how does that work in system suspend states.

Assuming I understand the above use case, you are thinking that the
display device (for example) is a part of a cluster PM domain, right?

If that's the case, besides that the cluster PM domain topology must
be modelled accordingly, the display device should be hooked up to the
cluster PM domain it belongs to.

Beyond that, it's the corresponding display driver that becomes
responsible for what should happen during system suspend. If the
screen needs to stay on it may need to call device_set_awake_path()
for the display device - unless it's a decision for user space that
can control the behaviour for the display device via its sysfs node.
If things are managed accordingly, genpd_finish_suspend() may decide
to keep the corresponding PM domain powered on during system suspend.

The above said, $subject patch doesn't change any of this. It only
allows us to use more states (deeper), which are limited to system
suspend (s2idle).

>
> Or am I missing something more fundamental the makes all the above argume=
nt
> void.
>
> --
> Regards,
> Sudeep

Did that make sense?

Kind regards
Uffe
