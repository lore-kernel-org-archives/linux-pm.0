From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PULL REQUEST] for Linux-PM (rc-X) from PM/Devfreq
Date: Wed, 12 Jul 2017 23:29:47 +0200
Message-ID: <3425387.Oejay9Fbzf@aspire.rjw.lan>
References: <CGME20170712051435epcms1p71763f426ee4cf7ab8c760ac130db1178@epcms1p7> <20170712051435epcms1p71763f426ee4cf7ab8c760ac130db1178@epcms1p7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62798 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752363AbdGLVhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 17:37:40 -0400
In-Reply-To: <20170712051435epcms1p71763f426ee4cf7ab8c760ac130db1178@epcms1p7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>, "garsilva@embeddedor.com" <garsilva@embeddedor.com>

On Wednesday, July 12, 2017 05:14:35 AM MyungJoo Ham wrote:
> Dear Rafael,
> 
> 
> Here goes pull-request from PM / devfreq with a few fixes.
> 
> 
> Cheers,
> MyungJoo
> 
> 
> The following changes since commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c:
> 
>   Linux 4.12 (2017-07-02 16:07:02 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rc
> 
> for you to fetch changes up to 37d644aa01c092686af8a96f34df93c74e55b480:
> 
>   PM / devfreq: constify attribute_group structures. (2017-07-06 10:17:24 +0900)
> 
> ----------------------------------------------------------------
> Arvind Yadav (1):
>       PM / devfreq: constify attribute_group structures.
> 
> Gustavo A. R. Silva (2):
>       PM / devfreq: rk3399_dmc: fix error return code in rk3399_dmcfreq_probe()
>       PM / devfreq: tegra: fix error return code in tegra_devfreq_probe()
> 
>  drivers/devfreq/governor_userspace.c | 2 +-
>  drivers/devfreq/rk3399_dmc.c         | 5 +++--
>  drivers/devfreq/tegra-devfreq.c      | 6 +++---
>  3 files changed, 7 insertions(+), 6 deletions(-)

Pulled, but please send these pull requests before merge windows or at least
in the first half of a merge window.

If this had not been fixes/cleanups I would have deferred it and queued it up
for the next release.

Thanks,
Rafael
