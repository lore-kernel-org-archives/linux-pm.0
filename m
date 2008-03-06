From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
	registrations concurrent with suspend/hibernation
Date: Thu, 6 Mar 2008 23:30:27 +0100
Message-ID: <200803062330.28639.rjw__35081.6003083766$1204842911$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803061656180.19564-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803061656180.19564-100000@iolanthe.rowland.org>
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
> > > > Well, can it happen in practice?  If it can, then what way can it happen?
> > > 
> > > Yes, it can happen in practice when a new module is loaded.  In some 
> > > ways, modules' init routines are like probe methods.
> > 
> > Hmm, I'm not sure if it really is possible to load a module when all devices
> > have been suspended.  Never mind, though.
> 
> You can load the module before devices are suspended, and then its init 
> routine can run while the suspend is starting.

Yeah.

> > > To be safe, I think we should make system sleep mutually exclusive with 
> > > module loading.
> > 
> > Okay, is the (yet another) version of the patch below fine by you?
> 
> Yes, it's fine.  Mutual exclusion with module loading can be added 
> later.  (Ironically, it may require putting pm_sleep_rwsem back!)

I'm going to send this patch and the "include dpm_sysfs_add() into
device_pm_add()" patch for -mm/linux-next testing, if you don't mind.

I'm working on a new version of the "PM: Separate suspend and hibernation
callbacks" patch, on top of the two.

Thanks,
Rafael
