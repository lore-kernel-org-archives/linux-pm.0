From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Fri, 16 Aug 2013 13:44:56 +0100
Message-ID: <520E1EC8.1010001@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376628563.4255.137.camel@pasglop> <520DE753.8090601@arm.com> <1376656351.25016.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:60368 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab3HPMov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2013 08:44:51 -0400
In-Reply-To: <1376656351.25016.2.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>, "linux@openrisc.net" <linux@openrisc.net>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On 16/08/13 13:32, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 09:48 +0100, Sudeep KarkadaNagesha wrote:
> 
>>> Naming is a bit gross. You might want to make it clearer that
>>> we are talking about CPU IDs in the device-tree here.
>>>
>> Any particular preference to the name or just a note is sufficient.
>> Also unlike PPC, in ARM we don't set hard processor id value based
>> values read from device tree. DT must contain the values matching to the
>> hardware ID registers.
> 
> This is exactly the same on ppc. We don't "set" HW values. The
> device-tree content matches the HW internals. Some processors have a
> "PIR" register as well which contains the HW value, in this case the
> device-tree must contain the same value as the PIR on that processor.
> 
Ok, I misread the function 'set_hard_smp_processor_id' function.
BTW, you didn't mention if you are OK by just have this clearly
documented in the function and/or you have any preference/better name.

I will send the next version based on that. I have even compile tested
:) now on PPC.

Regards,
Sudeep


