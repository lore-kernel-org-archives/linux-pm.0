From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Thu, 07 Dec 2017 13:54:44 +0100
Message-ID: <7734929.18g54ABnht@aspire.rjw.lan>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu> <alpine.LRH.2.21.1712071450001.1176@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1712071450001.1176@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 7, 2017 1:51:04 PM CET Meelis Roos wrote:
> > On 06-12-17, 20:21, Meelis Roos wrote:
> > > 30000 was not reliable.
> > > 
> > > I created root cron job
> > > @reboot sleep 120; /sbin/reboot
> > > 
> > > and by the evening it was dead again.
> > > 
> > > Will try 50000 tomorrow.
> > 
> > Lets make it similar to what it was before my original patch modified
> > it, to avoid all corner cases.
> > 
> > Please test against 200 ms, 200000 value here.
> 
> I tried
> 
> policy->transition_delay_us = 200000;
> 
> and it still hangs on top of mainline.
> 
> What next?

Well, please try to revert the commit you bisected the problem to and see
if that doesn't hang.
