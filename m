From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 1 Dec 2014 20:18:10 +0530
Message-ID: <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
	<7885354.QleDlR7NUO@wuerfel>
	<CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
	<5607434.rlEIdu4yyh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:57651 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbaLAOsL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 09:48:11 -0500
Received: by mail-oi0-f42.google.com with SMTP id v63so7501668oia.15
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 06:48:10 -0800 (PST)
In-Reply-To: <5607434.rlEIdu4yyh@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "olof@lixom.net" <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>

On 1 December 2014 at 19:35, Arnd Bergmann <arnd@arndb.de> wrote:
> I guess a string would be better here, the idea here was to
> have a different bool property per driver, which would also
> work.

Hmm, I will prefer string as we don't need to define any more bindings then
for new drivers.

>> > @@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
>> >         if (!IS_ERR(cpu_reg))
>> >                 regulator_put(cpu_reg);
>> >
>> > -       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
>> > -
>>
>> We still need this, and its about how clocks are shared between CPUs.
>
> I didn't see where this comes from. Who is setting up this platform
> data?

Mvebu is using it to communicate that all CPUs have separate
clock lines.

--
viresh
