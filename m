From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Tue, 2 Jun 2015 12:14:06 +0200
Message-ID: <CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com> <CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, dmaengine@vger.kernel.org, Alexander Holler <holler@ahsoftware.de>, Dan Williams <dan.j.williams@intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-clk@vger.kernel.o
List-Id: linux-pm@vger.kernel.org

On 2 June 2015 at 10:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 25, 2015 at 4:53 PM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>
>> have looked into ordered probing as a
>> better way of solving this than moving nodes around in the DT or playing with
>> initcall levels.
>>
>> While reading the thread [1] that Alexander Holler started with his series to
>> make probing order deterministic, it occurred to me that it should be possible
>> to achieve the same by registering devices as they are referenced by other
>> devices.
>
> This is pretty cool, but a too local solution to a global problem.
>
> Deferred probe and initcall reordering, silly as they may seem,
> does not require you to use device tree.
>
> The real solution, which I think I pointed out already when we
> added deferred probe, is to put dependency graphs in the drivers

By this you mean something like what Thierry suggested here?

http://article.gmane.org/gmane.linux.kernel/1774623

> and have the kernel device driver core percolate dependecies by
> walking the graph on probing driver, removing driver (usually the
> inverse use case), [runtime] suspend and [runtime] resumeing
> a driver. Possibly the dependencies will even be different
> depending on use case.
>
> This is what systemd is doing in userspace for starting services:
> ask for your dependencies and wait for them if they are not
> there. So drivers ask for resources and wait for them. It also
> needs to be abstract, so for example we need to be able to
> hang on regulator_get() until the driver is up and providing that
> regulator, and as long as everything is in slowpath it should
> be OK. (And vice versa mutatis mutandis for clk, gpio, pin
> control, interrupts (!) and DMA channels for example.)

I understood above that you propose probing devices in order, but now
you mention that resource getters would block until the dependency is
fulfilled which confuses me because if we are probing in order then
all dependencies would be fulfilled before the device in question gets
probed.

> So if this should be solved it should be solved in an abstract way
> in the device driver core available for all, then have calls calling
> out to DT, ACPI, possibly even PCI or USB (as these
> enumerate devices themselves) to obtain a certain
> dependency.

Yeah, I was planning looking into this now that I got it working with
async probing.

Thanks,

Tomeu

> Yours,
> Linus Walleij
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
