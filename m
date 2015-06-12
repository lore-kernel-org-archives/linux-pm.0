From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Fri, 12 Jun 2015 13:36:23 +0200
Message-ID: <557AC437.9000607@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de>	<CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>	<5579602F.1070801@ahsoftware.de>	<CACRpkdaZgBR5rHwrEYqcm5K4w3y8MXG8a0k=Y+oQY+jukHfuyw@mail.gmail.com>	<5579B9E8.9040609@ahsoftware.de> <CACRpkdbDSS0yw=q_cR17Bvg+kgTfU3Vcd2gSjx1p4V-CzOZ_SA@mail.gmail.com> <557AC040.40803@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <557AC040.40803@ahsoftware.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, DRM PANEL DRIVERS <dri-devel@lists.freedesktop.org>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am 12.06.2015 um 13:19 schrieb Alexander Holler:
> Am 12.06.2015 um 09:25 schrieb Linus Walleij:
>> On Thu, Jun 11, 2015 at 6:40 PM, Alexander Holler
>> <holler@ahsoftware.de> wrote:
>>> Am 11.06.2015 um 14:30 schrieb Linus Walleij:
>>
>>>> Certainly it is possible to create deadlocks in this scenario, but the
>>>> scope is not to create an ubreakable system.
>>>
>>> IAnd what happens if you run into a deadlock? Do you print "you've
>>> lost, try
>>> changing your kernel config" in some output hidden by a
>>> splash-screen? ;)
>>
>> Sorry it sounds like a blanket argument, the fact that there are
>> mutexes in the kernel makes it possible to deadlock, it doesn't
>> mean we don't use mutexes. Some programming problems are
>> just like such.
>
> I'm not talking about specific deadlocks through mutexes. I'm talking
> about what happens when driver A needs driver B which needs driver A.
> How do you recognise and handle that with your instrumented on-demand
> device initialization? Such a circular dependency might happen by just
> adding a new fucntion call or by changing the kernel configuration. And
> with the on-demand stuff, the possibility that the developer introducing
> this new (maybe optional) call will never hit such a circular dependency
> is high. So you will end up with a never ending stream of problem
> reports whenever someone introduced such a circular dependecy without
> having noticed it.
>
> And to come back to specific deadlocks, if you are extending function
> calls from something former simple to something which might initialize a
> whole bunch of drivers, needing maybe seconds, I wouldn't say this is a
> blanket argument, but a real thread.

Keep in mind, that the possibility that a function call ends up with 
initializing a whole bunch of other drivers, is not determined 
statically, but depends on the configuration and runtime behaviour of 
the actual system the on-demand stuff actually happens.

E.g. if driver A is faster one system that driver B, the whole bunch of 
drivers might become initialized by a call in driver A. But if driver B 
was faster on the developers system (or the system is configured to 
first init driver B), than the whole bunch of drivers might have become 
initialized by driver B on the developers system. Thus he never might 
have hit a possible problem when the whole bunch of drivers got 
initialized in driver A.

That means it isn't always a good idea to create dynamic systems (like 
on-demand device initialization), because it's very hard to foresee and 
correctly handle their runtime behaviour.

> Alexander Holler
