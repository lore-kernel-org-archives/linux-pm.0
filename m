From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 5/8] arm, arm64: factorize common cpu capacity default
 code
Date: Thu, 25 May 2017 15:12:51 +0200
Message-ID: <20170525131251.GB16244@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-6-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969019AbdEYNND (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 09:13:03 -0400
Content-Disposition: inline
In-Reply-To: <20170420144316.15632-6-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, Russell King <linux@armlinux.org.uk>

On Thu, Apr 20, 2017 at 03:43:13PM +0100, Juri Lelli wrote:
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
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
