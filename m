From: Mason <slash.tmp@free.fr>
Subject: Re: CPU1 does not come back online after failed suspend request
Date: Fri, 24 Jun 2016 21:21:14 +0200
Message-ID: <576D882A.4030903@free.fr>
References: <576AAEFA.1050509@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:9864 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbcFXTVk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jun 2016 15:21:40 -0400
In-Reply-To: <576AAEFA.1050509@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Sebastian Frias <sf84@laposte.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 22/06/2016 17:30, Mason wrote:

> (I'm using v4.7-rc4)
> 
> My dual-core platform defines the usual hooks:
> 
> static const struct smp_operations tango_smp_ops __initconst = {
> 	.smp_boot_secondary	= tango_boot_secondary,
> 	.cpu_kill		= tango_cpu_kill,
> 	.cpu_die		= tango_cpu_die,
> };
> 
> static const struct platform_suspend_ops tango_pm_ops = {
> 	.enter = tango_pm_enter,
> 	.valid = tango_pm_valid,
> };
> 
> static int tango_pm_powerdown(unsigned long data)
> {
> 	// tango_suspend(virt_to_phys(cpu_resume)); // SHOULD NOT RETURN
> 	printk("DEBUG: %s\n", __func__);
> 	// INSERT ONE SECOND DELAY
> 	return 42;
> }
> 
> static int tango_pm_enter(suspend_state_t state)
> {
> 	printk("DEBUG: %s\n", __func__);
> 	int ret = cpu_suspend(0, tango_pm_powerdown);
> 	printk("DEBUG: cpu_suspend returned %d\n", ret);
> 	return 0;
> }
> 
> I'm trying to test the error path, i.e. when tango_pm_powerdown()
> does in fact return.
> 
> Secondary core off-lining via /sys/devices/system/cpu/cpu1/online
> seems to work as expected:
> 
> # cat /sys/devices/system/cpu/online     
> 0-1
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> [   64.022349] CPU1: shutdown
> [   64.022354] DEBUG: tango_cpu_die
> [   64.028370] DEBUG: tango_cpu_kill
> # cat /sys/devices/system/cpu/online 
> 0
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> [   73.955994] DEBUG: tango_boot_secondary
> # cat /sys/devices/system/cpu/online 
> 0-1
> 
> 
> But the secondary core does not come back online after a failed
> suspend attempt (see below). I tried adding a 1 second delay in
> tango_pm_powerdown() to rule out timing issues.
> 
> # echo mem > /sys/power/state
> [   16.328980] PM: Syncing filesystems ... done.
> [   16.336844] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   16.345421] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   16.354034] Suspending console(s) (use no_console_suspend to debug)
> [   16.362965] PM: suspend of devices complete after 1.764 msecs
> [   16.363870] PM: late suspend of devices complete after 0.896 msecs
> [   16.364519] PM: noirq suspend of devices complete after 0.642 msecs
> [   16.364522] Disabling non-boot CPUs ...
> [   16.382340] CPU1: shutdown
> [   16.382344] DEBUG: tango_cpu_die
> [   16.382346] DEBUG: tango_cpu_kill
> [   16.392635] DEBUG: tango_pm_enter
> [   16.392635] DEBUG: tango_pm_powerdown
> [   16.392635] DEBUG: cpu_suspend returned 42
> [   16.392664] Enabling non-boot CPUs ...
> [   16.412544] DEBUG: tango_boot_secondary
> [   17.411927] CPU1: failed to come online
> [   17.432448] Error taking CPU1 up: -5
> [   17.433034] PM: noirq resume of devices complete after 0.576 msecs
> [   17.433750] PM: early resume of devices complete after 0.688 msecs
> [   17.435121] nb8800 26000.ethernet eth0: Link is Down
> [   17.435301] PM: resume of devices complete after 1.541 msecs
> [   17.516826] Restarting tasks ... done.
> 
> [root@toto5 ~]# cat /sys/devices/system/cpu/online
> 0
> 
> As you can see, cpu1 did not come back online.
> [ 17.411927] CPU1: failed to come online
> [ 17.432448] Error taking CPU1 up: -5
> 
> The other weirdness is that my 1 second delay happens between
> "DEBUG: tango_pm_powerdown" and "DEBUG: cpu_suspend returned 42",
> yet the timestamps for these two lines are identical. Is that
> because that the timestamp variable is not updated deep within
> the suspend framework? (My timer ticks at 27 MHz.)

Any idea if the code flow is different in the two cases?
(Manual offline/online via sysfs vs offline/online by the
suspend framework)

"CPU1: failed to come online" apparently comes from __cpu_up()
http://lxr.free-electrons.com/source/arch/arm/kernel/smp.c#L137

"Error taking CPU1 up: -5" apparently comes from enable_nonboot_cpus()
http://lxr.free-electrons.com/source/kernel/cpu.c#L1110

And -5 is simply -EIO returned from __cpu_up()

Is there any point in testing with v4.6?

Regards.

