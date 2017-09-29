From: Zhengqiang <zhengqiang10@huawei.com>
Subject: Re: [PATCH] Bug fix for PME interrupt handler, add Root Status check
Date: Fri, 29 Sep 2017 14:10:48 +0800
Message-ID: <59CDE3E8.7050702@huawei.com>
References: <1506570874-136126-1-git-send-email-zhengqiang10@huawei.com>
 <CAJZ5v0izo1xeCMqDx2wmn+aC=CntWEV6f9kDupXx=Rgx9uZVPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7506 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdI2GLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2017 02:11:07 -0400
In-Reply-To: <CAJZ5v0izo1xeCMqDx2wmn+aC=CntWEV6f9kDupXx=Rgx9uZVPw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Linuxarm <linuxarm@huawei.com>

Hi,Rafael, thanks for you reply.
please see my comment.

On 2017/9/29 7:13, Rafael J. Wysocki wrote:
> On Thu, Sep 28, 2017 at 5:54 AM, Qiang <zhengqiang10@huawei.com> wrote:
>> PCIe PME and hot plug share same interrupt number. In some special case,
>> Link down event cause hot plug interrupt, devices is not disconnected,
>> But read config will return 0xff.
>>
>> In that case, PME work function will run and not return Because
>> Root Status PME bit always 1 and can not be cleared.
>>
>> This patch add Root Status check in PME interrupt handler,
>> Just do same as pciehp isr Slot status check.
>>
>> Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
>> ---
>>  drivers/pci/pcie/pme.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>> index fafdb16..67144f5 100644
>> --- a/drivers/pci/pcie/pme.c
>> +++ b/drivers/pci/pcie/pme.c
>> @@ -273,7 +273,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>>         spin_lock_irqsave(&data->lock, flags);
>>         pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>>
>> -       if (!(rtsta & PCI_EXP_RTSTA_PME)) {
>> +       if (rtsta == (u32)(~0) || !(rtsta & PCI_EXP_RTSTA_PME)) {
>>                 spin_unlock_irqrestore(&data->lock, flags);
>>                 return IRQ_NONE;
>>         }
> 
> OK, but isn't there a symbol for all ones in u32?  And if there isn't,
> what about adding it?
> 
Here is Root Status register definitions.

Bit Location    Register Description        					Attributes
15:0            PME Requester ID – 						RO
		This field indicates the PCI Requester ID of the
		last PME Requester. This field is only valid
		when the PME Status bit is Set.

16              PME Status – This bit RW1C					RW1C
		indicates that PME was asserted by the PME Requester
		indicated in the PME Requester ID field. Subsequent PMEs
		are kept pending until the status register is cleared by
		software by writing a 1b.
		Default value of this bit is 0b.

17              PME Pending – 							RO
		This bit indicates that another PME is pending 		
		when the PME Status bit is Set. When the PME Status bit is
		cleared by software; the PME is delivered by hardware by
		setting the PME Status bit again and updating the PME
		Requester ID field appropriately. The PME Pending bit is
		cleared by hardware if no more PMEs are pending.
31:18		RsvdZ

Bit[31:18] is RsvdZ, read only and must return zero when read.

So, i guess there is no a symbol for all ones in u32.
If read Root Status return 0xff, perhaps RC is disconnected or accessed timeout.

> Thanks,
> Rafael
> 
> .
> 
Thanks
