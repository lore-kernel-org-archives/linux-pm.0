From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: CPUfreq lockdep issue
Date: Fri, 19 Feb 2016 14:35:44 -0800
Message-ID: <1455921344.8680.36.camel@linux.intel.com>
References: <1455793609.9851.45.camel@linux.intel.com>
	 <20160218113437.GX2610@vireshk-i7>
	 <1455871852.7321.4.camel@linux.intel.com>
	 <20160219091723.GB22812@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757484AbcBSWhL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 17:37:11 -0500
In-Reply-To: <20160219091723.GB22812@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dirk.j.brandewie@intel.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, lenb@kernel.org

On Fri, 2016-02-19 at 14:47 +0530, Viresh Kumar wrote:
> Adding the maintainers of the driver in cc now.
[...]
Hi Viresh,
> Hi Guys,
>=20
> Joonas reported a lockdep between cpufreq and intel-pstate driver and
> we are looking for probable solutions.
>=20
> I failed to understand why should we run intel_pstate_hwp_set() for
> each online CPU, while the frequency is changed only for a group of
> CPUs that belong to a policy.=20
Don't need from set_policy interface.=C2=A0
> Ofcourse intel_pstate_hwp_set() is
> required to be run for all CPUs, while the sysfs files are touched.
> And so, do we have a problem with below diff?
I gave a quick test, the change works fine.

Thanks,
Srinivas

