From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 13:27:54 +0100
Message-ID: <20150222122754.GA7955@amd>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20150222082654.GB24441@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45291 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbBVM15 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 07:27:57 -0500
Content-Disposition: inline
In-Reply-To: <20150222082654.GB24441@norris-Latitude-E6410>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Chirantan Ekbote <chirantan@chromium.org>

On Sun 2015-02-22 00:26:54, Brian Norris wrote:
> When CONFIG_PM_DEBUG=y, we provide a sysfs file (/sys/power/pm_test) for
> selecting one of a few suspend test modes, where rather than entering a
> full suspend state, the kernel will perform some subset of suspend
> steps, wait 5 seconds, and then resume back to normal operation.
> 
> This mode is useful for (among other things) observing the state of the
> system just before entering a sleep mode, for debugging or analysis
> purposes. However, a constant 5 second wait is not sufficient for some
> sorts of analysis; for example, on an SoC, one might want to use
> external tools to probe the power states of various on-chip controllers
> or clocks.
> 
> This patch turns this 5 second delay into a configurable module
> parameter, so users can determine how long to wait in this
> pseudo-suspend state before resuming the system.
> 
> Example (wait 30 seconds);
> 
>   # echo 30 > /sys/module/suspend/parameters/pm_test_delay
>   # echo core > /sys/power/pm_test
>   # time echo mem  > /sys/power/state
>   ...
>   [   17.583625] suspend debug: Waiting for 30 second(s).
>   ...
>   real	0m30.381s
>   user	0m0.017s
>   sys	0m0.080s
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

(Does this need documentation in kernel-parameters.txt or in place
where pm_test is documented?)

Thanks,
								Pavel
								

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
