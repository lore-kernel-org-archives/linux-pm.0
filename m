From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 5/9] arm, arm64: factorize common cpu capacity default
 code
Date: Mon, 10 Apr 2017 09:18:07 +0100
Message-ID: <20170410081806.GB27538@e104818-lin.cambridge.arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-6-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbdDJISN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 04:18:13 -0400
Content-Disposition: inline
In-Reply-To: <20170327131825.32134-6-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, Russell King <linux@armlinux.org.uk>, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:21PM +0100, Juri Lelli wrote:
> arm and arm64 share lot of code relative to parsing CPU capacity
> information from DT, using that information for appropriate scaling and
> exposing a sysfs interface for chaging such values at runtime.
> 
> Factorize such code in a common place (driver/base/arch_topology.c) in
> preparation for further additions.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
> 
> Changes from v2:
>  - make capacity_scale and raw_capacity static
>  - added SPDX header
>  - improved indent
>  - misc. whitespaces/newlines fixes
> 
> Changes from v1:
>  - keep the original GPLv2 header
> ---
>  arch/arm/Kconfig             |   1 +
>  arch/arm/kernel/topology.c   | 213 ++-----------------------------------
>  arch/arm64/Kconfig           |   1 +
>  arch/arm64/kernel/topology.c | 219 +--------------------------------------
>  drivers/base/Kconfig         |   8 ++
>  drivers/base/Makefile        |   1 +
>  drivers/base/arch_topology.c | 242 +++++++++++++++++++++++++++++++++++++++++++

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
