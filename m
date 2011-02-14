From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2] PM: Add support for device power
	domains
Date: Mon, 14 Feb 2011 23:34:47 +0100
Message-ID: <201102142334.47553.rjw__7738.52352654121$1297857240$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102141110400.1716-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102141110400.1716-100000@iolanthe.rowland.org>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 14, 2011, Alan Stern wrote:
> On Sat, 12 Feb 2011, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The platform bus type is often used to handle Systems-on-a-Chip (SoC)
> > where all devices are represented by objects of type struct
> > platform_device.  In those cases the same "platform" device driver
> > may be used with multiple different system configurations, but the
> > actions needed to put the devices it handles into a low-power state
> > and back into the full-power state may depend on the design of the
> > given SoC.  The driver, however, cannot possibly include all the
> > information necessary for the power management of its device on all
> > the systems it is used with.  Moreover, the device hierarchy in its
> > current form also is not suitable for representing this kind of
> > information.
> > 
> > The patch below attempts to address this problem by introducing
> > objects of type struct dev_power_domain that can be used for
> > representing power domains within a SoC.  Every struct
> > dev_power_domain object provides a sets of device power
> > management callbacks that can be used to perform what's needed for
> > device power management in addition to the operations carried out by
> > the device's driver and subsystem.
> > 
> > Namely, if a struct dev_power_domain object is pointed to by the
> > pwr_domain field in a struct device, the callbacks provided by its
> > ops member will be executed in addition to the corresponding
> > callbacks provided by the device's subsystem and driver during all
> > power transitions.
> 
> Overall this looks very good.
> 
> > Index: linux-2.6/include/linux/pm.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/pm.h
> > +++ linux-2.6/include/linux/pm.h
> > @@ -463,6 +463,14 @@ struct dev_pm_info {
> >  
> >  extern void update_pm_runtime_accounting(struct device *dev);
> >  
> > +/*
> > + * Power domains provide callbacks that are executed during system suspend,
> > + * hibernation, system resume and during runtime PM transitions along with
> > + * subsystem-level and driver-level callbacks.
> > + */
> > +struct dev_power_domain {
> > +	struct dev_pm_ops	ops;
> > +};
> 
> I don't have a clear picture of how people are going to want to use 
> these dev_power_domain structures.  Should there be a
> 
> 	void			*priv;
> 
> member as well?

Well, I'm not sure.  What would be the purpose of it?

Rafael
