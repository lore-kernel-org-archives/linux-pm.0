From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4 3/8] arm: fix return value of parse_cpu_capacity
Date: Thu, 20 Apr 2017 16:50:03 +0200
Message-ID: <CAKfTPtCnK6TW3+pdYLeDcUWEtQi5j+id70Lhtv4umg1eNyZV1w@mail.gmail.com>
References: <20170420144316.15632-1-juri.lelli@arm.com> <20170420144316.15632-4-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33929 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946428AbdDTOuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 10:50:24 -0400
Received: by mail-oi0-f48.google.com with SMTP id x184so54214129oia.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2017 07:50:24 -0700 (PDT)
In-Reply-To: <20170420144316.15632-4-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

On 20 April 2017 at 16:43, Juri Lelli <juri.lelli@arm.com> wrote:
> parse_cpu_capacity() has to return 0 on failure, but it currently returns
> 1 instead if raw_capacity kcalloc failed.
>
> Fix it (by directly returning 0).
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reported-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>
> Changes from v3:
>
>  - directly return 0 on failure (as pointed out by Vincent)
> ---
>  arch/arm/kernel/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index f8a3ab82e77f..1b8ec3054642 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -166,7 +166,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>                         if (!raw_capacity) {
>                                 pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
>                                 cap_parsing_failed = true;
> -                               return !ret;
> +                               return 0;

Acked-by: Vincent Guittot <vincent.guittot@linaor.org>
>                         }
>                 }
>                 capacity_scale = max(cpu_capacity, capacity_scale);
> --
> 2.10.0
>
