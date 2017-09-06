From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the
 firmware"
Date: Wed, 6 Sep 2017 16:02:10 -0500
Message-ID: <5bb7e3ca-38fc-1184-3bca-f666275c6180@linux.intel.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-pm@vger.kernel.org

On 9/6/17 3:42 PM, Johannes Stezenbach wrote:
> Hi,
> 
> I'm poking around on Asus E200HA, based on Atom x5-Z8300 (Cherrytrail),
> trying to get S0ix working, atm with gross hacks that are recorded in
> https://bugzilla.kernel.org/show_bug.cgi?id=193891
> 
> 
> I found commit d31fd43c0f9a4 "clk: x86: Do not gate clocks enabled by the firmware"
> prevents S0i3 entry.  Unfortunately the commit message doesn't explain
> the problem it fixes, nor does it mention the platform.
> 
> How can we fix d31fd43c0f9a4 to not break S0i3?

In the existing audio machine drivers, I only use the clock framework 
for Baytrail. on Cherrytrail, the pmc_platform_clk3 used for the audio 
MCLK is actually managed by the BIOS (look for CLK3 in the DSDT) so 
there is no activity in the drivers, the audio don't even 
get/prepare/enable the pmc_platform_clk3 so I would guess there is an 
issue with a non-audio driver or the BIOS. Put differently, it may be so 
that by allowing the drivers to gate an unused clock we allowed you to 
enter S0i3 even if the bios didn't enable this mode. I would remove all 
pmc-clock related stuff and see what happens.
