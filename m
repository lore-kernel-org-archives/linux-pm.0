From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/6] thermal: iio device for thermal sensor
Date: Thu, 31 Dec 2015 15:18:08 -0800
Message-ID: <1451603888.4047.34.camel@linux.intel.com>
References: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1443305111-28272-4-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151231191847.GA14793@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151231191847.GA14793-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-12-31 at 11:18 -0800, Eduardo Valentin wrote:
> On Sat, Sep 26, 2015 at 03:05:08PM -0700, Srinivas Pandruvada wrote:
> > This change registers temperature sensor in a thermal zone as an
> > IIO
> > temperature device. This allows user space thermal application to
> > fully
> > utilize IIO capability to read temperature events and samples.
> > The primary motivation for this change to improve performance for
> > user
> > space thermal controllers like Linux thermal daemon or Intel=C2=AE
> > Dynamic
> > Platform and Thermal Framework (DPTF) for Chromium OS.
> > The current sysfs has several limitations, which forces the current
> > user space to use polling as the safe way. This polling causes
> > performance
> > bottlenecks as some devices requires extremely aggressive response
> > to
> > changing temperature conditions.
> > These are some limitations, which this change tries to address:
> > - Temperature reading via sysfs attribute, which needs conversion
> > from
> > string to int
> > - No way to set threshold settings to avoid polling for temperature
> > change
> > without using a RW passive trip point.
> > - Event notifications via slow kobject uevents, which needs parsing
> > to id
> > the zone and read temperature
> > - Only pull interface from user space, kernel drivers can't send
> > samples
> > - One sample at a time read from user space
> > These limitations can be addressed by registering temperature
> > sensor
> > as an IIO device. IIO provides
> > - buffered access via /dev/iio:deviceX node with select/poll
> > capability
> > - temperature thresholds setting via iio event thresholds
> > - Wait and receive events
> > - Able to use different external trigger (data ready indications)
> > and push
> > samples to buffers
> >=20
> > Next set of patches uses the IIO binding introduced in this
> > patchset.
> > The iio device created during call to thermal_zone_device_register.
> > Samples
> > are pushed to iio buffers when thermal_zone_device_update is called
> > from
> > client drivers.
> >=20
> > New thermal zone device callbacks:
> > It introduces three new callbacks for thermal client drivers:
> > get_threshold_temp: Get the current threshold temperature
> > set_threshold_temp: Set the current threshold temperature
> > check_notification_support: Inform that the client driver has
> > asynchronous
> > notification mechanism. If it is then polling can be avoided for
> > the
> > temperature sensor.
> >=20
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---

[Cut]

> >=20
> > +	int (*get_threshold_temp)(struct thermal_zone_device *, > >=20
> > int,
> > +				  int *);
> > +	int (*set_threshold_temp)(struct thermal_zone_device *,
> > int,
> > +				  int);
> > +	int (*set_notification_status)(struct thermal_zone_device
> > *,
> > +				       bool status);
> > +	bool (*check_notification_support)(struct
> > thermal_zone_device *);
>=20
>=20
> Can an existing thermal sensor benefit of the new functionality? If
> yes,

Yes. The existing driver will be using the trips instead of thresholds.
As we discussed during LPC,
trips (pasive/active/..): These are temperature points to which a
cooling action can be performed by binding a cooling device. The
existing drivers who support RW trips, user space still can update
those and get sample notifications. Existing drivers either have
polling or interrupt suport to evaluate trips and call
thermal_zone_device_update(), which will result in sample pushed to
user space.
=20
Thresholds: These are sensor temperature points which user space wants
to get notification of temperature change. They will not be presented
as passive/active/hot trips. User space can decide what to do with the
notifications. If existing drivers don't want to present as fake trips,
then they need to add the callback support.

> The problem I have with the above is the fact that they add callbacks
> and behavior eligible only for a subset of thermal zones.
>=20
> If we are moving to IIO integrated mode, the existing drivers need to
> be
> converted, to avoid diversification of behavior. For example, there
> is
> existing notification callbacks. Also, hot trip points are described
> as
> notification points.
>=20
> I believe the patch set needs to document also the next steps on this
> move.
>=20

If we decide to merge this functionality, I will push a documentation
and IIO sample program to use these features.

Thanks,
Srinivas

>=20
> >  	int (*notify) (struct thermal_zone_device *, int,
> >  		       enum thermal_trip_type);
> >  };
> > @@ -148,6 +155,8 @@ struct thermal_attr {
> >  	char name[THERMAL_NAME_LENGTH];
> >  };
> > =20
> > +struct iio_dev;
> > +
> >  /**
> >   * struct thermal_zone_device - structure for a thermal zone
> >   * @id:		unique id number for each thermal zone
> > @@ -182,6 +191,7 @@ struct thermal_attr {
> >   * @lock:	lock to protect thermal_instances list
> >   * @node:	node in thermal_tz_list (in thermal_core.c)
> >   * @poll_queue:	delayed work for polling
> > + * @indio_dev:	pointer to instance of an IIO dev for this
> > zone
> >   */
> >  struct thermal_zone_device {
> >  	int id;
> > @@ -208,6 +218,9 @@ struct thermal_zone_device {
> >  	struct mutex lock;
> >  	struct list_head node;
> >  	struct delayed_work poll_queue;
> > +#if defined(CONFIG_THERMAL_IIO)
> > +	struct iio_dev *indio_dev;
> > +#endif
> >  };
> > =20
> >  /**
