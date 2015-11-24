From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 24 Nov 2015 15:57:09 +0100
Message-ID: <56547AC5.8030101@samsung.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <12277717.3uaUoj5Hzc@vostro.rjw.lan> <564D919B.4030107@samsung.com>
 <5195200.TAaTCrzPYp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:17725 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbKXO5x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 09:57:53 -0500
In-reply-to: <5195200.TAaTCrzPYp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On 11/19/2015 11:04 PM, Rafael J. Wysocki wrote:
> On Thursday, November 19, 2015 10:08:43 AM Andrzej Hajda wrote:
>> On 11/18/2015 03:17 AM, Rafael J. Wysocki wrote:
>>> On Tuesday, November 17, 2015 01:44:59 PM Andrzej Hajda wrote:
>>>> Hi Rafael,
>>>>
> [cut]
>
>>> So the operations that need to be taken care of are:
>>> - Probe (suppliers need to be probed before consumers if the dependencies are
>>>   known beforehand).
>>> - System suspend/resume (suppliers need to be suspended after consumers and
>>>   resumed before them) which may be asynchronous (so simple re-ordering doesn't
>>>   help).
>>> - Runtime PM (suppliers should not be suspended if the consumers are not
>>>   suspended).
>> I though provider's frameworks are taking care of it already. For example
>> clock provider cannot suspend until there are prepared/enabled clocks.
>> Similar enabled regulators, phys should block provider from runtime pm
>> suspending.
>>
>> Are there situations/frameworks which requires additional care?
> Yes, there are, AFAICS.
>
> A somewhat extreme example of this is when an AML routine needed for power
> management of one device uses something like a GPIO line or an I2C link
> provided by another one.  We don't even have a way to track that kind of
> thing at the provider framework level and the only information we can get
> from the platform firmware is "this device depends on that one".
>
> Plus, even if the frameworks track those things, when a device suspend is
> requested, the question really is "Are there any devices that have to be
> suspended before this one?" rather than "Are other devices using resources
> provided by this one?".  Of course, you may argue that answering the second
> one will allow you to answer the first one too (that is based on the assumption
> that you can always track all cases of resource utilization which may not be
> entirely realistic), but getting that answer in a non-racy way may be rather
> expensive.

In such extreme case the device itself can play a role of resource.
But in my proposal I do not try to answer which devices/resource depends
on which ones, we do not need such info.
It is just matter of notifying direct consumers about change of availability
of given resource, and this notification is necessary anyway if we want
to support hot resource/drivers (un-)plugging.


>
>>> - System shutdown (shutdown callbacks should be executed for consumers first).
>>> - Driver unbind (a supplier driver cannot be unbound before any of its consumer
>>>   drivers).
>>>
>>> In principle you can use resource tracking to figure out all of the involved
>>> dependencies, but that would require walking complicated data structures unless
>>> you add an intermediate "device dependency" layer which is going to be analogous
>>> to the one discussed here.
>> It should be enough if provider notifies consumers that the resource
>> will be unavailable.
> To me, this isn't going in the right direction.  You should be asking "Am I
> allowed to suspend now?" instead of saying "I'm suspending and now you deal
> with it" to somebody.  Why is that so?  Because the other end may simply be
> unable to deal with the situation in the first place.

No. It is just saying "I want to suspend now, please not use my resources".
In such case consumer should unprepare clocks, disable regulators, etc.
But if it is not able to do so it just ignores the request. Provider
will know
anyway that his resources are in use and will not suspend.

>
>>>>> My idea is to represent a supplier-consumer dependency between devices (or
>>>>> more precisely between device+driver combos) as a "link" object containing
>>>>> pointers to the devices in question, a list node for each of them and some
>>>>> additional information related to the management of those objects, ie.
>>>>> something like:
>>>>>
>>>>> struct device_link {
>>>>> 	struct device *supplier;
>>>>> 	struct list_head supplier_node;
>>>>> 	struct device *consumer;
>>>>> 	struct list_head consumer_node;
>>>>> 	<flags, status etc>
>>>>> };
>>>>>
>>>>> In general, there will be two lists of those things per device, one list
>>>>> of links to consumers and one list of links to suppliers.
>>>>>
>>>>> In that picture, links will be created by calling, say:
>>>>>
>>>>> int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);
>>>>>
>>>>> and they will be deleted by the driver core when not needed any more.  The
>>>>> creation of a link should also cause dpm_list and the list used during shutdown
>>>>> to be reordered if needed.
>>>>>
>>>>> In principle, it seems usefult to consider two types of links, one created
>>>>> at device registration time (when registering the second device from the linked
>>>>> pair, whichever it is) and one created at probe time (of the consumer device).
>>>>> I'll refer to them as "permanent" and "probe-time" links, respectively.
>>>>>
>>>>> The permanent links (created at device registration time) will stay around
>>>>> until one of the linked devices is unregistered (at which time the driver
>>>>> core will drop the link along with the device going away).  The probe-time
>>>>> ones will be dropped (automatically) at the consumer device driver unbind time.
>>>> What about permanent links in case provider is unregistered? Should they
>>>> disappear? It will not make consumers happy. What if the provider will be
>>>> re-registered.
>>> If the device object is gone, it cannot be pointed to by any links (on any end)
>>> any more.  That's just physically impossible. :-)
>> So the link will disappear and the 'consumer' will have dependencies
>> fulfilled.
> That's why in my opinion the rule should be that all consumers are unbound from
> their drivers before the supplier is unbound from its driver.

But the rule will not work with 'weak' dependencies.

>
>> It will be then probed? Is it OK? Or am I missing something?
> If one driver depends on a service provided by another one for correctness,
> then it won't work anyway if its supplier goes away no matter what.
>
>>>>> There's a question about what if the supplier device is being unbound before
>>>>> the consumer one (for example, as a result of a hotplug event).  My current
>>>>> view on that is that the consumer needs to be force-unbound in that case too,
>>>>> but I guess I may be persuaded otherwise given sufficiently convincing
>>>>> arguments.
>>>> Some devices can have 'weak' dependencies - they will be still functional
>>>> without some resources.
>>> Right.  That's on my radar.
>>>
>>>> In fact two last examples from my 1st paragraph are
>>>> counter-examples for this. I suspect there should be some kind of notification
>>>> for them about removal of the resource.
>>>>
>>>>> Anyway, there are reasons to do that, like for example it may
>>>>> help with the synchronization.  Namely, if there's a rule that suppliers
>>>>> cannot be unbound before any consumers linked to them, than the list of links
>>>>> to suppliers for a consumer can only change at its registration/probe or
>>>>> unbind/remove times (which simplifies things quite a bit).
>>>>>
>>>>> With that, the permanent links existing at the probe time for a consumer
>>>>> device can be used to check whether or not to defer the probing of it
>>>>> even before executing its probe callback.  In turn, system suspend
>>>>> synchronization should be a matter of calling device_pm_wait_for_dev()
>>>>> for all consumers of a supplier device, in analogy with dpm_wait_for_children(),
>>>>> and so on.
>>>>>
>>>>> Of course, the new lists have to be stable during those operations and ensuring
>>>>> that is going to be somewhat tricky (AFAICS right now at least), but apart from
>>>>> that the whole concept looks reasonably straightforward to me.
>>>>>
>>>>> So, the question to everybody is whether or not this sounds reasonable or there
>>>>> are concerns about it and if so what they are.  At this point I mostly need to
>>>>> know if I'm not overlooking anything fundamental at the general level.
>>>> Regarding fundamental things, maybe it is just my impression but parsing private
>>>> DT device nodes by kernel core assumes that convention about using resource
>>>> specifiers in DT is a strict rule, it should not be true.
>>> I really am not sure what you mean here, sorry.
>> Device tree bindings are defined per device so theoretically only device
>> driver
>> should parse them(except few basic properties). This is of course only my
>> impression, but even in this thread Mark made similar statement [1].
> No, DT bindings are not for exclusive use of a device driver.  They provide
> information about the system configuration and layout to the OS as a whole.
> Some of that information may only be relevant to device drivers, but not all
> of it.
>
> Some types of resources need to be tracked globally (take address ranges in
> the memory address space, for example), some are used by frameworks without
> drivers' knowledge etc.
>
>> Assuming this, permanent links should not be used with device tree, as a
>> result
>> deferred probing will be still a problem.
>>
>> [1]: http://permalink.gmane.org/gmane.linux.power-management.general/67593
> I'm not sure how you have derived this conclusion.  It seems to reach too far
> to me.

Lets drop my impressions, as there is no specification to verify it.

What about resources which are present in device node, but driver do
not use for some reason? Only driver knows which ones it requires in
the specific scenario. Real example: HDMI node can contain links
to SPDIF/audio clocks but since kernel is compiled without audio it
will not use them at all. How do driver core will know about it.

>
>>>> As I wrote before I have send some early RFC with framework which solves most of
>>>> the problems described here[1], the missing part is suspend/resume support which
>>>> should be quite easy to add, I suspect. Moreover it solves problem of device
>>>> driver hot bind/unbind.
>>>> Could you take a look at it, I will be glad to know it is worth to continue work
>>>> on it?
>>>>
>>>> [1]: https://lkml.org/lkml/2014/12/10/342
>>> I'm not sure to be honest.
>>>
>>> I'm not a big fan of notification-based mechanisms in general, because they
>>> depend on everyone registering those notifiers to implement them correctly and
>>> it gets additionally complicated if the ordering matters etc.  So I personally
>>> wouldn't take that route.
>>>
>>> I guess some way of resource tracking will be necessary at one point, but what
>>> shape it should take is a good question.
>> Any callback provided by a driver including probe/remove are in fact
>> notification mechanisms :) And they should be also correctly implemented.
>> Ordering in case of resource tracking is enforced by the framework, so I do
>> not see complication here.
>>
>> Anyway if we take two assumptions which are already true:
>> - device bound to driver can provide resources,
>> - device driver can be unloaded/unbound at any time.
>> Then notifications/callbacks seems to me the only solution.
> Unbinding a supplier driver can cause consumer drivers to be unbound
> automatically too.

As I said before, it will not work with 'weak' dependencies.

>
> As I said above, if one driver depends on a service provided by another one
> for correctness, it won't work after the first one is unbound no matter what.
> Since device_release_driver() works unconditionally, there is no choice but to
> make it unbind all consumers with hard dependencies before unbinding the
> device itself.
>
> Notifying them won't help if they can't recover from that condition anyway.

But there are cases devices can work without some resources.

>
> It may be a good idea to reprobe them then in case they can work without the
> missing supplier too, or to put them into the deferred probe list in case the
> supplier appears again.  All of that is sort of academic, though, unless we
> have real use cases like that to deal with.

Real hardware case(it is not correctly modeled in drivers):
HDMI generates clock, which is used by Display Controller.
Display Controller then generates new clock based on the 1st one.
The latter is used by HDMI.
This is real example from latest Exynos SoCs.
How do you want to model these dependencies using devices?

Regards
Andrzej

>
> Thanks,
> Rafael
>
>

