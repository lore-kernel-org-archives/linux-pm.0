From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
	registrations concurrent with suspend/hibernation
Date: Thu, 6 Mar 2008 17:26:02 +0100
Message-ID: <200803061726.03277.rjw__42850.0356073075$1204821261$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803061022150.4061-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803061022150.4061-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 6 of March 2008, Alan Stern wrote:
> On Thu, 6 Mar 2008, Rafael J. Wysocki wrote:
> 
> > > > Revised patch below.
> > > 
> > > It looks good.  Let's hope it doesn't mess up ACPI too badly...  :-)
> > > 
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Thanks!
> 
> I thought of one more thing you might want to add: device_pm_add() 
> doesn't handle the case where dev->parent is NULL.

I'm not sure what you mean.

If dev->parent is NULL, we get into the "successful" branch where the device is
added to dpm_active.  Do you think we should add any extra handling of this
case?

> You could put in that static "all_devices_sleeping" flag, which gets set at
> the end of dpm_suspend() and cleared at the start of dpm_resume().

Well, I don't think it's necessary.  dpm_active is empty in that case and
we can use the list_empty(&dpm_active) check instead.

Thanks,
Rafael
