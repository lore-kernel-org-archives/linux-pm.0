From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 11 Jun 2015 13:24:14 +0200
Message-ID: <55796FDE.7080701@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de> <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com> <5579602F.1070801@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5579602F.1070801-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open-7NY9aMYB+ISttCpgsWEBFg@public.gmane.org, "list-7NY9aMYB+ISttCpgsWEBFg@public.gmane.org:DRM PANEL DRIVERS" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c@vg>
List-Id: linux-pm@vger.kernel.org

Am 11.06.2015 um 12:17 schrieb Alexander Holler:
> Am 11.06.2015 um 10:12 schrieb Linus Walleij:
>> On Wed, Jun 10, 2015 at 10:28 AM, Alexander Holler
>> <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org> wrote:
>>> Am 10.06.2015 um 09:30 schrieb Linus Walleij:
>>
>>>> i2c host comes out, probes the regulator driver, regulator driver
>>>> probes and then the regulator_get() call returns.
>>>>
>>>> This requires instrumentation on anything providing a resource
>>>> to another driver like those I mentioned and a lot of overhead
>>>> infrastructure, but I think it's the right approach. However I don't
>>>> know if I would ever be able to pull that off myself, I know talk
>>>> is cheap and I should show the code instead.
>>>
>>> You would end up with the same problem of deadlocks as currently, and
>>> you
>>> would still need something ugly like the defered probe brutforce to
>>> avoid
>>> them.
>>
>> Sorry I don't get that. Care to elaborate on why?
>
> Because loading/initializing on demand doesn't give you any solved order
> of drivers to initialize. And it can't because it has no idea about the
> requirements of other drivers. The reason why it might work better in
> the case of the tegra is that it might give you another initialization
> order than the one which is currently choosen, which, by luck, might be
> a better one.
>
> But maybe I missed something, I haven't looked at the patches at all.
> But just loading on demand, can't magically give you a working order of
> drivers to initialize. E.g. how do you choose the first driver to
> initialize?

Other problems you will run into are time constraints and multithreaded 
drivers.

E.g. we all should know how tricky it sometimes is to avoid deadlocks. 
And with loading on demand, you are extending this problem over the 
initialization of maybe a whole bunch of other drivers which might be 
started by calling one function of another driver. And a function call 
might need a very long time to finish during which an unpredictable 
amount of things may happen.

It would make me wonder if that will end up with a good, usable and as 
simple as possible solution.

Regards,

Alexander Holler
