From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 2/4] cpufreq: cpufreq-dt: extend with platform_data
Date: Wed, 10 Sep 2014 14:36:12 +0200
Message-ID: <4101334.fU3EzedaAi@wuerfel>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com> <20140910142841.17ae320a@free-electrons.com> <CAKohpo=EPrwbu7RhyXAXeq2U9uV2BeLZHrMKTg3oAF1oZb0QmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=EPrwbu7RhyXAXeq2U9uV2BeLZHrMKTg3oAF1oZb0QmA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Lior Amsalem <alior@marvell.com>, Rob Herring <rob.herring@linaro.org>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Tawfik Bayouk <tawfik@marvell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Thomas Abraham <thomas.ab@samsung.com>, Mike Turquette <mike.turquette@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sachin Kamat <spk.linux@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 September 2014 18:02:59 Viresh Kumar wrote:
> > I'm using platform_device_register_data(), which does a kmemdup() of
> > the custom data being passed before assigning the struct
> > device->platform_data field.
> 
> Atleast in your case it isn't required to copy anymore but this driver can be
> used by others which may not guarantee that..
> 
> > But if you like, I can add one more memory copy 
> 
> Its not what I like, as wasting memory isn't sensible at all.. But about what's
> the right thing to do to make this code un-breakable..
> 
> @Arnd: Any inputs?

platform_device_register_data() is the right way to register a platform
device if one needs to do that, and it will always copy the data,
so that should be used, and the driver should rely on the data not
getting freed under it.

Statically defining platform_device instances is generally a bad idea,
and we should not do that, but if someone does it is up to them to
make sure the platform_data is not marked as __init.

	Arnd
