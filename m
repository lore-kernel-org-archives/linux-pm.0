From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: error handling in omap_des_hw_init()
Date: Thu, 11 Sep 2014 10:08:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1409111004180.1357-100000@iolanthe.rowland.org>
References: <1410434766.4966.7.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41361 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753831AbaIKOIN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 10:08:13 -0400
In-Reply-To: <1410434766.4966.7.camel@linux-fkkt.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: joelf@ti.com, linux-pm@vger.kernel.org

On Thu, 11 Sep 2014, Oliver Neukum wrote:

> Hi,
> 
> I am checking the error handling of drivers in connection
> with pm_runtime_get() and related functions. It looks
> to me like this driver has a harmful pm_runtime_put_noidle()
> in its error handling path. Usually as a pm operation fails
> it doesn't need to be done undone. Are there special circumstances
> here?

pm_runtime_get_sync() increments the usage counter and then calls
pm_runtime_resume(), returning its result.  So if the
pm_runtime_resume() call fails, you might very well want to decrement
the usage counter again.

Of course, if pm_runtime_resume() fails then there's probably something 
pretty serious going on (like the device has been hot-unplugged), so 
error handling might not matter much.

Alan Stern

