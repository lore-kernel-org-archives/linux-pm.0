From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 0/3] cpufreq: cpufreq-dt: platform_data based
 proposal
Date: Tue, 21 Oct 2014 15:13:46 +0200
Message-ID: <20141021151346.0fb90af5@free-electrons.com>
References: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<2513404.oZkEVY1Jti@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58017 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932300AbaJUNNv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 09:13:51 -0400
In-Reply-To: <2513404.oZkEVY1Jti@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

Dear Rafael J. Wysocki,

On Tue, 21 Oct 2014 15:33:09 +0200, Rafael J. Wysocki wrote:
> On Sunday, October 19, 2014 11:30:26 AM Thomas Petazzoni wrote:
> > Hello Rafael,
> > 
> > As you requested, here is a new version of the cpufreq-dt patches,
> > rebased on top of the latest Linus tree
> > (52d589a01d4545ce1dc5c3892bb8c7b55edfe714 as I write this).
> > 
> > Compared to version 2:
> > 
> >  - Rebased on top of latest Linus tree.
> > 
> >  - Removed PATCH 3/4, which is meant to go through the mvebu
> >    maintainer tree. I'll push it post-rc1.
> > 
> >  - Added Acked-by tags from Viresh, since he ACKed all the patches.
> > 
> > Could you take those patches and push them to 3.18 ?
> 
> I've applied the series and it is in my linux-next branch now (which means that
> it should appear in linux-next proper tomorrow).
> 
> I'm going to push it for 3.18-rc2.

Thanks a lot! I'll push the mvebu part of the series separately through
the mvebu maintainers.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
