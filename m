From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 11:35:57 +0100
Message-ID: <20150515113557.54ef930b@lxorguk.ukuu.org.uk>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150514092251.6d0625af@notabene.brown>
	<20150514235426.GF4316@dastard>
	<3798672.EXej90jOp1@vostro.rjw.lan>
	<CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
	<CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:55459 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbbEOKgX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 06:36:23 -0400
In-Reply-To: <CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, Len Brown <lenb@kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

> > Data loss may be caused for hotplug storage(like USB), or all storage
> > when power is exhausted during suspend.
> 
> Which also may very well happen at run time, right?

Intuitively users treat "suspended" as a bit like off and do remove
devices they've "finished with".

Technically yes the instant off/on on a phone is the same as the suspend
to RAM on a laptop but it doesn't mean the model in people's heads is the
same... not yet anyway.

> > Is there obvious advantage to remove sys_sync() in the case?
> 
> Yes, there is.  It is not necessary to sync() every time you suspend
> if you do that very often.

But if you do it very often you won't have any dirty pages to flush so it
will be very fast.

> And it is done in such a place that everything needs to wait for it to complete.

Only because the code deciding to trigger any automated suspend doesn't
do a sync a few seconds before. In the case the user goes to the menus
and does power->suspend then yes it's a delay. In the case where the OS
at some level has decided that it's 10 seconds from automatically
suspending to something the user space can issue a pre-emptive sync to
get the queue size down.

Alan
