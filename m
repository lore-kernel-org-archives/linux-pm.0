From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
 registrations concurrent with suspend/hibernation
Date: Thu, 6 Mar 2008 12:40:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803061233460.7892-100000__41677.9201281772$1204825531$gmane$org@iolanthe.rowland.org>
References: <200803061726.03277.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803061726.03277.rjw@sisk.pl>
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

> > I thought of one more thing you might want to add: device_pm_add() 
> > doesn't handle the case where dev->parent is NULL.
> 
> I'm not sure what you mean.
> 
> If dev->parent is NULL, we get into the "successful" branch where the device is
> added to dpm_active.  Do you think we should add any extra handling of this
> case?

If a device is registered after dpm_suspend() has returned, the
device won't be suspended properly before the system goes to sleep.  

If the device has a parent then you're okay, because the parent must
already be suspended and so device_pm_add() will fail.  But if the
device doesn't have a parent then device_pm_add() will succeed, which
you don't want.

> > You could put in that static "all_devices_sleeping" flag, which gets set at
> > the end of dpm_suspend() and cleared at the start of dpm_resume().
> 
> Well, I don't think it's necessary.  dpm_active is empty in that case and
> we can use the list_empty(&dpm_active) check instead.

What would happen the very first time the system registers a device 
during startup?

Alan Stern
