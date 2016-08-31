From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Kernel warning in cpufreq_add_dev()
Date: Wed, 31 Aug 2016 03:26 +0200
Message-ID: <1496109.Jd9MGDryNS@vostro.rjw.lan>
References: <20160819110032.GM1041@n2100.armlinux.org.uk> <2310664.2BksGViL4r@vostro.rjw.lan> <20160824131316.GI25143@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57434 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1757337AbcHaBUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 21:20:12 -0400
In-Reply-To: <20160824131316.GI25143@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday, August 24, 2016 06:43:16 PM Viresh Kumar wrote:
> On 22-08-16, 19:32, Rafael J. Wysocki wrote:
> > But it will be called in that path during physical CPU hot-add, won't it?
> 
> What about something like this instead (completely untested) ?

Inline, please?

> @Russell: Can you please try this ??

I was thinking about something similar, but won't the WARN_ON()s in
cpufreq_add/remove_dev_symlink() still trigger, say if there's more
than one CPU in a policy and both happen to be online initially?

Thanks,
Rafael

