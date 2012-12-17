From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 0/2] clocksource: nomadik-mtu: support timer-based delay
Date: Mon, 17 Dec 2012 12:36:11 +0100
Message-ID: <20121217113611.GA31470@balto.lan>
References: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: John Stultz <johnstul@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

On Tue, Dec 04, 2012 at 11:10:43AM +0100, Fabio Baltieri wrote:
> this implements timer-based delay support for nomadik and ux500
> platforms, using the MTU as time source, and marks the u8500 cpufreq
> driver as CPUFREQ_CONST_LOOPS accordingly.
> 
> The patches are based on Arnd's arm-soc/ux500/mtu-clk branch, as that
> contains latest MTU driver developments, including a driver move/rename,
> but I can rebase if necessary.

The patches applies cleanly on current mainline now, as all dependencies
has already been merged, can this be considered for for merging too?

Also, the nomadik-mtu driver has been moved into drivers/clocksource so
do anybody knows if this this should end up into arm-soc or in the
clocksource tree?

Thanks,
Fabio

> Fabio Baltieri (2):
>   clocksource: nomadik-mtu: support timer-based delay
>   cpufreq: db8500: set CPUFREQ_CONST_LOOPS
> 
>  drivers/clocksource/nomadik-mtu.c | 11 +++++++++++
>  drivers/cpufreq/db8500-cpufreq.c  |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)

-- 
Fabio Baltieri
