From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] intel-pstate: Update frequencies of policy->cpus only
 from ->set_policy()
Date: Mon, 22 Feb 2016 10:17:54 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286C694F@shsmsx102.ccr.corp.intel.com>
References: <c94ae8c4f0c9cf30d916aa29a339b793db30aa3a.1456117057.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c94ae8c4f0c9cf30d916aa29a339b793db30aa3a.1456117057.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Kumar,
> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Viresh Kumar
> Sent: Monday, February 22, 2016 12:58 PM
> To: Rafael Wysocki; Srinivas Pandruvada; Len Brown; Viresh Kumar
> Cc: linaro-kernel@lists.linaro.org; linux-pm@vger.kernel.org; Joonas Lahtinen;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] intel-pstate: Update frequencies of policy->cpus only from
> ->set_policy()
> 
> The intel-pstate driver is using intel_pstate_hwp_set() from two separate
> paths, i.e. ->set_policy() callback and sysfs update path for the files present
> in /sys/devices/system/cpu/intel_pstate/ directory.
> 
> While an update to the sysfs path applies to all the CPUs being managed by
> the driver (which essentially means all the online CPUs), the update via the -
> >set_policy() callback applies to a smaller group of CPUs managed by the
> policy for which ->set_policy() is called.
> 
> And so, intel_pstate_hwp_set() should update frequencies of only the CPUs
> that are part of policy->cpus mask, while it is called from
> ->set_policy() callback.
> 
> In order to do that, add a parameter (cpumask) to intel_pstate_hwp_set()
> and apply the frequency changes only to the concerned CPUs.
> 
> For ->set_policy() path, we are only concerned about policy->cpus, and so
> policy->rwsem lock taken by the core prior to calling ->set_policy() is enough
> to take care of any races. The larger lock acquired by
> get_online_cpus() is required only for the updates to sysfs files.
> 
IIRC,
1.HWP is  hardwarely per-package, CPUs inside one package have one shared HWP.
2.Currently all the CPUs share the same HWP settings according to intel_pstate design.
3.  The policy is per-cpu in intel_pstate driver.(policy->cpus only contains one cpu)

So with this patch applied,  it is likely CPUs may have different HWP settings?
For example:
CPU 0 belongs to package A with policy 0, and CPU 1 belongs to package B with policy 1,
If you change the policy 0 from powersave to performance, then only CPU0 will update its
min/max freq in HWP, however we should also update CPU 2's min/max in HWP settings?
Plz correct me  if I'm wrong..

thanks,
yu
