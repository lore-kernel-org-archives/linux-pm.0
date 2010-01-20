From: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH] PM / Runtime: Add sysfs switch for
 disabling device run-time PM
Date: Wed, 20 Jan 2010 14:50:27 -0800
Message-ID: <20100120225027.GB31280__28424.1479741924$1264028333$gmane$org@kroah.com>
References: <201001180129.55219.rjw@sisk.pl> <20100120025147.GA20979@kroah.com>
	<201001202155.37062.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001202155.37062.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 20, 2010 at 09:55:36PM +0100, Rafael J. Wysocki wrote:
> On Wednesday 20 January 2010, Greg KH wrote:
> > On Mon, Jan 18, 2010 at 01:29:55AM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > Subject: PM / Runtime: Add sysfs switch for disabling device run-time PM
> > > 
> > > Add new device sysfs attribute, power/runtime, allowing the user
> > > space to block the run-time power management of the device.  If this
> > > attribute is set to "disabled", the driver of the device won't be
> > > able to enable run-time power management for it (without breaking the
> > > rules).
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  drivers/base/power/power.h   |    4 +
> > >  drivers/base/power/runtime.c |  107 +++++++++++++++++++++++++++++++++----------
> > >  drivers/base/power/sysfs.c   |   46 ++++++++++++++++++
> > >  include/linux/pm.h           |    1 
> > >  include/linux/pm_runtime.h   |   11 +---
> > >  5 files changed, 139 insertions(+), 30 deletions(-)
> > 
> > You forgot to also add an entry into Documentation/ABI/ for when you
> > add/change a sysfs file :)
> 
> There's no description for /sys/devices/.../power/wakeup in there too and
> that one has been present for quite some time already.
> 
> I'd prefer adding them both in a separate patch if you don't mind.

That's fine with me, as long as you add them :)

thanks,

greg k-h
