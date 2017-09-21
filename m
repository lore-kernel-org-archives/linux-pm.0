From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the firmware"
Date: Thu, 21 Sep 2017 16:21:46 +0200
Message-ID: <4036229.gTT6xKEFIS@aspire.rjw.lan>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net> <20170908134920.qia2bdjvpahe3zvi@sig21.net> <20170921094013.hznamkxx5md4yhgf@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170921094013.hznamkxx5md4yhgf@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, September 21, 2017 11:40:13 AM CEST Johannes Stezenbach wrote:
> Hi,
> 
> TL;DR: ACPI 6.1 spec interpretation question:
> 
>   7.2 Declaring a Power Resource Object
>   ...
>   Power resource objects can appear wherever is convenient in the namespace.
>   ...
>   Systemlevel is the deepest system sleep level OSPM must maintain to keep this
>   power resource on (0 equates to S0, 1 equates to S1, and so on).
> 
> Does it imply the OS should turn Power Resources off when changing
> the system level below the systemlevel of the PowerResource?

You can interpret that this way I guess.

However, so far we have not had to deal with "dangling" power resources.

> Otherwise, what purpose do PowerResource objects have that are not
> mentioned in any device _PR[0-3W]?  Or is it BIOS bug?

There also is _RDI that may refer to power resources, but I'm not aware of
anyone using it in practice ATM.

Other than that, I don't see why it would ever be necessary to declare
a power resource that is not pointed to by any of the above.

At least when the "power level" is changing from S0 to anything like S3,
the firmware gets control anyway at one point and then it is free to
manipulate whatever power resources it needs to turn off at that point.

So I would be inclined to think of that as a BIOS issue.

Thanks,
Rafael

