From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: DT description of SRAM with power manageable banks
Date: Thu, 26 May 2016 22:48:01 +0300
Message-ID: <574752F1.6010408@mleia.com>
References: <57473709.1020108@mleia.com>
 <CAL_Jsq+R8E7UwAW+aUcmHPhgMS0D39C77kxgqwLK0_kTWHkWFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:47169 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885AbcEZTsF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 May 2016 15:48:05 -0400
In-Reply-To: <CAL_Jsq+R8E7UwAW+aUcmHPhgMS0D39C77kxgqwLK0_kTWHkWFw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sylvain Lemieux <slemieux.tyco@gmail.com>

Hi Rob,

On 26.05.2016 21:30, Rob Herring wrote:
> On Thu, May 26, 2016 at 12:48 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>> Hi DT team,
>>
>> let me ask you for advice how to extend a common "mmio-sram" compatible
>> binding description with information about power manageable banks,
>> which are specific to some SRAM. My main interest is to give a better
>> support of NXP LPC32xx SRAM, but as far as I know it concerns other
>> controllers from the LPC series, and maybe some other ones.
>>
>> Taking a simple visual example let's consider NXP LPC3250 SRAM, which
>> has four banks, three of them has independent power controls:
>>
>>         0x00000 - 0x0ffff (64KiB), always on-power bank,
>>         0x10000 - 0x1ffff (64KiB), power manageable bank
>>         0x20000 - 0x2ffff (64KiB), power manageable bank
>>         0x30000 - 0x3ffff (64KiB), power manageable bank
>>
>> All banks together form a single continuous address space, and it seems
>> important to have just one SRAM device and not 4, since e.g. in normal
>> runtime operation continuous 100KiB from the whole SRAM area are reserved
>> for storing MAC RX/TX buffers, it won't fit into one bank, however in
>> sleep mode (or when there is no users of some SRAM banks in runtime)
>> it is desirable to turn off unused banks, thus there should be a connection
>> between each power manageable bank and some power domain like this:
>>
>>         sram_pd: power-controller@110 {
>>                 compatible = "nxp,lpc3220-pos";
>>                 reg = <0x110 0x8>;
>>                 #power-domain-cells = <1>;
>>         };
>>
>> ...
>>
>>         sram-bank@08010000 {
>>                 reg = <0x08010000 0x10000>;
>>                 power-domains = <&sram_pd 0>;
>>         };
>>
>> ...
>>
>> The ordinary SRAM device node looks like
>>
>>         sram@08000000 {
>>                 compatible = "mmio-sram";
>>                 reg = <0x08000000 0x40000>;
>>         };
>>
>> and I would happy to have it just like that, and actually it works
>> perfectly, if the problem with delicate power management is ignored.
>> At least it demonstrates that a generic wide compatible "mmio-sram"
>> suits well here.
>>
>> The problem I face is in setting a proper layout of "sram@" and three
>> "sram-bank@" device nodes (remember 1 of 4 banks has no power control).
>> Unfortunately "sram-bank@" device nodes can not be children of "sram@",
>> because children of "mmio-sram" compatible device node play a role
>> of reserved areas ("partitions"), and that's not what I want. Moreover
>> reserved areas and power manageable banks are orthogonal, for instance
>> one reserved area may overlap with two power manageable banks or
>> vice versa.
>>
>> Questions I have concerning this case:
>>
>> 1) would it be correct to add the second compatible like this?
>>
>>         sram@08000000 {
>>                 compatible = "mmio-sram", "nxp,lpc3220-sram";
> 
> Yes, but reverse the order. Most specific first.
> 

Ok, thank you for correction.

>>                 reg = <0x08000000 0x40000>;
> 
> You can just add a single property like this:
> 
> power-domains = <&sram_pd 0>, <&sram_pd 1>, <&sram_pd 2>;
> 

Two notes regarding this.

1) either due to a bug/misfeature in Linux or intentionally power-domains
property handling doesn't accept multiple values, nor there are examples
of power-domains set to an array.

Of course it is quite trivial to extend, but here I want to get a
formal confirmation from DT and/or PM guys, that power-domains of one
device can contain links to several power domains.

2) in general usage of array of values assumes a presence of *-names
property, which might be better to avoid. As an artificial example
by some reason on a board someone would like to control power of
a subset of banks (or whatever device in general):

  power-domains = <&pd 0>, <&pd 2>;

Without power-domains-names or similar property it might be difficult
to describe this case, and I feel reluctant to introduce or anticipate
introduction of power-domains-names property, especially because
so far everyone is happy with just one power domain per device.

> The knowledge of what range each PD controls is encoded in the fact
> that the node is a "nxp,lpc3220-sram" and the information would stay
> in your driver.
> 
> Of course, if there's a lot of variation in sizes and domains, we may
> want to fully describe things in the DT.
> 
>>         };
>>
>> Or should I add the new compatible to device nodes of each of the power
>> manageable banks?
>>
>> 2) I assume that "sram-bank@" device nodes still should be descendants
>> of "sram@" node, but because children with "reg" property of "mmio-sram"
>> compatible device node can not be used to describe power manageable banks,
>> what name for an umbrella device node would you suggest? Would "banks" be
>> good enough? Should it have its own compatible?
> 
> I don't think you need all this, but in general you want to have
> compatible strings in each node (though there are many exceptions).
> 

If power-domains accepts only one value intentionally, then probably
every bank should have its own compatible, again not sure if it is
done by design, but in Linux PM domain consumers are devices only,
device implies own compatible, and, I don't know, in that case (one PM domain
per device) should I convert MMIO SRAM to a simple bus then?

>> 3) Do you think that reserved areas nodes should be placed under their
>> own device node with probably own compatible? So, something like it
>> was done recently with MTD partitions (compatible = "fixed-partitions").
> 
> If we did go down the path of have 2 sets of ranges, then yes.
> 

Please feel free to invite anyone to the discussion, who can advise/ack/nack
a soft conversion change of the currently accepted scheme for reserved
partitions to a potentially new one.

--
With best wishes,
Vladimir
