From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Wed, 26 Jul 2017 02:17:15 +0200
Message-ID: <4051208.gOcJRl3Z1H@aspire.rjw.lan>
References: <20170721121403.31202-1-waldemarx.rymarkiewicz@intel.com> <10881593.7egIBYKlCz@aspire.rjw.lan> <CAHKzcEONE7CUyqdQC5X45S9oWLa9iEbyVd4gpgiYBuU4vQeKUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50701 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751011AbdGZAZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 20:25:14 -0400
In-Reply-To: <CAHKzcEONE7CUyqdQC5X45S9oWLa9iEbyVd4gpgiYBuU4vQeKUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, WaldemarRymarkiewiczwaldemar.rymarkiewicz@gmail.com, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On Tuesday, July 25, 2017 10:09:42 AM Waldemar Rymarkiewicz wrote:
> On 24 July 2017 at 23:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, July 24, 2017 02:17:13 PM Viresh Kumar wrote:
> >> On 21-07-17, 14:13, Waldemar Rymarkiewicz wrote:
> >> > We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
> >> > exist. This can happen on platforms where not all possible CPUs are
> >> > available at start up ie. hotplugged out. Cpu device is not registered in
> >> > the system so we are not able to check struct device to set the sharing
> >> > CPUs bitmask properly.
> >> >
> >> > Example (real use case):
> >> > 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> >> > for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
> >> > due to the fact there is no struct device for cpu1 (remains offline at
> >> > bootup).
> >> >
> >> > To solve the bug, stop using device struct to check device_node. Instead
> >> > get cpu device_node directly from device tree with of_get_cpu_node().
> >> >
> >> > Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> >> > ---
> >> >  drivers/base/power/opp/of.c | 28 +++++++++++++++++-----------
> >> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > I've lost track of this, care to resend?
> 
> I've resent v3.

Well, I'm not seeing it in any of my mailboxes.

Have you CCed it to the mailing lists?
