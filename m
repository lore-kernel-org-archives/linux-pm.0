From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / sleep: Fix broken builds without
 CONFIG_PM_SLEEP_DEBUG
Date: Wed, 16 Sep 2015 07:30:23 +0530
Message-ID: <20150916020023.GB29235@linux>
References: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
 <4171587.Rkb7nBLebe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4171587.Rkb7nBLebe@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 16-09-15, 03:43, Rafael J. Wysocki wrote:
> On Tuesday, September 15, 2015 01:42:21 PM Viresh Kumar wrote:
> > The variable 'wakeup_irq' is defined within #ifdef CONFIG_PM_SLEEP_DEBUG
> > and used outside of it. And that breaks kernel build:
> > 
> > /home/viresh/linux/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> > /home/viresh/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> > 
> > Fix it by defining the variable outside of the ifdef.
> > 
> > Fixes: d1e59c235322 ("PM / sleep: Report interrupt that caused system wakeup")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I've applied the v11 of the Alexandra's patch that doesn't have this problem AFAICS.

For the record, as we have talked on IRC, even the v11 patch suffers
from this problem and you will be fixing it.

-- 
viresh
