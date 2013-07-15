From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT
 infrastructure
Date: Mon, 15 Jul 2013 15:53:01 +0200
Message-ID: <1373896381.4172.48.camel@weser.hi.pengutronix.de>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
	  <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>
	  <loom.20130715T124843-388@post.gmane.org> <51E3EC2C.2030803@ti.com>
	 <1373893198.4172.28.camel@weser.hi.pengutronix.de>
	 <51E3F864.1060000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab3GONzd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 09:55:33 -0400
In-Reply-To: <51E3F864.1060000@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org

Am Montag, den 15.07.2013, 09:25 -0400 schrieb Eduardo Valentin:
> On 15-07-2013 08:59, Lucas Stach wrote:
> > Am Montag, den 15.07.2013, 08:33 -0400 schrieb Eduardo Valentin:
> >> On 15-07-2013 08:12, Lucas Stach wrote:
> >>> Hi Eduardo and others,
> >>>
> >>> Eduardo Valentin <eduardo.valentin <at> ti.com> writes:
> >>>
> >>>>
> >>>> This patch improves the ti-soc-thermal driver by adding the
> >>>> support to build the thermal zones based on DT nodes.
> >>>>
> >>>> The driver will have two options now to build the thermal
> >>>> zones. The first option is the zones originally coded
> >>>> in this driver. So, the driver behavior will be same
> >>>> if there is no DT node describing the zones. The second
> >>>> option, when it is found a DT node with thermal data,
> >>>> will used the common infrastructure to build the thermal
> >>>> zone and bind its cooling devices.
> >>>>
> >>>> In either case, this driver still adds to the system
> >>>> a cpufreq cooling device.
> >>>>
> >>>
> >>> I really like the idea to configure thermal zones using devicetree, it's a
> >>> step in the right direction. We might follow suit with the i.MX6 tempmon
> >>> driver to use this infrastructure.
> >>>
> >>> What I strongly dislike is the notion of the sensor drivers instantiating
> >>> the cooling devices and the resulting devicetree binding. This seems really
> >>> backward to me.
> >>> I would rather see the drivers associated with the cooling devices (like
> >>> cpufreq and the respective gpu drivers) to instantiate the cooling devices
> >>> and the thermal zone referring to them through phandles. I think it
> >>> shouldn't be too much work to go in that direction.
> >>> The current method might be enough to work with the current thermal platform
> >>> drivers, but if you want to go down the route to eventually use plain i2c
> >>> devices (likely with an existing hwmon driver) you have to get away from the
> >>> sensor devices instantiating the cooling devices.
> >>
> >> I agree with you. While implementing the RFC, it looks awkward that the
> >> ti-soc-thermal driver had to do the job to load the cpufreq-cooling
> >> device. Problem is that a cooling device is not really a real device,
> >> and might get flamed while represented as a device tree node.
> >>
> > I don't think we even need to represent this into the device tree. We
> > already have the CPU nodes there and the cpu-freq driver is already
> > linked to those. It should be easy to have a global list of registered
> > thermal devices in the thermal framework together with their associated
> > devices, so one could look up cooling devices through the thermal
> > framework when we only have a phandle to the cpu node.
> 
> Well, we do have a list of thermal cooling devices associated with its
> corresponding struct device. That is private data to the thermal
> framework. However, one needs to load the cooling device in order to its
> data structure appear in this list. The framework can not be proactive
> here. Some other entity needs to see the need and inform the thermal
> framework of it.
> 
That's why I said it would be a good idea (IMHO) if the cpufreq driver
would register the cooling device.

> For instance, assuming that all systems will need a cpufreq cooling
> device is a flaw, because that is not the case. Thus, it makes sense to
> have a property, say at the cpu node, to determine that it needs
> cooling. However, that won't be saying how it would cool off.
> 
Maybe I'm not up to speed with the thermal framework yet (just starting
to look into this), but isn't it the other way around? The thermal zone
is defined by the sensor providing temp readings and trip points. The
CPUs may be just one source of heat in the thermal zone, thus they have
to register a cooling device with the thermalfw, so they can be
throttled if the zone crosses a certain trip point.

I don't see how it would be problematic if the cpufreq driver just
always registers the cooling devices. If no thermal zone references them
they are of no use, but they are also not causing any harm.(?)
> 
> > 
> >> I could try to push something following the same idea as the one I am
> >> trying to sell with this series for sensor devices. For instance, in a
> >> sensor node I am attaching a phandle to describe how thermal fw must
> >> behave. Then the sensor driver it is supposed to load the thermal data
> >> into the thermal fw. Same could apply for instance for cpufreq cooling
> >> device. at the cpu node we could have a 'cooling_device' node at the cpu
> >> node, while loading cpufreq-cpu0.
> > 
> > I think a separate cooling_device node may be only necessary if we stuff
> > additional info in there. If it's just a plain cooling device I think it
> > is reasonable for the cpufreq driver to just register a cooling device
> > if the thermal framework is there.
> 
> no, I think this is not what we want, because, as I said, not all cpus
> will need cooling. Just because the thermal framework is there does not
> mean your cpu needs cooling. As you can see, the thermal framework is
> not only for cpu cooling. It can be used for any other thermal need.
> Besides one needs to cover for the case where you are building for
> multiple platform support. Assuming system needs based on Kconfig setup
> is not very likely to scale in this case.
> 
Mhm, I think we have a bit of a misunderstanding here. I don't see how
always registering the cooling devices from the cpufreq driver would be
in the way of multiplatform support. In fact if I know the cpufreq
registers the cooling device I can just reference the CPU node from
whatever thermal zone the particular platform happens to define.
 
> > 
> > I would really like the information about a thermal zone to hang off one
> > dt node rather than being scattered over several nodes. This way it may
> 
> Again, thermal framework is not about only cpu(freq) cooling. Thermal
> zone info can (and will) be hanged off in one dt node. But please don't
> mix concepts. Just because a cooling device is part of a thermal zone,
> it does not mean it is only used there and that it can be defined there.
> One can use a cooling device in different thermal zones.
> 
That's exactly what I want, so we seem to be on the same page.

I'm fine with having subnodes for the cooling devices, if we need to
stuff some sort of info in there. I'm just not sure if we need those
nodes at all, or if would be ok for the device drivers (cpufreq, gpu,
memory controller, etc.) to just register the cooling devices and
thermal zones to then look them up through the phandles of those parent
devices.
Again, I'm not an expert with this topic, just want to provide my view,
so we can work something out, which works for everybody on multiple
platforms. 

> > be easy to reference a cooling device in different thermal zones with
> > different weight, etc. As long as we define a thermal zone to always be
> > defined by a single sensor the right place seems to be the proposed
> > subnode to the sensor. If we want a zone to have more than one sensor,
> > we might even want a separate dt node for the thermal zone, referencing
> > both sensors and cooling devices through phandles.
> 
> I still don't get why and how defining a thermal zone inside a sensor
> phandle can prevent us defining a cooling device in different device
> phandle.
> 
I'm not saying this. What I said is that if we define the thermal zone
inside the sensor node it's inherently bound to this single sensor,
which is completely fine, as long as we keep the current definition of
one thermal zone per sensor. It's just that I stumbled about the
proposal to have more than one sensor per thermal zone. For this to work
we would have to define the thermal zone in it's own node, so that we
can reference multiple sensors. I just wanted to point this out, as it
seems fundamental to the design of the dt binding. Personally I'm fine
either way.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

