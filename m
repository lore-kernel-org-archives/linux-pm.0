From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Disable suspend on a specific device] This is a
 little change in linux power scheme
Date: Wed, 08 Apr 2009 23:25:57 +0200
Message-ID: <49DD1665.5020205@gandalf.sssup.it>
References: <Pine.LNX.4.44L0.0904081607580.3138-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0904081607580.3138-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> On Tue, 7 Apr 2009, Rafael J. Wysocki wrote:
>
>   
>> Well, in fact I wanted to know your opinion about this patch. :-)
>>     
>
> Clearly this patch isn't appropriate for regular desktop or laptop 
> systems.  I'm not so sure it's the best approach for embedded systems 
> either.
>
> Part of the problem is the set of devices which would remain 
> unsuspended: the device for which the flag is set plus everything below 
> it in the device tree.  This goes against the way the kernel has 
> behaved up to now, which is that a device may not be suspended before 
> all its children are suspended.
>
> In addition, the patch appears to ignore issues involving clock and
> voltage domains.  These things often are not reflected directly in the 
> structure of the device tree.
>
> At a more fundamental level, this change points out a real weakness in
> the way suspend is currently implemented.  From the PM core's point of
> view, system suspend involves two main activities:
>
> 	Telling drivers to stop using their devices, and
>
> 	Turning off (or reducing) power to the devices.
>
> The PM framework does not treat these separately; a single suspend
> method call is used for both purposes.  But more and more we are seeing
> that they should be, especially on non-ACPI systems.  This patch is, in
> a roundabout way, an attempt to do so.
>
> Part of the problem is that people tend to think of "suspend" as
> meaning "suspend the system".  However a much more flexible -- dare I
> say more valid? -- point of view is "suspend the CPUs and at the same
> time remove (or reduce) power for devices that will no longer need it".  
> In other words, system suspend really is just a kind of runtime
> suspend, in which the devices being suspended are the CPUs and the
> sysdevs.
>
> Obviously this is an oversimplification, but I think it's a useful 
> approach.
>
> Just think about it.  Suppose every driver supported autosuspend.  
> When a driver received a notification that the CPU was going to be
> suspended, it would know that its device wasn't going to need power
> (since the device can't do anything useful without the driver telling
> it what to do) and so it would automatically power the device down,
> while also arranging not to access the device any more.  Thus the
> suspend method calls would really exist only to let drivers know that
> their code was going to stop running (since the CPU was about to stop
> all activity); the device-power management part would merely be a side
> effect.
>
> And then, of course, drivers on embedded systems would be smart enough 
> to know that some of the devices _should_ remain powered up, because 
> they could still be useful even when the CPU wasn't running.  The only 
> obstacle is letting the drivers know when their devices actually _are_ 
> in use -- sometimes this is apparent only at the application level.
>
> So the patch should be rewritten.  Change the name of the new attribute
> to something like "autonomous" or "in_use", and don't make the PM core 
> skip devices when the attribute is set.  Instead, change the relevant 
> drivers.  Their suspend methods should arrange for the driver to stop 
> using the device, but if the attribute is set then the device should 
> not be powered down.
>
> Alan Stern
>
>
>   
Ok I will provide a new patch with this approch.

Regards Michael
