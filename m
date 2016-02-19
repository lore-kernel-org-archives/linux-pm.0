From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: CPUfreq lockdep issue
Date: Fri, 19 Feb 2016 10:50:52 +0200
Message-ID: <1455871852.7321.4.camel@linux.intel.com>
References: <1455793609.9851.45.camel@linux.intel.com>
	 <20160218113437.GX2610@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423611AbcBSIuy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 03:50:54 -0500
In-Reply-To: <20160218113437.GX2610@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>

On to, 2016-02-18 at 17:04 +0530, Viresh Kumar wrote:
> On 18-02-16, 13:06, Joonas Lahtinen wrote:
> > Hi,
> >=20
> > The Intel P-state driver has a lockdep issue as described below. It
> > could in theory cause a deadlock if initialization and suspend were=
 to
> > be performed simultaneously. Conflicting calling paths are as follo=
ws:
> >=20
> > intel_pstate_init(...)
> > 	...cpufreq_online(...)
> > 		down_write(&policy->rwsem); // Locks policy->rwsem
> > 		...
> > 		cpufreq_init_policy(policy);
> > 			...intel_pstate_hwp_set();
> > 				get_online_cpus(); // Temporarily locks cpu_hotplug.lock
>=20
> Why is this one required?

Otherwise CPUs could be added or removed during the execution of
intel_pstate_hwp_set(), which has the following code:

=C2=A0 =C2=A0 =C2=A0 =C2=A0	get_online_cpus();
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for_each_online_cpu(cpu) {
		...
		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
	}
>=20
> > 		...
> > 		up_write(&policy->rwsem);
> >=20
> > pm_suspend(...)
> > 	...disable_nonboot_cpus()
> > 		_cpu_down()
> > 			cpu_hotplug_begin(); // Locks cpu_hotplug.lock
> > 			__cpu_notify(CPU_DOWN_PREPARE, ...);
> > 				...cpufreq_offline_prepare();
> > 					down_write(&policy->rwsem); // Locks policy->rwsem
> >=20
> > Quickly looking at the code, some refactoring has to be done to fix=
 the
> > issue. I think it would a good idea to document some of the driver
> > callbacks related to what locks are held etc. in order to avoid fut=
ure
> > situations like this.
> >=20
> > Because get_online_cpus() is of recursive nature and the way it
> > currently works, adding wider get_online_cpus() scope up around
> > cpufreq_online() does not fix the issue because it only momentarily
> > locks cpu_hotplug.lock and proceeds to do so again at next call.
> >=20
> > Moving get_online_cpus() completely away from pstate_hwp_set() and
> > assuring it is called higher in the call chain might be a viable
> > solution. Then it could be made sure get_online_cpus() is not calle=
d
> > while policy->rwsem is being held already.
>=20
> I don't think that will be a good solution. So what you are
> essentially saying is, take policy->rwsem after get_online_cpus()
> only.

Yes, grab the policy lock only after we've made sure we can apply the
policy to the online CPUs.

>=20
> > Do you think that would be an appropriate way of fixing it?
>=20
> At least I don't. Why do we need to call get_online_cpus()
> intel-pstate governor ?

See above for the code.

Regards, Joonas

>=20
--=20
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
