From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: cppc_cpufreq
Date: Sat, 09 Apr 2016 14:28:49 -0700
Message-ID: <1460237329.4491.12.camel@linux.intel.com>
References: <1460072821.5409.5.camel@intel.com>
	 <CAJ5Y-eaenct_KmZqGQsMdCeabdQqZBbzi9VCmOZHJ=snLy8XsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25438 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbcDIVb7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 9 Apr 2016 17:31:59 -0400
In-Reply-To: <CAJ5Y-eaenct_KmZqGQsMdCeabdQqZBbzi9VCmOZHJ=snLy8XsA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

On Fri, 2016-04-08 at 11:08 -0400, Ashwin Chaugule wrote:
> On 7 April 2016 at 19:50, Pandruvada, Srinivas
> <srinivas.pandruvada@intel.com> wrote:
> > Hi Ashwin,
> >=20
> > I didn't see in the cppc_cpufreq.c
> >=20
> > MODULE_LICENSE()
> >=20
> > Is it intentional?
>=20
> Not intentional. Doesn't the absence of this default to GPLv2? or is
> it required that the license be explicitly stated?
>=20
You are using symbols exported using EXPORT_SYMBOL_GPL

I get following error during insmod:

[=C2=A0=C2=A0=C2=A033.400861] cppc_cpufreq: module verification failed:=
 signature
and/or required key missing - tainting kernel
[=C2=A0=C2=A0=C2=A033.400890] cppc_cpufreq: Unknown symbol cpufreq_regi=
ster_driver
(err 0)
[=C2=A0=C2=A0=C2=A033.400901] cppc_cpufreq: Unknown symbol cppc_get_per=
f_ctrs (err 0)
[=C2=A0=C2=A0=C2=A033.400914] cppc_cpufreq: Unknown symbol acpi_get_psd=
_map (err 0)
[=C2=A0=C2=A0=C2=A033.400924] cppc_cpufreq: Unknown symbol cpufreq_freq=
_transition_end
(err 0)
[=C2=A0=C2=A0=C2=A033.400935] cppc_cpufreq: Unknown symbol cppc_get_per=
f_caps (err 0)
[=C2=A0=C2=A0=C2=A033.400945] cppc_cpufreq: Unknown symbol
cpufreq_freq_transition_begin (err 0)
[=C2=A0=C2=A0=C2=A033.400954] cppc_cpufreq: Unknown symbol cppc_set_per=
f (err 0)

I had to add=C2=A0MODULE_LICENSE(GPL).


Thanks,
Srinivas
>=20
> Thanks,
> Ashwin.
