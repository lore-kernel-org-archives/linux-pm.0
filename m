From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: Fix broken builds without CONFIG_PM_SLEEP_DEBUG
Date: Wed, 16 Sep 2015 04:54:22 +0200
Message-ID: <13895814.vlsbGKVKtB@vostro.rjw.lan>
References: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org> <20150916020023.GB29235@linux> <4506267.XG2T0Et70c@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44478 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751272AbbIPC0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 22:26:22 -0400
In-Reply-To: <4506267.XG2T0Et70c@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Wednesday, September 16, 2015 04:48:37 AM Rafael J. Wysocki wrote:
> On Wednesday, September 16, 2015 07:30:23 AM Viresh Kumar wrote:
> > On 16-09-15, 03:43, Rafael J. Wysocki wrote:
> > > On Tuesday, September 15, 2015 01:42:21 PM Viresh Kumar wrote:
> > > > The variable 'wakeup_irq' is defined within #ifdef CONFIG_PM_SLEEP_DEBUG
> > > > and used outside of it. And that breaks kernel build:
> > > > 
> > > > /home/viresh/linux/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> > > > /home/viresh/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> > > > 
> > > > Fix it by defining the variable outside of the ifdef.
> > > > 
> > > > Fixes: d1e59c235322 ("PM / sleep: Report interrupt that caused system wakeup")
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > 
> > > I've applied the v11 of the Alexandra's patch that doesn't have this problem AFAICS.
> > 
> > For the record, as we have talked on IRC, even the v11 patch suffers
> > from this problem and you will be fixing it.
> 
> Yes, it was slightly messed up.  Should be better now, though.

And as a side note, for patches that are in bleeding-edge only and not in
something like linux-next, you don't need to bother anyone with fixes except
for me (and maybe the patch author for their education mostly).

And I either drop patches that cause build problems to happen in bleeding-edge
or fix them.  That's what bleeding-edge is for.

Thanks,
Rafael

