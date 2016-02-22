From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] intel-pstate: Update frequencies of policy->cpus only
 from ->set_policy()
Date: Mon, 22 Feb 2016 10:19:04 -0800
Message-ID: <1456165144.8680.64.camel@linux.intel.com>
References: <c94ae8c4f0c9cf30d916aa29a339b793db30aa3a.1456117057.git.viresh.kumar@linaro.org>
	 <36DF59CE26D8EE47B0655C516E9CE640286C694F@shsmsx102.ccr.corp.intel.com>
	 <20160222112714.GN28226@vireshk-i7>
	 <CAJZ5v0gma2UrBUAkouY4DpA9Pyu66KEShjrMfc+Nq174nNO_rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43950 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcBVSUh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Feb 2016 13:20:37 -0500
In-Reply-To: <CAJZ5v0gma2UrBUAkouY4DpA9Pyu66KEShjrMfc+Nq174nNO_rA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Mon, 2016-02-22 at 13:54 +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 22, 2016 at 12:27 PM, Viresh Kumar <viresh.kumar@linaro.o
> rg> wrote:
> > Hi,
> >=20
> > I am not really an intel-pstate driver guy, just wrote the patch
> > based
> > on software-review of the stuff :)
> >=20
> > On 22-02-16, 10:17, Chen, Yu C wrote:
> > > IIRC,
> > > 1.HWP is=C2=A0=C2=A0hardwarely per-package, CPUs inside one packa=
ge have
> > > one shared HWP.
> > > 2.Currently all the CPUs share the same HWP settings according to
> > > intel_pstate design.
> > > 3.=C2=A0=C2=A0The policy is per-cpu in intel_pstate driver.(polic=
y->cpus
> > > only contains one cpu)
> > >=20
> > > So with this patch applied,=C2=A0=C2=A0it is likely CPUs may have=
 different
> > > HWP settings?
> >=20
> > I think the hardware should be able to cope with that, and should
> > be
> > selecting the frequency based on the highest frequency requested
> > for
> > the same package. Otherwise, why should there be an option to
> > supply
> > per-cpu settings ?
>=20
> Right.
>=20
> I can easily imagine a use case in which someone may want to have
> different ranges for different CPUs.
>=20
> > > For example:
> > > CPU 0 belongs to package A with policy 0, and CPU 1 belongs to
> > > package B with policy 1,
> > > If you change the policy 0 from powersave to performance, then
> > > only CPU0 will update its
> > > min/max freq in HWP, however we should also update CPU 2's
> > > min/max in HWP settings?
> > > Plz correct me=C2=A0=C2=A0if I'm wrong..
> >=20
> > I will let the official intel-pstate guys reply to that.
>=20
> My opinion is to do what your patch does until that proves to be a
> problem in practice.
>=20
I agree. If someone just changes policy in one CPU, even with current
code (before this patch) we have issue, we will change the limits in
processor for all online CPUs, but cpufreq core policy will be update
for current CPU only. I suggest users to use cpupower like utility if
someone want to change policy, which will change for all.

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
