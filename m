From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT
 infrastructure
Date: Mon, 15 Jul 2013 14:59:58 +0200
Message-ID: <1373893198.4172.28.camel@weser.hi.pengutronix.de>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
	 <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>
	 <loom.20130715T124843-388@post.gmane.org> <51E3EC2C.2030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33332 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab3GONC3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 09:02:29 -0400
In-Reply-To: <51E3EC2C.2030803@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org

Am Montag, den 15.07.2013, 08:33 -0400 schrieb Eduardo Valentin:
> On 15-07-2013 08:12, Lucas Stach wrote:
> > Hi Eduardo and others,
> > 
> > Eduardo Valentin <eduardo.valentin <at> ti.com> writes:
> > 
> >>
> >> This patch improves the ti-soc-thermal driver by adding the
> >> support to build the thermal zones based on DT nodes.
> >>
> >> The driver will have two options now to build the thermal
> >> zones. The first option is the zones originally coded
> >> in this driver. So, the driver behavior will be same
> >> if there is no DT node describing the zones. The second
> >> option, when it is found a DT node with thermal data,
> >> will used the common infrastructure to build the thermal
> >> zone and bind its cooling devices.
> >>
> >> In either case, this driver still adds to the system
> >> a cpufreq cooling device.
> >>
> > 
> > I really like the idea to configure thermal zones using devicetree, it's a
> > step in the right direction. We might follow suit with the i.MX6 tempmon
> > driver to use this infrastructure.
> > 
> > What I strongly dislike is the notion of the sensor drivers instantiating
> > the cooling devices and the resulting devicetree binding. This seems really
> > backward to me.
> > I would rather see the drivers associated with the cooling devices (like
> > cpufreq and the respective gpu drivers) to instantiate the cooling devices
> > and the thermal zone referring to them through phandles. I think it
> > shouldn't be too much work to go in that direction.
> > The current method might be enough to work with the current thermal platform
> > drivers, but if you want to go down the route to eventually use plain i2c
> > devices (likely with an existing hwmon driver) you have to get away from the
> > sensor devices instantiating the cooling devices.
> 
> I agree with you. While implementing the RFC, it looks awkward that the
> ti-soc-thermal driver had to do the job to load the cpufreq-cooling
> device. Problem is that a cooling device is not really a real device,
> and might get flamed while represented as a device tree node.
> 
I don't think we even need to represent this into the device tree. We
already have the CPU nodes there and the cpu-freq driver is already
linked to those. It should be easy to have a global list of registered
thermal devices in the thermal framework together with their associated
devices, so one could look up cooling devices through the thermal
framework when we only have a phandle to the cpu node.

> I could try to push something following the same idea as the one I am
> trying to sell with this series for sensor devices. For instance, in a
> sensor node I am attaching a phandle to describe how thermal fw must
> behave. Then the sensor driver it is supposed to load the thermal data
> into the thermal fw. Same could apply for instance for cpufreq cooling
> device. at the cpu node we could have a 'cooling_device' node at the cpu
> node, while loading cpufreq-cpu0.

I think a separate cooling_device node may be only necessary if we stuff
additional info in there. If it's just a plain cooling device I think it
is reasonable for the cpufreq driver to just register a cooling device
if the thermal framework is there.

I would really like the information about a thermal zone to hang off one
dt node rather than being scattered over several nodes. This way it may
be easy to reference a cooling device in different thermal zones with
different weight, etc. As long as we define a thermal zone to always be
defined by a single sensor the right place seems to be the proposed
subnode to the sensor. If we want a zone to have more than one sensor,
we might even want a separate dt node for the thermal zone, referencing
both sensors and cooling devices through phandles.

Regards,
Lucas

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

