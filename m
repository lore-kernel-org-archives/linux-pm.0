From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC v0 2/9] suspend: Add getter function to report if freezing is active
Date: Mon, 07 Sep 2015 23:44:41 +0200
Message-ID: <1597290.WZUafm8kGW@vostro.rjw.lan>
References: <1441373702-31796-1-git-send-email-daniel.wagner@bmw-carit.de> <1683655.HLd9k04Slu@vostro.rjw.lan> <55ED510F.7090702@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48569 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750897AbbIGVQw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 17:16:52 -0400
In-Reply-To: <55ED510F.7090702@bmw-carit.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Monday, September 07, 2015 10:55:43 AM Daniel Wagner wrote:
> On 09/05/2015 04:11 AM, Rafael J. Wysocki wrote:
> > On Friday, September 04, 2015 03:34:55 PM Daniel Wagner wrote:
> >> Instead encode the FREEZE state via the CPU state we allow the
> >> interesting subsystems (MCE, microcode) to query the power
> >> subsystem directly.
> > 
> > A use case, please.
> 
> The motivation for this change is to reduce the complexity in the
> hotplug code. As tried to point out in the cover letter, the FROZEN
> bits have only a bunch of users after all those years (2007). So it is
> worth to have all the notifier users to handle the FROZEN state?
> 
> Don't know if that counts as use case.

Well, the code you're changing has nothing to do with CPU hotplug and
CPU_TASKS_FROZEN.  It is about suspend-to-idle.

Please grep for suspend_freeze_state and see what it is used for.

There is some confusion in the naming, but that is about the freezing of
the whole system, while CPU_TASKS_FROZEN is about the freezing of user space.

> >> Most notifiers are not interested at all
> >> in this information so rather have explicit calls to freeze_active()
> >> instead adding complexity to the rest of the users of the CPU
> >> notifiers.
> > 
> > Why does it has anything to do with CPU notifiers?
> 
> cpu_{down|up} will call the notifiers with the CPU_TASK_FROZEN bit set
> and so most notifiers are doing
> 
> 	switch (actcion ~CPU_TASK_FROZEN)
> 
> to filter it out because they don't need to handle the system wide
> ongoing freeze operations.
> 
> > We don't offline CPUs for suspend-to-idle.
> 
> Sure. As I said the motivation is to reduce the complexity in the
> hotplug code.

You need to fine a different way to do that.

Thanks,
Rafael

