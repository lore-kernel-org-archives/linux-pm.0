From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Mon, 15 Jun 2015 11:42:50 +0200
Message-ID: <557E9E1A.7060000@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de>	<CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>	<5579602F.1070801@ahsoftware.de>	<CACRpkdaZgBR5rHwrEYqcm5K4w3y8MXG8a0k=Y+oQY+jukHfuyw@mail.gmail.com>	<5579B9E8.9040609@ahsoftware.de>	<CACRpkdbDSS0yw=q_cR17Bvg+kgTfU3Vcd2gSjx1p4V-CzOZ_SA@mail.gmail.com>	<557AC040.40803@ahsoftware.de>	<557AC437.9000607@ahsoftware.de>	<557C7609.30400@ahsoftware.de> <CACRpkdaVZmq_w_qgEgTP5oqfH3K1+80O7z7o7CJx-dhivUGhDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdaVZmq_w_qgEgTP5oqfH3K1+80O7z7o7CJx-dhivUGhDQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DRM PANEL DRIVERS <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linu>
List-Id: linux-pm@vger.kernel.org

Am 15.06.2015 um 10:58 schrieb Linus Walleij:
> On Sat, Jun 13, 2015 at 8:27 PM, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org> wrote:
>
>> And because you've said that "problem space is a bit convoluted" and I
>> disagree, here's a summary from my point of view:
>>
>> 1. All the necessary information (dependencies between drivers) already
>> exists at compile time. The set of dependencies between drivers might become
>> smaller by configuration, but will not become larger. So there should be NO
>> need to collect them at runtime, e.g. by instrumenting function calls.
>
> I think you arrived at the core of the crux here.

I've hoped so, that's why I've written it.

> I guess your suggested approach then need to introduce a special
> build tool to order the initcalls accordingly.
>
> Again this will fall short if you don't know at compile time exactly
> *which* board file will be executed.

I've just tried to describe the facts in order to make the problem space 
more clear, because, as said, I don't think it's convoluted.

Besides that, I didn't want to suggest anything else other than what 
I've already posted working patches for. What I've mentioned as possible 
other solutions above is stuff which might be possible too in order to 
give some starting points for people which are searching another 
solution. But I wouldn't have written my patches as they are, if I would 
think there is another more easier solution.

And of course, there is still a bit to resolve at runtime, even in the 
DT case (look at the "compatible" attribute). But there is already a 
runtime solution to find the right driver (in case of DT) and I haven't 
mentioned it in order to no confuse people again. Mentioning every 
little detail doesn't make sense if you want to describe something 
understandable (which is what I've tried).

> So the only practical way to solve this at compile time is to predict
> an initcall ordering sequence for all possible boot paths, compile in
> all of them, and choose the right one at boot. But the number of boot
> paths is equal to the number of device trees / ACPI tables or
> board files supported, and that space is uncontrolled and ordered
> infinite.

You just need one working ordered sequence which includes all options. 
This one will work for all others too.

> Basically I think the root problem with your approach is that you
> assume we know what hardware we will boot on at compile time. We

Totally wrong. If you assume that I assume this, than either I was 
totally unable to describe something clearly, or you were unable or 
unwilling to understand what I've written. And as the result is the 
same, we don't need to find out which was reason.

Anyway, have fun. I'm quitting the discussion here as I don't have any 
business with the kernel and already decided some time again to not post 
patches anymore as it seems to be a waste of my (and maybe others) time.

Regards,

Alexander Holler
