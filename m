From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
 registrations concurrent with suspend/hibernation
Date: Thu, 6 Mar 2008 10:26:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803061022150.4061-100000__17868.4968770996$1204817639$gmane$org@iolanthe.rowland.org>
References: <200803060024.28850.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803060024.28850.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Mar 2008, Rafael J. Wysocki wrote:

> > > Revised patch below.
> > 
> > It looks good.  Let's hope it doesn't mess up ACPI too badly...  :-)
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thanks!

I thought of one more thing you might want to add: device_pm_add() 
doesn't handle the case where dev->parent is NULL.  You could put in 
that static "all_devices_sleeping" flag, which gets set at the end of 
dpm_suspend() and cleared at the start of dpm_resume().

> Okay, I also have the appended patch on top of this one. :-)
> 
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Include dpm_sysfs_add() into device_pm_add(), in analogy with
> device_pm_remove(), and modify device_add() to call the latter after
> bus_add_device(), to avoid situations in which the PM core may
> attempt to suspend a device the registration of which has not been
> successful.

Clean and simple.  Ack.

Alan Stern
