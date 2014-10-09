From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH V3 0/3] PM/CPU: Parallel enalbing nonboot cpus with
 resume devices
Date: Thu, 09 Oct 2014 09:18:45 +0800
Message-ID: <5435E275.3030307@intel.com>
References: <1411633925-9018-1-git-send-email-tianyu.lan@intel.com> <20141008205441.GJ4750@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18706 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbaJIBXJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Oct 2014 21:23:09 -0400
In-Reply-To: <20141008205441.GJ4750@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, rafael.j.wysocki@intel.com, toshi.kani@hp.com, akpm@linux-foundation.org, ktkhai@parallels.com, fabf@skynet.be, laijs@cn.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, srivatsa@mit.edu, viresh.kumar@linaro.org, todd.e.brandt@linux.intel.com, tipbot@zytor.com, wangyun@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On 2014=E5=B9=B410=E6=9C=8809=E6=97=A5 04:54, Peter Zijlstra wrote:
> On Thu, Sep 25, 2014 at 04:32:02PM +0800, Lan Tianyu wrote:
>> This patchset is to parallel enabling nonboot cpus with resuming dev=
ices
>> during system resume in order to accelerate S2RAM. From test result =
on
>> a 8 logical core Haswell machine, system resume time reduces from 34=
7ms
>> to 217ms with this patchset.
>>
>> In the current world, all nonboot cpus are enabled serially during s=
ystem
>> resume. System resume sequence is that boot cpu enables nonboot cpu =
one by
>> one and then resume devices. Before resuming devices, there are few =
tasks
>> assigned to nonboot cpus after they are brought up. This wastes cpu =
usage.
>>
>> This patchset is to allow boot cpu to go forward to resume devices a=
fter
>> bringing up one nonboot cpu and starting a thread. The thread will b=
e in
>> charge of bringing up other frozen cpus. The thread will be schedule=
d to
>> the first online cpu to run . This makes enabling cpu2~x parallel wi=
th
>> resuming devices.
>=20
> So I feel we should really clean up hotplug before doing anything lik=
e
> this. Its a trainwreck and just piling more and more hacks ontop isn'=
t
> going to help any.
>=20

Hi Peter:
	Sorry, I don't know the gap of hotplug clearly. Could you elaborate it=
?
--=20
Best regards
Tianyu Lan
