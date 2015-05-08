From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 8 May 2015 10:34:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505081026250.1219-100000@iolanthe.rowland.org>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59509 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751378AbbEHOeO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 10:34:14 -0400
In-Reply-To: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 8 May 2015, Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Remove sys_sync() from the kernel's suspend flow.
> 
> sys_sync() is extremely expensive in some configurations,
> and so the kernel should not force users to pay this cost
> on every suspend.
> 
> The user-space utilities s2ram and s2disk choose to invoke sync() today.
> A user can invoke suspend directly via /sys/power/state to skip that cost.

I can understand the motivation for this, but is it aimed in the right 
direction?

Consider a system where sys_sync() is very expensive.  Should such a
system be using system suspend in the first place?  If there is a valid
use case, why does the extra overhead of sys_sync() matter?

To put it another way, if the system wants to go into a low-latency
suspend state, why doesn't it use an extreme version of runtime suspend
rather than system suspend?

This reminds me of the discussions we had with the Android developers
when they proposed adding wakelocks to the kernel -- they needed them
so that they could support system suspend when what they really wanted
to do was an extreme version of runtime suspend.  But generally
speaking, sys_sync() is not tremendously expensive on devices running
Android.

Alan Stern

