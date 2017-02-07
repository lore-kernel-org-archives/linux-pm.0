From: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2] PM / Domains: Keep the pd status during system PM
 phases
Date: Tue, 07 Feb 2017 17:22:51 +0800
Message-ID: <589991EB.9090501@rock-chips.com>
References: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com>
 <CAPDyKFp0GrSQYftSk1UHUSL=+OR_BGf4OVxJDVht-eXnTX8CtQ@mail.gmail.com>
 <58842848.5090806@rock-chips.com>
 <CAPDyKFpHttGjKGJi5_TbaD0uepMRC8+NSUqAa5Pmg5j61PT4-Q@mail.gmail.com>
 <5896F1A5.9080405@rock-chips.com>
 <CAPDyKFpXXL+zpGZCYSEqtJ6_1=tH+FCths7HuuO5OdRcALoRRA@mail.gmail.com>
 <589925B7.4020009@rock-chips.com>
 <CAPDyKFojbX1uiS00EsyxxkM5uLUbHkbu3xAN4R5=PKo4iFOcCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFojbX1uiS00EsyxxkM5uLUbHkbu3xAN4R5=PKo4iFOcCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Feng Xiao <xf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 02/07/2017 04:19 PM, Ulf Hansson wrote:
> [...]
>
>>>
>>>
>>> Unfortunate, I am still not fully understanding the scenarios. As you
>>> indicate, the problem seems related to wakeup settings.
>>>
>>> Could you please try to answer the below questions, hopefully it helps
>>> me to better understand.
>>>
>>> 1)
>>> While starting the system suspend sequence, under what circumstances
>>> are you expecting the vdd_gpu and pd_gpu to be powered on?
>>>
>>
>> I don't want to power on the vdd_gpu and pd_gpu during the system suspend
>> sequence.
>> I hope the pd_gpu and vdd_gpu power on/off just by gpu device.
>
> Let me rephrase my question.
>
> Can the vdd_gpu/pd_gpu ever remain in a powered on state while the
> system is suspended?
>
NO, the vdd_gpu/pd_gpu ever remain in a powered off state while the
system is suspended.
> If yes, when is that the case?
>
>>
>>> 2)
>>> While starting the system suspend sequence, under what circumstances
>>> are you expecting the vdd_gpu and the pd_gpu to be powered off?
>>>
>>
>> I don't want to power off the vdd_gpu and pd_gpu during the system suspend
>> sequence.
>> Because before the system suspend,the vdd_gpu and pd_gpu has been power off
>> by gpu device(pm_ruantime_put).
>
> *Exactly*, how do you guarantee that a pm_runtime_put() for the gpu
> device triggers a runtime suspend - before a system suspend sequence
> starts?
>
> For example, userspace may via sysfs prevent runtime suspend for any
> device with runtime PM enabled.
>
Yes, you are right.I did't consider this.
Whether on or off pd_gpu, the vdd_gpu is must be enabled.How to deal 
with the enable/disable the vdd_gpu?

our process in devices/platform/ff9a0000.gpu:
device init
	pm_runtime_enable()

gpu_power_on
	regulator_enable(vdd_gpu)
	pm_runtime_get_sync(pd_gpu)

gpu_power_off
	pm_runtime_put_sync(pd_gpu)
	regulator_disable(vdd_gpu)

device remove
	pm_runtime_disable()

>>
>>> 3)
>>> What devices are attached to vdd_gpu?
>>>
>> just pd_gpu
>>>
>>> 4)
>>> What devices are attached to pd_gpu?
>>>
>> just gpu device(mali driver)
>>
>> vdd_gpu
>> ------- pd_gpu
>> ----------------devices/platform/ff9a0000.gpu
>>>
>>>
>
> Thanks for these details, very useful!
>
> [...]
>
> Kind regards
> Uffe
>
>
>
