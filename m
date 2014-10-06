From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 0/4] cpufreq-dt, platform_data based proposal
Date: Tue, 07 Oct 2014 00:53:23 +0200
Message-ID: <2152065.1YrbYhlbqO@vostro.rjw.lan>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com> <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com> <20141006091905.4e0d976a@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51079 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750956AbaJFWdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 18:33:18 -0400
In-Reply-To: <20141006091905.4e0d976a@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

On Monday, October 06, 2014 09:19:05 AM Thomas Petazzoni wrote:
> Hello,
> 
> On Wed, 10 Sep 2014 14:08:24 +0200, Thomas Petazzoni wrote:
> 
> > Thomas Petazzoni (4):
> >   cpufreq: allow driver-specific data
> >   cpufreq: cpufreq-dt: extend with platform_data
> >   ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
> >   cpufreq: cpufreq-dt: adjust message related to regulators
> > 
> >  arch/arm/mach-mvebu/pmsu.c   |  8 +++++++-
> >  drivers/cpufreq/cpufreq-dt.c | 21 +++++++++++++++++----
> >  drivers/cpufreq/cpufreq.c    | 15 +++++++++++++++
> >  include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
> >  include/linux/cpufreq.h      |  2 ++
> >  5 files changed, 63 insertions(+), 5 deletions(-)
> >  create mode 100644 include/linux/cpufreq-dt.h
> 
> Since this series was Acked-by Viresh, would it be possible to get it
> merged for 3.18 ?

I'm still seeing discussion going on about patch [1/4], though.

Is that irrelevant?

Also I'd prefer Viresh to tell me that this is 3.18 material instead of
sending ACKs in random replies and hoping that I'll notice them.  I may
not.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
