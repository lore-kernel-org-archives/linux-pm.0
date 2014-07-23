From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] PM/CPU: Parallel enabling nonboot cpus with resume
 devices
Date: Wed, 23 Jul 2014 17:48:52 +0800
Message-ID: <53CF8504.6030806@intel.com>
References: <1406106694-3306-1-git-send-email-tianyu.lan@intel.com> <20140723092154.GH20603@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12102 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757022AbaGWJvg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Jul 2014 05:51:36 -0400
In-Reply-To: <20140723092154.GH20603@laptop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, toshi.kani@hp.com, mingo@kernel.org, akpm@linux-foundation.org, todd.e.brandt@linux.intel.com, fabf@skynet.be, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On 2014=E5=B9=B407=E6=9C=8823=E6=97=A5 17:21, Peter Zijlstra wrote:
> On Wed, Jul 23, 2014 at 05:11:34PM +0800, Lan Tianyu wrote:
>> In the current world, all nonboot cpus are enabled serially during s=
ystem
>> resume. System resume sequence is that boot cpu enables nonboot cpu =
one by
>> one and then resume devices. Before resuming devices, there are few =
tasks
>> assigned to nonboot cpus after they are brought up. This waste cpu u=
sage.
>>
>> To accelerate S3, this patches adds a new kernel configure
>> PM_PARALLEL_CPU_UP_FOR_SUSPEND to allow boot cpu to go forward to re=
sume
>> devices after bringing up one nonboot cpu. The nonboot cpu will be i=
n charge
>> of bringing up other cpus. This makes enabling cpu2~x parallel with =
resuming
>> devices. From the test result on 4 logical core laptop, the time of =
resume
>> device almost wasn't affected by enabling nonboot cpus lately while =
the start
>> point is almost 30ms earlier than before.
>=20
> Why is this a CONFIG and why do we want to add more warts to the cpu
> hotplug instead of fixing it 'proper'?
>=20

Hi Peter:
	Thank you for your review. Because I just tested this patch on x86
platform and didn't want to cause some regressions on the other
platforms. So I made it as a new CONFIG. In theory, this should not
cause some problems. If none objects, it can be the default behavior.

--=20
Best regards
Tianyu Lan
