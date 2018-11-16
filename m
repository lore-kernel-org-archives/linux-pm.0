From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Fri, 16 Nov 2018 10:00:33 +0530
Message-ID: <20181116043033.75q3e6wsfi2juryf@vireshk-i7>
References: <20180924151249.32328-1-gregory.clement@bootlin.com>
 <20180924151249.32328-3-gregory.clement@bootlin.com>
 <20181004050624.ecjl3ouczm7huqgg@vireshk-i7>
 <87o9aqwrtj.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87o9aqwrtj.fsf@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Hanna Hawa <hannah@marvell.com>, Omri Itach <omrii@marvell.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 15-11-18, 11:36, Gregory CLEMENT wrote:
>  On jeu., oct. 04 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 24-09-18, 17:12, Gregory CLEMENT wrote:
> >> Add cpufreq driver for Marvell AP-806 found on Aramda 8K.
> >> The AP-806 has DFS (Dynamic Frequency Scaling) with coupled
> >> clock domain for two clusters, so this driver will directly
> >> use generic cpufreq-dt driver as backend.
> >> 
> >> Based on the work of Omri Itach <omrii@marvell.com>.
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  drivers/cpufreq/Kconfig.arm         |  11 +++
> >>  drivers/cpufreq/Makefile            |   1 +
> >>  drivers/cpufreq/armada-8k-cpufreq.c | 148 ++++++++++++++++++++++++++++
> >>  3 files changed, 160 insertions(+)
> >>  create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c
> >> 
> >> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> >> index 0cd8eb76ad59..fd34095743a7 100644
> >> --- a/drivers/cpufreq/Kconfig.arm
> >> +++ b/drivers/cpufreq/Kconfig.arm
> >> @@ -25,6 +25,17 @@ config ARM_ARMADA_37XX_CPUFREQ
> >>  	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
> >>  	  The Armada 37xx PMU supports 4 frequency and VDD levels.
> >>  
> >> +config ARM_ARMADA_8K_CPUFREQ
> >> +	tristate "Armada 8K CPUFreq driver"
> >
> > Since you wanted this to be tristate, have you tried
> >
> > insmod armada-8k-cpufreq.ko
> > rmmod armada-8k-cpufreq.ko
> > insmod armada-8k-cpufreq.ko
> > ?
> 
> Actually the purpose of it is to be able to have the driver available as
> a module. Thanks to this the size kernel image is not increased. Once
> the system is running then we can load the module and have the feature
> but it is true that is no more possible to unload it. However, except
> for developing or debugging, I don't see the real interest to unload
> the driver.

Sure, probably it will never get used that way but I see that as
broken. If you want to have the driver as module, better support
unloading of it as well.

> >> +++ b/drivers/cpufreq/armada-8k-cpufreq.c

> >> +/*
> >> + * Setup the opps list with the divider for the max frequency, that
> >> + * will be filled at runtime, 0 meaning 100Mhz
> >
> > Add a full-stop at the end please.
> 
> I am not sure to understand what you means by a "full-stop": a 0Hz
> frequency?
> 
> But this case should be handle by the CPU idle driver.

I meant '.' by full-stop. I wanted you to add . at the end of the
line, like this:

Setup the opps list with the divider for the max frequency, that
will be filled at runtime, 0 meaning 100Mhz.

> > I am not sure why will you want to support 100 MHz as the CPUs may end
> > up running on that a lot :)
> 
> It should depend of the policy, or am I missing something.

Sure, but with any of the general governors like
ondemand/conservative/schedutil, you will end up running at 100 MHz
when the system doesn't have high load. And 100MHz may be way too
slow.

-- 
viresh
