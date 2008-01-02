From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/4] PM: Introduce destroy_suspended_device()
Date: Wed, 2 Jan 2008 17:50:15 +0100
Message-ID: <200801021750.16359.rjw__25431.8740954206$1199292607$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801021122070.5062-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801021122070.5062-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 of January 2008, Alan Stern wrote:
> On Wed, 2 Jan 2008, Rafael J. Wysocki wrote:
> 
> > On Wednesday, 2 of January 2008, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > It sometimes is necessary to destroy a device object during a suspend or
> > > hibernation, but the PM core is supposed to control all device objects in that
> > > cases.  For this reason, it is necessary to introduce a mechanism allowing one
> > > to ask the PM core to remove a device object corresponding to a suspended
> > > device on one's behalf.
> > > 
> > > Define function destroy_suspended_device() that will schedule the removal of
> > > a device object corresponding to a suspended device by the PM core during the
> > > subsequent resume.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Sorry, a small fix is needed for this patch.  Namely, dpm_sysfs_remove(dev)
> > should not be called by device_pm_schedule_removal(), because it will be called
> > anyway from device_pm_remove() when the device object is finally unregistered
> > (we're talking here about unlikely error paths only, but still).
> 
> The situation is a little confusing, because the source files under 
> drivers/base/power are maintained in Greg's tree and he already has 
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch 
> installed.  That patch conflicts with this one.
> 
> One of the these two patches will have to be rewritten to apply on top 
> of the other.  Which do you think should be changed?

Well, from the bisectability point of view, it would be better to adjust
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch and let the
$subject patch series go first, if you don't mind.

Rafael
