From: Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Thu, 7 Dec 2017 14:51:04 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1712071450001.1176@math.ut.ee>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org> <alpine.LRH.2.21.1712051017060.2774@math.ut.ee> <alpine.LRH.2.21.1712051054170.2774@math.ut.ee>
 <CAJZ5v0henViynygKTRqpYWr6mfm_LJALH6wurNhxM_AXLU4Kzg@mail.gmail.com> <alpine.LRH.2.21.1712062020200.11844@math.ut.ee> <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> On 06-12-17, 20:21, Meelis Roos wrote:
> > 30000 was not reliable.
> > 
> > I created root cron job
> > @reboot sleep 120; /sbin/reboot
> > 
> > and by the evening it was dead again.
> > 
> > Will try 50000 tomorrow.
> 
> Lets make it similar to what it was before my original patch modified
> it, to avoid all corner cases.
> 
> Please test against 200 ms, 200000 value here.

I tried

policy->transition_delay_us = 200000;

and it still hangs on top of mainline.

What next?


-- 
Meelis Roos (mroos@linux.ee)
