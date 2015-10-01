From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] dmaengine: usb-dmac: Fix crash on runtime suspend
Date: Thu, 1 Oct 2015 15:26:55 +0300
Message-ID: <560D268F.8090705@cogentembedded.com>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
 <1443684138-32252-2-git-send-email-geert+renesas@glider.be>
 <SG2PR06MB091969749911331385AB7E83D84C0@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:33714 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbbJAM1A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 08:27:00 -0400
Received: by lahh2 with SMTP id h2so73620423lah.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2015 05:26:58 -0700 (PDT)
In-Reply-To: <SG2PR06MB091969749911331385AB7E83D84C0@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hello.

On 10/1/2015 1:53 PM, Yoshihiro Shimoda wrote:

>> If CONFIG_PREEMPT=y:

    Actually, it happens even with CONFIG_PREEMPT_VOLUNTARY=y.

>>      Unable to handle kernel NULL pointer dereference at virtual address 00000014
>>      pgd = c0003000
>>      [00000014] *pgd=80000040004003, *pmd=00000000
>>      Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>>      Modules linked in:
>>      CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W       4.3.0-rc3-koelsch-022
>>      71-g705498fc5e6a5da8-dirty #1789
>>      Hardware name: Generic R8A7791 (Flattened Device Tree)
>>      Workqueue: pm pm_runtime_work
>>      task: ef578e40 ti: ef57a000 task.ti: ef57a000
>>      PC is at usb_dmac_chan_halt+0xc/0xc0
>>      LR is at usb_dmac_runtime_suspend+0x28/0x38
>>      pc : [<c023c880>]    lr : [<c023c95c>]    psr: 80000113
>>      sp : ef57bdf8  ip : 00000008  fp : 00000003
>>      r10: 00000008  r9 : c06ab928  r8 : ef49e810
>>      r7 : 00000000  r6 : 000000ac  r5 : ef770010  r4 : 00000000
>>      r3 : 00000000  r2 : 8ffc2b84  r1 : 00000000  r0 : ef770010
>>      Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>>      Control: 30c5307d  Table: 40003000  DAC: fffffffd
>>      Process kworker/0:1 (pid: 17, stack limit = 0xef57a210)
>>      Stack: (0xef57bdf8 to 0xef57c000)
>>
>>      [...
>>
>>      [<c023c880>] (usb_dmac_chan_halt) from [<c023c95c>] (usb_dmac_runtime_suspend+0x28/0x38)
>>      [<c023c95c>] (usb_dmac_runtime_suspend) from [<c027b25c>] (pm_genpd_runtime_suspend+0x74/0x23c)
>>
>> This happens because usb_dmac_probe() calls pm_runtime_put() before
>> usb_dmac_chan_probe(), leading to the device being suspended before the
>> DMA channels are initialized, causing a NULL pointer dereference.
>>
>> Move the call to pm_runtime_put() to the end of usb_dmac_probe() to fix
>> this.
>>
>> Add a check to usb_dmac_runtime_suspend() to prevent the crash from
>> happening in the error path.
>>
>> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I could not duplicate this issue completely on Lager.
> Even if I enabled ealyprintk, I didn't see the panic log.
> (Several kernel message appeared, and then the kernel hung.)

    I guess you also need to specify console=. The device tree console 
assignment (from the "stdout-path" prop) happens too late, the console gets 
switched to /dev/tty0 first. I forgot to mention that the pseudo-console 
(CONFIG_VT) should be disabled as well.

> Anyway, I tested this patch that kernel could boot correctly even if CONFIG_PREEMPT=y.
> So,
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

    Thank you. :-)

> Best regards,
> Yoshihiro Shimoda

MBR, Sergei

