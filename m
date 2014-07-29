From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: PM / OPP: ARCH_HAS_OPP
Date: Tue, 29 Jul 2014 15:03:46 +0800
Message-ID: <20140729070345.GA24750@dragon>
References: <1406551632.5397.17.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:49483
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752644AbaG2HEB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Jul 2014 03:04:01 -0400
Content-Disposition: inline
In-Reply-To: <1406551632.5397.17.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Mark Brown <broonie@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, Simon Horman <horms+renesas@verge.net.au>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Mon, Jul 28, 2014 at 02:47:12PM +0200, Paul Bolle wrote:
> Mark,
> 
> Your commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") landed in
> today's linux-next (ie, next-20140728). It removes the Kconfig symbol
> ARCH_HAS_OPP and ten select statements for that symbol.
> 
> After that commit there are still nine select statements for that symbol
> left in linux-next. (These select statements are now actually NOPs.) The
> peculiar thing is that these nine statements are all found in Kconfig
> files also touched by that commit.
> 
> Anyhow, are patches to remove these pointless select statements queued
> somewhere?

There a couple of such select in imx Kconfig, and I will clean them up.

Shawn
