From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Tue, 10 Nov 2015 14:00:38 +0100
Message-ID: <CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
	<87d1vili9c.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWSMsVZYF2jswCoRB217n_3OR8uikNtBYOfQHkQs3oWSA@mail.gmail.com>
	<CAPDyKFqW=PEiijHN8cPaLK8oPRn9WdAYsLug1dbMpitKmNNKjw@mail.gmail.com>
	<CAMuHMdX_mAd1PVv5_UCJJZ2U5EjYUbqQ36zaEgP5KdUuZiGQMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34341 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbKJNAj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 08:00:39 -0500
Received: by ykfs79 with SMTP id s79so80495661ykf.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2015 05:00:38 -0800 (PST)
In-Reply-To: <CAMuHMdX_mAd1PVv5_UCJJZ2U5EjYUbqQ36zaEgP5KdUuZiGQMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

+Rafael, Alan

On 10 November 2015 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Tue, Nov 10, 2015 at 10:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 10 November 2015 at 09:18, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Tue, Nov 10, 2015 at 3:12 AM, Kuninori Morimoto
>>> <kuninori.morimoto.gx@renesas.com> wrote:
>>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>>
>>>> It is using pm_runtime_get_sync() on probe(). Let's use
>>>> pm_runtime_put_sync() instead of pm_runtime_put(). Otherwise thermal
>>>> sensor doesn't work after unbind/re-bind
>>>>
>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>> ---
>>>>  drivers/thermal/rcar_thermal.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
>>>> index 13d01ed..f7cf2d7 100644
>>>> --- a/drivers/thermal/rcar_thermal.c
>>>> +++ b/drivers/thermal/rcar_thermal.c
>>>> @@ -373,7 +373,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>>>>                 thermal_zone_device_unregister(priv->zone);
>>>>         }
>>>>
>>>> -       pm_runtime_put(dev);
>>>> +       pm_runtime_put_sync(dev);
>>>>         pm_runtime_disable(dev);
>>
>> For the reasons explained by Geert, this is to me also a "workaround".
>>
>> I would replace pm_runtime_put() and pm_runtime_disable() with a call
>> to pm_runtime_force_suspend().
>>
>> In that way, you will make sure you device get runtime suspended
>> (clock domain will gate the clock). Additionally, the runtime PM
>> status will properly reflect the status of the device.
>
> That still sounds like a workaround to me, which we have to apply to all
> drivers relying on Runtime PM?

Definitely not all drivers, but those that runs pm_runtime_get_sync()
during ->probe() and expects the ->runtime_resume() callback to always
be invoked because of that. I guess we need to check upon which
drivers that may suffer from this.

I wouldn't be surprised if at least a subset of those cases we find,
are poorly designed from PM point of view and won't even probe
successfully unless CONFIG_PM is set. Whatever that means...

>
>>> With a bit more debugging info, this is the difference between the failing
>>> and the "fixed" cases:
>>>
>>>  unbind:
>>>
>>> +rcar_thermal e61f0000.thermal: pm_clk_suspend()
>>> +renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal OFF
>>>  rcar_thermal e61f0000.thermal: removing from PM domain clock-controller
>>>  pm_genpd_remove_device: Remove e61f0000.thermal from clock-controller
>>> -renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal OFF
>>>
>>>  bind:
>>>
>>>  rcar_thermal e61f0000.thermal: adding to PM domain clock-controller
>>>  __pm_genpd_add_device: Add e61f0000.thermal to clock-controller
>>>  rcar_thermal e61f0000.thermal: Clock thermal con_id (null) managed by
>>> runtime PM.
>>> -rcar_thermal e61f0000.thermal: thermal sensor was broken
>>> +rcar_thermal e61f0000.thermal: pm_clk_resume()
>>> +renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal ON
>>>  rcar_thermal e61f0000.thermal: 1 sensor probed
>>>
>>> In the failing case, pm_clk_suspend() is not called, and turning off the
>>> module clock is thus delayed until removal of the device from the clock
>>> domain.
>>> But as pm_clk_suspend() wasn't called, the device isn't correctly resumed on
>>> rebind, and the module clock is never re-enabled, leading to a failure.
>>>
>>> Ulf, what do you think?
>>
>> I totally agree on your analyse.
>>
>> The problem is that the runtime PM status of the device isn't
>> correctly updated at ->remove(). The effect is that the the
>> pm_runtime_get_sync() in ->probe() at re-bind will *not* trigger the
>> ->runtime_resume() callbacks to be invoked, as the runtime PM core
>> believes the device is already runtime resumed.
>
> So that's where it should be fixed?

That would be a more generic approach, although I am not sure how the
driver/PM core should be able to take the correct decision in this
phase. Devices may be runtime PM managed also without a driver bound.

Perhaps when __device_release_driver() finds a bounded driver for the
device, it could after all actions been performed to unbind the
driver, check if runtime PM is enabled. If it isn't, it could set the
runtime PM status to suspended!?

I have no idea if that would introduce other issues as it would kind
of force the runtime PM status of the device to suspend, without
actually knowing if it's the correct thing to do.

Kind regards
Uffe
