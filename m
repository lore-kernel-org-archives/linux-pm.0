From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH] PM / Runtime: Fix the twice judgement in rpm_suspend/resume()
Date: Tue, 15 Jan 2013 10:50:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1301151044560.6514-100000@netrider.rowland.org>
References: <27240C0AC20F114CBF8149A2696CBE4A20400F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:48178 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757174Ab3AOPuU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jan 2013 10:50:20 -0500
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A20400F@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 15 Jan 2013, Liu, Chuansheng wrote:

> > Indeed, this patch introduces a race.  If runtime_status changes from
> > RPM_SUSPENDING and power.wait_queue is signalled in between the test at
> > the end of the loop and the prepare_to_wait() call, the loop will never
> > end.
> Checking the race case, it should not happen?
> Updating runtime_status and wake_up wait_queue are protected by power.lock.
> spin_lock(&power.lock)
> ...
> __update_runtime_status()
> ...
> wake_up_all(&dev->power.wait_queue)
> ...
> spin_unlock(&power.lock)

You're right, the lock prevents this race from happening.

On the other hand, with your change we would end up calling finish_wait()
without calling prepare_to_wait() first.  And as Rafael mentioned, the
current code fits the pattern that people expect to see.

Alan Stern

