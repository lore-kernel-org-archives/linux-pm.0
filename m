From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Wed, 17 Aug 2016 11:43:48 +0800
Message-ID: <20160817034347.GA15682@sharon>
References: <cover.1470908324.git.yu.c.chen@intel.com>
 <20160811185441.GA15813@amd>
 <20160812025225.GA12238@sharon>
 <20160812063312.GD30992@amd>
 <CAJZ5v0jgiPsSV3ZRVeM+D7KD7wJudPD+0Fq0BoJGT1mZ3yryxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16183 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbcHQDfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Aug 2016 23:35:47 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgiPsSV3ZRVeM+D7KD7wJudPD+0Fq0BoJGT1mZ3yryxg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

On Fri, Aug 12, 2016 at 01:25:04PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 12, 2016 at 8:33 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > > Recently we have a new report that, the harddisk can not
> >> > > resume on time due to firmware issues, and got a kernel
> >> > > panic because of DPM watchdog timeout. Since the default
> >> > > timeout has once been modified from 12 to 60 seconds, we
> >> > > might still encounter new case which requires a longer timeout,
> >> > > so expose the value to sysfs and let the users decide which
> >> > > value is appropriate, meanwhile this can also ease the debugging
> >> > > process.
> >> > >
> >> > > The first patch is to force DPM watchdog depending on CONFIG_PM_SLEEP,
> >> > > thus the second patch which does the actual work, can use
> >> > > CONFIG_DPM_WATCHDOG safely without checking CONFIG_PM_SLEEP.
> >> >
> >> > Kernel should just work. User should not have to configure random
> >> > knobs to have working suspend/hibernation.
> >> >
> >> > We do not want "CONFIG_BREAK_SUSPEND" so I believe we don't want
> >> > "CONFIG_DPM_WATCHDOG". If normal users select it and it breaks their
> >> > system, make it depend on "CONFIG_EXPERT" or hide it in some other
> >> > way or maybe remove it from Kconfig altogether.
> >> >
> >> > Or maybe CONFIG_DPM_WATCHDOG should contain numeric value that user
> >> > has to select?
> >> >
> >> Yes, if people select it then they have the risk to break their system,
> >> and the original thought of the patch is to behave like a diagnosis to
> >> make it easier for the users to figure it out, how much time it takes
> >> to suspend/resume a bogus peripheral, without recomping the kernel.
> >> -- currently the timeout value for CONFIG_DPM_WATCHDOG can be adjusted
> >> by menuconfig, but bug reporter might have to recompile the kernel
> >> to confirm, and it takes some time to get a feedback from them, so...
> >
> > Please don't add sysfs knobs for this. People should not need to
> > adjust sysfs files to get working kernel.
> >
> > You can for example make the default 120 seconds.
> 
> Plus, IMO it would be good to be able to disable this thing from the
> kernel command line entirely in case 2 minutes is still too little
> time for somebody.
>
OK, I've modified the patch to the following version, Rafael, Pavel could
you take a glance at it, thanks:
 
Index: linux/kernel/power/Kconfig
===================================================================
--- linux.orig/kernel/power/Kconfig
+++ linux/kernel/power/Kconfig
@@ -197,7 +197,7 @@ config DPM_WATCHDOG
 config DPM_WATCHDOG_TIMEOUT
 	int "Watchdog timeout in seconds"
 	range 1 120
-	default 60
+	default 120
 	depends on DPM_WATCHDOG
 
 config PM_TRACE
Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c
+++ linux/drivers/base/power/main.c
@@ -407,6 +407,8 @@ struct dpm_watchdog {
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
 	struct dpm_watchdog wd
 
+static unsigned long __read_mostly dpm_wd_disabled;
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @data: Watchdog object address.
@@ -434,6 +436,9 @@ static void dpm_watchdog_set(struct dpm_
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (dpm_wd_disabled)
+		return;
+
 	wd->dev = dev;
 	wd->tsk = current;
 
@@ -453,9 +458,20 @@ static void dpm_watchdog_clear(struct dp
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (dpm_wd_disabled)
+		return;
+
 	del_timer_sync(timer);
 	destroy_timer_on_stack(timer);
 }
+
+static int __init no_dpm_wd_setup(char *str)
+{
+	dpm_wd_disabled = 1;
+	return 1;
+}
+__setup("no_dpm_watchdog", no_dpm_wd_setup);
+
 #else
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd)
 #define dpm_watchdog_set(x, y)
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -2749,6 +2749,8 @@ bytes respectively. Such letter suffixes
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
                         soft-lockup and NMI watchdog (hard-lockup).
 
+	no_dpm_watchdog	[KNL] Disable the device suspend/resume watchdog.
+
 	nowb		[ARM]
 
 	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
