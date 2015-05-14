From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Thu, 14 May 2015 14:53:54 +0100
Message-ID: <20150514135353.GY2067@n2100.arm.linux.org.uk>
References: <55520F0F.5010906@free.fr>
 <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr>
 <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr>
 <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55549DEE.6010202@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 14, 2015 at 03:06:54PM +0200, Mason wrote:
> I added a printk inside twd_update_frequency().
> 
> http://lxr.free-electrons.com/source/arch/arm/kernel/smp_twd.c?v=3.14#L107
> 
> I inserted printk("NEW RATE=%lu\n", twd_timer_rate);
> right before the call to clockevents_update_freq().
> 
> When I execute "echo 18500 > scaling_max_freq"
> the system is supposed to change the CPU frequency to 18.5 MHz
> (I might have a bug lurking there) and PERIPHCLK is 1/2 of that,
> i.e 9.25 MHz.
> 
> twd_update_frequency() is called twice: once for each CPU.
> (The timers are local to each CPU.)

That's expected.

I wonder if clockevents_update_freq() is returning an error - which we
don't check, and don't print a warning.  It would probably be a very
good idea to print a warning as a failure to reconfigure the clock
events code for a different frequency will lead to this kind of issue.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
