From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH v2 4/4] of: move of_get_cpu_node implementation to
 DT core library
Date: Mon, 19 Aug 2013 11:21:39 +0100
Message-ID: <5211F1B3.4080206@arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1376691273.25016.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376691273.25016.5.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

On 16/08/13 23:14, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
>> +#ifdef CONFIG_PPC
>> +               /* Check for historical "ibm,ppc-interrupt-server#s" property
>> +                * for thread ids on PowerPC. If it doesn't exist fallback to
>> +                * standard "reg" property.
>> +                */
>> +               if (__of_find_n_match_cpu_property(cpun,
>> +                               "ibm,ppc-interrupt-server#s", cpu, thread))
>> +                       return cpun;
>> +#endif
> 
> It's not "historical". It's still very much in use and well defined in PAPR :-)
> 
By historical, I meant it should not be used in future bindings.

Ah, sorry missed it in ePAPR, because its not under CPU node section.
What's more interesting is that ePAPR has it as an example for
non-standard property names :)

Can I mark it as custom/non-standard instead ? I mainly want to indicate
that we need to use 'reg' property and not introduce any more custom
properties for thread ids.

Can I add your ACK with this comment fixed ?

Regards,
Sudeep
