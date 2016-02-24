From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Wed, 24 Feb 2016 15:37:53 -0800
Message-ID: <1456357073.3860.21.camel@linux.intel.com>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007172343.GE4557@linux> <4807388.hTIoZIhGRk@vostro.rjw.lan>
	 <20151016054226.GQ19018@linux> <1456344052.8680.208.camel@linux.intel.com>
	 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12486 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbcBXXjX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 18:39:23 -0500
In-Reply-To: <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 2016-02-24 at 21:05 +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 24, 2016 at 9:00 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Fri, 2015-10-16 at 11:12 +0530, Viresh Kumar wrote:
> > > On 16-10-15, 00:45, Rafael J. Wysocki wrote:
> > > > We're talking about a continuous range above the base frequency
> > > > here.
> > >=20
> > > Ick. No it can't be reused for the continuous range stuff.
> > >=20
> > I know this is bit old discussion. Is there any problem in applying
> > this patch?
>=20
> Not in principle, but can you please resubmit?
>=20
Good I tested again.

Hi Viresh,

Are we no longer allowed to call
	sysfs_create_file in cpufreq_driver.init() callback?

The following call crashes because of BUG_ON for !kobj->sd:
	sysfs_create_file(&policy->kobj,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &(cpufreq_attr_base_frequ=
ency.attr));

Before I debug further, I want to check with you.
This used to work before.

Thanks,
Srinivas

> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
