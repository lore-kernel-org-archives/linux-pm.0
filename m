From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PULL REQUEST] PM / devfreq, for Linux 4.1
Date: Thu, 02 Apr 2015 00:47:53 +0200
Message-ID: <8899743.VjlCEZmNKa@vostro.rjw.lan>
References: <710482662.140561427784841523.JavaMail.weblogic@epmlwas02b>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50044 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752412AbbDAWXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 18:23:39 -0400
In-Reply-To: <710482662.140561427784841523.JavaMail.weblogic@epmlwas02b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: rafael.j.wysocki@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, tomeu.vizoso@collabora.com

On Tuesday, March 31, 2015 06:54:02 AM MyungJoo Ham wrote:
> Dear Rafael,
> 
> Here goes a pull request from devfreq including device driver updates and style fixes.
> 
> 
> Cheers,
> MyungJoo
> 
> The following changes since commit e42391cd048809d903291d07f86ed3934ce138e9:
> 
>   Linux 4.0-rc6 (2015-03-29 15:26:31 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20150331

Pulled, thanks!

> for you to fetch changes up to 358b615f5812e28dd763d2aa1297563927a2f89d:
> 
>   PM / devfreq: tegra: Register governor on module init (2015-03-31 13:17:15 +0900)
> 
> ----------------------------------------------------------------
> Pull Request for Rafael, Targeting Linux 4.1
> 
> This set includes tegra driver update and style fixes.
> 
> ----------------------------------------------------------------
> Chanwoo Choi (1):
>       PM / devfreq: event: Add const keyword for devfreq_event_ops structure
> 
> MyungJoo Ham (1):
>       PM / devfreq: correct misleading comment
> 
> Tomeu Vizoso (6):
>       PM / devfreq: tegra: Update to v5 of the submitted patches
>       PM / devfreq: tegra: Use clock rate constraints
>       PM / devfreq: tegra: remove operating-points
>       PM / devfreq: tegra: Set drvdata before enabling the irq
>       PM / devfreq: tegra: Enable interrupts after resuming the devfreq monitor
>       PM / devfreq: tegra: Register governor on module init
> 
>  drivers/devfreq/devfreq.c           |   1 -
>  drivers/devfreq/event/exynos-ppmu.c |   2 +-
>  drivers/devfreq/tegra-devfreq.c     | 509 ++++++++++++++++++++----------------
>  include/linux/devfreq-event.h       |   2 +-
>  4 files changed, 290 insertions(+), 224 deletions(-)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
