From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 3)
Date: Wed, 23 Jul 2014 22:31:41 +0200
Message-ID: <201407232231.41787.arnd@arndb.de>
References: <20140722205706.GA23220@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51227 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbaGWUbt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 16:31:49 -0400
In-Reply-To: <20140722205706.GA23220@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>, arm@kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Tuesday 22 July 2014, Jason Cooper wrote:
> All,
> 
> Here's the cpufreq changes I mentioned over the weekend.  It's been in
> -next for a while.  Once I get the new version of cpuidle from ThomasP,
> I'll push that as quickly as possible.

Just for my information, is this coordinated with the cpufreq maintainers?
I remember being asked to ensure all cpufreq/cpuidle stuff has an Ack
from them, even stuff that doesn't touch drivers/cpufreq at all.

The contents look good to me. I can merge them if there are no objections
from Viresh, feel free to send the next batch already without waiting
for me to pull.

> As usual (do I need to type this each time any more? :) ), this is an
> incremental pull request from tags/mvebu-soc-3.17-2 up to
> tags/mvebu-soc-3.17-3 on the mvebu/soc branch.

It certainly helps me to have this information, but you can write it
more briefly, e.g. "based on tags/mvebu-soc-3.17-2".

	Arnd
 
> The following changes since commit ba364fc752daeded072a5ef31e43b84cb1f9e5fd:
> 
>   ARM: Kirkwood: Remove mach-kirkwood (2014-07-13 22:13:39 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17-3
> 
> for you to fetch changes up to ba3ec5780bba27819bbc4f669e6c77418a00f14b:
> 
>   Merge branch 'mvebu/soc-cpufreq' into mvebu/soc (2014-07-22 20:46:48 +0000)
> 
> ----------------------------------------------------------------
> 
> mvebu SoC changes for v3.17 (round 3)
> 
>  - mvebu:
>     - Add cpufreq support for Armada XP
> 
> ----------------------------------------------------------------
> Jason Cooper (1):
>       Merge branch 'mvebu/soc-cpufreq' into mvebu/soc
> 
> Thomas Petazzoni (3):
>       ARM: mvebu: ensure CPU clocks are enabled
>       ARM: mvebu: extend PMSU code to support dynamic frequency scaling
>       clk: mvebu: extend clk-cpu for dynamic frequency scaling
> 
>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   5 +-
>  arch/arm/mach-mvebu/platsmp.c                      |   1 +
>  arch/arm/mach-mvebu/pmsu.c                         | 162 +++++++++++++++++++++
>  drivers/clk/mvebu/clk-cpu.c                        |  80 +++++++++-
>  include/linux/mvebu-pmsu.h                         |  20 +++
>  5 files changed, 261 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/mvebu-pmsu.h
> 

