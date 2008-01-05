From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/4] PM: Introduce destroy_suspended_device()
Date: Fri, 4 Jan 2008 22:11:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801042202070.22169-100000__8164.41849242455$1199502753$gmane$org@netrider.rowland.org>
References: <200801042305.35089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801042305.35089.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jan 2008, Rafael J. Wysocki wrote:

> I have rebased gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> on top of the $subject series, the result is appended.  It has only been
> compilation tested for now, but I'll be testing it for the next couple of days.
> 
> Please review.

I would prefer it if you could also merge in this patch at the same 
time:

https://lists.linux-foundation.org/pipermail/linux-pm/2007-December/015921.html

> +void device_resume(void)
>  {
> -	sysdev_resume();
> -	dpm_power_up();
> +	might_sleep();
> +	dpm_resume();
> +	unlock_all_devices();
> +	unregister_dropped_devices();
> +	up_write(&pm_sleep_rwsem);
>  }

With the aforementioned patch merged in, this will generate a 
warning for each dropped device.  The call to 
unregister_dropped_devices() should come after the up_write().

You might also consider adding a call to unregister_dropped_devices()  
in the error path of device_suspend() -- in theory even an aborted 
suspend might cause a device to malfunction.

Otherwise this looks okay.

Alan Stern
