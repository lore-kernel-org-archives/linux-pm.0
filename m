From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Mon, 19 Aug 2013 08:02:52 -0500
Message-ID: <5212177C.8000709@gmail.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop> <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jonas Bonn <jonas@southpole.se>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 08/19/2013 05:19 AM, Mark Rutland wrote:
> On Sat, Aug 17, 2013 at 11:09:36PM +0100, Benjamin Herrenschmidt wrote:
>> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
>>> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
>>> which 
>>> the updated bindings[1] define #address-cells = <0> and so no reg 
>>> property.
>>>
>>> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795
>>
>> Why did you do that in the binding ? That sounds like looking to create
>> problems ... 
>>
>> Traditionally, UP setups just used "0" as the "reg" property on other
>> architectures, why do differently ?
> 
> The decision was taken because we defined our reg property to refer to
> the MPIDR register's Aff{2,1,0} bitfields, and on UP cores before v7
> there's no MPIDR register at all. Given there can only be a single CPU
> in that case, describing a register that wasn't present didn't seem
> necessary or helpful.

What exactly reg represents is up to the binding definition, but it
still should be present IMO. I don't see any issue with it being
different for pre-v7.

Rob

> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
