From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v3 0/9] Fix issues and factorize arm/arm64 capacity
 information code
Date: Mon, 10 Apr 2017 17:21:48 +0100
Message-ID: <20170410162148.GG30804@e106622-lin>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170410150503.GS17774@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdDJQVq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 12:21:46 -0400
Content-Disposition: inline
In-Reply-To: <20170410150503.GS17774@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org

Hi,

On 10/04/17 16:05, Russell King - ARM Linux wrote:
> On Mon, Mar 27, 2017 at 02:18:16PM +0100, Juri Lelli wrote:
> > arm and arm64 topology.c share a lot of code related to parsing of capacity
> > information. This is v3 of a solution [1] (based on Will's, Catalin's and
> > Mark's off-line suggestions) to move such common code in a single place:
> > drivers/base/arch_topology.c (by creating such file and conditionally compiling
> > it for arm and arm64 only).
> 
> I think overall this is okay, with the exception of one patch which seems
> to be wrongly worded.

As I said in reply to your comments, we could also consider dropping
that patch entirely. What's your opinion?

> Once that's resolved, then:
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> for the series.
> 

Also, I'd like to update 3/9 as suggested by Vincent.

Thanks for the review.

Best,

- Juri
