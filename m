From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] kernel/power/autosleep.c: check for pm_suspend()
 return before queueing suspend again
Date: Mon, 29 Jun 2015 11:21:00 +0200
Message-ID: <20150629092100.GA7617@amd>
References: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59130 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbbF2JVD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 05:21:03 -0400
Content-Disposition: inline
In-Reply-To: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nitish Ambastha <nitish.a@samsung.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com, nits.ambastha@gmail.com

On Mon 2015-06-29 18:04:57, Nitish Ambastha wrote:
> Prevent tight loop for suspend-resume when some
> devices failed to suspend
> If some devices failed to suspend, we monitor this
> error in try_to_suspend(). pm_suspend() is already
> an 'int' returning function, how about checking return
> from pm_suspend() before queueing suspend again?
> 
> For devices which do not register for pending events,
> this will prevent tight loop for suspend-resume in
> suspend abort scenarios due to device suspend failures

Umm. I guess code could be rearranged so that wait entry is shared
with the already existing case?

Plus, I don't think "INFO" is right log level for failure...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
