From: Alan Stern <stern@rowland.harvard.edu>
Subject: pm_runtime_barrier breaks autosuspend
Date: Wed, 7 May 2014 11:21:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org>
References: <CAPcyv4h9prfrxmEvVamzCaT9Hc91WR90VO6k2PQa9RkSinAvuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42569 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752087AbaEGPVQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 11:21:16 -0400
In-Reply-To: <CAPcyv4h9prfrxmEvVamzCaT9Hc91WR90VO6k2PQa9RkSinAvuA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>

On Tue, 6 May 2014, Dan Williams wrote:

> > Why didn't pm_request_resume() result in an autosuspend?
> 
> Found it.
> 
> The last thing pm_runtime_barrier() does is pm_runtime_put_noidle()
> which may cause the autosuspend timer to never be reset.

Rafael, this seems like a bug.  Should pm_runtime_barrier() be changed
so that just before the spinlock is released, we queue an autosuspend
request if dev->power.use_autosuspend is set and all the other
conditions are met?

Alan Stern

