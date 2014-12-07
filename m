From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dmaengine: shdma: Runtime-resume device in .shutdown()
Date: Sun, 7 Dec 2014 11:35:21 +0100
Message-ID: <CAMuHMdW+zQontjNcG+MGxFec4CZFFzcDAwY=zNMNKCZLJh9whQ@mail.gmail.com>
References: <1416410146-29652-1-git-send-email-geert+renesas@glider.be>
	<20141205174754.GV3411@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:46592 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbaLGKfY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Dec 2014 05:35:24 -0500
In-Reply-To: <20141205174754.GV3411@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Vinod,

On Fri, Dec 5, 2014 at 6:47 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Nov 19, 2014 at 04:15:46PM +0100, Geert Uytterhoeven wrote:
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
>> off, and its registers cannot be accessed. Runtime-resume the device in
>> the driver's .shutdown() callback to fix this.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/dma/sh/shdmac.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
>> index b65317c6ea4e722c..a13c6ba7468f12a6 100644
>> --- a/drivers/dma/sh/shdmac.c
>> +++ b/drivers/dma/sh/shdmac.c
>> @@ -585,7 +585,10 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
>>  static void sh_dmae_shutdown(struct platform_device *pdev)
>>  {
>>       struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
>> +
>> +     pm_runtime_get_sync(&pdev->dev);
>>       sh_dmae_ctl_stop(shdev);
>> +     pm_runtime_put(&pdev->dev);
> but if you are runtime_suspended, then why should you even proceed to stop
> the clock. Why not just cleanup and return when runtime suspended

sh_dmae_ctl_stop() stops the DMA engine, not the clock.
Accessing the DMA engine cannot be done while the module clock is stopped.

If pm_runtime_suspended() returns true, I can indeed just return (no new
request can come in while .shutdown() is called).
However, if pm_runtime_suspended() returns false, the device may still
become runtime suspended in between the check for pm_runtime_suspended()
and accessing the DMA engine registers in sh_dmae_ctl_stop(), as runtime
suspend is an asynchronous operation, right?

So I think adding a check for pm_runtime_suspended() can only serve as
an optimization, the pm_runtime_{get_sync,put}() has to stay to prevent a
race condition.

Please correct me if I'm wrong.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
