From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 11 May 2015 11:44:28 +1000
Message-ID: <20150511014428.GB15721@dastard>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:5953 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751298AbbEKBpC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2015 21:45:02 -0400
Content-Disposition: inline
In-Reply-To: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, May 08, 2015 at 03:08:43AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Remove sys_sync() from the kernel's suspend flow.
> 
> sys_sync() is extremely expensive in some configurations,
> and so the kernel should not force users to pay this cost
> on every suspend.

Since when? Please explain what your use case is that makes this
so prohibitively expensive it needs to be removed.

> 
> The user-space utilities s2ram and s2disk choose to invoke sync() today.
> A user can invoke suspend directly via /sys/power/state to skip that cost.

So, you want to have s2disk write all the dirty pages in memory to
the suspend image, rather than to the filesystem?

Either way you have to write that dirty data to disk, but if you
write it to the suspend image, it then has to be loaded again on
resume, and then written again to the filesystem the system has
resumed. This doesn't seem very efficient to me....

And, quite frankly, machines fail to resume from suspne dall the
time. e.g. run out of batteries when they are under s2ram
conditions, or s2disk fails because a kernel upgrade was done before
the s2disk and so can't be resumed. With your change, users lose all
the data that was buffered in memory before suspend, whereas right
now it is written to disk and so nothing is lost if the resume from
suspend fails for whatever reason.

IOWs, I can see several good reasons why the sys_sync() needs to
remain in the suspend code. User data safety and filesystem
integrity is far, far more important than a couple of seconds
improvement in suspend speed....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
