From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Fix set_policy interface for
 no_turbo
Date: Tue, 07 Jun 2016 17:55:03 -0700
Message-ID: <1465347303.25099.7.camel@linux.intel.com>
References: <1465346333-3104-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465346333-3104-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0gtBQbWn2HSr_LRn6cFhqARVv=ve07DE30_c2XwfFYS9A@mail.gmail.com>
	 <1465346886.25099.6.camel@linux.intel.com>
	 <CAJZ5v0j9BTxAyOEijB-y2z3K49za373W3Ok-ChpXjASXScJJrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62210 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbcFHAxZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jun 2016 20:53:25 -0400
In-Reply-To: <CAJZ5v0j9BTxAyOEijB-y2z3K49za373W3Ok-ChpXjASXScJJrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 2016-06-08 at 02:50 +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 2:48 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Wed, 2016-06-08 at 02:42 +0200, Rafael J. Wysocki wrote:
> > >=20
> > > On Wed, Jun 8, 2016 at 2:38 AM, Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >=20
> > > >=20
> > > > When turbo is disabled, the set_policy interface is broken.
> > > > For example, when turbo is disabled and
> > > > cpuinfo.max =3D 2900000 (full max turbo frequency)
> > > > Setting the limits results in frequency less than settings:
> > > > Set 1000000 KHz results in 0700000 KHz
> > > > Set 1500000 KHz results in 1100000 KHz
> > > > Set 2000000 KHz results in=C2=A0=C2=A01500000 KHz
> > > >=20
> > > > This is because limits->max_perf fraction is calculated using
> > > > max
> > > > turbo frequency as the reference, but when the max P-State is
> > > > capped in the function intel_pstate_get_min_max, the reference
> > > > is not the max turbo P-State. This results in reducing max
> > > > P-State.
> > > >=20
> > > > One option is to always use max turbo as reference for
> > > > calculating
> > > > limits. But this will not be correct. By definition the
> > > > intel_pstate
> > > > sysfs limits, shows percentage of available performance. So
> > > > when
> > > > BIOS has disabled turbo, the available performance is max non
> > > > turbo.
> > > > So the max_perf_pct should still show 100%.
> > > >=20
> > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.i
> > > > ntel
> > > > .com>
> > > I guess we need this in -stable?
> > Yes.
> > >=20
> > >=20
> > > If so, all of them, or is there a specific starting point?
> > I think this is from (even in 3.10, it should have the same
> > behavior
> > looking at the code).
> OK
>=20
> All applicable, then?
Yes. But for some of the trees we need rebase, as the patch may not
apply cleanly.

Thanks,
Srinivas

