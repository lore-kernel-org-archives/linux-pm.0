From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] ARM: exynos: Ensure PM domains are powered at initialization
Date: Wed, 1 Oct 2014 14:45:41 +0200
Message-ID: <CAPDyKFq12sgjA71+wPv13xmTq2FO56A2UXP7XLkYRijphG5bGA@mail.gmail.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-3-git-send-email-ulf.hansson@linaro.org>
	<7hiok5x8k1.fsf@deeprootsystems.com>
	<542BE442.9040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <542BE442.9040505@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 October 2014 13:23, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 30.09.2014 20:33, Kevin Hilman wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> At ->probe() it's common practice for drivers/subsystems to bring their
>>> devices to full power and without depending on CONFIG_PM_RUNTIME.
>>>
>>> We could also expect that drivers/subsystems requires their device's
>>> corresponding PM domains to be powered, to successfully complete a
>>> ->probe() sequence.
>>>
>>> Align to the behavior above, by ensuring all PM domains are powered
>>> prior initialization of a generic PM domain.
>>>
>>> Do note, since the generic PM domain will try to power off unused PM
>>> domains at late_init, there are no increased power consumption over
>>> time.
>>
>> IMO "no increased power consumption" is a bit misleading because
>> boot-time power consumption may have a major increase when all power
>> domains are powered on.  Sure, they will eventually (hopefully) be
>> turned off in after late_initcall, but there will still be an impact.
>>
>> I guess the Samsung folks should comment here on whether that is
>> significant.
>
> Unfortunately this series has not been posted to linux-samsung-soc
> mailing list and I'm a formerly-Samsung folk now, so it hasn't really
> reached there.
>

Ohh, thanks for pointing this out. I will resend it.

Kind regards
Uffe
