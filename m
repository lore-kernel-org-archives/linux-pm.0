From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable
 for synchronization
Date: Tue, 8 Dec 2015 20:26:58 +0530
Message-ID: <20151208145658.GG3692@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <10138182.WjU9yqx6Gs@vostro.rjw.lan>
 <20151208135518.GE3692@ubuntu>
 <1843141.WbisoTkq1u@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1843141.WbisoTkq1u@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-12-15, 15:30, Rafael J. Wysocki wrote:
> It doesn't look nice, but then having a lockless timer function is worth
> it in my view.
> 
> The code in gov_cancel_work() runs relatively rarely, but the timer
> function can run very often, so avoiding the lock in there is a priority
> to me.
> 
> Plus we can avoid disabling interrupts in two places this way.

Okay, that's good enough then. I hope you will be sending these
patches now, right? And ofcourse, we need documentation in this case
as well.

-- 
viresh
