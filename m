From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] thermal: add sysfs_notify on some attributes
Date: Wed, 30 Mar 2016 10:06:31 -0700
Message-ID: <1459357591.13525.62.camel@linux.intel.com>
References: <1457979156-10972-1-git-send-email-srikars@nvidia.com>
	 <1458079520.4486.39.camel@intel.com>
	 <20160329013540.GA15615@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160329013540.GA15615-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-03-28 at 18:35 -0700, Eduardo Valentin wrote:
> On Tue, Mar 15, 2016 at 11:08:00PM +0000, Pandruvada, Srinivas wrote:
> >=20
> > On Mon, 2016-03-14 at 11:12 -0700, Srikar Srimath Tirumala wrote:
> > >=20
> > >=20
[...]
> >=20
> The complexity of such communication (or even the current status of
> sysfs ABI) starts to reach limit of such channel. We may definitely
> consider other means, such as /dev interface, just like IIO does.
Yes. Instead of loading netlink I/F, we need to have thermal channel to
notify.

> > During last LPC we discussed about using IIO for temperature
> > threshold
> > notifications and I submitted multiple changes for that. Looks like
> > we
> > also care of trip point changes. So I think we need more
> > comprehensive
> > mechanism to address this.
> >=20
> > May be we should have thermal mini summit during LPC again and
> > decide a
> > comprehensive plan to address all asynchronous thermal
> > notifications.
> >=20
> I have created a wiki for LPC 2016
> http://wiki.linuxplumbersconf.org/2016:thermal
>=20
> Overall I believe we need to solve the (temperature) sensing in a
> more
> structured way within the kernel. We have three subsystem that allow
> performing temperature sensing. They are different in design and
> concept, but still solve similar problems.
>=20
> Again, please lets generate enough quorum to run the micro conf.
>=20
I am planning to attend.

Thanks,
Srinivas
> BR,=C2=A0
>=20
> Eduardo Valentin
