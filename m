From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/3] Introduce of_match_machine() helper
Date: Wed, 24 Sep 2014 10:44:39 +0300
Message-ID: <20140924074439.GA25537@tbergstrom-lnx.Nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <53FB7642.1000808@wwwdotorg.org>
 <20140919131245.GQ26779@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3240 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaIXHov (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 03:44:51 -0400
Content-Disposition: inline
In-Reply-To: <20140919131245.GQ26779@tbergstrom-lnx.Nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Fri, Sep 19, 2014 at 04:12:45PM +0300, Peter De Schrijver wrote:
> On Mon, Aug 25, 2014 at 07:45:38PM +0200, Stephen Warren wrote:
> > On 08/07/2014 05:01 PM, Tuomas Tynkkynen wrote:
> > > Some mach-specific drivers that don't require their own node in the device tree
> > > (for example drivers/soc/*, cpufreq, cpuidle etc.) want to match on the device
> > > tree root compatible property instead. Instead of open-coding (and forgetting
> > > to call of_node_put on the root node) everywhere, add a helper to the OF core.
> > 
> > Tuomas, I assume there will be a new version of this series to address 
> > the review comments? For now, I'm not intending on applying this.
> 
> Given that Tuomas's internship ended, I'm willing to push this patch set
> forward, if there is interest. So are people still interested in this idea
> or should we drop it?

Seems there's no interest. I won't bother with this then.

Cheers,

Peter.
