From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] intel-pstate: Update frequencies of policy->cpus only
 from ->set_policy()
Date: Mon, 22 Feb 2016 13:54:57 +0100
Message-ID: <CAJZ5v0gma2UrBUAkouY4DpA9Pyu66KEShjrMfc+Nq174nNO_rA@mail.gmail.com>
References: <c94ae8c4f0c9cf30d916aa29a339b793db30aa3a.1456117057.git.viresh.kumar@linaro.org>
	<36DF59CE26D8EE47B0655C516E9CE640286C694F@shsmsx102.ccr.corp.intel.com>
	<20160222112714.GN28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33570 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcBVMy7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 07:54:59 -0500
In-Reply-To: <20160222112714.GN28226@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Mon, Feb 22, 2016 at 12:27 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> I am not really an intel-pstate driver guy, just wrote the patch based
> on software-review of the stuff :)
>
> On 22-02-16, 10:17, Chen, Yu C wrote:
>> IIRC,
>> 1.HWP is  hardwarely per-package, CPUs inside one package have one shared HWP.
>> 2.Currently all the CPUs share the same HWP settings according to intel_pstate design.
>> 3.  The policy is per-cpu in intel_pstate driver.(policy->cpus only contains one cpu)
>>
>> So with this patch applied,  it is likely CPUs may have different HWP settings?
>
> I think the hardware should be able to cope with that, and should be
> selecting the frequency based on the highest frequency requested for
> the same package. Otherwise, why should there be an option to supply
> per-cpu settings ?

Right.

I can easily imagine a use case in which someone may want to have
different ranges for different CPUs.

>> For example:
>> CPU 0 belongs to package A with policy 0, and CPU 1 belongs to package B with policy 1,
>> If you change the policy 0 from powersave to performance, then only CPU0 will update its
>> min/max freq in HWP, however we should also update CPU 2's min/max in HWP settings?
>> Plz correct me  if I'm wrong..
>
> I will let the official intel-pstate guys reply to that.

My opinion is to do what your patch does until that proves to be a
problem in practice.

Thanks,
Rafael
