From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Mon, 15 Jun 2015 10:58:05 +0200
Message-ID: <CACRpkdaVZmq_w_qgEgTP5oqfH3K1+80O7z7o7CJx-dhivUGhDQ@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>
	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>
	<5577F533.1060007@ahsoftware.de>
	<CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
	<5579602F.1070801@ahsoftware.de>
	<CACRpkdaZgBR5rHwrEYqcm5K4w3y8MXG8a0k=Y+oQY+jukHfuyw@mail.gmail.com>
	<5579B9E8.9040609@ahsoftware.de>
	<CACRpkdbDSS0yw=q_cR17Bvg+kgTfU3Vcd2gSjx1p4V-CzOZ_SA@mail.gmail.com>
	<557AC040.40803@ahsoftware.de>
	<557AC437.9000607@ahsoftware.de>
	<557C7609.30400@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557C7609.30400-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DRM PANEL DRIVERS <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linu>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 13, 2015 at 8:27 PM, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org> wrote:

> And because you've said that "problem space is a bit convoluted" and I
> disagree, here's a summary from my point of view:
>
> 1. All the necessary information (dependencies between drivers) already
> exists at compile time. The set of dependencies between drivers might become
> smaller by configuration, but will not become larger. So there should be NO
> need to collect them at runtime, e.g. by instrumenting function calls.

I think you arrived at the core of the crux here.

When we look up a resource provided from another driver, e.g. from
regulator_get(), clk_get(), pinctrl_get(), gpiod_get() etc - the dependency
is resolved by looking in a cross-reference table for either a struct device*
pointer or a string, an index, or both or all three. Examples:

struct regulator *regulator_get(struct device *dev, const char *id);
struct clk *clk_get(struct device *dev, const char *id);
struct gpio_desc *__must_check __gpiod_get(struct device *dev,
                                         const char *con_id,
                                         enum gpiod_flags flags);
(...)

(*_index() variants exist on some of the resource retrieveal
functions.)

struct device * is the device requesting the resource, con_id
is the string name of the resource on the provider side. This is all
solved by looking in cross reference tables. ONE way of resolving
that cross reference is to look into the device tree or the ACPI table.
But for the board file case, this is resolved at runtime by the cross
reference table, registered with calls such as gpiod_add_lookup_table().

It is true that in the theoretical sense, all of this exist at compile time
especially if you can parse something like a device tree and
figure out what struct device * nodes will correspond to the struct
device_node:s in it. For ACPI I guess a similar procedure is viable.

Problem: this requires the kernel compile to know exactly *which* device tree
or ACPI table it is going to boot on. The expressed goal of device tree
and ACPI is to have *ONE* kernel booting several device trees.
Here your approach stops short: you are suggesting instrumenting
the kernel at compile time to one single device tree or ACPI table.
But we never know really what device tree or ACPI table will be used.
This just cannot be done at compile time for that reason alone.

Example: in boot case (A) the regulator may be provided by regulator
"foo" driver on an i2c bus. But in boot case (B) the very same regulator
may be provided by regulator "bar" on an SPI bus. These are very
real usecases, for example for drivers/net/ethernet/smsc/smsc911x.c,
will get regulators from the most diverse places depending on what
device tree is used.

For board files, it is neither possible in theory: you need to compile the
code to figure out the struct device * provider, and/or the string name
of the providing device (.name field in struct device for the provider)
to resolve dependencies at compile time.

For the board file case, resolving dependencies at compile time will
require a quite complex two-stage rocket: compile the code to
get resources out, then recompile with known resources.

I guess your suggested approach then need to introduce a special
build tool to order the initcalls accordingly.

Again this will fall short if you don't know at compile time exactly
*which* board file will be executed.

So the only practical way to solve this at compile time is to predict
an initcall ordering sequence for all possible boot paths, compile in
all of them, and choose the right one at boot. But the number of boot
paths is equal to the number of device trees / ACPI tables or
board files supported, and that space is uncontrolled and ordered
infinite.

Basically I think the root problem with your approach is that you
assume we know what hardware we will boot on at compile time. We
discarded that development path years ago. We have no clue, this
is resolved at runtime. Alas, people still create super-optimized
systems using exactly this knowledge, but it is not our main target
here, it is a special optimization case.

Yours,
Linus Walleij
