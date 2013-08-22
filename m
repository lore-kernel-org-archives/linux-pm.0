From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Thu, 22 Aug 2013 16:32:10 +0100
Message-ID: <52162EFA.2070108@arm.com>
References: <51F9341E.60102@ti.com> <20130731161103.GS29859@e106331-lin.cambridge.arm.com> <51F93AFB.1030104@ti.com> <20130801135422.GA8095@e106331-lin.cambridge.arm.com> <51FA8BE2.9000309@ti.com> <20130802131541.GN2884@e106331-lin.cambridge.arm.com> <20130806134534.GB6603@kahuna> <20130807161722.GJ28558@e106331-lin.cambridge.arm.com> <52133E26.1000801@arm.com> <521543AC.4020709@wwwdotorg.org> <20130822115957.GC9799@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130822115957.GC9799@e106331-lin.cambridge.arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Nishanth Menon <nm@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 22/08/13 12:59, Mark Rutland wrote:
> On Wed, Aug 21, 2013 at 11:48:12PM +0100, Stephen Warren wrote:
>> On 08/20/2013 04:00 AM, Sudeep KarkadaNagesha wrote:
>> ...
>>> Until we get more feedback and agreement on new proposal can we have
>>> this simple amendment in this patch to the existing binding ? Since the
>>> new proposal[1] is backward compatible(this patch adding support for
>>> option#5 to existing option#1), we will have to add support for other
>>> binding options in [1] later.
>>>
>>> This is needed to support shared OPPs with simple/single OPP profile
>>> and also to fix the broken and unused binding
>>> @Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
>>>
>>> Regards,
>>> Sudeep
>>>
>>> [1] http://www.spinics.net/lists/cpufreq/msg06563.html
>>
>> Presumably the desire for cpu1's node to say "go look at cpu0's node for
>> OPP" is because they share OPPs. Don't they share OPPs because they are
>> parts of the same device - that device being the CPU complex. As such,
>> why not define the OPPs in /cpus rather than in each of /cpus/cpuN?
> 
> I'd very much like for it to be possible to factor out common properties
> into the /cpus node, but it should follow the ePAPR recommendation fo
> being treated as a fallback if not present in a particular /cpus/cpu@N
> node -- that way we can handle clusters with differing OPPs. The
> property might just be a phandle to a table node, but it should be
> possible to make it common.
> 
Yes we can have this fallback mechanism, but only from cpu devices(OPP
library handles non-cpu devices too).

Referring the table node, I have a generic question on DT nodes.
Does each DT node have to represent a unique device ? If so having a
property common to one/more devices in a separate node doesn't sound
correct.

>>
>> Of course, that doesn't help if there are separate CPU and GPU nodes
>> that just happen to have the same set of OPPs and you want to share them
>> to save DT space. Is that at all likely?
> 
> I suspect that the OPPs for CPUs and GPUs are likely to be quite
> distict, and they are logically separate regardless. I'm not averse to
> sharing of tables if we can handle them in a standard fashion.
> 
IMO sharing OPPs just for saving DT space might lead to confusions(no
strong opinion though).

>>
>> I'd suggest/bike-shed that operating-points-device is not the correct
>> property name; it somehow implies that the other device actively defines
>> the OPPs for this device, rather than just happening to have the same
>> OPPs. Perhaps "operating-points-identical-to"?
>>
> 
> I'd rather not have properties that point elsewhere and say "treat me
> the same as this node". I'd rather we have common properties as
> described above.
> 
Agreed, but for platforms with multiple CPU clusters, since we have only
one /cpus node, we ned to have table node which is arguable if node has
represent a device(as mentioned above)

Regards,
Sudeep



