Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1284BF946
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602865; cv=pass; b=ilRYFBCc5iRBs2yHnr9GppzeMNUAOvQk1gbFRxo0VDGXLTlKc687AKsoLctvGPBWhoiCYRQD8p90ETVwMncvKVbO6bjxG+swcxhsw/J4pxlrqnZVXJ3tUxRbIMlWlTE4jzpUFQdjmgfcYZds3l3KaIbVjlx0d0+p0I42twivyFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602865; c=relaxed/simple;
	bh=UXrUssOqDs424Ot/LRBm3Bd2VSf1a8hGnA+UMCBoH/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIhV61L46CcykZaQtf8tUnG8hvTaChPTQCEUrXQ6MP923KHlJSyCy6+Fu797KHwm5o1GdzXnP+lYcTmQ7V3OQOXsaKKuI8Qr7fCzO1C0lh1XpGKnS4eEACyVmQwpwj0HexMjSZW0PwgkZp6J+XS0Rfnp2Zv8k9N7GcmwE3WCQ84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QLuMvo/z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eUxl2YUO; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLuMvo/z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUxl2YUO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBACOL1433783
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zvO4KHh5+3Sjn/8S8nN2GCtDB0hzNLgAuajWPejXCKU=; b=QLuMvo/zKetP2bON
	1F6JTRCiTcgBMx+GIOZLYV96NkedIQM3tfwhmLDlUP2mHp3Ivp/6BP1M06NLdYE3
	fZye0wPD0FvcQhR1oddp6UqNxE/kZyxG/c3QlnHA5ufatTHMbO5kl1NBzOgFH0hX
	4OkKQWAfJyAZIXrjfs7jRq5UYWrco1uQFDwnmjRGpoo+JXm3WTUyn24th1NuvyOr
	kzDpEQ2NdAyI1VW+5yvm8hhAXVqopozfJJKko9Q+TSZqulJN8ImuD2kJyCBuG0TQ
	QEp3scaa4iJEREz0yO1DHJ6jlVXl7chRGi0WqXVhqVGthm2Owztq2BA/xy24HdgX
	1aY8uw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s1rhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:41:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1a439db36so1800202a12.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602862; cv=none;
        d=google.com; s=arc-20260327;
        b=f9AutV95WkK+N+sHhV8VY5I52MDgWp+X8R7a59x9AjW8ErjHJB8mXr6p7EKIRAhNUe
         A4Ix5pdqAFijYs5bjp90p7i5kTVwtzJaQCjhUngvde1twziS6HWKcNL2A3o2FQK3s0WX
         WzLDh2kwKwYeld6twxCXmBNwODkCPCNE9iEawbKrsr4jJvUOCSWLgqLs/rmAiR43HSHQ
         a5OxmPAD09xRjW7yE64GBoDGNHlXm9IsSTdrZ7Z6MeGEFucqFU95Puy4lrZMtZJoPTQR
         pMLizInYqKPaBcx0A7V3BdmnmxV4L2S56dkUmgeMIS4SOehqUSYtPVvLv92xGCzJpGkJ
         vyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zvO4KHh5+3Sjn/8S8nN2GCtDB0hzNLgAuajWPejXCKU=;
        fh=ajrIsGYZ4F/hIuLnCGly/Ue1Ngd5wnNHKy0nfmwNK+Y=;
        b=fPf5HgyCZXaXkBlyI9xnGCL37+8ISXav34Sc+bgXObMu5nIEkgXFy0YmzfBfv7dggw
         t+92RZWaQsAHDR3HXJP75dVDKuIBrLh6Bdo5he7tGxA7e8zjgiGrfAmaGjBTFGiz6Cdf
         L3GzV9r3UE9jvPKUo+EiPF4AanqUlJQpTmy0v+eWHB2QTwEEASO+l9AeG/ZU6kCK88YC
         184061KklqVsc4Rb7PLImLqTNT84bJu27k4M1WasucJJ97LrB0fJ4PmaF6rqzBch6Qek
         Ws/rZ+hMz9LMCSDxK3jGYolhwlHpBI4OzwWlurSGXgwxR95MREaNT/G6eYDq1bE2FB2O
         NSIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790602862; x=1791207662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvO4KHh5+3Sjn/8S8nN2GCtDB0hzNLgAuajWPejXCKU=;
        b=eUxl2YUOYV5qTkXXmMLB66sayqwk02HDcRUq1jAFocnMO/E7RKhbsb1ks8CPeRB1lj
         WRWDWBe+JGGX47XSDH0lB3hJys1Kvh51YhVYe9nMna00Pm3UsQXdLUrYGVjHdXyTfevX
         06Z8FimQqrJaWQ+P3rTWwmEEHKCfDEc19cKaIWf5uUK/PIKH/3x/YQYM72UXh0r8PR7X
         s7OCKk1ZX9dI3qMWM6Tmd8UPH7Di/esx6x0//jephzdPB9xyzhYuFOFxOf1XfJD1+bHo
         EFcsI0q0jqQa0hnL574Vh1kQQE1JCLpljY/sJyb+OxBC9jEytI+9rek8p+zXO0/+QM5O
         gK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602862; x=1791207662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvO4KHh5+3Sjn/8S8nN2GCtDB0hzNLgAuajWPejXCKU=;
        b=WiuaDIhV5K9QjwGgiCezW2n+ugP0wF7QB0tmcBYO1K3duJ9xzaK43l8w0+JinIAepb
         b3zskQANKVyeKlBJNx1cONkVcGjmdkndHSR5SvYZCucbuXr0Exr5t9VUF4ww7cV4tV9f
         jf/CQIzRwr//uqWVXSYPpkNPhtz5ekPrk57NRJGZDXmVCvhx/0gGgvl0autTNgvga8tG
         xpk80GkYG116lZX0BIa5sYrNWzm2LYXf0zXb0hFgbIAZ2RL0tAOfLL848VbmKO1LaH18
         hcIVR6gfnyfKN2IW9vdbOL1GRP/mN4kowSM693DaAgYo2Ii98UM2j0mSg5SHu+rBveqS
         0SLA==
X-Forwarded-Encrypted: i=1; AKwUvBzaMAzpRv7M23+9903bODtd2G0vwPeXxmTyrHyWaIaAVMdtVJuhpPE+QON0dIc3hvAOa9CDtKNpeQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzB8auHucGjlhqrWQ7BncHKi8261scLjWdQ8iMGs99Pdl75OVk
	fhoVmT59sJdQWDnbI/M+2Bb1NwdQQiFDi3SAgqvlddVnJ3e8EW1oRABbvYb19Lwq9n7zpc7nb5T
	Ofq3fuP30Onz7+aA30o/Dyb6IUxbHUOlsZgxRiFgMTdAXTFOHhnORyKEpSleQ3hUeI+j9jLQvgv
	sNJ2F6GNZ7kOdCJMa8urFAcQfp0im5OXyER27w
X-Gm-Gg: AYBFou3w1mFDBfrjN2jFyw9IAqMAGUk0mELs9TkIkVRXviOkKxRuBmAmPJlwIUISHht
	b1R2zrV6/Hzxdtt7SfmpWW4EnFOW7XwGSrynGIkGM1thQpIdvtheZEtK5Fo5sIu7igOEsP+jEyP
	iiJfwmikb6VQ4lkHaVOSMFNtAS/kwfdT/iyU0x0e2noxz8N9ggbVAXB6X9SQ==
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr7621264a91.58.1790602861459;
        Mon, 28 Sep 2026 06:41:01 -0700 (PDT)
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id
 98e67ed59e1d1-3a09c9df050mr7621242a91.58.1790602860981; Mon, 28 Sep 2026
 06:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
In-Reply-To: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:40:49 +0200
X-Gm-Features: AclHuK-CYfFjfJ09V4kjeu9-c6eVsXUrgX-bJNJlISAp6_i-4inIr8jE3KRN5YE
Message-ID: <CAPx+jO-xXqqXU5Y1QiKU9M7muLqFJstd2e+rb+FacWoYsvc0ag@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
        Kendall Willis <k-willis@ti.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NCBTYWx0ZWRfX4eanN2eAJ95k
 FkddOAbv+UuEBIFgoKT75s6E9e3WoZl9y6IJVi3vFFTj4wxTotlSUh5paM1tLw8W2yVSbJvE6ty
 1iJ1YYw5aVS/d5as9NAHtBtYhYxE0tImwaNvEP8mZ4lPDs84XUa3StN4bkPnMAeEWIqQT6I0PXx
 zIY0+TDyBJKoJWT2Ec5AmnEFTTA8CIQd38Tb1vPC5PfFhnGi8CuIaO5GNCVF8XOjMc5Wsy7T6ZS
 +69sHY52tgpUXj80Bzr7hyDH1Q/+rGq+yNvvvxNhaOFu0h0j78mGqcRZGSqAEWNdJ+i7+TfCWbS
 Voq+VBxhrpq/Yfqe9qUGllLQkBp2zaoI5zwTnsEFiwYAr2sXHrLEmDKSsoJfcQQspl8gTur7MXQ
 b8VGBNnn0r1hd8ql4ZaRY2E2n/6FjrXn7+vMvcv5EMyuoFOBiN85cmXxotrG/+cmoRpJ4W0MJS8
 UD5J5HYvlwJIRzAbQmw==
X-Proofpoint-ORIG-GUID: qLnu5KJq3bt3k5Xcq4jXp86ENiwpjTTO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NCBTYWx0ZWRfX47YFSqCjfDCd
 fzJlHXMhKdeuVLjTc6W6JB4xD3wG8h1HR/NlhgWeMOCVo7FPyOaypjPnqqBDDC+9BHjQODR7pAj
 ixfbsS2VT+0NhOijjhlwkciMMka4pAU=
X-Proofpoint-GUID: qLnu5KJq3bt3k5Xcq4jXp86ENiwpjTTO
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba6e6e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=x7h4Y0DfyXJz4sC5yoMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280054

On Thu, Sep 24, 2026 at 10:30=E2=80=AFPM Kevin Hilman (TI) <khilman@baylibr=
e.com> wrote:
>
> Currently QoS resume latencies are only considered for runtime PM
> transitions of pmdomains, which remains the default.
>
> In order to also support QoS resume latencies during system-wide PM,
> add a new flag to indicate a resume latency should be used for
> system-wide PM *in addition to* runtime PM.
>
> If a user requires a different latency value for system-wide PM
> compared to runtime PM, then the runtime PM value can be set for
> normal operations, and the system-wide value (and flag) can be set by
> during suspend (for example in a drivers ->prepare() hook) and the
> runtime PM value can be restored after resume (for example, in a
> driver's ->complete() hook.)
>
> To: Rafael J. Wysocki <rafael@kernel.org>
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: linux-pm@vger.kernel.org
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
> Changes in v6:
> - use forward declarations instead of include pm_domain.h
> - remove over-detailed locking/lockless comments
> - fix 64-bit math overflow on 32-bit systems
> - drop extra dev_dbg()
> - added Rafael's ack on patch 2
> - Link to v5: https://patch.msgid.link/20260826-topic-lpm-pmdomain-device=
-constraints-v5-0-28cbf43f7e38@baylibre.com
>
> Changes in v5:
> - update copyright year & author in new header
> - add Reviewed-by tags from Kendall & Abel
> - Link to v4: https://patch.msgid.link/20260819-topic-lpm-pmdomain-device=
-constraints-v4-0-7ceb095f5474@baylibre.com
>
> Changes in v4:
> - added corresponding WRITE_ONCE() to match READ_ONCE()
> - rebase to v7.2
> - Link to v3: https://patch.msgid.link/20260611-topic-lpm-pmdomain-device=
-constraints-v3-0-75d69438518b@baylibre.com
>
> Changes in v3:
> - rebased to v7.0
> - fix PREEMPT_RT: add new helper for lockless read of flags for atomic co=
ntexts
> - update kerneldoc for genpd_for_each_child() as requested by Ulf
> - Link to v2: https://patch.msgid.link/20260205-topic-lpm-pmdomain-device=
-constraints-v2-0-61f7be7d35ac@baylibre.com
>
> Changes in v2:
> - drop the userspace interface
> - add genpd helper to iterate over all devices in domain and child domain=
s
> - new flag means latency applies to runtime PM *and* system-wide PM
> - Link to v1: https://patch.msgid.link/20260120-topic-lpm-pmdomain-device=
-constraints-v1-0-108fc4cfafce@baylibre.com
>
> ---
> Kevin Hilman (TI) (4):
>       PM / QoS: add flag to indicate latency applies system-wide
>       PM / QoS: add lockless read for flags
>       pmdomain: core: add genpd_for_each_child() helper
>       pmdomain: add support system-wide resume latency constraints
>
>  drivers/pmdomain/core.c     | 45 +++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/pmdomain/core.h     | 18 ++++++++++++++++++
>  drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/pm_qos.h      |  9 +++++++++
>  kernel/power/qos.c          |  4 ++--
>  5 files changed, 119 insertions(+), 2 deletions(-)
> ---
> base-commit: 237a1c39e8dfd3e1c6f1f023eea37a48ec04cc63
> change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
>
> Best regards,
> --
> Kevin Hilman (TI) <khilman@baylibre.com>
>

The v6 applied for next, thanks!

Kind regards
Uffe
