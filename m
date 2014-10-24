From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Date: Fri, 24 Oct 2014 15:01:33 +0200
Message-ID: <6125598.IRePQWE45T@vostro.rjw.lan>
References: <48734362.lRa73hezrZ@vostro.rjw.lan> <alpine.DEB.2.10.1410241428050.30449@ayla.of.borg> <1414154351.6267.6.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414154351.6267.6.camel@pengutronix.de>
Sender: linux-sh-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, October 24, 2014 02:39:11 PM Lucas Stach wrote:
> Am Freitag, den 24.10.2014, 14:30 +0200 schrieb Geert Uytterhoeven:
> > 	Hi Lucas,
> > 
> > On Fri, 24 Oct 2014, Lucas Stach wrote:
> > > Am Donnerstag, den 23.10.2014, 16:43 +0200 schrieb Geert Uytterhoeven:
> > > > On Thu, Oct 23, 2014 at 4:10 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > > Am Donnerstag, den 23.10.2014, 11:19 +0200 schrieb Geert Uytterhoeven:
> > > > >> On Tue, Oct 21, 2014 at 4:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >> > On Thursday, October 16, 2014 12:08:20 PM Lucas Stach wrote:
> > > > >> >> If the regulator connected to the CPU voltage plane doesn't
> > > > >> >> support an OPP specified voltage with the acceptable tolerance
> > > > >> >> it's better to just disable the OPP instead of constantly
> > > > >> >> failing the voltage scaling later on.
> > > > >> >>
> > > > >> >> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > >> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > >> >
> > > > >> > Applied, thanks!
> > > > >>
> > > > >> This commit
> > > > >> (http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=d7bbd4cd0359d781b67c9e621d4bbfd1bb2f3783)
> > > > >> causes a boot regression on r8a7791/koelsch. It hangs after:
> > > > >>
> > > > >>     TCP: cubic registered
> > > > >>     Initializing XFRM netlink socket
> > > > >>     NET: Registered protocol family 17
> > > > >>     NET: Registered protocol family 15
> > > > >>     ata1: link resume succeeded after 1 retries
> > > > >>     ata1: SATA link down (SStatus 0 SControl 300)
> > > > >>     random: nonblocking pool is initialized
> > > > 
> > > > >> Reverting this commit fixes the issue, and makes the boot continue with:
> > > > >>
> > > > >>     cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 1300000 KHz
> > > > >>     cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
> > > > >> changed to: 1312500 KHz
> > > > >>     cpu cpu1: failed to get cpu-2 clock: 1
> > > > >>     cpufreq_dt: cpufreq_init: Failed to allocate resources: -2
> > > 
> > > I thought a bit more about about this to make sure this isn't a fault on
> > > my side, but can't seem to make any sense out of this. Can you please
> > > print out the value of opp_freq in each iteration of the while loop and
> > > also the return value of regulator_is_supported_voltage()? This would
> > > help me a lot to understand what's happening here.
> > 
> > It gets into an infinite loop doing:
> > 
> >     cpufreq_dt: cpufreq_init:232: opp_freq = 0
> >     cpufreq_dt: cpufreq_init:240: opp_freq = 375000000
> >     cpufreq_dt: cpufreq_init:247: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:258: opp_freq = 375000001
> >     ...
> > 
> > The loop is only aborted if dev_pm_opp_find_freq_ceil() returns an error,
> > but that never happens.
> > 
> > I think it should try the next frequency on each subsequent iteration, right?
> > So I came up with the fix below. After that it behaves better:
> > 
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 0
> >     cpufreq_dt: cpufreq_init:241: opp_freq = 375000000
> >     cpufreq_dt: cpufreq_init:248: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:259: opp_freq = 375000001
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 375000001
> >     cpufreq_dt: cpufreq_init:241: opp_freq = 750000000
> >     cpufreq_dt: cpufreq_init:248: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:259: opp_freq = 750000001
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 750000001
> >     cpufreq_dt: cpufreq_init:241: opp_freq = 937500000
> >     cpufreq_dt: cpufreq_init:248: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:259: opp_freq = 937500001
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 937500001
> >     cpufreq_dt: cpufreq_init:241: opp_freq = 1125000000
> >     cpufreq_dt: cpufreq_init:248: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:259: opp_freq = 1125000001
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 1125000001
> >     cpufreq_dt: cpufreq_init:241: opp_freq = 1312500000
> >     cpufreq_dt: cpufreq_init:248: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:259: opp_freq = 1312500001
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 1312500001
> >     cpufreq_dt: cpufreq_init:241: opp_freq = 1500000000
> >     cpufreq_dt: cpufreq_init:248: [ 1000000, 1010000 ] is supported
> >     cpufreq_dt: cpufreq_init:259: opp_freq = 1500000001
> >     cpufreq_dt: cpufreq_init:233: opp_freq = 1500000001
> >     cpufreq_dt: cpufreq_init:237: Error -34 => break
> > 
> > From e5f401eee8b316587fc385cac7acdd92b33adec7 Mon Sep 17 00:00:00 2001
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Date: Fri, 24 Oct 2014 14:23:14 +0200
> > Subject: [PATCH] cpufreq: dt: Don't reset opp_freq in subsequent loop
> >  iterations
> > 
> > opp_freq is incremented at the end of the loop, to find the next
> > supported frequency, but this is overturned by its re-initialization
> > in next iteration, causing an infinite loop.
> > 
> > Move the initialization of opp_freq outside the loop to fix this.
> > 
> > Fixes: d7bbd4cd0359d781 ("cpufreq: dt: disable unsupported OPPs")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index f6e39a2e324ffc87..2f25958053778ad1 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -219,6 +219,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  		transition_latency = CPUFREQ_ETERNAL;
> >  
> >  	if (!IS_ERR(cpu_reg)) {
> > +		unsigned long opp_freq = 0;
> > +
> >  		/*
> >  		 * Disable any OPPs where the connected regulator isn't able to
> >  		 * provide the specified voltage and record minimum and maximum
> > @@ -226,7 +228,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  		 */
> >  		while (1) {
> >  			struct dev_pm_opp *opp;
> > -			unsigned long opp_freq = 0, opp_uV, tol_uV;
> > +			unsigned long opp_uV, tol_uV;
> >  
> >  			rcu_read_lock();
> >  			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
> 
> *puts on brown paper bag*
> 
> Right, the fixed behavior with your patch was clearly the intention,
> which may be the cause it didn't see when staring at the code.
> I remember moving the variable initialization at one point, but somehow
> this slipped through my testing. Thanks for hunting it down.
> 
> Rafael, how do we handle this? Are you going to reapply the patch
> together with this fix, or want me to send an updated version with this
> fix included?

An update, please.  Plus say in the changelog that this includes a fix from
Geert.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
