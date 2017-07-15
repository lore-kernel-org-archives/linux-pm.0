From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 14:17:21 +0200
Message-ID: <5864280.u6UQBsuXnA@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net> <2497538.J9F6XFeBfd@aspire.rjw.lan> <20170715062838.GA20741@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57246 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751183AbdGOMZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 08:25:10 -0400
In-Reply-To: <20170715062838.GA20741@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Saturday, July 15, 2017 08:28:38 AM Pavel Machek wrote:
> On Sat 2017-07-15 00:16:16, Rafael J. Wysocki wrote:
> > On Wednesday, July 12, 2017 11:08:19 AM Florian Fainelli wrote:
> > > On 06/29/2017 04:00 PM, Rafael J. Wysocki wrote:
> > > > On Thursday, June 22, 2017 06:08:36 PM Florian Fainelli wrote:
> > > >> Add an optional platform_suspend_ops callback: target_state, and a
> > > >> helper function globally visible to get this called:
> > > >> platform_suspend_target_state().
> > > >>
> > > >> This is useful for platform specific drivers that may need to take a
> > > >> slightly different suspend/resume path based on the system's
> > > >> suspend/resume state being entered.
> > > >>
> > > >> Although this callback is optional and documented as such, it requires
> > > >> a platform_suspend_ops::begin callback to be implemented in order to
> > > >> provide an accurate suspend/resume state within the driver that
> > > >> implements this platform_suspend_ops.
> > > >>
> > > >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > >> ---
> > > >>  include/linux/suspend.h | 12 ++++++++++++
> > > >>  kernel/power/suspend.c  | 15 +++++++++++++++
> > > >>  2 files changed, 27 insertions(+)
> > > >>
> > > >> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > >> index d9718378a8be..d998a04a90a2 100644
> > > >> --- a/include/linux/suspend.h
> > > >> +++ b/include/linux/suspend.h
> > > >> @@ -172,6 +172,15 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
> > > >>   *	Called by the PM core if the suspending of devices fails.
> > > >>   *	This callback is optional and should only be implemented by platforms
> > > >>   *	which require special recovery actions in that situation.
> > > >> + *
> > > >> + * @target_state: Returns the suspend state the suspend_ops will be entering.
> > > >> + * 	Called by device drivers that need to know the platform specific suspend
> > > >> + * 	state the system is about to enter.
> > > >> + * 	This callback is optional and should only be implemented by platforms
> > > >> + * 	which require special handling of power management states within
> > > >> + * 	drivers. It does require @begin to be implemented to provide the suspend
> > > >> + * 	state. Return value is platform_suspend_ops specific, and may be a 1:1
> > > >> + * 	mapping to suspend_state_t when relevant.
> > > >>   */
> > > >>  struct platform_suspend_ops {
> > > >>  	int (*valid)(suspend_state_t state);
> > > >> @@ -184,6 +193,7 @@ struct platform_suspend_ops {
> > > >>  	bool (*suspend_again)(void);
> > > >>  	void (*end)(void);
> > > >>  	void (*recover)(void);
> > > >> +	int (*target_state)(void);
> > > > 
> > > > I would use unsigned int (the sign should not matter).
> > > > 
> > > >>  };
> > > > 
> > > > That's almost what I was thinking about except that the values returned by
> > > > ->target_state should be unique, so it would be good to do something to
> > > > ensure that.
> > > > 
> > > > The concern is as follows.
> > > > 
> > > > Say you have a driver develped for platform X where ->target_state returns
> > > > A for "mem" and B for "standby".  Then, the same IP is re-used on platform Y
> > > > returning B for "mem" and C for "standby" and now the driver cannot
> > > > distinguish between them.
> > > > 
> > > > Moreover, even if they both returned A for "mem" there might be differences
> > > > in how "mem" was defined by each of them and therefore in what the driver was
> > > > expected to do to handle "mem" on X and Y.
> > > 
> > > That makes sense, would you need the core implementation in
> > > platform_suspend_target_state() to range check what
> > > suspend_ops->target_state() returns against a set of reserved value say,
> > > checking from 0 up to ACPI_S_STATE_COUNT or is there another range you
> > > would like to see being used?
> > 
> > I had an idea of using an enum type encompassing all of the power states
> > defined for various platforms and serving both as a registry (to ensure the
> > uniqueness of the values assigned to the states) and a common ground
> > between platforms and drivers.
> > 
> > Something like:
> > 
> > enum platform_target_state {
> > 	PLATFORM_STATE_UNKNOWN = -1,
> > 	PLATFORM_STATE_WORKING = 0,
> > 	PLATFORM_STATE_ACPI_S1,
> > 	PLATFORM_STATE_ACPI_S2,
> > 	PLATFORM_STATE_ACPI_S3,
> > 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
> > 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
> > 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
> > 	...
> > };
> > 
> > and define ->target_state to return a value of this type.
> > 
> > Then, if a driver sees one of these and recognizes that value, it should
> > know exactly what to do.
> 
> Remind me why this is good idea?

Because there are drivers that need to do specific things during
suspend on a specific board when it goes into a specific state as a whole.

> We currently have 1364+ boards in tree. That will be rather large
> enum.

Fortunately enough, only some of the platform states need to be listed here,
the ones that drivers need to find out about.

The vast majority of drivers do the same thing regardless of the target state
of the platform.

> If board wants to know if certain regulator stays online during
> suspend, it should invent an API for _that_.

Ideally, yes.  However, that may be problematic for multiplatform kernels,
because they would need to have all of those APIs built in and the driver
code to figure out which API to use would be rather nasty.

Thanks,
Rafael
