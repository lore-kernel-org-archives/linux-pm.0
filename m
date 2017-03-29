From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 3/9] arm: fix return value of parse_cpu_capacity
Date: Wed, 29 Mar 2017 09:37:37 +0200
Message-ID: <CAKfTPtCswVBMCaEUzBF4w_GZf-2iLORsS5S0HhGD94ps4+J1Xg@mail.gmail.com>
References: <20170327131825.32134-1-juri.lelli@arm.com> <20170327131825.32134-4-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:35265 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbdC2Hh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 03:37:59 -0400
Received: by mail-ot0-f175.google.com with SMTP id y88so4876436ota.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 00:37:58 -0700 (PDT)
In-Reply-To: <20170327131825.32134-4-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

On 27 March 2017 at 15:18, Juri Lelli <juri.lelli@arm.com> wrote:
> parse_cpu_capacity() has to return 0 on failure, but it currently returns
> 1 instead if raw_capacity kcalloc failed.
>
> Fix it by removing the negation of the return value.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reported-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index f8a3ab82e77f..4e4af809606a 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -166,7 +166,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>                         if (!raw_capacity) {
>                                 pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
>                                 cap_parsing_failed = true;
> -                               return !ret;
> +                               return ret;

Why not directly returning 0 ? whatever the value of ret, the parse of
cpu capacity has failed in this case

>                         }
>                 }
>                 capacity_scale = max(cpu_capacity, capacity_scale);
> --
> 2.10.0
>
