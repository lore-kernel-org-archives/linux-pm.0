From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Wed, 15 Jun 2016 17:11:16 -0500
Message-ID: <CAL_JsqJwQVsn3=6vQus4Q2OhnLUsJVN70j2+f3QoJejcb=p9YA@mail.gmail.com>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com> <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42150 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbcFOWLm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 18:11:42 -0400
In-Reply-To: <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, peterz@infradead.org, Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Mark Brown <broonie@kernel.org>, sgurrappadi@nvidia.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof

On Wed, Jun 15, 2016 at 5:17 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> ARM systems may be configured to have cpus with different power/performance
> characteristics within the same chip. In this case, additional information
> has to be made available to the kernel (the scheduler in particular) for it
> to be aware of such differences and take decisions accordingly.
>
> Therefore, this patch aims at standardizing cpu capacities device tree
> bindings for ARM platforms. Bindings define cpu capacity-dmips-mhz
> parameter, to allow operating systems to retrieve such information from
> the device tree and initialize related kernel structures, paving the way
> for common code in the kernel to deal with heterogeneity.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>
> Changes from v1:
>  - removed section regarding capacity-scale
>  - added information regarding normalization
>
> Changes from v4:
>  - binding changed to capacity-dmips-mhz
>  - sections and changelod updated accordingly
> ---
>  .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
>  2 files changed, 246 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> new file mode 100644
> index 0000000..7582a13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -0,0 +1,236 @@
> +==========================================
> +ARM CPUs capacity bindings
> +==========================================
> +
> +==========================================
> +1 - Introduction
> +==========================================
> +
> +ARM systems may be configured to have cpus with different power/performance
> +characteristics within the same chip. In this case, additional information
> +has to be made available to the kernel (the scheduler in particular) for
> +it to be aware of such differences and take decisions accordingly.
> +
> +==========================================
> +2 - CPU capacity definition
> +==========================================
> +
> +CPU capacity is a number that provides the scheduler information about CPUs
> +heterogeneity. Such heterogeneity can come from micro-architectural differences
> +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
> +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
> +context is about differing performance characteristics; this binding tries to
> +capture a first-order approximation of the relative performance of CPUs.
> +
> +CPU capacities are obtained by running a suitable benchmark. This binding makes
> +no aspersions on the validity or suitability of any particular benchmark, the
> +final capacity should, however, be:
> +
> +* A "single-threaded" or CPU affine benchmark
> +* Divided by the running frequency of the CPU executing the benchmark
> +* Not subject to dynamic frequency scaling of the CPU
> +
> +For the time being we however advise usage of the Dhrystone benchmark. What
> +above thus becomes:
> +
> +CPU capacities are obtained by running the Dhrystone benchmark on each CPU at
> +max frequency. The obtained DMIPS score is then divided by the frequency (in
> +MHz) at which the benchmark has been run, so that DMIPS/MHz are obtained.
> +Such values are then normalized w.r.t. the highest score obtained in the
> +system.

So the property says it represents DMIPS/MHz, but we take that and
"normalize" them back to a made up numbers? Perhaps that step should
be optional. Then paranoid Si vendors can put their fake numbers in
and end users can update the dts files with real numbers.

Is there any point in allowing people to pick their own scale? Why not
just 100 (as in percent)?

Rob
