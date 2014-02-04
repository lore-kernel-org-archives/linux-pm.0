From: Nishanth Menon <nm@ti.com>
Subject: Re: Extending OPP bindings
Date: Tue, 4 Feb 2014 12:01:11 -0600
Message-ID: <52F12AE7.904@ti.com>
References: <52EA570A.8040501@arm.com> <52EAF1CA.3040702@ti.com> <20140131124620.GC2616@e102568-lin.cambridge.arm.com> <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com> <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbaBDSBn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Feb 2014 13:01:43 -0500
In-Reply-To: <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robherring2@gmail.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Shawn Guo <shawn.guo@linaro.org>, "mturquette@linaro.org" <mturquette@linaro.org>, Mark Brown <mark.brown@linaro.org>, Eduardo Valentin <eduardo.valentin@ti.com>

On 01/31/2014 12:09 PM, Lorenzo Pieralisi wrote:
> Hi Rob,
> 
> thanks for having a look.
> 
> On Fri, Jan 31, 2014 at 05:17:51PM +0000, Rob Herring wrote:
>> On Fri, Jan 31, 2014 at 6:46 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>> Hi Nishanth,
>>>
>>> On Fri, Jan 31, 2014 at 12:43:54AM +0000, Nishanth Menon wrote:
>>>> Hi Sudeep,
>>>>
>>>> On 01/30/2014 07:43 AM, Sudeep Holla wrote:
>>>>
>>>>>
>>>>> I am looking into a couple shortcomings in the current OPP bindings and
>>>>> how to address them. Feel free to add to the list if you think of any more
>>>>> issues that needs to be addressed or if and how any problem mentioned below
>>>>> can be handled with the existing bindings.
>>>>>
>>>>> 1. indexing: currently there are no indices in the operating-points.
>>>> indexing is based on frequency which is why the accessors use
>>>> frequency to pull out the OPP data.
>>>>
>>>> indexing is a horrible idea - on platforms where OPP may be disabled
>>>> or enabled for various reasons(see arch/arm/mach-imx/mach-imx6q.c,
>>>> arch/arm/mach-omap2/board-omap3beagle.c etc) - the indexing you see in
>>>> dts is just a myth that may not exist once the nodes are loaded and
>>>> operated upon depending on SoC variations (example efuse describing
>>>> which OPPs can be used and which not).
>>>
>>> I do not understand why. As long as a mapping from DT to data structures
>>> in the kernel is done at boot, I can see how by indexing device nodes
>>> can refer to specific OPPs. If they are disabled, amen, as long as we
>>> can point at specific operating points that should be ok.
>>>
>>> Indexing does not mean that the index in the DT is the same as the one
>>> allocated by the OS. Indexing is there to point at specific OPPs from
>>> different DT nodes, a good example are clock bindings and that's exactly
>>> how they work.
>>
>> That is not a good comparison. With clocks, you are describing which
>> physical signal coming out of a hardware block much like interrupts.
>> Granted the h/w is not typically documented that way for clocks
>> although the numbering could correspond to register bit locations as
>> interrupt numbers do. With OPP indexes, they are a totally made up
>> software construct.
> 
> Well ok, it might be, what I know is that current OPPs do not allow
> other nodes to reference their properties properly, I am not sure that adding
> an index make things worse, actually they are already broken as they are.

Let me look at this in two parts:
A: In kernel data representation:
If I were to use analogy of OPP library to database, A data base needs
a key to pick out data stored inside it -> the key in opp definition
as it stands right now is frequency. you can pick up any of the data
based on that key. proposal for using index into that table adds no
real value here.

Now, we can represent OPP data in many different forms. consider two
other properties per OPP (propx and propy)

data set #0:
   +------------+------------+---------+-------------+
   |   freq     | voltage    | propx   |  propy      |
   +-------------------------------------------------+
   | Fa         |  Va        |   PXa   |   PYa       |
   | Fb         |  Vb        |   PXb   |   PYb       |
   | Fc         |  Vc        |   PXc   |   PYc       |
   | Fd         |  Vd        |   PXd   |   PYd       |
   +------------+------------+---------+-------------+

Can then be represented as:
in opp library, considering it to be the least common denominator:
(data set #1)
   +------------+------------+
   |   freq     | voltage    |
   +--------------------------
   | Fa         |  Va        |
   | Fb         |  Vb        |
   | Fc         |  Vc        |
   | Fd         |  Vd        |
   +------------+------------+

where ever propx makes sense. (data set #2)
   +------------+---------+
   |   freq     | propx   |
   +-----------------------
   | Fa         |   PXa   |
   | Fb         |   PXb   |
   | Fc         |   PXc   |
   | Fd         |   PXd   |
   +------------+---------+

where ever propy makes sense (data set #3)
   +------------+-------------+
   |   freq     |  propy      |
   +--------------------------+
   | Fa         |   PYa       |
   | Fb         |   PYb       |
   | Fc         |   PYc       |
   | Fd         |   PYd       |
   +------------+-------------+

If my memory serves me right, in database terminology, this'd be first
normal form.

This also allows for data set #2 and #3 to modify or add a data set #4
with a propz at a later point in time without impacting set #1-3.

propx,y,z can be anything - efuse bits, cpuidle c state definition, etc..

As long as the key to the data sets are all the same (frequency),
information in data set #0 is maintained. It would be in our common
long term interest to maintain the split.

>> Perhaps OPPs should be nodes so new fields can be added easily and
>> then you have a phandle for each OPP.
> 
> Yeah, but the end result is the same, it has more to do with how to
> express dependencies with DT than the question on whether to use a phandle
> or an index. If we have to add phandles so be it, it is still just a way
> to reference properties for me.

B) Device tree representation of an OPP:
Here we have a ton of flexibility- I love the idea of representing
each OPP as a phandle - However, a phandle has been traditionally
meant to represent a device, I might be wrong, but i am not sure if we
have a precedence where phandle represents a property.

Having each OPP as a phandle does provide a lots of representation,
extensibility and reuse opportunity. but the same phandle will have to
be parsed by different drivers to pull out relevant data.

However when Sudeep introduced phandle approach, we did debate it's
representation and appropriate topology. if we can consider OPP as
it's own phandle and operating-points a list of OPP phandles, the pain
that we face in various driver usage can be simplified.


-- 
Regards,
Nishanth Menon
