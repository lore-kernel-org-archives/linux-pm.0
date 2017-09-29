From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Bug fix for PME interrupt handler, add Root Status check
Date: Fri, 29 Sep 2017 15:12:16 +0200
Message-ID: <CAJZ5v0ii5CSzmnNqrgGTyAG-2ckc8cebJDWH6f+BU3__9umDDQ@mail.gmail.com>
References: <1506570874-136126-1-git-send-email-zhengqiang10@huawei.com>
 <CAJZ5v0izo1xeCMqDx2wmn+aC=CntWEV6f9kDupXx=Rgx9uZVPw@mail.gmail.com> <59CDE3E8.7050702@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38753 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdI2NMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2017 09:12:17 -0400
In-Reply-To: <59CDE3E8.7050702@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhengqiang <zhengqiang10@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Linuxarm <linuxarm@huawei.com>

On Fri, Sep 29, 2017 at 8:10 AM, Zhengqiang <zhengqiang10@huawei.com> wrote:
> Hi,Rafael, thanks for you reply.
> please see my comment.
>
> On 2017/9/29 7:13, Rafael J. Wysocki wrote:
>> On Thu, Sep 28, 2017 at 5:54 AM, Qiang <zhengqiang10@huawei.com> wrote:
>>> PCIe PME and hot plug share same interrupt number. In some special case,
>>> Link down event cause hot plug interrupt, devices is not disconnected,
>>> But read config will return 0xff.
>>>
>>> In that case, PME work function will run and not return Because
>>> Root Status PME bit always 1 and can not be cleared.
>>>
>>> This patch add Root Status check in PME interrupt handler,
>>> Just do same as pciehp isr Slot status check.
>>>
>>> Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
>>> ---
>>>  drivers/pci/pcie/pme.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>>> index fafdb16..67144f5 100644
>>> --- a/drivers/pci/pcie/pme.c
>>> +++ b/drivers/pci/pcie/pme.c
>>> @@ -273,7 +273,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>>>         spin_lock_irqsave(&data->lock, flags);
>>>         pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>>>
>>> -       if (!(rtsta & PCI_EXP_RTSTA_PME)) {
>>> +       if (rtsta == (u32)(~0) || !(rtsta & PCI_EXP_RTSTA_PME)) {
>>>                 spin_unlock_irqrestore(&data->lock, flags);
>>>                 return IRQ_NONE;
>>>         }
>>
>> OK, but isn't there a symbol for all ones in u32?  And if there isn't,
>> what about adding it?
>>
> Here is Root Status register definitions.

Well, that's not what I meant.

You have "rtsta == (u32)(~0)" in the patch above, but you could do
"rtsta == U32_MAX" instead.

Thanks,
Rafael
