From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 03/10] freezer: add new freezable helpers using freezer_do_not_count()
Date: Thu, 02 May 2013 15:05:13 +0200
Message-ID: <4717747.DX2SLP8TIR@linux-5eaq.site>
References: <1367271946-7239-1-git-send-email-ccross@android.com> <1367271946-7239-4-git-send-email-ccross@android.com> <20130502124826.GE22618@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45389 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867Ab3EBNEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 May 2013 09:04:20 -0400
In-Reply-To: <20130502124826.GE22618@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Colin Cross <ccross@android.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Len Brown <len.brown@intel.com>

On Thursday 02 May 2013 14:48:26 Pavel Machek wrote:
> On Mon 2013-04-29 14:45:39, Colin Cross wrote:
> > Freezing tasks will wake up almost every userspace task from
> > where it is blocking and force it to run until it hits a
> > call to try_to_sleep(), generally on the exit path from the syscall
> > it is blocking in.  On resume each task will run again, usually
> > restarting the syscall and running until it hits the same
> > blocking call as it was originally blocked in.
> 
> Ok, so you are optimizing suspend at the cost of runtime operations,
> right?
> 
> Would it make sense to do suspends entirely without freezer in your
> configurations? With the right drivers, it should work ok.

Right now drivers now that they will not be busy when runtime
suspend happens. The freezer has the same effect for system PM.
If you remove that certainty it becomes impossible for simple drivers
to declare their devices busy upon open and do no synchronization
between IO and PM.

	Regards
		Oliver

