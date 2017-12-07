From: Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Thu, 7 Dec 2017 07:14:53 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1712070714190.11844@math.ut.ee>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org> <alpine.LRH.2.21.1712051017060.2774@math.ut.ee> <alpine.LRH.2.21.1712051054170.2774@math.ut.ee>
 <CAJZ5v0henViynygKTRqpYWr6mfm_LJALH6wurNhxM_AXLU4Kzg@mail.gmail.com> <alpine.LRH.2.21.1712062020200.11844@math.ut.ee> <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:46565 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdLGFO6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Dec 2017 00:14:58 -0500
In-Reply-To: <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

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

20000 was the first one tested, after it was unreliable, I tested 30000 
and that was unreliable too.

-- 
Meelis Roos (mroos@linux.ee)
