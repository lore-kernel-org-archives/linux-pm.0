From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Kernel warning in cpufreq_add_dev()
Date: Wed, 31 Aug 2016 09:41:37 +0530
Message-ID: <20160831041137.GE5539@vireshk-i7>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <2310664.2BksGViL4r@vostro.rjw.lan>
 <20160824131316.GI25143@ubuntu>
 <1496109.Jd9MGDryNS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33467 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbcHaEMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 00:12:18 -0400
Received: by mail-pf0-f170.google.com with SMTP id y134so14836119pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2016 21:11:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1496109.Jd9MGDryNS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 31-08-16, 03:26, Rafael J. Wysocki wrote:
> On Wednesday, August 24, 2016 06:43:16 PM Viresh Kumar wrote:
> > On 22-08-16, 19:32, Rafael J. Wysocki wrote:
> > > But it will be called in that path during physical CPU hot-add, won't it?
> > 
> > What about something like this instead (completely untested) ?
> 
> Inline, please?

I am not sure what that means. I pasted that inline in my previous mail only.

> > @Russell: Can you please try this ??
> 
> I was thinking about something similar, but won't the WARN_ON()s in
> cpufreq_add/remove_dev_symlink() still trigger, say if there's more
> than one CPU in a policy and both happen to be online initially?

real CPUs should already be online and their device structure should be
available, isn't it ?

-- 
viresh
