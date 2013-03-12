From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: fix pm_test support for freeze state
Date: Tue, 12 Mar 2013 01:13:19 +0100
Message-ID: <7844236.DBZj6jqABo@vostro.rjw.lan>
References: <1362720530.2734.4.camel@rzhang1-mobl4> <4494336.ukGySZsUdo@vostro.rjw.lan> <1363046595.2291.95.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53034 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284Ab3CLAGR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 20:06:17 -0400
In-Reply-To: <1363046595.2291.95.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On Tuesday, March 12, 2013 08:03:15 AM Zhang Rui wrote:
> On Tue, 2013-03-12 at 00:58 +0100, Rafael J. Wysocki wrote:
> > On Friday, March 08, 2013 01:28:50 PM Zhang Rui wrote:
> > > From d6e5d4f4e8b9a8af79fa50d8e13b14c89d8a9264 Mon Sep 17 00:00:00 2001
> > > From: Zhang Rui <rui.zhang@intel.com>
> > > Date: Wed, 6 Mar 2013 21:22:21 +0800
> > > Subject: [PATCH] PM: fix pm_test support for freeze state
> > > 
> > > freeze state is a software suspend state that does not run into
> > > low-level platform callbacks which may interact with BIOS.
> > > And freeze state does not need to disable the processors.
> > > Thus we should disable TEST_CPUS and TEST_CORE mode
> > > when running pm_test for freeze state.
> > > 
> > > Fix the problem so that users will get a warning message and fail to
> > > enter freeze state, when pm_test mode is set to TEST_CPUS/TEST_CORE.
> > > 
> > > Plus, change the code so that freeze_enter() is invoked after
> > > suspend_test(TEST_PLATFORM) being invoked, then pm_test can be used to
> > > check if freeze state is working well after all devices are suspended
> > > and before processors are blocked.
> > 
> > Can you please do one change per patch? 
> 
> okay. will do that.
> 
> >  The second change is not related
> > to the first one
> 
> right.
> 
> >  and I don't think it is correct event.
> > 
> hmmm,
> do you mean two changes in one patch is wrong or do you mean the code
> for the second change is wrong?

I thought that the second change code wasn't correct, but I seem to have
confused things.

Please split it off, though.

Thanks,
Rafael


> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  kernel/power/suspend.c |   18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > index d4feda0..e29909a 100644
> > > --- a/kernel/power/suspend.c
> > > +++ b/kernel/power/suspend.c
> > > @@ -76,8 +76,16 @@ EXPORT_SYMBOL_GPL(suspend_set_ops);
> > >  
> > >  bool valid_state(suspend_state_t state)
> > >  {
> > > -	if (state == PM_SUSPEND_FREEZE)
> > > -		return true;
> > > +	if (state == PM_SUSPEND_FREEZE) {
> > > +		if (pm_test_level == TEST_NONE ||
> > > +		    pm_test_level == TEST_FREEZER ||
> > > +		    pm_test_level == TEST_DEVICES ||
> > > +		    pm_test_level == TEST_PLATFORM)
> > > +			return true;
> > > +		printk(KERN_WARNING "Unsupported pm_test mode for freeze state,"
> > > +			" please choose none/freezer/devices/platform.\n");
> > > +		return false;
> > > +	}
> > >  	/*
> > >  	 * PM_SUSPEND_STANDBY and PM_SUSPEND_MEMORY states need lowlevel
> > >  	 * support and need to be valid to the lowlevel
> > > @@ -184,6 +192,9 @@ static int suspend_enter(suspend_state_t state, bool
> > > *wakeup)
> > >  			goto Platform_wake;
> > >  	}
> > >  
> > > +	if (suspend_test(TEST_PLATFORM))
> > > +		goto Platform_wake;
> > > +
> > >  	/*
> > >  	 * PM_SUSPEND_FREEZE equals
> > >  	 * frozen processes + suspended devices + idle processors.
> > > @@ -195,9 +206,6 @@ static int suspend_enter(suspend_state_t state, bool
> > > *wakeup)
> > >  		goto Platform_wake;
> > >  	}
> > >  
> > > -	if (suspend_test(TEST_PLATFORM))
> > > -		goto Platform_wake;
> > > -
> > >  	error = disable_nonboot_cpus();
> > >  	if (error || suspend_test(TEST_CPUS))
> > >  		goto Enable_cpus;
> > > 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
