From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Q: suspend_late() semantics
Date: Sun, 26 Aug 2007 16:23:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708261622130.8531-100000@netrider.rowland.org>
References: <Pine.LNX.4.60.0708260131080.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0708260131080.3809@poirot.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 26 Aug 2007, Guennadi Liakhovetski wrote:

> Hi
> 
> trying to understand when suspend_late gets called, I just wasn't quite 
> sure if I got the following points right:
> 
> 1. seems to be a typo in the comment above 
> drivers/base/power/suspend.c::device_power_down() - the function walks the 
> dpm_off list and not the dpm_off_irq list, as claimed in the comment

Yes, it's a typo.

> 2. in device_suspend() in the same file - this test:
> 
> 		if (!list_empty(&dev->power.entry)) {
> 
> is it to catch concurrent device removal, say, from device_pm_remove()?

Yes.

> Which would mean in normal case every device would be passed to bus_type's 
> suspend_late() if it's implemented?

Yes.

Alan Stern
