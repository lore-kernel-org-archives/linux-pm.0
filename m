From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: convert to smpboot thread
Date: Tue, 12 Apr 2016 10:21:42 +0200
Message-ID: <20160412082141.GB16146@pathway.suse.cz>
References: <1457710701-3014-1-git-send-email-bigeasy@linutronix.de>
 <20160406094735.1bbb3c0c@icelake>
 <570B9CD0.5060904@linutronix.de>
 <20160411081915.585de6c2@icelake>
 <570BCB15.1010702@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37292 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbcDLIVo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Apr 2016 04:21:44 -0400
Content-Disposition: inline
In-Reply-To: <570BCB15.1010702@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, rt@linutronix.de, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Mon 2016-04-11 18:04:37, Sebastian Andrzej Siewior wrote:
> On 04/11/2016 05:19 PM, Jacob Pan wrote:
> >>>> I tried to convert it over to smpboot thread so we don't have that
> >>>> CPU notifier stuff to fire the cpu threads during hotplug events.
> >>>>
> >>> there is another patchset to convert it to kthread worker. any
> >>> advantage of smpboot thread?
> >>> http://comments.gmane.org/gmane.linux.kernel.mm/144964
> >>
> >> It partly does the same thing except you still have your hotplug
> >> notifier which I wanted to get rid off. However it looks better than
> >> before.
> >> If you do prefer the kworker thingy then please switch from CPU_DEAD
> >> to CPU_DOWN_PREPARE (and add CPU_DOWN_FAILED to CPU_ONLINE).
> >> With those changes I should have no further problem with it :)
> >> Any ETA for (either of those patches) upstream?

It depends on some improvements of the kthread worker API. I hope
that we are getting close. I would like to send another iteration
later this week.

Best Regards,
Petr

> > +Petr
> > I do prefer not to keep track of CPU hotplug events. Let me do some
> > testing.
> Okay. Please keep me posted where you stand on this. If you go for the
> kwork series then I will try to make a patch which replaces CPU_DEAD to
> CPU_DOWN_PREPARE in order to make it symmetrical (and from what it
> looks, there is no need to run at CPU_DEAD time).
