From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 05 Jul 2007 18:28:13 +0800
Message-ID: <1183631293.8961.109.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707041432250.9446-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707041432250.9446-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-07-04 at 14:43 -0400, Alan Stern wrote:
> Here's a question that has been bothering me for a while.  Should we 
> enable remote wakeup on USB hubs?
> 
> On the face of it the answer is obviously Yes.  And certainly we want
> remote wakeup enabled during a runtime suspend; otherwise the system
> would never know when the user unplugged a device from the hub or
> plugged in a new one.
> 
> But consider STR, say in the case of a laptop with a USB mouse
> attached.  The user suspends the laptop.  Then he prepares to pack it
> away and in the process unplugs the mouse.  Pow! -- the laptop
> springs back to life.  That's not what we want.
> 
> On the other hand, the user might indeed want to awaken the laptop by
> clicking the USB mouse.  So what should we do?  The question is made
> even more difficult by the fact that, if the hub is already
> runtime-suspended when the system suspend occurs, we would have to
> resume the hub just in order to turn off remote wakeup!
> 
> Right now we more or less ignore all these issues by relying on the 
> wakeup settings in sysfs.  Is that a reasonable approach?  Is there 
> anything else we can do?
> 

IMO, device runtime wakeup and wakeup from a system sleep state are
different.
If we want to make use of the wakeup setting in sysfs, we can't simply
enable/disable /sys/.../power/wakeup.

Some different values like "device_runtime" and "system_sleep" are
needed to indicate the different remote wakeup state.
Take ACPI platform for example:
"disable":		disable remote wakeup.
"device_runtime":	device runtime wakeup is enabled, while device 
			can not wakeup the system from a sleep state.
			For ACPI platforms, that's disable the wakeup
			GPE of the device.
"system_sleep":		the ability of wakeup system from a sleep state
			is enabled. It needs to enable the device
			runtime wakeup ability first. and enable wakeup
			GPE as well for ACPI platforms.

All the platform specific operations can be done in the
platform_enable_wakeup hook.
All the remote wakeup state are set to device_runtime by default.
We can set the ../power/state to "system_sleep" when we want to wakeup
the system from STR by clicking the USB mouse. :)

Thanks,
Rui
