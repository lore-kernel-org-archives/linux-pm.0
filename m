From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 linux-next] cpufreq: ondemand: Calculate gradient of CPU load to early increase frequency
Date: Wed, 03 Apr 2013 00:55:51 +0200
Message-ID: <31773720.6bVyeZQsYt@vostro.rjw.lan>
References: <51253715.7080600@semaphore.gr> <1544183.cq3KaqH8x3@vostro.rjw.lan> <515AFDFA.8090108@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <515AFDFA.8090108@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 02, 2013 06:49:14 PM Stratos Karafotis wrote:
> On 04/02/2013 04:50 PM, Rafael J. Wysocki wrote:
> > Do you have any numbers indicating that this actually makes things better?
> > 
> > Rafael
> 
> No, I don't.
> The expected behaviour after this patch is to "force" max frequency few sampling periods earlier.
> The idea was to increase system responsiveness especially on 'small' embedded systems (phones for example).
> 
> Actually, I thought to provide some numbers but I had no idea how to measure this.
> 
> Would it be enough to provide the number of times that the CPU increases frequency 
> because of early_demand versus the total number of increments?

I think it would be better to check if your approach leads to a better behavior
as far as energy savings are concerned.  If it actually is worse, then I don't
see a reason to apply it.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
