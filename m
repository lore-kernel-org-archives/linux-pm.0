From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
Date: Fri, 14 Aug 2015 18:48:18 -0500
Message-ID: <CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
	<CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
	<CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yao Yuan <yao.yuan@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "stefan@agner.ch" <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 14, 2015 at 1:24 AM, Yao Yuan <yao.yuan@freescale.com> wrote:
> Hi Leo,
>
> Thanks for your review.
> About those two methods for DMA suspend that you have mentioned. We have a lot of the discussions in other DMA driver like DMA for Freescale PowerPC.
>
> Finally, we think the device which used the DMA transmission service should cancel the transmission service in its suspend.
> So DMA in suspend should be idle.

If that's the case you should clearly state this in the commit message
and in code, although I don't know if it is safe to make such
assumption.  There could be user of the DMA that doesn't track the
completion of transfers.

>
> Once the DMA in late_suspend is not be idle, we think some driver haven't canceled the DMA transmission. So maybe something is error when other driver in suspend.
>
> In the case, we should return failed to stop PM. DMA should not make a choice for other drivers(which used DMA) to force stop DMA transmission.

The suspend entrance should be terminated by wakeup events and only
critical issues.  I don't think we should just terminate the suspend
entrance just because having on-going I/O without even try to stop it.

>
> Thanks.
>
> Best Regards,
> Yuan Yao
>
>> -----Original Message-----
>> From: pku.leo@gmail.com [mailto:pku.leo@gmail.com] On Behalf Of Li Yang
>> Sent: Friday, August 14, 2015 4:58 AM
>> To: Yuan Yao-B46683
>> Cc: Vinod Koul; stefan@agner.ch; Arnd Bergmann; Dan Williams;
>> dmaengine@vger.kernel.org; lkml; linux-arm-kernel@lists.infradead.org; linux-
>> pm@vger.kernel.org
>> Subject: Re: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume
>> support
>>
>> On Tue, Jul 21, 2015 at 3:56 AM, Yuan Yao <yao.yuan@freescale.com> wrote:
>> > This add power management suspend/resume support for the fsl-edma
>> > driver.
>> >
>> > eDMA acted as a basic function used by others. What it needs to do is
>> > the two steps below to support power management.
>> >
>> > In fsl_edma_suspend_late:
>> > Check whether the DMA chan is idle and if it is not idle, stop PM
>> > operation.
>>
>> You should try to quiesce the device on suspend instead of depending on itself
>> to be happen in idle and failing if it is not.
>>
>> Regards,
>> Leo



-- 
- Leo
