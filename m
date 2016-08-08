From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 0/8] CPUs capacity information for heterogeneous
 systems
Date: Mon, 8 Aug 2016 18:49:37 +0200
Message-ID: <20160808164937.GH6879@twins.programming.kicks-ass.net>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45048 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbcHHQtp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2016 12:49:45 -0400
Content-Disposition: inline
In-Reply-To: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

On Tue, Jul 19, 2016 at 01:40:40PM +0100, Juri Lelli wrote:
> Patches high level description:
> 
>  o 01/08 introduces documentation for the new optional DT binding
>  o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
>    provide parsing of such information at boot time
>  o [07-08]/08 introduce sysfs attribute
> 

So generally ok with me; there does seem to be an unfortunate
duplication of code between arm and arm64 but other than that it looks
fine.

