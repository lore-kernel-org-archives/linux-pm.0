From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] PM/CPU: Parallel enabling nonboot cpus with resume
 devices
Date: Thu, 24 Jul 2014 10:00:29 +0800
Message-ID: <53D068BD.6090701@intel.com>
References: <1406106694-3306-1-git-send-email-tianyu.lan@intel.com> <20140723105304.GA22675@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53749 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771AbaGXCCx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Jul 2014 22:02:53 -0400
In-Reply-To: <20140723105304.GA22675@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, len.brown@intel.com, peterz@infradead.org, toshi.kani@hp.com, mingo@kernel.org, akpm@linux-foundation.org, todd.e.brandt@linux.intel.com, fabf@skynet.be, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 2014=E5=B9=B407=E6=9C=8823=E6=97=A5 18:53, Pavel Machek wrote:
> Hi!
>=20
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
> Does this mean that userspace can now run seeing the "offlined" cpus
> still in offline state?

No, the PM event handler of cpu hotplug will reenable cpu hotplug via
cpu_hotplug_enable() at the end of system resume. The function will wai=
t
for currently running cpu hotplug operations to complete.

>=20
> 									Pavel
>=20


--=20
Best regards
Tianyu Lan
