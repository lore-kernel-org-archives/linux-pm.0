From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 11 Jun 2015 12:17:19 +0200
Message-ID: <5579602F.1070801@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de> <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, open@wandq.ahsoftware, "list@wandq.ahsoftware:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, "linux-usb@vger.kernel.org" <linux-i2c@vg>
List-Id: linux-pm@vger.kernel.org

Am 11.06.2015 um 10:12 schrieb Linus Walleij:
> On Wed, Jun 10, 2015 at 10:28 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>> Am 10.06.2015 um 09:30 schrieb Linus Walleij:
>
>>> i2c host comes out, probes the regulator driver, regulator driver
>>> probes and then the regulator_get() call returns.
>>>
>>> This requires instrumentation on anything providing a resource
>>> to another driver like those I mentioned and a lot of overhead
>>> infrastructure, but I think it's the right approach. However I don't
>>> know if I would ever be able to pull that off myself, I know talk
>>> is cheap and I should show the code instead.
>>
>> You would end up with the same problem of deadlocks as currently, and you
>> would still need something ugly like the defered probe brutforce to avoid
>> them.
>
> Sorry I don't get that. Care to elaborate on why?

Because loading/initializing on demand doesn't give you any solved order 
of drivers to initialize. And it can't because it has no idea about the 
requirements of other drivers. The reason why it might work better in 
the case of the tegra is that it might give you another initialization 
order than the one which is currently choosen, which, by luck, might be 
a better one.

But maybe I missed something, I haven't looked at the patches at all. 
But just loading on demand, can't magically give you a working order of 
drivers to initialize. E.g. how do you choose the first driver to 
initialize?

Regards,

Alexander Holler
