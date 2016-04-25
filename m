From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/3] cpufreq: intel_pstate: Adjust policy->max
Date: Mon, 25 Apr 2016 11:58:56 -0700
Message-ID: <1461610736.8946.239.camel@linux.intel.com>
References: <1461384233-24214-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1461384233-24214-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <571DEDC7.9010600@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35171 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932559AbcDYS6d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Apr 2016 14:58:33 -0400
In-Reply-To: <571DEDC7.9010600@yandex-team.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>

On Mon, 2016-04-25 at 13:13 +0300, Konstantin Khlebnikov wrote:
> On 23.04.2016 07:03, Srinivas Pandruvada wrote:
> >=20
> >=20
>=20

[...]

> > - It can cause reduced max performance, if the policy->max is set
> > to
> > the least turbo frequency and because of precision error in
> > calculation
> > of ceiling limit, we may end up in a limit which is in non turbo
> > region.
> > This issue is more prone when we enforce _PPC limit, because of the
> > way
> > _PPC limit is set to indicate the beginning of turbo region when
> > config
> > TDP feature is in use.
> I don't understand this. This fix for configuration where maximum
> allowed
> frequency between maximum non-turbo and first turbo frequency?
> Or this address regression that Borislav Petkov reported last year
> where
> _PSS had bogus pstate 0xff?
>=20

I am glad you asked this question. The requested max scaling frequency
either via _PPC or via cpufreq-sysfs, will be converted into a fixed
floating point max percent scale. On majority of the cases this will
result in correct max (What you set via scaling_max, you will see that
as max). But not 100% of time. If your _PPC is requested at a point
where we have issue, we will loose performance as we will not request
turbo.

Let's look at real example from a Broadwell laptop with config TDP.

_PSS table from a Broadwell laptop

2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
1300000 1100000 1000000 900000 800000 600000 500000

The actual results by disabling config TDP so that we can get what you
requested on or below 2300000Khz.

scaling_max_freq	Max Requested P-State	Resultant scaling
max
---------------------------------------- ----------------------
2400000			18			2900000 (max
turbo)
2300000			17			2300000 (max
physical non turbo)
2200000			15			2100000
2100000			15			2100000
2000000			13			1900000=C2=A0
1900000			13			1900000
1800000			12			1800000
1700000			11			1700000
1600000			10			1600000
1500000			f			1500000
1400000			e			1400000
1300000			d			1300000
1200000			c			1200000
1100000			a			1000000
1000000			a			1000000
900000			9			=C2=A0900000
800000			8			=C2=A0800000
700000			7			=C2=A0700000
600000			6			=C2=A0600000
500000			5			=C2=A0500000
------------------------------------------------------------------


Now set the config TDP level 1 ratio as 0x0b (equivalent to 1100000KHz)
in BIOS (not every system will let you adjust this).
The turbo activation ratio will be set to one less than that, which
will be 0x0a (So any request above 1000000KHz should result in turbo
region assuming no thermal limits).
Here _PPC will request max to 1100000KHz (which basically should still
result in turbo as this is more than the turbo activation ratio upto
max allowable turbo frequency), but actual calculation resulted in a
max ceiling P-State which is 0x0a.
So under any load we will not go to turbo frequency. This will be a
huge performance hit.

Thanks,
Srinivas








