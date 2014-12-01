From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 01 Dec 2014 15:11:10 +0100
Message-ID: <23115535.r6kXsReHU2@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org> <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com> <547C6E9D.2090205@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63662 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbaLAOMD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 09:12:03 -0500
In-Reply-To: <547C6E9D.2090205@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "rob.herring@linaro.org" <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>

On Monday 01 December 2014 13:35:25 Sudeep Holla wrote:
> On 01/12/14 13:29, Viresh Kumar wrote:
> > On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
> >> Thanks a lot for working on this, we really need to figure it out one day!
> >
> > 
> >
> >> Your patches seem well-implemented, so if everybody thinks the general
> >> approach is the best solution, we should do that. From my point of view,
> >> there are two things I would do differently:
> >>
> >> - In the DT binding, I would strongly prefer anything but the root compatible
> >>    property as the key for the new platforms. Clearly we have to keep using
> >>    it for the backwards-compatibility case, as you do, but I think there
> >>    are more appropriate places to put it. Sorting from most favorite to least
> >>    favorite, my list would be:
> >>          1. a new property in /cpus/
> >>          2. a new property each /cpus/cpu@... node.
> >
> > I did it this way earlier and named it dvfs-method but probably putting this
> > into the /cpus/ node is far better. But then Sudeep asked to utilize
> > compatible property only..
> >
> > Are you fine with the name here? "dvfs-method"
> >
> 
> That's right, I don't like driver specific method in the cpu node as you
> initially did. But if it's a property in the chosen node (where we
> usually put the Linux specific properties), I am fine with
> that as Arnd has illustrated in his patch.

I would prefer the /cpus node over the /chosen node because the former
describes the hardware while the latter is supposed to be user-settable
(on real open-firmware at least). But I think either one is better than
using the / node compatible string.

How about a "linux,cpu-dvfs-method" property in the root node? Would
that work better for you than a "linux,dvfs-method" in the "/cpus"
node?

	Arnd
