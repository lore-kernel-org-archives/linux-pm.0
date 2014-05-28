From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: Performance regression in v3.14
Date: Thu, 29 May 2014 00:53:38 +0800
Message-ID: <20140528165337.GB2296@intel.com>
References: <20140506163559.GA5308@localhost>
 <CAKohpokYEvazxm0-JJXPzq-4OgLXmROfaCMcgHDZwugChOxtsQ@mail.gmail.com>
 <536A3EE9.5050409@intel.com>
 <20140521090051.GO21412@localhost>
 <20140528075945.GA21705@localhost>
 <20140528003540.GA2296@intel.com>
 <002401cf7a8d$fc6d9090$f548b1b0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002401cf7a8d$fc6d9090$f548b1b0$@net>
Sender: cpufreq-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Johan Hovold' <jhovold@gmail.com>, 'Dirk Brandewie' <dirk.brandewie@gmail.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, dirk.j.brandewie@intel.com, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>
List-Id: linux-pm@vger.kernel.org

> That is not true. Yes, and due to the setpoint being less than
> 100, which is needed or the driver won't work at all, there is
> a tendency to drive the target pstate upwards.
> However that is tempered by both the PID proportional gain,
> and ultimately integer math. More importantly, the CPU
> itself tells the driver when it is operating below the target
> pstate and driver responds.
> 
> Additionally, the tendency to drive up the target pstate
> too much is exasperated by some extra rounding up at a
> couple of spots. Dirk has a pending fix.
> 
> > And a few iterations
> > later, we will reach max (possible) frequency,
> > then we are effectively performance governor
> > (highest frequency all the time).
> 
> Please do not confuse highest target pstate with
> highest frequency. They are not the same. The processor
> itself can back off.
> 
Hi Doug,

All you said is about the hardware will not give whatever software wants
(e.g., requested freq too high). Agreed.

But does it matter to this discussion?

Yuyang 
