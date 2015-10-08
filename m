From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / sleep: ensure deferred probe workqueue is
 finished in wait_for_device_probe
Date: Thu, 8 Oct 2015 16:53:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510081637570.1284-100000@iolanthe.rowland.org>
References: <2181899.pIHuaJgxyC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49901 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751888AbbJHUxN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 16:53:13 -0400
In-Reply-To: <2181899.pIHuaJgxyC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Thu, 8 Oct 2015, Rafael J. Wysocki wrote:

> > @@ -391,6 +391,10 @@ int driver_probe_done(void)
> >   */
> >  void wait_for_device_probe(void)
> >  {
> > +	/* wait for the deferred probe workqueue to finish */
> > +	if (driver_deferred_probe_enable)
> > +		flush_workqueue(deferred_wq);
> > +
> >  	/* wait for the known devices to complete their probing */
> >  	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
> >  	async_synchronize_full();
> 
> I'm not sure if this is sufficient.
> 
> Something may be added to the workqueue right after you've flushed it and
> then be reporobed after the wait_event() in theory.  Or am I missing anything?

Maybe I'm missing part of this, but I think the point is to make sure 
that every probe which began or was queued before this function got 
called, has finished before the function returns.

Thus, in the case at hand we want to defer all probes starting from
some point in the system sleep transition.  Grygorii sets his
defer_all_probes variable and then calls this function.  It waits for
any probes that were initiated before the function call.  Any probe
that was initiated after the function call (for example, the ones
you're concerned about between the flush_workqueue and wait_event) will
see that defer_all_probes is set and so will defer itself.

Now, I'm not sure what happens when a probe that was deferred tries to 
defer itself again.  Do we end up in an infinite probing loop?  Is
the deferred_wq workqueue freezable?

Alan Stern

