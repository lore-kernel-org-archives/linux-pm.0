Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDA328243
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921746; cv=pass; b=QMkRY7hrdUiWWQIOxHWqGqsr6u0w/b3xDaluy09NJw3fxafQ02tLHU78Maq9uqu1J8wonysI2+Zy6lf+/W71RNW74wDagZCtNmlJrFRXcf+WkX6YTXozUCqI+h3G/HuuNQDcyQ4ccBFT/MANcbQo+3HmwGa/Eodn3YtZEIy1Wds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921746; c=relaxed/simple;
	bh=V8dDa/GHyF7aUA2nQhDnMeklGkqtowjGVj+5hVNLmeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWEgRaIITIv6Pf3RZpnwo+VUcaCbNo71u1O0IswLf8SBZCLzNUOt0jZuytznBl/rhBkRYyUuW90UABsOzSYDcORiuK4C+xKhA0eHoyK4yRq0Y/q0n5aoCU7+SFGOmv2JndRXoTfkCWZxpz/lw/iP83u9wZ+PUWmSsxKPcqx+vQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqT2e4PQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZFY++mM; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqT2e4PQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZFY++mM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA86nk3064405
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 12:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qMsc0H9v5E0bSl/fIG39NIMkkZMYTzMHbvVDO82fKk0=; b=HqT2e4PQr+oaOBkd
	t6CFh5SMjFW9PdYFIglukwk6axjkuqgay10FRcnmUF1YUOWiAjvv/KsZrocypxx1
	gACZLX8wIA9+xuI5TsiKXKZX71dB3YitdtKhm7uc1JWs1N1UUuhsBhtNtnqKnZvk
	4HFXfgChOyAklkX/pQ7CkN4fCIS5rd+5FBchkpbQwYSAjnLTANJ+0+GP8dlX2SqW
	jvpeDkYDSZEe0AYcARvlYGhRDnwNxqJX/gj9kwQ8N+P1YRBU9DgYvY9crR3RsMnE
	ETqasSZJdXoVElV9ljo72PsY/jRvkuqdbrJ5S/rF/rs7NxCvaCcYFy1tMt0jCp1X
	fI27Pg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb47n1q4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 12:55:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2131282a91.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 05:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787921742; cv=none;
        d=google.com; s=arc-20260327;
        b=sGsmHQiEeseXs3TiuUjyqs/Z0LFgSudYMA+mM8ec2A3mZ/NDS6L1VHEUlfpiLbmS60
         30X657H291Lj3MPWwLDkdkQwC8DKnD3VwH2l4yzXPp8YlMeoq0F0qgvvlslFsmCSxCPk
         Do1zcxcpFoofZ8hr9+T2XBxJCEQRxj/ZfxNHpnjGf7bqX3HQY34bBy3gchYLbS7ZQ7fe
         vsK/s9y0TG2L6EYUvwfg1Ne0jlPrcsMQvLTGBFs3N/MIgLdsessUk876f1keYFF5CSSx
         uiglSVKOhNqpsJxBFItyQ1Iu18TxziUOoXZ8YT4B0gq360JvjB7EapZ1q/HbiYzqbV5G
         6AJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qMsc0H9v5E0bSl/fIG39NIMkkZMYTzMHbvVDO82fKk0=;
        fh=BLSosJUHWi0r2e3Uyo3T3YrixWdPTmXjE8k2cYFJM8A=;
        b=hggfPqYjtJp5rLOoAQkGTT3Ox/nXKxaW0VZem7rSKD62JIUwnOeATuHLJFPmWw8jwW
         l/W9lUe4d9ob/1LGWJxQhBTGmsztwtchwbCAFkhDo4GHn8YkdFQBbcl93zYESYVI5bCq
         /qqpS8TmVMdMh2cDF0I4Ci55z2bba/2F1XCQV/A0xU6elxe+0WiGKfKbnDfkxaGdissw
         /tU4v+MCzpyjyHPh0Uem90tbrVZZ/or6VC7Dr2ignBaAxDOmS2BnBDhuzLy5T1c4NvLM
         06Y9B0z8luMJ2D7uvmacOJ1lG8wcL59MKtZXcZY2alZqXy1CeANkqeegL3NJ0V8E+/qm
         14Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787921742; x=1788526542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qMsc0H9v5E0bSl/fIG39NIMkkZMYTzMHbvVDO82fKk0=;
        b=fZFY++mMJOcMpdnsfbwab49LqNZVIFNz+YzeuuoeuOs3hJYN6zzy4O/etgc4tF4nsO
         4BhhVwr/p767g+MZRe/41nvIRRR7uq8sApvM0whZTxOmvzDMCNZVWC3BnR4mN9637LOC
         aHADbEq6g9bSlsz2gBkdYdMtcLHhTUHQiAbqU6nerW0dxYVAKsF6Y0TqqkQ6GJAyfwK7
         z4WXe3C1mBmiSn51AqmyUIHMxL3rr5Q4/d7qqaq6EDCDeWjdSCFF4Esqvf3CMNhNYFsf
         GrPl0jwVf78Ka+1YX5OWCOpBKuqd/xWMwvbiA1jV4ETuCqXB6hUVuw/9EWXRbsh6KOZU
         SkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921742; x=1788526542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMsc0H9v5E0bSl/fIG39NIMkkZMYTzMHbvVDO82fKk0=;
        b=jRW/RzhgRoBtQhCNVCVqhEESrvh1Sb6NWrfLYVcZWhbtKZTFBmg7ua4Yb3kmrH+8Xl
         1Qqd0VpNfDsM9UTkgIQzJb/gnCZkJb7qwyXQsx2JKDmleVDAxlthwqaEFqJk8eo+ZFB7
         0e3KL2QKiDS8UxdvzFkkHV5klPHbInaqBuqw8ny/lz7TPhnM1ob8jcV+hML8NY2dvjGr
         C9DJr4hnCo0muq+L83XM4dvtlsdxpT0lvaOLaNIBrkt4jvm/mudKDxnA//TMLeBnRcaG
         De061n3fyvuzQBlG5O1DfEc85e85Mf495kx7NX//M7NydBZIhkoLlbJzd04rz5e05AfC
         59CA==
X-Gm-Message-State: AFuF++lJ5hgrt0Ma9PgJS8ywgXqR8fNU2rpkk5LwWU+7dURxX8AMJrhz
	EENF3L+jR4BObLgPv8eiC1YwQi++RBeRUMCEn0h4pT1HbclJt4f6pDBDJN/xOQoreWK/MNbbKaf
	Y0WewKNDo/5rpFHVHsmnJn0XWJv3/0Z6P/nrs57knMfSZkvwYiEBq77P56aoLA3DyN21usOpU7r
	Qh7RdTsigEUVL/nKYhOKYL7m4Cnk+YHeo5q/wB
X-Gm-Gg: AR+sD11jCogLQEdbREPaJeZM9S5wsnJJN8UDoQxKxgpZeozSr+rCe35B3+rWynavh9o
	fan+fPIiNtfxx1RRvrqOyXziQV+Bi7ROoWe6ltIW0LGXf99chI2UpdLYVs+al4MoiwLxAhSkKFh
	LLSKMA0Hh5NSNaFdgIJQJhF/msdJg7mJifbdd9rJUnY8sGl/ExGK8GJwqjlQ==
X-Received: by 2002:a17:90b:2e0e:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-396d0e34e0amr15326604a91.2.1787921741952;
        Fri, 28 Aug 2026 05:55:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0e:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-396d0e34e0amr15326489a91.2.1787921741399; Fri, 28 Aug 2026
 05:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
 <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com>
In-Reply-To: <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 14:55:29 +0200
X-Gm-Features: AcwNN1V7lxdEGrOUHTiNyhanMK-GXSQ77bN-sYB5cy8Q_XdA_1K89CXemOM9wgs
Message-ID: <CAPx+jO9x304geo422e6PGNGPNsgSPAKcqUUyX244jOwy7fNw3w@mail.gmail.com>
Subject: Re: RISC-V genpd race in OSI mode (genpd domain power_off vs firmware
 suspend call)
To: Jimmy Ho <jimmy.ho@sifive.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Anup Patel <anup@brainfault.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nick Hu <nick.hu@sifive.com>, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=a8YAM0SF c=1 sm=1 tr=0 ts=6a91854e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=UXIAUNObAAAA:8 a=pFyQfRViAAAA:8
 a=jJX-bYqjmPCJVg_0ptYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=a1s67YnXd6TbAZZNj1wK:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: _epA4dBlddIv8z4Ej_5ISpb4ZG3Ed7hZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExMSBTYWx0ZWRfX8BljT2F7arOn
 ZmjDlX8u6q590ctHU2rvp0fLxFCsZaM72sy9INvKQMhxMeCxGOF4gej/V9lR8COMjQikL3q6IqM
 8FE4rWJy671U4Q9I8YKtdjnpCS21pXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExMSBTYWx0ZWRfX2f8nndieLWIV
 jeCdOZz03zAZ/fTQctn1IsFi5sN9MoENz6ivoBmzIgEYdhjtYiGDcO7BEw3F3bGnRRbK/bYoP8X
 W1rRc5slJuwCJAyj4l3xBGvk7l0GcIlpdn+ddQoJ79Sq3A5r8gwmyNrNqWFvX2AUis/5NXF+iym
 XodEAk77IJcL6h+sHl+uE+UKEFsRBWvu0f52Ez8xDiJh+ZRcDoxZyNaHPzjMt44RVwOV8wei4BB
 yb3DheoYYmInd+MKp64mD4Ve4iR22XJ3Nersq0PYO6h+oVVhW+TFPsLZi410EHTP21cD93eHUWi
 DbdR5SoG5DUyrEQgM+Y92ftPOKmH6JGgNzWpQlUZLENlQyIOQeWJ99jMTNumhU2PjjiS1gleD/j
 aKQGOjYzzM5r+e0Zgjz6JbqkRmXrIS0IGy1/yBCRJ7CGNukVZzMLn5zAqQ9lkE2LS8T8wSUkSZR
 l/7418O2pJUiZG/0IBg==
X-Proofpoint-GUID: _epA4dBlddIv8z4Ej_5ISpb4ZG3Ed7hZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280111

On Fri, Aug 28, 2026 at 7:03=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> wrot=
e:
>
> Resending this follow-up to Ulf=E2=80=99s current address
>
> On Fri, Aug 28, 2026 at 12:56=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.com> w=
rote:
> >
> > Hi linux-pm,
> >
> > We hit a race condition involving genpd's CPU PM domain (OSI-mode
> > hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RISC-V
> > platform, and would like to get your opinion on whether this is a
> > genpd-level issue and what the preferred generic fix would look like.
> >
> > Background
> > ----------
> > Observed this issue on qemu platform
> > On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a genpd
> > notifier to save/restore the S-mode APLIC context:
> >
> >   aplic_notifier()
> >     GENPD_NOTIFY_PRE_OFF -> aplic_save()
> >     GENPD_NOTIFY_ON      -> aplic_restore()
> >
> > CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
> > drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). When
> > the last CPU in the domain goes idle, genpd_power_off() decides the
> > domain can be turned off (based on the "not_suspended" count computed
> > under genpd_lock). When the first CPU
> > resumes, genpd_power_on() decides to turn the domain back on and fires
> > GENPD_NOTIFY_ON, which triggers aplic_restore().
> >
> > However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(),
> > similar to a PSCI CPU_SUSPEND call) is *not* issued inside
> > genpd_lock. genpd's power_off() callback only records which domain
> > idle state was selected; the real firmware suspend call happens later,
> > asynchronously, on each CPU's own cpuidle enter path
> > (__sbi_enter_domain_idle_state()).
> >
> > The race
> > --------
> > Because of this gap between "genpd's software decision that this CPU
> > is last-man / first-man" and "the CPU actually issuing the firmware
> > suspend/resume call", we observed the following sequence
> >
> > 1. CPU0 requests a system domain-level power-gate (deep sleep, tears do=
wn the
> >    shared S-mode APLIC context) and hands off to firmware.
> > 2. Before CPU0's request is physically completed, CPU1 wakes up,
> >    genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() runs.
> > 3. CPU1 goes idle again, but this time system domain-level genpd reject
> >    request, so it fallback to core level power-gate
> > 4. CPU0's original system deep power-gate request eventually completes =
at the
> >    firmware level -- physically collapsing the system domain, including=
 the
> >    S-mode APLIC context, saved earlier by aplic_save()
> > 5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system genpd'=
s
> >    software state still says the domain is "on" (from step 2), so syste=
m domain
> >    GENPD_NOTIFY_ON will not be fired again and aplic_restore() will not=
 be
> >    called
> >
> > This looks structurally identical to the race TF-A's PSCI OS-initiated
> > mode documentation describes:
> > https://trustedfirmware-a.readthedocs.io/en/latest/design_documents/psc=
i_osi_mode.html#races-in-os-initiated-mode
> >
> >
> >   "In OS-initiated mode, there are race windows where the OS's view
> >   and implementation's view of the system's state differ... the OS
> >   might request a powerdown state for a node from one core, while at
> >   the same time, the implementation observes that another core in
> >   that node is powering up."
> >
> > TF-A's answer is to require the OS to encode a "last_at_pwrlvl" field
> > into the StateID passed to CPU_SUSPEND, which firmware validates
> > against its own view of system state before honoring a powerdown
> > request. We could not find any code in current mainline Linux
> > (cpuidle-psci.c or generic cpuidle/genpd code) that actually computes
> > and encodes this field dynamically per suspend call, so as far as we
> > can tell this race is unhandled generically today, on both arm/psci
> > and riscv/sbi backends.
> >
> > Options we considered
> > ----------------------
> > 1. Implement something like PSCI's last_at_pwrlvl generically: expose
> >    genpd's already-computed "am I the last CPU in this domain"
> >    information through the power_off() callback API, so
> >    backends can pass it down to firmware, and have firmware validate/
> >    reject stale requests.
> >    - Pro: matches the documented PSCI OSI approach.
> >    - Con: We don't know how to set this flag properly in a generic way.
> >      last_at_pwrlvl is only meaningful on riscv/arm, so we can't just
> >      add it to genpd's generic code path. genpd also doesn't keep a
> >      counter of how many CPUs in a domain are still alive, so there's
> >      no existing state in genpd's power_off() callback we could read
> >      to derive the flag. One idea would be to walk the genpd hierarchy
> >      from within the power_off() callback and check the runtime_status
> >      of each CPU device in the same domain (genpd domains already carry
> >      a CPU mask, and get_cpu_device() can be used to look up the
> >      corresponding CPU device)
> >
> > 2. Do the power-domain control directly from the power_off()/power_on()
> >    genpd callbacks (e.g. have them poke the SoC's power controller
> >    registers via an SBI call, instead of relying on each CPU's own
> >    idle-entry path to trigger the deepest state).
> >    it creates two independent driver that will touch power controller
> >    (opensbi vs linux)
> >
> > 3. Have each CPU pass a monotonically increasing sequence number
> >    alongside its suspend request to firmware, and have firmware
> >    itself detect and reject/downgrade a deep power-down request if a
> >    *newer* sequence number from a shallower (i.e. "some CPU became
> >    active again") request has been observed for the same domain since.
> >    This is a firmware-side staleness check, entirely below the SBI
> >    call boundary
> >    this seq number can be maintained in gendpd generic code
> >    or riscv power_off() callback, where do you suggest this to be
> >    added?
> >
> > Do you have any suggestion to solving this issue?
> > Thanks,
> > Jimmy Ho

The problem seems very similar to the race condition we have for the
PSCI OSI mode. This race condition needs to be managed in the FW.

If the last CPU in a cluster is about to enter idle, the FW simply
needs to abort the request for it, if there is another CPU in the same
cluster that is about to wake up.

Kind regards
Uffe
