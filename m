From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
Date: Fri, 18 Mar 2016 10:49:18 -0700
Message-ID: <56EC3F9E.4050209@nvidia.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com> <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, pboonstoppel@nvidia.com
List-Id: linux-pm@vger.kernel.org

Hi Juri,

On 03/18/2016 07:24 AM, Juri Lelli wrote:

<snip>

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

Any reason why this capacity number is not dynamically generated based on the
max frequency for each CPU? The DT property would then instead specify just
the micro-architectural differences between the CPU types.

-Sai
