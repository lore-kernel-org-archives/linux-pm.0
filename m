From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: Fix broken builds without
 CONFIG_PM_SLEEP_DEBUG
Date: Tue, 15 Sep 2015 13:02:45 +0200
Message-ID: <20150915110244.GA25425@amd>
References: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41437 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbIOLCr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 07:02:47 -0400
Content-Disposition: inline
In-Reply-To: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

On Tue 2015-09-15 13:42:21, Viresh Kumar wrote:
> The variable 'wakeup_irq' is defined within #ifdef CONFIG_PM_SLEEP_DEBUG
> and used outside of it. And that breaks kernel build:
> 
> /home/viresh/linux/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> /home/viresh/drivers/base/power/wakeup.c:871: undefined reference to `wakeup_irq'
> 
> Fix it by defining the variable outside of the ifdef.
> 
> Fixes: d1e59c235322 ("PM / sleep: Report interrupt that caused system wakeup")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
