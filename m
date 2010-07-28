From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Questions about run time power management
Date: Wed, 28 Jul 2010 11:32:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007281124100.1744-100000@iolanthe.rowland.org>
References: <BLU102-W87DD2A0042EBCEDB9C141EBA80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W87DD2A0042EBCEDB9C141EBA80@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 28 Jul 2010, Raj Kumar wrote:

> Hi ALan,
> 
>  
> 
> 1) As you mentioned that -EBUSY code is appropriate, But if the
> 
> device started doing activities during that time then it is not appropriate
> 
> to check every time if device is idle.
> 
>  
> 
> Because if -EBUSY is returned, then workqueue thread will check again and again
> 
> that if the device is idle.
> 
>  
> 
>         if (notify)
>                 __pm_runtime_idle(dev);
> 
> 
> That is notify flag will be true. right?

Yes.  But the thread won't check again and again; it will check only
once.  Your runtime_idle callback will know that the device is busy,
and therefore it won't schedule another suspend on the workqueue.  Not 
until the device really becomes idle again.

> 2) The 2nd thing is use case of deep sleep state i.e. system suspend.
> 
>  
> 
> Suppose device is active and its run time status is active. Now when the system suspend 
> 
> happens, it will increment usage_counter of device in power management framework,
> 
>  
> 
> now at that time since clocks and power are enabled, So what will device do?

It will continue running normally until the driver's suspend callback
is invoked.

> My point is when system suspend comes to device and device is doing activities at that time,
> 
> if the device will ask run time power management to shut its clock off and make it suspended,
> 
>  
> 
> and then it respond to system suspend????

The _device_ doesn't do any of these things; the _driver_ does them.

During system suspend, the driver has to shut off the clock and suspend
the device.  It can't do these things by using runtime PM calls; it has
to do them some other way.

> Run time power management will not do at the time as its usage counter is already increased,
> 
>  
> 
> Right? so what about this use case when this kind of overlapping occurs?

Right.  During system suspend, the driver has to do its job without
using runtime PM.

Alan Stern
