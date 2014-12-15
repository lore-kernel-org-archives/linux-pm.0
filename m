From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 22:41:02 +0100
Message-ID: <3353119.0CuA8fKaup@vostro.rjw.lan>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk> <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com> <20141215174336.GJ11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50872 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750814AbaLOVTV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 16:19:21 -0500
In-Reply-To: <20141215174336.GJ11285@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Yadwinder Singh Brar <yadi.brar@samsung.com>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 'Eduardo Valentin' <edubezval@gmail.com>

On Monday, December 15, 2014 05:43:36 PM Russell King - ARM Linux wrote:
> On Mon, Dec 15, 2014 at 08:24:05PM +0530, Yadwinder Singh Brar wrote:
> > > The answer may well be to have finer grained locking here:
> > > 
> > > - one lock to protect cpufreq_dev_list, which is only ever taken when
> > >   adding or removing entries from it
> > > 
> > > - a second lock to protect cpufreq_dev_count and the calls to
> > >   cpufreq_register_notifier() and cpufreq_unregister_notifier()
> > > 
> > > and you would /never/ take either of those two locks inside each other.
> > > In other words:
> > > 
> > > 	mutex_lock(&cooling_list_lock);
> > > 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> > > 	mutex_unlock(&cooling_list_lock);
> > > 
> > > 	mutex_lock(&cooling_cpufreq_lock);
> > > 	if (cpufreq_dev_count++ == 0)
> > > 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> > > 					  CPUFREQ_POLICY_NOTIFIER);
> > > 	mutex_unlock(&cooling_cpufreq_lock);
> > > 
> > > and similar in the cleanup path.  The notifier itself would only ever
> > > take the cooling_list_lock.
> > > 
> > 
> > I agree with this approach, if its fine for others also, I can implement
> > and post patch.
> 
> Yes, please do.

Indeed.  We have a regression here to fix.

Rafael

