From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data
 pointer
Date: Thu, 4 Feb 2016 13:55:38 +0530
Message-ID: <20160204082538.GB3469@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1876466.AY9fn15fDn@vostro.rjw.lan>
 <20160204053614.GV3469@vireshk>
 <CAHZ_5WxJSDtFyFdCc-D2=HSaPON=3rzUxpxPYsCyZvrV1Nv3qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32980 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbcBDIZm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 03:25:42 -0500
Received: by mail-pf0-f171.google.com with SMTP id w123so37532542pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 00:25:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHZ_5WxJSDtFyFdCc-D2=HSaPON=3rzUxpxPYsCyZvrV1Nv3qw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 04-02-16, 13:44, Gautham R Shenoy wrote:
> In a a two policy system, to run ondemand on one and conservative on =
the other,
> =A0won't the driver have CPUFREQ_HAVE_GOVERNOR_PER_POLICY set? =A0

No.

CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not about the facility of using
separate governor-type for each policy, that is always available to
the user.

CPUFREQ_HAVE_GOVERNOR_PER_POLICY was initially added for platforms
with different type of CPUs on the same chip, though others can
benefit from it as well.

=46or example, on a 4 core ARM big LITTLE platform, we will have:
- 2 A7 (low performance/low power)
- 2 A15 (high performance/high power)

The A7's share a policy and A15's share another one.

Without CPUFREQ_HAVE_GOVERNOR_PER_POLICY, if ondemand is selected for
both the policies, the we used to get a single directory (and a set of
tunables) at /sys/devices/system/cpu/cpufreq/ondemand/ .

That used to force us to use same tunables, like sampling rate, etc
for both the policies.

But because the CPUs were so different, we really wanted independent
control.

So, we designed CPUFREQ_HAVE_GOVERNOR_PER_POLICY, so that in such
cases, each policy will have a set of tunables for the same governor
type.

Hope that makes it clear.

If the below questionnaire is still valid, please let me know :)

> If yes, then the changes in this patch won't come into play.
>=20
> Also in cpufreq_governor.c, we set cdata->gdbs_data only when=A0
> !have_governor_per_policy(). cdata->gdbs_data is NULL otherwise.
> A cursory inspection doesn't show any other place in the cpufreq code=
base
> =A0where cdata->gdbs_data is set. Unless I have missed one such initi=
alization,=A0
> based on my reading of the patch, instead of doing an extra hop to ge=
t the=A0
> governor data via cdata->gdbs_data, we can simply record it in a glob=
al
> variable.
>=20
> Also, if your concern is regarding the use of show_##file_name##_gov_=
sys in
> case
> of governor per policy, then the existing code is also broken, since =
we would
> be=A0
> accessing _gov##_dbs_cdata.gdbs_data->tuners where _gov##_dbs_cdata.g=
dbs_data=A0
> will be NULL!.
>=20
> What am I missing ?

--=20
viresh
