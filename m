From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] cpufreq: suspend/resume governors with PM notifiers
Date: Wed, 25 Dec 2013 23:39:07 +0100
Message-ID: <20131225223907.GA13593@amd.pavel.ucw.cz>
References: <0e476d16e0ae4b001f5dd4f9ac191f899095928a.1384510171.git.viresh.kumar@linaro.org>
 <2235672.LLJc6e6dny@vostro.rjw.lan>
 <CAKohpok_zjdRVz5-ZGRmZtwysC7jORm2mgRbLWDUzo1ucYVKZg@mail.gmail.com>
 <6050176.zVNbf5pomE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48600 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3LYWjJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Dec 2013 17:39:09 -0500
Content-Disposition: inline
In-Reply-To: <6050176.zVNbf5pomE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Nishanth Menon <nm@ti.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

Hi!

> > > Well, disabling it for the whole duration of suspend/resume and/or hibernation
> > > may not be the right approach entirely, unless we force the pax perf of the
> > 
> > s/pax/max ?
> 
> Yes.

I'm not sure max frequency is a good idea. In particular, early
athlon64 notebooks could not run on max frequency on battery power.

IMO it would be good to keep governors running during hibernation.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
