From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI thermal: do not always return
 THERMAL_TREND_RAISING for active trip points
Date: Sat, 27 Apr 2013 20:32:30 +0800
Message-ID: <1367065950.2128.11.camel@rzhang1-mobl4>
References: <1366967993-3812-1-git-send-email-rui.zhang@intel.com>
	 <20130427102346.GA30588@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:22552 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab3D0Mcf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 27 Apr 2013 08:32:35 -0400
In-Reply-To: <20130427102346.GA30588@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, eduardo.valentin@ti.com

On Sat, 2013-04-27 at 12:23 +0200, Pavel Machek wrote:
> Hi!
> 
> > Commit 4ae46befb49d4173122e0afa995c4e93d01948a2
> > introduces a regression that the fan is always on
> > even if the system is in idle state.
> > 
> > My original idea in that commit is that:
> > when the current temperature is above the trip point,
> > keep the fan on, even if the temperature is dropping.
> > when the current temperature is below the trip point,
> > turn on the fan when the temperature is raising,
> > turn off the fan when the temperature is dropping.
> 
> Is that even right algoritm?
> 
sorry the changelog is not clear enough here.
I should say,
"keep the fan on when the temperature is raising"
"turn off the fan when the temperature is dropping"

> Assume I'm running at very cold room, lets say -10C. Assume idle CPU
> will hover around 30C with no fan, or hover around 10C with fan
> running, trip point being 50C.
> 
> You _could_ leave fan off until 50C, having silent, passively cooled
> system.
> 
> What it will do instead is annoyingly pulse fan at 10C.
> 
First, fan will never spins on if the temperature never hits 50C.

let's see how ACPI 3.0 fan (just have on and off state) is supposed to
work after overheat.
1. temperature goes above 50C
2. Fan starts to spin.
3. a) if temperature goes higher (if possible), fan keeps on.
   b) if temperature drops, but still above 50C. the fan keeps on.
   c) if temperature drops below 50C, the last temperature is above 50C,
thus the fan is turned off.
   d) if the temperature goes higher again, the fan will not spin on
until the temperature is higher than the trip point (50C) again.

is this behavior what you want?

Thanks,
rui

