Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794174317;
	b=B1D5oIPMzXBJOM0WIWcn9WhDvpd/LgU2MNflstS708Fh4luFq0SbFYlsPCye5+WuLq0O
	 cInNVJriT7+rjgW4UF17I1luMopD6ufxyT7XvSDYa1pxwAVdRNYKVRUvf5NQVcsAM8Y/F
	 1VHlOSeegg3g0TuFhnmMvV0e8lMCuiPa3l5Qo/pv9PtbFGQnHr/QOiwOpWFoYaXKq1rFO
	 jWMxMCFHiGlzK8f2F+Mahe1lCV0Fwxuv0O4dkmYZPHnujGdW/gmWY3+Oa/kiOMobUMtJw
	 QUDpDX55eK/tfohv9lvniTeh2DyTBAstkjuxvMCyWzroLOlWqk3AJsFCbHPVqsYyhbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yP+R+yf5xY4dHL5c8agyL0IxXu0xVt/tENjfyE274v8=;
	b=sXQ9FOEfxNXmUrDtIfmEMdeLObFZO+tPLoDSKPcYXT1Gp5aq4dhbBEavC1dRtn2g9ncA
	 8VD2KmaIzI4FBVTcImWFCHcUlb72OYVppVYp8L3GHJYWApGos3IDnnGmTNFg9K9GmFb8o
	 U8OvKvNWLG8J+VSUSSsiqDiQj38WgSySRWPafz1L7P3Dur/bkrHiccB4VLkSIZfOEVTUE
	 t3MtNW13kxXFJsZQks/gBFdwYtEoL4VXyk/D0bBoj4eg3vWjbAzXhCY4CbsogLzCqC2PP
	 3fJr3jI42jVDv7FdYMH9OvbNlUYc9MrUvTYRrcrt8tucJD6QU3TgAvzrsAGYyJhWLWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=I7bKQwoM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE7606D803
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 21:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89BE7606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=I7bKQwoM
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67be6030c9fso168839d50.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 13:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794174315; cv=none;
        d=google.com; s=arc-20260327;
        b=myEcXAssepFaR2NXCiCsNrqqTw8CQGkwAQ+as03z4EHtLNlpIC9bKrTRmqfwrUDtqA
         8oEY14S0WZgaNGdjfg3/bKob7CNyewPwLt20b1EOzRb/bDolItgF1CiYvOwLOR9/SX2K
         0Xuv9T0VC4PxvLmB93V08a82a3gwWyNX3s355tpZUbbSMnzWm7OGODOtb1JwiDytqcZ6
         D76U4KlvwJt91cNuKwuzKuMEvp2LOajb9f0OjQjhlB1LCwiqPRndWjmj08jSlf9GPjB3
         lUnplCadHkqf1ZGRuaLFkCuO3lMcSoS056cWJe35YF0sWwCsssVzJYd++qwu/RC2Pi/3
         bfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yP+R+yf5xY4dHL5c8agyL0IxXu0xVt/tENjfyE274v8=;
        fh=8WQaDz74Y4fP3YGz+EvVIpjYDzvH/O4eQH4vzJcq21o=;
        b=a5g6AWIJ4w1eF1HsKmRijycEWMQfl8Qo/HQXMoCoSKIs8nHKvBU2BTX3abM9KHYED3
         WmzumT7N3Uw14mH3NlUJtDfXJuCToWX0+qTbYj9qw0fyEBtN+J+g+PBmxECey/uJe4f1
         uGuASUa+roaT9TzaWXumi3wvsikUeGRitcurMC6lFOs9j4WG/xmpAtINe6w09tARBUTm
         BgiF2kVTYFI1i1v3lIMUcT+VRGD6XMemHsN8v7D55r74dk7yLHebdGNSA+rFU6/5PqLO
         LH8N9Zgu0YhNZ9nWNoWJeKVo1jX2exA1EMihJmmPWhgm2pQU+UAMSP4Nx+2pVXTexpC0
         wdaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794174315; x=1794779115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yP+R+yf5xY4dHL5c8agyL0IxXu0xVt/tENjfyE274v8=;
        b=I7bKQwoM9NWBQhf/Z2M9xaKE9MTHjD5dWnIDH+Adr4H9RUTtmKRZOsxmHeKofyz7Ny
         5CvujknEZ2FdsKIfyVT1R/rHukzSbfqfbeZUoQ+mq5SSuAh7eETCg3UZ2Yzhcc390cJc
         Zt5++zvN/LBhhOI0WX2rUMsM3vl7LlqS8cWL0xnNAo3zoyfEoHzc6QOlQAADgd8Huoz9
         b9/JNUX5sv6svQjd9bfDrqaDY9Qwcig38CZz0q48zwybotVFcalNJBzlnbMyDvaoWmMd
         guEyM0VcxBpgZ4weamoFg+D7LcqcGJE0rbwmFiVSs7DrY6WzveUPYpQmqAAdKIwmNcub
         bL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174315; x=1794779115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP+R+yf5xY4dHL5c8agyL0IxXu0xVt/tENjfyE274v8=;
        b=qA+DkTs6YomxRasXm3Rlp2MJFSoE9QHBSeETZk/ehzYNmYq467syWr82dAF3EiEbpK
         TAVD6pbzYMgnpSBX6hDQsKCWoHGRw8K5etoec9MtNL0pg5gcarrl85H5Cyl6WJe5QBxN
         qVO8/xMSVJu0tDZ+4wV1/IXMpLIeZ1bcUVbSFoCFhNAT2hgOmNaUp7gbq8edZ8nYR/NA
         3f7THztpLTpN6W7P+5wc1pTbXVF6d0B//hl0Rwx1mrPlZg3g0XhoeIAx8z6PVK2QoToj
         Lk1/OU8TGhed1SkMlM/GO5h22feb6c1fiPloIlvjMbKYMHmgfs+bGPsqYMnh54tviE3W
         7Z4g==
X-Forwarded-Encrypted: i=1; AL+hErHSur9FI1yC2oytp8Xe3BzWUdR4zUxg6Q4RqUCfBV42DXtqu3NKi4jpCsxeh6hKzjm34V+bTNKRyw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DhNTcEMp/jDH9Exyxcbmi5mw34lgx0Qvs3hihN7pq/migMyLD
	YGYocqaKLwIAKDC/5/rb7IBHE9K0kWADBrzoX5Z6YFkLYjz9huT32rfTEvmqNyudfZ5d3MBinUA
	Z3H1Ucu33F0Mwe3WCmFzUvXgSlu7zzqU=
X-Gm-Gg: AYBFou08JcIUY1atCLzRArnbu3OI2aYooWvMjxBDLKWsUMbyjg8dZBq3Kktx5wgKqCJ
	IAKLlHU9lUEJ0Zw/ER9DiUfJnY9DU+kala3Qg9R4PNkqhwcLAFceXwEqpxPVgZC+VnmCLVbiCxx
	5CQ7/q7nEVXq7DfcK6D2qT9/MmaLDAHehd7fgxNRhFUx2QZuY/U5h44AV2Np9Qr2nJ0Uzm8ahtL
	kx8jvxB6NpfGekxMqjTVPGAs32nVnsKg4IPLgnGCElvVcfepKa558+oV8ZwWE1zCPTg6fK4oOB6
	8D5PZxj0AD9ly6wm9J5GaJLwPg0PbHFc8gGV+L6ngoOnVoGSsJxthD1UxscFOwcKXVN4gPV3fw6
	/X8YvJNqP5tUIAEU4isttDUkyFzWFG8d37q+Lse43Q8YyND0+ISJKT3YwlMspkwiHniSa0g==
X-Received: by 2002:a05:690e:bca:b0:67c:1dca:7f9 with SMTP id
 956f58d0204a3-67c3d9bb63cmr1402384d50.48.1794174315509; Sun, 08 Nov 2026
 13:45:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H> <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
 <at8WfX_G0tfTlFrm@vireshk-B250M-D3H> <9556e959-daf3-4c85-8794-9613e7e7a9ae@gmail.com>
 <A45EC676-5B14-4932-A4CF-87ED3B71108D@gmail.com> <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
 <CAFBinCBkJJeRPKLFBA9KYjwXMxFjow_NOtvFoKRQdxD=rOPW3w@mail.gmail.com> <48b333a3-ef88-4739-a087-3ed9d8ec60a4@amlogic.com>
In-Reply-To: <48b333a3-ef88-4739-a087-3ed9d8ec60a4@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 8 Nov 2026 22:45:04 +0100
X-Gm-Features: AclHuK-tzL5nxnrCwLMP_029tOJZYuTko3n3lDgTKGXJ3pWmAcdiBipcjDbfc6k
Message-ID: <CAFBinCCgmRmk--W53wqdJhF-SzJbai--s7wyzDNt3LpfN00spw@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, christian.koever-draxl@student.uibk.ac.at, 
	neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	khilman@baylibre.com, rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	=?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:46=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com> w=
rote:
>
> Hi Martin,
>      Thank you for joining this discussion. :)
>
> I have re-examined the capabilities provided by pm_opp and cpufreq-dt,
> and it seems that we may also be able to adapt A9 fairly well based on
> the amlogic-cpufreq.c here. So we have no objections to the driver
> implementation in amlogic-cpufreq.c here.
>
> I was most worried about before was that cpufreq-dt might not fully
> handle the complicated clock and supply adjustment logic between
> multiple clusters, which would have required adding a separate
> cpufreq_driver. But it now looks like this can be solved by adding the
> corresponding config_clks() and config_regulators() callbacks in
> dev_pm_opp_set_config().
That's great news, indeed!

[...]
> > - Meson8/8b/8m2 (32-bit ARM Cortex-A5/A9) where we need to reparent
> > the CPU clock to XTAL for stable operating during clock changes (which
> > should go into a cpufreq driver that implements target_intermediate).
> > There's no secure monitor or firmware involved for CPU clocks.
>
> BTW, could we put the CPU clock handling logic in the clock driver like
> G12A does (though, of course, handling it in the cpufreq driver might
> minimize the coupling between the clock and cpufreq drivers)? That way
> we could fully reuse the existing cpufreq-dt?
Common clock framework maintainers don't want muxes to be programmed
magically in clock notifiers (which is what G12A and Meson8* do).
So there's a chance that for new drivers they would just NACK that approach=
.
I don't recall the exact reason anymore - but from my perspective
using a cpufreq driver for this is the cleanest approach (although a
few lines of code extra).

Additionally: I believe the udelay(100) in the G12A and Meson8*
implementation is not even clock related but a delay to wait for the
regulator to become stable.

> > - GXBB/GXL/GXM use SCPI firmware CPU clock control so to my knowledge
> > we're good with what we have (meaning: no custom cpufreq driver
> > needed)
> > - G12A single cluster, no DSU: needs a cpufreq driver that implements
> > target_intermediate (currently it's managed on clock driver side in
> > kernel space, no firmware involved)
> > - G12B multi cluster, no DSU: needs a cpufreq driver that implements
> > target_intermediate (currently it's managed on clock driver side in
> > kernel space, no firmware involved)
>
> The cpufreq-related resources on the SoCs mentioned above are relatively
> clean: each cluster has only one independent clock and supply of its
> own, and these SoCs also do not support voltage selection based on chip
> binning.
That makes things simple, indeed: each cluster follows the same logic
using it's own resources.

> > - SM1 single cluster and DSU: needs a cpufreq driver that implements
> > target_intermediate (currently it's managed on clock driver side in
> > kernel space, no firmware involved)
>
> Compared with the SoCs above, the difference for SM1 is that it needs to
> additionally manage a DSU clock. In this case, the clock-related
> handling can be added in dev_pm_opp_set_config() in amlogic-cpufreq.c
> (by implementing clk_names and config_clks in struct dev_pm_opp_config).
I think so far mainline is not touching the DSU clock at all.

[...]
> All in all, it looks like we can currently support all Amlogic SoCs in a
> single amlogic-cpufreq.c? Then, for the specific characteristics of
> different SoCs, we can differentiate them through the "compatible"
> property and add the corresponding drvdata for each.
>
> I'll also try to support S7/A9 with representative differences based on
> this patch.
Great, let's look at some code rather than discussing theory on how to
write code :-)

There's one last detail that we have to manage in case we also want to
include the Meson8* code into the same file:
config MESON_SM depends on ARM64_4K_PAGES
32-bit kernel builds can't satisfy this (meaning: we end up with
linker errors). I think a simple way to get around this is to add stub
functions to include/linux/firmware/meson/meson_sm.h.
I'll take care of that once I can submit Meson8 support patches for
your upcoming amlogic-cpufreq.c!


Best regards,
Martin
