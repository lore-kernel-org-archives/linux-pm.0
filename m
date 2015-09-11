From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Pull Request for PM / devfreq, 4.3 RCx
Date: Sat, 12 Sep 2015 00:20:31 +0200
Message-ID: <1609738.tk1R7FZ6RA@vostro.rjw.lan>
References: <1966209939.941211441951888503.JavaMail.weblogic@ep2mlwas04a>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46956 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754026AbbIKVwh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 17:52:37 -0400
In-Reply-To: <1966209939.941211441951888503.JavaMail.weblogic@ep2mlwas04a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, myungjoo.ham@gmail.com, javi.merino@arm.com, yexl@marvell.com, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>

On Friday, September 11, 2015 06:11:29 AM MyungJoo Ham wrote:
> The following changes since commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:
> 
>   Linux 4.2 (2015-08-30 11:34:09 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rafael
> 
> for you to fetch changes up to 5f25f066f75a67835abb5e400471a27abd09395b:
> 
>   PM / devfreq: Fix incorrect type issue. (2015-09-11 14:23:30 +0900)
> 
> ----------------------------------------------------------------
> Pull Request of Devfreq for Linux 4.3 / PM

I've just sent my second pull request for 4.3-rc1 to Linus and I won't be able
to sent another one before the -rc1 is out.  Had I received this two days ago,
it would have made it just fine.

I'll pull it on Monday.

> ----------------------------------------------------------------
> Chanwoo Choi (2):
>       PM / devfreq: exynos-ppmu: Add the support of PPMUv2 for Exynos5433
>       PM / devfreq: exynos-ppmu: Update documentation to support PPMUv2
> 
> Javi Merino (2):
>       PM / devfreq: cache the last call to get_dev_status()
>       PM / devfreq: drop comment about thermal setting max_freq
> 
> Javier Martinez Canillas (1):
>       PM / devfreq: event: Remove incorrect property in exynos-ppmu DT binding
> 
> MyungJoo Ham (3):
>       PM / devfreq: exynos-ppmu: bit-wise operation bugfix.
>       PM / devfreq: comments for get_dev_status usage updated
>       PM / devfreq: tegra: Update governor to use devfreq_update_stats()
> 
> Viresh Kumar (1):
>       PM / devfreq: Drop unlikely before IS_ERR(_OR_NULL)
> 
> Xiaolong Ye (1):
>       PM / devfreq: Fix incorrect type issue.
> 
>  .../bindings/devfreq/event/exynos-ppmu.txt         |  43 +++++-
>  drivers/devfreq/devfreq.c                          |  12 +-
>  drivers/devfreq/event/exynos-ppmu.c                | 171 ++++++++++++++++++++-
>  drivers/devfreq/event/exynos-ppmu.h                |  70 +++++++++
>  drivers/devfreq/governor_simpleondemand.c          |  33 ++--
>  drivers/devfreq/tegra-devfreq.c                    |   8 +-
>  include/linux/devfreq.h                            |  24 ++-
>  7 files changed, 326 insertions(+), 35 deletions(-)

Thanks,
Rafael

