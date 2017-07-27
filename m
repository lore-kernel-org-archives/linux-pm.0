From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Thu, 27 Jul 2017 13:01:50 +0530
Message-ID: <20170727073150.GN352@vireshk-i7>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
 <2684007.FU6l9NfBCM@aspire.rjw.lan>
 <CAHKzcENdNdfsMmcQe_ET25JSY97dOrq5RkSK_Gpa-pKdFNx_Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34419 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbdG0Hby (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 03:31:54 -0400
Received: by mail-pg0-f42.google.com with SMTP id 123so94530939pgj.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 00:31:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHKzcENdNdfsMmcQe_ET25JSY97dOrq5RkSK_Gpa-pKdFNx_Pw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 27-07-17, 09:25, Waldemar Rymarkiewicz wrote:
> On 27 July 2017 at 02:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, July 26, 2017 02:11:38 PM Waldemar Rymarkiewicz wrote:
> >> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
> >> exist. This can happen on platforms where not all possible CPUs are
> >> available at start up ie. hotplugged out. Cpu device is not registered in
> >> the system so we are not able to check struct device to set the sharing
> >> CPUs bitmask properly.
> >>
> >> Example (real use case):
> >> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> >> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
> >> due to the fact there is no struct device for cpu1 (remains offline at
> >> bootup).
> >>
> >> To solve the bug, stop using device struct to check device_node. Instead
> >> get cpu device_node directly from device tree with of_get_cpu_node().
> >>
> >> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> >
> > Please fix the build issue reported by 0-day introduced by this patch.
> 
> Where can I find the report? I did not receive anything.

It was sent to your email id:
Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>

Here is the link:

http://marc.info/?l=linux-pm&m=150110740706429&w=2

-- 
viresh
