From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Thu, 8 Oct 2015 16:05:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510081601520.1284-100000@iolanthe.rowland.org>
References: <5616C87F.5070200@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49869 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758260AbbJHUFf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 16:05:35 -0400
In-Reply-To: <5616C87F.5070200@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Thu, 8 Oct 2015, Grygorii Strashko wrote:

> >>>> @@ -277,9 +304,15 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
> >>>>    
> >>>>    static int really_probe(struct device *dev, struct device_driver *drv)
> >>>>    {
> >>>> -	int ret = 0;
> >>>> +	int ret = -EPROBE_DEFER;
> >>>>    	int local_trigger_count = atomic_read(&deferred_trigger_count);
> >>>>    
> >>>> +	if (defer_all_probes) {
> 
> Will it be ok If I add below comment here?
> 		/*
> 		 * Value of defer_all_probes can be set only by
> 		 * device_defer_all_probes_enable() which, in turn, will call
> 		 * wait_for_device_probe() right after that to avoid any races.
> 		 */

That will help.  You could also add a comment where
wait_for_device_probe is called before device_defer_all_probes_enable,
explaining that is needed.

Alan Stern

