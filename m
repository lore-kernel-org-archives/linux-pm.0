From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 2/5] devcore adds generic wakeup event handler
Date: Wed, 22 Oct 2008 13:57:25 +0200
Message-ID: <200810221357.26442.rjw__42991.9283059009$1224676535$gmane$org@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	<200810192106.58828.rjw@sisk.pl>
	<20081022052406.GB15271@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081022052406.GB15271@sli10-desk.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 22 of October 2008, Shaohua Li wrote:
> On Mon, Oct 20, 2008 at 03:06:58AM +0800, Rafael J. Wysocki wrote:
> > On Thursday, 11 of September 2008, Shaohua Li wrote:
> > > The default action to handle wakeup event. Currently just prints something,
> > > maybe we should call .resume(). The routine will be called in task context.
> > >
> > > ---
> > >  drivers/base/power/main.c |    6 ++++++
> > >  include/linux/pm.h        |    2 ++
> > >  2 files changed, 8 insertions(+)
> > >
> > > Index: linux/drivers/base/power/main.c
> > > ===================================================================
> > > --- linux.orig/drivers/base/power/main.c      2008-09-11 10:56:26.000000000 +0800
> > > +++ linux/drivers/base/power/main.c   2008-09-11 10:56:39.000000000 +0800
> > > @@ -785,3 +785,9 @@ void __suspend_report_result(const char
> > >       }
> > >  }
> > >  EXPORT_SYMBOL_GPL(__suspend_report_result);
> > > +
> > > +void device_receive_wakeup_event(struct device *dev)
> > > +{
> > > +     printk("Device %s invokes wakeup event\n", dev->bus_id);
> > > +}
> > > +EXPORT_SYMBOL(device_receive_wakeup_event);
> > > Index: linux/include/linux/pm.h
> > > ===================================================================
> > > --- linux.orig/include/linux/pm.h     2008-09-11 10:56:29.000000000 +0800
> > > +++ linux/include/linux/pm.h  2008-09-11 10:56:39.000000000 +0800
> > > @@ -440,6 +440,8 @@ static inline int device_suspend(pm_mess
> > >
> > >  #endif /* !CONFIG_PM_SLEEP */
> > >
> > > +void device_receive_wakeup_event(struct device *dev);
> > > +
> > >  /*
> > >   * Global Power Management flags
> > >   * Used to keep APM and ACPI from both being active
> > 
> > Do you anticipate any particular use of this function?
> maybe calls .resume() to wakeup a device.

Well, resume() is specific to system sleep state transitions, so it seems we
need a separate driver callback here.
