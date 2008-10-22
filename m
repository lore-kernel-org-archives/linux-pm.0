From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Wed, 22 Oct 2008 13:23:18 +0800
Message-ID: <20081022052317.GA15271__6532.02934558994$1224653446$gmane$org@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	<20080911063822.973881418@sli10-desk.sh.intel.com>
	<200810192104.17510.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810192104.17510.rjw@sisk.pl>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 20, 2008 at 03:04:16AM +0800, Rafael J. Wysocki wrote:
> On Thursday, 11 of September 2008, Shaohua Li wrote:
> > Introduce .wakeup_event(). When a device gets a wakeup event,
> > the callback is called. The callback usually should disable wakeup event.
> >
> > ---
> >  include/linux/pm.h |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > Index: linux/include/linux/pm.h
> > ===================================================================
> > --- linux.orig/include/linux/pm.h     2008-09-11 10:56:27.000000000 +0800
> > +++ linux/include/linux/pm.h  2008-09-11 10:56:29.000000000 +0800
> > @@ -125,6 +125,12 @@ typedef struct pm_message {
> >   *   make ANY assumptions about the hardware state right prior to @restore().
> >   *   On most platforms, there are no restrictions on availability of
> >   *   resources like clocks during @restore().
> > + * @wakeup_event: Checks if a wakeup event occurs. In bus level, the op might
> > + *   check all devices under the bus and call device_receive_wakeup_event()
> > + *   for devices which invoke wakeup event. In device level, the op just
> > + *   returns if a wakeup event occurs. Note, if device follows standard
> > + *   mechanism for wakeup which bus level can handle, device level op can be
> > + *   empty.
> >   *
> >   * All of the above callbacks, except for @complete(), return error codes.
> >   * However, the error codes returned by the resume operations, @resume(),
> > @@ -151,6 +157,7 @@ struct pm_ops {
> >       int (*thaw)(struct device *dev);
> >       int (*poweroff)(struct device *dev);
> >       int (*restore)(struct device *dev);
> > +     bool (*wakeup_event)(struct device *dev);
> >  };
> >
> >  /**
> 
> I think it will be better to place wakeup_event() in 'struct device' itself
> rather than here.
> 
> Generally, the 'struct pm_ops' thing (after the simplification patch queued up
> for .29 that will be 'struct dev_pm_ops') will depend on PM_SLEEP and
> wakeup_event() is a run-time thing.
ok
