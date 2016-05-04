From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PULL Request] Devfreq for next (4.7)
Date: Wed, 04 May 2016 22:56:13 +0200
Message-ID: <6376884.OCU11kZgNN@vostro.rjw.lan>
References: <1799748329.331081462244196087.JavaMail.weblogic@ep2mlwas05b>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60833 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754556AbcEDUxD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 16:53:03 -0400
In-Reply-To: <1799748329.331081462244196087.JavaMail.weblogic@ep2mlwas05b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, =?utf-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>

On Tuesday, May 03, 2016 02:56:36 AM MyungJoo Ham wrote:
> Dear Rafael,
> 
> Here goes a pull request targetting Linux 4.7 (next)
> 
> 
> Cheers,
> MyungJoo
> 
> The following changes since commit 04974df8049fc4240d22759a91e035082ccd18b4:
> 
>   Linux 4.6-rc6 (2016-05-01 15:52:31 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/PR_4.7_20160503
> 
> for you to fetch changes up to 83cb0e4d837af4348cc218638e9d6daddd21d260:
> 
>   PM / devfreq: style/typo fixes (2016-05-03 11:22:10 +0900)
> 
> ----------------------------------------------------------------
> Pull Request for PM/Linux, targetting Linux-next (4.7)
> 
> Updates:
> - Passive governor: for SoC subsystems that may either
> have an independent voltage rail or have a parent subsystem
> or collegue subsystem sharing a voltage rail, when there
> is a parent of a collegue that is going to be the owner
> of the voltage rail, the dependent subsystem may use the
> passive governor.
> - Consolidated exynos bus/mem-if driver: now we have a single
> driver that supports (almost) all Exynos SoC's bus/mem-if subsystems.
> - New devfreq drivers included: Exynos NoC probe
> 
> ----------------------------------------------------------------
> Chanwoo Choi (13):
>       PM / devfreq: exynos: Add generic exynos bus frequency driver
>       PM / devfreq: exynos: Add documentation for generic exynos bus frequency driver
>       PM / devfreq: Add devfreq_get_devfreq_by_phandle()
>       PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier
>       PM / devfreq: Add new passive governor
>       PM / devfreq: exynos: Add support of bus frequency of sub-blocks using passive governor
>       PM / devfreq: exynos: Update documentation for bus devices using passive governor
>       PM / devfreq: exynos: Add the detailed correlation between sub-blocks and power line
>       PM / devfreq: exynos: Remove unused exynos4/5 busfreq driver
>       MAINTAINERS: Add samsung bus frequency driver entry
>       PM / devfreq: event: Add new Exynos NoC probe driver
>       PM / devfreq: event: Find the instance of devfreq-event device by using phandle
>       PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus
> 
> MyungJoo Ham (1):
>       PM / devfreq: style/typo fixes

Pulled, thanks!

