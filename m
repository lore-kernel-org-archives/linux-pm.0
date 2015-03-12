From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v2 17/17] soc/tegra: remove lagacy powergate APIs
Date: Thu, 12 Mar 2015 18:18:49 +0200
Message-ID: <20150312161849.GF6072@tbergstrom-lnx.Nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-18-git-send-email-vinceh@nvidia.com>
 <20150312124501.GA632@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7872 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030244AbbCLQTI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 12:19:08 -0400
Content-Disposition: inline
In-Reply-To: <20150312124501.GA632@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Vince Hsu <vinceh@nvidia.com>, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org

On Thu, Mar 12, 2015 at 01:45:02PM +0100, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Mar 12, 2015 at 08:15:18PM +0800, Vince Hsu wrote:
> > We switch to generic power domain now. So remove the legacy functions.
> > 
> > Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 68 -------------------------------------------------
> >  include/soc/tegra/pmc.h | 22 ----------------
> >  2 files changed, 90 deletions(-)
> 
> I don't think we can do this. What if somebody updates their kernel but
> not the DTB? In that case they'll end up with drivers that don't enable
> power partitions but at the same time the powergate driver won't enable
> them either because it is missing the corresponding nodes in the DTB.
> 
> What we'll have to do is probably keep the code that enables the power
> partitions and make it conditional on the power domains somehow. Is
> there a way to determine at runtime whether a device has been attached
> to a power domain?

Or use DT overlays to 'load' a hardcoded overlay for the specific SoC?

Cheers,

Peter.
