From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Thu, 10 Nov 2016 09:41:50 +0530
Message-ID: <20161110041150.GB11670@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161102045100.GD10786@vireshk-i7>
 <20161110011933.GW16026@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35987 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbcKJELy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 23:11:54 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so138845776pfz.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2016 20:11:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161110011933.GW16026@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 09-11-16, 17:19, Stephen Boyd wrote:
> On 11/02, Viresh Kumar wrote:
> > On 26-10-16, 12:02, Viresh Kumar wrote:
> > > Hi,
> > > 
> > > Some platforms (like TI) have complex DVFS configuration for CPU
> > > devices, where multiple regulators are required to be configured to
> > > change DVFS state of the device. This was explained well by Nishanth
> > > earlier [1].
> > > 
> > > One of the major complaints around multiple regulators case was that the
> > > DT isn't responsible in any way to represent the ordering in which
> > > multiple supplies need to be programmed, before or after frequency
> > > change. It was considered in this patch and such information is left to
> > > the platform specific OPP driver now, which can register its own
> > > opp_set_rate() callback with the OPP core and the OPP core will then
> > > call it during DVFS.
> > > 
> > > The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> > > and code to pass values for multiple regulators and verified that they
> > > are all properly read by the kernel (using debugfs interface).
> > > 
> > > Dave Gerlach has already tested it on the real TI platforms and it works
> > > well for him.
> > > 
> > > This is rebased over: linux-next branch in the PM tree.
> > > 
> > > V2->V3:
> > > - The last patch is new
> > > - Removed a debug leftover pr_info() message
> > > - Renamed few names as s/set_rate/set_opp
> > > - Removed a TODO comment (as it is done now with this series)
> > > - created struct for min_uV and max_uV
> > > - kerneldoc comments for structures in pm_opp.h
> > > - s/const char */const char * const
> > > - use kasprintf()
> > > - Some more minor reformatting
> > > - More Ack/RBY tags added
> > 
> > @Stephen: Can you please provide further comments or Acks ?
> > 
> 
> Where did we end up on the topic of RCU usage in OPP? I'd rather
> we figure that out before investing more time in reviewing code
> that we may end up completely rewriting in the future.

We haven't decided anything on that yet and I don't think there is any reason to
block this series for that. There is lots of existing code that needs to be
updated if we decide to walk that path and I wouldn't mind a small addition to
that from this series.

Lots of effort Coding/testing/reviewing has already gone into this work and we
better get it merged now.

-- 
viresh
