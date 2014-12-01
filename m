From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 01 Dec 2014 15:59:14 +0100
Message-ID: <3594266.ci9lGXQ9iA@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org> <5607434.rlEIdu4yyh@wuerfel> <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50041 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbaLAPAI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 10:00:08 -0500
In-Reply-To: <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "olof@lixom.net" <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>

On Monday 01 December 2014 20:18:10 Viresh Kumar wrote:
> On 1 December 2014 at 19:35, Arnd Bergmann <arnd@arndb.de> wrote:
> > I guess a string would be better here, the idea here was to
> > have a different bool property per driver, which would also
> > work.
> 
> Hmm, I will prefer string as we don't need to define any more bindings then
> for new drivers.

Right. You'd still need to define the known values though, so in
effect it's not much of a difference. I have no problem with 
a string property though.

> >> > @@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
> >> >         if (!IS_ERR(cpu_reg))
> >> >                 regulator_put(cpu_reg);
> >> >
> >> > -       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
> >> > -
> >>
> >> We still need this, and its about how clocks are shared between CPUs.
> >
> > I didn't see where this comes from. Who is setting up this platform
> > data?
> 
> Mvebu is using it to communicate that all CPUs have separate
> clock lines.

I still don't see where it does that. All I see for mvebu is

	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

without any platform data. I see this patch
http://lists.linaro.org/pipermail/linaro-kernel/2014-September/017693.html
on the mailing list, but it's not in linux-next, and it obviously
would not work any more with the patch I proposed. Instead I suppose
you would use a different string to match against for the case of
separate clocks.

	Arnd
