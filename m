From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 5/6] thermal: iio Documentation
Date: Fri, 02 Oct 2015 10:01:13 -0700
Message-ID: <1443805273.3085.3.camel@linux.intel.com>
References: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1443305111-28272-6-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <5608340F.8060406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1728 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbbJBRBc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Oct 2015 13:01:32 -0400
In-Reply-To: <5608340F.8060406@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org

On Sun, 2015-09-27 at 19:23 +0100, Jonathan Cameron wrote:
> On 26/09/15 23:05, Srinivas Pandruvada wrote:
> > An overview document about thermal iio binding.
> >=20
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  Documentation/thermal/thermal_iio_binding | 88
> > +++++++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/thermal/thermal_iio_binding
> >=20
> > diff --git a/Documentation/thermal/thermal_iio_binding
> > b/Documentation/thermal/thermal_iio_binding
> > new file mode 100644
> > index 0000000..df501f1
> > --- /dev/null
> > +++ b/Documentation/thermal/thermal_iio_binding
> > @@ -0,0 +1,88 @@
> > +
> > +Thermal IIO Bindings
> > +
> > +When CONFIG_THERMAL_IIO is enabled, in addition to the regular
> > thermal
> > +zone attributes, an additional entry for an IIO device is created.
> > +IIO sysfs ABI documents is available at Documentation/ABI/sysfs
> > -bus-iio.
> > +
> > +The following example shows the contents of the IIO:device in a
> > thermal
> > +zone.
> > +
> > +thermal_zoneX
> > +=E2=94=9C=E2=94=80=E2=94=80 iio:device9
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 buffer
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 enable
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 length
> > +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 watermark
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 events
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_temp_thresh=
_either_en
> > +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 in_temp_thresh=
_either_value
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_temp_raw
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 name
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 scan_elements
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_temp_en
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_temp_index
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_temp_type
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_timestamp_e=
n
> > +=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 in_timestamp_i=
ndex
> > +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 in_timestamp_t=
ype
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../.=
=2E/bus/iio
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 trigger0
> > +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 name
> > +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 trigger
> > +=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 current_trigge=
r
> > +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uevent
> > +=E2=94=9C=E2=94=80=E2=94=80 integral_cutoff
> > +...
> > +... other thermal_zone attributes
> > +...
> > +
> > +
> > +IIO Attributes
> > +
> > +name: This shows iio device name, which will match
> > thermal_zone/type attribute
> > +in_temp_raw: This will show raw temperature values same as
> > thermal_zone/temp
> > +attribute.
> > +
> > +trigger/current_trigger: This is IIO way of specifying data ready
> > indication.
> Kind of, given it's not exposed to userspace to read, but rather
> hooked directly
> to the filling of the buffer.  You might want to reword to not imply
> userspace can
> discover that it has fired directly.
OK
> > +If the thermal client can provide asynchronous notifications, then
> > a iio trigger
> > +device is created under trigger0. The name of this trigger will be
> > thermal
> > +device name suffixed with devX. To enable iio buffer
> > notifications,
> > +trigger/current_trigger cab be updated with this trigger. For
> > example
> > +
> > +#echo "x86_pkg_temp-dev9" > trigger/current_trigger
> > +
> > +In addition of samples can be pushed to iio buffers with external
> > standard IIO
> > +device triggers, E.g. sysfs trigger.
> > +
> > +How to enable events?
> > +To enable events a suitable threshold temperature can be written
> > to
> > +in_temp_thresh_either_value
> > +and enable by writing 1 to in_temp_thresh_either_en.
> > +
> > +To monitor events a good user space program is here:
> > +tools/iio/iio_event_monitor.c
> > +
> > +For example
> > +# echo 50000 >
> > /sys/devices/virtual/thermal/thermal_zone9/iio:device9/events/in_te
> > mp_thresh_either_value
> > +# echo 1 >
> > /sys/devices/virtual/thermal/thermal_zone9/iio:device9/events/in_te
> > mp_thresh_either_en
> > +# ./iio_event_monitor x86_pkg_temp
> > +Found IIO device with name x86_pkg_temp with device number 9
> > +Event: time: 1443297126626859289, type: temp, channel: 0, evtype:
> > thresh, direction: either
> > +
> > +How to read temperature samples?
> > +When thermal client or core driver calls
> > thermal_zone_device_update, this will
> > +result in sample pushed to iio buffers. These samples can be read
> > from
> > +/dev/iio:deviceX file.
> > +
> > +To enable buffer select scan_elements
> > +# echo 1 > scan_elements/in_temp_en
> > +
> > +Set buffer length to n samples and enable buffer.
> > +# echo 2 > buffer/length
> > +# echo 1 > buffer/enable
> > +
> > +Then user can poll/select or /dev/iio:deviceX (Here X correspond
> > to iio device number),
> > +and read temperature samples. A good example is at
> > tools/iio/generic_buffer.c.
> > +
> One too many blank lines at the end.
> > +
> Reasonable docs to get people started I think, but whether they are
> detailed enough is
> going to be a question for the thermal guys!
>=20
Idea here is to just give pointers to the IIO documentation and
examples to get developers to explore if they want to use this I/F.

> Also, perhaps a cross reference to Daniel's doc book on IIO?
> Documentation/DocBook/iio/
>=20
> As that expands in detail it might include lots of stuff that isn't
> relevant
> to thermal, but it might also fill in details that we don't want to
> explicitly
> layout here.
>=20
Thanks for your reviews.

-Srinivas

> Jonathan
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
