From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI thermal: do not always return
 THERMAL_TREND_RAISING for active trip points
Date: Sat, 27 Apr 2013 12:23:47 +0200
Message-ID: <20130427102346.GA30588@amd.pavel.ucw.cz>
References: <1366967993-3812-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366967993-3812-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

Hi!

> Commit 4ae46befb49d4173122e0afa995c4e93d01948a2
> introduces a regression that the fan is always on
> even if the system is in idle state.
> 
> My original idea in that commit is that:
> when the current temperature is above the trip point,
> keep the fan on, even if the temperature is dropping.
> when the current temperature is below the trip point,
> turn on the fan when the temperature is raising,
> turn off the fan when the temperature is dropping.

Is that even right algoritm?

Assume I'm running at very cold room, lets say -10C. Assume idle CPU
will hover around 30C with no fan, or hover around 10C with fan
running, trip point being 50C.

You _could_ leave fan off until 50C, having silent, passively cooled
system.

What it will do instead is annoyingly pulse fan at 10C.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
