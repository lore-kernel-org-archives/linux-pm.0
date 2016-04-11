From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: cppc_cpufreq
Date: Mon, 11 Apr 2016 09:05:33 -0700
Message-ID: <1460390733.4909.1.camel@linux.intel.com>
References: <1460072821.5409.5.camel@intel.com>
	 <CAJ5Y-eaenct_KmZqGQsMdCeabdQqZBbzi9VCmOZHJ=snLy8XsA@mail.gmail.com>
	 <1460237329.4491.12.camel@linux.intel.com>
	 <CAJ5Y-eb9M7A7q+R9MtVn4wXFAJbW-jHCBTSC+Lbm76vd3P8HtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47892 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbcDKQIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Apr 2016 12:08:45 -0400
In-Reply-To: <CAJ5Y-eb9M7A7q+R9MtVn4wXFAJbW-jHCBTSC+Lbm76vd3P8HtQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

On Mon, 2016-04-11 at 10:53 -0400, Ashwin Chaugule wrote:
> On 9 April 2016 at 17:28, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Fri, 2016-04-08 at 11:08 -0400, Ashwin Chaugule wrote:
> > > On 7 April 2016 at 19:50, Pandruvada, Srinivas
> > > <srinivas.pandruvada@intel.com> wrote:
> > > > Hi Ashwin,
> > > >=20
> > > > I didn't see in the cppc_cpufreq.c
> > > >=20
> > > > MODULE_LICENSE()
> > > >=20
> > > > Is it intentional?
> > >=20
> > > Not intentional. Doesn't the absence of this default to GPLv2? or
> > > is
> > > it required that the license be explicitly stated?
> > >=20
> > You are using symbols exported using EXPORT_SYMBOL_GPL
> >=20
> > I get following error during insmod:
> >=20
> > [=C2=A0=C2=A0=C2=A033.400861] cppc_cpufreq: module verification fai=
led: signature
> > and/or required key missing - tainting kernel
> > [=C2=A0=C2=A0=C2=A033.400890] cppc_cpufreq: Unknown symbol cpufreq_=
register_driver
> > (err 0)
> > [=C2=A0=C2=A0=C2=A033.400901] cppc_cpufreq: Unknown symbol cppc_get=
_perf_ctrs (err
> > 0)
> > [=C2=A0=C2=A0=C2=A033.400914] cppc_cpufreq: Unknown symbol acpi_get=
_psd_map (err
> > 0)
> > [=C2=A0=C2=A0=C2=A033.400924] cppc_cpufreq: Unknown symbol
> > cpufreq_freq_transition_end
> > (err 0)
> > [=C2=A0=C2=A0=C2=A033.400935] cppc_cpufreq: Unknown symbol cppc_get=
_perf_caps (err
> > 0)
> > [=C2=A0=C2=A0=C2=A033.400945] cppc_cpufreq: Unknown symbol
> > cpufreq_freq_transition_begin (err 0)
> > [=C2=A0=C2=A0=C2=A033.400954] cppc_cpufreq: Unknown symbol cppc_set=
_perf (err 0)
> >=20
> > I had to add MODULE_LICENSE(GPL).
>=20
> Ok. Thanks for the heads up. Will post a patch soon, unless you want
> to go ahead and send yours out.
This is license, so I prefer you post.
I will post other changes to CPPC for x86 once I am ready.

Thanks,
Srinivas

>=20
> Thanks,
> Ashwin.
