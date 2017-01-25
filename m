From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: Keep the pd status during system PM phases
Date: Wed, 25 Jan 2017 22:30:22 +0100
Message-ID: <CAPDyKFpHttGjKGJi5_TbaD0uepMRC8+NSUqAa5Pmg5j61PT4-Q@mail.gmail.com>
References: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com>
 <CAPDyKFp0GrSQYftSk1UHUSL=+OR_BGf4OVxJDVht-eXnTX8CtQ@mail.gmail.com> <58842848.5090806@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58842848.5090806@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Feng Xiao <xf@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, xxx@rock-chips.com, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22 January 2017 at 04:34, Elaine Zhang <zhangqing@rock-chips.com> wrote:
>
>
> On 01/20/2017 09:16 PM, Ulf Hansson wrote:
>>
>> On 20 January 2017 at 03:21, Elaine Zhang <zhangqing@rock-chips.com>
>> wrote:
>>>
>>> If a PM domain is powered off before system suspend,
>>> we hope do nothing in system runtime suspend noirq phase
>>> and system runtime resume noirq phase.
>>
>>
>> One can hope, but that isn't good enough. :-)
>>
>>
>>>
>>> This modify is to slove system resume issue for RK3399.
>>> RK3399 SOC pd_gpu have voltage domain vdd_gpu,
>>> so we must follow open vdd_gpu and power on pd_gpu,
>>> power off pd_gpu and disable vdd_gpu.
>>> Fix up in runtime resume noirq phase power on all PDs.
>>
>>
>> This doesn't make any sense to me. Can please try to explain this is
>> in great more detail, then I can try to help.
>>
> For example:
> -->device suspend
>    (mali gpu driver set pd_gpu off by pm_runtime_put_sync(),

This is the wrong approach, as runtime suspend is prevented by the PM
core in this phase. More precisely, it does a
pm_runtime_get_noresume() in the device prepare phase.

I think it seems like you would benefit from using the so called the
runtime PM centric approach, which gives you system PM support for
"free". Please have a look at the pm_runtime_force_suspend|resume()
helpers.

>     and then disabled the vdd_gpu by regulator_disable().)
>         --> system suspend
>                 -->prepare
>                         -->suspend_noirq():
>                         (power off all pds)
>         -->system resume
>                 -->resume_noirq():
>                 (power up all pds)
>                 (in this case the vdd_gpu is still disabled,
>                  if power on the pd_gpu maybe make the system crash)
>         -->complete : power off the not used pd
> -->device resuem
>    (mali gpu driver enable vdd_gpu by regulator_enable(),
>     and then power up the pd_gpu by pm_runtime_get_sync())

Seems like there is also a missing configuration of the relationship
between the PM domains. In the genpd terminology, you probably want to
set pd_gpu as a subdomain of the vdd_gpu.

In that way, the vdd_gpu is always powered on before pd_gpu is powered
on. And vice verse when powering off.

>
> So for RK3399 soc, if to set pd_gpu the vdd_gpu must be enabled, or else
> will can't get the ack back.
> I hope the pd_gpu power up/off by the driver itself.
>
> May be I solution is not the optimal solution,Do you have better suggestion?
>

Please see my comment above.

[...]

Kind regards
Uffe
