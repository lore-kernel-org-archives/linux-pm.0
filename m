From: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpuidle vs suspend vs something else
Date: Fri, 6 Feb 2015 22:21:09 +0100
Message-ID: <20150206212109.GB25967@amd>
References: <54D43143.2010403@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D43143.2010403@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mturquette@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> I've been reading about related sub-systems (cpuidle and suspend)
> and I'm not sure I understand how they relate / interact.
> 
> If I understand correctly (please do point out any misconceptions)
> on ARM Cortex A9, the first level of power saving is WFI, which is
> typically called from the idle loop.
> 
> This places the core in low-power mode ("Standby mode" in ARM docs).
> "RAM arrays" (don't know what they are), "processor logic", and
> "data engine" (not sure what any of these exactly refers to, guess
> I have more reading to do) are still powered-up, but most of the
> clocks are disabled.
> 
> In ARM's exact words, "WFI and WFE Standby modes disable most of the
> clocks in a processor, while keeping its logic powered up. This reduces
> the power drawn to the static leakage current, leaving a tiny clock
> power overhead requirement to enable the device to wake up."
> 
> Some CPUs like Intel's have several levels of sleep (deeper levels
> mean less power, but have a higher wake-up latency). AFAIU, cpuidle
> is used to describe and manage these levels?
> 
> Isn't suspend somewhat like the deepest level of sleep?
> (Or is it different in that things like RAM state are only a concern
> for suspend, not cpuidle?)

Somewhat.

> Are both subsystems still actively used?

Yes.

Idle is "oh, the computer is not doing anything, it can save power".

Suspend is "I don't want my computer to do anything until I press
power button, save power".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
