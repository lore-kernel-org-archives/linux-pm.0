From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Sun, 26 Jan 2014 22:08:50 +0100
Message-ID: <20140126210850.GA7246@Nokia-N900>
References: <ce1b9fc9cdcfd1fe8f9f3b8570421271dc15ae75.1390460951.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35821 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbaAZVI6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jan 2014 16:08:58 -0500
Content-Disposition: inline
In-Reply-To: <ce1b9fc9cdcfd1fe8f9f3b8570421271dc15ae75.1390460951.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

Hi!

> From: Len Brown <len.brown@intel.com>
> 
> Linux suspend-to-RAM was unreliable when first developed,
> and so sys_sync() was invoked inside the kernel at the
> start of every suspend flow.
> 
> Today, many devices are invoking suspend with
> high reliability and high frequency, and they don't
> want to be forced to pay for sync on every suspend.
> 
> So here we make it optional.
> De-select CONFIG_PM_SLEEP_SYNC to delete the call entirely.
> or keep CONFIG_PM_SLEEP and you can now clear the
> sys/power/sleep_sync attribte to disable the sync
> from user-space.

Dunno. Config option plus sysfs attribute is overdoing it a bit.
Maybe we could do

echo memfast > state

to enter suspend without sync? Patch should be simpler that way,
and we won't have to keep the state...

						Pavel
