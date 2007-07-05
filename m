From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 11:01:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051054040.3728-100000@iolanthe.rowland.org>
References: <1183631293.8961.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183631293.8961.109.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Zhang Rui wrote:

> IMO, device runtime wakeup and wakeup from a system sleep state are
> different.

I sort of agree with you.  (Except that on smaller or embedded systems, 
there isn't always such a clear distinction between runtime suspend and 
system suspend.  One sort of blends into the other as more and more 
components are powered down.  But let's ignore that.)

> If we want to make use of the wakeup setting in sysfs, we can't simply
> enable/disable /sys/.../power/wakeup.
> 
> Some different values like "device_runtime" and "system_sleep" are
> needed to indicate the different remote wakeup state.
> Take ACPI platform for example:
> "disable":		disable remote wakeup.
> "device_runtime":	device runtime wakeup is enabled, while device 
> 			can not wakeup the system from a sleep state.
> 			For ACPI platforms, that's disable the wakeup
> 			GPE of the device.
> "system_sleep":		the ability of wakeup system from a sleep state
> 			is enabled. It needs to enable the device
> 			runtime wakeup ability first. and enable wakeup
> 			GPE as well for ACPI platforms.

Allow me to rephrase.  You seem to be saying that /sys/.../power/wakeup 
should be able to hold four different values:

	1. always disabled
	2. always enabled
	3. enabled at runtime but not during system sleep
	4. enabled during system sleep but not at runtime

Right?  With the default being 3 (except for a few things like the 
power button).

Or maybe there should be two attribute files: wakeup (used during
system sleep) and wakeup_runtime (used for runtime suspend).

Comments from anybody else?

Alan Stern
