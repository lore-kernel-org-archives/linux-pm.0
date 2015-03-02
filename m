From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: hisilicon: add acpu driver
Date: Mon, 2 Mar 2015 18:50:25 +0800
Message-ID: <20150302105025.GA8702@leoy-linaro>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
 <1424956899-8891-2-git-send-email-leo.yan@linaro.org>
 <CAKohpokN3Ljuufv5i+TsoJRanGBVZoqEqF1wmUmCzfGbcPbUZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37814 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbCBKuc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 05:50:32 -0500
Received: by pabrd3 with SMTP id rd3so42647506pab.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2015 02:50:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpokN3Ljuufv5i+TsoJRanGBVZoqEqF1wmUmCzfGbcPbUZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com

Hi Viresh,

On Mon, Mar 02, 2015 at 11:44:28AM +0530, Viresh Kumar wrote:
> On 26 February 2015 at 18:51, Leo Yan <leo.yan@linaro.org> wrote:
> > Add acpu driver for hisilicon SoC, acpu is application processor
> > subsystem. Dependent on the H/W design, the silicon may has the coupled
> > clock domain for all clusters, or every cluster can have the dedicated
> > clock domain. So this driver will support both implementations.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm         |   9 +
> >  drivers/cpufreq/Makefile            |   1 +
> >  drivers/cpufreq/hisi-acpu-cpufreq.c | 324 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 334 insertions(+)
> >  create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c
> 
> What is stopping from reusing cpufreq-dt driver ?

Thanks for reviewing.

i'm glad to use more general method, let me give more input so that we
can see if can figure out a better way. ;)

1. From hardware design, during the initialization phase, it will
bind every opps with its corresponding voltage, and pass these related
info to power controller. So later, in kernel the cpufreq driver don't
need manually change the voltage, it will only change the cpu clock
frequency and power controller will automatically handle voltage
related operations. This is similar with TC's SPC implementation.

So looks likely the cpufreq-dt driver's voltage related ops are
redundant for this case.

2. For hi6220, it has two clusters but w/t coupled clock domain; after
discussion, the later series SoC will have two clusters with
dedicated clock domain, so we need support these two cases;

if support two clusters, arm_big_little.c is also good option; but it
cannot support coupled clock domain for two clusters; furthermore, the
cpufreq driver also need enable cooling cell so that it can support
thermal framework with cpu cooling device.

Do u think it's reasonable to apply upper changes to arm_big_little.c?

3. for the file hisi-acpu-cpufreq.c, actually it's common enough; all
register's related operations have been encapsulated in clk driver;
Especially thinking about now have many SoCs have multi-clusters and
only need change the frequency from clk APIs, do u think it's a good
idea to change this driver to be a common driver?

Thanks,
Leo Yan
