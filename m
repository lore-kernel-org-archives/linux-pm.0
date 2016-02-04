From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data
 pointer
Date: Thu, 4 Feb 2016 17:01:02 +0530
Message-ID: <20160204113102.GA17371@in.ibm.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1876466.AY9fn15fDn@vostro.rjw.lan>
 <20160204053614.GV3469@vireshk>
 <CAHZ_5WxJSDtFyFdCc-D2=HSaPON=3rzUxpxPYsCyZvrV1Nv3qw@mail.gmail.com>
 <20160204082538.GB3469@vireshk>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:53304 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbcBDLbP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 06:31:15 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 04:31:15 -0700
Content-Disposition: inline
In-Reply-To: <20160204082538.GB3469@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ego@linux.vnet.ibm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

Hello Viresh,

On Thu, Feb 04, 2016 at 01:55:38PM +0530, Viresh Kumar wrote:
> On 04-02-16, 13:44, Gautham R Shenoy wrote:
> > In a a two policy system, to run ondemand on one and conservative o=
n the other,
> > =A0won't the driver have CPUFREQ_HAVE_GOVERNOR_PER_POLICY set? =A0
>=20
> No.
>=20
> CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not about the facility of using
> separate governor-type for each policy, that is always available to
> the user.
>=20
> CPUFREQ_HAVE_GOVERNOR_PER_POLICY was initially added for platforms
> with different type of CPUs on the same chip, though others can
> benefit from it as well.
>=20
> For example, on a 4 core ARM big LITTLE platform, we will have:
> - 2 A7 (low performance/low power)
> - 2 A15 (high performance/high power)
>=20
> The A7's share a policy and A15's share another one.
>=20
> Without CPUFREQ_HAVE_GOVERNOR_PER_POLICY, if ondemand is selected for
> both the policies, the we used to get a single directory (and a set o=
f
> tunables) at /sys/devices/system/cpu/cpufreq/ondemand/ .
>=20
> That used to force us to use same tunables, like sampling rate, etc
> for both the policies.
>=20
> But because the CPUs were so different, we really wanted independent
> control.
>=20
> So, we designed CPUFREQ_HAVE_GOVERNOR_PER_POLICY, so that in such
> cases, each policy will have a set of tunables for the same governor
> type.
>=20
> Hope that makes it clear.

Yes it does! Thank you for the explanation.

So, the CPUFREQ_HAVE_GOVERNOR_PER_POLICY is really
CPUFREQ_HAVE_GOVERNOR_TUNERS_PER_POLICY. Can we change the name to
reflect the intent?

>=20
> If the below questionnaire is still valid, please let me know :)

No, it is no longer valid!
>=20
> viresh

--
Thanks and Regards
gautham.

