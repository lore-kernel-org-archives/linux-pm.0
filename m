From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question on autosuspend vs. system suspend
Date: Sat, 2 Jan 2016 12:26:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1601021215420.29040-100000@netrider.rowland.org>
References: <1451747365.13492.4.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53970 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751743AbcABR0Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2016 12:26:24 -0500
In-Reply-To: <1451747365.13492.4.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pm@vger.kernel.org

On Sat, 2 Jan 2016, Oliver Neukum wrote:

> Hi,
> 
> is there any point during system suspend one can
> be sure that autosuspend mechanisms are deactivated?

There isn't any "autosuspend mechanism" really; autosuspend is just one 
part of the runtime PM facility.

Thus, autosuspend is implemented using a timer and the PM work queue.  
The work queue has the WQ_FREEZABLE flag set, so it won't run at all 
during system suspend and resume.  This means there won't be any 
delayed autosuspends at those times.

On the other hand, if the autosusped delay has already elapsed when
pm_runtime_autosuspend() is called then it will bypass the work queue
and directly start a runtime suspend.  So there may be an undelayed
autosuspend during system suspend.

Alan Stern

