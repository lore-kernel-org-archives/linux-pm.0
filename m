From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Fri, 16 Aug 2013 09:48:19 +0100
Message-ID: <520DE753.8090601@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1376628563.4255.137.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46598 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab3HPIsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2013 04:48:16 -0400
In-Reply-To: <1376628563.4255.137.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>, "linux@openrisc.net" <linux@openrisc.net>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On 16/08/13 05:49, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-15 at 18:09 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently different drivers requiring to access cpu device node are
>> parsing the device tree themselves. Since the ordering in the DT need
>> not match the logical cpu ordering, the parsing logic needs to consider
>> that. However, this has resulted in lots of code duplication and in some
>> cases even incorrect logic.
> 
>  .../...
> 
>>  
>> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> +{
>> +	return (int)phys_id == get_hard_smp_processor_id(cpu);
>> +}
> 
> Naming is a bit gross. You might want to make it clearer that
> we are talking about CPU IDs in the device-tree here.
> 
Any particular preference to the name or just a note is sufficient.
Also unlike PPC, in ARM we don't set hard processor id value based
values read from device tree. DT must contain the values matching to the
hardware ID registers.

>> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
>> +			const char *prop_name, int cpu, unsigned int *thread)
>> +{
>> +	const __be32 *cell;
>> +	int ac, prop_len, tid;
>> +	u64 hwid;
>> +
>> +	ac = of_n_addr_cells(cpun);
>> +	cell = of_get_property(cpun, prop_name, &prop_len);
>> +	if (!cell)
>> +		return false;
>> +	prop_len /= sizeof(*cell);
>> +	for (tid = 0; tid < prop_len; tid++) {
>> +		hwid = of_read_number(cell, ac);
>> +		if (arch_match_cpu_phys_id(cpu, hwid)) {
>> +			if (thread)
>> +				*thread = tid;
>> +			return true;
>> +		}
> 
> Missing:          cell += ac;
Ah, missed it while refactoring, will fix it. Thanks

Regards,
Sudeep




