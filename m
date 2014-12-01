From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 01 Dec 2014 15:05:57 +0100
Message-ID: <5607434.rlEIdu4yyh@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org> <7885354.QleDlR7NUO@wuerfel> <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64086 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbaLAOGg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 09:06:36 -0500
In-Reply-To: <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "olof@lixom.net" <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>

On Monday 01 December 2014 18:59:20 Viresh Kumar wrote:
> On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
> > Thanks a lot for working on this, we really need to figure it out one day!
> 
> :)
> 
> > Your patches seem well-implemented, so if everybody thinks the general
> > approach is the best solution, we should do that. From my point of view,
> > there are two things I would do differently:
> >
> > - In the DT binding, I would strongly prefer anything but the root compatible
> >   property as the key for the new platforms. Clearly we have to keep using
> >   it for the backwards-compatibility case, as you do, but I think there
> >   are more appropriate places to put it. Sorting from most favorite to least
> >   favorite, my list would be:
> >         1. a new property in /cpus/
> >         2. a new property each /cpus/cpu@... node.
> 
> I did it this way earlier and named it dvfs-method but probably putting this
> into the /cpus/ node is far better. But then Sudeep asked to utilize
> compatible property only..
> 
> Are you fine with the name here? "dvfs-method"

No objection here, whatever makes sense to you.

> > +static bool dt_cpufreq_available(void)
> > +{
> > +       struct device_node *node;
> > +       bool ret;
> > +
> > +       node = of_find_node_by_path("/cpus");
> > +       if (!node)
> > +               return 0;
> > +
> > +       /* the specific property needs to be debated */
> > +       ret = of_property_read_bool("linux,cpu-frequency-scaling");
> 
> How can this be a bool? We need to differentiate on which binding
> wants to go for arm-bl or cupfreq-dt or any other driver. So we surely
> need a string ?

I guess a string would be better here, the idea here was to
have a different bool property per driver, which would also
work.

> > @@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
> >         if (!IS_ERR(cpu_reg))
> >                 regulator_put(cpu_reg);
> >
> > -       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
> > -
> 
> We still need this, and its about how clocks are shared between CPUs.

I didn't see where this comes from. Who is setting up this platform
data?

	Arnd
