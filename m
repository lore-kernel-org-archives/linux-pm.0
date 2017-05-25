From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 6/8] arm,arm64,drivers: reduce scope of
 cap_parsing_failed
Date: Thu, 25 May 2017 15:13:07 +0200
Message-ID: <20170525131307.GC16244@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-7-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969019AbdEYNNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 09:13:23 -0400
Content-Disposition: inline
In-Reply-To: <20170420144316.15632-7-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

On Thu, Apr 20, 2017 at 03:43:14PM +0100, Juri Lelli wrote:
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
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
