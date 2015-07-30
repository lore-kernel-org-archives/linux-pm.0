From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add ->get_rate() driver callback
Date: Thu, 30 Jul 2015 15:17:21 +0530
Message-ID: <20150730094721.GA9121@linux>
References: <fb44111fa7a762924661ad48a70985d597229bc4.1436351759.git.viresh.kumar@linaro.org>
 <1879392.TC0RceaKlH@vostro.rjw.lan>
 <20150709045902.GI1805@linux>
 <1709328.yilXR0UZlG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35104 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbbG3Jr2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 05:47:28 -0400
Received: by pabkd10 with SMTP id kd10so20925339pab.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 02:47:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1709328.yilXR0UZlG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10-07-15, 01:26, Rafael J. Wysocki wrote:
> *You* can do them faily quickly.  Say if all of the outstanding cpufreq
> patches are queued up for 4.3, then it will be the time to submit more.
> Otherwise I'll just have an ever growing queue of patches to process
> which won't speed up things at all.

Lots of pending stuff is already committed. Would you like me to send
these now?

Also, how should I send them? I mean, you want separate patches for
drivers? Or all of them in a single patch. This is how stats may look:

 drivers/cpufreq/acpi-cpufreq.c         |  7 ++++---
 drivers/cpufreq/arm_big_little.c       | 11 ++++++++---
 drivers/cpufreq/at32ap-cpufreq.c       |  2 +-
 drivers/cpufreq/blackfin-cpufreq.c     |  6 +++---
 drivers/cpufreq/cpufreq-dt.c           |  2 +-
 drivers/cpufreq/cpufreq-nforce2.c      |  8 ++++----
 drivers/cpufreq/cris-artpec3-cpufreq.c |  4 ++--
 drivers/cpufreq/cris-etraxfs-cpufreq.c |  4 ++--
 drivers/cpufreq/davinci-cpufreq.c      |  2 +-
 drivers/cpufreq/dbx500-cpufreq.c       |  2 +-
 drivers/cpufreq/e_powersaver.c         |  5 +++--
 drivers/cpufreq/elanfreq.c             |  6 +++---
 drivers/cpufreq/exynos-cpufreq.c       |  2 +-
 drivers/cpufreq/exynos5440-cpufreq.c   |  2 +-
 drivers/cpufreq/gx-suspmod.c           |  6 +++---
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  5 +++--
 drivers/cpufreq/imx6q-cpufreq.c        |  2 +-
 drivers/cpufreq/integrator-cpufreq.c   |  5 +++--
 drivers/cpufreq/intel_pstate.c         |  6 +++---
 drivers/cpufreq/kirkwood-cpufreq.c     |  5 +++--
 drivers/cpufreq/longhaul.c             |  6 +++---
 drivers/cpufreq/longrun.c              |  6 +++---
 drivers/cpufreq/loongson2_cpufreq.c    |  2 +-
 drivers/cpufreq/ls1x-cpufreq.c         |  2 +-
 drivers/cpufreq/maple-cpufreq.c        |  4 ++--
 drivers/cpufreq/omap-cpufreq.c         |  2 +-
 drivers/cpufreq/p4-clockmod.c          |  7 +++----
 drivers/cpufreq/pcc-cpufreq.c          |  5 +++--
 drivers/cpufreq/pmac32-cpufreq.c       |  4 ++--
 drivers/cpufreq/pmac64-cpufreq.c       |  4 ++--
 drivers/cpufreq/powernow-k6.c          |  4 ++--
 drivers/cpufreq/powernow-k7.c          |  6 +++---
 drivers/cpufreq/powernow-k8.c          |  5 +++--
 drivers/cpufreq/powernv-cpufreq.c      |  8 ++++----
 drivers/cpufreq/pxa2xx-cpufreq.c       |  4 ++--
 drivers/cpufreq/pxa3xx-cpufreq.c       |  4 ++--
 drivers/cpufreq/qoriq-cpufreq.c        |  2 +-
 drivers/cpufreq/s3c2416-cpufreq.c      |  6 +++---
 drivers/cpufreq/s3c24xx-cpufreq.c      |  2 +-
 drivers/cpufreq/s3c64xx-cpufreq.c      |  2 +-
 drivers/cpufreq/s5pv210-cpufreq.c      |  2 +-
 drivers/cpufreq/sa1100-cpufreq.c       |  7 ++++++-
 drivers/cpufreq/sa1110-cpufreq.c       |  7 ++++++-
 drivers/cpufreq/sc520_freq.c           |  4 ++--
 drivers/cpufreq/sh-cpufreq.c           |  8 ++++----
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  5 +++--
 drivers/cpufreq/sparc-us3-cpufreq.c    |  5 +++--
 drivers/cpufreq/spear-cpufreq.c        |  2 +-
 drivers/cpufreq/speedstep-centrino.c   |  5 +++--
 drivers/cpufreq/speedstep-ich.c        |  7 ++++---
 drivers/cpufreq/speedstep-smi.c        |  6 +++---
 drivers/cpufreq/tegra-cpufreq.c        |  2 +-
 drivers/cpufreq/unicore2-cpufreq.c     |  2 +-
 53 files changed, 132 insertions(+), 107 deletions(-)

-- 
viresh
