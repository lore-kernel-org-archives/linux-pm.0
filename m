From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 7/9] arm,arm64,drivers: reduce scope of
 cap_parsing_failed
Date: Mon, 10 Apr 2017 09:31:05 +0100
Message-ID: <20170410083104.GC27538@e104818-lin.cambridge.arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-8-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdDJIbK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 04:31:10 -0400
Content-Disposition: inline
In-Reply-To: <20170327131825.32134-8-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:23PM +0100, Juri Lelli wrote:
> Reduce the scope of cap_parsing_failed (making it static in
> drivers/base/arch_topology.c) by slightly changing {arm,arm64} DT
> parsing code.
> 
> For arm checking for !cap_parsing_failed before calling normalize_
> cpu_capacity() is superfluous, as returning an error from parse_
> cpu_capacity() (above) means cap_from _dt is set to false.
> 
> For arm64 we can simply check if raw_capacity points to something,
> which is not if capacity parsing has failed.
> 
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c   | 3 +--
>  arch/arm64/kernel/topology.c | 5 +----
>  drivers/base/arch_topology.c | 4 ++--
>  3 files changed, 4 insertions(+), 8 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
