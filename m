From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Make cpufreq_quick_get() safe to call.
Date: Sat, 19 Mar 2016 00:34:46 +0100
Message-ID: <3461345.ttUnIM4Vzr@vostro.rjw.lan>
References: <CAJZ5v0gDkVyHyQ-4YPV5SYz5ppbc+OT6xm-zaAVfMdponS4L8A@mail.gmail.com> <1457685787-6046-1-git-send-email-rcochran@linutronix.de> <20160311235237.GA27500@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62164 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753108AbcCRXcl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 19:32:41 -0400
In-Reply-To: <20160311235237.GA27500@vireshk-mac-ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Richard Cochran <rcochran@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, linux-pm@vger.kernel.org

On Saturday, March 12, 2016 06:52:37 AM Viresh Kumar wrote:
> On 11-03-16, 09:43, Richard Cochran wrote:
> > The function, cpufreq_quick_get, accesses the global 'cpufreq_driver' and
> > its fields without taking the associated lock, cpufreq_driver_lock.
> > 
> > Without the locking, nothing guarantees that 'cpufreq_driver' remains
> > consistent during the call.  This patch fixes the issue by taking the lock
> > before accessing the data structure.
> > 
> > Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> > ---
> >  drivers/cpufreq/cpufreq.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

