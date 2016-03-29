From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] thermal: add sysfs_notify on some attributes
Date: Mon, 28 Mar 2016 18:35:42 -0700
Message-ID: <20160329013540.GA15615@localhost.localdomain>
References: <1457979156-10972-1-git-send-email-srikars@nvidia.com>
 <1458079520.4486.39.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458079520.4486.39.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 15, 2016 at 11:08:00PM +0000, Pandruvada, Srinivas wrote:
> On Mon, 2016-03-14 at 11:12 -0700, Srikar Srimath Tirumala wrote:
> > Add a sysfs_notify on thermal_zone*/temp and cooling_device*/
> > cur_state whenever any trip is triggered or cur state is changed.
> >=20
> > This change allows usermode apps to register themselves to get
> > notified, when certain thermal conditions occur and reduce their
> > workload. This workload throttling allows usermode to react before
> > hardware clocks are throttled and keep some critical apps running
> > reliably longer.
> I think we need a combination of proposal in=A0
> https://patchwork.kernel.org/patch/7876351/=A0and this.
>=20
> For example this patch notifies that some trip is violated, but that =
is
> not enough for user space application to take any action. Some trips
> violations user space may not care as this may be a transient one. Th=
e
> patch from=A0Eduardo address that by providing trip, temperature and =
last
> temperature information. But that patch only address hot trips. I
> understand why Eduardo doesn't want to be notified for passive trips =
as
> there will be too many.
>=20

Yeah, my original intention was to avoid flooding userland, specially
through a pipe like the sysfs netlink, which is in use to deal with
other stuff.

> So IMO we need some mechanism to turn off notification and decide wha=
t
> notification will result in user space notifications.
> On some x86 systems we have 10+ passive/active trips, this will resul=
ts
> in too many notifications. We may be in thermally sensitive zone, whe=
re
> more code excecution is more heat.
>=20

Exactly, that has direct impact not only on the process waiting for
thermal notifications, but also on other process listening to sysfs.

> We may have some mask of trips for which will result in notifications=
=2E
> By default no notifications, unless some user space requests.
>=20

The complexity of such communication (or even the current status of
sysfs ABI) starts to reach limit of such channel. We may definitely
consider other means, such as /dev interface, just like IIO does.

> During last LPC we discussed about using IIO for temperature threshol=
d
> notifications and I submitted multiple changes for that. Looks like w=
e
> also care of trip point changes. So I think we need more comprehensiv=
e
> mechanism to address this.
>=20
> May be we should have thermal mini summit during LPC again and decide=
 a
> comprehensive plan to address all asynchronous thermal notifications.
>=20

I have created a wiki for LPC 2016
http://wiki.linuxplumbersconf.org/2016:thermal

Overall I believe we need to solve the (temperature) sensing in a more
structured way within the kernel. We have three subsystem that allow
performing temperature sensing. They are different in design and
concept, but still solve similar problems.

I would still prefer to get this better architectured.

Of course, we do not need to wait until LPC to start drafting this.

Again, please lets generate enough quorum to run the micro conf.

BR,=20

Eduardo Valentin
