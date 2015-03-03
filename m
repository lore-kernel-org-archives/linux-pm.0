From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Samsung Thermal fixes for v4.0-rc2
Date: Mon, 2 Mar 2015 22:21:20 -0400
Message-ID: <20150303022117.GA14070@developer.hsd1.ca.comcast.net>
References: <20150302114347.449271df@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44310 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbCCFna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 00:43:30 -0500
Content-Disposition: inline
In-Reply-To: <20150302114347.449271df@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Mar 02, 2015 at 11:43:47AM +0100, Lukasz Majewski wrote:
> Dear Eduardo,
> 
> Please find my first pull request for Samsung Thermal fixes targeting
> v4.0-rc2.
> 

Pulled. Thanks. 

Couple of minor comments though (check next on your pull)

> Changes:
> - Exynos7 power down detection mode fix
> - Fix for cpufreq cooling device regression
> - Updating MAINTAINER's entry for Samsung Exynos Thermal 
> 
> 
> 
> The following changes since commit
> 5912e264d9eec512598d8faf33440630a3aee989:
> 
>   Merge branch 'tmon-fixes' of .git into next (2015-02-28 14:07:03
>   +0800)
> 
> are available in the git repository at:
> 
> 
>   git@github.com:lmajewski/linux-samsung-thermal.git
>   github_linux-samusng-thermal/fixes

This branch does not really exist. But I figure you want to mention
'fixes' branch.

> 
> for you to fetch changes up to 93c537affd5d2a7b2fcea4a1d608b011841d3c04:
> 
>   MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER (2015-03-02
>   10:06:09 +0100)
> 
> ----------------------------------------------------------------
> Chanwoo Choi (1):
>       thermal: exynos: Fix wrong control of power down detection mode
> for Exynos7
> 
> Lukasz Majewski (2):
>       cpufreq: exynos: Use simple approach to asses if cpu cooling can
> be used MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER
> 
>  MAINTAINERS                          |  8 ++++++++
>  drivers/cpufreq/exynos-cpufreq.c     | 21 ++++++---------------

As this one was a left over and was acked by cpufreq maintainer, I am
picking this time. But even in the case of an ack, I would really prefer
to have each change going via their respective tree whenever possible.

>  drivers/thermal/samsung/exynos_tmu.c |  3 ++-
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> 
> -- 
> Best regards,
> 
> Lukasz Majewski
> 
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
