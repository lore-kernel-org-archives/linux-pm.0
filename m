From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
Date: Mon, 17 Aug 2015 14:10:46 -0500
Message-ID: <CADRPPNRaDaUBD1JG_QHrEQ5pKP9Ap1hV+bBdUnC-V32Nzr2qQw@mail.gmail.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
	<CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
	<CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
	<CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
	<CY1PR0301MB1562103588FB0C6BEFDDBF3C83790@CY1PR0301MB1562.namprd03.prod.outlook.com>
	<55D183D1.9020401@nigelcunningham.com.au>
	<CY1PR0301MB1562FBE9818C1973651D2B7183790@CY1PR0301MB1562.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:32883 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbbHQTKs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 15:10:48 -0400
In-Reply-To: <CY1PR0301MB1562FBE9818C1973651D2B7183790@CY1PR0301MB1562.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yao Yuan <yao.yuan@freescale.com>
Cc: Nigel Cunningham <nigel@nigelcunningham.com.au>, Vinod Koul <vinod.koul@intel.com>, "stefan@agner.ch" <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Aug 17, 2015 at 2:22 AM, Yao Yuan <yao.yuan@freescale.com> wrote:
> Hi Nigel,
>
> On Mon, Aug 17, 2015 at 2:49 PM, Nigel Cunningham < nigel@nigelcunningham.com.au > wrote:
>> On 17/08/15 13:59, Yao Yuan wrote:
>> > On Sat, Aug 15, 2015 at 7:48 AM, pku.leo < pku.leo@gmail.com > wrote:
>> >> On Fri, Aug 14, 2015 at 1:24 AM, Yao Yuan <yao.yuan@freescale.com> wrote:
>> >>> Hi Leo,
>> >>>
>> >>> Thanks for your review.
>> >>> About those two methods for DMA suspend that you have mentioned.
>> We
>> >> have a lot of the discussions in other DMA driver like DMA for
>> >> Freescale PowerPC.
>> >>> Finally, we think the device which used the DMA transmission service
>> >>> should
>> >> cancel the transmission service in its suspend.
>> >>> So DMA in suspend should be idle.
>> >> If that's the case you should clearly state this in the commit
>> >> message and in code, although I don't know if it is safe to make such
>> >> assumption.  There could be user of the DMA that doesn't track the
>> completion of transfers.
>> > I think it should be safe. In my opinion, even some client(the user of
>> > the DMA) forget to cancel its DMA transmission, It will just lead to PM failed
>> but no other system and data risk.
>> > Although we should first fix the behavior of the client.
>> > Once you are no need the DMA transmission, why not stop it?
>> >
>> > Is it right?
>> Think of it from the end user perspective. Would you like your laptop (or
>> whatever) to refuse to suspend because of this condition? The user may well
>> expect that closing the lid on their laptop will reliably lead to it suspending to
>> ram. Returning a failure here could result in a loss of data if the condition is not
>> detected and the machine subsequently runs out of power.
>>
>
> Yes, the user may well expect that closing the lid on their laptop will reliably lead to it suspending to ram.
> So the client(the user of the DMA) must  to PAUSE or terminate the DMA transmission.
>
> We need to rely on client doing the right thing here.
> The DMA should not make a decision instead of client.
> If the DMA is not idle in DMA suspend, it should be the client's issue.
> We don't know what the client really want to do, so just return the non-success value.

The problem here is that neither the client nor the DMA controller
driver should easily decide to stop the suspend entrance and rollback.
I don't think the non-idle situation is serious enough to cause a
rollback.  You should do whatever can be done with the DMA
controller(such as stop the controller and leave whatever to be done
to the wake up) and continue with the suspend.

Regards,
Leo
