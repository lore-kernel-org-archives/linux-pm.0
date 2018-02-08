From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Thu, 8 Feb 2018 12:45:17 +0200
Message-ID: <20180208104517.GA7655@kuha.fi.intel.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <e2cb104f53e20a01f3b44442068c549e5d0e1ac3.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130131131.GF14922@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeBHKpW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Feb 2018 05:45:22 -0500
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

Hi Adam,

On Tue, Feb 06, 2018 at 03:51:26PM +0000, Adam Thomson wrote:
> Right now there is no documentation for the generic psy class. The stuff in
> sysfs-class-power is device specific property information, and the same goes for
> sysfs-class-power-twl4030. The property usage can vary depending on driver
> implementation, an example being the 'online' property which can differ between
> drivers, so the usage I have here is very much tcpm related. Also, the ability
> to write to certain properties varies depending on the driver and HW, so here
> where we configure 'voltage_now' and 'current_now', the likelihood is that most
> other psy driver implementations won't allow for this.

The power supply class is missing documentation, YES! That is what I
have been saying! The fact that even an attribute like "online" can
mean different things depending on the driver is absolutely horrible.
The ABI documentation FOR THE POWER SUPPLY CLASS needs to provide
clear meaning for the attributes. It needs to also point out which
attributes can be hidden, and it should also give some hints for
things like which attributes can be expected to be visible for example
in case of USB type of psy and so on.

We are talking about user space ABI for power supplies here. The user
space does not know that its dealing with tcpm in this case, or some
other driver in an other case, AND, the user space _must_ not be
expected to know that kind of details. The behaviour and meaning of an
individual attribute file quite simply has to be the same, always,
regardless of the platform, HW, driver or whatever. Otherwise this
whole ABI is completely useless.

Working around the issue of missing guidelines and documentation for
subsystem ABI by providing it for the device drivers instead is not
acceptable. If you don't want to propose documentation for the class,
don't propose any documentation at all is better answer then that. And
using arguments like "well, twl4030 did it" is really starting to
annoy me. We are not lemmings here. We can make this right instead of
following others blindly over the cliff edge.

To summarize: We can't just accept chaos. Instead we should organize
the places without structure, in this case the user space ABI for
power supplies.

On top of ABI documentation, we will need driver API documentation as
well. I'm not expecting that you would also propose something for the
API too, but I just wanted to bring that up here. I would like to have
some guidelines on how the power supplies should be used also in
kernel.

Right now it is possible for one driver to create the power supply and
an other to take over the control of it. It is super easy to gain
access to a power supply. You can request it with just the name
without any control, and after gaining access, you have full control
over it. That makes it really easy to have race condition where both
the psy device driver and some other driver try to control the same
things of the same psy.

I guess the whole design of the psy class could use a little bit of
re-designing. So IMO, access to the psy should be more strict then it
is now, and also, even after gaining access to a psy handle, drivers
that are not the actual psy device drivers should have more controlled
access to it. So possibly separate API for them... OK, this is
definitely a separate topic. Sorry, I'll stop here.


Thanks,

-- 
heikki
