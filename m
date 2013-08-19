From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Mon, 19 Aug 2013 11:13:27 +0100
Message-ID: <5211EFC7.9090800@arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1376691186.25016.4.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:32773 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab3HSKNM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2013 06:13:12 -0400
In-Reply-To: <1376691186.25016.4.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On 16/08/13 23:13, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
>> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
>> +                       const char *prop_name, int cpu, unsigned int
>> *thread)
>> +{
>> +       const __be32 *cell;
>> +       int ac, prop_len, tid;
>> +       u64 hwid;
>> +
>> +       ac = of_n_addr_cells(cpun);
>> +       cell = of_get_property(cpun, prop_name, &prop_len);
>> +       if (!cell)
>> +               return false;
>> +       prop_len /= sizeof(*cell);
>> +       for (tid = 0; tid < prop_len; tid++) {
>> +               hwid = of_read_number(cell, ac);
>> +               if (arch_match_cpu_phys_id(cpu, hwid)) {
>> +                       if (thread)
>> +                               *thread = tid;
>> +                       return true;
>> +               }
>> +               cell += ac;
>> +       }
>> +       return false;
>> +}
> 
> The only problem I can see here is if "ac" is not 1, that will not work
> for the ibm,ppc-interrupt-server#s case. IE. The latter is always 1 cell
> per entry, only "reg" depends on #address-cells.
> 
> However that's only a theorical problem since on ppc #address-cells of
> /cpus is always 1...
> 
Ok agreed, but I assume in future if thread ids need 2 ac, it would use
standard 'reg' instead of 'ibm,ppc-interrupt-server#' property.

So I assume the above function is generic and need not be modified to
handle non '1' ac case  with non standard 'ibm,ppc-interrupt-server#'.

Regards,
Sudeep

