From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 09:52:44 -0700
Message-ID: <CAOesGMjzeJYVuNzrtahNxiMk-3Huq76=DVhKixMNC=3vebUc_Q@mail.gmail.com>
References: <20151014092644.GO14956@sirena.org.uk>
	<1444909328-24761-1-git-send-email-tomeu.vizoso@collabora.com>
	<CAOesGMj44N3Xfv_D_iLEzXBrkN6LXBa-uh6m3fi_F2xDenDhMg@mail.gmail.com>
	<CAL_Jsq+34sRXe0HWCKNceQfLj=WfDV4-soynumvdnH_nwuj+9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+34sRXe0HWCKNceQfLj=WfDV4-soynumvdnH_nwuj+9g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 17, 2015 at 8:19 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Oct 16, 2015 at 4:23 PM, Olof Johansson <olof@lixom.net> wrote:
>> Hi,
>>
>> I've bisected boot failures in next-20151016 down to patches in this branch:
>>
>> On Thu, Oct 15, 2015 at 4:42 AM, Tomeu Vizoso
>> <tomeu.vizoso@collabora.com> wrote:
>>> Tomeu Vizoso (20):
>>>       driver core: handle -EPROBE_DEFER from bus_type.match()
>>
>> The machine it happened on was OMAP5UEVM:
>>
>> http://arm-soc.lixom.net/bootlogs/next/next-20151016/omap5uevm-arm-omap2plus_defconfig.html
>
> So this one is because the MMC node numbering changed. I don't know
> how to fix that other than with aliases, but that doesn't solve
> backwards compatibility.

Yep, aliases will take care of it in this case. This is where -next
fills a great purpose, we can make sure we get those aliases added in
before the patches go in.

>> But I've also seen it on tegra2, that one bisected down to:
>>
>>>      regulator: core: Probe regulators on demand
>>
>> http://arm-soc.lixom.net/bootlogs/next/next-20151016/seaboard-arm-multi_v7_defconfig.html
>
> This one you need a rootwait I think. The MMC scanning is not
> guaranteed to be done before the rootfs mounting AFAIK. There may be
> other problems, but we can't see them since it panics.

Embarrassing, I almost always do this and I'm surprised this machine
has been this stable without it.


-Olof
