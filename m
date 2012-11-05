From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Sun, 4 Nov 2012 20:56:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211042049440.6022-100000@netrider.rowland.org>
References: <1352078237-20622-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:56749 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751035Ab2KEB44 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Nov 2012 20:56:56 -0500
In-Reply-To: <1352078237-20622-1-git-send-email-ying.huang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 5 Nov 2012, Huang Ying wrote:

> In current runtime PM implementation, the active child count of the
> parent device may be decreased if the runtime PM of the child device
> is disabled and forbidden.  For example, to unbind a PCI driver with a
> PCI device, the following code path is possible:
> 
>   pci_device_remove
>     pm_runtime_set_suspended
>       __pm_runtime_set_status
>         atomic_add_unless(&parent->power.child_count, -1, 0)
> 
> That is, the parent device may be suspended, even if the runtime PM of
> child device is forbidden to be suspended.  This violate the rule that
> parent is allowed to be suspended only after all its children are
> suspended, and may cause issue.

This doesn't sound like a correct description of the situation.  The 
rule is not violated.  After pm_runtime_set_suspended runs, the child 
_is_ suspended.  Thus there's no reason not to allow the parent to be 
suspended.

The problem -- if there really is one -- is that a driver can put a 
device into the suspended state by calling pm_runtime_disable followed 
by pm_runtime_set_suspended, even if the usage count is > 0.

I'm not so sure this should count as a problem.  Generally devices 
aren't disabled for runtime PM unless something is wrong.  Under those 
circumstances, the meaning of pm_runtime_forbid isn't very well 
defined.

Alan Stern

