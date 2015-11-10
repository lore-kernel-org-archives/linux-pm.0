From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Tue, 10 Nov 2015 10:57:26 +0100
Message-ID: <CAPDyKFqW=PEiijHN8cPaLK8oPRn9WdAYsLug1dbMpitKmNNKjw@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
	<87d1vili9c.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWSMsVZYF2jswCoRB217n_3OR8uikNtBYOfQHkQs3oWSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWSMsVZYF2jswCoRB217n_3OR8uikNtBYOfQHkQs3oWSA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>
List-Id: linux-pm@vger.kernel.org

On 10 November 2015 at 09:18, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Morimoto-san, Ulf,
>
> On Tue, Nov 10, 2015 at 3:12 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> It is using pm_runtime_get_sync() on probe(). Let's use
>> pm_runtime_put_sync() instead of pm_runtime_put(). Otherwise thermal
>> sensor doesn't work after unbind/re-bind
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>  drivers/thermal/rcar_thermal.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
>> index 13d01ed..f7cf2d7 100644
>> --- a/drivers/thermal/rcar_thermal.c
>> +++ b/drivers/thermal/rcar_thermal.c
>> @@ -373,7 +373,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>>                 thermal_zone_device_unregister(priv->zone);
>>         }
>>
>> -       pm_runtime_put(dev);
>> +       pm_runtime_put_sync(dev);
>>         pm_runtime_disable(dev);

For the reasons explained by Geert, this is to me also a "workaround".

I would replace pm_runtime_put() and pm_runtime_disable() with a call
to pm_runtime_force_suspend().

In that way, you will make sure you device get runtime suspended
(clock domain will gate the clock). Additionally, the runtime PM
status will properly reflect the status of the device.

>>
>>         return 0;
>
> While I can confirm this fixes the issue, I think this is a bug in the PM
> core, and thus your patch is merely a workaround.
>
> Morimoto-san: I assume this is a recent regression. Have you tried to bisect?
>
> With a bit more debugging info, this is the difference between the failing
> and the "fixed" cases:
>
>  unbind:
>
> +rcar_thermal e61f0000.thermal: pm_clk_suspend()
> +renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal OFF
>  rcar_thermal e61f0000.thermal: removing from PM domain clock-controller
>  pm_genpd_remove_device: Remove e61f0000.thermal from clock-controller
> -renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal OFF
>
>  bind:
>
>  rcar_thermal e61f0000.thermal: adding to PM domain clock-controller
>  __pm_genpd_add_device: Add e61f0000.thermal to clock-controller
>  rcar_thermal e61f0000.thermal: Clock thermal con_id (null) managed by
> runtime PM.
> -rcar_thermal e61f0000.thermal: thermal sensor was broken
> +rcar_thermal e61f0000.thermal: pm_clk_resume()
> +renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal ON
>  rcar_thermal e61f0000.thermal: 1 sensor probed
>
> In the failing case, pm_clk_suspend() is not called, and turning off the
> module clock is thus delayed until removal of the device from the clock
> domain.
> But as pm_clk_suspend() wasn't called, the device isn't correctly resumed on
> rebind, and the module clock is never re-enabled, leading to a failure.
>
> Ulf, what do you think?

I totally agree on your analyse.

The problem is that the runtime PM status of the device isn't
correctly updated at ->remove(). The effect is that the the
pm_runtime_get_sync() in ->probe() at re-bind will *not* trigger the
->runtime_resume() callbacks to be invoked, as the runtime PM core
believes the device is already runtime resumed.

Kind regards
Uffe
