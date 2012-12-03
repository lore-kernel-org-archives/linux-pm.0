From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [RFC PATCH 2/7] Thermal: Create zone level APIs
Date: Mon, 3 Dec 2012 13:12:21 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB592310F6@BGSMSX101.gar.corp.intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
	<1353149158-19102-3-git-send-email-durgadoss.r@intel.com>
	<CAJLyvQzptLcWPiJUquO2c2PegiMRt00SR+V=8kHA2wkZG4EFNQ@mail.gmail.com>
	<4D68720C2E767A4AA6A8796D42C8EB59230E20@BGSMSX101.gar.corp.intel.com>
	<CAJLyvQxW3fLrpyBhaKSpDoq2K4b4zOd8qLzAv1XsqEtNVgk8Sw@mail.gmail.com>
	<4D68720C2E767A4AA6A8796D42C8EB59230FA6@BGSMSX101.gar.corp.intel.com>
 <CAJLyvQwaix91RjAoc2NdMHq4LOxc9iOLGCqa6R6iOMT2kBQbkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26262 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab2LCNMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Dec 2012 08:12:36 -0500
In-Reply-To: <CAJLyvQwaix91RjAoc2NdMHq4LOxc9iOLGCqa6R6iOMT2kBQbkA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "wni@nvidia.com" <wni@nvidia.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>

Hi,

[big cut.]
> >> >> > +struct thermal_zone {
> >> >> > +       char name[THERMAL_NAME_LENGTH];
> >> >> > +       int id;
> >> >> > +       void *devdata;
> >> >> > +       struct thermal_zone *ops;
> >> >> What is this, thermal_zone_device_ops? and how to initialize this ops?
> >> >
> >> > oh, Not required, for now. Will remove it..
> >> > Good catch :-)
> >>
> >> I am still confused a bit.
> >> Is this thermal_zone going to take the place of the old
> >> thermal_zone_device?
> >
> > Yes, it will replace the older one.
> >
> >> If yes, which functions/callbacks are used to access
> >> thermal_zone->trip[] like the old get_trip_*?
> >
> > We will not have call backs associated with 'zone'.
> > A zone is kind of a virtual entity, which can have one or
> > more sensors associated with it.
> >
> > Trip points are attached to 'a sensor' which can be in
> > any zone. So, thermal_sensor_ops functions will help you
> > access the trip values.
> But I didn't find such functions in the current thermal_sensor_ops for
> access trip points, only functions for thresholds now.
> Will you add these functions when you update the governors?

The idea is the governors need these values to calculate the trend
of the thermal zone. And these are embedded inside thermal zone
structure. So, when required a zone can 'know' about its sensors and
their trip points through these pointers.

Having said that, when we modify governors, if a need arises to
implement these functions, we will implement it.

Thanks,
Durga
