From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Fri, 15 May 2015 12:58:53 +0100
Message-ID: <20150515115852.GJ2067@n2100.arm.linux.org.uk>
References: <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr>
 <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk>
 <5555CC1A.5040604@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5555CC1A.5040604@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 15, 2015 at 12:36:10PM +0200, Mason wrote:
> On 15/05/2015 11:51, Russell King - ARM Linux wrote:
> 
> > As you don't say which kernel version you're using,
> 
> Sorry about that, I thought the patch-generating command
> I posted conveyed the information.
> 
> $ git diff v3.14.41 HEAD >tango.patch && xz tango.patch
> 
> I'm using the 3.14.y branch from linux-stable.

So you're using a kernel over a year old...

> > for all we know, you might be using a version which omits some fixes
> > in this area, such as this one which you really must have if your
> > timer is operating in period mode:
> > 
> > fe79a9ba1196 clockevents: Adjust timer interval when frequency changes
> 
> Hmmm, according to git log, this patch was accepted during
> the 3.14-rc2 merge window. Why didn't it make it for 3.14?

No it wasn't:

$ git describe --contains fe79a9ba1196
v3.15-rc1~123^2~12

It was merged during the merge window immediately preceding v3.15-rc1.

> By any chance, is there a patch that would allow the platform
> to get high-resolution timers when using smp_twd?

I think you'll have to do the research for that yourself... what
I can say is that TWD is capable of one-shot mode, and is capable
of running as a high-res timer:

Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   21691754031
 min_delta_ns:   1000
 mult:           425201762
 shift:          31
 mode:           3			<== CLOCK_EVT_MODE_ONESHOT
 next_event:     595603944000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt	<== indicates that it's switched
					to high-res mode
 retries:        0

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
