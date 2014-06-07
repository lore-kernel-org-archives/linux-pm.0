From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] cpufreq: governor: Be friendly towards
 latency-sensitive bursty workloads
Date: Sun, 8 Jun 2014 00:11:46 +0200
Message-ID: <20140607221146.GA28741@amd.pavel.ucw.cz>
References: <20140607204114.25673.87194.stgit@srivatsabhat.in.ibm.com>
 <2855981.L5ysAMpFml@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2855981.L5ysAMpFml@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, viresh.kumar@linaro.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> > the idle time or idle residency; and the high frequency of the CPU when it goes
> > to cpu-idle does not affect/hurt the power-savings of deep idle states).
> > 
> > Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
