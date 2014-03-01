From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] PM: define new ASSIGN_*_PM_OPS macros based on
 assign_if
Date: Sat, 1 Mar 2014 12:06:33 +0100
Message-ID: <20140301110633.GA27749@amd.pavel.ucw.cz>
References: <1393261707-30565-1-git-send-email-joshc@codeaurora.org>
 <1393261707-30565-3-git-send-email-joshc@codeaurora.org>
 <20140227190219.GB4421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59767 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaCALGg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 06:06:36 -0500
Content-Disposition: inline
In-Reply-To: <20140227190219.GB4421@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Cartwright <joshc@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> > +#define ASSIGN_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> > +	.suspend = assign_if_pm_sleep(suspend_fn), \
> > +	.resume = assign_if_pm_sleep(resume_fn), \
> > +	.freeze = assign_if_pm_sleep(suspend_fn), \
> > +	.thaw = assign_if_pm_sleep(resume_fn), \
> > +	.poweroff = assign_if_pm_sleep(suspend_fn), \
> > +	.restore = assign_if_pm_sleep(resume_fn),
> 
> Ugh, what a mess, really?  Is it that hard to get the #ifdef right in
> the code?  Why not just always define the functions and then also always
> have them in the structures, and if the feature isn't enabled, just
> don't call/use them?

The functions may not compile with CONFIG_PM disabled. (And #ifdefs in
the code are considered ugly).

> Yes, it would cause a _very_ tiny increase in code size if the option is
> disabled, but really, does anyone ever disable those options becides on
> the dreaded 'make randconfig' checkers?

We don't want CONFIG_PM complexity on some embedded systems... and it
is useful tostart with simple (!PM) system when introducing new board.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
