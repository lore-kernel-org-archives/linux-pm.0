From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Fri, 30 Jan 2015 11:04:00 +0100
Message-ID: <CAMuHMdXy1wT_-uoGgX2nx4Rk37yPzaTsscZ9ZYb7tGkk9xA4sw@mail.gmail.com>
References: <1420454789-11547-1-git-send-email-geert+renesas@glider.be>
	<CAJKOXPfaH0sZmEqKydbKkKND3QB3-caVeLt4fVC1h=gfH3xw5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPfaH0sZmEqKydbKkKND3QB3-caVeLt4fVC1h=gfH3xw5w@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Fri, Jan 30, 2015 at 10:46 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-01-05 11:46 GMT+01:00 Geert Uytterhoeven <geert+renesas@glider.be>:
>> During system reboot, the sh-dma-engine device may be runtime-suspended,
>> causing a crash:
>>
>>     Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
>>     Internal error: : 1406 [#1] SMP ARM
>>     ...
>>     PC is at sh_dmae_ctl_stop+0x28/0x64
>>     LR is at sh_dmae_ctl_stop+0x24/0x64
>>
>> If the sh-dma-engine is runtime-suspended, its module clock is turned
>> off, and its registers cannot be accessed.
>>
>> To fix this, change the driver's .shutdown() callback:
>>   - If the device is runtime suspended, do nothing,
>>   - Else, explicitly runtime-resume the device, to avoid the device from
>>     being suspended while sh_dmae_ctl_stop() is being executed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - Do nothing if we're runtime suspended.
>> ---
>>  drivers/dma/sh/shdmac.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
>> index aec8a84784a469d7..2de30e8e7d9290b9 100644
>> --- a/drivers/dma/sh/shdmac.c
>> +++ b/drivers/dma/sh/shdmac.c
>> @@ -585,7 +585,13 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
>>  static void sh_dmae_shutdown(struct platform_device *pdev)
>>  {
>>         struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
>> +
>> +       if (pm_runtime_suspended(&pdev->dev))
>
> This still looks a little racy. What if runtime resume happens exactly
> here? I think safer would be disabling runtime PM before checking for
> suspend state.

I don't think new requests can come in while .shutdown() is called, so
the device cannot be resumed here.

>> +               return;
>> +
>> +       pm_runtime_get_sync(&pdev->dev);
>>         sh_dmae_ctl_stop(shdev);
>> +       pm_runtime_put(&pdev->dev);
>>  }
>>
>>  static int sh_dmae_runtime_suspend(struct device *dev)
>> --
>> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
