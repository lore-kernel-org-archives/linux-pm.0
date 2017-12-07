From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Thu, 7 Dec 2017 15:03:50 +0530
Message-ID: <20171207093349.ct2hkhqj2d2tzvui@vireshk-mac-ubuntu>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
 <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org>
 <alpine.LRH.2.21.1712051017060.2774@math.ut.ee>
 <alpine.LRH.2.21.1712051054170.2774@math.ut.ee>
 <CAJZ5v0henViynygKTRqpYWr6mfm_LJALH6wurNhxM_AXLU4Kzg@mail.gmail.com>
 <alpine.LRH.2.21.1712062020200.11844@math.ut.ee>
 <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu>
 <alpine.LRH.2.21.1712070925450.25092@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1712070925450.25092@math.ut.ee>
Sender: stable-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07-12-17, 09:26, Meelis Roos wrote:
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
> Sorry, I confused 200000 vs 20000, will test 200000.
> 
> But 200000 was the value before.

It was value of a different variable (transition_latency) at that
time. Just set transition_delay_us in my recent patch as 200,000 and
apply that over mainline.

I will resend the patch in the mean time as well.

> Shall I test 200000 with or without 
> the other limiting patch?

-- 
viresh
